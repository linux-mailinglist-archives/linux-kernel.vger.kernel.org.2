Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711A5342FCF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCTWOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:14:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCTWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:13:31 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616278410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9mjR39JAnk9LVTRWHFFkIeF7jmr7jmcsLWwDIHiw89w=;
        b=U6UCIMJtU8CzmTNm92+RpXTYXA9/F0wT9TidSuQfUoagt+Z3UVMgdXeHMwcqf+UKpK9RQG
        XdmQvhosA1xPM8vXyvTrO01FfQ6ihoHZUAEJ7Q+uQEH9lkkw1Cps0L1cJzDBdIjp9BWXvM
        seD125S++B2H+TLadPtvpOV4sXI5FUgX4WafONScUm4wDXptaq1mQJuk4MrngU4KzrCwPb
        kmn8Dvf06Oxp6FzHvx0oxJJWodCQL3NCtw5K2FjjJEWeH1VQxlUbjoGlNoMCSqRtphmIl9
        Xgr0D3qtdi0m/4WfKfVUugX3O9xD2KZWL3vy2OjtVlNbRvT849XFvauiM2l4pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616278410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9mjR39JAnk9LVTRWHFFkIeF7jmr7jmcsLWwDIHiw89w=;
        b=ftjeSDSqFhj471humgpgmU1OK2BUphH+h6o9Cy7UkO+FL9OxyhDX9RJfh3XeQMZZzCocHZ
        rQZMZgdDykEYZMBw==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the first use of dynamic user state
In-Reply-To: <20210221185637.19281-15-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-15-chang.seok.bae@intel.com>
Date:   Sat, 20 Mar 2021 23:13:29 +0100
Message-ID: <87o8fda2ye.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21 2021 at 10:56, Chang S. Bae wrote:
> +
> +/* Update MSR IA32_XFD with xfirstuse_not_detected() if needed. */
> +static inline void xdisable_switch(struct fpu *prev, struct fpu *next)
> +{
> +	if (!static_cpu_has(X86_FEATURE_XFD) || !xfirstuse_enabled())
> +		return;
> +
> +	if (unlikely(prev->state_mask != next->state_mask))
> +		xdisable_setbits(xfirstuse_not_detected(next));
> +}

So this is invoked on context switch. Toggling bit 18 of MSR_IA32_XFD
when it does not match. The spec document says:

  "System software may disable use of Intel AMX by clearing XCR0[18:17], by
   clearing CR4.OSXSAVE, or by setting IA32_XFD[18]. It is recommended that
   system software initialize AMX state (e.g., by executing TILERELEASE)
   before doing so. This is because maintaining AMX state in a
   non-initialized state may have negative power and performance
   implications."

I'm not seeing anything related to this. Is this a recommendation
which can be ignored or is that going to be duct taped into the code
base once the first user complains about slowdowns of their non AMX
workloads on that machine?

Thanks,

        tglx
