Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80B43FAC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhJ2Kfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:35:53 -0400
Received: from mx.socionext.com ([202.248.49.38]:15999 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231721AbhJ2Kfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:35:51 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Oct 2021 19:33:22 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 3BABC207616C;
        Fri, 29 Oct 2021 19:33:22 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 29 Oct 2021 19:33:22 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id DAAC2B62AB;
        Fri, 29 Oct 2021 19:33:21 +0900 (JST)
Received: from [10.212.181.14] (unknown [10.212.181.14])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 6EA1EB6291;
        Fri, 29 Oct 2021 19:33:21 +0900 (JST)
Subject: Re: [PATCH v2 7/8] dt-bindings: phy: uniphier-ahci: Add bindings for
 Pro4 SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1634687888-23900-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1634687888-23900-8-git-send-email-hayashi.kunihiko@socionext.com>
 <YXsSPm1SdvaeDwbq@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <9db1cd5a-c4f0-a1d2-2681-e8c58ee540ee@socionext.com>
Date:   Fri, 29 Oct 2021 19:33:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YXsSPm1SdvaeDwbq@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2021/10/29 6:12, Rob Herring wrote:
> On Wed, Oct 20, 2021 at 08:58:07AM +0900, Kunihiko Hayashi wrote:
>> Update AHCI-PHY binding document for UniPhier Pro4 SoC. Add a compatible
>> string, clock and reset lines for the SoC to the document.
>>
>> Pro4 AHCI-PHY needs to control additional GIO clock line and reset lines
>> ("pm", "tx", and "rx").
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/phy/socionext,uniphier-ahci-phy.yaml    | 20
> ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git
> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>> index 745c525ce6b9..67415f7ebe8c 100644
>> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
> yaml
>> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
> yaml
>> @@ -16,6 +16,7 @@ maintainers:
>>   properties:
>>     compatible:
>>       enum:
>> +      - socionext,uniphier-pro4-ahci-phy
>>         - socionext,uniphier-pxs2-ahci-phy
>>         - socionext,uniphier-pxs3-ahci-phy
>>   
>> @@ -30,6 +31,9 @@ properties:
>>   
>>     clock-names:
>>       oneOf:
>> +      - items:          # for Pro4
>> +          - const: gio
>> +          - const: link
> 
> Add new entries on the end...
> 
>>         - items:          # for PXs2
>>             - const: link
> 
> So add 'gio' here.
> 
> And add 'minItems: 1' in this entry.
> 
> There's also an error in 'clocks' as it needs 'minItems: 1'

I see.
I'll add "minItems: 1", and fix the item order.

> 
>>         - items:          # for others
>> @@ -37,12 +41,20 @@ properties:
>>             - const: phy
>>   
>>     resets:
>> -    maxItems: 2
>> +    minItems: 2
>> +    maxItems: 5
>>   
>>     reset-names:
>> -    items:
>> -      - const: link
>> -      - const: phy
>> +    oneOf:
>> +      - items:          # for Pro4
>> +          - const: gio
>> +          - const: link
>> +          - const: pm
>> +          - const: tx
>> +          - const: rx
>> +      - items:          # for others
>> +          - const: link
>> +          - const: phy
>>   
>>   required:
>>     - compatible
>> -- 
>> 2.7.4

Thank you,

---
Best Regards
Kunihiko Hayashi
