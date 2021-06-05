Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0D39C529
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFECeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:34:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33053 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbhFECe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:34:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622860362; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/RdTDTU8V3aAJAo21nijd68BuWTZQx28IJoONmF0Ks8=;
 b=lxozf/kdaEQUZI3rPRzIO4cji8Y2vg+/jPji1+IQIfIVh/pfRJhbvtyF+lhx9A6cEvGvnjIm
 AGr7SDd/uPgdxO+l71V31HR6O64omYi+Xmy1CBeYwQ3K14UqN3aEeKzIh8jkIOrXV9sARtny
 9lPZamR7q9+Evs+I+IwltGVLLXQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60bae231f726fa4188a80a0b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 05 Jun 2021 02:32:17
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB272C433F1; Sat,  5 Jun 2021 02:32:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 838FBC4338A;
        Sat,  5 Jun 2021 02:32:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 05 Jun 2021 08:02:13 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     tglx@linutronix.de
Cc:     Jisheng.Zhang@synaptics.com, afzal.mohd.ma@gmail.com,
        akpm@linux-foundation.org, corbet@lwn.net, gpiccoli@canonical.com,
        gustavo@embeddedor.com, helgaas@kernel.org, ilina@codeaurora.org,
        kernelfans@gmail.com, kexec@lists.infradead.org,
        linus.walleij@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org,
        mike.kravetz@oracle.com, mkshah@codeaurora.org, oneukum@suse.com,
        pawan.kumar.gupta@linux.intel.com, peterz@infradead.org,
        pmladek@suse.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] warn and suppress irqflood
In-Reply-To: <20210302074556.23998-1-saiprakash.ranjan@codeaurora.org>
References: <87tuueftou.fsf@nanos.tec.linutronix.de>
 <20210302074556.23998-1-saiprakash.ranjan@codeaurora.org>
Message-ID: <5a547a75b621e9919cd7f4706306c0e0@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2021-03-02 13:15, Sai Prakash Ranjan wrote:
> Hi Thomas,
> 
>> On Wed, Oct 28, 2020 at 12:58:41PM +0100, Thomas Gleixner wrote:
>> 
> 
> <snip>...
> 
>> Something like the completly untested below should work independent of
>> config options.
>> 
>> Thanks,
>> 
>>         tglx
>> ---
>>  include/linux/irqdesc.h |    4 ++
>>  kernel/irq/manage.c     |    3 +
>>  kernel/irq/spurious.c   |   74 
>> +++++++++++++++++++++++++++++++++++-------------
>>  3 files changed, 61 insertions(+), 20 deletions(-)
>> 
>> --- a/include/linux/irqdesc.h
>> +++ b/include/linux/irqdesc.h
>> @@ -30,6 +30,8 @@ struct pt_regs;
>>   * @tot_count:		stats field for non-percpu irqs
>>   * @irq_count:		stats field to detect stalled irqs
>>   * @last_unhandled:	aging timer for unhandled count
>> + * @storm_count:	Counter for irq storm detection
>> + * @storm_checked:	Timestamp for irq storm detection
>>   * @irqs_unhandled:	stats field for spurious unhandled interrupts
>>   * @threads_handled:	stats field for deferred spurious detection of 
>> threaded handlers
>>   * @threads_handled_last: comparator field for deferred spurious 
>> detection of theraded handlers
>> @@ -65,6 +67,8 @@ struct irq_desc {
>>  	unsigned int		tot_count;
>>  	unsigned int		irq_count;	/* For detecting broken IRQs */
>>  	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
>> +	unsigned long		storm_count;
>> +	unsigned long		storm_checked;
>>  	unsigned int		irqs_unhandled;
>>  	atomic_t		threads_handled;
>>  	int			threads_handled_last;
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -1581,6 +1581,9 @@ static int
>>  	if (!shared) {
>>  		init_waitqueue_head(&desc->wait_for_threads);
>> 
>> +		/* Take a timestamp for interrupt storm detection */
>> +		desc->storm_checked = jiffies;
>> +
>>  		/* Setup the type (level, edge polarity) if configured: */
>>  		if (new->flags & IRQF_TRIGGER_MASK) {
>>  			ret = __irq_set_trigger(desc,
>> --- a/kernel/irq/spurious.c
>> +++ b/kernel/irq/spurious.c
>> @@ -21,6 +21,7 @@ static void poll_spurious_irqs(struct ti
>>  static DEFINE_TIMER(poll_spurious_irq_timer, poll_spurious_irqs);
>>  static int irq_poll_cpu;
>>  static atomic_t irq_poll_active;
>> +static unsigned long irqstorm_limit __ro_after_init;
>> 
>>  /*
>>   * We wait here for a poller to finish.
>> @@ -189,18 +190,21 @@ static inline int bad_action_ret(irqretu
>>   * (The other 100-of-100,000 interrupts may have been a correctly
>>   *  functioning device sharing an IRQ with the failing one)
>>   */
>> -static void __report_bad_irq(struct irq_desc *desc, irqreturn_t 
>> action_ret)
>> +static void __report_bad_irq(struct irq_desc *desc, irqreturn_t 
>> action_ret,
>> +			     bool storm)
>>  {
>>  	unsigned int irq = irq_desc_get_irq(desc);
>>  	struct irqaction *action;
>>  	unsigned long flags;
>> 
>> -	if (bad_action_ret(action_ret)) {
>> -		printk(KERN_ERR "irq event %d: bogus return value %x\n",
>> -				irq, action_ret);
>> -	} else {
>> -		printk(KERN_ERR "irq %d: nobody cared (try booting with "
>> +	if (!storm) {
>> +		if (bad_action_ret(action_ret)) {
>> +			pr_err("irq event %d: bogus return value %x\n",
>> +			       irq, action_ret);
>> +		} else {
>> +			pr_err("irq %d: nobody cared (try booting with "
>>  				"the \"irqpoll\" option)\n", irq);
>> +		}
>>  	}
>>  	dump_stack();
>>  	printk(KERN_ERR "handlers:\n");
>> @@ -228,7 +232,7 @@ static void report_bad_irq(struct irq_de
>> 
>>  	if (count > 0) {
>>  		count--;
>> -		__report_bad_irq(desc, action_ret);
>> +		__report_bad_irq(desc, action_ret, false);
>>  	}
>>  }
>> 
>> @@ -267,6 +271,33 @@ try_misrouted_irq(unsigned int irq, stru
>>  	return action && (action->flags & IRQF_IRQPOLL);
>>  }
>> 
>> +static void disable_stuck_irq(struct irq_desc *desc, irqreturn_t 
>> action_ret,
>> +			      const char *reason, bool storm)
>> +{
>> +	__report_bad_irq(desc, action_ret, storm);
>> +	pr_emerg("Disabling %s IRQ #%d\n", reason, irq_desc_get_irq(desc));
>> +	desc->istate |= IRQS_SPURIOUS_DISABLED;
>> +	desc->depth++;
>> +	irq_disable(desc);
>> +}
>> +
>> +/* Interrupt storm detector for runaway interrupts (handled or not). 
>> */
>> +static bool irqstorm_detected(struct irq_desc *desc)
>> +{
>> +	unsigned long now = jiffies;
>> +
>> +	if (++desc->storm_count < irqstorm_limit) {
>> +		if (time_after(now, desc->storm_checked + HZ)) {
>> +			desc->storm_count = 0;
>> +			desc->storm_checked = now;
>> +		}
>> +		return false;
>> +	}
>> +
>> +	disable_stuck_irq(desc, IRQ_NONE, "runaway", true);
>> +	return true;
>> +}
>> +
>>  #define SPURIOUS_DEFERRED	0x80000000
>> 
>>  void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
>> @@ -403,24 +434,16 @@ void note_interrupt(struct irq_desc *des
>>  			desc->irqs_unhandled -= ok;
>>  	}
>> 
>> +	if (unlikely(irqstorm_limit && irqstorm_detected(desc)))
>> +		return;
>> +
>>  	desc->irq_count++;
>>  	if (likely(desc->irq_count < 100000))
>>  		return;
>> 
>>  	desc->irq_count = 0;
>>  	if (unlikely(desc->irqs_unhandled > 99900)) {
>> -		/*
>> -		 * The interrupt is stuck
>> -		 */
>> -		__report_bad_irq(desc, action_ret);
>> -		/*
>> -		 * Now kill the IRQ
>> -		 */
>> -		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
>> -		desc->istate |= IRQS_SPURIOUS_DISABLED;
>> -		desc->depth++;
>> -		irq_disable(desc);
>> -
>> +		disable_stuck_irq(desc, action_ret, "unhandled", false);
>>  		mod_timer(&poll_spurious_irq_timer,
>>  			  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
>>  	}
>> @@ -462,5 +485,16 @@ static int __init irqpoll_setup(char *st
>>  				"performance\n");
>>  	return 1;
>>  }
>> -
>>  __setup("irqpoll", irqpoll_setup);
>> +
>> +static int __init irqstorm_setup(char *arg)
>> +{
>> +	int res = kstrtoul(arg, 0, &irqstorm_limit);
>> +
>> +	if (!res) {
>> +		pr_info("Interrupt storm detector enabled. Limit=%lu / s\n",
>> +			irqstorm_limit);
>> +	}
>> +	return !!res;
>> +}
>> +__setup("irqstorm_limit", irqstorm_setup);
> 
> This irq storm detection feature is very useful, any chance to get this 
> merged?
> We will be happy to test. People seem to be having their own copy of
> such feature
> out-of-tree [1].
> 
> [1]
> https://elinux.org/images/d/de/Oct28_InterruptStormDetectionFeature_KentoKobayashi.pdf
> 

Any chance of having this useful debug feature in upstream kernel?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
