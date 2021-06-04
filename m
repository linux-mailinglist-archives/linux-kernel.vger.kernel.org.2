Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E2F39B969
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFDNH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhFDNH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:07:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCA5C611AE;
        Fri,  4 Jun 2021 13:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622811972;
        bh=op6mFMNBOG5sNidlhmJKg6sGFjEf9a++1qcAfO/vUdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5dQUcS8ebpyxCKDr/JxT8uLlfjXMnog4xZ0SA3Ts09HTgTLoFQr63FcQZSSr9Auo
         PL7DpQdV9U3/y/ApGZSs4ZUvk0y7GhAp3NhGY/e/8bKa4Q64uirMF5glGjfFXUJUEv
         WRMXYwhz+IqQ0N6RX+MyUoEFdl4mXM9ZVssaEiR+yMOuGtGq20d2MFJK4FScauFWtL
         DEC6TAa0GdDf6CnfClsC3vLV0yTjeAG9pcEp+NHkFJBh3UKGL92+TfZ1AQqVaEWqUF
         0zDwyOG/AMOt/O3UdD6Luc0c7FiX5o3p+goOT05ZbBkAu90o9nqYZsEYIXqnsrDJMk
         N/NLdCh6hDYYA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F014240EFC; Fri,  4 Jun 2021 10:06:08 -0300 (-03)
Date:   Fri, 4 Jun 2021 10:06:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH 1/3] perf stat: Check return value of asprintf() properly
Message-ID: <YLolQAIq3tpC4LTL@kernel.org>
References: <20210602212241.2175005-1-namhyung@kernel.org>
 <CAP-5=fVUvsnuayy9pqSUY1tjk9ptw5+QMXZrAwUKLzWD5hKa8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVUvsnuayy9pqSUY1tjk9ptw5+QMXZrAwUKLzWD5hKa8g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 03, 2021 at 09:47:58PM -0700, Ian Rogers escreveu:
> On Wed, Jun 2, 2021 at 2:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It returns -1 on error, so checking with 0 would not work.
> >
> > Fixes: 12279429d862 ("perf stat: Uniquify hybrid event name")
> > Cc: Jin Yao <yao.jin@linux.intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied both.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/stat-display.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index b759dfd633b4..04afd41b6067 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -564,7 +564,7 @@ static void uniquify_event_name(struct evsel *counter)
> >                                        counter->name, counter->pmu_name);
> >                 }
> >
> > -               if (ret) {
> > +               if (ret > 0) {
> >                         free(counter->name);
> >                         counter->name = new_name;
> >                 }
> > --
> > 2.32.0.rc0.204.g9fa02ecfa5-goog
> >

-- 

- Arnaldo
