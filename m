Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977D130B1A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBAUkw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Feb 2021 15:40:52 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:44142 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBAUkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:40:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2E57F608A38A;
        Mon,  1 Feb 2021 21:40:06 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id u55Rgbsdcb7O; Mon,  1 Feb 2021 21:40:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 46751608A38F;
        Mon,  1 Feb 2021 21:40:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SeDVACmb7lFf; Mon,  1 Feb 2021 21:40:05 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 00928608A38A;
        Mon,  1 Feb 2021 21:40:04 +0100 (CET)
Date:   Mon, 1 Feb 2021 21:40:04 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        tglx <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Meyer <thomas@m3y3r.de>
Message-ID: <790609565.351317.1612212004428.JavaMail.zimbra@nod.at>
In-Reply-To: <87v9bbzga2.fsf@jogness.linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de> <20210126211551.26536-10-john.ogness@linutronix.de> <YBgM5N4ebSr7YsPq@alley> <875z3bk9z1.fsf@jogness.linutronix.de> <1829482025.350347.1612198481059.JavaMail.zimbra@nod.at> <87v9bbzga2.fsf@jogness.linutronix.de>
Subject: Re: [PATCH printk-rework 09/12] um: synchronize kmsg_dumper
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: synchronize kmsg_dumper
Thread-Index: E17+D8fWeMDO0Mf1cXCZePXLxQWrVw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

----- Ursprüngliche Mail -----
>>> The line was previously synchronized for the kmsg_dump_get_line()
>>> call. But yes, it was not synchronized after the call, which is a bug if
>>> the dump is triggered on multiple CPUs simultaneously. The commit
>>> message should also mention that it is handling that bug.
>>> 
>>>> IMHO, this patch is not needed.
>>> 
>>> I am not familiar enough with ARCH=um to know if dumps can be triggered
>>> on multiple CPUs simultaneously. Perhaps ThomasM or Richard can chime in
>>> here.
>>
>> Well, uml has no SMP support, so no parallel dumps. :-)
> 
> When I grep through arch/um, I see many uses of spinlocks. This would
> imply that uml at least has some sort of preemption model where they are
> needed. Dumps can trigger from any context and from multiple paths.
> 
> If you are sure that this is no concern, then I will drop this patch
> from my series.

Currently uml selects ARCH_NO_PREEMPT, so no preemtion too.
We have spinlocks at obvious places in arch/um/ just to be ready if uml supports
SMP at some point.
Does your patch have drawbacks right now for uml? If not, I'd suggest to keep it.

Thanks,
//richard

