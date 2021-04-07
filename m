Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD990356130
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbhDGCES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:04:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16004 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhDGCER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:04:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFSL86MN4zPnsj;
        Wed,  7 Apr 2021 10:01:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.202) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 10:04:02 +0800
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'ports' does not match any of the regexes
To:     Rob Herring <robh@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20210331091616.2306-1-thunder.leizhen@huawei.com>
 <20210331091616.2306-3-thunder.leizhen@huawei.com>
 <20210401202056.GA947212@robh.at.kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a1aed23d-a9d2-5e05-b1f5-3b48ac8d17f1@huawei.com>
Date:   Wed, 7 Apr 2021 10:04:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210401202056.GA947212@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/2 4:20, Rob Herring wrote:
> On Wed, Mar 31, 2021 at 05:16:16PM +0800, Zhen Lei wrote:
>> Currently, if there are more than two ports, or if there is only one port
>> but other properties(such as "#address-cells") is required, these ports
>> are placed under the "ports" node. So add the schema of property "ports".
> 
> A given binding should just use 'ports' or 'port' depending on it's 
> need. Supporting both forms is needless complexity.

Right, I'll adjust this patch again.

> 
>> Otherwise, warnings similar to the following will be reported:
>> arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dt.yaml: \
>> sound@ec500000: 'ports' does not match any of the regexes: \
>> '^rcar_sound,ctu$', '^rcar_sound,dai$', '^rcar_sound,dvc$', ...
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
>> index 384191ee497f534..a42992fa687d3f3 100644
>> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
>> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
>> @@ -115,6 +115,11 @@ properties:
>>      $ref: audio-graph-port.yaml#
>>      unevaluatedProperties: false
>>  
>> +  ports:
> 
>        $ref: /schemas/graph.yaml#/properties/ports

OK, thanks

> 
>> +    patternProperties:
>> +      '^port@[0-9]':
>> +        $ref: "#/properties/port"
> 
> Then this should be: $ref: audio-graph-port.yaml#

OK, thanks

> 
> Also, what each port is should be defined, but that's a separate 
> problem.
> 
>> +
>>  # use patternProperties to avoid naming "xxx,yyy" issue
>>  patternProperties:
>>    "^rcar_sound,dvc$":
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

