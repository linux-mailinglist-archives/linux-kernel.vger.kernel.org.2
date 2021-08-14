Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDC23EC410
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbhHNRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbhHNRR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:17:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6346C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:16:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l11so15956342plk.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSDkNCURFEIerS4iE9wKcdTIcG2uwI6A6CD3SDPBRN8=;
        b=FcEHlEZz3GfI58B1aUkkpBH3m8rYUGuBC14Rhh9bN+ZH3MCMDjI9vD1lvee2lSvpk7
         wxSyeMY0ngtGGen96qYWmUG8Xwx98HCFwJPUG5daFR0pVLDxS2zFpczr6zWa9dPOU5cU
         xYftjJMQOSk0B+2oxL01LPdKo3XgvwiU585kCS4K2qXPJa60oLiXOYUQ/MazxSR9y3Ou
         7ziIHssx6c0jX8OVbzLXITQpz9UvVcGnph7TdoS1N2s32Ucz/dk2uyMRiKzOTgf7Nix/
         5GS8PVBdsnZIcx07jJHGbc2kraDwY3U0NGw3g1fZKU3jClOkY6WWjELYXenbIMwJjmHW
         SebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSDkNCURFEIerS4iE9wKcdTIcG2uwI6A6CD3SDPBRN8=;
        b=duBOQan50tkOEH2US3Ey6yKtVkc4R/HtXlwt6R1MnGoIMuxVMHfdylQlgdpD+dKEkB
         LDgN5KWD3G9plZ5zTdcQOS/ufqZFxl+XD9TSy1utDgZ2wvFitaRPk48N5ls0TV9OKNVj
         +l9CLIUX9HGZkgkgWAHiDLi4gyXOWIRoUpsMRll/E0G9TgM5y7WXxcK1N3qJEiYXoViV
         EGvvRJcaG6pa2MZlLz2urPdI5Qo+5H4+kwea5Onb5MYK9qv5xs/vApxFo3VuM4GtXSun
         GUvwp/sml732OFzqrRkq33lX+Lo9/Ql+KWWVbuNST852hnGZ/bKmWjeBbgFKPxOP/rPJ
         YH8w==
X-Gm-Message-State: AOAM533Ad6oIsf7/8x8qHj0FKaLfVcdWRQLPQg9e/v6DLxCUEjWZm99T
        4gW4y83PcMm8kYhCrxyAGq/UgShAaLL8Nn2+++Ml3A==
X-Google-Smtp-Source: ABdhPJzmR7voE8ENxlTFiH68Wa1IFqhTypLcQw/V3cnzGoCIdsQOqQrHG3YRu3i45Eet6yBmt14LCKHYGwBSRu+Dp0g=
X-Received: by 2002:a17:90a:1b2e:: with SMTP id q43mr8090780pjq.217.1628961418202;
 Sat, 14 Aug 2021 10:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210813201418.4018631-1-nathan@kernel.org>
In-Reply-To: <20210813201418.4018631-1-nathan@kernel.org>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 14 Aug 2021 18:16:47 +0100
Message-ID: <CAA=Fs0nbbzOKhYs_AgpiAfDCLvuUGKz0cSSHwxct6k4eFzEUZg@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: Remove unnecessary ret variable in rtw_drv_init()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 at 21:14, Nathan Chancellor <nathan@kernel.org> wrote:
>
> ret is unnecessary as both error paths set the same error code so just
> return that directly.
>
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 667f41125a87..3e5f4b5eb0fc 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -705,22 +705,18 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
>  {
>         struct adapter *if1 = NULL;
>         struct dvobj_priv *dvobj;
> -       int ret;
>
>         /* step 0. */
>         process_spec_devid(pdid);
>
>         /* Initialize dvobj_priv */
>         dvobj = usb_dvobj_init(pusb_intf);
> -       if (!dvobj) {
> -               ret = -ENODEV;
> +       if (!dvobj)
>                 goto err;
> -       }
>
>         if1 = rtw_usb_if1_init(dvobj, pusb_intf);
>         if (!if1) {
>                 DBG_88E("rtw_init_primarystruct adapter Failed!\n");
> -               ret = -ENODEV;
>                 goto free_dvobj;
>         }
>
> @@ -734,7 +730,7 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
>  free_dvobj:
>         usb_dvobj_deinit(pusb_intf);
>  err:
> -       return ret;
> +       return -ENODEV;
>  }
>
>  /*
>
> base-commit: 0bd35146642bdc56f1b87d75f047b1c92bd2bd39
> --
> 2.33.0.rc2
>

Dear Nathan,

Thanks for this.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
