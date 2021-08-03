Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5473DED9E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhHCMJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:09:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24742 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235309AbhHCMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:09:20 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173C7GEA008194;
        Tue, 3 Aug 2021 14:08:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=YP6GeDkhv23N3H3s/t4ZBoWEGwnmTPCec20LHUS888g=;
 b=FZeveeDx+YrFSwHCEK5v9/lH3eqLLt6Xrgh9zq+JJNSuoZLZruXmidrqGvRu2pwsza3k
 n0GbWGuVgNuC7G5+7ANBE8nfmWZ8mGqteHM3wiehglbXZXf9+PbyQANmV/LGWT71yO6l
 TVzKHZjHepmJ3mLmLeXDIOeX/qIhFqk1jxRRoA1wGHREDGSHa0f+Askexyr/3ecB0qsG
 /+5rjrFrgHsKKK6XPxfHaZyuhx6b7qlKpmOTUXtreZrrD+S+HDGTs9R3iRVZ/LXGs7qh
 ouDkeE6Bxf/2m+9tx7kkzfJI9K9YNjWzKJO9esZXp+iFOuIkL/KvTtwo1EMd6zStQIWS ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a74mx88fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:08:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6BFF810002A;
        Tue,  3 Aug 2021 14:08:49 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F0B6220F3F;
        Tue,  3 Aug 2021 14:08:49 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:08:48 +0200
Subject: Re: [PATCH v3 12/13] ARM: dts: sti: add the thermal sensor node
 within stih418
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210331204228.26107-1-avolmat@me.com>
 <20210331204228.26107-13-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <ca0bc89c-2a04-f1eb-de3a-01b271692df8@foss.st.com>
Date:   Tue, 3 Aug 2021 14:08:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210331204228.26107-13-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-03,2021-08-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 3/31/21 10:42 PM, Alain Volmat wrote:
> The STiH418 embedded the same sensor as the STiH410.
> This commit adds the corresponding node, relying on the st_thermal
> driver.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih418.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
> index 39a249983496..97eda4392fbe 100644
> --- a/arch/arm/boot/dts/stih418.dtsi
> +++ b/arch/arm/boot/dts/stih418.dtsi
> @@ -108,5 +108,13 @@
>  			assigned-clock-parents = <&clk_s_c0_pll1 0>;
>  			assigned-clock-rates = <200000000>;
>  		};
> +
> +		thermal@91a0000 {
> +			compatible = "st,stih407-thermal";
> +			reg = <0x91a0000 0x28>;
> +			clock-names = "thermal";
> +			clocks = <&clk_sysin>;
> +			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
> +		};
>  	};
>  };
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
