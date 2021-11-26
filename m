Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B185F45EB89
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376841AbhKZKbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:31:17 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35062 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377229AbhKZK3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:29:16 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AQALNMb003409;
        Fri, 26 Nov 2021 11:25:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=dbwGfIwnUU/8KIQMSbt8DZOHk6GsjPaWZ736Ald/Wn8=;
 b=Z8HoQGniG4HFI+CncknYRDT1NE32SATiqwbJ9fiZToFiMRRCkGNjUK08Cyd55X+Qdl13
 rC2YuJy0WHbJKk2WjAT2IJGIDxbqhXPEM+U+Ae7BUxqkHoegh/O9cStSfNQjJozxsNZ2
 qArwUdqAkr4gpVTOXfxl+1J7Mqwg6RCiwDu+g7VJRI5FZRLPzDBE2I8sMqwtv4XVKvY4
 bv5yaKMJOsKoV7hLa8wpd2hF7sktJQ58aaXEhrmcN3A339xFPklnQrlU7BBXCTu/KrX7
 WomZvZxPYEc9ULWqkzwdt5hGPVatG9OZXcRiL4r3Hab949H7OkNeYULb894UAphueMqm Jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cjqsk9ywf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 11:25:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F18710002A;
        Fri, 26 Nov 2021 11:25:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1EEEB222C80;
        Fri, 26 Nov 2021 11:25:30 +0100 (CET)
Received: from lmecxl0577.lme.st.com (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 26 Nov
 2021 11:25:28 +0100
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: stm32: i2s: add
 audio-graph-card port
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@foss.st.com>, <alain.volmat@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <amelie.delaunay@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <devicetree@vger.kernel.org>, <arnaud.pouliquen@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
 <20211125144053.774-2-olivier.moysan@foss.st.com>
 <1637875562.357461.2858318.nullmailer@robh.at.kernel.org>
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
Message-ID: <237f56b3-0597-2526-a182-f1fbdd327338@foss.st.com>
Date:   Fri, 26 Nov 2021 11:25:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637875562.357461.2858318.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_03,2021-11-25_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 11/25/21 10:26 PM, Rob Herring wrote:
> On Thu, 25 Nov 2021 15:40:50 +0100, Olivier Moysan wrote:
>> The STM2 I2S DAI can be connected via the audio-graph-card.
>> Add port entry into the bindings.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1559750
> 
> 
> audio-controller@4000b000: 'port' does not match any of the regexes: '^port@[0-9]', 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/stm32mp157a-dk1.dt.yaml
> 	arch/arm/boot/dts/stm32mp157c-dk2.dt.yaml
> 

This warning is not a new one.

The i2s2 node in stm32mp15xx-dkx.dtsi would require the following binding:
port:
	$ref: audio-graph-port.yaml#
	unevaluatedProperties: false

However the spi binding requires to introduce a unit address:
patternProperties:
   '^port@[0-9]':
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false

The warning can be removed by re-ordering the bindings patches in the 
serie, as "additionalProperties: true" makes the check more tolerant on 
extra properties.
The patch "ASoC: dt-bindings: stm32: i2s: add audio-graph-card port" can 
even be merely dropped.
So, I suggest to resend the serie without audio-graph-card patch.

Does it sound too permissive to you ?

Thanks
Olivier
