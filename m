Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86005452A10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbhKPFyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbhKPFyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:54:04 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B9C03AA3A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 20:56:12 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m27so25352370lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 20:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P95ELlRgMRZkG9bYMP1tznGDyj5awpaPH3jueNkr9vs=;
        b=fc60BO/LhMAvTzt1F7fb84/UivvOkjq1d3XJQoYvajCOGz8LFjBXGN/8tdKJKhpOSD
         tJclVXPw0M22drkWldIvCeGHEG5TjGuyi9JyjFSTjZT/qNs7k+Mgln4iLRaRr+/4w/4p
         IcwPKeH9Zwq3WUROVHUv5AZHOQ7bggOI8Pi6dZ4JG5ns2FPuByqKahev4NLghX9/+VmR
         D46+QjhiJ9Y709O4KaRL/V+16BBqJFOAguORbSvY0lB40CKdldHxBfPZSDIcho3Vw/Rz
         4W1A6r5g14KYf2dFJU5jh6pENFoW8ebek2rOMbWMvKZaPPSycRSbxVzB3NNya65zkUdq
         oM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P95ELlRgMRZkG9bYMP1tznGDyj5awpaPH3jueNkr9vs=;
        b=p6KBDxudIgcr1zA0qAzqdEM3nnB6z4Gk/tUXyB4m8h3pumT+ivSYr30fxW0yn5bCZZ
         xOw/XWyrRCwoy1ql4TLS1StWYImrFE5v3vgYBdup3YWxDj2r3Nfn1+PHjIkEuL3X0vwp
         Z4e6NUHg7MotYULmoSmy/+qu80cDi3jKKTCQ71pe2+Hfh4wlc0MSNHOocL+qsPflpefv
         z4Z4FIPob2AUUkz3KqU4vpe4ObY44QEaP/z50UxEHu70xOf3FLAjlUcokO/Bj8n3r1KR
         CwdpkDiBTCJYTzN6Pd/A7A8JkT51PasXhfBVzM0QsJZeQpajZpkPbb126pk2EHXq43oZ
         ar8g==
X-Gm-Message-State: AOAM533c4Kl+T9bB+d2h31iTrGoGS2Pyv3jj1yseDWp08wlC6v5bzCQz
        09eaKfGzBA5Cb4pKSMC+AsU=
X-Google-Smtp-Source: ABdhPJzH+TYpnt3oy1FqocZ1A8ZSjdLchUbbv88G/CLiD/w1q4sft1RfgxacRYroytzVicTDMyRR1Q==
X-Received: by 2002:a05:6512:21c8:: with SMTP id d8mr4188821lft.7.1637038570719;
        Mon, 15 Nov 2021 20:56:10 -0800 (PST)
Received: from [172.28.2.233] ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id k15sm1646322ljh.102.2021.11.15.20.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 20:56:10 -0800 (PST)
Message-ID: <6d2d9c4a-3f05-1d51-42dc-b1ebbb4aefe1@gmail.com>
Date:   Tue, 16 Nov 2021 07:56:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] staging: r8188eu: remove unused defines in wifi.h
Content-Language: en-US
To:     Zameer Manji <zmanji@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211116011451.896714-1-zmanji@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211116011451.896714-1-zmanji@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 04:14, Zameer Manji wrote:
> None of these defines in wifi.h are used so they
> can be safely removed.
> 
> Signed-off-by: Zameer Manji <zmanji@gmail.com>
> ---
>   drivers/staging/r8188eu/include/wifi.h | 57 --------------------------
>   1 file changed, 57 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> index 193a557f0f47..7cbc7015e90f 100644
> --- a/drivers/staging/r8188eu/include/wifi.h
> +++ b/drivers/staging/r8188eu/include/wifi.h
> @@ -13,32 +13,9 @@
>   #define BIT(x)	(1 << (x))

What about BIT() macro? It's already defined in include/vdso/bits.h and 
can be included via include/bits.h.

Most likely linux/ieee80211.h contains bits.h. Haven't checked yet, but 
anyway redefining kernel macros is not good approach and BIT() can be 
also removed.



With regards,
Pavel Skripkin
