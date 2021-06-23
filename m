Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7380C3B2051
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFWSbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFWSbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:31:38 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DB1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:29:20 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 14so4325919oir.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYHrGTC3a+TqzndzZD+u5HI/qQGjEDtBrwf4IIOjVpc=;
        b=BiVfxgiCIq2RxLoQpd7S7dkCTcu1xTw2fQeBWRTjRkQDSBhKdKImTub0Y5Oh8klQCJ
         ehfKpoeDIlEI4fhyf4mN6c9YLPkvnK653/qhRKRojgbq4Hjam0QAZsxfpFjuzr1AmzoB
         zxrj4x9XvcZefmyJU29MteOHarcyCXGxCi5DthOrNf9g+te2X2YjME6buhuAf5lvmmMt
         gETBRmWaKW5r6UKjV+E9s8BkAUKZgInkD6CPhDU2dSfcn5fE9qcwrnbbd7t+MpJJ1WCz
         5e3xnd0rlx/8McyRa/2Rgh2y1zmqyi1MW0xZmpjXxDqunJ8hnMtirU7phYOHeginJFgp
         hhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYHrGTC3a+TqzndzZD+u5HI/qQGjEDtBrwf4IIOjVpc=;
        b=b08ZrhMLo/7deDr247gR+hvVKZudYzq0yWwNyKstPl4lvQ68621yFJE0ZZU5YjTkVt
         fFfIh4T0iFP3QXMy5fo8ontTEt9xY5NsxYY9wBdJHvoRPLXk4IHVYWYPdMXkpwNgGDUI
         Za3mhGAY+2euOrafna6VUz8FGyhPEK3M4Fu8VtjsMoq7B1JynqvigA5v4CJqh29HZPlE
         zFXKJ2vouTBN63DOTH8AO2LEWs9w0odL6TTN+A7Y/BPotOe7nhlR3K+D/iPMahCoZ6Tm
         nmGJjvY7ooND5shq2UyJMtbr9c1fKEE3Tr5C4OQZLpBcbFe/H4SBsyPlPrJQmpa/tSz2
         AnLA==
X-Gm-Message-State: AOAM530rQsowEU7LFdu+O6T3UsURQkkdeXC7r6yvLmMFQ+dBo65ghvCF
        zKCZP/8PcPZyrK4lxQ59BvfFdQ74A00g+L3iRwtHHQ==
X-Google-Smtp-Source: ABdhPJzqtXmD0CSzJKDp3W4V6JjmPyfhXL981msUvh7ZJeQym8HBwaKcceP2WqToojtofT4BPj2woTWb2WMzpsr4ZNI=
X-Received: by 2002:a54:4586:: with SMTP id z6mr4270825oib.6.1624472959242;
 Wed, 23 Jun 2021 11:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210510081535.94184-1-like.xu@linux.intel.com> <20210510081535.94184-5-like.xu@linux.intel.com>
In-Reply-To: <20210510081535.94184-5-like.xu@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 23 Jun 2021 11:29:08 -0700
Message-ID: <CALMp9eQG+JLnHe4zRKg0sHtxynSiGGKPw--5J+cY2-f3QWRW2A@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 04/10] KVM: vmx/pmu: Add MSR_ARCH_LBR_CTL
 emulation for Arch LBR
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 1:16 AM Like Xu <like.xu@linux.intel.com> wrote:
>
> Arch LBRs are enabled by setting MSR_ARCH_LBR_CTL.LBREn to 1. A new guest
> state field named "Guest IA32_LBR_CTL" is added to enhance guest LBR usage.
> When guest Arch LBR is enabled, a guest LBR event will be created like the
> model-specific LBR does.
>
> On processors that support Arch LBR, MSR_IA32_DEBUGCTLMSR[bit 0] has no
> meaning. It can be written to 0 or 1, but reads will always return 0.
> Like IA32_DEBUGCTL, IA32_ARCH_LBR_CTL msr is also reserved on INIT.
>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  arch/x86/events/intel/lbr.c      |  2 --
>  arch/x86/include/asm/msr-index.h |  1 +
>  arch/x86/include/asm/vmx.h       |  2 ++
>  arch/x86/kvm/vmx/pmu_intel.c     | 31 ++++++++++++++++++++++++++-----
>  arch/x86/kvm/vmx/vmx.c           |  9 +++++++++
>  5 files changed, 38 insertions(+), 7 deletions(-)
>
Same comments as on the previous patch. Your guard for ensuring that
the new VMCS fields exist can be spoofed by a malicious userspace, and
the new MSR has to be enumerated by KVM_GET_MSR_INDEX_LIST.
