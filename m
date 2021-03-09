Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2578E33250A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCIMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:13:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50100 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhCIMNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:13:44 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129CDavd119205;
        Tue, 9 Mar 2021 06:13:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615292016;
        bh=NT3U539wn8PIxN0x0E+OPu7W5tyhAjByxTd2uPdsmVw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sDaPthwxPrCaV3ndAcZ+krDWkIaLiuJsxPVO7BSWCkpe8ZrVONq48dhJW9k5iSWtj
         /7whnlmBBnuKndnhQY2oHx7sxTko3xdDhKkSRkefOLmBM8/Oza7VrLI5Tg+uj6Pwqk
         6P+1Hx4cFWtsmEU+FP4QxubhAko/P0xPKhBqeRoA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129CDaq3044823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 06:13:36 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 06:13:35 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Mar 2021 06:13:35 -0600
Received: from [10.250.234.4] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129CDWxG005388;
        Tue, 9 Mar 2021 06:13:33 -0600
Subject: Re: [PATCH 3/9] phy: ti: j721e-wiz: Don't configure wiz if its
 already configured
To:     Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20201103035556.21260-1-kishon@ti.com>
 <20201103035556.21260-4-kishon@ti.com> <20201116073029.GI7499@vkoul-mobl>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <91c9433f-02c0-b440-3fc4-a9d757cc1b91@ti.com>
Date:   Tue, 9 Mar 2021 17:43:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116073029.GI7499@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 16/11/20 1:00 pm, Vinod Koul wrote:
> On 03-11-20, 09:25, Kishon Vijay Abraham I wrote:
>> From: Faiz Abbas <faiz_abbas@ti.com>
>>
>> Serdes lanes might be shared between multiple cores in some usecases
>> and its not possible to lock PLLs for both the lanes independently
>> by the two cores. This requires a bootloader to configure both the
>> lanes at early boot time.
>>
>> To handle this case, skip all configuration if any of the lanes has
>> already been enabled.
>>
>> While we are here, also fix the wiz_init() to be called before the
>> of_platform_device_create() call.
> 
> Let's do two patches for these two issues :-)
> 
> Other than that, change lgtm, with exception of minor nit
> 
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/phy/ti/phy-j721e-wiz.c | 36 +++++++++++++++++++++-------------
>>  1 file changed, 22 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
>> index d57d29382ce4..9786e8aec252 100644
>> --- a/drivers/phy/ti/phy-j721e-wiz.c
>> +++ b/drivers/phy/ti/phy-j721e-wiz.c
>> @@ -816,13 +816,14 @@ static int wiz_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	struct device_node *node = dev->of_node;
>>  	struct platform_device *serdes_pdev;
>> +	bool already_configured = false;
>>  	struct device_node *child_node;
>>  	struct regmap *regmap;
>>  	struct resource res;
>>  	void __iomem *base;
>>  	struct wiz *wiz;
>>  	u32 num_lanes;
>> -	int ret;
>> +	int ret, val, i;
>>  
>>  	wiz = devm_kzalloc(dev, sizeof(*wiz), GFP_KERNEL);
>>  	if (!wiz)
>> @@ -944,10 +945,26 @@ static int wiz_probe(struct platform_device *pdev)
>>  		goto err_get_sync;
>>  	}
>>  
>> -	ret = wiz_clock_init(wiz, node);
>> -	if (ret < 0) {
>> -		dev_warn(dev, "Failed to initialize clocks\n");
>> -		goto err_get_sync;
>> +	for (i = 0; i < wiz->num_lanes; i++) {
>> +		regmap_field_read(wiz->p_enable[i], &val);
>> +		if (val & (P_ENABLE | P_ENABLE_FORCE)) {
>> +			already_configured = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!already_configured) {
> 
> do you really need this variable and check, why not move the below into
> precceding block and do wiz_clock_init() and wiz_init() inside the
> if condition and drop the variable

Don't see a clean way to do it in the preceding block. So we have "N"
lanes and even if any one of the lanes is already configured, the
following block has to be executed once.

Thanks
Kishon
