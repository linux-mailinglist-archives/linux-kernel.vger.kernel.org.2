Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE73CD5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbhGSNAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:00:15 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:37758 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239261AbhGSNAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:00:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JDbF3U028393;
        Mon, 19 Jul 2021 15:40:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : from : to
 : cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=OPnz7GgLa8oBsVio/uq8oZKdX3WKnEdHcpPLC45ORr8=;
 b=HPl9cSj3lPAOMW5xhJapuhSPgSSZI1ke9xYFQDeEyz7o7kv6CX28N+OD9Fb68S7YlrBY
 RVkMPwlhGNJQYylUg+bwQOgdqOlVP/KiNGPzOW3jjQxz2eDOx6lvDNZI01HdUR1/KuIN
 2VLboleqDLg+/G99BvE8uC9brDf01o72QBXyYT3wrKqyzpOZ8y/1ZmG+TljyOUZJXNpb
 NbLbDatueUEKVAoPxyBlKu4NMhAdmJx0jfgzeEoZ+7g1hnGDHCS3d4WZR6NgQUTQooRK
 ZHPAFmeUo6mV5t9GG7R3vQ3SGAWdxmjnciupKxlxYQEt/0XTQwwSDR9ODrZO8669Pubz ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39w40eaag8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 15:40:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6222810002A;
        Mon, 19 Jul 2021 15:40:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 360A42291C7;
        Mon, 19 Jul 2021 15:40:40 +0200 (CEST)
Received: from lmecxl0993.lme.st.com (10.75.127.46) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 15:40:39 +0200
Subject: Re: [PATCH] drm/stm: dsi: compute the transition time from LP to HS
 and back
From:   Philippe CORNU <philippe.cornu@foss.st.com>
To:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20210713144941.3599-1-antonio.borneo@foss.st.com>
 <fab62613-59a4-5d0b-4ff8-3900ef70a49d@foss.st.com>
Message-ID: <780cf379-3b7a-3e75-0803-0ebd30e649ea@foss.st.com>
Date:   Mon, 19 Jul 2021 15:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fab62613-59a4-5d0b-4ff8-3900ef70a49d@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_05:2021-07-19,2021-07-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/21 6:47 PM, Philippe CORNU wrote:
> Hi Antonio,
> 
> On 7/13/21 4:49 PM, Antonio Borneo wrote:
>> The driver uses a conservative set of hardcoded values for the
>> maximum time delay of the transitions between LP and HS, either
>> for data and clock lanes.
>>
>> By using the info in STM32MP157 datasheet, valid also for other ST
>> devices, compute the actual delay from the lane's bps.
>>
>> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
>> ---
>> To: Yannick Fertre <yannick.fertre@foss.st.com>
>> To: Philippe Cornu <philippe.cornu@foss.st.com>
>> To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> To: David Airlie <airlied@linux.ie>
>> To: Daniel Vetter <daniel@ffwll.ch>
>> To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> To: Alexandre Torgue <alexandre.torgue@foss.st.com>
>> To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> To: dri-devel@lists.freedesktop.org
>> To: linux-stm32@st-md-mailman.stormreply.com
>> To: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>>   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c 
>> b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
>> index 8399d337589d..32cb41b2202f 100644
>> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
>> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
>> @@ -309,14 +309,23 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const 
>> struct drm_display_mode *mode,
>>       return 0;
>>   }
>> +#define DSI_PHY_DELAY(fp, vp, mbps) DIV_ROUND_UP((fp) * (mbps) + 1000 
>> * (vp), 8000)
>> +
>>   static int
>>   dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
>>                  struct dw_mipi_dsi_dphy_timing *timing)
>>   {
>> -    timing->clk_hs2lp = 0x40;
>> -    timing->clk_lp2hs = 0x40;
>> -    timing->data_hs2lp = 0x40;
>> -    timing->data_lp2hs = 0x40;
>> +    /*
>> +     * From STM32MP157 datasheet, valid for STM32F469, STM32F7x9, 
>> STM32H747
>> +     * phy_clkhs2lp_time = (272+136*UI)/(8*UI)
>> +     * phy_clklp2hs_time = (512+40*UI)/(8*UI)
>> +     * phy_hs2lp_time = (192+64*UI)/(8*UI)
>> +     * phy_lp2hs_time = (256+32*UI)/(8*UI)
>> +     */
>> +    timing->clk_hs2lp = DSI_PHY_DELAY(272, 136, lane_mbps);
>> +    timing->clk_lp2hs = DSI_PHY_DELAY(512, 40, lane_mbps);
>> +    timing->data_hs2lp = DSI_PHY_DELAY(192, 64, lane_mbps);
>> +    timing->data_lp2hs = DSI_PHY_DELAY(256, 32, lane_mbps);
> 
> Many thanks for your patch.
> 
> Reviewed-by: Philippe Cornu <philippe.cornu@foss.st.com>
> Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
> 
> I will apply it on drm-misc-next early next week,
> 
> Philippe :-)
> 
>>       return 0;
>>   }
>>
>> base-commit: 35d283658a6196b2057be562096610c6793e1219
>>

Applied on drm-misc-next.
Many thanks for your patch,
Philippe :-)
