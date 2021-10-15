Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0682E42F1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbhJONEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:04:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37720 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233950AbhJONEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:04:13 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FAUt4s023369;
        Fri, 15 Oct 2021 15:02:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=+tcV1yuTviRHHEw5zsxDrHY85fzmmQAUWdNmbIqotIU=;
 b=xMXgaVMVrPLfuKxZpPoLSwgBLInpxFKbs39q1vqLxw9B5l3fp3yyww836f+ExgeE3oU4
 G8gKAqc9yzHmoYcZNS+YI3DNvdqxCORkQIu7+yFa52s6F81dziVgvEBBpsYeTQmRF2rk
 PO87EHc8El7pb/OKxFe6zUoGKZxrbrfHbEkrot8Ck4S4ZfgFgYYEVe2iArtGnbUKYwmO
 SgbrNKrYAEHrSGv+AhGJvGK3kDAtPuz+PTiWPIrMFjVVxjrylIf0FiNmr3iSYRHO3Erl
 KtowZ2jt+XNH8YEowilL+8GbEEUxECnkI4DWpRPiC8YjS0Ii+It+iLOQ9TrGJPxXPbJm Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bq270kah3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 15:02:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 38CA310002A;
        Fri, 15 Oct 2021 15:01:59 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 30F5C22FA55;
        Fri, 15 Oct 2021 15:01:59 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 15 Oct
 2021 15:01:58 +0200
Subject: Re: [PATCH] ARM: dts: stm32: fix SAI sub nodes register range
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210924160221.13287-1-olivier.moysan@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <f2c206ad-503b-3652-8741-d4c660b8dedf@foss.st.com>
Date:   Fri, 15 Oct 2021 15:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924160221.13287-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_04,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 6:02 PM, Olivier Moysan wrote:
> The STM32 SAI subblocks registers offsets are in the range
> 0x0004 (SAIx_CR1) to 0x0020 (SAIx_DR).
> The corresponding range length is 0x20 instead of 0x1c.
> Change reg property accordingly.
> 
> Fixes: 5afd65c3a060 ("ARM: dts: stm32: add sai support on stm32mp157c")
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index bd289bf5d269..6992a4b0ba79 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -824,7 +824,7 @@
>   				#sound-dai-cells = <0>;
>   
>   				compatible = "st,stm32-sai-sub-a";
> -				reg = <0x4 0x1c>;
> +				reg = <0x4 0x20>;
>   				clocks = <&rcc SAI1_K>;
>   				clock-names = "sai_ck";
>   				dmas = <&dmamux1 87 0x400 0x01>;
> @@ -834,7 +834,7 @@
>   			sai1b: audio-controller@4400a024 {
>   				#sound-dai-cells = <0>;
>   				compatible = "st,stm32-sai-sub-b";
> -				reg = <0x24 0x1c>;
> +				reg = <0x24 0x20>;
>   				clocks = <&rcc SAI1_K>;
>   				clock-names = "sai_ck";
>   				dmas = <&dmamux1 88 0x400 0x01>;
> @@ -855,7 +855,7 @@
>   			sai2a: audio-controller@4400b004 {
>   				#sound-dai-cells = <0>;
>   				compatible = "st,stm32-sai-sub-a";
> -				reg = <0x4 0x1c>;
> +				reg = <0x4 0x20>;
>   				clocks = <&rcc SAI2_K>;
>   				clock-names = "sai_ck";
>   				dmas = <&dmamux1 89 0x400 0x01>;
> @@ -865,7 +865,7 @@
>   			sai2b: audio-controller@4400b024 {
>   				#sound-dai-cells = <0>;
>   				compatible = "st,stm32-sai-sub-b";
> -				reg = <0x24 0x1c>;
> +				reg = <0x24 0x20>;
>   				clocks = <&rcc SAI2_K>;
>   				clock-names = "sai_ck";
>   				dmas = <&dmamux1 90 0x400 0x01>;
> @@ -886,7 +886,7 @@
>   			sai3a: audio-controller@4400c004 {
>   				#sound-dai-cells = <0>;
>   				compatible = "st,stm32-sai-sub-a";
> -				reg = <0x04 0x1c>;
> +				reg = <0x04 0x20>;
>   				clocks = <&rcc SAI3_K>;
>   				clock-names = "sai_ck";
>   				dmas = <&dmamux1 113 0x400 0x01>;
> @@ -896,7 +896,7 @@
>   			sai3b: audio-controller@4400c024 {
>   				#sound-dai-cells = <0>;
>   				compatible = "st,stm32-sai-sub-b";
> -				reg = <0x24 0x1c>;
> +				reg = <0x24 0x20>;
>   				clocks = <&rcc SAI3_K>;
>   				clock-names = "sai_ck";
>   				dmas = <&dmamux1 114 0x400 0x01>;
> @@ -1271,7 +1271,7 @@
>   			sai4a: audio-controller@50027004 {
>   				#sound-dai-cells = <0>;
>   				compatible = "st,stm32-sai-sub-a";
> -				reg = <0x04 0x1c>;
> +				reg = <0x04 0x20>;
>   				clocks = <&rcc SAI4_K>;
>   				clock-names = "sai_ck";
>   				dmas = <&dmamux1 99 0x400 0x01>;
> @@ -1281,7 +1281,7 @@
>   			sai4b: audio-controller@50027024 {
>   				#sound-dai-cells = <0>;
>   				compatible = "st,stm32-sai-sub-b";
> -				reg = <0x24 0x1c>;
> +				reg = <0x24 0x20>;
>   				clocks = <&rcc SAI4_K>;
>   				clock-names = "sai_ck";
>   				dmas = <&dmamux1 100 0x400 0x01>;
> 

Applied on stm32-next.

Thanks
Alex

