Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D50834A3A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCZJGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:06:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8286 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229589AbhCZJFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:05:49 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12Q91f9o008067;
        Fri, 26 Mar 2021 10:05:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=SfGDczMFdVs4NsLs7fVrUK95O9Wm/idmWV1zG/3B7ks=;
 b=jL43Rz2N0zLtHTkJh3ufuzEUV8+Z3TbBptIr1IKRqDN8NAiocMg+wO/0XU2hGOyNDTwW
 ji0JrhS0pLXUYBZWbzfUe4zCkA4B5smB/bpIbu1BRy37/gKzIgYmcHW+3MjOekBfu7St
 +q7Odmf1I+Vxhl+x5/cxHpAi37/K5p9/CPuFZLWZVAunbLZSc00vGWhtHFFLfDsMBufx
 5tAJqD6zymWVKRgUiyp7ZUFhcOST0nnyDAAtKv8fEvUiVNXv7PPjlQUvEJ/6C99kbPBv
 iKsINgVvkqEB7VtkWTM2NLgG8bxpW2PuFoTM6SF0eP5EuQXhC4FCK806xy2XFqWfvED8 rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37h136320v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 10:05:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A44A100034;
        Fri, 26 Mar 2021 10:05:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 323C924187A;
        Fri, 26 Mar 2021 10:05:34 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Mar
 2021 10:05:33 +0100
Subject: Re: [PATCH 1/2] dt-bindings: phy: add vbus-supply optional property
 to phy-stm32-usbphyc
To:     Rob Herring <robh@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210317160954.15487-1-amelie.delaunay@foss.st.com>
 <20210317160954.15487-2-amelie.delaunay@foss.st.com>
 <20210326002851.GA2031564@robh.at.kernel.org>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <5c0d0bc5-1243-fcda-4578-da6cad80c53c@foss.st.com>
Date:   Fri, 26 Mar 2021 10:05:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210326002851.GA2031564@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_02:2021-03-26,2021-03-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/26/21 1:28 AM, Rob Herring wrote:
> On Wed, Mar 17, 2021 at 05:09:53PM +0100, Amelie Delaunay wrote:
>> This patch adds vbus-supply optional property to phy sub-nodes.
>> A regulator for USB VBUS may be needed for host mode.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
>> index 018cc1246ee1..ad2378c30334 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
>> +++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
>> @@ -71,6 +71,9 @@ patternProperties:
>>         phy-supply:
>>           description: regulator providing 3V3 power supply to the PHY.
>>   
>> +      vbus-supply:
>> +        description: regulator providing 5V Vbus to the USB connector.
> 
> Unless Vbus is powering the phy, then this only belongs in the USB
> connector node.
> 

Do you mean I should declare a connector node as a child of the phy node 
and get the vbus-supply property from this connector node ?

In case of a on-board autonomous hub between the phy and the connectors, 
so no driver to drive it nor to get the vbus-supply property to provide 
VBUS to the hub, then the connectors, how to use connector ?

[USB controller]===[USB PHY]===[(USB HUB)]===|> USB A connector
                               /              |> USB A connector
                             VBUS             |> USB A connector
                                              |> USB A connector

Please advise.

Regards,
Amelie

>> +
>>         "#phy-cells":
>>           enum: [ 0x0, 0x1 ]
>>   
>> -- 
>> 2.17.1
>>
