Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12091418B07
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 22:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhIZUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 16:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhIZUpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 16:45:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2D1C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 13:43:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632689017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJ30AYB5dQYASQQ807+byPlQXDuR+aVd2Y6AuvkeBsk=;
        b=c7DZw2UARw7rviOfPwcG4Rn7hDtw091Q2dmLGp7U39YzC/pdhfE+RRbd8i9pwT2G0zqaUT
        CRQA70dL5bp0McEY+HZQg8za09pBInbrbVp8lFt28Lvz9ZpJMtkcBKGsGgdWcZqaO8L82j
        qTXFleJVeokh+58qBbOHC/nOS/3mD98c+vlR81XiLhETUj3X7DWbwyrJWfD1watJDyn/ec
        xYLR51aEFmI5ok1Wy/dYQKI4kx2NGzMoEwmov1hKxcnjHpnhV1M0QWRlkpgxLCPse0bf+M
        f/2/oGITlgXZzT42Cevf/XZOtb5ro/0ip1DBCB/5XLxrNBE85LHCI1cy0aPSRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632689017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJ30AYB5dQYASQQ807+byPlQXDuR+aVd2Y6AuvkeBsk=;
        b=CWV8pLQoXg4kgNQ2jnmRurpE1vPQpH6rfEbcLpw3FDP6D/qds7EajlcMZmVbSJF0ypWOCY
        QAgiIGSNaVGMOrCw==
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2 01/41] x86/entry: Fix swapgs fence
In-Reply-To: <20210926150838.197719-2-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
 <20210926150838.197719-2-jiangshanlai@gmail.com>
Date:   Sun, 26 Sep 2021 22:43:37 +0200
Message-ID: <87r1dbawzq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lai,

On Sun, Sep 26 2021 at 23:07, Lai Jiangshan wrote:
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -898,17 +898,12 @@ SYM_CODE_START_LOCAL(paranoid_entry)
>  	rdmsr
>  	testl	%edx, %edx
>  	jns	.Lparanoid_entry_swapgs
> +	FENCE_SWAPGS_KERNEL_ENTRY

Good catch.

>  	ret
>  
>  .Lparanoid_entry_swapgs:
>  	swapgs
> -
> -	/*
> -	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
> -	 * unconditional CR3 write, even in the PTI case.  So do an lfence
> -	 * to prevent GS speculation, regardless of whether PTI is enabled.
> -	 */
> -	FENCE_SWAPGS_KERNEL_ENTRY
> +	FENCE_SWAPGS_USER_ENTRY

This change is wrong.

In the paranoid entry path even if user GS base is set then the entry
does not necessarily come from user space so there is no guarantee that
there was a CR3 write on PTI enabled systems before the SWAPGS.

FENCE_SWAPGS_USER_ENTRY does not emit a LFENCE when PTI is enabled, so
both the comment and FENCE_SWAPGS_KERNEL_ENTRY which emits LFENCE on
affected CPUs unconditionaly are correct. Though the comment could do
with some polishing to make this entirely clear.

Before adding support for FSGSBASE both the swapgs and non swapgs case
issued the LFENCE unconditionally with FENCE_SWAPGS_KERNEL_ENTRY. The
commit you identified splitted the code pathes and failed to add the
FENCE_SWAPGS_KERNEL_ENTRY into the non-swapgs path.

Thanks,

        tglx
