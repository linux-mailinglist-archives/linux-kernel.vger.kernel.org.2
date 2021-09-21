Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9294135D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhIUPIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:08:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59422 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhIUPH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:07:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18LF6K7M000980;
        Tue, 21 Sep 2021 10:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632236780;
        bh=e1C9dxRu2rpH6JNZ8lGvLtHm9S53oRzTxeitBhOkrgQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YAsOxf8yqMmYw3YuuYgyKw6lXH/1+9eLJgrn8pKk+/h0Z8ynlFl1TCo7en7VePQk+
         Cu/EzDlS5EpntZN+sYC4koVYAAHGAUEcvy+Ky+f2xZBw0NrH6RDUf0MJfMZ5+eiEGS
         QrbVXkCYKZrH6dDYvbsZSote2vh9APXFfX7pNH5A=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18LF6JGZ075510
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Sep 2021 10:06:19 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Sep 2021 10:06:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Sep 2021 10:06:19 -0500
Received: from [10.250.37.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18LF6J51087845;
        Tue, 21 Sep 2021 10:06:19 -0500
Subject: Re: [PATCH v4 2/6] arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Aswath Govindraju <a-govindraju@ti.com>
References: <cover.1631708830.git.jan.kiszka@siemens.com>
 <c18b46fcf205074db2bdd6d0f7694f07216fc241.1631708830.git.jan.kiszka@siemens.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <29a9389f-c27a-9b88-37b8-2de3bf54c37a@ti.com>
Date:   Tue, 21 Sep 2021 10:06:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c18b46fcf205074db2bdd6d0f7694f07216fc241.1631708830.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 7:27 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The IOT2050 devices described so far are using SR1.0 silicon, thus do
> not have the additional PRUs of the ICSSG of the SR2.0. Disable them.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Acked-by: Aswath Govindraju <a-govindraju@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
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

