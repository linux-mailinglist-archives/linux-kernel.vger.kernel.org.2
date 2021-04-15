Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F308361314
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhDOTtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 15:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234735AbhDOTtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 15:49:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3EC060FF0;
        Thu, 15 Apr 2021 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618516118;
        bh=XFrfWw1wDB/JimT4e2JQs2CnouuoEnMmATfGQ4ibUJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLPj4qRz+1LxZB4SuMFlmhCwXdqTB+PTtTbO36fH+orIpW7l0ch06e8v4auyjbczq
         fG4PoN6Up7ndM41Pf0Vg43U3x+GGpJTZp1U4ZWZkl3oNuEccl5KkE6BookMl27y6ti
         i7OfVV4HjuuE53+m0LdukMMtvYfs2365PCSmJpdyP/eELfsF0JAk8MvYEzcCavHDS0
         wcv9npLXwf3SnewlI+db6EI6gH9zqkTyOPivPPAF5dAhDcJxCCe0rdcfD4S8hEoPOH
         MDiSIK/Mjs4D1J0xUfOZ/vi2cUUa5GVKwrq4kV9c1LE87nPceyDZy/AxWERU71yAw+
         FK4qstS1S6Nsw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7AA540647; Thu, 15 Apr 2021 16:48:34 -0300 (-03)
Date:   Thu, 15 Apr 2021 16:48:34 -0300
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
Message-ID: <YHiYkhBKWRYA6WRC@kernel.org>
References: <20210414195758.4078803-1-robh@kernel.org>
 <CAM9d7chWROPAg3T_gd+T6N+94pWawKtggyegCGo0nXzKF+F7+g@mail.gmail.com>
 <CAL_JsqKuk53i0Lf=3sMOjieSNZo3Rqh+-Uhbd0n3qn=rpRKfLQ@mail.gmail.com>
 <YHiYJp9nabvsCZ4O@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHiYJp9nabvsCZ4O@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 15, 2021 at 04:46:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 14, 2021 at 03:53:36PM -0500, Rob Herring escreveu:
> > On Wed, Apr 14, 2021 at 3:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Thu, Apr 15, 2021 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > xyarray__entry() is missing any bounds checking yet often the x and y
> > > > parameters come from external callers. Add bounds checks and an
> > > > unchecked __xyarray__entry().
> > > >
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  tools/lib/perf/include/internal/xyarray.h | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/lib/perf/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
> > > > index 51e35d6c8ec4..f0896c00b494 100644
> > > > --- a/tools/lib/perf/include/internal/xyarray.h
> > > > +++ b/tools/lib/perf/include/internal/xyarray.h
> > > > @@ -18,11 +18,18 @@ struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
> > > >  void xyarray__delete(struct xyarray *xy);
> > > >  void xyarray__reset(struct xyarray *xy);
> > > >
> > > > -static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
> > > > +static inline void *__xyarray__entry(struct xyarray *xy, int x, int y)
> > > >  {
> > > >         return &xy->contents[x * xy->row_size + y * xy->entry_size];
> > > >  }
> > > >
> > > > +static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
> > > > +{
> > > > +       if (x >= xy->max_x || y >= xy->max_y)
> > > > +               return NULL;
> > >
> > > Maybe better to check negatives as well.
> > 
> > max_x and max_y are size_t and unsigned, so x and y will be promoted
> > to unsigned and the check will still work.
> 
> Fair enough, applied.

So...:

  CC       /tmp/build/perf/builtin-script.o
In file included from xyarray.c:2:
/home/acme/git/perf/tools/lib/perf/include/internal/xyarray.h: In function ‘xyarray__entry’:
/home/acme/git/perf/tools/lib/perf/include/internal/xyarray.h:28:8: error: comparison of integer expressions of different signedness: ‘int’ and ‘size_t’ {aka ‘long unsigned int’} [-Werror=sign-compare]
   28 |  if (x >= xy->max_x || y >= xy->max_y)
      |        ^~
/home/acme/git/perf/tools/lib/perf/include/internal/xyarray.h:28:26: error: comparison of integer expressions of different signedness: ‘int’ and ‘size_t’ {aka ‘long unsigned int’} [-Werror=sign-compare]
   28 |  if (x >= xy->max_x || y >= xy->max_y)
      |                          ^~
cc1: all warnings being treated as errors


Fedora 33's gcc complains, so I'll cast it to size_t.

- Arnaldo
 
>  
> > It's probably better to change the args to size_t though. And perhaps
> > on xyarray__new(), xyarray__max_y(), and xyarray__max_x() as well.

-- 

- Arnaldo
