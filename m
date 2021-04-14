Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57E35ED31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhDNGXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:23:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52771 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349221AbhDNGW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:22:59 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWYv6-0007Eb-QI
        for linux-kernel@vger.kernel.org; Wed, 14 Apr 2021 06:22:36 +0000
Received: by mail-ed1-f71.google.com with SMTP id z3-20020a05640240c3b029037fb0c2bd3bso2745755edb.23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JSGpiJ39NLZU1nC6HICC+dG4seEp2QpeNa5YM4lkqF4=;
        b=JSNVBzraQuAKQAuxbG+AASRr7d4NS0DCR4kgYJbb8gNbg7NLsZRHuE6/T2bqeAaT7o
         E4J/4gg5+98pK4g7HetgAza9kdAoj2b2/YDLRpda9QT1yqmDvVG3I/js0//Ne4edHj/0
         Hk/YfEpBhnFr5zfjg6uCsN1xEzEU1C3eAFGToABVtvann7VPk8xbR0k4gdLjP/4XjSJ1
         UAwDVrsdwp6i3+NtPqCe/4+lbFxd8dqqcox4lQo0LEcQc6huGhX4TyX8DrJoEV/l2GvS
         1tRtuu3+lsNheHTaHrEFKKpgNV/6nZFddRBAD/gWHi+FCy1jL2wdNVnPEIoDQwUFitk8
         nZdg==
X-Gm-Message-State: AOAM530s2UjTuR4QRl0yV7y5vQh9XeDEZDQCNMR6D12hghwiDt+a95Qx
        utNeOSILV1huy0ZozDt4wBYu5CbbksQlxEGxrzG4KK0THWFMScK7Ryc4MiLzl7vOadDlRL4IDte
        0b0iL7v7r4IAQgJfSAP/ijsz0SRM7rnGtz3/WLzc/UQ==
X-Received: by 2002:a17:907:7283:: with SMTP id dt3mr13059961ejc.47.1618381356425;
        Tue, 13 Apr 2021 23:22:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc+W2YNC6BqcZus895U2ci0Cv8Sg59KQnn2K2ha4/WQYNKRsatv0G/4PTC+oGTu4cp/AK51Q==
X-Received: by 2002:a17:907:7283:: with SMTP id dt3mr13059942ejc.47.1618381356301;
        Tue, 13 Apr 2021 23:22:36 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id dh27sm10829592edb.28.2021.04.13.23.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 23:22:35 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] dt-bindings: arm: imx: Add i.mx6q DaSheng COM-9XX
 SBC board dts support
To:     dillon.minfei@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        linux@rempel-privat.de, s.riedmueller@phytec.de,
        matthias.schiffer@ew.tq-group.com, leoyang.li@nxp.com,
        arnd@arndb.de, olof@lixom.net, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        prabhakar.csengg@gmail.com, mchehab@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-media@vger.kernel.org
References: <1618380827-16056-1-git-send-email-dillon.minfei@gmail.com>
 <1618380827-16056-2-git-send-email-dillon.minfei@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2a993aa9-6933-4af8-da26-f53096dc6ab7@canonical.com>
Date:   Wed, 14 Apr 2021 08:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1618380827-16056-2-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 08:13, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> The DaSheng Com-9xx is and ARM based signle board computer (SBC)
> featuring:
> - i.MX6Q
> - 2GiB LPDDR3 DRAM
> - 8GiB eMMC 5.0 FLASH
> - 4MiB SPI Flash
> - USB 2.0 Host/Device
> - Multiple multi-protocol RS232/RS485 Serial ports
> - microSD socket
> - 5V DC power input
> - HDMI1.4a,1080p@60
> - RGMIIx1 Gigabit Ethernet
> - CSI0x1, connect with ov2659
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 297c87f45db8..24bdfbd4853f 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -206,6 +206,7 @@ properties:
>                - fsl,imx6q-sabreauto
>                - fsl,imx6q-sabrelite
>                - fsl,imx6q-sabresd
> +              - ds,imx6q-sbc              # Da Sheng COM-9XX Modules
>                - karo,imx6q-tx6q           # Ka-Ro electronics TX6Q Modules
>                - kiebackpeter,imx6q-tpc    # K+P i.MX6 Quad TPC Board
>                - kontron,imx6q-samx6i      # Kontron i.MX6 Dual/Quad SMARC Module
> 

You miss change in vendor prefixes. Didn't checkpatch complain about it?
Did you run checkpatch?
Best regards,
Best regards,
Krzysztof
