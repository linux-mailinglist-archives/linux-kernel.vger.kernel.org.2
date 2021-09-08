Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8B94032B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 04:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347136AbhIHCqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 22:46:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50138 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbhIHCp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:45:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1882igT3099648;
        Tue, 7 Sep 2021 21:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631069082;
        bh=IhgD6rGc1hvaiqNGzq1oAJoxWP6SQ5EaATMhBa6lVCo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=d1cwvDSfWyQyMj9dQ54aUw1XA1URiU/bvRd/XnQRrQs+Q4chs30oTp2Feofzvj4LQ
         +uwlrZyjCXMww6gIJ53G0BNifb63KpbhgILSKi5PuME6HmaF1jGh/+FBkHLj7lsh5+
         Tm0A/vu8UPUxHQQK9ll2gaaeT7l+6wuXsmKOcG10=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1882ig9n056414
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Sep 2021 21:44:42 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Sep 2021 21:44:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Sep 2021 21:44:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1882igGR073864;
        Tue, 7 Sep 2021 21:44:42 -0500
Date:   Tue, 7 Sep 2021 21:44:42 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am65: Flip mmc device ordering
Message-ID: <20210908024442.jskmqqye432p4nmt@gatherer>
References: <cover.1631032682.git.jan.kiszka@siemens.com>
 <0dce149347353556e38a0bdf9a9489ffc9cf66d2.1631032682.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0dce149347353556e38a0bdf9a9489ffc9cf66d2.1631032682.git.jan.kiszka@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:37-20210907, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This ensures that the SD card will remain mmc0 across devices with and
> without eMMC.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index a9fc1af03f27..785d931a2dd9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -31,6 +31,8 @@ aliases {
>  		i2c4 = &main_i2c2;
>  		i2c5 = &main_i2c3;
>  		ethernet0 = &cpsw_port1;
> +		mmc0 = &sdhci1;
> +		mmc1 = &sdhci0;

Jan,

Responding in context of [1]. Suggestion from Aswath is to do the
following instead at SoC level:
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;

>  	};
>  
>  	chosen { };
> -- 
> 2.31.1
> 
[1] https://lore.kernel.org/all/4cb6e76e-479f-5e06-778a-4788be53afb9@siemens.com/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
