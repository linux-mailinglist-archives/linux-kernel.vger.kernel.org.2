Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA05F42DEF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhJNQQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhJNQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:16:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736C7C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:14:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso7299453pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NyW7J3fGaetabJGlg55KQ2jz0KhoAMqc4PRWGXhXp9U=;
        b=hmeN3UF0kXwn7N7/4WKvMyhvdrui1DF0GouB+UKzYWgSEYJ27YZhrK28k1lZkO+KVY
         9xexWIbV5z4DLvwstb7yqCn/TDgNIBBMAaVqJYiEXjpMHG5YarZSaEnKNUhNpCQnXV3a
         aVamiLvnUiwvYoX098saL5rXFP17t31180jk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyW7J3fGaetabJGlg55KQ2jz0KhoAMqc4PRWGXhXp9U=;
        b=1ejjKPPDekZzYBpTFDq3WqbwvIlVFqXSMOeBn0bZyMZjl0yYFvCBhN0AdyXaBW0IN6
         9F8BWeG+UfkDQbfayeDUWoWybDSPn8za1lQX5JezcmgCMduBxcjHqnQ9GPy+1uQHOAcc
         qEo/vlJn62gzhdcI8cykENmG7T8UwP1ENeS03xAO/8xxwmNYay1mVFhgE+3hGriRkAmY
         ajRqJs91DuW8k/v56mnYIvvwr03bR/c0p7Auh/67ipyemWg2vQpYaSE06AKLGe5lnNW2
         yxNG/7zm6lFJCy8uMxjFIIPj/Vqgoj0oQLED+yOGwQM/eZg2ZpASIFsrGV2atpfcgxQa
         2f6Q==
X-Gm-Message-State: AOAM533U6W6a+J8czZN3Xa2hvfnzgdIyYKa8bMnvZmfw5q2/0OqkQQc8
        YkaZyaQR0R390I236cBAn046eQ==
X-Google-Smtp-Source: ABdhPJwEAm3/wxLMfpYc1ofSDs5cRduehiISnlbIyNaRJEThyJZu4wkWpPWLh5RgtuS+6mUERlN8kg==
X-Received: by 2002:a17:90a:d58b:: with SMTP id v11mr7059544pju.207.1634228062854;
        Thu, 14 Oct 2021 09:14:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z4sm3040338pfz.99.2021.10.14.09.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 09:14:22 -0700 (PDT)
Date:   Thu, 14 Oct 2021 09:14:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        acme <acme@kernel.org>, rostedt <rostedt@goodmis.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [sched.h] 317419b91e:
 perf-sanity-tests.Parse_sched_tracepoints_fields.fail
Message-ID: <202110140910.295E856@keescook>
References: <20211010102429.99577-4-laoar.shao@gmail.com>
 <20211014072707.GA18719@xsang-OptiPlex-9020>
 <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
 <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
 <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com>
 <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com>
 <CALOAHbBTxLvuiuT4tT2_7C+jaXBoh0uTjzLRm+njO4tKxCtPwg@mail.gmail.com>
 <1171592945.14099.1634219447199.JavaMail.zimbra@efficios.com>
 <CALOAHbAhT1bTAThrmA1zYE5q8shR4dxZf5fqcq_9wVrV+XwVEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAhT1bTAThrmA1zYE5q8shR4dxZf5fqcq_9wVrV+XwVEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 10:40:04PM +0800, Yafang Shao wrote:
> On Thu, Oct 14, 2021 at 9:50 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > ----- On Oct 14, 2021, at 9:11 AM, Yafang Shao laoar.shao@gmail.com wrote:
> >
> > > On Thu, Oct 14, 2021 at 9:09 PM Mathieu Desnoyers
> > > <mathieu.desnoyers@efficios.com> wrote:
> > >>
> > >> ----- On Oct 14, 2021, at 9:05 AM, Yafang Shao laoar.shao@gmail.com wrote:
> > >> [...]
> > >> >> If it happens that this ABI break is noticed by more than an in-tree test
> > >> >> program, then
> > >> >> the kernel's ABI rules will require that this trace field size stays unchanged.
> > >> >> This brings
> > >> >> up once more the whole topic of "Tracepoints ABI" which has been discussed
> > >> >> repeatedly in
> > >> >> the past.
> > >> >>
> > >> >
> > >> > I will check if any other in-tree tools depends on TASK_COMM_LEN.
> > >>
> > >> That's a start, but given this is a userspace ABI, out-of-tree userland
> > >> tools which depend of this to be fixed-size are also relevant.
> > >>
> > >
> > > TASK_COMM_LEN isn't defined in include/uapi/ directory, so it seems
> > > that it isn't the uerspace ABI?
> >
> > One case where this 16 bytes size is expected by userspace is prctl(2) PR_GET_NAME
> > and PR_SET_NAME.
> >
> 
> the prctl(2) man page says that:
> : PR_SET_NAME
> :        If the length of the string, including the terminating
> :        null byte, exceeds 16 bytes, the string is silently truncated.
> : PR_GET_NAME
> :         The buffer should allow space for up to 16 bytes
> :          the returned string will be null-terminated.
> 
> As the string returned to user space is null-terminated, extending
> task comm won't break the prctl(2) user code.

If userspace was:

	char comm[16];
	int important_values;

	...

	prctl(PR_GET_NAME, pid, comm);

the kernel will clobber "important_values", so prctl() must enforce the
old size (and terminate it correctly). It's not okay for us to expect
that userspace get recompiled -- old binaries must continue to work
correctly on kernel kernels.

        case PR_GET_NAME:
                get_task_comm(comm, me);
                if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
                        return -EFAULT;
                break;

This looks like it needs to be explicitly NUL terminated at 16 as well.

I'd say we need a TASK_COMM_LEN_V1 to use in all the old hard-coded
places.

-Kees

> 
> > The other case I am referring to is with ftrace and perf:
> >
> > mount -t tracefs nodev /sys/kernel/tracing
> > cat /sys/kernel/tracing/events/sched/sched_switch/format
> >
> > name: sched_switch
> > ID: 314
> > format:
> > [...]
> >         field:char prev_comm[16];       offset:8;       size:16;        signed:1;
> > [...]
> >         field:char next_comm[16];       offset:40;      size:16;        signed:1;
> >
> > Both of those fields expose a fixed-size of 16 bytes.
> >
> > AFAIK Steven's intent was that by parsing this file, trace viewers could adapt to
> > changes in the event field layout. Unfortunately, there have been cases where
> > trace viewers had a hard expectation on the field layout. Hopefully those have
> > all been fixed a while ago.
> >
> 
> I don't have a clear idea what will happen to trace viewers if we
> extend task comm.
> 
> Steven, do you have any suggestions ?
> 
> -- 
> Thanks
> Yafang

-- 
Kees Cook
