Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE5342D9C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhJNNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:11:16 -0400
Received: from mail.efficios.com ([167.114.26.124]:38488 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhJNNLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:11:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6AB9038D1FE;
        Thu, 14 Oct 2021 09:09:10 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SX16T8nkSvtc; Thu, 14 Oct 2021 09:09:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 052F338D537;
        Thu, 14 Oct 2021 09:09:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 052F338D537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1634216950;
        bh=QA5iHLT0xwd7pVtVi/ntg/zo6PLr+nWTvEpxMyu1hng=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZNyuPokd1KuOJ5jlCLDEq/XeO+LNqz7ZshGVK/CIqeNtpAD65eFVlNz5lMM85zqBE
         AaYF83xWCeqMhazswL1USzn3Hc6R04xjraNNUDZqDNdAfG4ZhWukhZoznNAYRgYgWU
         spkqf0ilD0YRHWz7VWCqLt/PMCrfGLZiimXk9PlMfmOIxu7dGs+rB3jJqd7mjpVqNt
         SGUFHeBRlFRRL305EHoCbiwi1bkjooRmUqehZHyaboUVitUVADQmNX6F6mNfXE80r3
         rUWywaSIaFM/82XoL65Qvd/YvX0VS3vY8iQjFAq65TOsCXIyVD0+vR7PtSutpbvNMR
         MDcSL/notZA7g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MvqFsZP8MAyP; Thu, 14 Oct 2021 09:09:09 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DCA6A38D49D;
        Thu, 14 Oct 2021 09:09:09 -0400 (EDT)
Date:   Thu, 14 Oct 2021 09:09:09 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     acme <acme@kernel.org>, rostedt <rostedt@goodmis.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qiang Zhang <qiang.zhang@windriver.com>,
        robdclark <robdclark@chromium.org>,
        christian <christian@brauner.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        bristot <bristot@redhat.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Message-ID: <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com>
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020> <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com> <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com> <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e:
 perf-sanity-tests.Parse_sched_tracepoints_fields.fail
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4156 (ZimbraWebClient - FF93 (Linux)/8.8.15_GA_4156)
Thread-Topic: 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
Thread-Index: IUaqGI45KnV+Wu7moWF2apb54rkhyQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 14, 2021, at 9:05 AM, Yafang Shao laoar.shao@gmail.com wrote:
[...]
>> If it happens that this ABI break is noticed by more than an in-tree test
>> program, then
>> the kernel's ABI rules will require that this trace field size stays unchanged.
>> This brings
>> up once more the whole topic of "Tracepoints ABI" which has been discussed
>> repeatedly in
>> the past.
>>
> 
> I will check if any other in-tree tools depends on TASK_COMM_LEN.

That's a start, but given this is a userspace ABI, out-of-tree userland
tools which depend of this to be fixed-size are also relevant.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
