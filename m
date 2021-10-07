Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD6424F73
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbhJGIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 04:52:04 -0400
Received: from mx.socionext.com ([202.248.49.38]:12695 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240314AbhJGIv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:51:59 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Oct 2021 17:50:04 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 556A92059034;
        Thu,  7 Oct 2021 17:50:04 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 7 Oct 2021 17:50:04 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id CBDFFB6390;
        Thu,  7 Oct 2021 17:50:03 +0900 (JST)
Received: from [10.212.182.138] (unknown [10.212.182.138])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 6A26EB62B3;
        Thu,  7 Oct 2021 17:50:03 +0900 (JST)
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: uniphier: Add clock binding
 for SoC-glue
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1633518555-8195-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1633518555-8195-5-git-send-email-hayashi.kunihiko@socionext.com>
 <YV395BTH/gqcuDJH@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <f2138a98-9740-d1de-5dc9-e14a68fa509b@socionext.com>
Date:   Thu, 7 Oct 2021 17:50:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YV395BTH/gqcuDJH@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2021/10/07 4:49, Rob Herring wrote:
> On Wed, Oct 06, 2021 at 08:09:14PM +0900, Kunihiko Hayashi wrote:
>> Update binding document for clocks implemented in SoC-glue.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/clock/socionext,uniphier-clock.yaml         | 16
> ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git
> a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>> index ee8d16a8019e..05a9d1f89756 100644
>> ---
> a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>> +++
> b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>> @@ -46,6 +46,9 @@ properties:
>>             - socionext,uniphier-ld20-peri-clock
>>             - socionext,uniphier-pxs3-peri-clock
>>             - socionext,uniphier-nx1-peri-clock
>> +      - description: SoC-glue clock
>> +        enum:
>> +          - socionext,uniphier-pro4-sg-clock
>>   
>>     "#clock-cells":
>>       const: 1
>> @@ -95,3 +98,16 @@ examples:
>>   
>>           // other nodes ...
>>       };
>> +
>> +  - |
>> +    soc-glue@5f800000 {
>> +        compatible = "socionext,uniphier-sysctrl", "simple-mfd",
> "syscon";
>> +        reg = <0x5f800000 0x2000>;
>> +
>> +        clock {
>> +            compatible = "socionext,uniphier-pro4-sg-clock";
>> +            #clock-cells = <1>;
>> +        };
>> +
>> +        // other nodes ...
>> +    };
> 
> What's the value of this 2nd example? It's just a different compatible
> string.
Following the previous three examples in the document, it describes the
difference between the parent nodes that place the clock.

They are common to be child nodes of "syscon", and the definition of the
parent node is not in this document.
Should I put them together in a common example?

Thank you,

---
Best Regards
Kunihiko Hayashi
