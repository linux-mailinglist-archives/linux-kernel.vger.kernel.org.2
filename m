Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EEC452FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhKPLGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:06:11 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:54033 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234637AbhKPLFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:05:30 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 06:05:30 EST
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.240])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id E001BCBCDEA1;
        Tue, 16 Nov 2021 11:27:10 +0100 (CET)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 16 Nov
 2021 11:27:10 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-101G00488e9d7c1-0317-46b2-b738-c13bf1602699,
                    BFAEB7FE3C4E2C4D96001007C3BA12B7689A693E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <50482eb9-389c-0114-ba21-988f1fce493c@kaod.org>
Date:   Tue, 16 Nov 2021 11:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 16/39] irqdomain: Make normal and nomap irqdomains
 exclusive
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Greg Kurz <groug@kaod.org>
References: <20210520163751.27325-1-maz@kernel.org>
 <20210520163751.27325-17-maz@kernel.org>
 <1fe9d629-0f5f-4807-b97c-77b3b3c7de72@kaod.org>
 <87a6i48pp5.wl-maz@kernel.org>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <87a6i48pp5.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: a0750013-07d5-4706-bb9b-93a98d531333
X-Ovh-Tracer-Id: 9763241045856979750
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrfedvgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhhfelgeeukedtteffvdffueeiuefgkeekleehleetfedtgfetffefheeugeelheenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehgrhhouhhgsehkrghougdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

>> This patch is breaking the POWER9/POWER10 XIVE driver (these are not
>> old PPC systems :) on machines sharing the same LSI HW IRQ. For instance,
>> a linux KVM guest with a virtio-rng and a virtio-balloon device. In that
>> case, Linux creates two distinct IRQ mappings which can lead to some
>> unexpected behavior.
> 
> Either the irq domain translates, or it doesn't. If the driver creates
> a nomap domain, and yet expects some sort of translation to happen,
> then the driver is fundamentally broken. And even without that: how do
> you end-up with a single HW interrupt having two mappings?
> 
>> A fix to go forward would be to change the XIVE IRQ domain to use a
>> 'Tree' domain for reverse mapping and not the 'No Map' domain mapping.
>> I will keep you updated for XIVE.
> 
> I bet there is a bit more to it. From what you are saying above,
> something rather ungodly is happening in the XIVE code.

It's making progress.

This change in irq_find_mapping() is what 'breaks' XIVE :

   +       if (irq_domain_is_nomap(domain)) {
   +               if (hwirq < domain->revmap_size) {
   +                      data = irq_domain_get_irq_data(domain, hwirq);
   +                      if (data && data->hwirq == hwirq)
   +                               return hwirq;
   +               }
   +
   +               return 0;


With the introduction of IRQ_DOMAIN_FLAG_NO_MAP, the revmap_tree lookup
is skipped and the previously mapped IRQ is not found. XIVE was relying
on a side effect of irq_domain_set_mapping() which is not true anymore.

I guess the easiest fix for 5.14 and 5.15 (in which was introduced MSI
domains) is to change the XIVE IRQ domain to a domain tree. Since the HW
can handle 1MB interrupts, this looks like a better choice for the driver.

Thanks,

C.
