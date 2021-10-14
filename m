Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A3642DBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhJNOmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhJNOmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:42:49 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89EEC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 07:40:44 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a8so3726164ilj.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vf6cE4PPa4v3+bsdQEEt1icoIwGyEK8nRcHaAS9IFTY=;
        b=CRtMmdZawgppL6lggnYhzQaUipb+bwGxtjUkWRYJbuyR/oBrVTDFSYxXx2eG2U4Ep+
         H4ZYNTBT9nv0xFG5ZmrescKfqzVN+eAxtzDpg4lVXJCOZpD5oZGBkpAX+5kbZbBdHN3A
         D/EAWOJQYsLb9az5269xszw2vgkLyAR4Pny0Mqe/9Ocypm2ksvWkLCvFSuT4HNsS5Pvf
         lERf7npRI/RvtGNMRhsepE3tEZqg0bG5fTd9ff8TM6NM5YW0zFooqtCenqCiPgJxMSkQ
         kgvGvo0MTSYBYtGXMPlc8I/5YPdhHKdhdgHxRLXCZsvr1BgjfrUaNLXuYc8g1IInBHfr
         CyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vf6cE4PPa4v3+bsdQEEt1icoIwGyEK8nRcHaAS9IFTY=;
        b=l2e34c2+Eiui1cDDuWdpJfJDKupyaiirZ8i/NhkNTYPXSaJ4i7GUFRhTV420s7y5Ys
         YZosadHrFtQ4uFRl0eSqtEeWhyJCpDGWvrGiWKwSQMcJcalRdXefEFRGyRWxxrD+pqT0
         we7W3Tew01SKaUIlJrr7B5d+Ei1mF/A5avM92vqN84Fvv/jtywmNieXL6ab1UCVOOpfh
         Jqq+PDcIvAeJphhlIUIiQBwnMmmu3djosmgqBH9EssSRoJ4HYIgBaib6WG6QbncXxtXx
         cyrg23hX9U0wf13KTb1EN8GCBEAd2blJ4NyYB/B/sKhNkjzmWV8sL76e3qd7M0Z1zWlQ
         /Xww==
X-Gm-Message-State: AOAM531OK7DlzqDHo10s6Qp+vplaqIUNsSr427K9NQp4ZjUmSiwPNTG9
        QAUjoIXmHfNoAS/2Os+2pkCpEFRyPLa2sCRZxUo=
X-Google-Smtp-Source: ABdhPJzoQpLaSPV5cA1GZcYyHxpnTo+5/Nqxmf8D9DEM2vqKciR094dbJ4faBfJgWc9RUqQxMMwBdW5GeiHC2GJsA+k=
X-Received: by 2002:a05:6e02:c11:: with SMTP id d17mr2818280ile.25.1634222444101;
 Thu, 14 Oct 2021 07:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020>
 <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
 <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
 <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com>
 <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com>
 <CALOAHbBTxLvuiuT4tT2_7C+jaXBoh0uTjzLRm+njO4tKxCtPwg@mail.gmail.com> <1171592945.14099.1634219447199.JavaMail.zimbra@efficios.com>
In-Reply-To: <1171592945.14099.1634219447199.JavaMail.zimbra@efficios.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Oct 2021 22:40:04 +0800
Message-ID: <CALOAHbAhT1bTAThrmA1zYE5q8shR4dxZf5fqcq_9wVrV+XwVEQ@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 9:50 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Oct 14, 2021, at 9:11 AM, Yafang Shao laoar.shao@gmail.com wrote:
>
> > On Thu, Oct 14, 2021 at 9:09 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> ----- On Oct 14, 2021, at 9:05 AM, Yafang Shao laoar.shao@gmail.com wrote:
> >> [...]
> >> >> If it happens that this ABI break is noticed by more than an in-tree test
> >> >> program, then
> >> >> the kernel's ABI rules will require that this trace field size stays unchanged.
> >> >> This brings
> >> >> up once more the whole topic of "Tracepoints ABI" which has been discussed
> >> >> repeatedly in
> >> >> the past.
> >> >>
> >> >
> >> > I will check if any other in-tree tools depends on TASK_COMM_LEN.
> >>
> >> That's a start, but given this is a userspace ABI, out-of-tree userland
> >> tools which depend of this to be fixed-size are also relevant.
> >>
> >
> > TASK_COMM_LEN isn't defined in include/uapi/ directory, so it seems
> > that it isn't the uerspace ABI?
>
> One case where this 16 bytes size is expected by userspace is prctl(2) PR_GET_NAME
> and PR_SET_NAME.
>

the prctl(2) man page says that:
: PR_SET_NAME
:        If the length of the string, including the terminating
:        null byte, exceeds 16 bytes, the string is silently truncated.
: PR_GET_NAME
:         The buffer should allow space for up to 16 bytes
:          the returned string will be null-terminated.

As the string returned to user space is null-terminated, extending
task comm won't break the prctl(2) user code.

> The other case I am referring to is with ftrace and perf:
>
> mount -t tracefs nodev /sys/kernel/tracing
> cat /sys/kernel/tracing/events/sched/sched_switch/format
>
> name: sched_switch
> ID: 314
> format:
> [...]
>         field:char prev_comm[16];       offset:8;       size:16;        signed:1;
> [...]
>         field:char next_comm[16];       offset:40;      size:16;        signed:1;
>
> Both of those fields expose a fixed-size of 16 bytes.
>
> AFAIK Steven's intent was that by parsing this file, trace viewers could adapt to
> changes in the event field layout. Unfortunately, there have been cases where
> trace viewers had a hard expectation on the field layout. Hopefully those have
> all been fixed a while ago.
>

I don't have a clear idea what will happen to trace viewers if we
extend task comm.

Steven, do you have any suggestions ?

-- 
Thanks
Yafang
