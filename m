Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C800B3A9954
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhFPLfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:35:02 -0400
Received: from phobos.denx.de ([85.214.62.61]:54344 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhFPLe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:34:57 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E87AE8035B;
        Wed, 16 Jun 2021 13:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623843170;
        bh=T+Cs1AeQE7LkpU7A7afZ1a78WZrIIf6qmW2TwzpJZpo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MBct9gtyk7PwHbCNWV+gq0y6jsEiTjz63p9FrCk1tHcGtm+2K0F2veZl1fau6uZkt
         V9C24JhUjVF1bbjIcjXQmmZzQ0GlBlh+JogVkFnWVsxbfZosjFA1XEm2feUcyyUz5b
         BCfqcHihZsyek4WOcpmIWtMJ3WDwFHIx54s3ceki3sTdjStkoQVlZ5lrvjlg+k2dK3
         PJsVlkpK6bPEz7Pey79UCqPIt0t9NY4jK6DNl8anRHHZsvGMMb4gX3AyaP0KRsRFaG
         XoIeJq9o+7R02l9PdYRR1colKndQN+KOYM8nerYsFWT6omtRzoPNig5nLuBgThQz/N
         kHRrptdRZZMjg==
Subject: Re: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        kernel <kernel@dh-electronics.com>,
        "festevam@gmail.com" <festevam@gmail.com>
References: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
 <20210602195009.GA3870858@robh.at.kernel.org>
 <b765351a7c3542d2a66ab1168f1ff222@dh-electronics.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <bfbd70ca-b5a6-f7a7-4c7d-72ac86874227@denx.de>
Date:   Wed, 16 Jun 2021 13:32:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b765351a7c3542d2a66ab1168f1ff222@dh-electronics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 1:19 PM, Christoph Niedermaier wrote:
> Send reply also to Rob Herrings +dt email address:
> 
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, June 2, 2021 9:50 PM
> 
>> On Tue, May 25, 2021 at 04:30:01PM +0200, Christoph Niedermaier wrote:
>>> Add DH electronics DHCOM PicoITX and DHCOM DRC02 boards.
>>>
>>> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: robh+dt@kernel.org
>>> Cc: Shawn Guo <shawnguo@kernel.org>
>>> Cc: kernel@dh-electronics.com
>>> To: devicetree@vger.kernel.org
>>> ---
>>> V2: Remove line with fsl,imx6s on the DRC02 Board
>>> ---
>>>   Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> index fce2a8670b49..3c4ff79a3be7 100644
>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> @@ -407,6 +407,12 @@ properties:
>>>             - const: dfi,fs700e-m60
>>>             - const: fsl,imx6dl
>>>
>>> +      - description: i.MX6DL DHCOM PicoITX Board
>>> +        items:
>>> +          - const: dh,imx6dl-dhcom-picoitx
>>> +          - const: dh,imx6dl-dhcom-som
>>> +          - const: fsl,imx6dl
>>> +
>>>         - description: i.MX6DL Gateworks Ventana Boards
>>>           items:
>>>             - enum:
>>> @@ -458,6 +464,12 @@ properties:
>>>             - const: toradex,colibri_imx6dl          # Colibri iMX6 Module
>>>             - const: fsl,imx6dl
>>>
>>> +      - description: i.MX6S DHCOM DRC02 Board
>>> +        items:
>>> +          - const: dh,imx6s-dhcom-drc02
>>> +          - const: dh,imx6s-dhcom-som
>>> +          - const: fsl,imx6dl
>>
>> fsl,imx6s?
> 
> In the first version I had here an additional line with "fsl,imx6s",
> but currently the kernel isn't supporting that compatible. The i.MX6
> Solo is currently supported by "fsl,imx6dl". So my idea was to add
> both "fsl,imx6dl" and "fsl,imx6s" to match it maybe on a later kernel
> version. If there is no match with the Solo now, it will fall back to
> the i.MX6 DualLite. That is why I had both fsl,imx6s and fsl,imx6dl
> in that order. On Fabio's advice, I removed the line with "fsl,imx6s"
> in version 2.
> Is this what you meant by your comment?

I didn't notice that at first myself, but I think what Rob means is

- const: dh,imx6s-dhcom-drc02
- const: dh,imx6s-dhcom-som
- const: fsl,imx6dl <------ this should be consistent with the two above

that is

  - const: dh,imx6s-dhcom-drc02
  - const: dh,imx6s-dhcom-som
-- const: fsl,imx6dl
+- const: fsl,imx6s
               ^^^^^

But that is a bit odd here:
- The MX6S is MX6DL with one CPU core disabled.
- The DRC02 device can only house a SOM with MX6S and NOT with MX6DL
(due to some thermal design consideration or something).
- The kernel discerns the MX6S/MX6DL automatically based on the number 
of cores it reads from some register, therefore it only has the 
fsl,mx6dl compatible to cover both MX6S and MX6DL.
So, the closest fallback compatible for this device really is the MX6DL, 
i.e. fsl,imx6dl.

So I think this patch is correct as-is, no ?
