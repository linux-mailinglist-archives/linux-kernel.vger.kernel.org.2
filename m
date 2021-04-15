Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C4236131E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhDOTvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 15:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234659AbhDOTvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 15:51:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EA5560C3E;
        Thu, 15 Apr 2021 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618516272;
        bh=Vi4ZQVp6eNHn89x2m3ZAFI/gBHKlopsh0hgr5OJiMOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JRYqfeQxBaqtbb8bx1WwD8ZfVgmmMBRE9YcbWfRGRKOvuriR7P8M8pQupaaUk1TXw
         wndA4c2Ob9bPudH+NWsQiywp7xbqAzaz5paJO3tYjD7PdDomhrEPck8OQUtj+h35I8
         AT/Yu/lEh638tC6qIxW1hDqDy3gVjNWIR8Xk7CNo/a1V9ml8Kea7IkbeZ+ERc+bExb
         yvdnYm8H+Lp+IcvifJCElqM8469293lved1aHzm/2SO4ORDu5DZBaBvJmXOTKuq5pN
         mw/wcOoKmmZ8wdGG34+bAIkagLVCCFX0Sr2LwwUHFRBjpws71PJBfkomK5xBPIm6L+
         EG1RslIRCi1mQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 31CEC40647; Thu, 15 Apr 2021 16:51:09 -0300 (-03)
Date:   Thu, 15 Apr 2021 16:51:09 -0300
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
Message-ID: <YHiZLbHBsnBkVzbZ@kernel.org>
References: <20210414195758.4078803-1-robh@kernel.org>
 <CAM9d7chWROPAg3T_gd+T6N+94pWawKtggyegCGo0nXzKF+F7+g@mail.gmail.com>
 <CAL_JsqKuk53i0Lf=3sMOjieSNZo3Rqh+-Uhbd0n3qn=rpRKfLQ@mail.gmail.com>
 <YHiYJp9nabvsCZ4O@kernel.org>
 <YHiYkhBKWRYA6WRC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHiYkhBKWRYA6WRC@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 15, 2021 at 04:48:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Apr 15, 2021 at 04:46:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Apr 14, 2021 at 03:53:36PM -0500, Rob Herring escreveu:
> > > On Wed, Apr 14, 2021 at 3:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > +static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
> > > > > +{
> > > > > +       if (x >= xy->max_x || y >= xy->max_y)
> > > > > +               return NULL;
> > > >
> > > > Maybe better to check negatives as well.
> > > 
> > > max_x and max_y are size_t and unsigned, so x and y will be promoted
> > > to unsigned and the check will still work.
> > 
> > Fair enough, applied.
> 
> So...:
> 
>   CC       /tmp/build/perf/builtin-script.o
> In file included from xyarray.c:2:
> /home/acme/git/perf/tools/lib/perf/include/internal/xyarray.h: In function ‘xyarray__entry’:
> /home/acme/git/perf/tools/lib/perf/include/internal/xyarray.h:28:8: error: comparison of integer expressions of different signedness: ‘int’ and ‘size_t’ {aka ‘long unsigned int’} [-Werror=sign-compare]
>    28 |  if (x >= xy->max_x || y >= xy->max_y)
>       |        ^~
> /home/acme/git/perf/tools/lib/perf/include/internal/xyarray.h:28:26: error: comparison of integer expressions of different signedness: ‘int’ and ‘size_t’ {aka ‘long unsigned int’} [-Werror=sign-compare]
>    28 |  if (x >= xy->max_x || y >= xy->max_y)
>       |                          ^~
> cc1: all warnings being treated as errors
> 
> 
> Fedora 33's gcc complains, so I'll cast it to size_t.

> > > It's probably better to change the args to size_t though. And perhaps
> > > on xyarray__new(), xyarray__max_y(), and xyarray__max_x() as well.

So I did this, should be enough:

diff --git a/tools/lib/perf/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
index f0896c00b4940016..f10af3da7b21cc15 100644
--- a/tools/lib/perf/include/internal/xyarray.h
+++ b/tools/lib/perf/include/internal/xyarray.h
@@ -23,7 +23,7 @@ static inline void *__xyarray__entry(struct xyarray *xy, int x, int y)
 	return &xy->contents[x * xy->row_size + y * xy->entry_size];
 }
 
-static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
+static inline void *xyarray__entry(struct xyarray *xy, size_t x, size_t y)
 {
 	if (x >= xy->max_x || y >= xy->max_y)
 		return NULL;
