Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A792420B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhJDM57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:57:59 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:36268 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhJDM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633352133; x=1664888133;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JccWlpUp/or4JMcaKBhLvGhBaLkD9fbtO9eKKoI3YkA=;
  b=uHfOZ2zHMzpiZuohcU6+DXt/5n7AWgSlePsHpm/pstmTdNvC3hoHuHFr
   uVrWAwQy47LxeYBhgCWf4BdfAGd04kUJa6dHVn5ZHhqEmEu1c8swx67LE
   QKiW0uekpbwaV+uo6WSDMWAug/Q23WDAkDJebIJJZrPDr2sSN7rJGyYIk
   qIVYGuyKdC1AS0Gqb7JAKSJyOcxJAMRR6H8OvYIcXiMDecZ6/4z04V+bu
   8o0Zj7wYxKb/lyoWWr9HHY/qE3LrixYHdPYCk4kTgmeS0/dn69S8R1peh
   4+/cwbTiEs4T/1WUW65yCC/6ACXimhXMXzmsZc+YXfOitGt8m857J0cFV
   Q==;
IronPort-SDR: zyaE9nC/36+n7dYKUTIUlsupvphOvcygjjT6DyF49geXMLjpLB5vrOGkom88OMSa9Q+fxuIlBa
 fykR7itjtkWgPBbM3Q+wYDUKrwTmeWZlBzOhwszfdPGnZpHu66Ghbl5fcw6U8XlFEZSxXTm16Y
 vglL3eSPsFml1WVm7KYNfTmAHJbD87TnKGtMgRuMMpJJiK+vN6gSUFWqSFemlZra+mdXxEuMft
 WS+lcQvYj75rEvKrXzspYLcfT55oyort9BkQJOpmfjzeHdRvc8+UENTHc8H7QK8hyo2coSfS1h
 CvigYaCiskW7m5iUHfXBfU0E
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="138365305"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 05:55:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 05:55:32 -0700
Received: from [10.12.73.58] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 4 Oct 2021 05:55:29 -0700
Subject: Re: [PATCH 0/4] Add lan966 documentation and remove lan966x.c file
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
CC:     <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <corbet@lwn.net>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Manohar.Puri@microchip.com>
References: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
 <YVrgzWLReFS5FgWd@piout.net>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <09645199-50af-0373-c5bb-e0d745543e5b@microchip.com>
Date:   Mon, 4 Oct 2021 14:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVrgzWLReFS5FgWd@piout.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2021 at 13:09, Alexandre Belloni wrote:
> On 04/10/2021 16:29:22+0530, Kavyasree Kotagiri wrote:
>> This patch series modifies Kconfig entry, adds documentation for
>> lan966 family and removes lan966x setup code file as it is not
>> required.
>>
>> These patches are generated from at91/linux.git
>> I had agreement with Nicolas Ferre that he will merge these changes
>> into existing patch.
>>
> 
> Seems good to me, for the whole series:
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com> for the whole 
series, added to at91-soc and merged with previous patch.

Please have a look at the resulting tree or at91-next branch for 
double-checking.

Thanks, best regards,
   Nicolas

>> Kavyasree Kotagiri (4):
>>    ARM: at91: Kconfig: use only one name SOC_LAN966 and merge options
>>    ARM: at91: Documentation: add lan966 family
>>    dt-bindings: arm: at91: Document lan966 pcb8291 and pcb8290 boards
>>    ARM: at91: remove lan966x file
>>
>>   Documentation/arm/microchip.rst               |  6 +++++
>>   .../devicetree/bindings/arm/atmel-at91.yaml   | 12 +++++++++
>>   arch/arm/mach-at91/Kconfig                    | 12 ++++-----
>>   arch/arm/mach-at91/Makefile                   |  1 -
>>   arch/arm/mach-at91/lan966x.c                  | 25 -------------------
>>   5 files changed, 23 insertions(+), 33 deletions(-)
>>   delete mode 100644 arch/arm/mach-at91/lan966x.c
>>
>> --
>> 2.17.1
>>
> 
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


-- 
Nicolas Ferre
