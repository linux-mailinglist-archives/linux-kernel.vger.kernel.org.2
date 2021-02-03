Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7459430E3FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhBCUWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhBCUWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:22:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D2A264F74;
        Wed,  3 Feb 2021 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612383696;
        bh=l+Q8cVjJCF46Q7uBRRuHlNXTNi7wvYTaUBGpLznUN1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCBFsg7lZbde/KK/Px0Q80A2/EDR1Jlqw/nrG/oC6axfT0b308bokJ2pa9b60EnRy
         IuPr2+8DX3JyrAsNjfZRu9eqhJhC21gHiD8IVmzF1cH2/okiERLMh/JtSh/GgrdmJt
         kdOv1z+7ueYXNBJ6L5jPEWBcQV7T6HlXuhG3whfmfZzs8btRFD0XSlW+ysgqKixc2L
         P8mEgM+sCWsOeE205fBt/CsBXax0qS1G2JCcKu6/d5GSiHksNxznkFYByD8ZS4cR5a
         fNFO7csPxJROsuojw13QTzCKL0TCZL10lNU/KMoJTFSf0xeQvTn6NEjOz2nmhvEbEV
         ivU1bRU+D+eRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 974D740513; Wed,  3 Feb 2021 17:21:30 -0300 (-03)
Date:   Wed, 3 Feb 2021 17:21:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Joe Mario <jmario@redhat.com>
Cc:     Don Zickus <dzickus@redhat.com>, kan.liang@linux.intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 4/9] perf c2c: Support data block and addr block
Message-ID: <20210203202130.GI854763@kernel.org>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612296553-21962-5-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 02, 2021 at 12:09:08PM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>

Hey Joe, heads up on these new fields.

The whole thread is at:

  https://lore.kernel.org/lkml/1612296553-21962-1-git-send-email-kan.liang@linux.intel.com/

The kernel cset introducing the support:

  "perf/x86/intel: Add perf core PMU support for Sapphire Rapids"
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/core&id=61b985e3e775a3a75fda04ce7ef1b1aefc4758bc

Cheers,

- Arnaldo
 
> perf c2c is also a memory profiling tool. Apply the two new data source
> fields to perf c2c as well.
> 
> Extend perf c2c to display the number of loads which blocked by data or
> address conflict.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-c2c.c     | 3 +++
>  tools/perf/util/mem-events.c | 6 ++++++
>  tools/perf/util/mem-events.h | 2 ++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c5babea..4de49ae 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2111,6 +2111,8 @@ static void print_c2c__display_stats(FILE *out)
>  	fprintf(out, "  Load MESI State Exclusive         : %10d\n", stats->ld_excl);
>  	fprintf(out, "  Load MESI State Shared            : %10d\n", stats->ld_shared);
>  	fprintf(out, "  Load LLC Misses                   : %10d\n", llc_misses);
> +	fprintf(out, "  Load access blocked by data       : %10d\n", stats->blk_data);
> +	fprintf(out, "  Load access blocked by address    : %10d\n", stats->blk_addr);
>  	fprintf(out, "  LLC Misses to Local DRAM          : %10.1f%%\n", ((double)stats->lcl_dram/(double)llc_misses) * 100.);
>  	fprintf(out, "  LLC Misses to Remote DRAM         : %10.1f%%\n", ((double)stats->rmt_dram/(double)llc_misses) * 100.);
>  	fprintf(out, "  LLC Misses to Remote cache (HIT)  : %10.1f%%\n", ((double)stats->rmt_hit /(double)llc_misses) * 100.);
> @@ -2139,6 +2141,7 @@ static void print_shared_cacheline_info(FILE *out)
>  	fprintf(out, "  L2D hits on shared lines          : %10d\n", stats->ld_l2hit);
>  	fprintf(out, "  LLC hits on shared lines          : %10d\n", stats->ld_llchit + stats->lcl_hitm);
>  	fprintf(out, "  Locked Access on shared lines     : %10d\n", stats->locks);
> +	fprintf(out, "  Blocked Access on shared lines    : %10d\n", stats->blk_data + stats->blk_addr);
>  	fprintf(out, "  Store HITs on shared lines        : %10d\n", stats->store);
>  	fprintf(out, "  Store L1D hits on shared lines    : %10d\n", stats->st_l1hit);
>  	fprintf(out, "  Total Merged records              : %10d\n", hitm_cnt + stats->store);
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 890f638..f93a852 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -385,6 +385,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
>  	u64 lvl    = data_src->mem_lvl;
>  	u64 snoop  = data_src->mem_snoop;
>  	u64 lock   = data_src->mem_lock;
> +	u64 blk    = data_src->mem_blk;
>  	/*
>  	 * Skylake might report unknown remote level via this
>  	 * bit, consider it when evaluating remote HITMs.
> @@ -404,6 +405,9 @@ do {				\
>  
>  	if (lock & P(LOCK, LOCKED)) stats->locks++;
>  
> +	if (blk & P(BLK, DATA)) stats->blk_data++;
> +	if (blk & P(BLK, ADDR)) stats->blk_addr++;
> +
>  	if (op & P(OP, LOAD)) {
>  		/* load */
>  		stats->load++;
> @@ -515,6 +519,8 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
>  	stats->rmt_hit		+= add->rmt_hit;
>  	stats->lcl_dram		+= add->lcl_dram;
>  	stats->rmt_dram		+= add->rmt_dram;
> +	stats->blk_data		+= add->blk_data;
> +	stats->blk_addr		+= add->blk_addr;
>  	stats->nomap		+= add->nomap;
>  	stats->noparse		+= add->noparse;
>  }
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 5ddf447..755cef7 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -79,6 +79,8 @@ struct c2c_stats {
>  	u32	rmt_hit;             /* count of loads with remote hit clean; */
>  	u32	lcl_dram;            /* count of loads miss to local DRAM */
>  	u32	rmt_dram;            /* count of loads miss to remote DRAM */
> +	u32	blk_data;            /* count of loads blocked by data */
> +	u32	blk_addr;            /* count of loads blocked by address conflict */
>  	u32	nomap;               /* count of load/stores with no phys adrs */
>  	u32	noparse;             /* count of unparsable data sources */
>  };
> -- 
> 2.7.4
> 

-- 

- Arnaldo
