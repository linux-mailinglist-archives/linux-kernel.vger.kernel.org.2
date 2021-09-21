Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5E34130DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 11:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhIUJqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 05:46:12 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:28053 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhIUJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 05:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632217484; x=1663753484;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OvI/X/RQ4jZpyc9yauoJDTSXYLNl8EhydRgfWIgTA4k=;
  b=BA+lRceG0iYq2dy2j2qa6DwTksjwNS+JITmTfT8BaxHnquF+CDrJNw2/
   JbNk9NNweqay10MH/GJaMDjQEiNw8NDfRhU850QEE5HtwAPJEXd7aLjlH
   C1Brh24Snh+nfqyW/qUSA3M19d5VNbCsec3HTEsxbUl72U2jDJJuCiOX8
   WzB1OKnNfIB5dgcnXz5h1ol7SlVmKBBHKXuIoJr507cCMh4AvaWRk5lN2
   mJ+QneNrAnr8sJgkYsMWS/M7D7IX5f4q15i/M5EIbVmg6yeEegxO4xfq7
   OTcg0XUyozrGqoc5Ji9RAC6/MBJMWSrht05Csd1/hfMn5olkis0zhX1Oc
   g==;
IronPort-SDR: a2k3kfz8B2RjtHaDpe8R1f3QLoBkPChzOMrLhmyqb4FyFkEeKVfLAL8u1pZJajwQZBDNwDIyr1
 zxzG0dq+y7PTrDDqft34jSj5AH6O9AJjqgcWDST8bB/FoPBUjqENxX/wkfOQbfVlX1sCheyVki
 xBYPvZ2tRW9Wi1Npi7A3+kY8ot3wKLJxIhLPOMJ7AzeonN8CDZ56B1bMGgIRQC8011GIXQ70Ab
 AdbUjfVKSkHGZSahA4AJkmFzqOCU823VdEtS1sD5IFFT1pENP8QK74i41GD6C2BsFFXwuhctjs
 9Yibg0ijdnBGyKuIJtEr2lC5
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="132558815"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Sep 2021 02:44:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Sep 2021 02:44:41 -0700
Received: from [10.171.246.85] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 21 Sep 2021 02:44:39 -0700
Subject: Re: [PATCH 2/2] ARM: at91: dts: at91-sama5d2_xplained: Add comments
 for sama5d29
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <Ludovic.Desroches@microchip.com>, <robh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>, <Hari.PrasathGE@microchip.com>
References: <20210812140758.28273-1-Hari.PrasathGE@microchip.com>
 <20210812140758.28273-2-Hari.PrasathGE@microchip.com>
 <YRV13nfgpEEuOOxB@piout.net>
 <78b26b01-b66f-5779-9f67-fdd13e473dfc@microchip.com>
 <YR4+eUWdeHRCOMo3@piout.net>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <87f93ee9-83aa-6516-6deb-0880f64a6e4e@microchip.com>
Date:   Tue, 21 Sep 2021 11:44:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR4+eUWdeHRCOMo3@piout.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2021 at 13:20, Alexandre Belloni wrote:
> On 19/08/2021 10:56:21+0000, Hari.PrasathGE@microchip.com wrote:
>> Hello,
>>
>> On 13/08/21 12:56 am, Alexandre Belloni wrote:
>>> Hello,
>>>
>>> On 12/08/2021 19:37:58+0530, Hari Prasath wrote:
>>>> Add comments for the end user for modifying the DTS file for
>>>> instantiating the sama5d29 SoC.
>>>>
>>>> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
>>>> ---
>>>>    arch/arm/boot/dts/at91-sama5d2_xplained.dts | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>>>> index 627b7bf88d83..faa30063d9a9 100644
>>>> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>>>> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>>>> @@ -6,6 +6,11 @@
>>>>     *                2015 Nicolas Ferre <nicolas.ferre@atmel.com>
>>>>     */
>>>>    /dts-v1/;
>>>> +/*
>>>> + * Replace the line below with "sama5d29.dtsi" in order to instantiate the
>>>> + * sama5d29 SoC of the sama5d2 family.Otherwise, leave it unchanged when
>>>> + * using sama5d27 SoC for instance.
>>>> + */
>>>
>>> I guess it would be better to have a at91-sama5d29_xplained.dts (and we
>>> should have had a at91-sama5d27_xplained.dts), else, you can't create an
>>> image that will support both variants.
>>>
>>>
>> The new SoC 'sama5d29' belongs to the same sama5d2 family. It is
>> essentially a new chip revision of the existing sama5d27 with a new GMAC
>> controller IP that addresses few silicon issues. There wouldn't be
>> separate evaluation boards that shall be made but we will be using the
>> existing sama5d2 XPlained boards itself but with the new SoC populated.
> 
> That's what I understood but a board with a different SoC is a
> different board.

The problem that we have right now is that the official board sama5d2 
Xplained will never be officially released with a sama5d29 SoC. There's 
basically no available board with this chip.

We added this "hint" as a comment to our historical board but it's true 
that it might be confusing.

For now, I'm taking only the first patch of the series. If the need 
arise, we'll create the proper board DTS file.

>> Hence we have taken this approach of having a separate DTSI file and
>> reuse the existing board specific DTS file.
>>
>> We don't want to create single image that will support both variants. In
>> fact, we don't want our customers to enable certain features that are
>> broken at the silicon level in the existing revision of the SoC i.e
>> sama5d27. Instead, they could do this change manually and use it in the
>> new SoC i.e sama5d29.
>>
> 
> This will be confusing to your customers while you could make their
> lives simpler by having the bootloader chose the proper dtb instead of
> having them change that manually. They will then have to regenerate
> images with that change, see how your customers struggle to do that:
> 
> https://stackoverflow.com/questions/68222619/update-custom-device-tree-on-yocto
> https://stackoverflow.com/questions/37347808/how-to-use-an-own-device-tree-and-modified-kernel-config-in-yocto
> https://stackoverflow.com/questions/63047955/overriding-defconfig-in-bbappend-file
Yes, understood. The intention was not to create another different board 
but to give a hint, should customer replace themselves the SoC on 
official sama5d2 xplained board (like we did internally). Use case is 
probably so unlikely that we might just forget about it (for now at least).

Best regards,
   Nicolas

-- 
Nicolas Ferre
