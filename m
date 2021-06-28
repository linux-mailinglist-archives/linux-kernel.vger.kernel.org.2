Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E723B5D13
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhF1LUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhF1LUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:20:48 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5744EC061574;
        Mon, 28 Jun 2021 04:18:21 -0700 (PDT)
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9F22082DAA;
        Mon, 28 Jun 2021 13:18:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1624879099;
        bh=qA45Pgs9vtEjSDKl0Lpxyl8donDg6Vmu3o01tms71Sw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=u7ggcc7OjxDa6PZfbOhJG+MOyi+dIGDwtArvZ7C3dpiXocmniVH6ChlopUR8Vj/4K
         ppiB0mngIHTXKer5uR+TkReCVscDnvfd4yVlN6Mj76lMGuAfWk6jutC5Woug6YKwob
         wFxjQgq+1OH4SR84OUv2G7fmdaRZMc8FKyyUkVMzld1bOWWfyeyEV0f7moon1VLVC2
         PKMw0ipUHlrhgmdb23gS0K7KUpFlmdZ49mb6JQ9ljD19nKPJjhYeLMuNAFNDPKnZec
         wSK5yFc0rhXOXthTT5oOLbtQCIT2REyfjJUWDoS6Z5X24TeJCZxt3/BNMnz7FG4mOZ
         WJZnkwtQ81Skg==
Subject: Re: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
To:     Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>
References: <20210612133134.2738-1-peng.fan@oss.nxp.com>
 <20210612133134.2738-5-peng.fan@oss.nxp.com>
 <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
 <2c39672b-780a-8e33-038e-0856e32ede7a@denx.de>
 <DB6PR0402MB27603801C9017F05393DDFAB88039@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <c4ea05d1-46db-3ec9-85f8-3c16ccdb5c74@denx.de>
Date:   Mon, 28 Jun 2021 13:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DB6PR0402MB27603801C9017F05393DDFAB88039@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 1:14 PM, Peng Fan wrote:
>> Subject: Re: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
>>
>> On 6/14/21 8:07 PM, Adam Ford wrote:
>>> On Sat, Jun 12, 2021 at 7:58 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
>> wrote:
>>>>
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
>>>> that support in this driver.
>>>>
>>>> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>
>>> Maybe my TF-A is too old, but I am not able to wake the device from
>>> suspend-to-ram with this series.  I used the device tree from [1] to
>>> enable both the GPCv2 and the blk-ctl stuff.
>>>
>>> [1] -
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
>>>
>> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20210604111
>> 005
>>> .6804-1-peng.fan%40oss.nxp.com%2F&amp;data=04%7C01%7Cpeng.fan%4
>> 0nxp.co
>>>
>> m%7Ca4c06cfdf6314633c7c708d93a23cff0%7C686ea1d3bc2b4c6fa92cd99c
>> 5c30163
>>>
>> 5%7C0%7C0%7C637604747755701757%7CUnknown%7CTWFpbGZsb3d8eyJ
>> WIjoiMC4wLjA
>>>
>> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s
>> data=0
>>> pDwVtfizZ7mZh9pSfy0bSbffOxP90AnaQrZ8i8cNv0%3D&amp;reserved=0
>>>
>>> I based both off Shawn's for-next branch.
>>
>> I also ran into issues with this, although it could also be related to GPCv2. On
>> MX8MM , the system sometimes hangs when bringing up the GPCv2 power
>> domain 6 (VPUMIX). It seems that the GPCv2 driver sets
>> GPC_PU_PGC_SW_PUP_REQ register to 0x100 to bring up the VPUMIX and
>> the bit never self-clears. After that, it seems the entire GPC locks up.
>> Have you ever seen that kind of behavior ?
> 
> Do you have clk enabled for vpumix? Is this issue happends every time? Or hard
> to reproduce?

Yes, DEC_ROOT is active, I also activated BUS.

It happens sporadically (every 5 or so reboots), I have to reboot the 
machine a few times to trigger it. It happens during the kernel boot 
process in every few boots.
