Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25030B01E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhBATK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhBATKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:10:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F35C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:10:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hs11so26126289ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kq3V0zk7/NxAJfrOZfZ2Vz2Yq/qtwdkfS7jsVoNMjUY=;
        b=kzPzL5Hv2XEwxEoE2DGFHOqbXj08SBsj5rwtKZEuYuGtWhprWrNxdhroyVOAuCtve4
         PrTSzFwXzkYMF3AULP03fAoDJHS+WKjMjJnpq1IONBbcypF1q1U0ojLIOGpkUcfGvY2V
         VUVWJOXexBQOKypBZkS6yN0tRG+X+stJr2cOW26osOK/ImpnekCzKsJ6QAiSPEyVUTnq
         hgRvIl6lzDTGH1ngF5OKwD50G+kfMITLvC5tuVPkjIwkOQbcD+TVB9iB3gSY4Fc62YPy
         bmmvGNxtKlUQSMAHDA3yNFHkStxmMjEKMyoIOck5A7FrVRRzbBH7ptasjhaXCA7bhUZN
         YLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kq3V0zk7/NxAJfrOZfZ2Vz2Yq/qtwdkfS7jsVoNMjUY=;
        b=Hfk50nKLWm7NKHCmtGmIWDLEfjF3CZ2MQaajsZuRwTMbMq23hxDcLQ/YJvETd3xdA4
         syzJB8NcmREoNYp3KVa9W2Ds4dsmhym3q0Hl8NECLQ63gz04Sl4dTDZVo9mD3hnCMw+O
         e3wyyv98HR8qokL44vXNeZm1n0NkRj0i4yGknUI8KM7G4ZW6ZQwE8Cc91QovrqNU7DiC
         gGxhWpZ1zxT7lAv216zZNKNRPWdN6fwfrdEMbuSjA1TVI2vkuvJHuRPDpvEm0ofg7IK5
         mAOt2Mqvnjn+sYDeAnNyRZpbOkuTVJs7sTPhJhgaqftpQxFTaescROKsiX1L5ZxcDoxh
         O2mw==
X-Gm-Message-State: AOAM533MbSMAlHD/lr2gGNOMcCiJrQuJ6v6D71mmCkOEACyI/pgZBAoz
        dHNJGu8mrQZP32fXLTzLuo4=
X-Google-Smtp-Source: ABdhPJyQOsm7R+5kJJsGidkuXPRG0pnv4N8x5w5RIIwYx77so+HoKA9dy2dTcZNs8XqBDMCCyM9mlg==
X-Received: by 2002:a17:906:1f8b:: with SMTP id t11mr19272726ejr.224.1612206612283;
        Mon, 01 Feb 2021 11:10:12 -0800 (PST)
Received: from localhost (ipv6-4edfac2144800d4b.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:4edf:ac21:4480:d4b])
        by smtp.gmail.com with ESMTPSA id w17sm8416280ejk.124.2021.02.01.11.10.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:10:11 -0800 (PST)
Date:   Mon, 1 Feb 2021 20:10:01 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panel: simple: add SGD GKTW70SDAD1SD
Message-ID: <20210201191001.GA22816@portage>
References: <1611947364-30688-1-git-send-email-oliver.graute@gmail.com>
 <20210201132736.dbqnyzn7dbu7dsmq@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201132736.dbqnyzn7dbu7dsmq@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/21, Marco Felsch wrote:
> Hi Oliver,
> 
> thanks for the patch :)
> 
> On 21-01-29 20:09, Oliver Graute wrote:
> > Add support for the Solomon Goldentek Display Model: GKTW70SDAD1SD
> > to panel-simple.
> > 
> > The panel spec from Variscite can be found at:
> > https://www.variscite.com/wp-content/uploads/2017/12/VLCD-CAP-GLD-RGB.pdf
> > 
> > Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> > Cc: Marco Felsch <m.felsch@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > ---
> > 
> > v2:
> > 
> > - changed bpc to 6
> > - set max value of pixelclock
> > - increased hfront_porch and hback_porch
> > - dropped connector-type
> > 
> > adding of bus_format = MEDIA_BUS_FMT_RGB666_1X18 results in wrong colors.
> > omitting bus_format and using some default is good (Tux Pinguin is colored
> > fine)
> > 
> >  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 2be358f..c129a8c 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -3336,6 +3336,28 @@ static const struct panel_desc satoz_sat050at40h12r2 = {
> >  	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> >  };
> >  
> > +static const struct display_timing sgd_gktw70sdad1sd_timing = {
> > +	.pixelclock = {30000000, 30000000, 40000000},
> > +	.hactive = { 800, 800, 800},
> > +	.hfront_porch = {40, 40, 40},
> > +	.hback_porch = {40, 40, 40},
> > +	.hsync_len = {48, 48, 48},
> > +	.vactive = {480, 480, 480},
> > +	.vfront_porch = {13, 13, 13},
> > +	.vback_porch = {29, 29, 29},
> > +	.vsync_len = {3, 3, 3},
> 
> Please add also:
> 
> 	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> 		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
ok will do

> 
> > +};
> > +
> > +static const struct panel_desc sgd_gktw70sdad1sd = {
> > +	.timings = &sgd_gktw70sdad1sd_timing,
> > +	.num_timings = 1,
> > +	.bpc = 6,
> > +	.size = {
> > +		.width = 153,
> > +		.height = 86,
> > +	},
> 
> and:
> 
> 	.delay = {
> 		.prepare = 20 + 20 + 10 + 10, /* T0 + T2 + T3 + T4 */
> 		.enable = 50, /* T5 */
> 		.disable = 50, /* T5 */
> 		.unprepare =  10 + 10 + 20 + 20, /* T4 + T3 + T2 + T0 */
> 	};

ok will do

thx for your review.

Best regards,

Oliver
