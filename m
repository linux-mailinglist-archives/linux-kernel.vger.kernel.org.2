Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364C83AFEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFVIKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFVIKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:10:44 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6490FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 01:08:28 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so20480359otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 01:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Beo38iuohodlyRGHyjXttlsvIYg9mKSm+zuOAhH7bbI=;
        b=eXFdd6VxuZa/DYPOmOXnXEky4VQsJMT/UQpduHu02BEU1YhAn1pFfY4FaYLDYL+ikC
         uAHK2J/vbGb40UKTAEfT/yo1IYWvbxUDVqFGzgBAydAhPlRO4zmhMwZL5+u7HGavYZKH
         H12WEshODfMx+D7fAubGmbmY9lBoPGpqkW3J/X+5gcKxM/i2xzfNbVMqDiYsTU1158qs
         gg9IWNeR2Yza7A5Ic/pwJaQ449BMitgtZvwr4VOY6PjYgZeq5ar+lh1ej3pCQJ9MnJwZ
         JvE5EgYzJz7WiQzsrYxSPY3I6n1l+xuGf8aj3ziygHc6+Z2EAocVErEEFRefl+xrNi8E
         nKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Beo38iuohodlyRGHyjXttlsvIYg9mKSm+zuOAhH7bbI=;
        b=V4I5xPjRGD79gAb/iJ1iS0SmskqW/Swd6MI0mD0mw07KkJTdfQLqgt4O6U2v0smJiy
         PDqpY9AtZqq0bid0BtR6Ngz0Jk0/ElXBngg7oifQe6nuK2TpE2i7xKu7UX9BFFzj1OmK
         Unry5XsiSJbJAdJZOmKTtQ6VcT7hlAVXoul4FbDoq72LjWTKsKgvmCvq7p/jhCKtV/WC
         C2gfmihxx+pX1fE8gFYBBIkm8rruH3DcQmrrDYVr/OrWKqhx/eq9SsynQM5+egMdE1Ev
         87bpif2740Ji90IdDhixBt48V7ukubiCDo0wMkJTbWjeY3ZU/QNbeO2r7CcEEYPHbnN6
         a/jA==
X-Gm-Message-State: AOAM5326Z8QBdBU77PuBj64qGthA5r4ynAHgMHWcZIRKtS3rCPFyb9fz
        KIMG7SbzacGtVIIxFbxRb71IGZXZdWFnTJEHYY6GvQ==
X-Google-Smtp-Source: ABdhPJyiET1EnWwNel3SWJVHizN68wDafL2KmojvV1sgueaM5ziIuDkR6iIl0gSG5oojwkafjVs4ZM7JoA8uNdQS05g=
X-Received: by 2002:a05:6830:1598:: with SMTP id i24mr2089639otr.52.1624349307481;
 Tue, 22 Jun 2021 01:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210621111716.37157-1-steven.price@arm.com> <20210621111716.37157-5-steven.price@arm.com>
In-Reply-To: <20210621111716.37157-5-steven.price@arm.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 22 Jun 2021 09:07:51 +0100
Message-ID: <CA+EHjTzuduzTcJo+jjVzVAVUB4i3Nr3mki4jyiNW9K=pr-HPYA@mail.gmail.com>
Subject: Re: [PATCH v17 4/6] KVM: arm64: Expose KVM_ARM_CAP_MTE
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        qemu-devel@nongnu.org, Dave Martin <Dave.Martin@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 21, 2021 at 12:18 PM Steven Price <steven.price@arm.com> wrote:
>
> It's now safe for the VMM to enable MTE in a guest, so expose the
> capability to user space.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/kvm/arm.c      | 9 +++++++++
>  arch/arm64/kvm/reset.c    | 4 ++++
>  arch/arm64/kvm/sys_regs.c | 3 +++
>  3 files changed, 16 insertions(+)
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e720148232a0..28ce26a68f09 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -93,6 +93,12 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>                 r = 0;
>                 kvm->arch.return_nisv_io_abort_to_user = true;
>                 break;
> +       case KVM_CAP_ARM_MTE:
> +               if (!system_supports_mte() || kvm->created_vcpus)
> +                       return -EINVAL;
> +               r = 0;
> +               kvm->arch.mte_enabled = true;
> +               break;
>         default:
>                 r = -EINVAL;
>                 break;
> @@ -237,6 +243,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>                  */
>                 r = 1;
>                 break;
> +       case KVM_CAP_ARM_MTE:
> +               r = system_supports_mte();
> +               break;
>         case KVM_CAP_STEAL_TIME:
>                 r = kvm_arm_pvtime_supported();
>                 break;
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index d37ebee085cf..9e6922b9503a 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -244,6 +244,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>         switch (vcpu->arch.target) {
>         default:
>                 if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
> +                       if (vcpu->kvm->arch.mte_enabled) {
> +                               ret = -EINVAL;
> +                               goto out;
> +                       }
>                         pstate = VCPU_RESET_PSTATE_SVC;
>                 } else {
>                         pstate = VCPU_RESET_PSTATE_EL1;

nit: I was wondering whether this check would be better suited in
kvm_vcpu_set_target, rather than here (kvm_reset_vcpu). kvm_reset_vcpu
is called by kvm_vcpu_set_target, but kvm_vcpu_set_target is where
checking for supported features happens. It might be better to group
all such checks together. I don't think that there is any risk of this
feature being toggled by the other call path to kvm_reset_vcpu (via
check_vcpu_requests).

Cheers,
/fuad

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 5c75b24eae21..f6f126eb6ac1 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1312,6 +1312,9 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
>                                    const struct sys_reg_desc *rd)
>  {
> +       if (kvm_has_mte(vcpu->kvm))
> +               return 0;
> +
>         return REG_HIDDEN;
>  }
>
> --
> 2.20.1
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
