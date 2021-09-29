Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7E141CAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbhI2Q4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344142AbhI2Q4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:56:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DB256142A;
        Wed, 29 Sep 2021 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632934482;
        bh=MC/H1E8TSLJ2TbZMhpk0E7SEx/R2oV68ZKQQ3Ig/N5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCafMlLtcX+JlQkGqvM5QA5BDba/hrxBVJw0zfIbW9G6CFnGymGHs/qmIxxZ2meHk
         J19P5Q/DRLwKcWFwhVXKz3xGGnUB7sNRgVakiYd6m/I2mwuSOSgGiFdBwFi/oa4ipG
         evmk/Ho1rec5mL1K2MPQjsDwzfw7WVw/C+ogFmBRSMhbSOxRB7fkJqi4xgGDKvNl0E
         SbQkpYO7DSmtxN3tq3ckn9mYAl6QYZd8V7WIUDQsECxclsKIkOqBDvKquorKh1/1iA
         AEWYnqh1kndy6S5iNeeBN4HJn0C0TbIlI9D87STTmbu6caukATy3XvBXTno1Nuv7kV
         RPyFDTidtDY7w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4C433410A1; Wed, 29 Sep 2021 13:54:39 -0300 (-03)
Date:   Wed, 29 Sep 2021 13:54:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Joe Mario <jmario@redhat.com>, kan.liang@linux.intel.com
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf script: Fix PERF_SAMPLE_WEIGHT_STRUCT support
Message-ID: <YVSaT54dsMjJV4dF@kernel.org>
References: <1632929894-102778-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632929894-102778-1-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 29, 2021 at 08:38:13AM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> -F weight in perf script is broken.
> 
>   # ./perf mem record
>   # ./perf script -F weight
>   Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot
> print 'weight' field.
> 
> The sample type, PERF_SAMPLE_WEIGHT_STRUCT, is an alternative of the
> PERF_SAMPLE_WEIGHT sample type. They share the same space, weight. The
> lower 32 bits are exactly the same for both sample type. The higher 32
> bits may be different for different architecture. For a new kernel on
> x86, the PERF_SAMPLE_WEIGHT_STRUCT is used. For an old kernel or other
> ARCHs, the PERF_SAMPLE_WEIGHT is used.
> 
> With -F weight, current perf script will only check the input string
> "weight" with the PERF_SAMPLE_WEIGHT sample type. Because the commit
> ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT") didn't
> update the PERF_SAMPLE_WEIGHT_STRUCT sample type for perf script. For a
> new kernel on x86, the check fails.
> 
> Use PERF_SAMPLE_WEIGHT_TYPE, which supports both sample types, to
> replace PERF_SAMPLE_WEIGHT.
> 
> Reported-by: Joe Mario <jmario@redhat.com>
> Fixes: ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT")

Hey Joe, Jiri,

	Can I have your Tested-by?

Thanks,

- Arnaldo

> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 6211d0b..9f62ac6 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -459,7 +459,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(WEIGHT) &&
> -	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT", PERF_OUTPUT_WEIGHT))
> +	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT))
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(SYM) &&
> -- 
> 2.7.4

-- 

- Arnaldo
