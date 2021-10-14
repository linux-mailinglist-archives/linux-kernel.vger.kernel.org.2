Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9742DDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhJNPOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhJNPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:13:51 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFB3C09B04F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:05:58 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d125so4144683iof.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqtrsb2myc57sZUFYA0S4hcwxSX7FpAo+OjdmCHiHII=;
        b=nlnkQTanK3tTWZScPGug5nMGE7mk0FQPqQDPAJaLJwzAHmYR/RNwiS4VnyWUGYa1MA
         aXL9iMfEgKqmwH1WfzxOGLiQzDBfV/HCH/BzPUZP+Df3zB1t2RTT4mnAna4/s/fidXg6
         1VnFWPTN0mzhEqnqo7ppO4HkTzMnhv57cvAvLTN5nfpZCtLdliSQpLasMdBMEjT7LR5C
         S28KOpfUHK+5VJFZLRwna4U58eIkI0gXKZz0CxKab6liKBOL/ru37AhRl254v+K6Ftze
         HgVBR8t3IgEk+kaLqafaUzRUv925KfahjsZ8liMDRbq3Sqcyge5toAD7BQt0zu0rw3cp
         I6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqtrsb2myc57sZUFYA0S4hcwxSX7FpAo+OjdmCHiHII=;
        b=10gkdXxb9Jsm7KbuXIr+dL3t/69Nbl8vhIXMMYqc/mAD6G8CqUiDA8PPCTCNO1oHUU
         YyIFgAp7LaExwZzV1wkbzup0WI0IyQAVnPZEfWEh57jUP3Wv+QPz38ahxOgTQ0TnyWDp
         3KSK2rafWe/UkqczD0pdktmmgjYBNZYa5/VOKkAg90Kt9dP34kZtByDx09yKRUX5TuGA
         Vpeq4tlkkjF7o0peFxNBOjS4wJ98gplve6zfQBwKoghI/lN7fp4iy34JbQrfhWNQlVow
         kNYXkFElB/lAlV8sewXOACR5gxAWrHPdehChxRA1SfkNNhhizb33xv2UFNs67dro8h2u
         nzmw==
X-Gm-Message-State: AOAM530K1KJO4gFeZRDxbHkN2TQZuYT35CJicnTBJzHT1h41TkZgMYTI
        9Qxvgg3hTDKaVQvCDLahSP7nkYtAeT3GJfwsGKw=
X-Google-Smtp-Source: ABdhPJzKMBXfsRRMvbta41zJ5GB5pp1gdGPiXg9Yl/5u7ApNTNJi1TmU2eWR3BKLTDRgGEwRkigJ65gsacJAjgL8zA4=
X-Received: by 2002:a05:6602:27d4:: with SMTP id l20mr2821613ios.94.1634223957717;
 Thu, 14 Oct 2021 08:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020>
 <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
 <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
 <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com>
 <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com>
 <CALOAHbBTxLvuiuT4tT2_7C+jaXBoh0uTjzLRm+njO4tKxCtPwg@mail.gmail.com>
 <1171592945.14099.1634219447199.JavaMail.zimbra@efficios.com>
 <CALOAHbAhT1bTAThrmA1zYE5q8shR4dxZf5fqcq_9wVrV+XwVEQ@mail.gmail.com> <20211014104811.356e11ae@gandalf.local.home>
In-Reply-To: <20211014104811.356e11ae@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Oct 2021 23:05:17 +0800
Message-ID: <CALOAHbBaFYYvTDd4tFtYZznbNi-9pwXrNRrQb2iLa9st9M8wxw@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        acme <acme@kernel.org>,
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

On Thu, Oct 14, 2021 at 10:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 14 Oct 2021 22:40:04 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > > mount -t tracefs nodev /sys/kernel/tracing
> > > cat /sys/kernel/tracing/events/sched/sched_switch/format
> > >
> > > name: sched_switch
> > > ID: 314
> > > format:
> > > [...]
> > >         field:char prev_comm[16];       offset:8;       size:16;        signed:1;
> > > [...]
> > >         field:char next_comm[16];       offset:40;      size:16;        signed:1;
> > >
> > > Both of those fields expose a fixed-size of 16 bytes.
> > >
> > > AFAIK Steven's intent was that by parsing this file, trace viewers could adapt to
> > > changes in the event field layout. Unfortunately, there have been cases where
> > > trace viewers had a hard expectation on the field layout. Hopefully those have
> > > all been fixed a while ago.
> > >
> >
> > I don't have a clear idea what will happen to trace viewers if we
> > extend task comm.
>
> There shouldn't be any doing a hard coded read of the events. That happened
> once with powertop, but they broke when they ran 32 bit userspace on a 64
> bit kernel, and they switched to libtraceevent to fix it. Which handles
> these updates.
>

Thanks for the explanation.

> >
> > Steven, do you have any suggestions ?
>
> The "Don't break user space" is a "tree in the forest" argument. We break
> user space all the time. But if no user space tool is around to hear it,
> did it really break? The answer is "no".
>

Got it!

-- 
Thanks
Yafang
