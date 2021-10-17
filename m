Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E50430895
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245619AbhJQMRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbhJQMRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:17:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D04C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:15:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y3so35881394wrl.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4rGQu9A9hg6MKWxmyhdVi7SLuN8q4rVtdsjRdJ3svpQ=;
        b=A+3OurShtosqmVYq25zLOfVNdpG6MQ/pqQ+uIG+vGL4jkzWR/U0RVccHEdfm/s+vee
         /JP6fYXZk2McT/sacQxQZ9G52KtjNEaWQEDajzL0VIByftr7KLT/GrpxvLSjqDgyujlR
         5MnRw/WevlyGun715FsAeABXmpDcCiqlBZ7s4pehWSXLJq1BI2gwjV6duc/e2mFN3sWC
         9MZ5hJIbUbGR7UO8gB19ZCLTDYnrjkH9bAvbJHTuDM6qQYgoeDZ/ZpC4PHUkYcbOj1eI
         /4mJvpgrmdlksvr0U7jbOUt8AD9fVHJjwspuhpBEXMcUToTK5nQaI4K1Uc9RiTJ3ovss
         jUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4rGQu9A9hg6MKWxmyhdVi7SLuN8q4rVtdsjRdJ3svpQ=;
        b=g/sgxN288w9IvWU25K/WS58pY4j7p93q33OZqtn3JlbvILpEXUq9RgiamY5X1Qb0Wn
         u/fGi4C7SJwClHwRCaNw4lGd0baHdth7ENlR3Ihe6Vs3BXAS/U077w7XAi90c+lMLn8H
         1Gx+kptM78nIj3NCzEXz+RdEdvqrk/CvSeDggz9vv8XBgisHBWsvtD/lnIFb2MYLT+mx
         6PWd8vt6hRNFsjWvSbTy/nSQNhy+OZe5CGculx1oxqEjn5PzhZSnQ+WwQT0Gyr5EWeIb
         Kvrt6ygu80rimMSAv4yz1uRPgiJtOTn6jpxrXSB+ve3OrN+WONcmNSJLyq0Jv5zQxIgV
         o91w==
X-Gm-Message-State: AOAM5319yJ3qAZuQ5SEIk9GtTpYvVQGh0pn/UbfXzxKvhSHP/PQFkgDT
        khpePGctq9KzDGvp2jypjfI=
X-Google-Smtp-Source: ABdhPJyIJsVeEecyaw19JmEdHpyfzEypReDKnv2jtc6S/6OR4WdwNGfTHZ7drSqYWhagxTENi24P1A==
X-Received: by 2002:adf:d1ee:: with SMTP id g14mr28422383wrd.165.1634472935679;
        Sun, 17 Oct 2021 05:15:35 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id n9sm3813170wro.68.2021.10.17.05.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 05:15:35 -0700 (PDT)
Message-ID: <1072576d-f580-413c-4566-df274a395c65@gmail.com>
Date:   Sun, 17 Oct 2021 14:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] staging: r8188eu: Makefile: remove unused driver
 config
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211016173544.25376-1-martin@kaiser.cx>
 <20211016173544.25376-2-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211016173544.25376-2-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/21 19:35, Martin Kaiser wrote:
> Remove config settings from the Makefile that are related to
> unused or deleted features.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/Makefile | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
> index 1e0cb819f7f3..fccf7e6d1520 100644
> --- a/drivers/staging/r8188eu/Makefile
> +++ b/drivers/staging/r8188eu/Makefile
> @@ -4,8 +4,6 @@ EXTRA_CFLAGS += -O1
>   
>   ccflags-y += -D__CHECK_ENDIAN__
>   
> -CONFIG_WOWLAN = n
> -
>   OUTSRC_FILES :=				\
>   		hal/HalHWImg8188E_MAC.o	\
>   		hal/HalHWImg8188E_BB.o	\
> @@ -36,10 +34,6 @@ OUTSRC_FILES :=				\
>   		hal/usb_halinit.o	\
>   		hal/usb_ops_linux.o
>   
> -RTL871X = rtl8188e
> -
> -HCI_NAME = usb
> -
>   _OS_INTFS_FILES :=				\
>   			os_dep/ioctl_linux.o	\
>   			os_dep/mlme_linux.o	\
> @@ -52,10 +46,6 @@ _OS_INTFS_FILES :=				\
>   
>   _HAL_INTFS_FILES += $(OUTSRC_FILES)
>   
> -ifeq ($(CONFIG_WOWLAN), y)
> -EXTRA_CFLAGS += -DCONFIG_WOWLAN
> -endif
> -
>   SUBARCH := $(shell uname -m | sed -e "s/i.86/i386/; s/ppc.*/powerpc/; s/armv.l/arm/; s/aarch64/arm64/;")
>   
>   ARCH ?= $(SUBARCH)
> 

Acked-by: Michael Straube <straube.linux@gmail.com>
