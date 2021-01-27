Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF843065CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhA0VOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:14:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhA0VOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:14:05 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611781993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+W210YcTn7f0FWj77TkJ8ytVhpV8sXey/lss5LyxnfI=;
        b=k7/Y8grAb9UaDQcEUoXliwbIZC+AonOYgpVzhs4Dwl6y3yyGTvk5N0SmGeuAZZHertjRqB
        vZ7DVk44GvLgOSqre4gguTCBOyocGAaggHaEnulk0hV1DkR/KGfdqcV2L8mnWox9KeB93i
        GPbdXITDeJYQWqVjb7GbiRLW7BeeyzIpUbTwjabdVyjLuxfAHaCaF1tRkZUJpP+lnSypca
        niX090nP3DUqMfIQYPTy7UkVTOoVuvRxo6NXwtVbrHiLZ/OXjeJ6UwDEdoPEBRnHWFqrX7
        +GpmOpocO9uj6OwQtA//9x6SzKRSgNPQqNC+JYVJSb5I0jkIPJxw4cGLlbAyng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611781993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+W210YcTn7f0FWj77TkJ8ytVhpV8sXey/lss5LyxnfI=;
        b=b9D9bjVVs3raMgxd5T2FRNvlUnF+A4noFc7+OsN1Ro2JVmVfoDAp13VJOvO1Nbgcdw8Fd3
        2SnYec6CKsOHwWBg==
To:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v4 1/4] x86/cpufeatures: Enumerate #DB for bus lock detection
In-Reply-To: <20201124205245.4164633-2-fenghua.yu@intel.com>
References: <20201124205245.4164633-1-fenghua.yu@intel.com> <20201124205245.4164633-2-fenghua.yu@intel.com>
Date:   Wed, 27 Jan 2021 22:13:13 +0100
Message-ID: <87wnvydqxi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24 2020 at 20:52, Fenghua Yu wrote:

> A bus lock is acquired though either split locked access to
> writeback (WB) memory or any locked access to non-WB memory. This is
> typically >1000 cycles slower than an atomic operation within a cache
> line. It also disrupts performance on other cores.
>
> Some CPUs have ability to notify the kernel by an #DB trap after a user
> instruction acquires a bus lock and is executed. This allows the kernel
> to enforce user application throttling or mitigations.

That's nice, but how does that interact with a data breakpoint on the
same location?

Also the information you pointed to in the cover letter

>  [1] Intel Instruction Set Extension Chapter 8:
> https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

does not contain anything which is even remotely related to this patch
series. That chapter describes another bit in TEST_CTRL_MSR ...

Thanks,

        tglx


