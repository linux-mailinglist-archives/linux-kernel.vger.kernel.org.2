Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE3381A1C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhEORVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 13:21:42 -0400
Received: from 5.mo52.mail-out.ovh.net ([188.165.45.220]:38296 "EHLO
        5.mo52.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhEORVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:21:40 -0400
X-Greylist: delayed 1138 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 May 2021 13:21:39 EDT
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.206])
        by mo52.mail-out.ovh.net (Postfix) with ESMTPS id AC3FC274AC4;
        Sat, 15 May 2021 19:01:27 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.10; Sat, 15 May
 2021 19:01:24 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-95G0017059047b-b38a-4751-9eef-8f92e1973d78,
                    30864F63682E1C8B156C6C04D354283F0418D16C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
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
Message-ID: <7a8ad02f-63a8-c1aa-fdd1-39d973593d02@kaod.org>
Date:   Sat, 15 May 2021 19:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87tuoax79f.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: fb12255e-f89a-4433-9509-acd5864595f8
X-Ovh-Tracer-Id: 18331620808367836125
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdeitddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehuedtheeghfdvhedtueelteegvdefueektdefiefhffffieduuddtudfhgfevtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggv
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

Here are some ipistorm results on a P10 system with 12 activated chips, 
each with ~120 HW threads. The kernel is a 5.12 plus extras : 

  - XIVE IPI IRQ domain patchset (merged in 5.13-rc1)
  - MSI IRQ domain pachset (should not have any impact)
  - your IRQF_NO_DEBUG patch.

There is some slight improvement on the first 4 chips but it gets
better when we reach the fifth which requires an extra hop on the
bus. On 12 chips, we are close to an extra 9%. 

Given these results, I think it would good to have the IRQF_NO_DEBUG 
flag. 

Thanks,

C.

[*] https://github.com/antonblanchard/ipistorm


                         Mint/s

chips   cpus              IRQF_NO_DEBUG
---------------------------------------
0         15       4.32         4.32   
          31       8.63         8.65   
          47      12.86        12.89  
          63      17.11        17.16  
          79      21.29        21.40  
          95      25.45        25.67  
         111      29.61        29.80  
1        127      33.53        33.64  
         143      37.55        37.77  
         159      41.50        41.78  
         175      45.42        45.63  
         191      49.39        49.51  
         207      53.27        53.61  
         223      57.17        57.73  
         239      61.05        61.59  
2        255      64.94        65.69  
         271      65.20        62.62  
         287      62.20        65.18  
         303      63.96        67.69  
         319      65.74        69.95  
         335      67.45        71.84  
         351      69.63        72.75  
3        367      70.96        74.38  
         383      72.34        75.62  
         399      74.26        77.69  
         415      76.49        79.78  
         431      78.46        81.67  
         447      79.87        82.50  
         463      82.07        85.13  
         479      83.95        87.03  
4        495      87.67        92.94  
         511      93.70        98.74  
         527      95.43       101.45 
         543      97.39       103.39 
         559      98.95       104.76 
         575     100.08       105.70 
         591     101.26       107.06 
         607     102.17       108.16 
5        623     103.27       109.44 
         639     104.95       111.14 
         655     106.59       112.36 
         671     107.92       113.72 
         687     108.75       115.25 
         703     109.84       117.06 
         719     110.99       118.45 
6        735     112.30       119.07 
         751     114.19       120.72 
         767     115.59       122.70 
         783     116.69       124.80 
         799     118.62       126.38 
         815     120.38       128.36 
         831     120.78       129.15 
         847     122.69       130.44 
7        863     123.65       132.44 
         879     124.78       133.83 
         895     126.58       135.43 
         911     128.02       136.85 
         927     130.48       138.98 
         943     130.98       140.58 
         959     132.17       141.74 
8        975     134.55       142.62 
         991     134.89       143.82 
        1007     135.64       145.51
        1023     137.23       147.22
        1039     139.37       149.85
        1055     141.80       150.27
        1071     141.37       152.33
        1087     143.08       153.20
9       1103     144.83       154.23
        1119     144.55       155.96
        1135     147.32       157.91
        1151     148.31       159.04
        1167     150.67       160.41
        1183     149.44       161.82
        1199     152.53       164.69
        1215     153.51       165.31
10      1231     154.88       166.67
        1247     156.06       168.40
        1263     157.59       170.01
        1279     158.74       172.10
        1295     159.55       172.79
        1311     160.74       173.62
        1327     161.86       175.02
11      1343     163.75       175.95
        1359     163.67       177.96
        1375     164.95       178.94
        1391     166.53       180.09
        1407     167.17       181.25
        1423     168.84       183.94
        1439     170.20       183.96
        1455     170.47       185.47
        

From 130eb33a02eb9d98fd8d8148e420b7b7b243bb93 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 2 Apr 2021 08:23:25 +0200
Subject: [PATCH] genirq: Add a IRQF_NO_DEBUG flag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The whole call to note_interrupt() can be avoided or return early when
interrupts would be marked accordingly. For IPI handlers which always
return HANDLED the whole procedure is pretty pointless to begin with.

Add a IRQF_NO_DEBUG flag.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/linux/interrupt.h |  3 +++
 include/linux/irq.h       |  2 ++
 kernel/irq/settings.h     | 12 ++++++++++++
 kernel/irq/chip.c         |  2 +-
 kernel/irq/handle.c       |  2 +-
 kernel/irq/manage.c       |  5 +++++
 6 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4777850a6dc7..a52109c3f3a4 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -64,6 +64,8 @@
  * IRQF_NO_AUTOEN - Don't enable IRQ or NMI automatically when users request it.
  *                Users will enable it explicitly by enable_irq() or enable_nmi()
  *                later.
+ * IRQF_NO_DEBUG - Exclude from runnaway detection for IPI and similar handlers,
+ *		   depends on IRQF_PERCPU.
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -78,6 +80,7 @@
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
 #define IRQF_NO_AUTOEN		0x00080000
+#define IRQF_NO_DEBUG		0x00100000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 31b347c9f8dd..8e9a9ae471a6 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -72,6 +72,7 @@ enum irqchip_irq_state;
  *				  mechanism and from core side polling.
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
  * IRQ_HIDDEN			- Don't show up in /proc/interrupts
+ * IRQ_NO_DEBUG			- Exclude from note_interrupt() debugging
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -99,6 +100,7 @@ enum {
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
 	IRQ_HIDDEN		= (1 << 20),
+	IRQ_NO_DEBUG		= (1 << 21),
 };
 
 #define IRQF_MODIFY_MASK	\
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 403378b9947b..7b7efb1a114b 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -18,6 +18,7 @@ enum {
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
 	_IRQ_HIDDEN		= IRQ_HIDDEN,
+	_IRQ_NO_DEBUG		= IRQ_NO_DEBUG,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -33,6 +34,7 @@ enum {
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
 #define IRQ_HIDDEN		GOT_YOU_MORON
+#define IRQ_NO_DEBUG		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -174,3 +176,13 @@ static inline bool irq_settings_is_hidden(struct irq_desc *desc)
 {
 	return desc->status_use_accessors & _IRQ_HIDDEN;
 }
+
+static inline void irq_settings_set_no_debug(struct irq_desc *desc)
+{
+	desc->status_use_accessors |= _IRQ_NO_DEBUG;
+}
+
+static inline bool irq_settings_no_debug(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_NO_DEBUG;
+}
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8cc8e5713287..7f04c7d8296e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -481,7 +481,7 @@ void handle_nested_irq(unsigned int irq)
 	for_each_action_of_desc(desc, action)
 		action_ret |= action->thread_fn(action->irq, action->dev_id);
 
-	if (!noirqdebug)
+	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, action_ret);
 
 	raw_spin_lock_irq(&desc->lock);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 762a928e18f9..221d80c31e94 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -197,7 +197,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
 
 	add_interrupt_randomness(desc->irq_data.irq, flags);
 
-	if (!noirqdebug)
+	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, retval);
 	return retval;
 }
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4c14356543d9..7bdd09e7d5f0 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1686,8 +1686,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		if (new->flags & IRQF_PERCPU) {
 			irqd_set(&desc->irq_data, IRQD_PER_CPU);
 			irq_settings_set_per_cpu(desc);
+			if (new->flags & IRQF_NO_DEBUG)
+				irq_settings_set_no_debug(desc);
 		}
 
+		if (noirqdebug)
+			irq_settings_set_no_debug(desc);
+
 		if (new->flags & IRQF_ONESHOT)
 			desc->istate |= IRQS_ONESHOT;
 
-- 
2.31.1
