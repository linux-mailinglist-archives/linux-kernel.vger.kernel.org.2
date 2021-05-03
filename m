Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B316A37129E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhECItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhECItR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:49:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24628C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 01:48:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620031702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IeWjvR+4fYFphBgV6kVzXcbgtodKzRO1JVhft24e7tk=;
        b=iFzbwZ26b0nAA7RhyhQg9VFODsf3YnhqgM/+OHG/c+7lOD3TcoZqHrLNn0B6Zk92uMJypq
        EMfQGlbmMPPfgMNACYlFzro6h/vl31R+EH3yXfSI/+eBurwB9wnVUMCDr+PHYuTYtbR2U7
        qs7xpEaDuEK+ndRLUf79Z6h3fxdi9oTFEl/PiQDppjLxVXW48bykIeiKLwkh2Cto5s37IM
        LU7wqMOyYZioPrORQbQHWpyD9MPGPkF5MvhBSRakPHd9FkIKpXGmH85DaKrmTQjij8ZLzI
        DsLgO6e9JouJy9BzoyghhBnh1nKX2xzXO2NdxW8hi3Zp4Zz6cClDUv2v/mUUDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620031702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IeWjvR+4fYFphBgV6kVzXcbgtodKzRO1JVhft24e7tk=;
        b=PI/NN62S0I/FLzpIf3OhvuA3TTN/BQ7iGjzrtqwnXQe0FQ/H5h9PF7/t6wC4kFUR1zDqim
        2tG8UxtR0lMuiXDQ==
To:     Anand K Mistry <amistry@google.com>, x86@kernel.org
Cc:     joelaf@google.com, asteinhauser@google.com, bp@alien8.de,
        Anand K Mistry <amistry@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jay Lang <jaytlang@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] x86/speculation: Allow per-process control of when to issue IBPB
In-Reply-To: <20210429184101.RFC.v2.1.Iadd904c1764f3bfe260db30fe41bdb9b8f98533d@changeid>
References: <20210429084410.783998-1-amistry@google.com> <20210429184101.RFC.v2.1.Iadd904c1764f3bfe260db30fe41bdb9b8f98533d@changeid>
Date:   Mon, 03 May 2021 10:48:21 +0200
Message-ID: <878s4wdwyy.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anand,

On Thu, Apr 29 2021 at 18:44, Anand K. Mistry wrote:
>  
> -static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
> +static inline unsigned long mm_mangle_tif_spec_ib_on_leave(
> +	struct task_struct *next)
>  {
>  	unsigned long next_tif = task_thread_info(next)->flags;
> -	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
> +	unsigned long spec_disabled =
> +		(next_tif >> TIF_SPEC_IB) & ~(next_tif >> TIF_NO_IBPB_LEAVE);
> +	unsigned long ibpb = spec_disabled & LAST_USER_MM_IBPB;
>  
>  	return (unsigned long)next->mm | ibpb;
>  }
>  
> +static inline bool ibpb_on_entry(struct task_struct *next)
> +{
> +	unsigned long next_tif = task_thread_info(next)->flags;
> +	unsigned long spec_disabled =
> +		(next_tif >> TIF_SPEC_IB) & ~(next_tif >> TIF_NO_IBPB_ENTRY);
> +	return spec_disabled & 1;
> +}

Why exactly do we need _three_ TIF bits and this non-intuitive inverted
logic?

The existing mode is: Issue IBPB when scheduling in and when scheduling out.

Ergo the obvious approach for making it more finegrained is to split the
existing TIF_SPEC_IB into TIF_SPEC_IB_IN and TIF_SPEC_IB_OUT and have
the existing mode both bits set.

Thanks,

        tglx


