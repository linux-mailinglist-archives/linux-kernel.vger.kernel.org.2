Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0E34FAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhCaHul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:50:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhCaHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:50:22 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617177020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZw6jkxG2tvSevv3X2+abnTHnXCHkwF4cE7lD/cYS0c=;
        b=jUZ1Puxo9W22AXzcFYFJ62E72Axd/SK2ZV8cEve6PHL2b0LfRU4wESftLlahc7fWxip4AM
        BBRqghhiGBRl7jKDiWl61U/Kd8GE0BO2yzFsmrzPH5KFvgHJ3Bxb6nEqyxkwbVsMNDyC4p
        71QTjwCX7E4m3wMy0qF1RkjLiPTthV91YEW3gFxDvP8NNM6uZ42CyhB6MesNOu0wQuu1qy
        XPq1pF/txTA47YN+pLN3i8C8eweRc2FE3U7tq1qThEBzCMhpE9NNDxzGE0AubaVIh4W3sH
        UgvB+tZgA6eTvr+vAKcvVXMVUOfPorneRFlwQ+GN0M68PY7bXY2FOr1ztCMdWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617177020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZw6jkxG2tvSevv3X2+abnTHnXCHkwF4cE7lD/cYS0c=;
        b=MN+pzWVv1yf6pCY2oCNeGdwPONSSKq5G0kTaSCVNpA6ZRX43kxrMo6DqtDgPG5dGcxWZs+
        +KgsgvXLPSPQFzCg==
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
Subject: Re: [PATCH v8 4/6] x86/entry: Enable random_kstack_offset support
In-Reply-To: <20210330205750.428816-5-keescook@chromium.org>
References: <20210330205750.428816-1-keescook@chromium.org> <20210330205750.428816-5-keescook@chromium.org>
Date:   Wed, 31 Mar 2021 09:50:20 +0200
Message-ID: <87lfa369tv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30 2021 at 13:57, Kees Cook wrote:

> Allow for a randomized stack offset on a per-syscall basis, with roughly
> 5-6 bits of entropy, depending on compiler and word size. Since the
> method of offsetting uses macros, this cannot live in the common entry
> code (the stack offset needs to be retained for the life of the syscall,
> which means it needs to happen at the actual entry point).
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
