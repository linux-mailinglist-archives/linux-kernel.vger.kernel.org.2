Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A471342092A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhJDKN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:13:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:38621 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhJDKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633342291; x=1664878291;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qLcpqz+iRRKrosQS6DZLyFyiCeY52+B1R8A+oMdkn90=;
  b=fptvREj/Z9eoZELMFLQsIoOLq0XWQLJzvwsitqzH9PzKStWq3xbNuo2b
   N52nBm9bhWG0AQW5K2KDwePBzdHNYTimgjOK+Z+MLdnCCv1PiJ6K6pTiJ
   xZsSMcBvYASnMdptQcS4QFw7iuF988dgtz8gLRCzu/U1HQr83WZ/VWWN0
   23PRCOvD+nDi3EevHT89lrs7EZh4RWjSJqaCONOxFcPOdKDl75iYz5lYt
   vbW+6WQqHidEInan1ihwVcRrnPI3FtYiMDgeIrH+00SpfYJELFMX+4X7d
   txSkB1qu6E/zTfa3cilK+fXvZW3SX17pjC791BTTzthIbzCWPucaTbbqi
   w==;
IronPort-SDR: FvH2JJpRMwzdVoKsO661SwLMjbFDpZK1OPBnnh/hw5vhgfiZfrwnW08HcbngdGRN6lf/9JnHDK
 S9vpnjtrqb60e1c8d4MWn4VtrPETNY7tVJqVfe7d+1VowEYlDprWtteC05U1lSA51sOT0oG/nG
 WhsP5jVs9jwU9XNOQ/lMhpSCjLDdjqvkWqsrQaXQ/VpOOFPyo/KmM+lQuomsl+SnWpPN+aU1Ph
 3CKJu1vO34ve3BBaqMBU7MuqLMRrT5Gb6OQELtIer1lVUKmILCAWLqqo+5rY28DWqvz2uhnV1U
 MRp8gEOgd1gZEjybHtWhLI28
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="71596531"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 03:11:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 03:11:28 -0700
Received: from [10.12.73.58] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 4 Oct 2021 03:11:26 -0700
Subject: Re: [PATCH 2/3] ARM: at91: pm: group constants and addresses loading
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Ludovic Desroches - M43218 <Ludovic.Desroches@microchip.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
 <20210928084257.2188017-3-claudiu.beznea@microchip.com>
 <YVLn4WScnmybTzy1@piout.net>
 <fe93c4ae-4ac4-02e2-ce4a-03ead76e65e6@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <98829cc8-ee9b-d600-58d7-eb3d74263c9c@microchip.com>
Date:   Mon, 4 Oct 2021 12:11:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fe93c4ae-4ac4-02e2-ce4a-03ead76e65e6@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2021 at 12:16, Claudiu Beznea - M18063 wrote:
> On 28.09.2021 13:01, Alexandre Belloni wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hello,
>>
>> On 28/09/2021 11:42:56+0300, Claudiu Beznea wrote:
>>> Group constants and addresses loading. This commit prepares the field for
>>> the next one. Added fixes tag on this commit as the next one will fail
>>> to apply if backported alone to older kernels.
>>
>> The proper notation is to use Depends-on: on the next patch.
> 
> At the moment this patch has no sha1 associated so I will ask Nicolas to
> add the Depends-on when he will take it. Do you see other options?

Depends-on added when queuing on at91-fixes.

Thanks, best regards,
   Nicolas

>>> Fixes: f0bbf17958e8 ("ARM: at91: pm: add self-refresh support for sama7g5")
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>> ---
>>>   arch/arm/mach-at91/pm_suspend.S | 17 +++++++++--------
>>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
>>> index cbd61a3bcab1..34f251fdb743 100644
>>> --- a/arch/arm/mach-at91/pm_suspend.S
>>> +++ b/arch/arm/mach-at91/pm_suspend.S
>>> @@ -1014,6 +1014,15 @@ ENTRY(at91_pm_suspend_in_sram)
>>>        mov     tmp1, #0
>>>        mcr     p15, 0, tmp1, c7, c10, 4
>>>
>>> +     ldr     tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
>>> +     str     tmp1, .mckr_offset
>>> +     ldr     tmp1, [r0, #PM_DATA_PMC_VERSION]
>>> +     str     tmp1, .pmc_version
>>> +     ldr     tmp1, [r0, #PM_DATA_MEMCTRL]
>>> +     str     tmp1, .memtype
>>> +     ldr     tmp1, [r0, #PM_DATA_MODE]
>>> +     str     tmp1, .pm_mode
>>> +
>>>        ldr     tmp1, [r0, #PM_DATA_PMC]
>>>        str     tmp1, .pmc_base
>>>        ldr     tmp1, [r0, #PM_DATA_RAMC0]
>>> @@ -1022,14 +1031,6 @@ ENTRY(at91_pm_suspend_in_sram)
>>>        str     tmp1, .sramc1_base
>>>        ldr     tmp1, [r0, #PM_DATA_RAMC_PHY]
>>>        str     tmp1, .sramc_phy_base
>>> -     ldr     tmp1, [r0, #PM_DATA_MEMCTRL]
>>> -     str     tmp1, .memtype
>>> -     ldr     tmp1, [r0, #PM_DATA_MODE]
>>> -     str     tmp1, .pm_mode
>>> -     ldr     tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
>>> -     str     tmp1, .mckr_offset
>>> -     ldr     tmp1, [r0, #PM_DATA_PMC_VERSION]
>>> -     str     tmp1, .pmc_version
>>>        /* Both ldrne below are here to preload their address in the TLB */
>>>        ldr     tmp1, [r0, #PM_DATA_SHDWC]
>>>        str     tmp1, .shdwc
>>> --
>>> 2.25.1
>>>
>>
>> --
>> Alexandre Belloni, co-owner and COO, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
>>
> 


-- 
Nicolas Ferre
