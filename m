Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73587377FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhEJJvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:51:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhEJJvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:51:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620640234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uu8yR1uIVsZTgHnVx1Jfk+F5cIpkWGO6K0/OsAAHQRY=;
        b=CzZbVJxwnfxLS0kWfb+cBt4BbD7DpYTAfk8TOQYAIjEnItBxjcHn4I5bADczg/ICCXklJ+
        C6VhVC4ZSV2Iuxzg1pF70pBvE1DQtDBr6zzbl2OboA2E1ya0A76z3zK5hsXXfS+ittwI4N
        Yz+eEwUvlGx5+pn5yCS8HZkIWMbz00Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5DB31ACF6;
        Mon, 10 May 2021 09:50:34 +0000 (UTC)
Date:   Mon, 10 May 2021 11:50:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     luojiaxing <luojiaxing@huawei.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJkB6SedDHe3FlGI@alley>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <YJP4F1UIt/eRZ96s@google.com>
 <YJVnNQ7RGvx9JKxV@alley>
 <46df3838-e1a6-ee95-b398-bef0896d2b03@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46df3838-e1a6-ee95-b398-bef0896d2b03@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-05-10 16:29:11, luojiaxing wrote:
> 
> On 2021/5/8 0:13, Petr Mladek wrote:
> > On Thu 2021-05-06 23:07:19, Sergey Senozhatsky wrote:
> > > Thanks for Cc-ing Petr
> > > 
> > > On (21/05/06 15:39), Petr Mladek wrote:
> > > > Many printk messages might get accumulated when consoles were suspended.
> > > > They are proceed when console_unlock() is called in resume_console().
> > > > 
> > > > The possibility to pass the console lock owner was added to reduce the risk
> > > > of softlockup when too many messages were handled in an atomic context.
> > > > 
> > > > Now, resume_console() is always in a preemptible context that is safe
> > > > to handle all accumulated messages. The possibility to pass the console
> > > > lock owner actually makes things worse. The new owner might be in an atomic
> > > > context and might cause softlockup when processing all messages accumulated
> > > > when the console was suspended.
> > > > 
> > > > Create new console_unlock_preemptible() that will not allow to pass
> > > > the console lock owner. As a result, all accumulated messages will
> > > > be proceed in the safe preemptible process.
> > > If we have a lot of pending messages in the logbuf, then there is
> > > something chatty - some context (task, irq) or maybe several contexts.
> > > And those contexts can continue adding messages, while we print them
> > > _exclusively_ from preemptible context only. without ever throttling down
> > > printk() callers - something that console_owner spinning and handover
> > > does for us. And those printk() callers can even preempt
> > > console_unlock_preemptible() and cause delays and lost messages.
> > Luo, please, correct me if I am wrong.
> 
> 
> Hi, Petr, I reply the test result on your first reply for this patch.
> 
> Please check it when you are free.
> 
> 
> > 
> > This patch a about one well defined scenario. The messages are
> > accumulated between suspend_console() and resume_console().
> > It is "small" part of the system hibernation. And we need
> > to get them out now. There might be many if something special
> > was debugged.
> > 
> > I am pretty sure that Luo did not see any flood of messages:
> > 
> >     + Flood in more contexts would be balanced by switching
> >       the console_owner.
> > 
> >     + Flood in one context would be naturally throttled because
> >       this context will become the console_owner.
> > 
> > In each case, these messages would be generated after
> > console_resume(). Luo's original patch was explicitly talking
> > about messages accumulated during the suspend.
> > 
> > Luo, could you please provide some log showing the problem?
> 
> 
> Sure, But, it is not easy to find that the printk got such problem in the
> user's logs.
> 
> So I'm attaching a log of the simulation test. You can clearly see that the
> driver thread calling dev_info() is blocked.
> 
> 
> My test method is as follows:
> Kernel thread A causes the console to enter suspend and then resume it 10
> seconds later.
> Kernel thread B repeatedly invokes dev_info() for 15 seconds after the
> console suspend.
> 
> 
> Part of dmesg log I save before:
> 
> [  288.013869] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  288.013870] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  288.013871] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  288.013872] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  288.013873] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  288.013874] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  288.013875] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  288.013876] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  288.013877] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  289.670256] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  299.286325] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  299.291198] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  299.296063] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  299.300924] hisi_sas_v3_hw 0000:b4:02.0: print test
> [  299.305787] hisi_sas_v3_hw 0000:b4:02.0: print test
> 
> The log shows that when thread B invokes dev_info, dev_info is blocked for
> several seconds.

This works as expected. It is not ideal but it is the best we
can do with the current printk() design. kthread B causes flood
of messages and it pays the price for it. The console work
is a nature throttling.

The only problem is that it becomes the console_owner too late.
It spends long time by flushing the accumulated messages. But
they are its own messages after all.

The only real solution is to pass the console work to a separate
kthread and do not block any printk() caller.


By other words. The above test case does not justify the need
of the patch.

The only justification for the patch would be when you see many
messages accumulated between suspend_console() and resume_console()
in the real life.

Best Regards,
Petr
