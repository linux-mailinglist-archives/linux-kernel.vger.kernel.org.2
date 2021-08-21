Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF03F3CCD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 01:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhHUX7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHUX7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 19:59:01 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CC1C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 16:58:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id n18so13023961pgm.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ze576013se8gTETJRjtdN0zpKGBJhk+U/2xWctJQRKI=;
        b=bhEJ0rA28D8RxCMKQwAzZlwDOVlv3/Gn9NXMukx4btG5s4GTBms8IynaLMusHs16E3
         dZXPvFwTUUgEZ+/WdmXyIHpi1jJ0EBZInIBIyKqspSlG8+43VKZ0jGrg2Q8ny/ZOFi5E
         RAsu/WoYzres5Pw/XQyzjaOz6IYDyBRR7p28VL7p87/IlsKtIyTr24v3p8k67GQqGMa+
         mISQV18GQ/3yLbJOI0frMQjUMKXBogudyN2KaMWDSkdrtGuhb7ahPNNBxZkdnSspEpgG
         rC+I1JNQBq1198IMVNV8Wgy1pjdJ50MbDFiSsi4/qEHBcLEelb71SfSsV8fsEDYgaooy
         UadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ze576013se8gTETJRjtdN0zpKGBJhk+U/2xWctJQRKI=;
        b=t2chslzH/RXJUZXHTIGI7oywI8wDRjk6Hr6CJQTLIutagBLeV2FWz1kVL3uBB685qo
         jEvSqitQwwW11WTUFq2Umf/6d0Bprdfpt13/Z972rByuYTDj3ctCMKR9oTwa7hp0HQo7
         FOk5oi63egtCRxs/0qBPKegh5KTgYaEpVWIAMH88skwJ62uFCZz8rl3yQ9tB1Og2E8Ao
         AnQwlBirOvRWfb87rFhrZj8HiFk54a2lvpBbjxjy3l5IIm20Q7CTd+60mJZcgOLvCLnk
         5o0t3fkTFQM6V4N9nrqWpBssy8BPLmcpkoNtjKvNCu8bTETV7/6dIVGUdAgKdLUOKEby
         NlQg==
X-Gm-Message-State: AOAM5308Vj3BGEYacuyk5RWRm74QSb6x39oDrLihqVzRKL9QCbWd3NTA
        RFrXoyXpPSNC/7xWaqNnistkwGJ/h0p65Kobs57Whg==
X-Google-Smtp-Source: ABdhPJzWFJqq4vBBZ9oSiF99YbB7JP00V60CNeHb6sB3dmOCLQR5hIoOab/IOKpTDkysdkG1owqZozY04cVvTxkcmwU=
X-Received: by 2002:a62:5c6:0:b029:341:e0b1:a72c with SMTP id
 189-20020a6205c60000b0290341e0b1a72cmr26837102pff.71.1629590300709; Sat, 21
 Aug 2021 16:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <YSFgrLUfXzgcT6k4@user>
In-Reply-To: <YSFgrLUfXzgcT6k4@user>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sun, 22 Aug 2021 00:58:10 +0100
Message-ID: <CAA=Fs0kByg1NztU+Nf__RUzTHuVh_q2hvcyh+3JqXiVgn+_VeQ@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 at 21:23, Saurav Girepunje
<saurav.girepunje@gmail.com> wrote:
>
> Remove the condition with no effect (if == else) in rtw_led.c
> file.
>
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_led.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
> index 22d4df9c92a5..76cbd5f19f90 100644
> --- a/drivers/staging/r8188eu/core/rtw_led.c
> +++ b/drivers/staging/r8188eu/core/rtw_led.c
> @@ -148,10 +148,7 @@ static void SwLedBlink(struct LED_871x *pLed)
>                         _set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
>                         break;
>                 case LED_BLINK_WPS:
> -                       if (pLed->BlinkingLedState == RTW_LED_ON)
> -                               _set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
> -                       else
> -                               _set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
> +                       _set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
>                         break;
>                 default:
>                         _set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
> --
> 2.30.2
>

Thanks for this, looks good.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
