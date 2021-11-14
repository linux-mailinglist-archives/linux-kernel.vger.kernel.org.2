Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556544F8FE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhKNQTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:19:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236135AbhKNQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636906581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ThPWPGxclO6HCx6vB+C0CqhUooFZuPsY+MpmwS3/Gc=;
        b=GHBROiGV5VciYoy1t1TbhINX6jt7q6dEsRV8NeKfQywY0q3VJi2xB9p8fgM/iKYL7n97Bz
        L42xe7cr3hY1R6QVXjvdnXeefa7RzgJ+QxhDT6Yo0Khf4+yBESxsJSlcfr0KcSdoTeu7kR
        /rXuuL/ZiJZP9zDh6t2b4oz2jier9uE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-bmJ0aEMLN9GhOwf9qZMZDw-1; Sun, 14 Nov 2021 11:16:20 -0500
X-MC-Unique: bmJ0aEMLN9GhOwf9qZMZDw-1
Received: by mail-wr1-f70.google.com with SMTP id d3-20020adfa343000000b0018ed6dd4629so2486074wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 08:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8ThPWPGxclO6HCx6vB+C0CqhUooFZuPsY+MpmwS3/Gc=;
        b=ouumXsweAeyKdno/tu56gxMGoGAFwMAj143C7RlvXQkYjNZAOiRyXIPYsncVFNzfkg
         JaRVLmLGm4IaDpAMz7pRfvQzGPsFhRb/792mB99hkqTifA/5Q19wUQpUvJaO+m+VWlTC
         5zxEhAcU8F8yVUnPCAhvWCbspYG3SKJzubWrj5wyCnN2z5y/UDxIUh6NUFch+gnk6vfh
         FVQXfL+4wU7FMUdrIgTub/h8Wiw23NzRIUsS4lYtZk4uJ+n6UYDCnFbH8WhcDlt3fD9q
         /LlKQ092EguogyBuwMy0HxNBK7B6p7HSDK3b+iyXg/Qi85AoHQJGMAJRXvKbC8w/gSN0
         tU4Q==
X-Gm-Message-State: AOAM531goz84JcyCYrj4dq29tB6LSiaTHIvSYlUmfWyCagQSsHq0EKNb
        7ZMF0eKfrIeLnsYKuPd/jSSqv1w/Ux1ljIocJZgxJCVE/aEtK1mnmwWpGzD24k+Z1okNgKaw8sD
        MBA7Zx2k7Qr/CqChw8gIMl9Ka
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr34632463wmi.178.1636906579659;
        Sun, 14 Nov 2021 08:16:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2oV8uu5KGyTQ/J5RSZhjWT+kGR6eUEouyOQpXWZZz7HBXFNpNxKeToV473estwHh5eTSQ9w==
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr34632427wmi.178.1636906579355;
        Sun, 14 Nov 2021 08:16:19 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f3sm17092956wmb.12.2021.11.14.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:16:18 -0800 (PST)
Date:   Sun, 14 Nov 2021 17:16:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     Rob Herring <robh@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Message-ID: <YZE2UNYUjO/Cpn24@krava>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
 <20210922101627.3396398-2-nakamura.shun@fujitsu.com>
 <YUuhe7e0J0PSea+b@krava>
 <OSBPR01MB4600A329F99490D206990EC0F7A89@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YV8rpPWOgFa5ARlU@krava>
 <OSBPR01MB46000071426DEC8FFF04C4F6F7BD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB4600CC928A1D4BB0703EFAE3F7919@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB4600CC928A1D4BB0703EFAE3F7919@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 12:49:24AM +0000, nakamura.shun@fujitsu.com wrote:
> Hi Jirka
> 
> > > > > On Wed, Sep 22, 2021 at 07:16:26PM +0900, Shunsuke Nakamura wrote:
> > > > > > From: nakamura shunsuke <nakamura.shun@fujitsu.com>
> > > > > > 
> > > > > > perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
> > > > > > does not scale counters obtained by read() system call.
> > > > > > 
> > > > > > Add processing to perf_evsel__read() to scale the counters obtained during the
> > > > > > read() system call when multiplexing.
> > > > > > 
> > > > > > 
> > > > > > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> > > > > > ---
> > > > > >  tools/lib/perf/evsel.c | 6 ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > > > 
> > > > > > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > > > > > index 8441e3e1aaac..0ebd1d34436f 100644
> > > > > > --- a/tools/lib/perf/evsel.c
> > > > > +++ b/tools/lib/perf/evsel.c
> > > > > > @@ -18,6 +18,7 @@
> > > > > >  #include <sys/ioctl.h>
> > > > > >  #include <sys/mman.h>
> > > > > >  #include <asm/bug.h>
> > > > > > +#include <linux/math64.h>
> > > > > >  
> > > > > >  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
> > > > > >                      int idx)
> > > > > > @@ -321,6 +322,11 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> > > > > >        if (readn(*fd, count->values, size) <= 0)
> > > > > >                return -errno;
> > > > > >  
> > > > > > +     if (count->ena != count->run) {
> > > > > > +             if (count->run != 0)
> > > > > > +                     count->val = mul_u64_u64_div64(count->val, count->ena, count->run);
> > > > > > +     }
> > > > > 
> > > > > so I think perf stat expect raw values in there and does the
> > > > > scaling by itself, please check following code:
> > > > > 
> > > > > read_counters
> > > > >   read_affinity_counters
> > > > >     read_counter_cpu
> > > > >       read_single_counter
> > > > >         evsel__read_counter
> > > > > 
> > > > >   perf_stat_process_counter
> > > > >     process_counter_maps
> > > > >       process_counter_values
> > > > >         perf_counts_values__scale
> > > > > 
> > > > > 
> > > > > perhaps we could export perf_counts_values__scale if it'd be any help
> > > > 
> > > > Thank you for your comment.
> > > > 
> > > > The purpose of this patch is to unify the counters obtained with 
> > > > perf_evsel__read() to scaled or unscaled values.
> > > > 
> > > > perf_evsel__read() gets counter by perf_mmap__read_self() if RDPMC is 
> > > > available, else gets by readn(). In current implementation, caller 
> > > > gets scaled counter if goes through RDPMC path, otherwise gets unscaled 
> > > > counter via readn() path.
> > > > 
> > > > However caller cannnot know which path were taken.
> > > > 
> > > > If caller expects a raw value, I think the RDPMC path should also 
> > > > return an unscaled counter.
> > > > 
> > > > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > > > index c89dfa5..aaa4579 100644
> > > > --- a/tools/lib/perf/mmap.c
> > > > +++ b/tools/lib/perf/mmap.c
> > > > @@ -353,8 +353,6 @@ int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count
> > > >                 count->ena += delta;
> > > >                 if (idx)
> > > >                         count->run += delta;
> > > > -
> > > > -               cnt = mul_u64_u64_div64(cnt, count->ena, count->run);
> > > 
> > > perf stat does not mmap counters so this should not be invoked
> > > within perf stat.. but we should be consistent and scale after
> > > calling perf_evsel__read.. and give user the possibility to get
> > > un-scaled counts
> > > 
> > > that perhaps brings new feature.. mmap perf stat counters to invoke
> > > the fast reading path for counters.. IIRC it should be matter just
> > > to mmap the first 'user' page
> > 
> > Thank you for your comment.
> > I think it will be good that perf stat supports rdpmc.
> > 
> > I will modify the patch. 
> 
> I think rdpmc cannot measure the command/program specified in perf stat 
> because it measures the calling thread of perf_event_open.
> If my understanding is wrong, please point it out to me.

right, I guess we could use that just for system wide monitoring,
where we open counter for each cpu

jirka

