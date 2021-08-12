Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB0E3EAC3C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 23:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhHLVJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhHLVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:09:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C0C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:09:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso10033274pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwF9gPVb6rSLv8TfNn020arGyAKk62BBC6M1h4xTevU=;
        b=IuuCgqYx4BPxjD5Pm0KgpVEiQmkLhiXA814N3a3j5+lrQsl3YG3LfIiWxoxd14hxZ0
         4RGvWs4JohzN4HqAcSw10p+8j2AigtBErRFlpfywzQL/FDIY/lsOb0NG83DJ301td7tb
         WelLBc/4DuPEX/BXWym6ag2QLgoy/ErPk+MHG/rIxDlThXDp0npeYsciBRX18jxuwDZa
         wZbPHU0r1i1+zY3nLFegD8Q238XrKK8TrfacZDBmtO8GwOdufp9aXEukBKLQ58sH72Ez
         2WJZYxnmYMek26CRaqs0OhCPihu8j1K0ESrFHEbb+kdiRX+MmSIDlZvF3cxErNVlacui
         ioSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwF9gPVb6rSLv8TfNn020arGyAKk62BBC6M1h4xTevU=;
        b=j+1QfBAvuBG5LSFtGifZ3Ct8qO1xm1xZU6ewLGYhcYGkAlx2gzPHzh2CLaQ3G/9fRw
         4HUWnLhAhB3FNI2wDNm/ClMZx7pl0g5UulLKNuaXegfSr0d5BLs2ksYrfWtgBlLOtP9n
         oYOoFiN39yVijSJvLLMdvpr1TWyb9cikXlEpqLYfsRRFLPEYMD5S8E7ny0Hf1EHcfXJd
         FaNgpUnp66fmoeljYxL2rUrZRbrCQ1EUXRRO2YJKGSsZar/kdQo5xQlxr74SP/JXcJrZ
         vpL/AARtxiJl4q70kxJn73UJpUKkPk0qJ7cgJJ9NtVR52mNcASBLRRQLcXYvazm6W8KW
         uXyw==
X-Gm-Message-State: AOAM532V+HSsYEUoKthVtK3KVsHZ4uwjAsM4mYhALKr1lCXpITJ2I+st
        JR4O8NzZvpSXcx60PCJWoG+asWFj8OPsYnroz/oyQQ==
X-Google-Smtp-Source: ABdhPJxeGt+jyLedAnAFq7sXc5iu6NqpVBagtGh/H6ypybLGjl+PjfMszRQ60ZHPi49s39/oavnefbAWKC77Y7JrxoY=
X-Received: by 2002:a17:90a:1b2e:: with SMTP id q43mr6086414pjq.217.1628802566538;
 Thu, 12 Aug 2021 14:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210812204027.338872-1-nathan@kernel.org> <20210812204027.338872-3-nathan@kernel.org>
In-Reply-To: <20210812204027.338872-3-nathan@kernel.org>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 12 Aug 2021 22:09:15 +0100
Message-ID: <CAA=Fs0k=MeBAHeCK4kFd9p5S5mqER931DGs-mp6Di92rCmAJGg@mail.gmail.com>
Subject: Re: [PATCH 2/3] staging: r8188eu: Remove uninitialized use of
 ether_type in portctrl()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 at 21:40, Nathan Chancellor <nathan@kernel.org> wrote:
>
> After commit 987219ad34a6 ("staging: r8188eu: remove lines from Makefile
> that silence build warnings"), clang warns:
>
> drivers/staging/r8188eu/core/rtw_recv.c:499:8: warning: variable
> 'ether_type' is uninitialized when used here [-Wuninitialized]
>                         if (ether_type == eapol_type)
>                             ^~~~~~~~~~
> drivers/staging/r8188eu/core/rtw_recv.c:458:16: note: initialize the
> variable 'ether_type' to silence this warning
>         u16     ether_type;
>                           ^
>                            = 0
> 1 warning generated.
>
> This if statement sets the exact same assignment as above so just remove
> it.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 9b3637e49052..8df38db9572c 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -495,10 +495,6 @@ static struct recv_frame *portctrl(struct adapter *adapter, struct recv_frame *p
>                         /* allowed */
>                         /* check decryption status, and decrypt the frame if needed */
>                         prtnframe = precv_frame;
> -                       /* check is the EAPOL frame or not (Rekey) */
> -                       if (ether_type == eapol_type)
> -                               /* check Rekey */
> -                               prtnframe = precv_frame;
>                 }
>         } else {
>                 prtnframe = precv_frame;
> --
> 2.33.0.rc2
>

Thanks again.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
