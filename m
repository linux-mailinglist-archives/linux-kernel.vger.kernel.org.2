Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE042F199
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbhJONBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:01:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35828 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235718AbhJONBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:01:40 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FAMd6X022836;
        Fri, 15 Oct 2021 14:59:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=+ib+q3m8dnN8ADucrFEFL5QS/hW2B3DXFypb6Jmo450=;
 b=NQzEo0Y9sJVGo3dihWmSLaekgcpSy4KjRdZh6CSxKc/VIBT4txXZ77RV+gba0f5EKRO2
 PSi6RWbbGK2RVrOeQwipc5oRwsbMuiqPXlff7yz1x4DiAOmwfSyge/WpdEubdSmcEPQS
 skEXnH4b23D3FFuy95uQHRrl14VW6QyekvX71iwADuk0t1Oz+3jLMtmt1JNw+dQrhABQ
 9F3e0SC9nvMzrQKWr0kJVXd4FK2ApoDGcWJSwhxEzUo7YWoTUlBdSdmDhVjVo+KEU6Ga
 h3/MXMR25TqBbBL6vPGCLaysigCnbL7AVM3AXdclrvFWpQIwN75kE09DmAuz0OX7xAvN pQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bq270k9wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 14:59:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 302FA10002A;
        Fri, 15 Oct 2021 14:59:21 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2543522FA3F;
        Fri, 15 Oct 2021 14:59:21 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 15 Oct
 2021 14:59:20 +0200
Subject: Re: [PATCH] ARM: dts: stm32: fix STUSB1600 Type-C irq level on
 stm32mp15xx-dkx
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC:     <robh+dt@kernel.org>, <amelie.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1632231289-18881-1-git-send-email-fabrice.gasnier@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <25ca69bf-1a39-cbc7-5743-e282121a7bf5@foss.st.com>
Date:   Fri, 15 Oct 2021 14:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1632231289-18881-1-git-send-email-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_04,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/21 3:34 PM, Fabrice Gasnier wrote:
> STUSB1600 IRQ (Alert pin) is active low (open drain). Interrupts may get
> lost currently, so fix the IRQ type.
> 
> Fixes: 83686162c0eb ("ARM: dts: stm32: add STUSB1600 Type-C using I2C4 on stm32mp15xx-dkx")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> index 9a95489..878ea36 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> @@ -260,7 +260,7 @@
>   	stusb1600@28 {
>   		compatible = "st,stusb1600";
>   		reg = <0x28>;
> -		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>   		interrupt-parent = <&gpioi>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&stusb1600_pins_a>;
> 

Applied on stm32-next.

Thanks
Alex
