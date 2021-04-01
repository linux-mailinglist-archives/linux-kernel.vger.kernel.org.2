Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF335103B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhDAHkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:40:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38854 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbhDAHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:39:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1317db29023664;
        Thu, 1 Apr 2021 02:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617262777;
        bh=9fskxeDKcFwVRSaKpjEcEev7N/dbj8ubzqBdyCt3hDI=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=v+bYs0YG4R2cmwX/Ti7eIlny+UGUEFj8cIoItLPvg4UUiYwj+O1xOEgont4eFNydD
         M8q9szqkcQHKttasOS6Ol3TpFE7RhIr0Dk0HhMGLvRkE9AKlXsinjAFtOAFvMyh3ZH
         f+mR+PoyQD46CFpxHXiA041AgwmYGelzEN3VgQN0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1317dbAi056025
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Apr 2021 02:39:37 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 1 Apr
 2021 02:39:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 1 Apr 2021 02:39:37 -0500
Received: from [10.250.234.178] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1317dYvP009919;
        Thu, 1 Apr 2021 02:39:35 -0500
Subject: Re: [Discussion] Uninitialized variable in wiz_mode_select()
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <colin.king@canonical.com>,
        <dan.carpenter@oracle.com>
References: <943b92c6ac291726cf0e6bd92e88f2110c14b74c.camel@gmail.com>
 <aaa035d2-95a7-00b3-ef76-1aa61c7f8da9@ti.com>
Message-ID: <0ac860d1-15b5-b314-c694-750db6274aa5@ti.com>
Date:   Thu, 1 Apr 2021 13:09:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aaa035d2-95a7-00b3-ef76-1aa61c7f8da9@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/04/21 1:08 pm, Kishon Vijay Abraham I wrote:
> Hi Usama,
> 
> On 01/04/21 1:03 pm, Muhammad Usama Anjum wrote:
>> Hi,
>>
>> `mode` remains uninitialized when `lane_phy_type` isn't PHY_TYPE_DP
>> or 
>> PHY_TYPE_QSGMII. I've checked the dtsi (k3-j721e-common-proc-
>> board.dts) 
>> and possible values of `lane_phy_type` are justPHY_TYPE_USB3 and 
>> PHY_TYPE_PCIE. If this is correct, the mode will remain uninitialized with
>> garbage value. `mode` should be initialized to what? It seems like it is highly 
>> implementation dependent.
>>
>> /drivers/phy/ti/phy-j721e-wiz.c: 344 in wiz_mode_select()
>> 338             for (i = 0; i < num_lanes; i++) {
>> 339                     if (wiz->lane_phy_type[i] == PHY_TYPE_DP)
>> 340                             mode = LANE_MODE_GEN1;
>> 341                     else if (wiz->lane_phy_type[i] == PHY_TYPE_QSGMII)
>> 342                             mode = LANE_MODE_GEN2;
>> 343     
>>>>>     CID 1503592:  Uninitialized variables  (UNINIT)
>>>>>     Using uninitialized value "mode" when calling "regmap_field_write".
>> 344                     ret = regmap_field_write(wiz->p_standard_mode[i], mode);
>> 345                     if (ret)
>> 346                             return ret;
>> 347             }
>> 348     
>> 349             return 0;
> 
> I've sent a follow-up patch fixing this.
> http://lor.kernel.org/r/20210331131417.15596-1-kishon@ti.com

Fixed a typo in the link
https://lore.kernel.org/linux-phy/20210331131417.15596-1-kishon@ti.com/

Thanks
Kishon
