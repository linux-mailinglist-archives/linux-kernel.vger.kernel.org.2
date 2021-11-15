Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4040A4509DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 17:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhKOQpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 11:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhKOQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 11:45:19 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB35C061570;
        Mon, 15 Nov 2021 08:42:23 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso315602wmf.0;
        Mon, 15 Nov 2021 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JuqPZpJkmVPxr1XEd2xmER6X+Ym/lgTGuP07ml9bU0g=;
        b=GJUKEGDKs7KpQ/B8MSIsEkzPmGD9HaDBMQ/7KfepUnjJ4QIuJ2U4i5lEKz2HLUwjIF
         49iPrAkz1V7h60hhJ0uSWSuS2utkMm1n8Tx7HrijpwI4oJwvYg5HcF7F/AGoDIv+hyPe
         XE9LDsTth53plL96TWa6QRbA63N0tJ0RIBsghoDuPprc9XYvGjCNi4qmckFaQvoW6+lF
         LQtGZWmW/xTfoKBXq3WVZ7DPptprQvRKQWYQnOApM8xZQ6H0SFyuA1DBokbdWvjZ8WDV
         713hzutv++iddTkcWPejXBCK2u4v7IECLNl9sTHyDpa/zlE1SbZbZjmUWgmmpwd6VUEt
         0Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JuqPZpJkmVPxr1XEd2xmER6X+Ym/lgTGuP07ml9bU0g=;
        b=nq8ekplPWfCnyy7HbnFDhlb6bpRofMdKmmPI/jaC4JkUwdxmvuh5hE8maENKGC2DBi
         NF3PthbviOEwwF+fL/LeXodEJ3sWiOfFtYiikQtYMYIV2tqnsZTSTdv+7N3D+BbHa2nk
         sCzX3MpeeTzA/QXmLSHvAXh8JkvnUDrWw7LgT1QQ/7r270u7e4AxjkFHO+DkWLSbw0ZF
         Pimy0EzWMLdzrvn0mlLJ+65oGaSpZt1mWGWrJFMzNjRCzy8/vmlxIdBODkIO7tGrA3IC
         JbdstZsddpHY9sokBSot2PfsmbOG68ZZcCNpz+NTnTz/GjZ1qgwE/XLDfK+F/DG9A8oW
         DJIw==
X-Gm-Message-State: AOAM533Vp3m9veZFwCUgiovSDS4ngEaQnt9ODQPQRjdwQMbW9nU/cMiQ
        XRL1N/vUqNsDfOWMbesBgds=
X-Google-Smtp-Source: ABdhPJwok9H8xlFto8+eTwjCwgKcKtmnfgk3TO4CGlesnBQIwE8v1bZMANd9k7yeOeUrVOnuk1RzJg==
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr59313728wmj.55.1636994542287;
        Mon, 15 Nov 2021 08:42:22 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id j11sm14944511wrt.3.2021.11.15.08.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 08:42:21 -0800 (PST)
Message-ID: <62e52ffc-09e5-6b83-540f-f6347fca7adf@gmail.com>
Date:   Mon, 15 Nov 2021 17:42:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] arm: dts: mt6589: Add device tree for Fairphone 1
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-mediatek@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211024084535.30959-1-luca@z3ntu.xyz>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211024084535.30959-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2021 10:45, Luca Weiss wrote:
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
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Now part of v5.16-next/dts32

Thanks

> ---
>   arch/arm/boot/dts/Makefile                 |  1 +
>   arch/arm/boot/dts/mt6589-fairphone-fp1.dts | 30 ++++++++++++++++++++++
>   arch/arm/boot/dts/mt6589.dtsi              |  2 +-
>   3 files changed, 32 insertions(+), 1 deletion(-)
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
> index 000000000000..c952347981de
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
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +};
> +
> +&cpus {
> +	/* SMP is not stable on this board, makes the kernel panic */
> +	/delete-property/ enable-method;
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
> index 70df00a7bb26..c6babc8ad2ba 100644
> --- a/arch/arm/boot/dts/mt6589.dtsi
> +++ b/arch/arm/boot/dts/mt6589.dtsi
> @@ -14,7 +14,7 @@ / {
>   	compatible = "mediatek,mt6589";
>   	interrupt-parent = <&sysirq>;
>   
> -	cpus {
> +	cpus: cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   		enable-method = "mediatek,mt6589-smp";
> 
