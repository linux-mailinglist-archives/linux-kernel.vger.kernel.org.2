Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5134C3576E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhDGVfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232943AbhDGVfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:35:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50C0D611C9;
        Wed,  7 Apr 2021 21:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617831309;
        bh=IdAzorjKFWWP7Wbg08Lv/fd2wz/xa0/RkGQZvq+ZFQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmTeEKanC/hf6TByQCGKkTTUeM0E3DzNiv25DryA5VMVSM3MRfh1VaH/2bbk8mzAQ
         2l7iQHBwvDXErGQ5gwe6x49SltrcvCmFZv8UdNehv4i436SIzm+GPK66TXcSoKZfFp
         /DUWiQKJb2d92wMnFU6jW3qYY3vi7sKASbdIp7dhhpxoH+YMTrRJhgoYCOooTZEgiK
         3+aiEEnTbrwWo6qXF5t0wmK8fQB1MKDEQrNESJknOo+jl6F4Yn9H7EUSsXBReAYM03
         zYkvCMpwQTJ/ga0Fju36msC7V5ZPjiJpbv/7LWokEKiAW1CinZFro/xOWT6BKLi7Rt
         9KFhqRBPoiRqA==
Date:   Wed, 7 Apr 2021 22:35:03 +0100
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
Subject: Re: [PATCH v10 5/6] arm64: entry: Enable random_kstack_offset support
Message-ID: <20210407213502.GA16569@willie-the-truck>
References: <20210401232347.2791257-1-keescook@chromium.org>
 <20210401232347.2791257-6-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401232347.2791257-6-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 04:23:46PM -0700, Kees Cook wrote:
> Allow for a randomized stack offset on a per-syscall basis, with roughly
> 5 bits of entropy. (And include AAPCS rationale AAPCS thanks to Mark
> Rutland.)
> 
> In order to avoid unconditional stack canaries on syscall entry (due to
> the use of alloca()), also disable stack protector to avoid triggering
> needless checks and slowing down the entry path. As there is no general
> way to control stack protector coverage with a function attribute[1],
> this must be disabled at the compilation unit level. This isn't a problem
> here, though, since stack protector was not triggered before: examining
> the resulting syscall.o, there are no changes in canary coverage (none
> before, none now).
> 
> [1] a working __attribute__((no_stack_protector)) has been added to GCC
> and Clang but has not been released in any version yet:
> https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;h=346b302d09c1e6db56d9fe69048acb32fbb97845
> https://reviews.llvm.org/rG4fbf84c1732fca596ad1d6e96015e19760eb8a9b
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/Kconfig          |  1 +
>  arch/arm64/kernel/Makefile  |  5 +++++
>  arch/arm64/kernel/syscall.c | 16 ++++++++++++++++
>  3 files changed, 22 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
