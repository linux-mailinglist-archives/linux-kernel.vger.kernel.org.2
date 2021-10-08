Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9BE426A24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbhJHLvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbhJHLvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:51:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4661C061772;
        Fri,  8 Oct 2021 04:49:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v17so28944022wrv.9;
        Fri, 08 Oct 2021 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i1USBJq9F3A9TOJZg6Wun0mkV6fuM/zyzzq0ur+ZWkM=;
        b=TrHWFpZk1hBg4BNeXKvJbfJJ6DVgKu9vSyROmzcutuCtBP92iFon9Hc1IwCieShoQS
         P8bm62d+2+YpgbV0vEr6jKoElMLYWATbfJJJy4Me3gj3kTU2aZyKrY1dnFMetszxksfN
         y+mJJqVCUGGI6ZcO4AFrStPUlOHviZQyzLBnreYPS9hlZ9ZSWCU57gU7DA/s9tnwz+cD
         2ueenDzipjfvutsEc1ucvvwRsFSlh0aTG31vhnThuAaoUIE5bHfP8WjNoSijfObZwcJc
         u5Fm5XOe3OfhoXavxGGVujBqPU2Tzpf0erk8uuVL+1dvUizbvf+eOwziXnI0iv0joknT
         RVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i1USBJq9F3A9TOJZg6Wun0mkV6fuM/zyzzq0ur+ZWkM=;
        b=ejQv1TiGAP9FYazuDmT/8x5adXKsJLdXdjoOofOUbOrmXAz8h5DjPbcJ0fQZXOVSXX
         1M61D03pJWRQJLhmnPBljj40Kwg3aA1YxuXpM0CMhhTsd+nM5bzl18D4wtzrbnd0Cs50
         vQeukuZNnXtQiAfRzUaea1pmLxu1t3XqXjpbx6YSN6uXBXan1hJRW2pDhDA8oaYhjU5g
         cymX+gaZXUtKjdmAovZpelLDIjJvqfUnASoUXp51XY0smUazbCyphlui+n8nnelXL0gg
         HifZc1dFOrZ3gC/pXSQJQRx3u1xhB1ZeX2rppzhQrXEMUGpMhHMWoFCclBPaazREVXrl
         GkxA==
X-Gm-Message-State: AOAM533LJDk6QBqBeboAPqoZHUYu265TSa6yrGTYFHAiMO8p1KseL5qc
        GEhjD2cWC7m0v7h+f6jSZQs=
X-Google-Smtp-Source: ABdhPJwEb1M1xAqD7t+bZHRlFTnnVa7+ol3EKhZKsTwrkNUouAJXScKLX+w24KKdd+gB+6dDenYqSA==
X-Received: by 2002:a5d:64c3:: with SMTP id f3mr3501505wri.73.1633693767284;
        Fri, 08 Oct 2021 04:49:27 -0700 (PDT)
Received: from [192.168.2.177] ([206.204.146.29])
        by smtp.gmail.com with ESMTPSA id a81sm2342283wmd.30.2021.10.08.04.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 04:49:26 -0700 (PDT)
Message-ID: <686404ce-2e0b-5470-b095-1c1fd7c18250@gmail.com>
Date:   Fri, 8 Oct 2021 13:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 2/2] arm: dts: mt6589: Add device tree for Fairphone 1
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-mediatek@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
References: <20211005202833.96526-1-luca@z3ntu.xyz>
 <20211005202833.96526-2-luca@z3ntu.xyz>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211005202833.96526-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2021 22:28, Luca Weiss wrote:
> Add rudimentary support for the Fairphone 1, based on MT6589 to boot to
> UART console.
> 
> The recently added SMP support needs to be disabled for this board as
> the kernel panics executing /init with it, even though the CPUs seem to
> start up fine - maybe a stability issue.
> 
> [    0.072010] smp: Bringing up secondary CPUs ...
> [    0.131888] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.191889] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> [    0.251890] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> [    0.251982] smp: Brought up 1 node, 4 CPUs
> [    0.254745] SMP: Total of 4 processors activated (7982.28 BogoMIPS).
> [    0.255582] CPU: All CPU(s) started in SVC mode.
> 
> [    0.472039] Run /init as init process
> [    0.473317] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
> 

Would be nice to find out why. Did you tried to boot the system with 
enable-method set but with bringing up just one or two cpus?

> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   arch/arm/boot/dts/Makefile                 |  1 +
>   arch/arm/boot/dts/mt6589-fairphone-fp1.dts | 30 ++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
>   create mode 100644 arch/arm/boot/dts/mt6589-fairphone-fp1.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e0934180724..24f402db2613 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1437,6 +1437,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>   	mt2701-evb.dtb \
>   	mt6580-evbp1.dtb \
>   	mt6589-aquaris5.dtb \
> +	mt6589-fairphone-fp1.dtb \
>   	mt6592-evb.dtb \
>   	mt7623a-rfb-emmc.dtb \
>   	mt7623a-rfb-nand.dtb \
> diff --git a/arch/arm/boot/dts/mt6589-fairphone-fp1.dts b/arch/arm/boot/dts/mt6589-fairphone-fp1.dts
> new file mode 100644
> index 000000000000..32c14ecf2244
> --- /dev/null
> +++ b/arch/arm/boot/dts/mt6589-fairphone-fp1.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, Luca Weiss <luca@z3ntu.xyz>
> + */
> +
> +/dts-v1/;
> +#include "mt6589.dtsi"
> +
> +/ {
> +	model = "Fairphone 1";
> +	compatible = "fairphone,fp1", "mediatek,mt6589";
> +
> +	chosen {
> +		stdout-path = &uart3;
> +	};
> +
> +	cpus {

I'd expected "&cpus" why can we overwrite delete the node property like this here?

> +		/* SMP is not stable on this board, makes the kernel panic */
> +		/delete-property/ enable-method;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> 
