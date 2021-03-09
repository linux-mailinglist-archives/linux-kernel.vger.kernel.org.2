Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2963324C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCIMJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhCIMJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:09:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB7D26522B;
        Tue,  9 Mar 2021 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615291756;
        bh=OZs9k/9cWxgTTY0u75PBlzwg7cNm9Hp61E916wXKLTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dfls9DYIJ4iqdZjLfAGhq6ZR37k2V7D7ocY6+TuaQnobTj+6GfPOjf7cRigQdUC3G
         77mHdMFUubfUzun0fJb7qSpLmUQSw/gDg3YEqDEKstoMkmFavqyJbLQeg5zM0iONKj
         qPudAk/L9dBmInF7ln3Xvob7LafBEgDradtQiytS3oxOERR1SOL18INfsTyOZAmaBp
         56TMFmVljdF6Cu5iypfXL9xrqpv/CJ+COxBxLmHr4alGXKH8hqsKyH3VYhJa3Zz+Vv
         S8hX7kURmSqyxWO2UldwO8mRuDVMLbwKgLbA4byG+EieaeQIpccBD82Cw6VZmI6Rs2
         YBRzcjrrtUAFw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DD1F040647; Tue,  9 Mar 2021 09:09:12 -0300 (-03)
Date:   Tue, 9 Mar 2021 09:09:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: use ARRAY_SIZE
Message-ID: <YEdlaO9PSl/68uki@kernel.org>
References: <1615281145-2122-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615281145-2122-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 09, 2021 at 05:12:25PM +0800, Jiapeng Chong escreveu:
> Fix the following cppcheck warnings:
> 
> ./tools/perf/tests/demangle-ocaml-test.c:29:34-35: WARNING: Use
> ARRAY_SIZE.

Thanks, applied.

- Arnaldo

 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  tools/perf/tests/demangle-ocaml-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/demangle-ocaml-test.c b/tools/perf/tests/demangle-ocaml-test.c
> index a273ed5..2fac7d7 100644
> --- a/tools/perf/tests/demangle-ocaml-test.c
> +++ b/tools/perf/tests/demangle-ocaml-test.c
> @@ -26,7 +26,7 @@ int test__demangle_ocaml(struct test *test __maybe_unused, int subtest __maybe_u
>  		  "Stdlib.bytes.++" },
>  	};
>  
> -	for (i = 0; i < sizeof(test_cases) / sizeof(test_cases[0]); i++) {
> +	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
>  		buf = ocaml_demangle_sym(test_cases[i].mangled);
>  		if ((buf == NULL && test_cases[i].demangled != NULL)
>  				|| (buf != NULL && test_cases[i].demangled == NULL)
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo
