Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7E3612FC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 21:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhDOThm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 15:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234226AbhDOThh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 15:37:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 092BB610EA;
        Thu, 15 Apr 2021 19:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618515434;
        bh=+2AURCWuO1kL79fzoAwS1sagrNWOsFnpgEZIpyXtmbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKH0gb6Ml7ikPbK9616Lb5dgofcLQgbIsQFGP/alUMJYJ6vktQMr1osLxk5HKBsl1
         RatxNEXBfBUxt4fTX/LdutV6tBbVlgdmTe0Ajposbou4IIKlXmcFcGLORrEsxoWdwZ
         n42Ew1i5tnGzSVaTfL4kfrawYGmO4u4ehoHUHw3KvudV/QXWgNFstUsZJlUReRF2DT
         rjq6dsCMzxW1zz58NBqqcnszIr+08+9Wl/XXKZgAl1kYvrpc0HW5tEo4cD6O5OhxVj
         doDjK6ntmk342Ljl6IuYbKEMpAtSHEZ0z+TTfruODOK21fsvOFYPXtqB1AthWVYn7Z
         LTOOhJ+t9RFgA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3597740647; Thu, 15 Apr 2021 16:37:10 -0300 (-03)
Date:   Thu, 15 Apr 2021 16:37:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v8 2/4] libperf: Add evsel mmap support
Message-ID: <YHiV5vqSD3TmUspL@kernel.org>
References: <20210414155412.3697605-1-robh@kernel.org>
 <20210414155412.3697605-2-robh@kernel.org>
 <CAM9d7cibppJUQuqcxEO9gU-KcHJNsoMJQw=1+_Fw3oXXHEKUCA@mail.gmail.com>
 <YHcuIKjNDkOUCupx@kernel.org>
 <YHczIzjv6Kt3cxI7@kernel.org>
 <CAM9d7chYYa5B-QR6xNJG5NeLb0ENv5inLdLMqT_e+8jkRZZCJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chYYa5B-QR6xNJG5NeLb0ENv5inLdLMqT_e+8jkRZZCJA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 15, 2021 at 04:14:31AM +0900, Namhyung Kim escreveu:
> On Thu, Apr 15, 2021 at 3:23 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Apr 14, 2021 at 03:02:08PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Apr 15, 2021 at 01:41:35AM +0900, Namhyung Kim escreveu:
> > > > Hello,
> > > >
> > > > On Thu, Apr 15, 2021 at 1:07 AM Rob Herring <robh@kernel.org> wrote:
> > > > > +void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
> > > > > +{
> > > > > +       if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
> > > > > +               return NULL;
> > > >
> > > > I think you should check the cpu and the thread is in
> > > > a valid range.  Currently xyarray__entry() simply accesses
> > > > the content without checking the boundaries.
> > >
> > > So, since xyarray has the bounds, it should check it, i.e. we need to
> > > have a __xyarray__entry() that is what xyarray__entry() does, i.e.
> > > assume the values have been bounds checked, then a new method,
> > > xyarray__entry() that does bounds check, if it fails, return NULL,
> > > otherwise calls __xyarray__entry().
> > >
> > > I see this is frustrating and I should've chimed in earlier, but at
> > > least now this is getting traction, and the end result will be better
> > > not just for the feature you've been dilligently working on,
> > >
> > > Thank you for your persistence,
> >
> > Re-reading, yeah, this can be done in a separate patch, Namhyung, can I
> > have your Reviewed-by? That or an Acked-by?
> 
> Sure, for the series:
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Ok, b4 failed on it, probably some missing Reply to, so I'll apply it by
hand:

[acme@five perf]$ b4 am -t -s -l --cc-trailers 20210414155412.3697605-1-robh@kernel.org
Looking up https://lore.kernel.org/r/20210414155412.3697605-1-robh%40kernel.org
Grabbing thread from lore.kernel.org/lkml
Analyzing 11 messages in the thread
---
Thread incomplete, attempting to backfill
---
Writing ./v8_20210414_robh_libperf_userspace_counter_access.mbx
  [PATCH v8 1/4] tools/include: Add an initial math64.h
    + Acked-by: Namhyung Kim <namhyung@kernel.org>
    + Acked-by: Jiri Olsa <jolsa@redhat.com> (✓ DKIM/redhat.com)
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20210414155412.3697605-2-robh@kernel.org
    + Cc: Catalin Marinas <catalin.marinas@arm.com>
    + Cc: Mark Rutland <mark.rutland@arm.com>
    + Cc: Itaru Kitayama <itaru.kitayama@gmail.com>
    + Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
    + Cc: Will Deacon <will@kernel.org>
    + Cc: Ingo Molnar <mingo@redhat.com>
    + Cc: linux-kernel@vger.kernel.org
  ERROR: missing [2/4]!
  [PATCH v8 3/4] libperf: tests: Add support for verbose printing
    + Acked-by: Jiri Olsa <jolsa@redhat.com> (✓ DKIM/redhat.com)
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20210414155412.3697605-3-robh@kernel.org
    + Cc: Catalin Marinas <catalin.marinas@arm.com>
    + Cc: Mark Rutland <mark.rutland@arm.com>
    + Cc: Itaru Kitayama <itaru.kitayama@gmail.com>
    + Cc: Peter Zijlstra <peterz@infradead.org>
    + Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
    + Cc: Namhyung Kim <namhyung@kernel.org>
    + Cc: Will Deacon <will@kernel.org>
    + Cc: Ingo Molnar <mingo@redhat.com>
    + Cc: linux-kernel@vger.kernel.org
  [PATCH v8 4/4] libperf: Add support for user space counter access
    + Acked-by: Jiri Olsa <jolsa@redhat.com> (✓ DKIM/redhat.com)
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20210414155412.3697605-4-robh@kernel.org
    + Cc: Catalin Marinas <catalin.marinas@arm.com>
    + Cc: Mark Rutland <mark.rutland@arm.com>
    + Cc: Itaru Kitayama <itaru.kitayama@gmail.com>
    + Cc: Peter Zijlstra <peterz@infradead.org>
    + Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
    + Cc: Namhyung Kim <namhyung@kernel.org>
    + Cc: Will Deacon <will@kernel.org>
    + Cc: Ingo Molnar <mingo@redhat.com>
    + Cc: linux-kernel@vger.kernel.org
---
Total patches: 3
---
WARNING: Thread incomplete!
Cover: ./v8_20210414_robh_libperf_userspace_counter_access.cover
 Link: https://lore.kernel.org/r/20210414155412.3697605-1-robh@kernel.org
 Base: not found
       git am ./v8_20210414_robh_libperf_userspace_counter_access.mbx
[acme@five perf]$
