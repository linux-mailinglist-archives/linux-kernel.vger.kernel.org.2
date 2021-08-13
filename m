Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF83EB636
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 15:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbhHMNqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 09:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240660AbhHMNqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 09:46:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 243CE610FA;
        Fri, 13 Aug 2021 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628862357;
        bh=mEgbN/2TUygqQhXGsMw6TNwBF+MK1gURp246MiNT6Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsCOy4l26L1yFd3FhXOQYaE+184kPfg96L+XUF9Z6rgCGBidjmLSJ6i8UTNz0m5vm
         PZZVvrGMNwlaakGTE3sddzi+l4Ey9fWNK2V9zyzpZI5CC84Wn88Vojhm1uvaQnBAt9
         0hTvlEK/3Qf8cOF4z4m5CoZrrnlXz9xsDWfOjd/tEzg+XFCQnY400ZkEKxq1AGv1ma
         mS+8cJs4zsOcofPcC/97FK/JWrxyxabtaPrI9/eY1qdBSpK3UbXFkjBsqMfVIKuFZd
         rFU4WCnQ98jovFNK6Wu2nPkKTzr7y5SwjGZddBFhWzQbR9zfnliF371w66oevNgPRl
         Pn3hzI8SMJmkw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 67835403F2; Fri, 13 Aug 2021 10:45:54 -0300 (-03)
Date:   Fri, 13 Aug 2021 10:45:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        James Clark <james.clark@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf test: Do not compare overheads in the zstd comp test
Message-ID: <YRZ3kjG2+3oO6qyq@kernel.org>
References: <20210812235738.1684583-1-namhyung@kernel.org>
 <CAP-5=fVamifp3oua6OTCm3pCxM=RoiMATx90Ynm6JLnUso7zLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVamifp3oua6OTCm3pCxM=RoiMATx90Ynm6JLnUso7zLA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 12, 2021 at 05:09:20PM -0700, Ian Rogers escreveu:
> On Thu, Aug 12, 2021 at 4:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The overhead can vary on each run so it'd make the test failed
> > sometimes.  Also order of hist entry can change.
> >
> > Use perf report -F option to omit the overhead field and sort the
> > result alphabetically.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/shell/record+zstd_comp_decomp.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> > index 045723b3d992..8a168cf8bacc 100755
> > --- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> > +++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> > @@ -25,8 +25,8 @@ check_compressed_stats() {
> >
> >  check_compressed_output() {
> >         $perf_tool inject -i $trace_file -o $trace_file.decomp &&
> > -       $perf_tool report -i $trace_file --stdio | head -n -3 > $trace_file.comp.output &&
> > -       $perf_tool report -i $trace_file.decomp --stdio | head -n -3 > $trace_file.decomp.output &&
> > +       $perf_tool report -i $trace_file --stdio -F comm,dso,sym | head -n -3 > $trace_file.comp.output &&
> > +       $perf_tool report -i $trace_file.decomp --stdio -F comm,dso,sym | head -n -3 > $trace_file.decomp.output &&
> >         diff $trace_file.comp.output $trace_file.decomp.output
> >  }
> >
> > --
> > 2.33.0.rc1.237.g0d66db33f3-goog
> >

-- 

- Arnaldo
