Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498CC3EBBBB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhHMR6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 13:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhHMR6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:58:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E11C360EFE;
        Fri, 13 Aug 2021 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628877493;
        bh=J6D46KhrsQ2B5chlvCMLyT6qJIR9dOkPjZOOAqPF6P4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VBi6zU+6EZ5jjkV3bjcVGHXEFQw9CgbdQTlc0wGgoJkGDKxiMP1N128Rk2yDSXqC/
         rtU53/rDl91F649c+sFD8YnbQ3nJnxCRitezMWUlA1sth/VIqaOeKwAIeDR62jiC9a
         pXcZfuYEEijzraKal7tSfIRBUYb6ZAK0xAgsu6Sj4Fj8J/TGbvYKIPth4I0H+I4uY9
         L+72y/ztW35wtXeKaQkkEiDKj1YFmGKM+WpjQOJfWDRvSzG6gdQhampuvNRxyYHxg8
         CEQ1JAAhZbWemzEhhkpjmoJy+EviDX6cRhsi8adtKwIrTw7hhayiR82eKqJGX3v/wn
         vlj9TuTg0oHCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AE51F5C0373; Fri, 13 Aug 2021 10:58:13 -0700 (PDT)
Date:   Fri, 13 Aug 2021 10:58:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: selftest: Cleanup and add missing __init
Message-ID: <20210813175813.GC4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210813081055.3119894-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813081055.3119894-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 10:10:55AM +0200, Marco Elver wrote:
> Make test_encode_decode() more readable and add missing __init.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Thank you!  I have queued and pushed this one as well as your previous
series:

https://lkml.kernel.org/r/20210813081055.3119894-1-elver@google.com

							Thanx, Paul

> ---
>  kernel/kcsan/selftest.c | 72 +++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 42 deletions(-)
> 
> diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
> index 7f29cb0f5e63..b4295a3892b7 100644
> --- a/kernel/kcsan/selftest.c
> +++ b/kernel/kcsan/selftest.c
> @@ -18,7 +18,7 @@
>  #define ITERS_PER_TEST 2000
>  
>  /* Test requirements. */
> -static bool test_requires(void)
> +static bool __init test_requires(void)
>  {
>  	/* random should be initialized for the below tests */
>  	return prandom_u32() + prandom_u32() != 0;
> @@ -28,14 +28,18 @@ static bool test_requires(void)
>   * Test watchpoint encode and decode: check that encoding some access's info,
>   * and then subsequent decode preserves the access's info.
>   */
> -static bool test_encode_decode(void)
> +static bool __init test_encode_decode(void)
>  {
>  	int i;
>  
>  	for (i = 0; i < ITERS_PER_TEST; ++i) {
>  		size_t size = prandom_u32_max(MAX_ENCODABLE_SIZE) + 1;
>  		bool is_write = !!prandom_u32_max(2);
> +		unsigned long verif_masked_addr;
> +		long encoded_watchpoint;
> +		bool verif_is_write;
>  		unsigned long addr;
> +		size_t verif_size;
>  
>  		prandom_bytes(&addr, sizeof(addr));
>  		if (addr < PAGE_SIZE)
> @@ -44,53 +48,37 @@ static bool test_encode_decode(void)
>  		if (WARN_ON(!check_encodable(addr, size)))
>  			return false;
>  
> -		/* Encode and decode */
> -		{
> -			const long encoded_watchpoint =
> -				encode_watchpoint(addr, size, is_write);
> -			unsigned long verif_masked_addr;
> -			size_t verif_size;
> -			bool verif_is_write;
> -
> -			/* Check special watchpoints */
> -			if (WARN_ON(decode_watchpoint(
> -				    INVALID_WATCHPOINT, &verif_masked_addr,
> -				    &verif_size, &verif_is_write)))
> -				return false;
> -			if (WARN_ON(decode_watchpoint(
> -				    CONSUMED_WATCHPOINT, &verif_masked_addr,
> -				    &verif_size, &verif_is_write)))
> -				return false;
> -
> -			/* Check decoding watchpoint returns same data */
> -			if (WARN_ON(!decode_watchpoint(
> -				    encoded_watchpoint, &verif_masked_addr,
> -				    &verif_size, &verif_is_write)))
> -				return false;
> -			if (WARN_ON(verif_masked_addr !=
> -				    (addr & WATCHPOINT_ADDR_MASK)))
> -				goto fail;
> -			if (WARN_ON(verif_size != size))
> -				goto fail;
> -			if (WARN_ON(is_write != verif_is_write))
> -				goto fail;
> -
> -			continue;
> -fail:
> -			pr_err("%s fail: %s %zu bytes @ %lx -> encoded: %lx -> %s %zu bytes @ %lx\n",
> -			       __func__, is_write ? "write" : "read", size,
> -			       addr, encoded_watchpoint,
> -			       verif_is_write ? "write" : "read", verif_size,
> -			       verif_masked_addr);
> +		encoded_watchpoint = encode_watchpoint(addr, size, is_write);
> +
> +		/* Check special watchpoints */
> +		if (WARN_ON(decode_watchpoint(INVALID_WATCHPOINT, &verif_masked_addr, &verif_size, &verif_is_write)))
>  			return false;
> -		}
> +		if (WARN_ON(decode_watchpoint(CONSUMED_WATCHPOINT, &verif_masked_addr, &verif_size, &verif_is_write)))
> +			return false;
> +
> +		/* Check decoding watchpoint returns same data */
> +		if (WARN_ON(!decode_watchpoint(encoded_watchpoint, &verif_masked_addr, &verif_size, &verif_is_write)))
> +			return false;
> +		if (WARN_ON(verif_masked_addr != (addr & WATCHPOINT_ADDR_MASK)))
> +			goto fail;
> +		if (WARN_ON(verif_size != size))
> +			goto fail;
> +		if (WARN_ON(is_write != verif_is_write))
> +			goto fail;
> +
> +		continue;
> +fail:
> +		pr_err("%s fail: %s %zu bytes @ %lx -> encoded: %lx -> %s %zu bytes @ %lx\n",
> +		       __func__, is_write ? "write" : "read", size, addr, encoded_watchpoint,
> +		       verif_is_write ? "write" : "read", verif_size, verif_masked_addr);
> +		return false;
>  	}
>  
>  	return true;
>  }
>  
>  /* Test access matching function. */
> -static bool test_matching_access(void)
> +static bool __init test_matching_access(void)
>  {
>  	if (WARN_ON(!matching_access(10, 1, 10, 1)))
>  		return false;
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
> 
