Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ACC3F3BD3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhHURp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhHURp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:45:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A619C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:45:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q2so12431523pgt.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kF6aHsrAj7KUVldSv2hRrmUYmHo9pqAIsV/DNdAO92I=;
        b=w5MLn0PH0pocM4tRhMdT6Jp21GHTHt3O05eDb6/VtoU3KlJ5rDDMkk1HfFu8ap0QJx
         QFZAWKuMnI0lksoN19rfZN/TaeazW6B0aCFmDdA3Apj30+0wvb2De4cdhTzgVLrGvPHh
         1aY0Dl41hPouBDKxHDy0846SrM2qWmBNPxULtSJMlNUtyrkCrqB2GhGSuhb5Tm6v8mZ8
         OxtjRIwHOxOfazg8I/o1pVJrRbLcjqwql5Fl8m70IeiEOKSHx5u1NFK1mSn8khQJfl2J
         H/RwlOvpIoDJ2I0AlntVsicY6JKUFhSx0Btn+w2z8inh9SXVj4iioXiht9YTN2neNxq9
         CA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kF6aHsrAj7KUVldSv2hRrmUYmHo9pqAIsV/DNdAO92I=;
        b=fuvxVcWrIEvR+5FtjYAsKYr+oUgTtnElWISua4MR0DPzl4Uap9o7T/T+eQEcyZAIgM
         /FeDAlQCPwjGty2vYwgbcm81rwAn3VmxqJVIftqVkKfld233kWz+O+DUpTt4CrGlOKg2
         E/Nlq+t6YznMuKjrMq5ro89t4IY2FyFCT9xAOuuQIuJcD8dQYyhrZGHru1CDWpQ+0TU/
         vdlo1Gh169fvToONoh3ngxZKk8btB/lBllcqwuiYOeTnAiScx+Ee8nFBzq+yRbftxksS
         SJdyY/h1OgEj8CieLqhO7b/PtHkFa2rE0dTgtRX66k9Dx7hwoFgInJ6Er0HJOFOKP/N4
         TbXA==
X-Gm-Message-State: AOAM533V98KM+68p5KoTmkLcVRjUsaHCXE6Hgw5pRtXZhL1FVMNqIeyc
        iLIEY1wUMO3D1Tq0uo6wTVzKxkYhJEIsvbSfpS2vaQ==
X-Google-Smtp-Source: ABdhPJzgeb4c2OgI2VGn1CCT3EcAui9DerXhEPu7Rr1rFXmPt9mUs1zz0sMMQ8EVCkXkgh7BtSZl1hZBqTtuvY8m4Ak=
X-Received: by 2002:a63:aa43:: with SMTP id x3mr24547403pgo.208.1629567916187;
 Sat, 21 Aug 2021 10:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210821164859.4351-1-martin@kaiser.cx> <20210821164859.4351-4-martin@kaiser.cx>
In-Reply-To: <20210821164859.4351-4-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:45:05 +0100
Message-ID: <CAA=Fs0mETti1k5=m0yzE+zwN6etRyGeRGAGBKtWy-9d3oDix1Q@mail.gmail.com>
Subject: Re: [PATCH 04/10] staging: r8188eu: rewrite usb vendor request defines
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

On Sat, 21 Aug 2021 at 17:49, Martin Kaiser <martin@kaiser.cx> wrote:
>
> Replace the numeric values with USB constants to make their
> meaning clearer.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/include/usb_ops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
> index 5d290199e37c..b6a1cd536adf 100644
> --- a/drivers/staging/r8188eu/include/usb_ops.h
> +++ b/drivers/staging/r8188eu/include/usb_ops.h
> @@ -8,8 +8,8 @@
>  #include "drv_types.h"
>  #include "osdep_intf.h"
>
> -#define REALTEK_USB_VENQT_READ         0xC0
> -#define REALTEK_USB_VENQT_WRITE                0x40
> +#define REALTEK_USB_VENQT_READ         (USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
> +#define REALTEK_USB_VENQT_WRITE                (USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
>  #define REALTEK_USB_VENQT_CMD_REQ      0x05
>  #define REALTEK_USB_VENQT_CMD_IDX      0x00
>
> --
> 2.20.1
>

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
