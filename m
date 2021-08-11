Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8173E9B51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhHKXvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhHKXvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:51:17 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17F7C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:50:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so12284488pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEga9V3w054sVWObR8faNCjdILL695VoP9rSy8xFIWo=;
        b=1VDZXLD2+/AyA1j2CUlow20YJ/V4hGd64IsPjmRUEe0vG+LNr+GEpRpuQj3RsqhheJ
         3rKRN1OQykWmQu/jUlMOjJvtsVKRPZApVX8mVPonnIZk78X1eb4NDS6sNf29XIy68/Iq
         R7WHtWRaVh0NnYuIq/XH6ZrW3fmUbzKecRAZqlgCzZFhZRpmFPWfri36H/Q5cYym7RAP
         UPhMCZvnrw1aKGl845110bGqsECF4Joc6+aPvZh0/RcEqKWRWTuX+cqv3qdhl011Ar8O
         BK1byFRlwg0dTB9vaYFGSR0Ze3aOiG83NiVOkalwLg3d/hfQBoFCmYl/LQaA1qvk6Ghf
         Jhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEga9V3w054sVWObR8faNCjdILL695VoP9rSy8xFIWo=;
        b=P+3hjRF49uXOzbRBkG6UlQUld3UwlNH0lhA5fC9RYp4eEkKjkhZnkYB0PrjhkxY+GK
         Cz3iyfszYdy9X5QC90VUA35stNID/g4KwZBo/Qe4ZvrkQBUyve/aW2ZQ9OCqbW0yRVAD
         1g3Lk9+OciLPzhugbvXWOzhXnoBiI66AM6h48N6TNXqJ7FOHV83ceqKRI4u3wNCqBFvH
         ONjpLQZ1CUztzEnqmJ3t9CRp3exXtqBjP5cTqx5uvLpGTPTKtxswccp1bst4mWs+ezBW
         L6+M1mOn+E9blDUuw1R9r3fGrtwcftPvVDI1dZ/dvHcPed4vXyI70TjQkuyrtRDUe73p
         Bz3Q==
X-Gm-Message-State: AOAM531Tt5gERZdSsmLEe86ZCaKsU5qcab8Vmq9w+/KMeRIZUhY8Ypt3
        Lum0DhTE4pJWBycy7YyRAxgUD/Emc4/p8k6dLp74qA==
X-Google-Smtp-Source: ABdhPJyspPyR7V1yxh9d7KLVIgcebLMBHtTy18nFu1WajssrMJz+HL1/hzmEVKFVwf//FLZbzWm3YZSPzQUf6kkZwx0=
X-Received: by 2002:a17:902:8c81:b029:12c:ee37:3f58 with SMTP id
 t1-20020a1709028c81b029012cee373f58mr1065401plo.45.1628725852571; Wed, 11 Aug
 2021 16:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210811201450.31366-1-martin@kaiser.cx> <20210811201450.31366-2-martin@kaiser.cx>
In-Reply-To: <20210811201450.31366-2-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 12 Aug 2021 00:50:41 +0100
Message-ID: <CAA=Fs0kYeHsuAUPXZGpkuo4w5WKwjFDR8vURxSDGHZ-nFtZfyA@mail.gmail.com>
Subject: Re: [PATCH 2/5] staging: r8188eu: remove unused function parameters
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:15, Martin Kaiser <martin@kaiser.cx> wrote:
>
> rtw_usb_if1_init and chip_by_usb_id do not need a
> struct usb_device_id parameter.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 8f1e33d2fff7..4bf89b78a74a 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -250,8 +250,7 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
>
>  }
>
> -static void chip_by_usb_id(struct adapter *padapter,
> -                          const struct usb_device_id *pdid)
> +static void chip_by_usb_id(struct adapter *padapter)
>  {
>         padapter->chip_type = NULL_CHIP_TYPE;
>         hal_set_hw_type(padapter);
> @@ -569,7 +568,7 @@ int rtw_resume_process(struct adapter *padapter)
>   */
>
>  static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
> -       struct usb_interface *pusb_intf, const struct usb_device_id *pdid)
> +       struct usb_interface *pusb_intf)
>  {
>         struct adapter *padapter = NULL;
>         struct net_device *pnetdev = NULL;
> @@ -587,7 +586,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>
>         /* step 1-1., decide the chip_type via vid/pid */
>         padapter->interface_type = RTW_USB;
> -       chip_by_usb_id(padapter, pdid);
> +       chip_by_usb_id(padapter);
>
>         if (rtw_handle_dualmac(padapter, 1) != _SUCCESS)
>                 goto free_adapter;
> @@ -722,7 +721,7 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
>         if (!dvobj)
>                 goto exit;
>
> -       if1 = rtw_usb_if1_init(dvobj, pusb_intf, pdid);
> +       if1 = rtw_usb_if1_init(dvobj, pusb_intf);
>         if (!if1) {
>                 DBG_88E("rtw_init_primarystruct adapter Failed!\n");
>                 goto free_dvobj;
> --
> 2.20.1
>

Dear Martin,

Looks good.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
