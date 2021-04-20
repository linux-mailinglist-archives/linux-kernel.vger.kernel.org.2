Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3007D365A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhDTNaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:30:00 -0400
Received: from mail.efficios.com ([167.114.26.124]:33372 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhDTN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:29:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A740D2FE916;
        Tue, 20 Apr 2021 09:29:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3m9Gwf_gMSRu; Tue, 20 Apr 2021 09:29:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 37A4F2FED9B;
        Tue, 20 Apr 2021 09:29:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 37A4F2FED9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618925367;
        bh=QsxHLQuZ6/NmxdwKl3bSdvfvXYh8C1ZBM9eOhl6zdvc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=W13i74aXhgRV/poLcJPrRQkcqPt2WSqaN0cI+vQiU5C9DMd4vWvKN8rO9lEmZl6gi
         8tnGknzEh8o3FYv3mssQtpK2AhjCCGuxLYqOcsfr3GKvwX53Wc59s0cV9NFXl6NraV
         cfsm8VBVNtBH5L6w/wtR0g1Et0jmLyXNu1j5y84u83tGE0N4zWjF5ZRX+z1kIV3Uwm
         MX4qUntdQAnGa/N2vjVaIPMXkNISOWp+tvvKWsCVjf9cyEIPrppnOEpR5v1Wj2ybXj
         rWU5hYzqcLjGdQWrrpNuz5rsOpUOSOXl9MNi5VELORBIa3rDqhPl8LJBWIgleOYtvI
         qpMkn09ksCaKg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cwFy8b8gn99W; Tue, 20 Apr 2021 09:29:27 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 255132FED21;
        Tue, 20 Apr 2021 09:29:27 -0400 (EDT)
Date:   Tue, 20 Apr 2021 09:29:27 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        fweisbec <fweisbec@gmail.com>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, chris@chris-wilson.co.uk,
        yuanhan liu <yuanhan.liu@linux.intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Message-ID: <1154727029.2004.1618925367044.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210420085532.4062b15e@gandalf.local.home>
References: <1299622684.20306.77.camel@gandalf.stny.rr.com> <20130813111442.632f3421@gandalf.local.home> <87siybk8yl.fsf@rustcorp.com.au> <20130814233228.778f25d0@gandalf.local.home> <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com> <20210419181111.5eb582e8@gandalf.local.home> <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com> <20210420085532.4062b15e@gandalf.local.home>
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: tracing: Enable tracepoints via module parameters
Thread-Index: sM+iKvNdasbLkp1rglxClIfh9BgdaA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 20, 2021, at 8:55 AM, rostedt rostedt@goodmis.org wrote:
[...]
> 
> Would adding automatic module parameters be an issue? That is, you can add
> in the insmod command line a parameter that will enable tracepoints. We
> could have a way to even see them from the modinfo. I think I had that
> working once, and it wasn't really that hard to do.

There is one thing we should consider here in terms of namespacing: those module
command line parameters should be specific to each tracer (e.g. ftrace, perf, ebpf).

LTTng for instance already tackles early module load tracing in a different
way: users can enable instrumentation of yet-to-be loaded kernel modules. So
it would not make sense in that scheme to have module load parameters.

It's a different trade-off in terms of error reporting though: for instance,
LTTng won't report an error if a user does a typo when entering an event name.

So I think those command line parameters should be tracer-specific, do you agree ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
