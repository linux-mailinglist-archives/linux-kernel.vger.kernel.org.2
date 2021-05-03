Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A378737163A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhECNvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:51:32 -0400
Received: from mail.efficios.com ([167.114.26.124]:51614 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbhECNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:51:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 01368241226;
        Mon,  3 May 2021 09:50:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Lhs7HQXiEDSs; Mon,  3 May 2021 09:50:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7E4F224129C;
        Mon,  3 May 2021 09:50:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7E4F224129C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1620049830;
        bh=eUdc0ORANnqMPD7ukmSadEOiM93pqNDHZ9zconEvXSg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=d+OTnJ6CtaokRpIb6Gsn3GLe9daSzfn7xw/Zx7jLnfggYTXxmjGL4R4svrnV2CxYa
         rn7Z9ZOX+arXjgk3yykcAPAizDOG/dysQFwQfCk1LBjNy2aQqtAtscrXzRxNTBtr+U
         hx9cg/GIn9MSvh6i4j8sJc+2fAr9Q7GP14DmWISpUjA+0FB1CcdFzrXzZhkBp/4SKU
         x3KmDd4LESxHDoSZINBuF8vTBQZqTsgYuEATcQPa2sWR/sSnJ7j4lT1hycn+sPNdZq
         aG1FIKa+csdx3n0qE+xlAFQKqIvzMvWqeEhFftUhuJFO8JQfPTZLxOhdAcVR2UrTLg
         WfUmLa7gHMK6g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q3LbvlmhcHGc; Mon,  3 May 2021 09:50:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 69B12241299;
        Mon,  3 May 2021 09:50:30 -0400 (EDT)
Date:   Mon, 3 May 2021 09:50:30 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     peter enderborg <Peter.Enderborg@sony.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Minchan Kim <minchan@kernel.org>
Message-ID: <1214833117.22933.1620049830326.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210501091104.418765bd@oasis.local.home>
References: <20210430142223.25500-1-peter.enderborg@sony.com> <20210430142223.25500-2-peter.enderborg@sony.com> <m14kfnzmsp.fsf@fess.ebiederm.org> <4bb24db4-f720-f5e7-9054-36bdeaee1d79@sony.com> <20210501091104.418765bd@oasis.local.home>
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: tracing: Add a trace for task_exit
Thread-Index: wfnMoF8QnBjqFe75TFoqmMOQw19oNQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 1, 2021, at 9:11 AM, rostedt rostedt@goodmis.org wrote:

> On Sat, 1 May 2021 09:29:41 +0000
> <Peter.Enderborg@sony.com> wrote:
> 
>> On 4/30/21 7:48 PM, Eric W. Biederman wrote:
>> > Peter Enderborg <peter.enderborg@sony.com> writes:
>> >  
>> >> This is the peer functions to task_rename and task_newtask.
>> >> With this we get hole "life-cycle" of task and can easily
>> >> see short livied task and their exit status.
>> > This patch is incorrect.  The location you are dealing with is not part
>> > of task exit.  The location you have instrumented is part of reaping a
>> > task which can come arbitrarily long after the task exits.
>> 
>> That is what it aiming. When using this as tool for userspace you
>> would like to know when the task is done. When it no longer
>> holds any thing that might have any impact. If you think the
>> exit imply something more specific I can change the name.
>> 
>> I thought exit was a good name, it is in in exit.c.
>> 
>> Will the name task_done, task_finished or task_reaped work for you?
> 
> I think "task_reaped" is probably the best name, and the most
> descriptive of what happened.

What would it provide that is not already available through the "sched_process_free"
tracepoint in delayed_put_task_struct ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
