Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF036130E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 21:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhDOTrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 15:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234954AbhDOTrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 15:47:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42625610FC;
        Thu, 15 Apr 2021 19:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618516009;
        bh=99yOuosVCqntbi99t5Badr8yj6MP1RNPcmVp864g8kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j66LItH6fpvLi+TKG7eGi1hPhR3ULIs3PzhvihWlbotIFd0EYfND+iJIqjwBdpB2X
         cnyOCBlmQhFbZEGYAqZefByPNgBOEzVlZqpsQQLQsYTFZ+RuGluEPvzDvmXEyf+5n5
         QfKIhmWph5DvWEYxKoD0aaarnaaQ4r31lQavPA/hWQ6C5NveyWIhrNuWp/OLh8Ild+
         QP84FzWfm7f1oHAXzpssDCSnMXoRRWLMdFOX0WpqIDNQAljD2LjwCDh/STBc58fixZ
         T534FCmxVh+p4La6jVg4QEKbAccEyrBSyGBt8t7+D3RteeAKkKgVucIeEHKOfp+8Yp
         qb3VZT08DV2pw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A29340647; Thu, 15 Apr 2021 16:46:46 -0300 (-03)
Date:   Thu, 15 Apr 2021 16:46:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] libperf: xyarray: Add bounds checks to xyarray__entry()
Message-ID: <YHiYJp9nabvsCZ4O@kernel.org>
References: <20210414195758.4078803-1-robh@kernel.org>
 <CAM9d7chWROPAg3T_gd+T6N+94pWawKtggyegCGo0nXzKF+F7+g@mail.gmail.com>
 <CAL_JsqKuk53i0Lf=3sMOjieSNZo3Rqh+-Uhbd0n3qn=rpRKfLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKuk53i0Lf=3sMOjieSNZo3Rqh+-Uhbd0n3qn=rpRKfLQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 14, 2021 at 03:53:36PM -0500, Rob Herring escreveu:
> On Wed, Apr 14, 2021 at 3:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Apr 15, 2021 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > xyarray__entry() is missing any bounds checking yet often the x and y
> > > parameters come from external callers. Add bounds checks and an
> > > unchecked __xyarray__entry().
> > >
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  tools/lib/perf/include/internal/xyarray.h | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/perf/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
> > > index 51e35d6c8ec4..f0896c00b494 100644
> > > --- a/tools/lib/perf/include/internal/xyarray.h
> > > +++ b/tools/lib/perf/include/internal/xyarray.h
> > > @@ -18,11 +18,18 @@ struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
> > >  void xyarray__delete(struct xyarray *xy);
> > >  void xyarray__reset(struct xyarray *xy);
> > >
> > > -static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
> > > +static inline void *__xyarray__entry(struct xyarray *xy, int x, int y)
> > >  {
> > >         return &xy->contents[x * xy->row_size + y * xy->entry_size];
> > >  }
> > >
> > > +static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
> > > +{
> > > +       if (x >= xy->max_x || y >= xy->max_y)
> > > +               return NULL;
> >
> > Maybe better to check negatives as well.
> 
> max_x and max_y are size_t and unsigned, so x and y will be promoted
> to unsigned and the check will still work.

Fair enough, applied.

- Arnaldo
 
> It's probably better to change the args to size_t though. And perhaps
> on xyarray__new(), xyarray__max_y(), and xyarray__max_x() as well.
