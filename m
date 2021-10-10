Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE07F428431
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 01:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhJJX5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 19:57:35 -0400
Received: from mx.socionext.com ([202.248.49.38]:24769 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhJJX5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 19:57:34 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Oct 2021 08:55:34 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 331EB2058B40;
        Mon, 11 Oct 2021 08:55:34 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 11 Oct 2021 08:55:34 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id BDCB8C1E11;
        Mon, 11 Oct 2021 08:55:33 +0900 (JST)
Received: from [10.212.182.24] (unknown [10.212.182.24])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 466E1B62B3;
        Mon, 11 Oct 2021 08:55:33 +0900 (JST)
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: uniphier: Add clock binding
 for SoC-glue
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
References: <1633518555-8195-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1633518555-8195-5-git-send-email-hayashi.kunihiko@socionext.com>
 <YV395BTH/gqcuDJH@robh.at.kernel.org>
 <f2138a98-9740-d1de-5dc9-e14a68fa509b@socionext.com>
 <CAL_JsqL8N+h7bciDt=4fMHyAP=DL=YikpaTh2v4q383XVXH2AA@mail.gmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <1fe99277-10e0-0149-cef5-e839bd2515bb@socionext.com>
Date:   Mon, 11 Oct 2021 08:55:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL8N+h7bciDt=4fMHyAP=DL=YikpaTh2v4q383XVXH2AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/09 4:20, Rob Herring wrote:
> On Thu, Oct 7, 2021 at 3:50 AM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> Hi Rob,
>>
>> On 2021/10/07 4:49, Rob Herring wrote:
>>> On Wed, Oct 06, 2021 at 08:09:14PM +0900, Kunihiko Hayashi wrote:
>>>> Update binding document for clocks implemented in SoC-glue.
>>>>
>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> ---
>>>>    .../bindings/clock/socionext,uniphier-clock.yaml         | 16
>>> ++++++++++++++++
>>>>    1 file changed, 16 insertions(+)
>>>>
>>>> diff --git
>>> a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>>> b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>>>> index ee8d16a8019e..05a9d1f89756 100644
>>>> ---
>>> a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>>>> +++
>>> b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>>>> @@ -46,6 +46,9 @@ properties:
>>>>              - socionext,uniphier-ld20-peri-clock
>>>>              - socionext,uniphier-pxs3-peri-clock
>>>>              - socionext,uniphier-nx1-peri-clock
>>>> +      - description: SoC-glue clock
>>>> +        enum:
>>>> +          - socionext,uniphier-pro4-sg-clock
>>>>
>>>>      "#clock-cells":
>>>>        const: 1
>>>> @@ -95,3 +98,16 @@ examples:
>>>>
>>>>            // other nodes ...
>>>>        };
>>>> +
>>>> +  - |
>>>> +    soc-glue@5f800000 {
>>>> +        compatible = "socionext,uniphier-sysctrl", "simple-mfd",
>>> "syscon";
>>>> +        reg = <0x5f800000 0x2000>;
>>>> +
>>>> +        clock {
>>>> +            compatible = "socionext,uniphier-pro4-sg-clock";
>>>> +            #clock-cells = <1>;
>>>> +        };
>>>> +
>>>> +        // other nodes ...
>>>> +    };
>>>
>>> What's the value of this 2nd example? It's just a different compatible
>>> string.
>> Following the previous three examples in the document, it describes the
>> difference between the parent nodes that place the clock.
>>
>> They are common to be child nodes of "syscon", and the definition of the
>> parent node is not in this document.
>> Should I put them together in a common example?
> 
> I'd just drop the example.
I see. I'd drop the example in next.

Thank you,

---
Best Regards
Kunihiko Hayashi
