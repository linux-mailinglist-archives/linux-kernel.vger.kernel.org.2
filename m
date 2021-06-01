Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB039705C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhFAJ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:29:17 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56616 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233182AbhFAJ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:29:08 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1519QRn8002805;
        Tue, 1 Jun 2021 11:27:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=BsDpJoLHvDvSIYjWJaYxAmYm+9EbdYsJJXc+10150Fk=;
 b=PfDoER9oXuNCgWnYOKszZTpqmVokmPoa8D1Jpn4V6CVbfgjTgDQwYXVn26WmZ2HFbcC0
 XY37NKR73VVnTZfrI9klV4NA6eQ2fsI1qACyqsQL1GbNE46lfgJa/vgn+VW9lSp9PMh+
 65FkfwCs8Xn/7NeHtwk5R/dPbbI58ne+p8RvO7ld1qE5udyAt1m1+foemK3Zkbe/lztp
 56JbDSPxQcQMd51CgeVPYSr3KEeGR5HKXrHwGlraeaglWDZrQ8N6ruCmyj9GbJgekpEX
 r+PV6MmDl9/67kCCeq/ZkGxmfPI8T0jXjd4fg30rBllmJMh795rWGG75yQa7SPsyYOHi gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38w49ckk1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 11:27:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E55F210002A;
        Tue,  1 Jun 2021 11:27:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CE7D4218112;
        Tue,  1 Jun 2021 11:27:04 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Jun
 2021 11:27:04 +0200
Subject: Re: [PATCH] ARM: dts: stm32: fix stm32mp157c-odyssey card detect pin
To:     Grzegorz Szymaszek <gszymaszek@short.pl>
CC:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        =?UTF-8?Q?Marcin_S=c5=82oniewski?= <marcin.sloniewski@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <YHH9+Xrn5Quge4Jt@nx64de-df6d00>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <74029811-6417-7c0b-1abd-6ea15de7f1ae@foss.st.com>
Date:   Tue, 1 Jun 2021 11:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YHH9+Xrn5Quge4Jt@nx64de-df6d00>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_05:2021-05-31,2021-06-01 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/21 9:35 PM, Grzegorz Szymaszek wrote:
> The microSD card detect pin is physically connected to the MPU pin PI3.
> The Device Tree configuration of the card detect pin was wrong—it was
> set to pin PB7 instead. If such configuration was used, the kernel would
> hang on “Waiting for root device” when booting from a microSD card.
> 
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>   arch/arm/boot/dts/stm32mp157c-odyssey.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> index a7ffec8f1516..be1dd5e9e744 100644
> --- a/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> @@ -64,7 +64,7 @@ &sdmmc1 {
>   	pinctrl-0 = <&sdmmc1_b4_pins_a>;
>   	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
>   	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> -	cd-gpios = <&gpiob 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +	cd-gpios = <&gpioi 3 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>   	disable-wp;
>   	st,neg-edge;
>   	bus-width = <4>;
> 

Hi Grzegorz

Applied on stm32-next.

Thanks.
Alex


