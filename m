Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EAB35DE84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbhDMMRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:17:19 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:36551 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345469AbhDMMRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:17:00 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.191])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id C318499EADAF;
        Tue, 13 Apr 2021 14:16:37 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 13 Apr
 2021 14:16:37 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-100R003a97ef6b3-24da-4675-bac2-562d38c2bee5,
                    4BE79BB08BA9582E888D4556D96BF37B7B4E8F35) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.89.73.13
Subject: Re: [PATCH] genirq: reduce irqdebug bouncing cachelines
To:     Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20210402132037.574661-1-npiggin@gmail.com>
 <87im4u2vxx.ffs@nanos.tec.linutronix.de>
 <2dae4501-6f01-1b32-4b69-1dfc94c93425@kaod.org>
 <87wnt71xmm.ffs@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b299bb0c-2997-6f6f-8646-4a7ecb2c79c0@kaod.org>
Date:   Tue, 13 Apr 2021 14:16:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87wnt71xmm.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 9558eb5d-0d17-4289-a131-ed6a1f3ab400
X-Ovh-Tracer-Id: 10062448946537532381
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudekledghedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgedvieejfedvhfduhfffueevheeludffhfdvkeehleegtddttdfhieegveeghfffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

>> We could test irq_settings_no_debug() directly under handle_nested_irq() 
>> and handle_irq_event_percpu() to avoid calling note_interrupt(), just 
>> like we do for noirqdebug.
> 
> We can do that, but then we should not just make it:
> 
>    if (!irqnodebug && !irq_settings_no_debug(desc))
>    	note_interrupt(...);
> 
> Instead have only one condition:
> 
>    if (!irq_settings_no_debug(desc))
>    	note_interrupt(...);
> 
> See the uncompiled delta patch below.

I merged this second part with the first and gave IRQF_NO_DEBUG a try 
on P8 and P9 systems and all looked fine. I should send both patches 
after IRQF_NO_AUTOEN is merged in mainline.     

Thanks,

C.
