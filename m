Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69F35700F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353450AbhDGPVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:21:20 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:50117 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhDGPVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:21:19 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 137FKwnl016116
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 17:20:58 +0200
Received: from [139.22.47.56] ([139.22.47.56])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 137FDblB023332;
        Wed, 7 Apr 2021 17:13:37 +0200
Subject: Re: [PATCH] arm64: dts: ti: k3-am65: Add support for UHS-I modes in
 MMCSD1 subsystem
To:     Nishanth Menon <nm@ti.com>, Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210407104303.25950-1-a-govindraju@ti.com>
 <20210407145937.prvue66guhdls2fw@immovably>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7d089f1c-6f9e-82fe-fc8a-42c691d4ec40@siemens.com>
Date:   Wed, 7 Apr 2021 17:13:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210407145937.prvue66guhdls2fw@immovably>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.21 16:59, Nishanth Menon wrote:
> On 16:13-20210407, Aswath Govindraju wrote:
>> UHS-I speed modes are supported in AM65 S.R. 2.0 SoC[1].
>>
>> Add support by removing the no-1-8-v tag and including the voltage
>> regulator device tree nodes for power cycling.
>>
>> [1] - https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf, section 12.3.6.1.1
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> 
>> ---
>>
>> test logs:
>> https://pastebin.ubuntu.com/p/vpYbY9QWh8/
>>
> Thanks, but I dont plan on queuing this for 5.13-rc1 (my PR is already
> out). but it does trigger an interesting discussion..
> 
>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
>>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 33 +++++++++++++++++++
>>  2 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index cb340d1b401f..632f32fce4a1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -301,7 +301,6 @@
>>  		ti,otap-del-sel = <0x2>;
>>  		ti,trm-icp = <0x8>;
>>  		dma-coherent;
>> -		no-1-8-v;
>>  	};
>>  
> 
> Jan - this will break your IOT SR1.0 boards, no? with all the SR1.0,
> 2.0, 2.1 coming along, the plan for TI was to support older revs via
> overlays hoping that older boards will eventually get replaced or die
> out of lack of use.. but you do have production on 1.0 -> so would you
> rather handle this in overlay OR IOT boards dts introduce no-1-8-v
> property?

I'm fine with pulling anything needed into our board-specific DTs. Those
pending are for SR1.0 boards only. SR2 will come later and have their
own DTs.

Didn't follow the thread: Where is this patch located wrt my IOT2050
series? Does it come first first, and we would have to rebase? Or would
this change rather have to move the flag to k3-am65-iot2050-common.dtsi?

Thanks a lot for having an eye on these subtle dependencies!

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
