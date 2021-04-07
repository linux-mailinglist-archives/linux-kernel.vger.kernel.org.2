Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EF23574E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhDGTYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhDGTYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:24:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91C4F610CE;
        Wed,  7 Apr 2021 19:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617823479;
        bh=NzHxaMc9ymOaHFsr0WO3B8EPV7NmVSRJm/gRBzJJYQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqnQR4Kg7z8Q9qHykgd/9B4hD79nCKGO9l9gDR1OvTk2CWe4lhrZYwlYH/rH9BWnE
         DHZ0dOibaDhi7A4SgsNRTOJ4/8FB2BXANIvnWqa5O0XjRvdE75+n/vyxv9RcrSEZaF
         aqu2HKfqyk0wY2s+ypjdY8iwKaHvPof3BSQKXMCzTrcDf0zmWdKoi76vrrbGr0a5UI
         13SBBNlWHKJJyKr3T3IHslTOdIdzIjWxs9fACO0MXur84Q9Tfc2llVhwgPVVjV4yeQ
         dmrJT0fhP58WgYHw2sMRTqfEu215Hyw/xfqJyNUBz5bKsahiVTm+NS8lmEPmatCLoM
         QwSqZg9PY5tAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0B8AD40647; Wed,  7 Apr 2021 16:24:37 -0300 (-03)
Date:   Wed, 7 Apr 2021 16:24:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf arm-spe: Avoid potential buffer overrun.
Message-ID: <YG4G9Fb8NO3MYYQa@kernel.org>
References: <20210407153955.317215-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407153955.317215-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 07, 2021 at 08:39:55AM -0700, Ian Rogers escreveu:
> SPE extended headers are >1 byte so ensure the buffer contains at
> least this before reading. This issue was detected by fuzzing.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index f3ac9d40cebf..2e5eff4f8f03 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -210,8 +210,10 @@ static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
>  
>  	if ((hdr & SPE_HEADER0_MASK2) == SPE_HEADER0_EXTENDED) {
>  		/* 16-bit extended format header */
> -		ext_hdr = 1;
> +		if (len == 1)
> +			return ARM_SPE_BAD_PACKET;
>  
> +		ext_hdr = 1;
>  		hdr = buf[1];
>  		if (hdr == SPE_HEADER1_ALIGNMENT)
>  			return arm_spe_get_alignment(buf, len, packet);
> -- 
> 2.31.0.208.g409f899ff0-goog
> 

-- 

- Arnaldo
