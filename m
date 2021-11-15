Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA0450287
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbhKOK3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:29:34 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48346 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231140AbhKOK3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:29:13 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AF8sjc7006661;
        Mon, 15 Nov 2021 11:25:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=OBTHaDPVAeUyWjvL19tyCYUzLLTVfgrUYyMf7H/p9Ow=;
 b=nVlBUXxLNUBPS9t4Q6GA2ogtF7ORLFRmgtuAOJYdbR/1Yr/HSlDuKFG+kXWaZkeKruH0
 KJeaJqMl2cSNjrGBAVUOrMAOpjqGW69blIda/p6xpOAcQhfC5p6fGuwkhmTN6BR3tsK/
 BGnn/1hh3SvlCr2F3tUwMpefNweeTDNUuy4duYrQ+8mLrCaG+rbh2otl+a9PNaajWdG/
 jQrY/JC8O/RdPPGwyTB+DDLU8lRpgabhsgrtFcsiLmi1j0h5Q0OTd7ZcdSmQog1TCjHU
 VrymE4bszjBgKhiS+QpHj4uNBObsb+6HwK/eNreU+SPWrhCb+MgqqqgfsgZ3V/BXR+Yx Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cbmf40kc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 11:25:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EB2DA10002A;
        Mon, 15 Nov 2021 11:25:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1CB02291B8;
        Mon, 15 Nov 2021 11:25:51 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 15 Nov
 2021 11:25:50 +0100
Subject: Re: [PATCH 1/1] phy: stm32: fix st,slow-hs-slew-rate with
 st,decrease-hs-slew-rate
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20211026154817.198937-1-amelie.delaunay@foss.st.com>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <d4e76549-4f27-6043-64c1-411261b8a5aa@foss.st.com>
Date:   Mon, 15 Nov 2021 11:25:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211026154817.198937-1-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_09,2021-11-12_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kind reminder.

Regards,
Amelie

On 10/26/21 5:48 PM, Amelie Delaunay wrote:
> st,decrease-hs-slew-rate is described in phy-stm32-usbphyc.yaml. Then
> fix the property name in driver.
> 
> Fixes: 2f5e9f815a2f ("phy: stm32: add phy tuning support")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>   drivers/phy/st/phy-stm32-usbphyc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
> index 7df6a63ad37b..e4f4a9be5132 100644
> --- a/drivers/phy/st/phy-stm32-usbphyc.c
> +++ b/drivers/phy/st/phy-stm32-usbphyc.c
> @@ -478,7 +478,7 @@ static void stm32_usbphyc_phy_tuning(struct stm32_usbphyc *usbphyc,
>   	if (!of_property_read_bool(np, "st,no-lsfs-fb-cap"))
>   		usbphyc_phy->tune |= LFSCAPEN;
>   
> -	if (of_property_read_bool(np, "st,slow-hs-slew-rate"))
> +	if (of_property_read_bool(np, "st,decrease-hs-slew-rate"))
>   		usbphyc_phy->tune |= HSDRVSLEW;
>   
>   	ret = of_property_read_u32(np, "st,tune-hs-dc-level", &val);
> 
