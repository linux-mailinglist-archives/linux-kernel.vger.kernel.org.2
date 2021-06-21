Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6689B3AE6DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFUKUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:19:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196A0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:17:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624270663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qft33V4n9w3liTUGyYv8UgJkn2C6rbIC2OAf9sOGNjk=;
        b=zlvyGNzuMG71JDurWdOkedBk2iDwGJsC1+60MfER/DwqGFsRwO7WRvoX+vcg96W+5OCQEl
        tU1E2lAidXhunOG9zbosY6v59HEGFFw6RyLYA8eDvB6m/2KFZNU+/CCh2kWnW2Gh+lxrAw
        JPlffgwg2QDm4uBGTpC0yDZBZ3hqH77fCq/ItaBhA/6wUlrWuy8xML3XOlSkcuSW7aUjig
        d6Wk8zIWnaoU2hhRSQKw3b1xLyBsLJ1VURezSoK3axyngKaEFCviurZSXomrn9GwAeS9e+
        EEj5m7oUoROdgTOIgrLsNiymPROxHl3vE4/vieEZRok812Yt8dmgZ/ZLek4YhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624270663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qft33V4n9w3liTUGyYv8UgJkn2C6rbIC2OAf9sOGNjk=;
        b=YPhOey8KYJ06wNQYMWravZAmAiWNwIXTQzt5oAB9StScGwNsTWs+1c0pV2GTmK9K1ifUQV
        xmQ5Ew3q5L6pHNDw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V3 15/66] x86/fpu: Fail ptrace() requests that try to set invalid MXCSR values
In-Reply-To: <20210618143446.088319013@linutronix.de>
References: <20210618141823.161158090@linutronix.de> <20210618143446.088319013@linutronix.de>
Date:   Mon, 21 Jun 2021 12:17:43 +0200
Message-ID: <87mtrjfrnc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18 2021 at 16:18, Thomas Gleixner wrote:

> From: Andy Lutomirski <luto@kernel.org>
>
> There is no benefit from accepting and silently changing an invalid MXCSR
> value supplied via ptrace().  Instead, return -EINVAL on invalid input.
>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch. Picked up from Andy.
> ---
>  arch/x86/kernel/fpu/regset.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> ---
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -64,8 +64,9 @@ int xfpregs_set(struct task_struct *targ
>  	if (ret)
>  		return ret;
>  
> -	/* Mask invalid MXCSR bits (for historical reasons). */
> -	newstate.mxcsr &= mxcsr_feature_mask;
> +	/* Do not allow an invalid MXCSR value. */
> +	if (newstate.mxcsr & ~mxcsr_feature_mask)
> +		ret = -EINVAL;

This obviously needs to be:

               return -EINVAL;

/me goes to find a brown paperbag
