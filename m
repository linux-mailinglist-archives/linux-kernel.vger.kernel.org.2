Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35FC32B721
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357430AbhCCKtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhCBX4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:56:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83094C0611BC;
        Tue,  2 Mar 2021 15:40:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j2so8820275wrx.9;
        Tue, 02 Mar 2021 15:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wU9np/B17g0hNZmy/Vroj0jnabzNoYbqEuJBn3uOdp0=;
        b=dWOWMX5aUSCmikpv4jmURB+ixRNSIv+Ruhe0w6BiKpkGo2hF12Jns8VMi+PecWrTKH
         KSO13mX2ekuj1CFpHJwCyz3vCItzZWK5GaBkTgbGqNP7alexXl2cjnI7JKR+a+GFvmyP
         7Agb1uGfY4BQgE1/dz+6SeGDwClB6ivCIodpzRuhdRIgAINMRluOle41s0stTPdHIqWo
         DITVfTF9uBwADOKoA3Rdh7oF7w9huhO8Y9/TXcB3qtp+AlBLwsQsBI9AO4WD8mOyrlbE
         MHCDV7UElVYyZiL4zMpZ0KJPkAaprcrfXNkzODIXi8Z48LlZNN+FyRMUY3tc9p24Gchn
         hlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wU9np/B17g0hNZmy/Vroj0jnabzNoYbqEuJBn3uOdp0=;
        b=I2U0FqMBiKxjYYO5m6sOzelP4y7F4UyBUsXTUERBpksXVCcZWV4edmM2wnfkcfN7rx
         WFYlHHURqR0i2Xw1nk75+iRIdS9ChktAPNAppv9VBfZ6+8rP6iQ00e2Rqxl+tDAg8mVn
         uEdEZqlHCcm21Vw/tBs70FQGKcvhHZ130x98ZOU4+ds0KgZ/TkdslzXLdpjZD8CyBIKE
         jBbBN48fZ4SS407HmJtI/e/ymcls5zdnhSTP2OCSgo0GjyMcEpq19HJT1U6a+St76tv+
         SHrI4WgbHNnxmKlV6O0p9p9z85OJoAICBfko1v/4JtqQtsidH339p0XZ0OA8t/J7l2v+
         KIdw==
X-Gm-Message-State: AOAM532j3UfoHPdaAtxlvicDqKZnOET4C8gb0ke/Gp10YIsAOAq6XxNk
        5aOIcDhW/ze2E/apPif9ecTn+PFfHVWoaJZ+
X-Google-Smtp-Source: ABdhPJwQBbSuTwmfw9yI7mii+7ZHMW5JGbKQkmgQRNkqqxg7ZFhAA37Ivyy4VG5bJnI/A1ODf++iKw==
X-Received: by 2002:a5d:6cd2:: with SMTP id c18mr23533074wrc.330.1614728434318;
        Tue, 02 Mar 2021 15:40:34 -0800 (PST)
Received: from sf (tunnel547699-pt.tunnel.tserv1.lon2.ipv6.he.net. [2001:470:1f1c:3e6::2])
        by smtp.gmail.com with ESMTPSA id z25sm4972693wmi.23.2021.03.02.15.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 15:40:33 -0800 (PST)
Date:   Tue, 2 Mar 2021 23:40:31 +0000
From:   Sergei Trofimovich <slyich@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        linux-ia64@vger.kernel.org, "Dmitry V . Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] ia64: fix ia64_syscall_get_set_arguments() for
 break-based syscalls
Message-ID: <20210302234024.73bf0c14@sf>
In-Reply-To: <20210221002554.333076-1-slyfox@gentoo.org>
References: <20210221002554.333076-1-slyfox@gentoo.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Feb 2021 00:25:53 +0000
Sergei Trofimovich <slyfox@gentoo.org> wrote:

> In https://bugs.gentoo.org/769614 Dmitry noticed that
> `ptrace(PTRACE_GET_SYSCALL_INFO)` does not work for syscalls called
> via glibc's syscall() wrapper.
> 
> ia64 has two ways to call syscalls from userspace: via `break` and via
> `eps` instructions.
> 
> The difference is in stack layout:
> 
> 1. `eps` creates simple stack frame: no locals, in{0..7} == out{0..8}
> 2. `break` uses userspace stack frame: may be locals (glibc provides
>    one), in{0..7} == out{0..8}.
> 
> Both work fine in syscall handling cde itself.
> 
> But `ptrace(PTRACE_GET_SYSCALL_INFO)` uses unwind mechanism to
> re-extract syscall arguments but it does not account for locals.
> 
> The change always skips locals registers. It should not change `eps`
> path as kernel's handler already enforces locals=0 and fixes `break`.
> 
> Tested on v5.10 on rx3600 machine (ia64 9040 CPU).
> 
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: linux-ia64@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Dmitry V. Levin <ldv@altlinux.org>
> Bug: https://bugs.gentoo.org/769614
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  arch/ia64/kernel/ptrace.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
> index c3490ee2daa5..e14f5653393a 100644
> --- a/arch/ia64/kernel/ptrace.c
> +++ b/arch/ia64/kernel/ptrace.c
> @@ -2013,27 +2013,39 @@ static void syscall_get_set_args_cb(struct unw_frame_info *info, void *data)
>  {
>  	struct syscall_get_set_args *args = data;
>  	struct pt_regs *pt = args->regs;
> -	unsigned long *krbs, cfm, ndirty;
> +	unsigned long *krbs, cfm, ndirty, nlocals, nouts;
>  	int i, count;
>  
>  	if (unw_unwind_to_user(info) < 0)
>  		return;
>  
> +	/*
> +	 * We get here via a few paths:
> +	 * - break instruction: cfm is shared with caller.
> +	 *   syscall args are in out= regs, locals are non-empty.
> +	 * - epsinstruction: cfm is set by br.call
> +	 *   locals don't exist.
> +	 *
> +	 * For both cases argguments are reachable in cfm.sof - cfm.sol.
> +	 * CFM: [ ... | sor: 17..14 | sol : 13..7 | sof : 6..0 ]
> +	 */
>  	cfm = pt->cr_ifs;
> +	nlocals = (cfm >> 7) & 0x7f; /* aka sol */
> +	nouts = (cfm & 0x7f) - nlocals; /* aka sof - sol */
>  	krbs = (unsigned long *)info->task + IA64_RBS_OFFSET/8;
>  	ndirty = ia64_rse_num_regs(krbs, krbs + (pt->loadrs >> 19));
>  
>  	count = 0;
>  	if (in_syscall(pt))
> -		count = min_t(int, args->n, cfm & 0x7f);
> +		count = min_t(int, args->n, nouts);
>  
> +	/* Iterate over outs. */
>  	for (i = 0; i < count; i++) {
> +		int j = ndirty + nlocals + i + args->i;
>  		if (args->rw)
> -			*ia64_rse_skip_regs(krbs, ndirty + i + args->i) =
> -				args->args[i];
> +			*ia64_rse_skip_regs(krbs, j) = args->args[i];
>  		else
> -			args->args[i] = *ia64_rse_skip_regs(krbs,
> -				ndirty + i + args->i);
> +			args->args[i] = *ia64_rse_skip_regs(krbs, j);
>  	}
>  
>  	if (!args->rw) {
> -- 
> 2.30.1
> 

Andrew, would it be fine to pass it through misc tree?
Or should it go through Oleg as it's about ptrace?

-- 

  Sergei
