Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D947B34BCA2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhC1OmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 10:42:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC1OmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 10:42:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616942523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D54Z2PmLCo200yXOSvaj2hVPC2HaVunYq4YcYHV7CLI=;
        b=nOSANqfo4EtIMAP5mGifyuzW2Af52m5HsKAtyMqUUKMzc0XR6FoAXid/2jQwT1JZL0bk7z
        XPx6W8UmnTT3Jx8MOw6POYFwlaSRgC40XHyAM5M5FsbPbyOmckgM3CeZ6439glilf+vtSq
        sV/a3k181wHYDoGE2YkUj9wK8HnMhNzpeJaVEDbXe5/Xjgk8QNWJBHO+6uqjcNoR+FXFCZ
        yESHY04k4zxypQtFZ8DrCTzA11YAhm/q9JYc/rH+HEA/Aq5HxI9j53+8VORvF9pvloSBK+
        YRfZClUyO8fKSqfnrPgq+eK5DxXnt0UkMYLx1a/LsXp/dt707mjcotvIBxFSaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616942523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D54Z2PmLCo200yXOSvaj2hVPC2HaVunYq4YcYHV7CLI=;
        b=2/R47s1sLunWDFbaoDjixBAOVW6iJ5IR9uZH6pLWwX8sxIDwqn63g4zVRcfcZhQBqAGFeV
        mga+yqnJjOZqMqCQ==
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v7 3/6] stack: Optionally randomize kernel stack offset each syscall
In-Reply-To: <20210319212835.3928492-4-keescook@chromium.org>
References: <20210319212835.3928492-1-keescook@chromium.org> <20210319212835.3928492-4-keescook@chromium.org>
Date:   Sun, 28 Mar 2021 16:42:03 +0200
Message-ID: <87eefzcpc4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees,

On Fri, Mar 19 2021 at 14:28, Kees Cook wrote:
> +/*
> + * Do not use this anywhere else in the kernel. This is used here because
> + * it provides an arch-agnostic way to grow the stack with correct
> + * alignment. Also, since this use is being explicitly masked to a max of
> + * 10 bits, stack-clash style attacks are unlikely. For more details see
> + * "VLAs" in Documentation/process/deprecated.rst

VLAs are bad, VLAs to the rescue! :)

> + * The asm statement is designed to convince the compiler to keep the
> + * allocation around even after "ptr" goes out of scope.
> + */
> +void *__builtin_alloca(size_t size);
> +
> +#define add_random_kstack_offset() do {					\
> +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> +				&randomize_kstack_offset)) {		\
> +		u32 offset = this_cpu_read(kstack_offset);              \

Not that it matters on x86, but as this has to be called in the
interrupt disabled region of the syscall entry, shouldn't this be a
raw_cpu_read(). The asm-generic version has a preempt_disable/enable
pair around the raw read for native wordsize reads, otherwise a
irqsave/restore pair.

__this_cpu_read() is fine as well, but that has an sanity check before
the raw read when CONFIG_DEBUG_PREEMPT is on, which is harmless but
also pointless in this case.

Probably the same for the counterpart this_cpu_write().

Thanks,

        tglx
