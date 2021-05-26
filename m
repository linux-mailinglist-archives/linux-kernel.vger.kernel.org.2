Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E5391992
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhEZOMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbhEZOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:12:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11D0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:11:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t206so830900wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=+2FNtzevJ4qM2Fi7yCUYyh+8owZT/RfCjcCcFFpDxCo=;
        b=kJnBFRGy2Qk3liIbBYF+s4ylrkulEO33hYBKTvb2+e4YoqH8YWyBoMWfRh3tguebht
         jFQkqz/4c1yOV/44EWaOsk7utHt2h9fQIvKS6Rao6FQSSE8rLt1oDbpYG4Tb7t9nfa/n
         g0xIFC9m4dlqqWM0cJWoEUUu/yw/ZSuXD0m+BWhlLRckqceZLH8IdKX7wIPhsjCsL9qa
         VsXUpH1h14vtH7rS3I6pYnuXRdMbPB8HijoWbMP2xDGY6n3SxaAyIZCs+bqZZ3mZpvXz
         SZu877Ha0DvTirbSdJq6s7qcwicub/ZqgEoxHdbnXAO/rEChYCO971tyBlTWTgGm3V5k
         uFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=+2FNtzevJ4qM2Fi7yCUYyh+8owZT/RfCjcCcFFpDxCo=;
        b=IEYlblxy2PGy0hfJKyXFr8j+1QxsY3QNamJyCLS9B6Y2M2Uh/WXxA8/FYQ+btizd8o
         C11SEQ4NiqM4+qFcBq4/hI+0x7fL9qeL1EBemzSduQ2GRRcHi8RR0BzGWyEVYsTVeIgz
         jl9hyiwWWm4zrNGwNvcs/wCsX3QsJ6glNAb8MQCguXJag0M1KmiLenBmFw8sLqkERstD
         q9csg35qBo51akdz9kZtuasW5z3bXs67bYRn5U+M2IQwO3gYrMyOAzAwj9VHQyppBvWD
         QrbG0racxVlqlU6XW+iWAtY6WhzqYukYpR56dCsV0cKg4O7OAcN8gGmquVWOK9dQ62G+
         /0Fg==
X-Gm-Message-State: AOAM533XmYBqLb5ORnupGNP/eQ0jN9bor54Hj7Hx0TBCStiaH7f2tmXn
        TpmcsrkHRelTvdQNn0mby0o8qn43HINmpQ==
X-Google-Smtp-Source: ABdhPJze0yp8Mpe8hzE4v/dQoiiVLfHunD7AbUa47ZMHimdS0UwcSwiH28GiE4Hv+1aBbcBbc4sdUw==
X-Received: by 2002:a05:600c:3544:: with SMTP id i4mr3733209wmq.112.1622038266468;
        Wed, 26 May 2021 07:11:06 -0700 (PDT)
Received: from localhost (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id k11sm6737212wmj.1.2021.05.26.07.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 07:11:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 26 May 2021 15:11:04 +0100
Message-Id: <CBN8KRXT6GKH.3TIZOGGT3RG0W@arch-thunder>
To:     "Lee Jones" <lee.jones@linaro.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 06/24] usb: isp1760: isp1760-udc: Provide missing
 description for 'udc' param
From:   "Rui Miguel Silva" <rui.silva@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-7-lee.jones@linaro.org>
In-Reply-To: <20210526130037.856068-7-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
On Wed May 26, 2021 at 2:00 PM WEST, Lee Jones wrote:

> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/usb/isp1760/isp1760-udc.c:150: warning: Function parameter or me=
mber 'udc' not described in 'isp1760_udc_select_ep'
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/isp1760/isp1760-udc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/isp1760/isp1760-udc.c b/drivers/usb/isp1760/isp1=
760-udc.c
> index 3e05e36054357..a78da59d6417b 100644
> --- a/drivers/usb/isp1760/isp1760-udc.c
> +++ b/drivers/usb/isp1760/isp1760-udc.c
> @@ -137,6 +137,7 @@ static void __isp1760_udc_select_ep(struct isp1760_ud=
c *udc,
>  /**
>   * isp1760_udc_select_ep - Select an endpoint for register access
>   * @ep: The endpoint
> + * @udc: Reference to the device controller

I had this in my latest patch set, but got lost, thanks for fixing
this.

I'd like to ask you to swap the order to match the order in which
the args appear in the function declaration.

With this changed you can add my:
Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>

------
Cheers,
     Rui


>   *
>   * The ISP1761 endpoint registers are banked. This function selects the =
target
>   * endpoint for banked register access. The selection remains valid unti=
l the
> --=20
> 2.31.1



