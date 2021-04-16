Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B342361D89
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbhDPJ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhDPJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:58:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973C3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:58:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A3935A5;
        Fri, 16 Apr 2021 11:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618567082;
        bh=xSo6PytDu5Cq4mnyjhpzVYDwWNwyPGmVgHOT/48h4nU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZOdxX5ofISyaTc31LDkhK/plA7k0+HS91ESbp1PMm16M18wsilwkkSaOsQ2Cug4w
         G+DmizAgRLLcii1bDbmZ9zJe7k4kt5/6nT340AKnyGUJfLTSluhMP+PjX7UM9aUsVf
         2TjmDMBTbT9JF4vbcSaaMTNZn0LW25TvON5CZO34=
Date:   Fri, 16 Apr 2021 12:58:00 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net, robert.foss@linaro.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/bridge: dw-hdmi: disable loading of DW-HDMI CEC
 sub-driver
Message-ID: <YHlfqJIlUh7eytty@pendragon.ideasonboard.com>
References: <20210416092737.1971876-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416092737.1971876-1-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Apr 16, 2021 at 11:27:35AM +0200, Neil Armstrong wrote:
> This adds DW-HDMI driver a glue option to disable loading of the CEC sub-driver.
> 
> On some SoCs, the CEC functionality is enabled in the IP config bits, but the
> CEC bus is non-functional like on Amlogic SoCs, where the CEC config bit is set
> but the DW-HDMI CEC signal is not connected to a physical pin, leading to some
> confusion when the DW-HDMI CEC controller can't communicate on the bus.

If we can't trust the CEC config bit, would it be better to not use it
at all, and instead let each platform glue logic tell whether to enable
CEC or not ?

> Jernej Skrabec (1):
>   drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC
>     driver
> 
> Neil Armstrong (1):
>   drm/meson: dw-hdmi: disable DW-HDMI CEC sub-driver
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
>  drivers/gpu/drm/meson/meson_dw_hdmi.c     | 1 +
>  include/drm/bridge/dw_hdmi.h              | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 

-- 
Regards,

Laurent Pinchart
