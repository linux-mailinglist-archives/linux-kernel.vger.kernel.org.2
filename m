Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE83F72AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhHYKKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbhHYKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:10:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D27C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:09:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i21so9144189ejd.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lTM6ISsEymRSdxqbfbjQ9nbYtaTqxueWlZIn8/Cn8Fw=;
        b=A6clfGDTpE1XV0m3hWY2qjpn2irid8WDQi/ySOnXTlo3MEf6IRyJUdFW4TP6xXuTrQ
         IvU6SWKhSDFJ3GHRSOU9ku+OyJIIKJTAebrk7kzYI23XBkMf2v3Jdx0UzEMvcgQiikgr
         JnrLs8j4KtBXpNhblXWBLk1MNsRW4mwqCdYqg+Cjb+Sm3pzBofa7sXXN7vb+P+/3+vN7
         sdzARspP7+BuCuHqBM5N9jhFJD+4xgwf9pnLhNBvidbj1KjcfiVwxywWeycLFo8A8hsp
         qjVuocULa6rPyFZX4ucztQr6CEe6bYn1EfvSzCOO1/bEH2MhjtJfROuQ7fqbnxeqxIyG
         X8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lTM6ISsEymRSdxqbfbjQ9nbYtaTqxueWlZIn8/Cn8Fw=;
        b=M0fodRmzb7dFNnZLe5DqYdkTIKroP7pWj2tck335NXyw0O+i7XMZwJWaXs3pmO2g1s
         FqlvTvfHLsPOZjfH42jpIbGe+s1sIzrqxA4hAb7TL5Q7s1tXjjRMS4bQbev8SEg2tEnq
         Tx245/heMBXRRMtgUT5h/PwFid2bCNTIjepOyA9jOESoQAnKCPiJ8vJOyCtjuv0RS9/5
         IhuCr0076FDMyVlCzr5rSdRkH/J6tV+6T6KvLwXfhgNHngkgnMo7WCPUoD9JeoMdgOP6
         mULXSQtpmUKgwcltllLP2HXSKDfdmzzzJq4g565S0RqS7spOJdwugGZ+90GrnfEgvHhW
         lKqA==
X-Gm-Message-State: AOAM531AbYql/UA4KRv1NZogY8qJh2gdW13C79zGs9zZ7s0yQanGhT3F
        GUimof7mOwZ9mRM/n5DLxHgMoDKvO+nWT8tT
X-Google-Smtp-Source: ABdhPJxEqu+4q/oK+dOodY3REvmNZlaxOAS1g55GEriLq0b6y+wQ7eSA58Yob89Vc0+Ss6zv5hsFBg==
X-Received: by 2002:a17:906:f8c4:: with SMTP id lh4mr44842845ejb.542.1629886187395;
        Wed, 25 Aug 2021 03:09:47 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::e05? ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id k15sm4509166ejb.92.2021.08.25.03.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 03:09:47 -0700 (PDT)
Subject: Re: [PATCH] microblaze: move core-y in arch/microblaze/Makefile to
 arch/microblaze/Kbuild
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210811164518.187497-1-masahiroy@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <5a401a6f-4f3a-43f0-50be-2bc4005ed46f@monstr.eu>
Date:   Wed, 25 Aug 2021 12:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210811164518.187497-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/21 6:45 PM, Masahiro Yamada wrote:
> Use obj-y to clean up Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/microblaze/Kbuild   | 4 ++++
>  arch/microblaze/Makefile | 5 -----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/microblaze/Kbuild b/arch/microblaze/Kbuild
> index a4e40e534e6a..a1c597889319 100644
> --- a/arch/microblaze/Kbuild
> +++ b/arch/microblaze/Kbuild
> @@ -1 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-y			+= kernel/
> +obj-y			+= mm/
> +obj-$(CONFIG_PCI)	+= pci/
> +obj-y			+= boot/dts/
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index 6d4af39e3890..9adc6b6434df 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -50,17 +50,12 @@ KBUILD_CFLAGS += -ffixed-r31 $(CPUFLAGS-y) $(CPUFLAGS-1) $(CPUFLAGS-2)
>  
>  head-y := arch/microblaze/kernel/head.o
>  libs-y += arch/microblaze/lib/
> -core-y += arch/microblaze/kernel/
> -core-y += arch/microblaze/mm/
> -core-$(CONFIG_PCI) += arch/microblaze/pci/
>  
>  boot := arch/microblaze/boot
>  
>  # Are we making a simpleImage.<boardname> target? If so, crack out the boardname
>  DTB:=$(subst simpleImage.,,$(filter simpleImage.%, $(MAKECMDGOALS)))
>  
> -core-y	+= $(boot)/dts/
> -
>  export DTB
>  
>  all: linux.bin
> 

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

