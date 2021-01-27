Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E352A3063B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344468AbhA0TEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344347AbhA0TEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:04:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD71DC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UtSSckf2PZmsT5AzLuwb0CrCU8LOlhxRp19DyvxdD8A=; b=01jCaOj+T6gS4TLcauADjXNZ0F
        GFJMAsiOuubt/OIuUTLQJuzmSOzpJAPnl6nIPRiREZtXnX5R4KjVJKw1vfIhGsyg3FdZ1+6+lbzpD
        8y9xWyWHgIaniVAMe3iBJe6zMqvTRnQsgus/Lp+G3k1nzzYOJTDC7vn2NfajTj08A1sG8N4kCRsZ+
        fZQH6xIuHHf1D5TarZ8xm4DzQ0OjmiD7BCwoaf4j2R5cZRFFIb5BjDt2hQtwLas3ZrT6y37W/6Ra1
        NhGkMntWGVeoHsUmwcXx8Nyg7rCcYcBYBPgGRiFNklWUAhcT98z8gQ4CpWpz/J9iT78ewXCyM6QfE
        odDmv8oA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4q6b-0007kV-Eh; Wed, 27 Jan 2021 19:03:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68A26300455;
        Wed, 27 Jan 2021 20:03:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 460EF2D2DAB25; Wed, 27 Jan 2021 20:03:51 +0100 (CET)
Date:   Wed, 27 Jan 2021 20:03:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH V2 1/5] perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT
Message-ID: <YBG5F2rCbsto+Y9F@hirez.programming.kicks-ass.net>
References: <1611761925-159055-1-git-send-email-kan.liang@linux.intel.com>
 <1611761925-159055-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611761925-159055-2-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 07:38:41AM -0800, kan.liang@linux.intel.com wrote:
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index b15e344..13b4019 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -145,12 +145,14 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_CGROUP			= 1U << 21,
>  	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
>  	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
> +	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
>  
> -	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };
>  
> +#define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
>  /*
>   * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set
>   *
> @@ -890,7 +892,16 @@ enum perf_event_type {
>  	 * 	  char			data[size];
>  	 * 	  u64			dyn_size; } && PERF_SAMPLE_STACK_USER
>  	 *
> -	 *	{ u64			weight;   } && PERF_SAMPLE_WEIGHT
> +	 *	{ union perf_sample_weight
> +	 *	 {
> +	 *		u64		full; && PERF_SAMPLE_WEIGHT
> +	 *		struct {
> +	 *			u32	low_dword;
> +	 *			u16	high_word;
> +	 *			u16	higher_word;
> +	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
> +	 *	 }
> +	 *	}
>  	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
>  	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
>  	 *	{ u64			abi; # enum perf_sample_regs_abi
> @@ -1248,4 +1259,13 @@ struct perf_branch_entry {
>  		reserved:40;
>  };
>  
> +union perf_sample_weight {
> +	__u64		full;
> +	struct {
> +		__u32	low_dword;
> +		__u16	high_word;
> +		__u16	higher_word;
> +	};
> +};

*urgh*, my naming lives ... anybody got a better suggestion?

Also, do we want to care about byte order?
