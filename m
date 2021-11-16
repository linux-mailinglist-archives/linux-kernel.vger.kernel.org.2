Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27518453415
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbhKPO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhKPO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:26:45 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB199C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:23:46 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n29so37885602wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7kOp545uVgx+GwL0MS2uV1T/3qLsZYrxv7B/NrXjJ0=;
        b=EMhiTIADHX9DiXxs1O8k/BKoqlBWAU/GRoWm0wPlPlMvCMCar7lRLY8j/HCLDSu+9q
         bQ+5g0kVF9+WDT61LBdd4DdKHxhMr4Zex6NYFbjZ1vJSvOLWdQRmGK5reVKGuA/pMc81
         4dfOnSmhgTTZKcHCAFoG44Owt3/v3ZpnFzKRwA1i6GLVx6kpEz7DJbNOQqJfufktOBKn
         eDPGSjAugQFu1al3bgZPR9W6GMeHRPMJfV7OC8y3ZPFn6fWg3Gn/QFpMxxi8Vrsy+ofi
         lIfV0QHe8wRNtrVGNUCym2Ohe7bbx0VSh5LON5Q11cDYoKv/gu8PC1mJ9OYFB22YMLDw
         JdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7kOp545uVgx+GwL0MS2uV1T/3qLsZYrxv7B/NrXjJ0=;
        b=nMxWYvQCRzekeFqDQN9LeGWoMHi4IJswqSAbsrpMzFttu+Kmn5oSzy/AeQafKUa9GD
         rPFdEwRM8h4Mn3Z1sR9O3AHukJu9I6w144q+qZD4Ilc0vNel4rKkkYgLLpbkkJDpz4ky
         9kd8eWoVzvrO0mWb7Q9JzV6DzCref4ooaGw8JoIeZN/dW89HDEgb11aCz3rL+6my/cbT
         tEHJHvpV9d+AneiDe5HpRwjCrjVRuNvSfSj7WwaRxych3DYOS5zkBnMYlOtyhmiKLhOq
         3TTA4BEFHUAI6eLGTUaGZCqH32Gb1tJ4hX4B3FtcIesPy+4shMASbDgNE7tedt9P52g3
         8o/Q==
X-Gm-Message-State: AOAM533JcHKamHOET4dNZ/VVBsSHbS3yR7o3lJJXSGbsMP7AkJBkj5NY
        8AdaX1W8B+Z9kz/pwS+yDvsOZeVuqDO+ad4kflZo3w==
X-Google-Smtp-Source: ABdhPJy1qTUFimPfD6YE2YJwCxkMQbs6CZrlUst3mZPNkbsBqE7ARnXVPNrMOA8ymxY0gvwCyDiplZvMikGY4x4mz6A=
X-Received: by 2002:a5d:628f:: with SMTP id k15mr9997324wru.363.1637072625270;
 Tue, 16 Nov 2021 06:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20211104164107.1291793-1-seanjc@google.com> <20211104164107.1291793-2-seanjc@google.com>
In-Reply-To: <20211104164107.1291793-2-seanjc@google.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 16 Nov 2021 19:47:08 +0530
Message-ID: <CAAhSdy1sREo9KT_99kbz70RYLsXr1aCSapxxpraZ6ZOxh1P+kw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: RISC-V: Unmap stage2 mapping when
 deleting/moving a memslot
To:     Sean Christopherson <seanjc@google.com>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 10:11 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Unmap stage2 page tables when a memslot is being deleted or moved.  It's
> the architectures' responsibility to ensure existing mappings are removed
> when kvm_arch_flush_shadow_memslot() returns.
>
> Fixes: 99cdc6c18c2d ("RISC-V: Add initial skeletal KVM support")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

The Fixes tag should be
Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")

Otherwise it looks good to me.

I have queued this patch for fixes.

Thanks,
Anup

> ---
>  arch/riscv/kvm/mmu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index d81bae8eb55e..fc058ff5f4b6 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -453,6 +453,12 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
>  void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>                                    struct kvm_memory_slot *slot)
>  {
> +       gpa_t gpa = slot->base_gfn << PAGE_SHIFT;
> +       phys_addr_t size = slot->npages << PAGE_SHIFT;
> +
> +       spin_lock(&kvm->mmu_lock);
> +       stage2_unmap_range(kvm, gpa, size, false);
> +       spin_unlock(&kvm->mmu_lock);
>  }
>
>  void kvm_arch_commit_memory_region(struct kvm *kvm,
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
