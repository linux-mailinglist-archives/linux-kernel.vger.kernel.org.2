Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE611423AA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhJFJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbhJFJiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:38:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC620C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 02:36:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k26so1863580pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivmiliHmVECNs+tD9udvPPT9X7ypsbwVELS3/VdaCXA=;
        b=LfUpHYEvt7VV6Mdx7h4bj9pOel5YkPzUldKd/bm8n18wrDpNkEvVC9MFoYYMznrQX9
         q70igHA+HOTbMl46LZYxeKqyYPK/ylQiw6Z9/kA/ll78Oip4iU7MKTwckaodArsV4ucm
         u/sWpOpJ5HdZb19oYyH3ZBuV8wwoINrgwkBXGD8ih1+X+N7Bdp/RkMw9UEq8pQhikMV7
         1leJV2Rv2B/1tRv5kklho3zxOW+rcftV8ToWMJmZcyZLSphNgL6YiX6vR/+vLVWQL8ls
         r0Nv3ETJQgcmSaq9LzYfgUMhD/UR1KWzshjGRioZfEq2/dnGgSyxaQo6PhAGcqvNBOJt
         jGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivmiliHmVECNs+tD9udvPPT9X7ypsbwVELS3/VdaCXA=;
        b=5qjHE6spr8LmE7Ytl22XPJdVU2fI+RCJ1VEsge3Srq/5CFeNo5zPjgXlCCPJHpPQ/R
         x8irysGHa3Gl5lMIt5Yy7/qLjWpBoojp0NFRcD2FeRIBCt4dBfDTxbAZUKGAhcKUK8AY
         eyhmPPNUlcOzRpAyvtzZ4fCqzboVrSRlYVOySq6LJDeR/vyCzjrRTJvFw6LId1lw0Xuu
         nHAhXm14DRKdpeKsIzdMBSGUff3qAJjYeVh8k8ppsFfGagAoBqQuvD51EM+4b31TmIjw
         DCvJd8j61Tinbo1AwSyU3AXqkYor+WTxMKfScT05LYG8fDpKRdboa7NeqpBPSpO05s/z
         lYAg==
X-Gm-Message-State: AOAM531xglw1B1RzkOdZpIFjZsYUXrn9/lnvVvP2Z7O2Mr5YuAuqewN0
        uwUlkyTEUclcMytThEhWje5sp9lH+rEwb7YrPXSm0w==
X-Google-Smtp-Source: ABdhPJyJHFp7PxiNzFM0uNAU6r9bpQS9fJ2YelL4yw+Op2yk3u/S0zWg7QK4dZ1PlLtBS6v0H7mi0oh0Axno0UHAcFw=
X-Received: by 2002:a65:4345:: with SMTP id k5mr19758632pgq.410.1633512993175;
 Wed, 06 Oct 2021 02:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210922125909.215-1-caihuoqing@baidu.com> <YUu6AukldZ482TDf@pendragon.ideasonboard.com>
In-Reply-To: <YUu6AukldZ482TDf@pendragon.ideasonboard.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 6 Oct 2021 11:36:21 +0200
Message-ID: <CAG3jFyvy6G15-aA=OPEfHzycpXMjEXAfYs_n4yFmUUAjwe5LRw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi-cec: Make use of the helper function devm_add_action_or_reset()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next

On Thu, 23 Sept 2021 at 01:19, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Cai,
>
> Thank you for the patch.
>
> On Wed, Sep 22, 2021 at 08:59:08PM +0800, Cai Huoqing wrote:
> > The helper function devm_add_action_or_reset() will internally
> > call devm_add_action(), and if devm_add_action() fails then it will
> > execute the action mentioned and return the error code. So
> > use devm_add_action_or_reset() instead of devm_add_action()
> > to simplify the error handling, reduce the code.
> >
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> > index 70ab4fbdc23e..c8f44bcb298a 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> > @@ -265,11 +265,9 @@ static int dw_hdmi_cec_probe(struct platform_device *pdev)
> >       /* override the module pointer */
> >       cec->adap->owner = THIS_MODULE;
> >
> > -     ret = devm_add_action(&pdev->dev, dw_hdmi_cec_del, cec);
> > -     if (ret) {
> > -             cec_delete_adapter(cec->adap);
> > +     ret = devm_add_action_or_reset(&pdev->dev, dw_hdmi_cec_del, cec);
> > +     if (ret)
> >               return ret;
> > -     }
> >
> >       ret = devm_request_threaded_irq(&pdev->dev, cec->irq,
> >                                       dw_hdmi_cec_hardirq,
>
> --
> Regards,
>
> Laurent Pinchart
