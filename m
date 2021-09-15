Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E540BDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhIOCot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:44:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49590 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbhIOCos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:44:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18F2hOG9011842;
        Tue, 14 Sep 2021 21:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631673804;
        bh=FBXPfHWkW3xvmVjVjEAuMjeAj0JmYFVAStEn6Rlwnf0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YNenTsSJP8mtcYulxMVF3+lg7ZSAupn0tpB3U6p7BMDO1USWsoCWmjV8aiS2AwWjy
         EeWwh/v9wAaTbtZlkThetSu0KtJLVqcxDN3C54va1xpSMGyWR6PjZa+XCsUBqq5Qa/
         glK3/n72otvxHfAi0YJtEF/tiAlecBf/jpfFBvdc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18F2hOoe073941
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Sep 2021 21:43:24 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Sep 2021 21:43:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Sep 2021 21:43:23 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18F2hKca072203;
        Tue, 14 Sep 2021 21:43:21 -0500
Subject: Re: [PATCH v3 2/5] arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1631216478.git.jan.kiszka@siemens.com>
 <cf3b54a42583b97e6065e211fdd73613bf2a6c02.1631216478.git.jan.kiszka@siemens.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <b58a8f65-f5a5-2fc3-9069-ec1729f98e5b@ti.com>
Date:   Wed, 15 Sep 2021 08:13:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cf3b54a42583b97e6065e211fdd73613bf2a6c02.1631216478.git.jan.kiszka@siemens.com>
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
> The IOT2050 devices described so far are using SR1.0 silicon, thus do
> not have the additional PRUs of the ICSSG of the SR2.0. Disable them.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Acked-by: Aswath Govindraju <a-govindraju@ti.com>

>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 6261ca8ee2d8..58c8e64d5885 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -716,3 +716,27 @@ &icssg1_mdio {
>  &icssg2_mdio {
>  	status = "disabled";
>  };
> +
> +&tx_pru0_0 {
> +	status = "disabled";
> +};
> +
> +&tx_pru0_1 {
> +	status = "disabled";
> +};
> +
> +&tx_pru1_0 {
> +	status = "disabled";
> +};
> +
> +&tx_pru1_1 {
> +	status = "disabled";
> +};
> +
> +&tx_pru2_0 {
> +	status = "disabled";
> +};
> +
> +&tx_pru2_1 {
> +	status = "disabled";
> +};
> 

