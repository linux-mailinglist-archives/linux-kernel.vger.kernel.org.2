Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23135EF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350026AbhDNIQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:16:45 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54778 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350019AbhDNIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:16:43 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D6C06F2;
        Wed, 14 Apr 2021 10:16:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618388180;
        bh=p7bKNnORnvXq4gKs9g820nMSsU73O8OexxbaO+c4jHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6iXPhBQn7IxK3Fi8sR64LIAnS2hqZJ1oL11Z8JHO2gZTBKXx4246tQHYMLZHEbMp
         UCloyzrfntmWffCg1fQaKUVeYgdJshEODVYFlXBWJdyj04q96MRpyNAIjnki5kvIvc
         7h+/M2vpOjFmW8jfuiqMZxBw7a1nIxOJmFU1oYC4=
Date:   Wed, 14 Apr 2021 11:16:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>, paul@crapouillou.net,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phong LE <ple@baylibre.com>
Subject: Re: [PATCH v3 2/3] drm: bridge: add it66121 driver
Message-ID: <YHak0zr0o0thq/fu@pendragon.ideasonboard.com>
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
 <20210412154648.3719153-3-narmstrong@baylibre.com>
 <CAG3jFysFb+y6ymXsBQatuwtPEYRTBnWTku0EpmNyR2gR5a=Y2w@mail.gmail.com>
 <3266977b-9d19-c81d-6fd7-b6fa0714b1ef@baylibre.com>
 <CAG3jFysp+3__TfEyvKSf47q3nYsdRSbkb9LxX2pcJr356yAgKw@mail.gmail.com>
 <911c73a8-47e8-0bae-2bdd-9eb217b25094@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <911c73a8-47e8-0bae-2bdd-9eb217b25094@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Apr 14, 2021 at 10:08:46AM +0200, Neil Armstrong wrote:
> On 14/04/2021 10:06, Robert Foss wrote:
> > On Wed, 14 Apr 2021 at 08:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >> Le 13/04/2021 à 22:21, Robert Foss a écrit :
> >>> Hey Neil & Phong,
> >>>
> >>> Thanks for submitting this series!
> >>>
> >>>> +
> >>>> +static const struct drm_bridge_funcs it66121_bridge_funcs = {
> >>>> +       .attach = it66121_bridge_attach,
> >>>> +       .enable = it66121_bridge_enable,
> >>>> +       .disable = it66121_bridge_disable,
> >>>> +       .mode_set = it66121_bridge_mode_set,
> >>>> +       .mode_valid = it66121_bridge_mode_valid,
> >>>> +       .detect = it66121_bridge_detect,
> >>>> +       .get_edid = it66121_bridge_get_edid,
> >>>> +       .atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
> >>>> +       .atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
> >>>> +};
> >>>
> >>> I would like to see an implementation of HPD, since it is supported by
> >>> the hardware[1] (and required by the documentation). IRQ status bit 0
> >>> seems to be the responsible for notifying us about hot plug detection
> >>> events.
> >>
> >> It's implemented in the IRQ handler with the IT66121_INT_STATUS1_HPD_STATUS event.
> > 
> > I didn't even get that far :)
> > 
> > Either way, the HPD support should be exposed in drm_bridge_funcs
> > (.hpd_enable, .hpd_disable (and possibly .hpd_notify)) and
> > drm_bridge.ops (DRM_BRIDGE_OP_HPD).
> 
> Indeed I forgot these calls in the NO_CONNECTOR implementation...

For new bridges, you should no implement connector creation, only the
DRM_BRIDGE_ATTACH_NO_CONNECTOR case should be supported.

-- 
Regards,

Laurent Pinchart
