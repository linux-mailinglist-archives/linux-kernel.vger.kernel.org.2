Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B738FDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhEYJ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:26:54 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:59939 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhEYJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621934723; x=1653470723;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=id5jjjYGUYQ5y88qtb+UmsSE5j6OC46ZQvVJFXn8Wyc=;
  b=hU+OEv2iwi4e3MSXWEqDDjruLVoQ88F2BoNeim6Csaq0VVzVMLa4tlED
   LgMOUXNFoipDCk+wB0LQR3dCJCjxt5llf5Rlt4OAhd7ud+z38WYi7aLuc
   v8qbVBK6Q2Km/tdPiZvlTjV1JXgz/kEqrjqM3BsV52yhDZ4lcbP4uZoiQ
   ydspsjtiIkNBSTZ3ym5VTnrcFKxQdXOlSbN7TsnqZFH0G37WcI7O9F7WV
   IZIvtNKrV4Np/LDrk7WGI3/cjKx49TnwYxZp1Qzhr/VVuV4ZebjGj5vKi
   Fp1VcWmkdomhl7r29XZSsJ1nNFFA0Wf1DOFXa3arwTai2O1ltf0UkAxos
   w==;
IronPort-SDR: tg+RT8KQ02foJIOL7ihExOxMfJaaEfZF7OcWfCWqUf1mz6TzhnwVXpPCewgCbCH1dCfqqsWpvX
 P4Y/N/kbxWu/njpWFzPnDg6UTJ9SB/FSgqVYATG83//+QM6ZRO63k0ktkmFwzJdy9ecjEyoohu
 rZn+PQdDHnNRpggA3/kv95omzzMlEJkKhoUrmA+C7ZlYR20XoLnnFOIFCvc+cr6ubxxavSHvW2
 ilGsri8AEojsPZYheCw3O2q87NWDfXHG0GKfPZrvcKGNKYUoqTuvpchGoU4QNBmFfoD8K/clPO
 lII=
X-IronPort-AV: E=Sophos;i="5.82,328,1613458800"; 
   d="scan'208";a="129362356"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2021 02:25:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 02:25:22 -0700
Received: from [10.12.74.7] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 25 May 2021 02:25:21 -0700
Subject: Re: [PATCH v2 2/4] ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek
To:     Rob Herring <robh@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <Eugen.Hristev@microchip.com>,
        <Ludovic.Desroches@microchip.com>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Codrin.Ciubotariu@microchip.com>
References: <20210511071223.71379-1-eugen.hristev@microchip.com>
 <20210511071223.71379-2-eugen.hristev@microchip.com>
 <070939b0-ec77-a135-b351-4c4c8bc543f0@microchip.com>
 <YJo0PY2E36v2Pqz/@piout.net>
 <8c74596c-6d23-c822-fc2e-6cbb984fa4fd@microchip.com>
 <20210511191653.GA2446068@robh.at.kernel.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <bbbb0934-666a-44be-f98c-cb0ad180c792@microchip.com>
Date:   Tue, 25 May 2021 11:25:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210511191653.GA2446068@robh.at.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2021 at 21:16, Rob Herring wrote:
> On Tue, May 11, 2021 at 09:03:37AM +0000, Eugen.Hristev@microchip.com wrote:
>> On 5/11/21 10:37 AM, Alexandre Belloni wrote:
>>> On 11/05/2021 07:18:31+0000, Eugen.Hristev@microchip.com wrote:
>>>> On 5/11/21 10:12 AM, Eugen Hristev wrote:
>>>>> Add Device Tree for sama7g5 SoC and associated board sama7g5-ek
>>>>>
>>>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>>>>> [claudiu.beznea@microchip.com: add clocks, ethernet, timers, power]
>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>>> [codrin.ciubotariu@microchip.com: add audio]
>>>>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>>>>> ---
>>>>
>>>> Changes in v2:
>>>> - fixed license
>>>> - fixed warnings for make dtbs (changed ahb/apb to just soc)
>>>> - changed some node names as suggested
>>>> - removed some okay status properties
>>>> - addressed cpu node by label
>>>> - removed stdout path
>>>
>>> Why would you remove stdout-path? The solution was to remove The console
>>> parameter from bootargs, especially since you don't know what name the
>>> console device will have depending on CONFIG_SERIAL_ATMEL_TTYAT.
>>
>> Ok, sure, I will add it back and remove console=...
>>
>> I will wait to see if Rob has anymore comments before preparing a v3.
> 
> No, nothing else.

Hi Rob,

v4 was posted some time ago:
https://lore.kernel.org/linux-arm-kernel/20210514082151.178571-2-eugen.hristev@microchip.com/

I plan to include this series in at91 tree these couple of next days: do 
I wait for your tag?

Best regards,
   Nicolas


-- 
Nicolas Ferre
