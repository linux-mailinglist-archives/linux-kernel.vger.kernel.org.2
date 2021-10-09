Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B824278A6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhJIKDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 06:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhJIKDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 06:03:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7444C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eJGnKartCQ4NB8EPnX4WMRHlEI5BDRvPfhGVC/om05E=; b=P5RBRHbgLGBhPByidmufzLM0eo
        Zm3sf8aLCI99jpVQNHxNuaYP03aVVa8G1hiV38pRKywxghM0mB4nEjdB4KkywhpodCCCF3Txm1eUi
        M2LeOMGUlOJYrpMc2LBy7ZVfcHxC5M/cqHSKCbVCQBoFbSlAMybyBH5p3lJMOhXigEVFqCHTjXFq0
        hz6KnCe2S9ipAzhFyBkgdSL13/wVTmFig/hVh+/Qw1PjMJwIAuQVBIAEC05Hq6suewnprOC08q+Yz
        DzMsuYPfhAiqYW7cqI/m24W9V64TNa7+/XUi9uew//daAuS0qurNRs77jZoSRPVIWSFaJ7KSIoA9+
        hqqBy3Dg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZ99i-0042pR-NW; Sat, 09 Oct 2021 10:00:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7204C9811D4; Sat,  9 Oct 2021 12:00:37 +0200 (CEST)
Date:   Sat, 9 Oct 2021 12:00:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_call: fix null-ptr-deref in static_call_del_module
Message-ID: <20211009100037.GU174703@worktop.programming.kicks-ass.net>
References: <20211009074428.1668662-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009074428.1668662-1-wanghai38@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 03:44:28PM +0800, Wang Hai wrote:
> I got a NULL pointer dereference report when doing fault injection test:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000009
> ...
> RIP: 0010:static_call_del_module+0x7a/0x100
> ...
> Call Trace:
>  static_call_module_notify+0x1e1/0x200
>  notifier_call_chain_robust+0x6f/0xe0
>  blocking_notifier_call_chain_robust+0x4e/0x70
>  load_module+0x21f7/0x2b60
>  __do_sys_finit_module+0xb0/0xf0
>  ? __do_sys_finit_module+0xb0/0xf0
>  __x64_sys_finit_module+0x1a/0x20
>  do_syscall_64+0x34/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> When loading a module, if it fails to allocate memory for static
> calls, it will delete the non-existent mods (mods == 1) in the
> static_call_module_notify()'s error path.
> 
> static_call_module_notify
> 	static_call_add_module
> 		__static_call_init
> 			site_mod = kzalloc() // fault injection
> 	static_call_del_module // access non-existent mods
> 
> This patch fixes the bug by skipping the operation when the key
> has no mods.
> 
> Fixes: a945c8345ec0 ("static_call: Allow early init")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  kernel/static_call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/static_call.c b/kernel/static_call.c
> index 43ba0b1e0edb..c3f8ffc5a52f 100644
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -400,7 +400,7 @@ static void static_call_del_module(struct module *mod)
>  
>  	for (site = start; site < stop; site++) {
>  		key = static_call_key(site);
> -		if (key == prev_key)
> +		if (key == prev_key || !static_call_key_has_mods(key))
>  			continue;
>  
>  		prev_key = key;

Should you not update prev_key in that case? Also have you looked at
jump_label_del_module() which is very similar in construction?
