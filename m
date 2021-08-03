Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564093DED9C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhHCMJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:09:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23084 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235309AbhHCMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:09:00 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173C7Mli008274;
        Tue, 3 Aug 2021 14:08:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=swNErm7Zy2eWJjCHZJ99CaNs8YV9UEb1Ao/iPVAuRSU=;
 b=wuSl2Dc44SYCQ+bB5AJNpr0m8mogkCEw9zFkiX1Nx7jelbco4pD65t+B4TnHFBtGfPMx
 VvTr/utQPeYFevs2kMKP+BHx4grSk5738zDlNV8Y2tRm1DIc++Vrxr0GgNJvKhtA/N8j
 807mfenqKjU2eX7qxoJUBVUK4Y0KW38V//5D0ZJgCHKGOKWTRWfXnvrUgFfdE9rFq7XM
 S0ZNpSGnSHxG6C1gUgJCNhr/0bo6Z4rAQ7bcVQeHHWM58g6DVcUj/PjhINlzbB9YZAZt
 kVVvvZTHQjkMTsJmhMnjrQUCOZCJkAlgoF+uLYiV4hfuN36by6Du4rHpvzNziXVKG+op WA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a74mx88em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:08:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EFA1210002A;
        Tue,  3 Aug 2021 14:08:33 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E3212220F3F;
        Tue,  3 Aug 2021 14:08:33 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:08:33 +0200
Subject: Re: [PATCH v3 11/13] ARM: dts: sti: disable rng11 on the stih418
 platform
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210331204228.26107-1-avolmat@me.com>
 <20210331204228.26107-12-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <01885352-44d1-2997-f320-5f236140e8ac@foss.st.com>
Date:   Tue, 3 Aug 2021 14:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210331204228.26107-12-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-03,2021-08-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 3/31/21 10:42 PM, Alain Volmat wrote:
> The rng11 is not available on the STiH418 hence is disabled in the
> stih418.dtsi
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih418.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
> index a05e2278b448..39a249983496 100644
> --- a/arch/arm/boot/dts/stih418.dtsi
> +++ b/arch/arm/boot/dts/stih418.dtsi
> @@ -27,6 +27,10 @@
>  	};
>  
>  	soc {
> +		rng11: rng@8a8a000 {
> +			status = "disabled";
> +		};
> +
>  		usb2_picophy1: phy2@0 {
>  			compatible = "st,stih407-usb2-phy";
>  			reg = <0 0>;
> 
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
