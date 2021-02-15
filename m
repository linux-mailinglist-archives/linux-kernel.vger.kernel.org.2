Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519B931B561
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 07:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBOG07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 01:26:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:44573 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhBOG0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 01:26:55 -0500
IronPort-SDR: cPU903P6yZrfpxA+6zHKa2QPbmLhByKQB8AMYaFyvqU5WkOr3aZ2Lp7jnVJUcERs5M73ma4ESd
 OLGd1xcOrVNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="246690438"
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400"; 
   d="scan'208";a="246690438"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2021 22:26:11 -0800
IronPort-SDR: Yw7eB/ypS+B6kCv/SY4jILLEHSHTj630omnK82lbZSKWG2i9QcENN149E6CrYmGv52KbstOSwC
 PGtrjfHZGdKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400"; 
   d="scan'208";a="425356345"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2021 22:26:09 -0800
Subject: Re: [PATCH] perf test: Fix unaligned access in sample parsing test
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
References: <20210214091638.519643-1-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <870d16e1-30dc-161d-33bf-e35428260ec6@intel.com>
Date:   Mon, 15 Feb 2021 08:26:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210214091638.519643-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/21 11:16 am, Namhyung Kim wrote:
> The ubsan reported the following error.  It was because sample's raw
> data missed u32 padding at the end.  So it broke the alignment of the
> array after it.
> 
> The raw data contains an u32 size prefix so the data size should have
> an u32 padding after 8-byte aligned data.
> 
> 27: Sample parsing  :util/synthetic-events.c:1539:4:
>   runtime error: store to misaligned address 0x62100006b9bc for type
>   '__u64' (aka 'unsigned long long'), which requires 8 byte alignment
> 0x62100006b9bc: note: pointer points here
>   00 00 00 00 ff ff ff ff  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>               ^
>     #0 0x561532a9fc96 in perf_event__synthesize_sample util/synthetic-events.c:1539:13
>     #1 0x5615327f4a4f in do_test tests/sample-parsing.c:284:8
>     #2 0x5615327f3f50 in test__sample_parsing tests/sample-parsing.c:381:9
>     #3 0x56153279d3a1 in run_test tests/builtin-test.c:424:9
>     #4 0x56153279c836 in test_and_print tests/builtin-test.c:454:9
>     #5 0x56153279b7eb in __cmd_test tests/builtin-test.c:675:4
>     #6 0x56153279abf0 in cmd_test tests/builtin-test.c:821:9
>     #7 0x56153264e796 in run_builtin perf.c:312:11
>     #8 0x56153264cf03 in handle_internal_command perf.c:364:8
>     #9 0x56153264e47d in run_argv perf.c:408:2
>     #10 0x56153264c9a9 in main perf.c:538:3
>     #11 0x7f137ab6fbbc in __libc_start_main (/lib64/libc.so.6+0x38bbc)
>     #12 0x561532596828 in _start ...
> 
> SUMMARY: UndefinedBehaviorSanitizer: misaligned-pointer-use
>  util/synthetic-events.c:1539:4 in
> 
> Fixes: 045f8cd8542d ("perf tests: Add a sample parsing test")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/sample-parsing.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> index f506eabfc269..0dbe3aa99853 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
> @@ -202,7 +202,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>  		.data = {1, -1ULL, 211, 212, 213},
>  	};
>  	u64 regs[64];
> -	const u64 raw_data[] = {0x123456780a0b0c0dULL, 0x1102030405060708ULL};
> +	const u32 raw_data[] = {0x12345678, 0x0a0b0c0d, 0x11020304, 0x05060708, 0 };
>  	const u64 data[] = {0x2211443366558877ULL, 0, 0xaabbccddeeff4321ULL};
>  	const u64 aux_data[] = {0xa55a, 0, 0xeeddee, 0x0282028202820282};
>  	struct perf_sample sample = {
> 

