Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B472032FACE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 14:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCFNPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 08:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhCFNOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 08:14:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE70C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 05:14:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d13so6978635edp.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 05:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KFj0L+kuX3w0y3pNrmRfQeddr6KSngxQbB8TpEwmjoQ=;
        b=Ax/NvCGbY0yonQSHVABoIBQcdkkiG2FNUNUP5ApnUqgfyM9ERleUWqbsW4vEj+y6vt
         3979fgQN6G+1uX9AWcbgAepi0jCPV5mkv4FdXdWKE8pMdQK/cpstMprjRGV9fQe51gdJ
         hIDdHnZmfmFdJKL5vJDBZ3sS55NO1XheSW+L+KiKHWMiQ00NQ6ljZSq5Zw/lTa7fompV
         LxL+CxIpOS2Wb8696iLDaRiknDgZMYo456h5CZrr8s/Qbnh6y5uDfGAetrv/Q//2436e
         t43auWw5uR8mqk78b7KVmTC+M7iPHJhfpD0nNqLjL4diluTbahJ7OvqT56evChlqCePW
         RpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KFj0L+kuX3w0y3pNrmRfQeddr6KSngxQbB8TpEwmjoQ=;
        b=uH9UI2ZZM5hzGpC9JA8uW//cUk9m4kOIjbXhFcGekPONxSuYG2Im44RsPOJY5qDZYa
         O6Dehg3ALIcHjaU30FeuxchR60s2wVhcWvFO/NwuJMIyMtnh+qCzat/lajsmfM9/w0Lv
         oLNIpTroc2jiTnq62km07akW4fhQiHs+umffKskZ4L70yHIIwkpzJkO4UA4x8kcuei41
         hkmgdm89Y1aHpG/1XV1PyhoCYyTVavrddl69kVcFDk+fmkQfEBePJlflorWLOipaVwZD
         Z/tl34tEgiljocO1Su6rqIfoPjK4dyUGKt+D1tsyA7s4xmoCiuPufVGJ+jWQWfdJUhZV
         lMVQ==
X-Gm-Message-State: AOAM530qyDvcZCCWfM3mODt/7KHscl5P5mTNdL78lehMtzqpHIkhZKeH
        4QqJKQEWWrj3b3FqizE6tAc=
X-Google-Smtp-Source: ABdhPJzL840oKc04Yh0AKzjE2Pl4y3DHTG5pNUmAtxDs1DSKblkFOyIhT/T6aZnFrIV+yxB6Hh/7UA==
X-Received: by 2002:a50:ed90:: with SMTP id h16mr7189109edr.101.1615036484433;
        Sat, 06 Mar 2021 05:14:44 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i6sm3185499ejz.95.2021.03.06.05.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 05:14:44 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Mar 2021 14:14:42 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "struct perf_sample_data" alignment
Message-ID: <20210306131442.GA552533@gmail.com>
References: <CAHk-=wgQWHDUFjzmAazg8WN0BR7nOyHmduj-MV1GWWDUu+UKCQ@mail.gmail.com>
 <YEHtjioucovbxbRt@hirez.programming.kicks-ass.net>
 <YEJG8v/sCxsG5Lsg@hirez.programming.kicks-ass.net>
 <CAADnVQLBrdBggyP1kBVrRQ2JDG+-5HzWAiLR7e-bNuLsKu2PkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLBrdBggyP1kBVrRQ2JDG+-5HzWAiLR7e-bNuLsKu2PkQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > This seems to be it... (completely untested)
> >
> > ---
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 3f7f89ea5e51..918a296d2ca2 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1032,7 +1032,9 @@ struct perf_sample_data {
> >         u64                             cgroup;
> >         u64                             data_page_size;
> >         u64                             code_page_size;
> > -} ____cacheline_aligned;
> > +};
> > +
> > +typedef struct perf_sample_data perf_sample_data_t ____cacheline_aligned;
> >
> >  /* default value for data source */
> >  #define PERF_MEM_NA (PERF_MEM_S(OP, NA)   |\
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index b0c45d923f0f..f32c623abef6 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -923,7 +923,7 @@ __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
> >   * bpf_perf_event_output
> >   */
> >  struct bpf_trace_sample_data {
> > -       struct perf_sample_data sds[3];
> > +       perf_sample_data_t sds[3];
> 
> bpf side doesn't care about about cacheline aligned.
> No need to add new typedef just for that.

So this structure is not supposed to be exposed to any ABI anywhere.

I did a (non-exhaustive) search of tooling, and there doesn't appear 
to be any accidental exposure.

The in-kernel ABI interaction appears to be the following:

 - In __perf_event_header_size() we only use fields within 
   perf_sample_data to size the header. Alignment won't change any of 
   the output.

 - Ditto in perf_event__id_header_size().

I.e. I think we should just zap it per the patch below (untested).

Thanks,

	Ingo

============>

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3f7f89ea5e51..d75e03ff31ea 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1032,7 +1032,7 @@ struct perf_sample_data {
 	u64				cgroup;
 	u64				data_page_size;
 	u64				code_page_size;
-} ____cacheline_aligned;
+};
 
 /* default value for data source */
 #define PERF_MEM_NA (PERF_MEM_S(OP, NA)   |\
