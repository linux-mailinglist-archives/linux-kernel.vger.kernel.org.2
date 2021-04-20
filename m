Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73355365BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhDTPPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:15:49 -0400
Received: from mail.efficios.com ([167.114.26.124]:35252 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhDTPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:15:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 032EA2FFB10;
        Tue, 20 Apr 2021 11:15:12 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YViuQ0V-iCvr; Tue, 20 Apr 2021 11:15:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F11EF2FF6E7;
        Tue, 20 Apr 2021 11:15:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F11EF2FF6E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618931711;
        bh=9jmTl63ejRoEGDH7Iz+Ejiz0VcBL3V+jrgoAm8jUmpY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=M63n3KlXl3yXGgfWiE6tYiU7C9+neliWTS0XbarLUcH3O3nD6dAMSVuNebxkoNwfI
         1xqfRU+hzVCGA9JKUKeG3DEr0I17KPId7k4GxpTTHirjf4l1YNoQWRY4vpE6VAtepN
         igjzrrrN5gXFVSkp8YJ1+uCsod7RWesdEN6K2KfKHXuipYecU8HeLSUm5QocXLayG5
         yuEjNfyz2aco/yk01zBjm/L8ypHseinDYKSM1pnsz78lpfksLLGucnCtjUxd+njoC1
         o0141zWmCo8MQDTnskeZHmmiw3XITCtx60RlWuqQCjMBelllSfPNJKj9UP2lAuw75Z
         6AG7Z48qbwwDA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NgK35Tnf0dea; Tue, 20 Apr 2021 11:15:10 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E09AA2FF8AA;
        Tue, 20 Apr 2021 11:15:10 -0400 (EDT)
Date:   Tue, 20 Apr 2021 11:15:10 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        fweisbec <fweisbec@gmail.com>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, chris <chris@chris-wilson.co.uk>,
        yuanhan liu <yuanhan.liu@linux.intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Message-ID: <1672102317.2266.1618931710794.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210420105511.65490e8d@gandalf.local.home>
References: <1299622684.20306.77.camel@gandalf.stny.rr.com> <20130814233228.778f25d0@gandalf.local.home> <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com> <20210419181111.5eb582e8@gandalf.local.home> <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com> <20210420085532.4062b15e@gandalf.local.home> <1154727029.2004.1618925367044.JavaMail.zimbra@efficios.com> <20210420105511.65490e8d@gandalf.local.home>
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: tracing: Enable tracepoints via module parameters
Thread-Index: r4NP/v2czuZt4JWbk4RSvFnbBsSZqw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 20, 2021, at 10:55 AM, rostedt rostedt@goodmis.org wrote:

> On Tue, 20 Apr 2021 09:29:27 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Apr 20, 2021, at 8:55 AM, rostedt rostedt@goodmis.org wrote:
>> [...]
>> > 
>> > Would adding automatic module parameters be an issue? That is, you can add
>> > in the insmod command line a parameter that will enable tracepoints. We
>> > could have a way to even see them from the modinfo. I think I had that
>> > working once, and it wasn't really that hard to do.
>> 
>> There is one thing we should consider here in terms of namespacing: those module
>> command line parameters should be specific to each tracer (e.g. ftrace, perf,
>> ebpf).
>> 
>> LTTng for instance already tackles early module load tracing in a different
>> way: users can enable instrumentation of yet-to-be loaded kernel modules. So
>> it would not make sense in that scheme to have module load parameters.
>> 
>> It's a different trade-off in terms of error reporting though: for instance,
>> LTTng won't report an error if a user does a typo when entering an event name.
>> 
>> So I think those command line parameters should be tracer-specific, do you agree
>> ?
> 
> 
> No, I do not agree. I would like to make it consistent with the kernel
> command line. As you can put in: "trace_event=sched_switch" and the
> sched_switch trace point will be enable (for the tracefs directory) on boot
> up. The same should be for modules as well.
> 
> It shouldn't affect LTTng, as you already have a way to enable them as they
> get loaded.

That sounds fine. So that would be within the "trace_event" (and not tracepoint)
namespace for module load parameters as well ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
