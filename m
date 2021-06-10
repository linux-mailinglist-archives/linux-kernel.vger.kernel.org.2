Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A5F3A2D63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhFJNsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:48:25 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:34868 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230346AbhFJNsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:48:24 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ADfF2G011626;
        Thu, 10 Jun 2021 15:46:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=wEEkWxXSfq66/leswbqmUsRSfaLtlKhzGDS4UuKrTTk=;
 b=MW7/lejI8Ni+q25Bdb5nP/0nlLSRcMzo0l04yr9y0FMZDdlFI5ncEuH5Pd6qzsxzcWg9
 sL6vzU5V9CMTWs5fDnoNYUPsCGRGwKsCSfbSaMUcbzCAv0Cn8NZiNgQb46Z9DD1J92qM
 zuJeX/MrTr1Vn37L6glaLFMtqoBGGwCPvrWx+dn6YDvkcfRFgJsBmWgeEbrqq8JTkGfJ
 V3/XgeU2S6AUsayfQZTTqzy75vfl58O5YeU0Tz0hNKiGodt/CseWn0AhRsHjNlrYK9oL
 hnuq7Ge0aGk03uoEEF+zlKsyng3R3NtkTH0Q1/PzhdmBxJkpNYfRL5dM52MtWGHZr5Wy 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 393eqyj1uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 15:46:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 274CD10002A;
        Thu, 10 Jun 2021 15:46:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 093B2228838;
        Thu, 10 Jun 2021 15:46:11 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 15:46:10 +0200
Subject: Re: [PATCH] ARM: dts: stm32: fix the Odyssey SoM eMMC VQMMC supply
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <YLj4AMTCi84yO9GO@nx64de-df6d00>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <af63b0d2-fce7-1e29-e36e-02da08f14d83@foss.st.com>
Date:   Thu, 10 Jun 2021 15:46:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YLj4AMTCi84yO9GO@nx64de-df6d00>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_07:2021-06-10,2021-06-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 6/3/21 5:40 PM, Grzegorz Szymaszek wrote:
> The Seeed SoM-STM32MP157C device tree had the eMMC’s (SDMMC2) VQMMC
> supply set to v3v3 (buck4), the same as the VMMC supply. That was
> incorrect, as on the SoM, the VQMMC supply is provided from vdd (buck3)
> instead.
> 
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>   arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> index 6cf49a0a9e69..b5601d270c8f 100644
> --- a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> @@ -269,7 +269,7 @@ &sdmmc2 {
>   	st,neg-edge;
>   	bus-width = <8>;
>   	vmmc-supply = <&v3v3>;
> -	vqmmc-supply = <&v3v3>;
> +	vqmmc-supply = <&vdd>;
>   	mmc-ddr-3_3v;
>   	status = "okay";
>   };
> 

Applied on stm32-next.

Thanks.
Alex
