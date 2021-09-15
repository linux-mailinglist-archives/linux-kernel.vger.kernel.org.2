Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942E040BDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhIOCmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:42:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49112 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhIOCma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:42:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18F2f3gD011135;
        Tue, 14 Sep 2021 21:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631673663;
        bh=a1D5LbkSa6XxkaDORQZ13b3WaGLuI7Sgt2608PMhTTc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ECMclo0rhulUHthFyOJe7bvsq0ISOLgitBK8Q3AbLctMwYLCjt+fMDkbnbw77x8wa
         i6hSU847usJ0hXauXije4oOhZiY4XPTNsUnlYincuEVvuiE9d3V+B+J+23PF9HGG+b
         upFAZjNLN+OZAJ0fOEbvNIZ6lD14zArfzEF4b3Uo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18F2f2or125912
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Sep 2021 21:41:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Sep 2021 21:41:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Sep 2021 21:41:01 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18F2ewFD069180;
        Tue, 14 Sep 2021 21:40:59 -0500
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: iot2050: Flip mmc device ordering
 on Advanced devices
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1631216478.git.jan.kiszka@siemens.com>
 <7385701c47c11ff2c3455e02c81be24cbb919905.1631216478.git.jan.kiszka@siemens.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <5bc5bc51-cf79-00c8-caf1-10100178cbf9@ti.com>
Date:   Wed, 15 Sep 2021 08:10:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7385701c47c11ff2c3455e02c81be24cbb919905.1631216478.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/21 1:11 am, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This ensures that the SD card will remain mmc0 across Basic and Advanced
> devices, also avoiding surprises for users coming from the downstream
> kernels.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Acked-by: Aswath Govindraju <a-govindraju@ti.com>

>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 1008e9162ba2..6261ca8ee2d8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -17,6 +17,8 @@
>  / {
>  	aliases {
>  		spi0 = &mcu_spi0;
> +		mmc0 = &sdhci1;
> +		mmc1 = &sdhci0;
>  	};
>  
>  	chosen {
> 

