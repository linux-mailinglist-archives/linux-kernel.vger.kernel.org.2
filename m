Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5231A607
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhBLU1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhBLU1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:27:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3D4760200;
        Fri, 12 Feb 2021 20:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613161581;
        bh=uvh2JjJGO0LkjSarTE71s0DcdlwXWYF696TTVPU/K98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMtwmZx2glV5ayocFr98JAfSziC5Jq2W0I8qBI3FfyoddlmdavXgD3OlV0hts1aYB
         W3PZN203IyUBiyW0kQxZzA+DZUn1/sgXz0VUqAcjCUWvDQZUsJwgfB6HndGp8k7TLq
         b2m6AM8FdnfYUQ2jTFgeKb2ZSULHSc4P53DS3kMDW1+/eQ1JA2aOZKEAogReJvI6II
         IIO1tReYhvAzU6GFqTjQm8V6ufGsT22C3dljGDCi+IqvGN9ImQPF2IoDHkcTd/JEI6
         bapfP4VDR1FrdpzM97SciNSoCrQIfwqz7I9xa30wh3xmEIRGcH8nW8mRXqGRMxEAMe
         0RzcleV5vLrtg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66F4C40513; Fri, 12 Feb 2021 17:26:16 -0300 (-03)
Date:   Fri, 12 Feb 2021 17:26:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf libperf: Remove unused xyarray.c
Message-ID: <20210212202616.GG1398414@kernel.org>
References: <20210212043803.365993-1-irogers@google.com>
 <YCY9dtFKwTLjTq+w@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCY9dtFKwTLjTq+w@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 12, 2021 at 09:33:58AM +0100, Jiri Olsa escreveu:
> On Thu, Feb 11, 2021 at 08:38:03PM -0800, Ian Rogers wrote:
> > Migrated to libperf in:
> > commit 4b247fa7314c ("libperf: Adopt xyarray class from perf")
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/xyarray.c | 33 ---------------------------------
> >  1 file changed, 33 deletions(-)
> >  delete mode 100644 tools/perf/util/xyarray.c
> > 
> > diff --git a/tools/perf/util/xyarray.c b/tools/perf/util/xyarray.c
> > deleted file mode 100644
> > index 86889ebc3514..000000000000
> > --- a/tools/perf/util/xyarray.c
> > +++ /dev/null
> > @@ -1,33 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include "xyarray.h"
> > -#include <stdlib.h>
> > -#include <string.h>
> > -#include <linux/zalloc.h>
> > -
> > -struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size)
> > -{
> > -	size_t row_size = ylen * entry_size;
> > -	struct xyarray *xy = zalloc(sizeof(*xy) + xlen * row_size);
> > -
> > -	if (xy != NULL) {
> > -		xy->entry_size = entry_size;
> > -		xy->row_size   = row_size;
> > -		xy->entries    = xlen * ylen;
> > -		xy->max_x      = xlen;
> > -		xy->max_y      = ylen;
> > -	}
> > -
> > -	return xy;
> > -}
> > -
> > -void xyarray__reset(struct xyarray *xy)
> > -{
> > -	size_t n = xy->entries * xy->entry_size;
> > -
> > -	memset(xy->contents, 0, n);
> > -}
> > -
> > -void xyarray__delete(struct xyarray *xy)
> > -{
> > -	free(xy);
> > -}
> > -- 
> > 2.30.0.478.g8a0d178c01-goog
> > 
> 

-- 

- Arnaldo
