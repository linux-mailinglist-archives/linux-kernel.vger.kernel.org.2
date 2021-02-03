Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D18B30E437
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhBCUtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:49:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232329AbhBCUqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:46:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4721964F58;
        Wed,  3 Feb 2021 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612385090;
        bh=HU3lcXYzW0AmAK9z/JWzWJGpYf2uoz2DW9TuQFbx2AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kq5SGPY4K5B9MnDQKUqGKb12hcVSSAQ2y4UF3pKGqwZQ0qMGxaCOuKuBx4+ux9qip
         71mAWgo3qy34mfJO04OfTz/LxObItureo5a9+EJefG+Ti3yoigeTvKB3SW29MNkdAu
         a1Px/9ezX4rJklKoVE63/TZdlDAsuiAwuMqp8VYtRelcjfRZIpKb+z9AxeqRfxqzgZ
         dy79ZjVoQhiSlGNljIyP7thcWDAZ89mWGGUMCFX/7m6aP5A2F/soVm3LOuEZi0rC+Q
         kO77uLR02x+C3GF2SLWLnQeCgYOHe7RitcV6hMn0bIgdG/WXOxaaWS59eW0QrOT5bM
         OqzfZN+k+PKqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4511A40513; Wed,  3 Feb 2021 17:44:48 -0300 (-03)
Date:   Wed, 3 Feb 2021 17:44:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 7/9] perf test: Support PERF_SAMPLE_WEIGHT_STRUCT
Message-ID: <20210203204448.GL854763@kernel.org>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-8-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612296553-21962-8-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 02, 2021 at 12:09:11PM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Support the new sample type for sample-parsing test case.

ditto wrt code page size
 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/tests/sample-parsing.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> index 2393916..c5739cc 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
> @@ -129,6 +129,9 @@ static bool samples_same(const struct perf_sample *s1,
>  	if (type & PERF_SAMPLE_WEIGHT)
>  		COMP(weight);
>  
> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> +		COMP(ins_lat);
> +
>  	if (type & PERF_SAMPLE_DATA_SRC)
>  		COMP(data_src);
>  
> @@ -238,6 +241,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>  		.phys_addr	= 113,
>  		.cgroup		= 114,
>  		.data_page_size = 115,
> +		.ins_lat	= 116,
>  		.aux_sample	= {
>  			.size	= sizeof(aux_data),
>  			.data	= (void *)aux_data,
> @@ -344,7 +348,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
>  	 * were added.  Please actually update the test rather than just change
>  	 * the condition below.
>  	 */
> -	if (PERF_SAMPLE_MAX > PERF_SAMPLE_CODE_PAGE_SIZE << 1) {
> +	if (PERF_SAMPLE_MAX > PERF_SAMPLE_WEIGHT_STRUCT << 1) {
>  		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
>  		return -1;
>  	}
> @@ -374,8 +378,12 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
>  			return err;
>  	}
>  
> -	/* Test all sample format bits together */
> -	sample_type = PERF_SAMPLE_MAX - 1;
> +	/*
> +	 * Test all sample format bits together
> +	 * Note: PERF_SAMPLE_WEIGHT and PERF_SAMPLE_WEIGHT_STRUCT cannot
> +	 *       be set simultaneously.
> +	 */
> +	sample_type = (PERF_SAMPLE_MAX - 1) & ~PERF_SAMPLE_WEIGHT;
>  	sample_regs = 0x3fff; /* shared yb intr and user regs */
>  	for (i = 0; i < ARRAY_SIZE(rf); i++) {
>  		err = do_test(sample_type, sample_regs, rf[i]);
> -- 
> 2.7.4
> 

-- 

- Arnaldo
