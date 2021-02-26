Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B36326311
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBZNEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:04:24 -0500
Received: from smtpcmd03117.aruba.it ([62.149.158.117]:47112 "EHLO
        smtpcmd03117.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhBZNEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:04:14 -0500
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2021 08:04:13 EST
Received: from [192.168.1.133] ([79.10.42.7])
        by Aruba Outgoing Smtp  with ESMTPA
        id FccKlzwPoGnOmFccLlJn3t; Fri, 26 Feb 2021 13:53:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1614343997; bh=2rMVWXF8lNyJSU6nmJKiXTRpfRlzP9TAQ8yJ4iqi81E=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=Bgn/1OvKfYcIJNO21gMdg2O88WFu3JpJ9dDm51f2mxa55QKDlLAQXiQUqUxKiz6de
         LOb7q1xcsELgYdKq3AL4bUezqyWIcxBabFmao0qCZBg+3t6RgFZ6/r98tSqaEkxUst
         VvE1xDXEGR7ShvfkOMgZmR54n5olw1jg5Wx6ZR+7H3shorJKhufOLQ+dYfeOtV26Go
         52UBgAZkjcxuAhnTPVZFTFabrtBVEOTe4a5ynfZYQR7ZTnF3YluMV4qkKV4AXxSlZZ
         9OxnYQwhDarwQnAri5u1MUuAH3bqtcJvgLsQstAg34uiF6B3IIE/pp/hCVq6/5vsVR
         SiABdtLR28qDg==
Subject: Re: [PATCH] pinctrl/sunxi: adding input-debounce-ns property
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <d244aa6b-00b7-d768-83cb-e5a228b7ee08@trexom.it>
 <20210114081732.9386-1-giulio.benetti@benettiengineering.com>
 <20210114114219.faulkwww3dhdqwmc@gilmour>
 <c3bc06e3-4193-dc0b-b2b3-d54636481e28@trexom.it>
 <20210217110313.ly5ly5u5vyh2s7dh@gilmour>
From:   Marjan Pascolo <marjan.pascolo@trexom.it>
Message-ID: <4171ad5c-97f1-5738-9127-078fea74bbf7@trexom.it>
Date:   Fri, 26 Feb 2021 13:53:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210217110313.ly5ly5u5vyh2s7dh@gilmour>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: it
X-CMAE-Envelope: MS4wfPSXGG2O58ymEadOQn9t3b2CCvFJTGHtNrRAPDC5W/xe1ILKrHnZO0KXAe8IZ7oulpWh8RqmtHEnuIvk97tvC62odHVmCLVdoI3M0QHX730+Kygp5kgh
 Msq4dcnpSf2AM7oaZ0LSdE2MFzojJgb2G+zqw0V1G0ovJxbARr5yTzRrd2roX9Gw9TrpzKumr52fzykfGniU8F9w78D0RV+7jZo/e/9iHfbsTKynJmwiLqhJ
 G9OUDJSKoCd943+EFZMRjPLIzQz0mhi0TNAcHUW6UmC5dxGs5+UZw8fuAIcgJHg8Xc0qSARK+ljQWUy5DhwRplZqwagbtZ3IW0R0ye+xaYRlDwnfr6XQiVso
 gfa/ilDCq2nK0NHLUoZKWViwCQCPrA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Il 17/02/2021 12:03, Maxime Ripard ha scritto:
> Hi,
>
> On Wed, Feb 10, 2021 at 05:22:37PM +0100, Marjan Pascolo wrote:
>> On Allwinner SoC interrupt debounce can be controlled by two oscillator
>> (32KHz and 24MHz) and a prescale divider.
>> Oscillator and prescale divider are set through
>> device tree property "input-debounce" which have 1uS accuracy.
>> For acheive nS precision a new device tree poperty is made
>> named "input-debounce-ns".
>> "input-debounce-ns" is checked only if "input-debounce"
>> property is not defined.
>>
>> Suggested-by: Maxime Ripard <maxime@cerno.tech>
>> Signed-off-by: Marjan Pascolo <marjan.pascolo@trexom.it>
>> ---
>> ---
>>   .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  9 +++++++
>>   drivers/pinctrl/sunxi/pinctrl-sunxi.c         | 25 ++++++++++++++++---
>>   2 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
>> b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
>> index 5240487dfe50..346776de3a44 100644
>> ---
>> a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
>> +++
>> b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
>> @@ -93,6 +93,15 @@ properties:
>>       minItems: 1
>>       maxItems: 5
>>
>> +  input-debounce-ns:
>> +    description:
>> +      Debouncing periods in nanoseconds, one period per interrupt
>> +      bank found in the controller.
>> +      Only checked if input-debounce is not present
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    maxItems: 5
>> +
> This should be a separate patch, with the DT maintainers in Cc.
>
> You should enforce that the properties are mutually exclusive through
> the schema too

I'm sorry, I've ignored documentaion about /Documentation.

I see that some additional YAML operator (like oneOf) are used.

oneOf should fit the schema, but I can't understand if oneOf's options 
must be a literal value, or if could also be a node.

Otherwise I'll use if ..then..else.


>
>>   patternProperties:
>>     # It's pretty scary, but the basic idea is that:
>>     #   - One node name can start with either s- or r- for PRCM nodes,
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> index dc8d39ae045b..869b6d5743ba 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> @@ -1335,14 +1335,31 @@ static int sunxi_pinctrl_setup_debounce(struct
>> sunxi_pinctrl *pctl,
>>       struct clk *hosc, *losc;
>>       u8 div, src;
>>       int i, ret;
>> +    /* Keeping for loop below clean */
>> +    const char* debounce_prop_name;
>> +    unsigned long debounce_dividend;
>>
>>       /* Deal with old DTs that didn't have the oscillators */
>>       if (of_clk_get_parent_count(node) != 3)
>>           return 0;
>>
>> +    /*
>> +     * Distinguish between simple input-debounce
>> +     * and new input-debounce-ns
>> +     */
>> +
> I'm not sure that comment should stay, the code is obvious enough
>
>>       /* If we don't have any setup, bail out */
>> -    if (!of_find_property(node, "input-debounce", NULL))
>> -        return 0;
>> +    if (!of_find_property(node, "input-debounce", NULL)) {
>> +        if(!of_find_property(node, "input-debounce-ns", NULL)) {
>> +            return 0;
>> +        } else {
>> +            debounce_prop_name="input-debounce-ns";
>> +            debounce_dividend=NSEC_PER_SEC;
>> +        }
>> +    } else {
>> +        debounce_prop_name="input-debounce";
>> +        debounce_dividend=USEC_PER_SEC;
>> +    }
> This doesn't follow the kernel coding style, make sure to run
> scripts/checkpatch.pl on your patches before sending them.
Spaces between operators, right. After /Documentation submission I'll 
resubmit this one
>
> Maxime
