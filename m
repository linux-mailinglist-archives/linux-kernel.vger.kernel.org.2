Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7533B619F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhF1OhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 10:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234512AbhF1OaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:30:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A61561C4D;
        Mon, 28 Jun 2021 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624890384;
        bh=bWxS+PW4uHwFAS2u4SGZ+jwiyecpBBukHG7Lr3pxU3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jssHygMJ+sEVvtekUPUVgp/IzSDqLqyXHJC7B1mNRU7BLNBGU3PY7HVutSsQV1yT8
         h2TPlcSoKYJjYQ1nrLmt8S//kw38FL7jWXkJmuDoKa8P6pwajb3S0l3K+kwbgtZ2Ir
         UyeGZQzxAIU2smseHVr5iu7scziaw7sKCQt326Kmwz6vucVKyH3/d4vMg5I6m7VpEE
         EmwB81TBKIYN8KP8EeFcJjdW141ri54Qfb/s6qfXDc0Nr78GNCjsI5TYJReA0+q31K
         WHeTe71PEUKuoGq5C4fs1ZDJQUxgch02vsgYtc+4lzqBLLY3gt7k+ExJAtLTjCIEI1
         NNdmjS8pehNdg==
Date:   Mon, 28 Jun 2021 23:26:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] static_call: Fix static_call_text_reserved() vs
 __init
Message-Id: <20210628232621.778201d638c421ddda0e3c59@kernel.org>
In-Reply-To: <20210628113045.106211657@infradead.org>
References: <20210628112409.233121975@infradead.org>
        <20210628113045.106211657@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 13:24:11 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> It turns out that static_call_text_reserved() was reporting __init
> text as being reserved past the time when the __init text was freed
> and re-used.
> 
> This is mostly harmless and will at worst result in refusing a kprobe.
> 
> Fixes: 6333e8f73b83 ("static_call: Avoid kprobes on inline static_call()s")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  kernel/static_call.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -292,13 +292,15 @@ static int addr_conflict(struct static_c
>  
>  static int __static_call_text_reserved(struct static_call_site *iter_start,
>  				       struct static_call_site *iter_stop,
> -				       void *start, void *end)
> +				       void *start, void *end, bool init)
>  {
>  	struct static_call_site *iter = iter_start;
>  
>  	while (iter < iter_stop) {
> -		if (addr_conflict(iter, start, end))
> -			return 1;
> +		if (init || !static_call_is_init(iter)) {
> +			if (addr_conflict(iter, start, end))
> +				return 1;
> +		}
>  		iter++;
>  	}
>  
> @@ -324,7 +326,7 @@ static int __static_call_mod_text_reserv
>  
>  	ret = __static_call_text_reserved(mod->static_call_sites,
>  			mod->static_call_sites + mod->num_static_call_sites,
> -			start, end);
> +			start, end, mod->state == MODULE_STATE_COMING);
>  
>  	module_put(mod);
>  
> @@ -459,8 +461,9 @@ static inline int __static_call_mod_text
>  
>  int static_call_text_reserved(void *start, void *end)
>  {
> +	bool init = system_state < SYSTEM_RUNNING;
>  	int ret = __static_call_text_reserved(__start_static_call_sites,
> -			__stop_static_call_sites, start, end);
> +			__stop_static_call_sites, start, end, init);
>  
>  	if (ret)
>  		return ret;
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
