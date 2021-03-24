Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48253473CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhCXIlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:41:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:41698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhCXIlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:41:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616575274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PxMDSdG3FPE34dQL3+yxqk6XbvrySDv1MamsG1KJkTk=;
        b=vKGWrrSvKplvLhXHHXnAhJQQ7GcmXbAEIDlUMOcwilomqaipLvDDLPYaekyjsWJqsWBF7S
        qLohTm/02Rb9f2zhovhmyAouZCmBLTROMTnmQJli478T/JdkuNL2TFvFIeuFPAJY5t/lW1
        YBv27T7nzY9V7Cmma1PM53JqkGiem2A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57117AB9B;
        Wed, 24 Mar 2021 08:41:14 +0000 (UTC)
Date:   Wed, 24 Mar 2021 09:41:13 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v1 1/3] printk: track/limit recursion
Message-ID: <YFr7KSwgX/WexbXy@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-2-john.ogness@linutronix.de>
 <YFiuf/Kn9iLOwgNx@alley>
 <87czvp7e0f.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czvp7e0f.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-23 22:32:00, John Ogness wrote:
> On 2021-03-22, Petr Mladek <pmladek@suse.com> wrote:
> > On Wed 2021-03-17 00:33:24, John Ogness wrote:
> >> Track printk() recursion and limit it to 3 levels per-CPU and per-context.
> >
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 2f829fbf0a13..c666e3e43f0c 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> +/* Return a pointer to the dedicated counter for the CPU+context of the caller. */
> >> +static char *printk_recursion_counter(void)
> >> +{
> >> +	int ctx = 0;
> >> +
> >> +#ifdef CONFIG_PRINTK_NMI
> >> +	if (in_nmi())
> >> +		ctx = 1;
> >> +#endif
> >> +	if (!printk_percpu_data_ready())
> >> +		return &printk_count_early[ctx];
> >> +	return &((*this_cpu_ptr(&printk_count))[ctx]);
> >> +}
> >
> > It is not a big deal. But using an array for two contexts looks strange
> > especially when only one is used on some architectures.
> > Also &((*this_cpu_ptr(&printk_count))[ctx]) is quite tricky ;-)
> >
> > What do you think about the following, please?
> >
> > static DEFINE_PER_CPU(u8 printk_count);
> > static u8 printk_count_early;
> >
> > #ifdef CONFIG_HAVE_NMI
> > static DEFINE_PER_CPU(u8 printk_count_nmi);
> > static u8 printk_count_nmi_early;
> > #endif
> >
> > static u8 *printk_recursion_counter(void)
> > {
> > 	if (IS_ENABLED(CONFIG_HAVE_NMI) && in_nmi()) {
> > 		if (printk_cpu_data_ready())
> > 			return this_cpu_ptr(&printk_count_nmi);
> > 		return printk_count_nmi_early;
> > 	}
> >
> > 	if (printk_cpu_data_ready())
> > 		return this_cpu_ptr(&printk_count);
> > 	return printk_count_early;
> > }
> 
> I can split it into explicit variables. But is the use of the IS_ENABLED
> macro preferred over ifdef? I would prefer:
> 
> static u8 *printk_recursion_counter(void)
> {
> #ifdef CONFIG_HAVE_NMI
> 	if (in_nmi()) {
> 		if (printk_cpu_data_ready())
> 			return this_cpu_ptr(&printk_count_nmi);
> 		return printk_count_nmi_early;
> 	}
> #endif
> 	if (printk_cpu_data_ready())
> 		return this_cpu_ptr(&printk_count);
> 	return printk_count_early;
> }
> 
> Since @printk_count_nmi and @printk_count_nmi_early would not exist, I
> would prefer the pre-processor removes that code block rather than
> relying on compiler optimization.

Feel free to use #ifdef.

Best Regards,
Petr
