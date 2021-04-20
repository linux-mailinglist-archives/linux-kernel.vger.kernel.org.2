Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9266B36624B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 00:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhDTWuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 18:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbhDTWuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:50:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F37C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:49:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5293345E;
        Wed, 21 Apr 2021 00:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618958980;
        bh=tnPqQylg0M/heoMDy9x5XiXEnGZ70xHfOc6q1pK7LwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZeMKknPmyhvE4Lv+KgrktMqxfIhcblSiEh0KPDRygcger3YAT3GSLEBBVqXh7qDG3
         LUCWeoNI6c8vlxZEBDR5b4U2e8itmNqfq+KD8TT6Vjcyoxfawp1ukhGUyh4Uuk+uES
         vWsUrRluJfe99MxGLvGZHiOc3SPvj76DvRnhj3UA=
Date:   Wed, 21 Apr 2021 01:49:36 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, jernej.skrabec@siol.net,
        jonas@kwiboo.se, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, robert.foss@linaro.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] drm/bridge: dw-hdmi: disable loading of DW-HDMI CEC
 sub-driver
Message-ID: <YH9agHwLhEL27TA1@pendragon.ideasonboard.com>
References: <20210416092737.1971876-1-narmstrong@baylibre.com>
 <YHlfqJIlUh7eytty@pendragon.ideasonboard.com>
 <96b9e144-0791-4c19-3e3c-b0e9efb86138@baylibre.com>
 <cbea511c-5d5c-8c59-f91f-fedc8eec1e39@xs4all.nl>
 <0821533b-9e6a-237e-3845-741e82de4ed9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0821533b-9e6a-237e-3845-741e82de4ed9@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 05:19:52PM +0200, Neil Armstrong wrote:
> On 20/04/2021 17:13, Hans Verkuil wrote:
> > On 16/04/2021 13:38, Neil Armstrong wrote:
> >> On 16/04/2021 11:58, Laurent Pinchart wrote:
> >>> Hi Neil,
> >>>
> >>> On Fri, Apr 16, 2021 at 11:27:35AM +0200, Neil Armstrong wrote:
> >>>> This adds DW-HDMI driver a glue option to disable loading of the CEC sub-driver.
> >>>>
> >>>> On some SoCs, the CEC functionality is enabled in the IP config bits, but the
> >>>> CEC bus is non-functional like on Amlogic SoCs, where the CEC config bit is set
> >>>> but the DW-HDMI CEC signal is not connected to a physical pin, leading to some
> >>>> confusion when the DW-HDMI CEC controller can't communicate on the bus.
> >>>
> >>> If we can't trust the CEC config bit, would it be better to not use it
> >>> at all, and instead let each platform glue logic tell whether to enable
> >>> CEC or not ?
> >>
> >> Actually, the CEC config bit is right, the HW exists and should be functional, but
> >> this bit doesn't tell if the CEC signal is connected to something.
> >>
> >> This lies in the IP integration, like other bits under the "amlogic,meson-*-dw-hdmi"
> >> umbrella.
> >>
> >> The first attempt was by Hans using DT, but adding a property in DT for a vendor
> >> specific compatible doesn't make sense. Another idea would be to describe the
> >> CEC signal endpoint like we do for video signal, but I think this is out of scope and
> >> this solution is much simpler and straightforward, and it's more an exception than
> >> a general use case to solve.
> > 
> > While a DT property might not make sense in this particular case, I still
> > believe that it is a perfectly valid approach in general: whether or not
> > the CEC pin is connected is at the hardware level decision, it is not
> > something that software can detect. If the designer of the board didn't
> > connect it, then the only place you can define that is in the device tree.
> 
> Agreed, we need to define a smart way to declare CEC bus relationship in DT, the side
> effect would be to handle this particular case.

I wonder if it would make sense to use the OF graph bindings to describe
the connection between the CEC controller and the CEC "device" (which I
assume in most cases will be a DT node for a physical connector). Or is
this overkill ?

> > Anyway, for meson I am fine with this solution. At least it prevents creating
> > a non-functioning cec device. So for this series:
> > 
> > Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> 
> Thanks,
> 
> Applying this serie to drm-misc-next
> 
> >>>> Jernej Skrabec (1):
> >>>>   drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC
> >>>>     driver
> >>>>
> >>>> Neil Armstrong (1):
> >>>>   drm/meson: dw-hdmi: disable DW-HDMI CEC sub-driver
> >>>>
> >>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
> >>>>  drivers/gpu/drm/meson/meson_dw_hdmi.c     | 1 +
> >>>>  include/drm/bridge/dw_hdmi.h              | 2 ++
> >>>>  3 files changed, 4 insertions(+), 1 deletion(-)

-- 
Regards,

Laurent Pinchart
