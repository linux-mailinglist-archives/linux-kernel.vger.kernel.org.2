Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B783375F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhCKOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:41:37 -0500
Received: from gecko.sbs.de ([194.138.37.40]:51621 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233696AbhCKOlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:41:19 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 12BEfAdn011723
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 15:41:10 +0100
Received: from [167.87.35.81] ([167.87.35.81])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 12BEa9qT015234;
        Thu, 11 Mar 2021 15:36:09 +0100
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
 <519ae6b7-35db-1fdd-de1e-e0155e0ca82a@siemens.com>
 <20210311142151.5o54k7kmrnatufcw@target>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f8c6f598-cb9c-ecd5-0b01-09f171ce7c26@siemens.com>
Date:   Thu, 11 Mar 2021 15:36:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311142151.5o54k7kmrnatufcw@target>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.21 15:21, Nishanth Menon wrote:
> On 15:14-20210311, Jan Kiszka wrote:
> 
> [...]
> 
>>>
>>> See [1] compare the compatibles against
>>> Documentation/devicetree/bindings -> I think you should describe what
>>> your hardware really is though.
>>
>> This SPI bus is routed to an Arduino connector. By default, userspace
>> (e.g. mraa) takes ownership and adds the desired logic for what is being
>> connected. We have no idea what shield or other extension the user adds,
>> though.
> 
> overlays look like the right approach for variable systems like these.
> It is not exactly plug and play.. but it does provide a level of
> flexibility that is helpful.

Yes, that's for extensions which have kernel drivers. The default model
here is userspace, though. Will add as a separate patch to our queue for
now.

> 
> [..]
>> The problem here is not simple txt->yml conversion: There is no official
>> binding for spidev yet, just existing users and the driver waiting for them.
>>
> 
> I think we should discuss in the spidev list to get it resolved.
> 
>>> Thanks.. While it might help me personally to get some on my internal
>>> farm, it might be good to get them on kernelci as well on the longer
>>> run.
>>>
>>
>> Will keep that on the radar. I definitely want to get it into the CIP
>> LAVA lab which is testing LTS as well.
> 
> Cool.
> 
>> Are we talking about spidev here? Then let's drop that node, but I do
>> need to know how to describe spidev properly
> 
> yes - the spidev is my problem. can you drop the node and repost? i cant
> locally modify and hope it works.
> 

Done.

>>
>> Or is it about those other warnings coming from your dtsi files, now
>> being surfaced? If you can tell me how to resolve them, I can write patches.
> 
> I will look at the warnings later today.. I dont think they are
> triggered by the board dts.
> 

That was also my interpretation of the results. Some are even just
copies from what you get for the EVM boards.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
