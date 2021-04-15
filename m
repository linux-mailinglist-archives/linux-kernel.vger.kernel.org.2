Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5110C360903
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhDOMND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:13:03 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56190 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231590AbhDOMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:13:02 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FCAoFj023982;
        Thu, 15 Apr 2021 14:12:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=9LcfNvL3q1nqjhvUfDTxZXWWF0n6sg5Qxq9jRLUkPiY=;
 b=PPvxpkdQ5nKGK1PR3Mid7VGQh5CocddyDY2CkHpeiNmbgwOsZ1TttZIeTwtSgFUfQhAT
 Pmr+99V8UGGaHfWnzhF3arcDvhsNqr/NPUCPqG9clAFnft6fAt9ADFcQJKMPtOoRF2dw
 0a2ywhRjkf2ToXR7NJ8RpysyaS6Fgo4eEvNjoOZ0OOjbL5oezcAcndp364Ygvc/qwUZY
 ENBB8393ZCm4bPQgXrJRrXdWcHKjyT53y3nHpwGn01k6U1YF43zXduXMUEiyR73qYGJC
 KPkNnpGWW5/IxnpVgAaokporDItYeXKYcZPyp3bnyJO4mMYuKplgSYYPG0X3vqNizQDR Wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xes0tvug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 14:12:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 29F5D10002A;
        Thu, 15 Apr 2021 14:12:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 26D9722D608;
        Thu, 15 Apr 2021 14:12:20 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr
 2021 14:12:19 +0200
Subject: Re: [PATCH 10/13] dt-bindings: mfd: add vref_ddr-supply to st,stpmic1
 yaml
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <kuba@kernel.org>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-11-alexandre.torgue@foss.st.com>
 <9fc27672-765b-9bd3-bb0a-d9159cb7d502@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <906ea3e5-0aaa-2307-e6fb-aaac1a5e5d00@foss.st.com>
Date:   Thu, 15 Apr 2021 14:12:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9fc27672-765b-9bd3-bb0a-d9159cb7d502@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_04:2021-04-15,2021-04-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad

On 4/15/21 12:51 PM, Ahmad Fatoum wrote:
> Hi,
> 
> On 15.04.21 12:10, Alexandre Torgue wrote:
>> Add vref_ddr-supply to the STPMIC1 regulators supplies pattern
>> list.
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>> index 305123e74a58..ffc32d209496 100644
>> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>> @@ -184,7 +184,7 @@ properties:
>>           additionalProperties: false
>>   
>>       patternProperties:
>> -      "^(buck[1-4]|ldo[1-6]|boost|pwr_sw[1-2])-supply$":
>> +      "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])-supply$":
> 
> IIRC, vref-ddr was a hack because a change in the regulator core broke
> the STM32MP1 boards. I believe vref-ddr should be removed altogether
> instead. It's supplied from BUCK2IN, which is already in the binding,
> so it's redundant.

Correct I forgot this point. We got random crash without this 
vddr_ref_supply but I don't know if regulator FW has been updated to fix 
it. If yes, I'll drop this one and remove
vddr_ref_supply from DT file.

> 
> Cheers,
> Ahmad
> 
>>           description: STPMIC1 voltage regulators supplies
>>   
>>         "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$":
>>
> 
