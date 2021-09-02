Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0249B3FF555
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbhIBVIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344283AbhIBVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:08:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D45EC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 14:07:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t12so7058980lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XguslLdPIXxVxFmZIelMYc4XAgNZi0tFqmUYgQxOp5M=;
        b=GRl6nsj+q44z1Ha5UTrEb/YbOYWdRlaK0fubHiqDSnXS8sWWJcwTGWoDIW2UCbn6Zr
         Cin4HyfAIjK1TVjdigRZ9ja7ecjITroQf2sZC4PC79Xaz+k+vtV6XvjQXxLLGFS3Tgvd
         rZxyeNE+Shn/fy1exk3CDfTmR+G77EyuLt2WAGw8j5ATWWbDt8eRpAfxm4LgmHc7p2us
         SdVcNLtNJiQPkMgU50e+CmDwIvKnHFdoc0jTOcrwRN3F83mIHv0PA+s/3GaM1tNx243Z
         gMITCnX0rWgJVXu10k47y/pC6aRMKRjTFKL60xjdzuDoDoXohJ5vAGs0C1TJ9uxuED5z
         b2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XguslLdPIXxVxFmZIelMYc4XAgNZi0tFqmUYgQxOp5M=;
        b=GW7sf6wXcaPIBYA4f1I6p/Se7PeTea0N5fYdV7kXLpHWP//UyP9RKDcXCu4YhxT+4J
         NmDQoz+EWILlLiuYB0jNrycui/CKz65j4+vPZt4KaHHWYrf7Pf3uI73YJbuOQZjKZP1O
         InyWEIgyKjX4BJrQw5Xr86Kum6cePinsZi8wSF8eIxPSZrA4OkP6YvrOR6WRDUETgYZd
         FnkQ7Ndf6eb4XXEv6TOFwqwIByvTDny7+LiP0d+W2lZUfOVzqSI7XMVbTrf7Mi05DKNA
         bwuTgaEXFcoE+tdutKk93upcGSBBMACaUIf5iv03/dLiO2KUWCDSmEpwEbSJdOjB/qiM
         J78Q==
X-Gm-Message-State: AOAM531RSvAGX+fSeujWeVkcFgypNg2XijCugT0fPPVGBoZsw5rmBlSd
        nSMtySTsNsylKJ+EoUkhH1Yb8tdp3gB7YTISxUKRrQ==
X-Google-Smtp-Source: ABdhPJy8xnwpcjzdbh31Silho7ZsIAfWPr+R+NuwJ6UvcoeGh2m0fcJ/FCsJ2/qFTEX7zkqJV51h+rVv6z0QgWfOt/4=
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr80050lff.411.1630616831502;
 Thu, 02 Sep 2021 14:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210901211412.4171835-1-rananta@google.com> <20210901211412.4171835-9-rananta@google.com>
In-Reply-To: <20210901211412.4171835-9-rananta@google.com>
From:   Oliver Upton <oupton@google.com>
Date:   Thu, 2 Sep 2021 14:06:58 -0700
Message-ID: <CAOQ_QsiYHkyDVUuUjFb5Zc=o4=yrmVEERNqt1aAY=4uy91mbgQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] KVM: arm64: selftests: Add light-weight spinlock support
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 2:14 PM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> Add a simpler version of spinlock support for ARM64 for
> the guests to use.
>
> The implementation is loosely based on the spinlock
> implementation in kvm-unit-tests.
>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |  2 +-
>  .../selftests/kvm/include/aarch64/spinlock.h  | 13 +++++++++
>  .../selftests/kvm/lib/aarch64/spinlock.c      | 27 +++++++++++++++++++
>  3 files changed, 41 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/spinlock.h
>  create mode 100644 tools/testing/selftests/kvm/lib/aarch64/spinlock.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 5d05801ab816..61f0d376af99 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -35,7 +35,7 @@ endif
>
>  LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
>  LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
> -LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S
> +LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c
>  LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
>
>  TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
> diff --git a/tools/testing/selftests/kvm/include/aarch64/spinlock.h b/tools/testing/selftests/kvm/include/aarch64/spinlock.h
> new file mode 100644
> index 000000000000..cf0984106d14
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/aarch64/spinlock.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef SELFTEST_KVM_ARM64_SPINLOCK_H
> +#define SELFTEST_KVM_ARM64_SPINLOCK_H
> +
> +struct spinlock {
> +       int v;
> +};
> +
> +extern void spin_lock(struct spinlock *lock);
> +extern void spin_unlock(struct spinlock *lock);
> +
> +#endif /* SELFTEST_KVM_ARM64_SPINLOCK_H */
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/spinlock.c b/tools/testing/selftests/kvm/lib/aarch64/spinlock.c
> new file mode 100644
> index 000000000000..6d66a3dac237
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/aarch64/spinlock.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM64 Spinlock support
> + */
> +#include <stdint.h>
> +
> +#include "spinlock.h"
> +
> +void spin_lock(struct spinlock *lock)
> +{
> +       uint32_t val, res;

nit: use 'int' to match the lock value type.

> +
> +       asm volatile(
> +       "1:     ldaxr   %w0, [%2]\n"
> +       "       cbnz    %w0, 1b\n"
> +       "       mov     %w0, #1\n"
> +       "       stxr    %w1, %w0, [%2]\n"
> +       "       cbnz    %w1, 1b\n"
> +       : "=&r" (val), "=&r" (res)
> +       : "r" (&lock->v)
> +       : "memory");
> +}
> +
> +void spin_unlock(struct spinlock *lock)
> +{
> +       asm volatile("stlr wzr, [%0]\n" : : "r" (&lock->v) : "memory");
> +}
> --
> 2.33.0.153.gba50c8fa24-goog
>

Otherwise, LGTM.

Reviewed-by: Oliver Upton <oupton@google.com>
