Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EA6377F61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhEJJbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:31:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:37572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhEJJbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:31:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620639015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLihkZcVIkvaEOMR/c+S14T+LzOAE6VV6MDzVKNIWvg=;
        b=AIUoGJFeYyZ2ExMHqZyepQFAWh2Hb9cSiSae9JKr4JhSVwFBa6IezTMgl9gtf/2wyW7NCL
        WkW3H4bA8+tdyeFFHIV5e6hI87v+ep/N3FBqbqXI5s2ryTywCKFGalASzn16bR3r1k90u3
        B8EA5vvpDpmtzzpHpGZLtaJ7UyH0UZA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF33DB034;
        Mon, 10 May 2021 09:30:14 +0000 (UTC)
Date:   Mon, 10 May 2021 11:30:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     luojiaxing <luojiaxing@huawei.com>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linuxarm@huawei.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJj9JdhgL88ivHVy@alley>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <f38cd7b9-22a4-b65d-fd37-2d95fe95fc00@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f38cd7b9-22a4-b65d-fd37-2d95fe95fc00@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-05-10 15:41:31, luojiaxing wrote:
> 
> On 2021/5/6 21:39, Petr Mladek wrote:
> Hi, Petr, I test your patch and I think it needs to make some modifications
> to fix the problem.
> 
> 
> My test method is as follows:
> Kernel thread A causes the console to enter suspend and then resume it 10
> seconds later.
> Kernel thread B repeatedly invokes dev_info() for 15 seconds after the
> console suspend.

Could you please provide the test code?

If kthread B starts invoking dev_info() after console_resume() then it
has nothing to do with suspend/resume. It can happen anytime that a
process starts a flood of printk() calls.

Also, do you see this problem in the real life, please?
What motivated you to investigate this scenario, please?

> > >From 574e844f512c9f450e64832f09cc389bc9915f83 Mon Sep 17 00:00:00 2001
> > From: Petr Mladek <pmladek@suse.com>
> > Date: Thu, 6 May 2021 12:40:56 +0200
> > Subject: [PATCH] printk: Prevent softlockup when resuming console
> > 
> > Many printk messages might get accumulated when consoles were suspended.
> > They are proceed when console_unlock() is called in resume_console().
> > 
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2637,13 +2636,15 @@ void console_unlock(void)
> >   		 * finish. This task can not be preempted if there is a
> >   		 * waiter waiting to take over.
> >   		 */
> > -		console_lock_spinning_enable();
> > +		if (spinning_enabled)
> > +			console_lock_spinning_enable();
> 
> 
> change to
> 
> 
> +               if (!spinning_enabled) {
> +                       raw_spin_lock(&console_owner_lock);
> +                       WRITE_ONCE(console_waiter, true);
> +                       raw_spin_unlock(&console_owner_lock);
> +               }
> 

IMHO, both variants have the same result and behavior:

console_trylock_spinning() has the following condition:

	if (!waiter && owner && owner != current) {
		WRITE_ONCE(console_waiter, true);
		spin = true;
	}

My variant causes that @owner will stay "NULL".
Your variant causes that @waiter will be "true"

In both cases, the condition fails and spin will stay "false"
which means that any parallel printk() will not spin.

Best Regards,
Petr
