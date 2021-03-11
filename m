Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB0B337538
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhCKOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:15:21 -0500
Received: from gecko.sbs.de ([194.138.37.40]:46347 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhCKOOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:14:51 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 12BEEf0x007069
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 15:14:41 +0100
Received: from [167.87.35.81] ([167.87.35.81])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 12BEEeDD022550;
        Thu, 11 Mar 2021 15:14:40 +0100
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: Add support for Siemens IOT2050
 boards
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <cover.1615369068.git.jan.kiszka@siemens.com>
 <9bff40f434e5298890e5d139cc36cc46a0ca2d76.1615369068.git.jan.kiszka@siemens.com>
 <20210311131754.i5ewls6hgeitcgre@astonish>
 <8d076ff1-cdac-941f-e796-a2e6dba792ab@siemens.com>
 <20210311140056.fzvke3rrg6c2uuoa@uncouth>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <519ae6b7-35db-1fdd-de1e-e0155e0ca82a@siemens.com>
Date:   Thu, 11 Mar 2021 15:14:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311140056.fzvke3rrg6c2uuoa@uncouth>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.21 15:00, Nishanth Menon wrote:
> On 14:44-20210311, Jan Kiszka wrote:
>> On 11.03.21 14:17, Nishanth Menon wrote:
>>> On 10:37-20210310, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> +	spidev@0 {
>>>> +		compatible = "rohm,dh2228fv";
>>>> +		spi-max-frequency = <20000000>;
>>>> +		reg = <0>;
>>>
>>> Jan,
>>>
>>> As part of my final sanity checks, I noticed that we missed this: is a checkpatch warning
>>>
>>> WARNING: DT compatible string "rohm,dh2228fv" appears un-documented -- check ./Documentation/devicetree/bindings/
>>> #629: FILE: arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi:581:
>>> 		compatible = "rohm,dh2228fv";
>>>
>>> I cannot pick up nodes that are'nt documented as yaml in
>>> 	Documentation/devicetree
>>>
>>> I know this is irritating to find such nodes that already have previous
>>> users and the person coming last gets to deal with "new rules".. but
>>> sorry for catching this so late.
>>>
>>> Here are the options that come to mind:
>>>
>>> option 1) - drop the node and resubmit.
>>>
>>> option 2) - get the documentation into linux master tree and then submit
>>> the patches.
>>>
>>
>> As you said, I'm not setting a precedence here:
>>
>> arch/arm/boot/dts/imx28-cfa10049.dts:                   compatible = "rohm,dh2228fv";
>> arch/arm/boot/dts/rv1108-elgin-r1.dts:          compatible = "rohm,dh2228fv";
>> arch/arm/boot/dts/socfpga_cyclone5_socdk.dts:           compatible = "rohm,dh2228fv";
>> drivers/spi/spidev.c:   { .compatible = "rohm,dh2228fv" },
>>
>> Was just just never documented as binding? Or why is no one allowed to 
>> use this anymore? What is to be used instead for spidev?
> 
> See [1] compare the compatibles against
> Documentation/devicetree/bindings -> I think you should describe what
> your hardware really is though.

This SPI bus is routed to an Arduino connector. By default, userspace
(e.g. mraa) takes ownership and adds the desired logic for what is being
connected. We have no idea what shield or other extension the user adds,
though.

> 
> Unfortunately devicetree migration has been far from being smooth.. it
> was like chewing an elephant - linux community had to attack it in
> pieces..
> 
> Yes - it was unfortunately one of those cases where the driver support
> was introduced long back and no binding was introduced at that time (it
> was'nt mandatory then).. then we added a mandatory requirement that it
> be documented in txt.. over years realized things are'nt great with
> unstructured txt description of binding, now moving on converting
> existing txt files to yaml and schemas to static check the dts...
> evolution over the years, I guess.
> 
> I am on a fight internally as well to have all our legacy txt files
> converted over to yaml.. and am having to put up a stance - see [2]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spidev.c#n678
> [2] https://lore.kernel.org/linux-arm-kernel/20210311134908.jsh2lywtwzvlyvbc@finally/T/#u
> 

The problem here is not simple txt->yml conversion: There is no official
binding for spidev yet, just existing users and the driver waiting for them.

>>
>>>
>>> I think we should just drop the node and resubmit - since this is a more
>>> intrusive change and I don't have your platform handy, I am going to
>>> suggest you make a call :(
>>
>> This breaks userspace here, and we would need to carry that node on top.
>>
> 
> Uggh... that sucks.. but I think that would be lower tradeoff to make
> than me (as it stands now) having to drop the patch series.
> 
>> BTW, I already brought up the topic internally to get you some boards 
>> for testing.
> 
> Thanks.. While it might help me personally to get some on my internal
> farm, it might be good to get them on kernelci as well on the longer
> run.
> 

Will keep that on the radar. I definitely want to get it into the CIP
LAVA lab which is testing LTS as well.

>>
>> I've done that and addressed all that I could (former patch 4). We 
>> import those from k3, and I don't feel confident how to resolve them.
>> See also v1 of this patch.
> 
> Yeah - i noticed that upstream dt-schema has gotten even more stricter
> even though the dts has remained the same.. I need to spend time in
> digging at it.
> 
> At this point the only big kicker is the checkpatch stuff which I cant
> let through - if i do that arnd will probably kick everything from my
> PR out :( - which I cant do.
> 

Are we talking about spidev here? Then let's drop that node, but I do
need to know how to describe spidev properly

Or is it about those other warnings coming from your dtsi files, now
being surfaced? If you can tell me how to resolve them, I can write patches.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
