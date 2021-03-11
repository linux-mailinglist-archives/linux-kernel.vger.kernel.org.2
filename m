Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF999337C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhCKSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhCKSXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:23:52 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B15CC061574;
        Thu, 11 Mar 2021 10:23:52 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so77878otn.10;
        Thu, 11 Mar 2021 10:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X2TrxazCY9UP4CB1vU4flOfkXW+UhcWuBfdkGL2i0ls=;
        b=BUtq+4jn2klGMKpxl2wR35WkkEZRdFysShY3uG2jaEHooE5HIc95GqTSX4danc4zMU
         qsBYqW1K22GAI3c7WPdEgjeMPgAgvQG7CpPSIoEUSlU6Vey/U1rdMc2BPpBORnyvio+R
         bzArVzZ7NRpCjhrOFVEtVqpfcqt+5cNUYqiBCHOT4t/+WzA9sPQKpHHQhRdlRzU0stjR
         crVK1HfaLduy6I8LXQQ0HfVmDcthoqFZUVjUNPVewAan2cLH0K7GEP8uHV7yu8A9zyJo
         ovg6OFKRr8pJVDCahIGNKzStPzIqfaEcHe4Np8JG09s0eVFtMwRbMdOpOajM9+ewvYrg
         z4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X2TrxazCY9UP4CB1vU4flOfkXW+UhcWuBfdkGL2i0ls=;
        b=oOpO34LFgfFhbXw5N3KClCjgfbyPNSgYcD/qJlI02gMNkmfHYMidfhxEjuTyUxsZ1H
         sR80claCIr0ElvAinQP+ZKQKis4wAZMwVBYgYFdpmSn9aERrPj7bkAke3Gh3hosoSals
         BemjOEkpwrXNfVOQFAg5x7DjvTD4Q0r0/Y0WIqef+KjzCDKfQRrOGtsipsheWKGQY655
         HnujLrbBfloWzA4DuWbVOViuX+K4T1dj0aORzy64HpMKt0g3Mqdl63pLJsWbJ50ryh0K
         PCm06fcVljkfMMbKOlrU5kSJfIuohzKD9r4uXritrWf72DonU56jpRmIQZu12jNqUVCi
         Hr1w==
X-Gm-Message-State: AOAM533Jfm0iTjM40AcscTraupfoIMOgcZ4ydb9CcJjv2hD2FE67JWVY
        NOejxFIINTvSy5eUEg4/+5BkeAmVPyC+vA==
X-Google-Smtp-Source: ABdhPJwfReDNY3UNDzP/Lron5+DB+qEb1RaV1nW4bRx4prAzn7c5QIcnORnFi7XILA1BRkgwA9hCAA==
X-Received: by 2002:a9d:480d:: with SMTP id c13mr155104otf.149.1615487031747;
        Thu, 11 Mar 2021 10:23:51 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id m11sm691670oih.34.2021.03.11.10.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 10:23:51 -0800 (PST)
Subject: Re: [Linux-stm32] [PATCH v2 00/14] Introduce STM32MP1 RCC in secured
 mode
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Gabriel FERNANDEZ - foss <gabriel.fernandez@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne CARRIERE <etienne.carriere@st.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
 <2e04f814-b694-119d-fe8a-13e6df129536@gmail.com>
 <AS8PR10MB4712C27260707345FA99ED5AEE909@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
 <c57775fe-41ef-07f5-56a2-04b8f70797c1@denx.de>
 <463dafed-ec60-cd9a-33d2-ba118a6af629@foss.st.com>
 <c1c9c89b-8794-9b91-b626-d743cd8ff31e@pengutronix.de>
 <b87a2b24-678a-724d-e5df-1eabf5969ad2@denx.de>
 <a23933fa-0c94-1e22-6100-d5b1a50826dd@foss.st.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <6c470715-0042-622b-d53d-59445cab8ed1@gmail.com>
Date:   Thu, 11 Mar 2021 12:23:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a23933fa-0c94-1e22-6100-d5b1a50826dd@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/21 12:10 PM, Alexandre TORGUE wrote:
> Hi Guys
> 
> On 3/11/21 5:11 PM, Marek Vasut wrote:
>> On 3/11/21 3:41 PM, Ahmad Fatoum wrote:
>>> Hello,
>>
>> Hi,
>>
>>> On 11.03.21 15:02, Alexandre TORGUE wrote:
>>>> On 3/11/21 12:43 PM, Marek Vasut wrote:
>>>>> On 3/11/21 9:08 AM, Alexandre TORGUE wrote:
>>>>>> 1- Break the current ABI: as soon as those patches are merged, 
>>>>>> stm32mp157c-dk2.dtb will impose to use
>>>>>> A tf-a for scmi clocks. For people using u-boot spl, the will have 
>>>>>> to create their own "no-secure" devicetree.
>>>>>
>>>>> NAK, this breaks existing boards and existing setups, e.g. DK2 that 
>>>>> does not use ATF.
>>>>>
>>>>>> 2-As you suggest, create a new "secure" dtb per boards (Not my 
>>>>>> wish for maintenance perspectives).
>>>>>
>>>>> I agree with Alex (G) that the "secure" option should be opt-in.
>>>>> That way existing setups remain working and no extra requirements 
>>>>> are imposed on MP1 users. Esp. since as far as I understand this, 
>>>>> the "secure" part isn't really about security, but rather about 
>>>>> moving clock configuration from Linux to some firmware blob.
>>>>>
>>>>>> 3- Keep kernel device tree as they are and applied this secure 
>>>>>> layer (scmi clocks phandle) thanks to dtbo in
>>>>>> U-boot.
>>>>>
>>>>> Is this really better than
>>>>> #include "stm32mp15xx-enable-secure-stuff.dtsi"
>>>>> in a board DT ? Because that is how I imagine the opt-in "secure" 
>>>>> option could work.
>>>>>
>>>>
>>>> Discussing with Patrick about u-boot, we could use dtbo application 
>>>> thanks to extlinux.conf. BUT it it will not prevent other case (i.e. 
>>>> TF-A which jump directly in kernel@). So the "least worst" solution 
>>>> is to create a new "stm32mp1257c-scmi-dk2 board which will overload 
>>>> clock entries with a scmi phandle (as proposed by Alex).
>>>
>>> I raised this issue before with your colleagues. I still believe the 
>>> correct way
>>> would be for the TF-A to pass down either a device tree or an overlay 
>>> with the
>>> actual settings in use, e.g.:
>>>
>>>    - Clocks/Resets done via SCMI
>>>    - Reserved memory regions
>>>
>>> If TF-A directly boots Linux, it can apply the overlay itself, 
>>> otherwise it's
>>> passed down to SSBL that applies it before booting Linux.
>>
>> That sounds good and it is something e.g. R-Car already does, it 
>> merges DT fragment from prior stages at U-Boot level and then passes 
>> the result to Linux.
>>
>> So on ST hardware, the same could very well happen and it would work 
>> for both non-ATF / ATF / ATF+TEE options.
> 
> Even this solution sounds good but we are currently not able to do it in 
> our TF-A/u-boot so not feasible for the moment. So we have to find a 
> solution for now. Create a new dtb can be this solution. Our internal 
> strategy is to use scmi on our official ST board. It will be a really 
> drawback to include a "no-scmi.dtsi" in DH boards (for example) and to 
> create a stm32mp157c-noscmi-dk2.dts ?

It could work, as long as all users are reminded to change their build 
scripts to pick up a "-noscmi.dtb". I suspect that if this were the case 
we'll see quite a few bug reports saying "stm32mp1 no longer boots with 
kernel v5.13".

I didn't think of this originally, though u-boot already does the DTB 
patching for OPTEE reserved memory regions. It's not too hard to also 
patch in the SCMI clocks at boot. In u-boot's case, runtime detection 
might even be feasible.

Alex
