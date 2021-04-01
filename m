Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E4E3510E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhDAIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 04:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233024AbhDAIan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:30:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2F5B6100A;
        Thu,  1 Apr 2021 08:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617265842;
        bh=4Rz7Nq21QOn+cCeGiTdZAPi0H+35CYkw2WOtrh7X8SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxNB5z4cr3tbGV4VzlRuXgPZbjB8VSeyCqsWPoq97a20sSU37b9Q0eR3jvWw4E6Ys
         VyucRP2l3G0/tpLuJdqu2zu5tQe8ei4HLGgvLHdQSog9c4m07/Z2fZkwEgGbU7PD7Q
         nEgSfHkNoTizg6f/ZPpk7Rl8dHnvA5eeMrksAivrGAjZEY7obLUljOd9WOdpN/yHt8
         hKggM97UadPbpZ5eqF/36LjiD5p9vNq86oQlUZOnuaB6awEgRwGB0zM+rPe3kc18LO
         +dNWUng2mYYQOrw6EDbCAD415KDpvQhT9hucpKzuAh1ypODzTsNzJcD2Inr7r4HzN0
         kP1gBv0XcdeEA==
Date:   Thu, 1 Apr 2021 09:30:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <20210401083034.GA8554@willie-the-truck>
References: <20210330205750.428816-1-keescook@chromium.org>
 <20210330205750.428816-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330205750.428816-4-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 01:57:47PM -0700, Kees Cook wrote:
> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> new file mode 100644
> index 000000000000..351520803006
> --- /dev/null
> +++ b/include/linux/randomize_kstack.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _LINUX_RANDOMIZE_KSTACK_H
> +#define _LINUX_RANDOMIZE_KSTACK_H
> +
> +#include <linux/kernel.h>
> +#include <linux/jump_label.h>
> +#include <linux/percpu-defs.h>
> +
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> +			 randomize_kstack_offset);
> +DECLARE_PER_CPU(u32, kstack_offset);
> +
> +/*
> + * Do not use this anywhere else in the kernel. This is used here because
> + * it provides an arch-agnostic way to grow the stack with correct
> + * alignment. Also, since this use is being explicitly masked to a max of
> + * 10 bits, stack-clash style attacks are unlikely. For more details see
> + * "VLAs" in Documentation/process/deprecated.rst
> + * The asm statement is designed to convince the compiler to keep the
> + * allocation around even after "ptr" goes out of scope.
> + */
> +void *__builtin_alloca(size_t size);
> +/*
> + * Use, at most, 10 bits of entropy. We explicitly cap this to keep the
> + * "VLA" from being unbounded (see above). 10 bits leaves enough room for
> + * per-arch offset masks to reduce entropy (by removing higher bits, since
> + * high entropy may overly constrain usable stack space), and for
> + * compiler/arch-specific stack alignment to remove the lower bits.
> + */
> +#define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
> +
> +/*
> + * These macros must be used during syscall entry when interrupts and
> + * preempt are disabled, and after user registers have been stored to
> + * the stack.
> + */
> +#define add_random_kstack_offset() do {					\
> +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> +				&randomize_kstack_offset)) {		\
> +		u32 offset = __this_cpu_read(kstack_offset);		\
> +		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
> +		asm volatile("" : "=m"(*ptr) :: "memory");		\

Using the "m" constraint here is dangerous if you don't actually evaluate it
inside the asm. For example, if the compiler decides to generate an
addressing mode relative to the stack but with writeback (autodecrement), then
the stack pointer will be off by 8 bytes. Can you use "o" instead?

Will
