Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E4416650
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbhIWUE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbhIWUE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:04:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6704EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 13:02:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mTUvl-00023Z-Lh; Thu, 23 Sep 2021 22:02:53 +0200
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org,
        =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-2-qiangqing.zhang@nxp.com>
 <6d91d833-08cc-7ce2-4fe5-3d843a8b31ae@pengutronix.de>
 <181c4037-3c34-0f71-6bb7-a9c11b173064@linaro.org>
 <dbd1c20c-e3be-6c92-52a8-2ad76d0092d0@pengutronix.de>
 <8fc0a5e2-18c0-fa81-3eed-a6d596361633@linaro.org>
 <d580dd06-8bc8-91c9-262b-f6f276b033c2@pengutronix.de>
 <53fd9335-baca-fb52-42f1-2af3b08b5f1f@linaro.org>
 <89b4a2d6-1966-7fcb-d476-f69e88293ea0@pengutronix.de>
 <18c0d9c0-bee8-41fa-8fe8-26a0ceda1ecd@linaro.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <7aa60518-1045-5773-5b24-9f386cac1b8e@pengutronix.de>
Date:   Thu, 23 Sep 2021 22:02:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <18c0d9c0-bee8-41fa-8fe8-26a0ceda1ecd@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Srini,

On 22.09.21 15:23, Srinivas Kandagatla wrote:
> On 22/09/2021 14:08, Ahmad Fatoum wrote:
>> On 22.09.21 15:03, Srinivas Kandagatla wrote:
>>> User A and B should mention about this encoding information in there NVMEM provider bindings.
>>>
>>> Based on that specific post-processing should be selected.
>>
>> So instead of just compatible = "atmel,at24c16"; there will be
>>
>>    compatible = "user-A,my-eeprom", "atmel,at24c16";
>>
>> and
>>
>>    compatible = "user-B,my-eeprom", "atmel,at24c16";
> 
> It will depend how you specify encoding information.

I would specify them in cell-type, which you disagree with, thus
I am asking:

Is using a stock EEPROM with a non-canonical format for e.g. a MAC
address something that you think should be supported with NVMEM?

> The issue with making this encoding information generic is that the combinations are endless and nvmem core bindings is definitely not the right place for this.

Add a separate file and include it from the core file?

> ex:
> If I remember correctly we have mac-address stored in various formats:
> from old thread I can see
> 
> Type 1: Octets in ASCII without delimiters. (Swapped/non-Swapped)
> 
> Type 2: Octets in ASCII with delimiters like (":", ",", ".", "-"... so on) (Swapped/non-Swapped)
> 
> Type 3: Is the one which stores mac address in Type1/2 but this has to
> be incremented to be used on other instances of eth.
> 
> Type 4: Octets as bytes/u8, swapped/non-swapped
> 
> This list can be endless and its not just the cell-type property you have to deal with, new properties keep popping up.

Yes, an extendible interface will likely encourage people to extend it.

Cheers,
Ahmad

> --srini
> 
> 
> 
>>
>> and they each need to patch the at24 driver to call one of the
>> common library functions?
>>
>>>
>>> --srini
>>>>
>>>
>>>>>
>>>>> --srini
>>>>>
>>>>>>
>>>>>>>> I'd thus prefer to not make this specific to the OCOTP as all:
>>>>>>>>
>>>>>>>>       * #define NVMEM_CELL_ENCODING_MAC_ADDRESS_IMX    /* ... */
>>>>>
>>>>
>>>>
>>>
>>
>>
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
