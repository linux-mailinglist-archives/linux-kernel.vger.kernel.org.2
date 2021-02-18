Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D76B31F034
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhBRTnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhBRTJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:09:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9B4464ECC;
        Thu, 18 Feb 2021 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613675351;
        bh=fqwSRDj3myioMaYiJ7H6OhIAHWqu96KAuxo9Peo+unA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXk4BuYuxZojM0tTa/6EO+CIcTVnMlHypIJnjYYhu8WOaD97IPPpqkWAOlrwPM5fE
         Mx6TAlrLzlAPn8JX837UUQZldKWfauRmq1vyNTTG+TUsBU75qcpqApz3JO2i+QMMlN
         b5AC4/locDh0eGjeUMQZr4btEcG0BTWWZtd73b/8/JptzymC6JfAZHo5RXtfkjyhuO
         WudeiCuVZE75uvDBE7N9OPATOI6GpPeOtoKBjvzF74NX5xuTw+mgZKcx3cc3DcjmGl
         +pg2p2hXyGl8umf/onQAJl++sztbP8gUEvynJWMjhlmBk4wm54d47MVv7sOlaBf49i
         oz2wOfXaYmXeg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2A1540CD9; Thu, 18 Feb 2021 16:09:08 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:09:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf test: Fix unaligned access in sample parsing test
Message-ID: <YC67VPX6rarQ0S8Q@kernel.org>
References: <20210214091638.519643-1-namhyung@kernel.org>
 <870d16e1-30dc-161d-33bf-e35428260ec6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <870d16e1-30dc-161d-33bf-e35428260ec6@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 15, 2021 at 08:26:08AM +0200, Adrian Hunter escreveu:
> On 14/02/21 11:16 am, Namhyung Kim wrote:
> > The ubsan reported the following error.  It was because sample's raw
> > data missed u32 padding at the end.  So it broke the alignment of the
> > array after it.
> > 
> > The raw data contains an u32 size prefix so the data size should have
> > an u32 padding after 8-byte aligned data.
> > 
> > 27: Sample parsing  :util/synthetic-events.c:1539:4:
> >   runtime error: store to misaligned address 0x62100006b9bc for type
> >   '__u64' (aka 'unsigned long long'), which requires 8 byte alignment
> > 0x62100006b9bc: note: pointer points here
> >   00 00 00 00 ff ff ff ff  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> >               ^
> >     #0 0x561532a9fc96 in perf_event__synthesize_sample util/synthetic-events.c:1539:13
> >     #1 0x5615327f4a4f in do_test tests/sample-parsing.c:284:8
> >     #2 0x5615327f3f50 in test__sample_parsing tests/sample-parsing.c:381:9
> >     #3 0x56153279d3a1 in run_test tests/builtin-test.c:424:9
> >     #4 0x56153279c836 in test_and_print tests/builtin-test.c:454:9
> >     #5 0x56153279b7eb in __cmd_test tests/builtin-test.c:675:4
> >     #6 0x56153279abf0 in cmd_test tests/builtin-test.c:821:9
> >     #7 0x56153264e796 in run_builtin perf.c:312:11
> >     #8 0x56153264cf03 in handle_internal_command perf.c:364:8
> >     #9 0x56153264e47d in run_argv perf.c:408:2
> >     #10 0x56153264c9a9 in main perf.c:538:3
> >     #11 0x7f137ab6fbbc in __libc_start_main (/lib64/libc.so.6+0x38bbc)
> >     #12 0x561532596828 in _start ...
> > 
> > SUMMARY: UndefinedBehaviorSanitizer: misaligned-pointer-use
> >  util/synthetic-events.c:1539:4 in

Thanks, applied.

- Arnaldo

 
> > Fixes: 045f8cd8542d ("perf tests: Add a sample parsing test")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> > ---
> >  tools/perf/tests/sample-parsing.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> > index f506eabfc269..0dbe3aa99853 100644
> > --- a/tools/perf/tests/sample-parsing.c
> > +++ b/tools/perf/tests/sample-parsing.c
> > @@ -202,7 +202,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
> >  		.data = {1, -1ULL, 211, 212, 213},
> >  	};
> >  	u64 regs[64];
> > -	const u64 raw_data[] = {0x123456780a0b0c0dULL, 0x1102030405060708ULL};
> > +	const u32 raw_data[] = {0x12345678, 0x0a0b0c0d, 0x11020304, 0x05060708, 0 };
> >  	const u64 data[] = {0x2211443366558877ULL, 0, 0xaabbccddeeff4321ULL};
> >  	const u64 aux_data[] = {0xa55a, 0, 0xeeddee, 0x0282028202820282};
> >  	struct perf_sample sample = {
> > 
> 

-- 

- Arnaldo
