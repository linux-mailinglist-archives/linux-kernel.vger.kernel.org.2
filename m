Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF3B3B5F43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhF1NqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhF1NqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:46:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2B9C61883;
        Mon, 28 Jun 2021 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624887820;
        bh=gJqInbHX6Us83HMFo3RkNrKg8rMfR8eHVqFlvzvL8VI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=usqjamcTbtVaGCkh7xAY9zUqVLP/N2tr9W5rA87h10st1NRtdYMJtISxZyBR+RnPX
         JyRxscflboYuiwfybFJ5Byt/5kgl6O9aHmCx1Knpcm4FuUCEAdS28Vdn9KmDE9ecbm
         3o8pIkt7Me/wQFRxcDTMzDPBXbSXG62uY9QCbt8kY/5K5v/4/TNmaC91zZ6mG1Cl0F
         sVw2D6p2SH3XhZQCjhOV/0GCs1yprYwa4iaVAFxa2eXvBzlqGIR4gyIMnUk8TM0Apj
         fx6G8E4KtgrE413xj3nwmQ/EI8leK0e1T9p1mpnkI006ykLoVPWlNgFg4xikRuId0Z
         tE57ViYlzD1Mg==
Date:   Mon, 28 Jun 2021 22:43:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 1/3] jump_label: Fix jump_label_text_reserved() vs
 __init
Message-Id: <20210628224337.5429a2a898ea6f5e0d96d77c@kernel.org>
In-Reply-To: <20210628113045.045141693@infradead.org>
References: <20210628112409.233121975@infradead.org>
        <20210628113045.045141693@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 13:24:10 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> It turns out that jump_label_text_reserved() was reporting __init text
> as being reserved past the time when the __init text was freed and
> re-used.
> 
> For a long time, this resulted in, at worst, not being able to kprobe
> text that happened to land at the re-used address. However a recent
> commit e7bf1ba97afd ("jump_label, x86: Emit short JMP") made it a
> fatal mistake because it now needs to read the instruction in order to
> determine the conflict -- an instruction that's no longer there.
> 
> Fixes: 4c3ef6d79328 ("jump label: Add jump_label_text_reserved() to reserve jump points")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  kernel/jump_label.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -316,14 +316,16 @@ static int addr_conflict(struct jump_ent
>  }
>  
>  static int __jump_label_text_reserved(struct jump_entry *iter_start,
> -		struct jump_entry *iter_stop, void *start, void *end)
> +		struct jump_entry *iter_stop, void *start, void *end, bool init)
>  {
>  	struct jump_entry *iter;
>  
>  	iter = iter_start;
>  	while (iter < iter_stop) {
> -		if (addr_conflict(iter, start, end))
> -			return 1;
> +		if (init || !jump_entry_is_init(iter)) {
> +			if (addr_conflict(iter, start, end))
> +				return 1;
> +		}
>  		iter++;
>  	}
>  
> @@ -561,7 +563,7 @@ static int __jump_label_mod_text_reserve
>  
>  	ret = __jump_label_text_reserved(mod->jump_entries,
>  				mod->jump_entries + mod->num_jump_entries,
> -				start, end);
> +				start, end, mod->state == MODULE_STATE_COMING);
>  
>  	module_put(mod);
>  
> @@ -786,8 +788,9 @@ early_initcall(jump_label_init_module);
>   */
>  int jump_label_text_reserved(void *start, void *end)
>  {
> +	bool init = system_state < SYSTEM_RUNNING;
>  	int ret = __jump_label_text_reserved(__start___jump_table,
> -			__stop___jump_table, start, end);
> +			__stop___jump_table, start, end, init);
>  
>  	if (ret)
>  		return ret;
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
