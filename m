Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F151545DD05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355895AbhKYPQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:16:00 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38898 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352143AbhKYPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:13:59 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AP9GKwf002630;
        Thu, 25 Nov 2021 16:10:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ZNpw/wEl79xLxGfptoydRS3NBKjqN1tzwe8TzZvAg5g=;
 b=YXm8SP6htVEqYHadkROkvqRar4Nmf45yosi0uj5v1/qEqefkGbQ5KnvoTPqjZCF7AprG
 mCgR+RVLZO4ud1WoxxMVKgjXtCuEcn1LnAbofmXf/djAXkDgDvEf3UNd544GoiTQA698
 kjRg+/S7owgH2Bmki65f5u4BQyYmXznzRLIl610QIo/+Es3NzavrcruadT3/RvaCCula
 37SZnO3z2dYPKQpnSkH41W33Qs1XplZ5/Zigjm3kaI0B/285oTh+B4UzE4nyZiXHwKaD
 w1tpQtkh1/rzQpLHgAV/gVPiVVd9hN59tdnLFriXaKx4bJYXqBfZMxRNSd4f5LsdG1ZW DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cj3cym0bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 16:10:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D1BDC10002A;
        Thu, 25 Nov 2021 16:10:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C8791234542;
        Thu, 25 Nov 2021 16:10:38 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 25 Nov
 2021 16:10:38 +0100
Subject: Re: [PATCH 1/1] ARM: dts: stm32: add pull-up to USART3 and UART7 RX
 pins on DKx boards
To:     Erwan Le Ray <erwan.leray@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
References: <20211020150311.10101-1-erwan.leray@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <40ff7701-7911-28e1-a217-0f1a3448df8e@foss.st.com>
Date:   Thu, 25 Nov 2021 16:10:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211020150311.10101-1-erwan.leray@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-25_06,2021-11-25_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 5:03 PM, Erwan Le Ray wrote:
> Add pull-up to USART3 and UART7 RX pins to allow loop tests between USART3
> and UART7 on stm32mp15 DKx boards.
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

Applied on stm32-next.

thanks
Alex


> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index e13c2a9762b8..fe6e6f50151d 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -1816,7 +1816,7 @@
>   		};
>   		pins2 {
>   			pinmux = <STM32_PINMUX('E', 7, AF7)>; /* UART7_RX */
> -			bias-disable;
> +			bias-pull-up;
>   		};
>   	};
>   
> @@ -1826,7 +1826,7 @@
>   		};
>   		pins2 {
>   			pinmux = <STM32_PINMUX('E', 7, AF7)>; /* UART7_RX */
> -			bias-disable;
> +			bias-pull-up;
>   		};
>   	};
>   
> @@ -1971,7 +1971,7 @@
>   		pins2 {
>   			pinmux = <STM32_PINMUX('B', 12, AF8)>, /* USART3_RX */
>   				 <STM32_PINMUX('I', 10, AF8)>; /* USART3_CTS_NSS */
> -			bias-disable;
> +			bias-pull-up;
>   		};
>   	};
>   
> @@ -1988,7 +1988,7 @@
>   		};
>   		pins3 {
>   			pinmux = <STM32_PINMUX('B', 12, AF8)>; /* USART3_RX */
> -			bias-disable;
> +			bias-pull-up;
>   		};
>   	};
>   
> @@ -2012,7 +2012,7 @@
>   		pins2 {
>   			pinmux = <STM32_PINMUX('B', 12, AF8)>, /* USART3_RX */
>   				 <STM32_PINMUX('B', 13, AF7)>; /* USART3_CTS_NSS */
> -			bias-disable;
> +			bias-pull-up;
>   		};
>   	};
>   
> @@ -2029,7 +2029,7 @@
>   		};
>   		pins3 {
>   			pinmux = <STM32_PINMUX('B', 12, AF8)>; /* USART3_RX */
> -			bias-disable;
> +			bias-pull-up;
>   		};
>   	};
>   
> 

