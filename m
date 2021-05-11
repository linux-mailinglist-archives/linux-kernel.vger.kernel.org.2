Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D9F37AB22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhEKPvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:51:31 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:53758 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhEKPv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:51:28 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 14BFnqIE012506
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 17:49:52 +0200
Received: from [167.87.32.54] ([167.87.32.54])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 14BFQqmi012261;
        Tue, 11 May 2021 17:26:52 +0200
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am65: Add support for UHS-I modes
 in MMCSD1 subsystem
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210511095339.16268-1-a-govindraju@ti.com>
 <200b5648-b2d9-b4c9-f81a-b39c3baf81f9@siemens.com>
 <7561137c-adf1-bf03-c442-ff8174b2f143@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <95539fea-8190-7a3d-05aa-90824eb03293@siemens.com>
Date:   Tue, 11 May 2021 17:26:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <7561137c-adf1-bf03-c442-ff8174b2f143@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.21 12:13, Aswath Govindraju wrote:
> Hi Jan,
> 
> On 11/05/21 3:31 pm, Jan Kiszka wrote:
>> On 11.05.21 11:53, Aswath Govindraju wrote:
>>> UHS-I speed modes are supported in AM65 S.R. 2.0 SoC[1].
>>>
>>> Add support by removing the no-1-8-v tag and including the voltage
>>> regulator device tree nodes for power cycling.
>>>
>>> However, the 4 bit interface of AM65 SR 1.0 cannot be supported at 3.3 V or
>>> 1.8 V because of erratas i2025 and i2026 [2]. As the SD card is the primary
>>> boot mode for development usecases, continue to enable SD card and disable
>>> UHS-I modes in it to minimize any ageing issues happening because of
>>> erratas.
>>>
>>> k3-am6528-iot2050-basic and k3-am6548-iot2050-advanced boards use S.R. 1.0
>>> version of AM65 SoC. Therefore, add no-1-8-v in sdhci1 device tree nodes
>>> for these boards.
>>>
>>> [1] - https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
>>> [2] - https://www.ti.com/lit/er/sprz452e/sprz452e.pdf
>>>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
>>>  .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |  4 +++
>>>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 33 +++++++++++++++++++
>>>  .../dts/ti/k3-am6548-iot2050-advanced.dts     |  4 +++
>>>  4 files changed, 41 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> index cb340d1b401f..632f32fce4a1 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> @@ -301,7 +301,6 @@
>>>  		ti,otap-del-sel = <0x2>;
>>>  		ti,trm-icp = <0x8>;
>>>  		dma-coherent;
>>> -		no-1-8-v;
>>>  	};
>>>  
>>>  	scm_conf: scm-conf@100000 {
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
>>> index 4f7e3f2a6265..485266960d5f 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
>>> @@ -40,6 +40,10 @@
>>>  	status = "disabled";
>>>  };
>>>  
>>> +&sdhci1 {
>>> +	no-1-8-v;
>>> +};
>>> +
>>
>> Let's move that to k3-am65-iot2050-common.dtsi, to avoid repeating
>> yourself. There is already a sdhci1 extension.
>>
> 
> The reason why I added these tags in board dts and not in the common
> dtsi is because if it was added in the common board then for all the iot
> boards this will be applicable and in future if a different version of
> iot boards use S.R. 2.0 then we might have to change it again.

Yes, we will have to take care of the split-up for SR2.0-based variants.
I didn't have the chance study their DTs yet but I strongly suspect that
there will be more differences. Then we may add some
k3-am65-iot2050-common-{SR1,SR2}.dtsi.

So, I would not try to refactor when not all variables are on the table yet.

Thanks
Jan


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
