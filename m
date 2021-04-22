Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC01368916
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 00:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhDVWkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 18:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbhDVWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 18:39:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA25EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 15:39:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h15so15088574pfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUlDwcgwPAcRYMvT6n0zmQZ02FrFSLFm4jKgBTz17LU=;
        b=Cw8D18+LB+KggXJC3Hs7OS36Q58sjfTflgjQhQVcB9h78s6y35jRdKlqU4zsPFg4F6
         pauiG4kgb/tk6UMTiawgychtg2BRhGZAQ1p7iSqS2dbuOqqpEykK7yoJYv6NINA6/GNO
         pF1RFPp0jpJX0UJ8BzE9xlRkIfI23O6jSnpGPDBoSIBf32ExAiXZVm5UBA+eA/tYaMYI
         Y0QH0appUDGgAU/iCvtSaHHcH49M53u9lJ2gwQ5sZwuMMeSPnFPgHzjIBqv3BeSfYRlJ
         xvechPdEmgyOqG07nK6+N0VIL0Nl+KiqVFKLAixAcFi59f6mO2+kI8ivDP62z3e3QyGL
         Ydng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUlDwcgwPAcRYMvT6n0zmQZ02FrFSLFm4jKgBTz17LU=;
        b=SNogohPumx8Z9eBndkHoaJKm3+5NlzONiLohvNx5Fka/5YCG83AYET9DC4LFNP0DuE
         gGYrCHbv/dWVh840Kb740h0xqC262N7bH9HxgIQHWu/OeKQwd4ebF7+rBxCV5B8bXcG3
         fdW6bQOVehEDuPrkOPrpE2/75evXxlCCCGYkJ8G3ErZvQ/qrJwYtSxVOk4AS3wr8WNql
         YJu8lWqi65ctKfePsEIbOsz3RjABNLAUOTOYnBh2z8XJjhv5PJ+3/ZVZLnSp0J1tRkTh
         FS0nqOP2zLlojXuKvEigVw2U99+5qrPEAMqvkC6z7tzfArfYOkKPOHLL9LLhOOYLSwgZ
         wkwg==
X-Gm-Message-State: AOAM533PSFCU6/DSlhBIWLZnx2tD30TfjbrrQa5yfAW4co7lp4Prg0JZ
        NGZx+4ALnfOGthG86V43MSkswG+JWzgAPEd3/G+nLw==
X-Google-Smtp-Source: ABdhPJy3/ASgM45udMwId+U8e7zn4WwchaRq957LjL2HP2hRvBq6aRgoGXGIp2N7MYU2Ynup+2a99x/e4Y0612lWCik=
X-Received: by 2002:a63:4f50:: with SMTP id p16mr913749pgl.40.1619131163259;
 Thu, 22 Apr 2021 15:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210422001736.3255735-1-seanjc@google.com> <CAAeT=FxaRV+za7yk8_9p45k4ui3QJx90gN4b8k4egrxux=QWFA@mail.gmail.com>
 <YIHYsa1+psfnszcv@google.com>
In-Reply-To: <YIHYsa1+psfnszcv@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Thu, 22 Apr 2021 15:39:07 -0700
Message-ID: <CAAeT=FwXuaHM+_ZpoCwHgXyBtSn_gA3r8j+gZ9rfgUBxEwkpWA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: SVM: Delay restoration of host MSR_TSC_AUX until
 return to userspace
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> All in all, I think we want this:
>
>         case MSR_TSC_AUX:
>                 if (!boot_cpu_has(X86_FEATURE_RDTSCP))
>                         return 1;
>
>                 if (!msr_info->host_initiated &&
>                     !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
>                         return 1;
>
>                 /*
>                  * TSC_AUX is usually changed only during boot and never read
>                  * directly.  Intercept TSC_AUX instead of exposing it to the
>                  * guest via direct_access_msrs, and switch it via user return.
>                  */
>                 preempt_disable();
>                 r = kvm_set_user_return_msr(TSC_AUX_URET_SLOT, data, -1ull);
>                 preempt_enable();
>                 if (r)
>                         return 1;
>
>                 /*
>                  * Bits 63:32 are dropped by AMD CPUs, but are reserved on
>                  * Intel CPUs.  AMD's APM has incomplete and conflicting info
>                  * on the architectural behavior; emulate current hardware as
>                  * doing so ensures migrating from AMD to Intel won't explode.
>                  */
>                 svm->tsc_aux = (u32)data;
>                 break;


Thank you for the explanation.
I understand and the code above looks good to me.
(I would assume we want to check the msr_info->host_initiated and
guest_cpuid_has in svm_get_msr as well)

Thanks,
Reiji
