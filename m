Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37D2305A64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhA0LxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:53:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39620 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbhA0Lto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:49:44 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10RBlxLb113803;
        Wed, 27 Jan 2021 05:47:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611748079;
        bh=2whmilIuoGCUmJs9CP5lfu3eSo1VzsAUCj1yQnSaSek=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=M+Xgiy8tN/Gm6li1YxHWFJVuLPSSg4lncXDskwMRfVNtIuAwg8MbvfATezjmY+HxS
         NYLeOV4spVVNkPedIsxmKyRICa5Q5yaLqJ+qWf8+6QeA5Ymbqd8d6xreRzqItF0U7J
         NUXRR1zVq14oK9Qh/bmdlGSEUCaKd7IhDe6sjtlM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10RBlx4J095022
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jan 2021 05:47:59 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 Jan 2021 05:47:59 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 Jan 2021 05:47:58 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10RBltYX085345;
        Wed, 27 Jan 2021 05:47:56 -0600
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j7200-main: Add support for higher
 speed modes in MMCSD subsystems
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210125162532.30845-1-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <ed978a0a-9a54-a3da-bb64-087c7d95e620@ti.com>
Date:   Wed, 27 Jan 2021 17:17:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125162532.30845-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/01/21 9:55 pm, Aswath Govindraju wrote:
> The following speed modes are now supported in J7200 SoC,
> - HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
> - UHS-I speed modes in MMCSD1 subsystem [1].
> 
> Set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1 device
> tree nodes.
> 
> [1] - section 12.3.6.1.1 MMCSD Features, in
>       https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> performance test logs using EXT4 filesystem for eMMC HS400 speed mode,
> https://pastebin.ubuntu.com/p/JnPs8DxV58/
> 
> performance test logs using EXT4 filesystem for SD SDR104 speed mode,
> https://pastebin.ubuntu.com/p/KPGzBz8YwC/
> 
> Changes since v1:
> - Squashed the two patches into one
> - added performance logs for the above mentioned speed modes
> 
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 4cc2e9094d0e..4b3d0b5739e8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -517,6 +517,8 @@
>  		ti,trm-icp = <0x8>;
>  		bus-width = <8>;
>  		mmc-ddr-1_8v;
> +		mmc-hs200-1_8v;
> +		mmc-hs400-1_8v;
>  		dma-coherent;
>  	};
>  
> @@ -534,7 +536,6 @@
>  		ti,otap-del-sel-sdr50 = <0xc>;
>  		ti,otap-del-sel-sdr104 = <0x5>;
>  		ti,otap-del-sel-ddr50 = <0xc>;
> -		no-1-8-v;
>  		dma-coherent;
>  	};
>  
> 

Please ignore this patch. Sorry, I forgot to add voltage regulator nodes
required to enable UHS modes. While testing there was an error from my
side.

Thanks,
Aswath
