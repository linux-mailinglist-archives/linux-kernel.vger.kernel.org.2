Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3233A41AC62
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbhI1Jy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:54:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240100AbhI1Jy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:54:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S8ZmId027256;
        Tue, 28 Sep 2021 05:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=7EW8K5vgBsIAehRfm9IChNfdKaLs+ZEwo5YfSNm5bS0=;
 b=IpF5VSy44+VSAuMVG5nEJ6pII97HDotOCk5jU8OyIXVjFaSmgIFqvnXtciQRn2fhPlvH
 3GfRic8KjGWnHOTJ8Skqqm0MtXAmtYc7qvTDMeixTOQWJ+wgfhgNzJzqPfw8v+97xU6X
 J+WrbcIktVuougiNRGIPxBTivwik61q6NBUjx8sHNAhC6xxG1Q7AhS9oTYgSd99Em4wk
 jGRR+s3ThQZPv84VEHCK5VLcXvfIhyTnOZfNc+9gk2eRWSzsEo1Zcx8ELJz3P4Ey6VXu
 TITqL88+fp1fYgCcHt8v7NcFj3d73jEA+v1Wm8XsxZWRyiYQSPJd6Jq1BHM8rU2HgGQw Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bbwqsc7pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 05:52:58 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18S9HvWe012578;
        Tue, 28 Sep 2021 05:52:58 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bbwqsc7p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 05:52:58 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18S9VpLM030623;
        Tue, 28 Sep 2021 09:52:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3b9ud92x1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 09:52:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18S9qqbV28967320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 09:52:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46D28A4069;
        Tue, 28 Sep 2021 09:52:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E55DA406F;
        Tue, 28 Sep 2021 09:52:51 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Sep 2021 09:52:51 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCHv2 0/5] arm64/irqentry: remove duplicate housekeeping of
References: <20210924132837.45994-1-kernelfans@gmail.com>
        <20210924173615.GA42068@C02TD0UTHF1T.local>
        <20210924225954.GN880162@paulmck-ThinkPad-P17-Gen-1>
        <20210927092303.GC1131@C02TD0UTHF1T.local>
        <20210928000922.GY880162@paulmck-ThinkPad-P17-Gen-1>
        <20210928083222.GA1924@C02TD0UTHF1T.local>
Date:   Tue, 28 Sep 2021 11:52:51 +0200
In-Reply-To: <20210928083222.GA1924@C02TD0UTHF1T.local> (Mark Rutland's
        message of "Tue, 28 Sep 2021 09:32:22 +0100")
Message-ID: <yt9dtui53u30.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JPWLfOxAz9ckLCaweHbKb27JfsOoePyN
X-Proofpoint-GUID: xAcvHu3TUWRPPJQTFYn0Ag2XxPES9--t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 phishscore=0 impostorscore=0 mlxlogscore=908
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Mon, Sep 27, 2021 at 05:09:22PM -0700, Paul E. McKenney wrote:
>> On Mon, Sep 27, 2021 at 10:23:18AM +0100, Mark Rutland wrote:
>> > On Fri, Sep 24, 2021 at 03:59:54PM -0700, Paul E. McKenney wrote:
>> > > On Fri, Sep 24, 2021 at 06:36:15PM +0100, Mark Rutland wrote:
>> > > > [Adding Paul for RCU, s390 folk for entry code RCU semantics]
>> > > > 
>> > > > On Fri, Sep 24, 2021 at 09:28:32PM +0800, Pingfan Liu wrote:
>> > > > > After introducing arm64/kernel/entry_common.c which is akin to
>> > > > > kernel/entry/common.c , the housekeeping of rcu/trace are done twice as
>> > > > > the following:
>> > > > >     enter_from_kernel_mode()->rcu_irq_enter().
>> > > > > And
>> > > > >     gic_handle_irq()->...->handle_domain_irq()->irq_enter()->rcu_irq_enter()
>> > > > >
>> > > > > Besides redundance, based on code analysis, the redundance also raise
>> > > > > some mistake, e.g.  rcu_data->dynticks_nmi_nesting inc 2, which causes
>> > > > > rcu_is_cpu_rrupt_from_idle() unexpected.
>> > > > 
>> > > > Hmmm...
>> > > > 
>> > > > The fundamental questionss are:
>> > > > 
>> > > > 1) Who is supposed to be responsible for doing the rcu entry/exit?
>> > > > 
>> > > > 2) Is it supposed to matter if this happens multiple times?
>> > > > 
>> > > > For (1), I'd generally expect that this is supposed to happen in the
>> > > > arch/common entry code, since that itself (or the irqchip driver) could
>> > > > depend on RCU, and if that's the case thatn handle_domain_irq()
>> > > > shouldn't need to call rcu_irq_enter(). That would be consistent with
>> > > > the way we handle all other exceptions.
>> > > > 
>> > > > For (2) I don't know whether the level of nesting is suppoosed to
>> > > > matter. I was under the impression it wasn't meant to matter in general,
>> > > > so I'm a little surprised that rcu_is_cpu_rrupt_from_idle() depends on a
>> > > > specific level of nesting.
>> > > > 
>> > > > >From a glance it looks like this would cause rcu_sched_clock_irq() to
>> > > > skip setting TIF_NEED_RESCHED, and to not call invoke_rcu_core(), which
>> > > > doesn't sound right, at least...
>> > > > 
>> > > > Thomas, Paul, thoughts?
>> > > 
>> > > It is absolutely required that rcu_irq_enter() and rcu_irq_exit() calls
>> > > be balanced.  Normally, this is taken care of by the fact that irq_enter()
>> > > invokes rcu_irq_enter() and irq_exit() invokes rcu_irq_exit().  Similarly,
>> > > nmi_enter() invokes rcu_nmi_enter() and nmi_exit() invokes rcu_nmi_exit().
>> > 
>> > Sure; I didn't mean to suggest those weren't balanced! The problem here
>> > is *nesting*. Due to the structure of our entry code and the core IRQ
>> > code, when handling an IRQ we have a sequence:
>> > 
>> > 	irq_enter() // arch code
>> > 	irq_enter() // irq code
>> > 
>> > 	< irq handler here >
>> > 
>> > 	irq_exit() // irq code
>> > 	irq_exit() // arch code
>> > 
>> > ... and if we use something like rcu_is_cpu_rrupt_from_idle() in the
>> > middle (e.g. as part of rcu_sched_clock_irq()), this will not give the
>> > expected result because of the additional nesting, since
>> > rcu_is_cpu_rrupt_from_idle() seems to expect that dynticks_nmi_nesting
>> > is only incremented once per exception entry, when it does:
>> > 
>> > 	/* Are we at first interrupt nesting level? */
>> > 	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
>> > 	if (nesting > 1)
>> > 		return false;
>> > 
>> > What I'm trying to figure out is whether that expectation is legitimate,
>> > and assuming so, where the entry/exit should happen.
>> 
>> Oooh...
>> 
>> The penalty for fooling rcu_is_cpu_rrupt_from_idle() is that RCU will
>> be unable to detect a userspace quiescent state for a non-nohz_full
>> CPU.  That could result in RCU CPU stall warnings if a user task runs
>> continuously on a given CPU for more than 21 seconds (60 seconds in
>> some distros).  And this can easily happen if the user has a CPU-bound
>> thread that is the only runnable task on that CPU.
>> 
>> So, yes, this does need some sort of resolution.
>> 
>> The traditional approach is (as you surmise) to have only a single call
>> to irq_enter() on exception entry and only a single call to irq_exit()
>> on exception exit.  If this is feasible, it is highly recommended.
>
> Cool; that's roughly what I was expecting / hoping to hear!
>
>> In theory, we could have that "1" in "nesting > 1" be a constant supplied
>> by the architecture (you would want "3" if I remember correctly) but
>> in practice could we please avoid this?  For one thing, if there is
>> some other path into the kernel for your architecture that does only a
>> single irq_enter(), then rcu_is_cpu_rrupt_from_idle() just doesn't stand
>> a chance.  It would need to compare against a different value depending
>> on what exception showed up.  Even if that cannot happen, it would be
>> better if your architecture could remain in blissful ignorance of the
>> colorful details of ->dynticks_nmi_nesting manipulations.
>
> I completely agree. I think it's much harder to keep that in check than
> to enforce a "once per architectural exception" policy in the arch code.
>
>> Another approach would be for the arch code to supply RCU a function that
>> it calls.  If there is such a function (or perhaps better, if some new
>> Kconfig option is enabled), RCU invokes it.  Otherwise, it compares to
>> "1" as it does now.  But you break it, you buy it!  ;-)
>
> I guess we could look at the exception regs and inspect the original
> context, but it sounds overkill...
>
> I think the cleanest thing is to leave this to arch code, and have the
> common IRQ code stay well clear. Unfortunately most architectures
> (including arch/arm) still need the common IRQ code to handle this, so
> we'll have to make that conditional on Kconfig, something like the below
> (build+boot tested only).
>
> If there are no objections, I'll go check who else needs the same
> treatment (IIUC at least s390 will), and spin that as a real
> patch/series.

Hmm, s390 doesn't use handle_domain_irq() and doesn't have
HANDLE_DOMAIN_IRQ set. So i don't think the patch below applies to s390.
However, i'll follow the code to make sure we're not calling
irq_enter/irq_exit twice.

> Thanks,
> Mark.
>
> ---->8----
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8df1c7102643..c59475e50e4c 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -225,6 +225,12 @@ config GENERIC_SMP_IDLE_THREAD
>  config GENERIC_IDLE_POLL_SETUP
>         bool
>  
> +config ARCH_ENTERS_IRQ
> +       bool
> +       help
> +         An architecture should select this when it performs irq entry
> +         management itself (e.g. calling irq_enter() and irq_exit()).
> +
>  config ARCH_HAS_FORTIFY_SOURCE
>         bool
>         help
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5c7ae4c3954b..fa6476bf2b4d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -16,6 +16,7 @@ config ARM64
>         select ARCH_ENABLE_MEMORY_HOTREMOVE
>         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>         select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> +       select ARCH_ENTERS_IRQ
>         select ARCH_HAS_CACHE_LINE_SIZE
>         select ARCH_HAS_DEBUG_VIRTUAL
>         select ARCH_HAS_DEBUG_VM_PGTABLE
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 4e3c29bb603c..6affa12222e0 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -677,6 +677,15 @@ int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
>  EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
>  
>  #ifdef CONFIG_HANDLE_DOMAIN_IRQ
> +
> +#ifdef ARCH_ENTERS_IRQ
> +#define handle_irq_enter()
> +#define handle_irq_exit()
> +#else
> +#define handle_irq_enter()     irq_enter()
> +#define handle_irq_exit()      irq_exit()
> +#endif
> +
>  /**
>   * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
>   *                     usually for a root interrupt controller
> @@ -693,7 +702,7 @@ int handle_domain_irq(struct irq_domain *domain,
>         struct irq_desc *desc;
>         int ret = 0;
>  
> -       irq_enter();
> +       handle_irq_enter();
>  
>         /* The irqdomain code provides boundary checks */
>         desc = irq_resolve_mapping(domain, hwirq);
> @@ -702,7 +711,7 @@ int handle_domain_irq(struct irq_domain *domain,
>         else
>                 ret = -EINVAL;
>  
> -       irq_exit();
> +       handle_irq_exit();
>         set_irq_regs(old_regs);
>         return ret;
>  }
