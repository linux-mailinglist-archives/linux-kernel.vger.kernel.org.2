Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88675432A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 01:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhJRXvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 19:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRXvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 19:51:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98928C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 16:48:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id g5so12416591plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 16:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjJmB2kSFRa+PVzQW4Tlhv7PdsoaNoVuz5+nTON3mTk=;
        b=fBiLFwAZ1toZ8kccvHjc15v7lGeRm1qPJgQNuxQYag7MstqWTwMPXsna/pKlQgzyKu
         nffLzqx4o81C2miFc+mZlJOEqqdU6njnAQFHJSaLTWJ5PqPZY1i3CnmuzqXuF7uC/Yna
         4J/lGjZrZz+frWC69SsAhfe+nDQZq4rx6tr7IPOcbUV+8zhkObfNaNLgLMOmi9oS1Gt1
         8b+Yi0PWlVpp3qQAvLlvwBnGIV9j6j4hbrjLfyTMZfOPSzUPxrsnoiwHrItP0XaxUaT0
         PvrBE7qhXsM/A2fm+oSQh66bWiigV3aGnq3fWKJLKowelpITkPLw/576Dk+A6B1hH29G
         Nrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjJmB2kSFRa+PVzQW4Tlhv7PdsoaNoVuz5+nTON3mTk=;
        b=BsjLa0polatXs72HqKjPEzyYNzei8HQTHPAlsTTkPDJW9x60QT+9ORLD+/ar5trqzo
         11fjoKsvX2+QohH7zZM7PFucuaUWB3NfLZ9Pa8naP337WKR7tYq6fH2Wni9M7iZceRWp
         S6fi0DfSQitcNNjXdFAMHNMHp+QsVmoGUuTkcR2bROZJ4/z3yyyTiCK8eRo/9lKKnM6f
         Uw45D0tTLV7BQ+M2iJvXfFNUD2mll1EbCvY0pnmrwk9d7xwkA8whFJ7L/fjVGV2+VulZ
         c1QuUXecLfuhsXz0RVceQDqN3XUGvd+JCXKZKQk9Yrab3BTT13cuHINxSdxuebmQikrg
         M2SA==
X-Gm-Message-State: AOAM533TrycF7TenxwajiaHHb8G0b8x6RbDXCALbRIwxFoNj/khNJbv9
        OqLqsijJPR089hZJ+7mmPNJk6K2wl+oJVZ8ns1oZDw==
X-Google-Smtp-Source: ABdhPJxjqB0fQ1WTr+FNiWx+sYYdMjVhmtJgT2gl7LjwG0oRdPiz7rTQ/m09rKA/pAWBRrcOG0K9Pk9NyuyueRZs8sk=
X-Received: by 2002:a17:902:be0c:b0:13e:2b53:d3 with SMTP id
 r12-20020a170902be0c00b0013e2b5300d3mr30317072pls.86.1634600932965; Mon, 18
 Oct 2021 16:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211018221231.7837-1-straube.linux@gmail.com>
In-Reply-To: <20211018221231.7837-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 19 Oct 2021 00:48:42 +0100
Message-ID: <CAA=Fs0nvM4qYx_tOvQ5uKLa24bje=APMV61DHwjvCbgX-bwJHw@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: fix a gcc warning
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 at 23:13, Michael Straube <straube.linux@gmail.com> wrote:
>
> Replace strncpy with strlcpy to fix the following gcc warning.
>
> drivers/staging/r8188eu/os_dep/ioctl_linux.c: In function 'rtw_wx_set_enc_ext':
> drivers/staging/r8188eu/os_dep/ioctl_linux.c:1929:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
>  1929 |         strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The destination buffer size is IEEE_CRYPT_ALG_NAME_LEN and the length
> of the string to copy is always < IEEE_CRYPT_ALG_NAME_LEN. So strlcpy
> will never truncate the string.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 51f46696a593..4f0ae821d193 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -1926,7 +1926,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
>                 return -1;
>         }
>
> -       strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
> +       strlcpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
>
>         if (pext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)
>                 param->u.crypt.set_tx = 1;
> --
> 2.33.0
>

Looks good, thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
