Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A311F39F9B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhFHO45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:56:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47802 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhFHO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:56:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 610C0219D8;
        Tue,  8 Jun 2021 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623164099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kfFLel7kBMZ/tFEEsR35uK45odZ9fNmpHy5ylGrtTLY=;
        b=fH24whE8gyop3DhwX7NGS5lrLCpwRV392lIttd50T/a3ZPKmH+BcB9JRNLShiqnZninF91
        q4/sfeMw2ueVWfGkc40Uu9KynNfZo057pL4zHyllE5ygHh5fgrjNSSIuv094QhSUGyTJOW
        rQEwx22TGHRY0KHEExHmKXU+T1jwvGc=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A4788A3B84;
        Tue,  8 Jun 2021 14:54:58 +0000 (UTC)
Date:   Tue, 8 Jun 2021 16:54:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH next v2 1/2] dump_stack: move cpu lock to printk.c
Message-ID: <YL+EwqLO8KsGqQVm@alley>
References: <20210607200232.22211-1-john.ogness@linutronix.de>
 <20210607200232.22211-2-john.ogness@linutronix.de>
 <YL9XMBxeZ4fGRS79@alley>
 <878s3kihpk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s3kihpk.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-08 15:55:35, John Ogness wrote:
> On 2021-06-08, Petr Mladek <pmladek@suse.com> wrote:
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> >
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -3532,3 +3532,78 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
> >> +void printk_cpu_lock_irqsave(bool *lock_flag, unsigned long *irq_flags)
> >> +{
> >> +	int old;
> >> +	int cpu;
> >> +
> >> +retry:
> >> +	local_irq_save(*irq_flags);
> >> +
> >> +	cpu = smp_processor_id();
> >> +
> >> +	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
> >> +	if (old == -1) {
> >> +		/* This CPU is now the owner. */
> >> +
> >
> > Superfluous space?
> 
> I was concerned that people may associate the comment with the following
> line of code. Especially in the next patch when many more lines are
> added. The comment is for the whole conditional block.
> 
> >> +		*lock_flag = true;
> >
> > The original name name "was_locked" was more descriptive. I agree that
> > it was not good for an API. What about keeping the inverted logic and
> > calling it "lock_nested" ?
> >
> > I do not resist on any change. The logic is trivial so...
> 
> I wanted it to be an opaque variable, which is why it is named so. But I
> can rename it for v3. There is no need to debate naming here.

Yup. I didn't want to block the patch because of this. I mentioned it
just for case v3 was needed and you agreed. Feel free to keep your
preferred names and spacing. I am not going to fight over it.

Best Regards,
Petr
