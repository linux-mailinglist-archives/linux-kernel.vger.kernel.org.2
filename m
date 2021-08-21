Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0E3F3BA3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhHURVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhHURVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:21:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F4C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:20:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n12so7766188plf.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eh/YHDzWLhkmryQ9StQxG/PNPAnNUl2yaG+z0zg56s=;
        b=V5CEXRff6307CC8lQ93T3IBpuLz5w3O2KxCqsfhYlEpx8p/EbJnWe1MLk5f8fJ4rbA
         MOPa5hQT2ow8PzVgstjS+U1UprImGZ/WqPz5bWyuBytbGdbKdiJolPY5YCV6bAUJTb8T
         FFlLP2KZzTni2cNmbDNXlOim1QZyYOvABusvtgtjvicYFZVFeugy0PKNdnm6/ppNZHnB
         cldf9XdBeMOsrcq0B7wofAFUv1dp6JQ9AN4ktNVH81LB+cNEnUYUTNZnwYwh3d0ipsqs
         Te7vx28Is9Sj2xyMZpORgW/+ITQ1DrhQB0GPp3VlAhDqn2fV8P1yjpvc3KOPlb/0veDR
         e86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eh/YHDzWLhkmryQ9StQxG/PNPAnNUl2yaG+z0zg56s=;
        b=bCPrcwD55up7eJkLS21bD1XNojQ3vnWGLpFz4rG8HVZZbhJ8T9B0k//OT8FWR3eoda
         OPEtceNgvnM8ZNRx8rNyoICVozblvxSpvAz+KOh1cXYZmdWwH+CjSLB9myGDWQ5dejt/
         ZA19/4KJ4lXxpOt5mT+d4rcka5HxjSrijwq4+zkHMDnp+1J/21kSnrTwwtqEYM6cVeVz
         zmorYdMWMkSxFhFPut9W5RnfG7LE0ztQrlKHaQR9nE+MmLzlBUEonJIlU5RrAv0Kgo5Y
         1S+wD0vOMMDnIT7/8rAUOeXa+EaGSKtYGm56CxcbQKiWGrfTv1yutM3xAt90Yde8RKyN
         GWwA==
X-Gm-Message-State: AOAM533l/IIG25ErEY6RHKdQ5XScn/kbjlLsG0KuUjT2T7hPLYx1+IXY
        ZOJS5Z2CPS1OPbvasvr0y9hFs0iN//ntY7ww90CN0Q==
X-Google-Smtp-Source: ABdhPJzhQq3XaPbroqdsZU21990BR9Ig+QpTPtXz8WNELOIgdI3dxRGfzB8H3g4yoCHwNskk1LQNbr8A3cZwVH3anyY=
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id
 h4-20020a170902f704b029011acdee0490mr21478121plo.37.1629566452451; Sat, 21
 Aug 2021 10:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210821155151.25822-1-straube.linux@gmail.com>
In-Reply-To: <20210821155151.25822-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:20:41 +0100
Message-ID: <CAA=Fs0kzfra7UwkSU86-8vpdk=FLRSAG_w=YmZcyLUhmf3wv2g@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove cmd_osdep.h header file
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 at 16:52, Michael Straube <straube.linux@gmail.com> wrote:
>
> All functions declared in the cmd_osdep.h header file are only used in
> a single c source file. Make the functions static and remove the header
> file and its includes.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c      | 11 +++++------
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c  |  1 -
>  drivers/staging/r8188eu/include/cmd_osdep.h | 16 ----------------
>  3 files changed, 5 insertions(+), 23 deletions(-)
>  delete mode 100644 drivers/staging/r8188eu/include/cmd_osdep.h
>
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 955499eb608a..ce73ac7cf973 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -6,7 +6,6 @@
>  #include "../include/osdep_service.h"
>  #include "../include/drv_types.h"
>  #include "../include/recv_osdep.h"
> -#include "../include/cmd_osdep.h"
>  #include "../include/mlme_osdep.h"
>  #include "../include/rtw_br_ext.h"
>  #include "../include/rtw_mlme_ext.h"
> @@ -16,7 +15,7 @@ Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
>  No irqsave is necessary.
>  */
>
> -int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
> +static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
>  {
>         int res = _SUCCESS;
>
> @@ -59,7 +58,7 @@ int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
>
>  static void c2h_wk_callback(struct work_struct *work);
>
> -int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
> +static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
>  {
>         int res = _SUCCESS;
>
> @@ -87,7 +86,7 @@ void rtw_free_evt_priv(struct evt_priv *pevtpriv)
>         }
>  }
>
> -void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
> +static void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
>  {
>         if (pcmdpriv) {
>                 kfree(pcmdpriv->cmd_allocated_buf);
> @@ -105,7 +104,7 @@ ISR/Call-Back functions can't call this sub-function.
>
>  */
>
> -int    _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
> +static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
>  {
>         unsigned long flags;
>
> @@ -123,7 +122,7 @@ int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
>         return _SUCCESS;
>  }
>
> -struct cmd_obj *_rtw_dequeue_cmd(struct __queue *queue)
> +static struct cmd_obj *_rtw_dequeue_cmd(struct __queue *queue)
>  {
>         struct cmd_obj *obj;
>         unsigned long flags;
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> index 3e1a45030bc8..7d50d64cf34d 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> @@ -6,7 +6,6 @@
>  #include "../include/osdep_service.h"
>  #include "../include/drv_types.h"
>  #include "../include/recv_osdep.h"
> -#include "../include/cmd_osdep.h"
>  #include "../include/mlme_osdep.h"
>  #include "../include/rtw_ioctl_set.h"
>
> diff --git a/drivers/staging/r8188eu/include/cmd_osdep.h b/drivers/staging/r8188eu/include/cmd_osdep.h
> deleted file mode 100644
> index 3954d6350cc6..000000000000
> --- a/drivers/staging/r8188eu/include/cmd_osdep.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> -/* Copyright(c) 2007 - 2011 Realtek Corporation. */
> -
> -#ifndef __CMD_OSDEP_H_
> -#define __CMD_OSDEP_H_
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -extern int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv);
> -extern int _rtw_init_evt_priv(struct evt_priv *pevtpriv);
> -extern void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv);
> -extern int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj);
> -extern struct cmd_obj  *_rtw_dequeue_cmd(struct __queue *queue);
> -
> -#endif
> --
> 2.32.0
>

Looks good to me, thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
