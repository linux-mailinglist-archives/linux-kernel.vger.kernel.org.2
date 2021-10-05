Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133B9421F83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhJEHjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231816AbhJEHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633419452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49p/2VYCpgzSUPriPCQYlTSgRQVf+nlRSvbtUTXuaMU=;
        b=B9AlEbB19+f2vB8LRNxY2s6udT6AyA7/+cldz5bmp+wbIdAXzyxZ874uM417sRhhZrDoNN
        HmwHCTr1l4p3gGsIIjo53HTG+KHyAWoqVtb8/5aJVfzLCJf8AN7YBthU2o63Op5AADN86a
        Rksc/Mxhqxnv3IgGiLWsfwJ23wHYmd0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-_89JLQ_oOW-f1q6W0n7jzQ-1; Tue, 05 Oct 2021 03:37:31 -0400
X-MC-Unique: _89JLQ_oOW-f1q6W0n7jzQ-1
Received: by mail-ed1-f69.google.com with SMTP id k10-20020a508aca000000b003dad77857f7so3862074edk.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 00:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=49p/2VYCpgzSUPriPCQYlTSgRQVf+nlRSvbtUTXuaMU=;
        b=LPkuisyUtb8fXUjmxVU6fgvmM6BgzgA+So9794M2zZkzuPQjbwn5ie2FC4SRLWR/ic
         2xwCsXTRSe208cuPXhy/l5pXmd/QIuui3Xvntai/KHmlQ4YnDEdde3UvAy0uiZFGqhn3
         oNQZIVINiEeWs/YePaCUUBn/MP48cwgQasTzBC4R4T8R4hKWpxrvCLqWLpi3cpBKsEAI
         DXQThTSiQRx6rlP25RZ7lwRXW7Sr0bYL7MM7AueZzFVaQTZvPaFAS4ePgH7BU6pj00za
         kWWAheLPGHnL8POrqfsdd/thhSvkSNvU7v5noOXgWFJFxr6CVV0eawsXzvRblV0v0PHF
         NWYA==
X-Gm-Message-State: AOAM533VtTWYO+Wcq3HR9KlLRdokqiLYG2FfUVNwC0FcJINYvXzHil12
        EVM4yTGfQqoCpHgkB8nQgrxi92+FRKgoHReKcG3GOBpVfFL2Ic/LxP6tz7rBahExUG8gTW0Yxbd
        4vHeNM7UAuZ1YRC0pWUi4sy3f
X-Received: by 2002:aa7:d78e:: with SMTP id s14mr23518882edq.171.1633419449697;
        Tue, 05 Oct 2021 00:37:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYKBVFrLpIIpPhu4m8RSBp05E7KVTz4BenJWgbIUX3s52OfAYe/V6Krl1NZzZwvRsRNqEHBQ==
X-Received: by 2002:aa7:d78e:: with SMTP id s14mr23518858edq.171.1633419449429;
        Tue, 05 Oct 2021 00:37:29 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.162.200])
        by smtp.gmail.com with ESMTPSA id d10sm7349501eja.81.2021.10.05.00.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 00:37:28 -0700 (PDT)
Message-ID: <ea3a9bab-28f2-48e7-761e-b41d7bc7d0a5@redhat.com>
Date:   Tue, 5 Oct 2021 09:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v20 00/17] KVM RISC-V Support
Content-Language: en-US
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, graf@amazon.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, anup@brainfault.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-1bfcbce2-3da3-4490-bcc5-45173ad84285@palmerdabbelt-glaptop>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <mhng-1bfcbce2-3da3-4490-bcc5-45173ad84285@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/21 20:01, Palmer Dabbelt wrote:
> 
> Just to make sure we're on the same page here, I've got
> 
>     commit 6c341a285912ddb2894ef793a58ad4f8462f26f4 (HEAD -> for-next)
>     Merge: 08da1608a1ca 3f2401f47d29
>     Author: Palmer Dabbelt <palmerdabbelt@google.com>
>     Date:   Mon Oct 4 10:12:44 2021 -0700
>         Merge tag 'for-riscv' of 
> https://git.kernel.org/pub/scm/virt/kvm/kvm.git into for-next
>         H extension definitions, shared by the KVM and RISC-V trees.
>         * tag 'for-riscv' of 
> ssh://gitolite.kernel.org/pub/scm/virt/kvm/kvm: (301 commits)
>           RISC-V: Add hypervisor extension related CSR defines
>           KVM: selftests: Ensure all migrations are performed when test 
> is affined
>           KVM: x86: Swap order of CPUID entry "index" vs. "significant 
> flag" checks
>           ptp: Fix ptp_kvm_getcrosststamp issue for x86 ptp_kvm
>           x86/kvmclock: Move this_cpu_pvti into kvmclock.h
>           KVM: s390: Function documentation fixes
>           selftests: KVM: Don't clobber XMM register when read
>           KVM: VMX: Fix a TSX_CTRL_CPUID_CLEAR field mask issue
>           selftests: KVM: Explicitly use movq to read xmm registers
>           selftests: KVM: Call ucall_init when setting up in rseq_test
>           KVM: Remove tlbs_dirty
>           KVM: X86: Synchronize the shadow pagetable before link it
>           KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
>           KVM: x86: nSVM: don't copy virt_ext from vmcb12
>           KVM: x86: nSVM: test eax for 4K alignment for GP errata 
> workaround
>           KVM: x86: selftests: test simultaneous uses of V_IRQ from L1 
> and L0
>           KVM: x86: nSVM: restore int_vector in svm_clear_vintr
>           kvm: x86: Add AMD PMU MSRs to msrs_to_save_all[]
>           KVM: x86: nVMX: re-evaluate emulation_required on nested VM exit
>           KVM: x86: nVMX: don't fail nested VM entry on invalid guest 
> state if !from_vmentry
>           ...
> 
> into 
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git 
> for-next
> (I know that's kind of a confusing name, but it's what I've been using 
> as my short-term staging branch so I can do all my tests before saying 
> "it's on for-next").
> 
> If that looks OK I can make it a touch more official by putting into the 
> RISC-V tree.

Yes.  All of the patches in there, except the last, are already in 
Linus's tree.

Thank you,

Paolo

