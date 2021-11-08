Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73A447DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhKHK0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhKHK0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:26:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004EC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FaGo5zXccfjU85Y91QVmL/g6L4USJv7YVarFWNokkR0=; b=n91197H02v535HIqNJ3DW5Znuo
        XUjRRg2V4BTJArGflcJuq/LTqWDB+gUOQ+qKYEfqYyTeFlwcOBOd2Jnos+M/9EiM0ZGmhueynhJQN
        Pc4zhdpimWY6ae9mMWV6LgqTZbXRA7UgOq5K2+ntphdDJpL0AjopcnS3j0WvxCyXFebB3WTSgh+G1
        VmMHtRtRdQC0XeGvYgLhT3elgiyqYc2uDApOCihmd4WwTiLyNKL7VD8eVXgoH6excZxosgQPaQkHE
        CmcjaC9iRf+O7kfx3qCwN86pFlQ25Xmzgdi+k1n7uMoqBY6ea4jCNN12vxyXZxw7MSqHfIN3uHeVx
        aeDEFl4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk1nt-00Eri2-RO; Mon, 08 Nov 2021 10:23:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34AA73000A3;
        Mon,  8 Nov 2021 11:23:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D31F2D38726B; Mon,  8 Nov 2021 11:23:05 +0100 (CET)
Date:   Mon, 8 Nov 2021 11:23:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6 2/2] arm64: implement support for static call
 trampolines
Message-ID: <YYj6ib6Mrp9rAjVJ@hirez.programming.kicks-ass.net>
References: <20211105145917.2828911-1-ardb@kernel.org>
 <20211105145917.2828911-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105145917.2828911-3-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 03:59:17PM +0100, Ard Biesheuvel wrote:
> diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/asm/static_call.h
> new file mode 100644
> index 000000000000..6ee918991510
> --- /dev/null
> +++ b/arch/arm64/include/asm/static_call.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_STATIC_CALL_H
> +#define _ASM_STATIC_CALL_H
> +
> +/*
> + * The sequence below is laid out in a way that guarantees that the literal and
> + * the instruction are always covered by the same cacheline, and can be updated
> + * using a single store-pair instruction (provided that we rewrite the BTI C
> + * instruction as well). This means the literal and the instruction are always
> + * in sync when observed via the D-side.
> + *
> + * However, this does not guarantee that the I-side will catch up immediately
> + * as well: until the I-cache maintenance completes, CPUs may branch to the old
> + * target, or execute a stale NOP or RET. We deal with this by writing the
> + * literal unconditionally, even if it is 0x0 or the branch is in range. That
> + * way, a stale NOP will fall through and call the new target via an indirect
> + * call. Stale RETs or Bs will be taken as before, and branch to the old
> + * target.
> + */

Thanks for the comment!


> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index 771f543464e0..a265a87d4d9e 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c


> +static void *strip_cfi_jt(void *addr)
> +{
> +	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> +		void *p = addr;
> +		u32 insn;
> +
> +		/*
> +		 * Taking the address of a function produces the address of the
> +		 * jump table entry when Clang CFI is enabled. Such entries are
> +		 * ordinary jump instructions, preceded by a BTI C instruction
> +		 * if BTI is enabled for the kernel.
> +		 */
> +		if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> +			p += 4;

Perhaps:
		if (aarch64_insn_is_bti(le32_to_cpup(p)))
			p += 4;

Perhapser still, add:
		else
			WARN_ON(IS_ENABLED(CONFIG_ARM64_BTI_KERNEL));

> +
> +		insn = le32_to_cpup(p);
> +		if (aarch64_insn_is_b(insn))
> +			return p + aarch64_get_branch_offset(insn);
> +
> +		WARN_ON(1);
> +	}
> +	return addr;
> +}

Also, can this please have a comment decrying the lack of built-in for
this?
