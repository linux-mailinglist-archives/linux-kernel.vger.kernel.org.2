Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC43197F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 02:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBLBTl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Feb 2021 20:19:41 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3019 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBLBTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 20:19:36 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DcFwb3mh3zRCWT;
        Fri, 12 Feb 2021 09:17:35 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 12 Feb 2021 09:18:52 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 12 Feb 2021 09:18:52 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Fri, 12 Feb 2021 09:18:52 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "funaho@jurai.org" <funaho@jurai.org>,
        "philb@gnu.org" <philb@gnu.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC] IRQ handlers run with some high-priority interrupts(not NMI)
 enabled on some platform
Thread-Topic: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
Thread-Index: AdcA2xDwQTa7W6j6SmS4J3iBnsSynA==
Date:   Fri, 12 Feb 2021 01:18:52 +0000
Message-ID: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.23]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting a very long debate with Finn in this thread:
https://lore.kernel.org/lkml/1612697823-8073-1-git-send-email-tanxiaofei@huawei.com/

In short, the debate is about if high-priority IRQs (*not NMI*)
are allowed to preempt an running IRQ handler in hardIRQ context.

In my understanding, right now IRQ handlers are running with *all* interrupts
disabled since this commit and IRQF_DISABLED was dropped:
e58aa3d2d0cc
genirq: Run irq handlers with interrupts disabled

b738a50a2026
genirq: Warn when handler enables interrupts
We run all handlers with interrupts disabled and expect them not to
enable them. Warn when we catch one who does.

While it seems to be true in almost all platforms, it seems to be
false on m68k.

According to Finn, while IRQ handlers are running, high-priority
interrupts can still jump out on m68k. A driver which is handling
this issue is here: drivers/net/ethernet/natsemi/sonic.c.
you can read the comment:
static irqreturn_t sonic_interrupt(int irq, void *dev_id)
{
	struct net_device *dev = dev_id;
	struct sonic_local *lp = netdev_priv(dev);
	int status;
	unsigned long flags;

	/* The lock has two purposes. Firstly, it synchronizes sonic_interrupt()
	 * with sonic_send_packet() so that the two functions can share state.
	 * Secondly, it makes sonic_interrupt() re-entrant, as that is required
	 * by macsonic which must use two IRQs with different priority levels.
	 */
	spin_lock_irqsave(&lp->lock, flags);

	status = SONIC_READ(SONIC_ISR) & SONIC_IMR_DEFAULT;
	if (!status) {
		spin_unlock_irqrestore(&lp->lock, flags);

		return IRQ_NONE;
	}
}

So m68k does allow a high-priority interrupt to preempt
a hardIRQ so the code needs to call irqsave to protect
this risk. That is to say, some interrupts are not disabled
during hardIRQ of m68k.

But m68k doesn't trigger any warning for !irqs_disabled() in
genirq:
irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags)
{
	...

		trace_irq_handler_entry(irq, action);
		res = action->handler(irq, action->dev_id);
		trace_irq_handler_exit(irq, action, res);

		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",
			      irq, action->handler))
			local_irq_disable();
}

The reason is:
* arch_irqs_disabled() return true while low-priority interrupts are disabled
though high-priority interrupts are still open;
* local_irq_disable, spin_lock_irqsave() etc will disable high-priority interrupt
(IPL 7);
* arch_irqs_disabled() also return true while both low and high priority interrupts
interrupts are disabled.
Note m68k has several interrupt levels. But in the above description, I simply
abstract them as high and low to help the understanding.

I think m68k lets arch_irq_disabled() return true in relatively weaker condition
to pretend all IRQs are disabled while high-priority IRQ is still open, thus
pass all sanitizing check in genirq and kernel core. But Finn strongly disagreed.

I am not saying I am right and Finn is wrong. But I think we need somewhere to clarify
this problem.

Personally, I would prefer "interrupts disabled" mean "all except NMI", So I'd like to
guard this by:

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 7c9d6a2d7e90..b8ca27555c76 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -32,6 +32,7 @@ static __always_inline void rcu_irq_enter_check_tick(void)
  */
 #define __irq_enter()                                  \
        do {                                            \
+               WARN_ONCE(in_hardirq() && irqs_disabled(), "nested
interrupts\n"); \
                preempt_count_add(HARDIRQ_OFFSET);      \
                lockdep_hardirq_enter();                \
                account_hardirq_enter(current);         \
@@ -44,6 +45,7 @@ static __always_inline void rcu_irq_enter_check_tick(void)
  */
 #define __irq_enter_raw()                              \
        do {                                            \
+               WARN_ONCE(in_hardirq() && irqs_disabled(), " nested
interrupts\n"); \
                preempt_count_add(HARDIRQ_OFFSET);      \
                lockdep_hardirq_enter();                \
        } while (0)

Though Finn thought it lacks any justification

So I am requesting comments on:
1. are we expecting all interrupts except NMI to be disabled in irq handler,
or do we actually allow some high-priority interrupts between low and NMI to
come in some platforms?

2. If either side is true, I think we need to document it somewhere as there
is always confusion about this.

Personally, I would expect all interrupts to be disabled and I like the way
of ARM64 to only use high-priority interrupt as pseudo NMI:
https://lwn.net/Articles/755906/
Though Finn argued that this will contribute to lose hardware feature of m68k.

Thanks
Barry
