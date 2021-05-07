Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE01376876
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhEGQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:14:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:54566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234577AbhEGQOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:14:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620404021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6KzXqvMiRVjruPFLOERuSFj47yPPD+JdIfqMkIo8UmY=;
        b=cx1f6VUJe6SWZOo3Eh0nPfjdUiW/HcyUubU2j00m0mt90tv1wQoN6i2CIbwjHfduwZoXQS
        C0wMGhwZLj5ickX69KmJ2o5bZijrpDfMGya9mMsutzvw7P2/fLNzF5mAMsUq5YGJSEi0lx
        ZzYarOFd8KzhNSuDqje74XmeXv1mHGA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF5F9AD80;
        Fri,  7 May 2021 16:13:41 +0000 (UTC)
Date:   Fri, 7 May 2021 18:13:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJVnNQ7RGvx9JKxV@alley>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <YJP4F1UIt/eRZ96s@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJP4F1UIt/eRZ96s@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-05-06 23:07:19, Sergey Senozhatsky wrote:
> Thanks for Cc-ing Petr
> 
> On (21/05/06 15:39), Petr Mladek wrote:
> > 
> > Many printk messages might get accumulated when consoles were suspended.
> > They are proceed when console_unlock() is called in resume_console().
> > 
> > The possibility to pass the console lock owner was added to reduce the risk
> > of softlockup when too many messages were handled in an atomic context.
> > 
> > Now, resume_console() is always in a preemptible context that is safe
> > to handle all accumulated messages. The possibility to pass the console
> > lock owner actually makes things worse. The new owner might be in an atomic
> > context and might cause softlockup when processing all messages accumulated
> > when the console was suspended.
> > 
> > Create new console_unlock_preemptible() that will not allow to pass
> > the console lock owner. As a result, all accumulated messages will
> > be proceed in the safe preemptible process.
> 
> If we have a lot of pending messages in the logbuf, then there is
> something chatty - some context (task, irq) or maybe several contexts.
> And those contexts can continue adding messages, while we print them
> _exclusively_ from preemptible context only. without ever throttling down
> printk() callers - something that console_owner spinning and handover
> does for us. And those printk() callers can even preempt
> console_unlock_preemptible() and cause delays and lost messages.

Luo, please, correct me if I am wrong.

This patch a about one well defined scenario. The messages are
accumulated between suspend_console() and resume_console().
It is "small" part of the system hibernation. And we need
to get them out now. There might be many if something special
was debugged.

I am pretty sure that Luo did not see any flood of messages:

   + Flood in more contexts would be balanced by switching
     the console_owner.

   + Flood in one context would be naturally throttled because
     this context will become the console_owner.

In each case, these messages would be generated after
console_resume(). Luo's original patch was explicitly talking
about messages accumulated during the suspend.

Luo, could you please provide some log showing the problem?

Best Regards,
Petr
