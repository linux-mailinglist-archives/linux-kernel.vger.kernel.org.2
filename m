Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659A335F497
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351148AbhDNNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:13:42 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:36773 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244296AbhDNNNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:13:40 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.192])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 8FE409A41E62;
        Wed, 14 Apr 2021 15:13:17 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 14 Apr
 2021 15:13:17 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-106R00692793ddd-07f1-4232-92a8-daead18c2131,
                    38A808AD2D0D3C4A59D9F430F89D181E503BD305) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.89.73.13
Subject: Re: [PATCH] genirq: reduce irqdebug bouncing cachelines
To:     Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20210402132037.574661-1-npiggin@gmail.com>
 <87im4u2vxx.ffs@nanos.tec.linutronix.de>
 <2dae4501-6f01-1b32-4b69-1dfc94c93425@kaod.org>
 <87wnt71xmm.ffs@nanos.tec.linutronix.de>
 <b299bb0c-2997-6f6f-8646-4a7ecb2c79c0@kaod.org>
 <87tuoax79f.ffs@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8f7b2768-fe69-b1eb-8fc0-dc77a394ae99@kaod.org>
Date:   Wed, 14 Apr 2021 15:13:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87tuoax79f.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 754c5738-ed00-444e-9a70-b76b5110eec9
X-Ovh-Tracer-Id: 16892157780021054429
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudeluddgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 10:24 PM, Thomas Gleixner wrote:
> On Tue, Apr 13 2021 at 14:16, Cédric Le Goater wrote:
>>>> We could test irq_settings_no_debug() directly under handle_nested_irq() 
>>>> and handle_irq_event_percpu() to avoid calling note_interrupt(), just 
>>>> like we do for noirqdebug.
>>>
>>> We can do that, but then we should not just make it:
>>>
>>>    if (!irqnodebug && !irq_settings_no_debug(desc))
>>>    	note_interrupt(...);
>>>
>>> Instead have only one condition:
>>>
>>>    if (!irq_settings_no_debug(desc))
>>>    	note_interrupt(...);
>>>
>>> See the uncompiled delta patch below.
>>
>> I merged this second part with the first and gave IRQF_NO_DEBUG a try 
>> on P8 and P9 systems and all looked fine. I should send both patches 
>> after IRQF_NO_AUTOEN is merged in mainline.     
> 
> Does having that NODEBUG flag set on the IPI irqs make a measurable
> difference or is it just too small to matter?

It does not add much benefits on the 2s and 4s systems but I will give it 
a try on bigger ones when I can grab them. Then we can decide if it is 
worth merging. 

Thanks,

C.
