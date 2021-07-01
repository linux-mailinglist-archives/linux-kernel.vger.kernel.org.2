Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8887C3B8FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhGAJs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbhGAJs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:48:56 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08C0C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 02:46:24 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so5988045otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KqXQbQzlGVwEb4hWk4vNvj2KHxy2ozKcVZUp0ZucZUA=;
        b=pzYWtZ85Xr0ACe20qL8ekATUPFSpPXGUulouerDSLObu1bRaA7gRhx52fZhiD8XvcR
         vflwJvbUaibOzGeRTfsrgCBkdimwmu9Fd+xLUZlY+Q1aDSq0FFDRarNgdyuf+y/WIplp
         oMssndh9bXrM90I0syKFbHoN1LCfcyNp5O/N8fuUeCUnmhbBEUJ3Zl88HMXba/6VhEaI
         tlv9KuGDpoZriGyjRg6MblOaem9DEmEAF/GxRRtk1wBU52an2+zwWw0JPPfb5KN98Oew
         huvnk5ShQ1DjVzE7/CS80XPF1GPJZJ+ol72Lq9lNp8b1ZHmRQ0PF9TH5Xma/Ybcmdci0
         /J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqXQbQzlGVwEb4hWk4vNvj2KHxy2ozKcVZUp0ZucZUA=;
        b=Jk6MTEYJSG4l0WukKHcUSVjgyjvjTlBzpVS2i4awAJitAz6JSo7AwCMdgrVLcCEwlQ
         UiiceyXNKflGr8ACC3rg0ZErTVvV7slcCtFkhL7I2+KZL2MYiF6XpecXQ3sIXDtDumIF
         /KB/LusgglbJKTSu5Tq8AY979nLdPnQLqAgbuooTIhyXliooBTMXXeX1WR51MPKHQD31
         3Z5ARDKnCsmi7w0WHWpbms9HLMhMgH+STBKlj/pzEeJr5TYi82YA085g0+HTFRhA3Dt0
         Tx6/QNz1WbYLo6M8aA9lzC1mmW2Khh+qP1ABoHoCOgS4zJVuDCPO4nM5Y7liRG5UwpV4
         CTrg==
X-Gm-Message-State: AOAM531+9+3XguqP2njFjkNF8+P0+zaORV5ThgPaW86CQdRFNJG2YB6P
        Vp7n9zT+VJE7wLA/iBrmLrAg/qPlGN98la2gnFnHZA==
X-Google-Smtp-Source: ABdhPJzkPZ4KZLlvCnTvoKpFFW/fJBrw9Dhv5ZuJscqzhxX3tORpPfVsjsrdFi0cULSbHzUPEuJxSs3HMxEpPJek4t8=
X-Received: by 2002:a05:6830:18da:: with SMTP id v26mr12685796ote.144.1625132783894;
 Thu, 01 Jul 2021 02:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210608154805.216869-1-jean-philippe@linaro.org> <20210608154805.216869-4-jean-philippe@linaro.org>
In-Reply-To: <20210608154805.216869-4-jean-philippe@linaro.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 1 Jul 2021 10:45:47 +0100
Message-ID: <CA+EHjTzSSVbJGyWbR98eyshZbNsaf6uSu8zqJs7kHkwGYZf2yQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] KVM: arm64: Allow userspace to request WFI
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     maz@kernel.org, salil.mehta@huawei.com, lorenzo.pieralisi@arm.com,
        kvm@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, will@kernel.org,
        jonathan.cameron@huawei.com, pbonzini@redhat.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

On Tue, Jun 8, 2021 at 4:54 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> To help userspace implement PSCI CPU_SUSPEND, allow setting the "HALTED"
> MP state to request a WFI before returning to the guest.
>
> Userspace won't obtain a HALTED mp_state from a KVM_GET_MP_STATE call
> unless they set it themselves. When set by KVM, to handle wfi or
> CPU_SUSPEND, it is consumed before returning to userspace.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  Documentation/virt/kvm/api.rst | 15 +++++++++------
>  include/uapi/linux/kvm.h       |  1 +
>  arch/arm64/kvm/arm.c           | 11 ++++++++++-
>  3 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 7fcb2fd38f42..e4fe7fb60d5d 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -1416,8 +1416,8 @@ Possible values are:
>                                   which has not yet received an INIT signal [x86]
>     KVM_MP_STATE_INIT_RECEIVED    the vcpu has received an INIT signal, and is
>                                   now ready for a SIPI [x86]
> -   KVM_MP_STATE_HALTED           the vcpu has executed a HLT instruction and
> -                                 is waiting for an interrupt [x86]
> +   KVM_MP_STATE_HALTED           the vcpu has executed a HLT/WFI instruction
> +                                 and is waiting for an interrupt [x86,arm64]

Considering that arm64 has a HLT instruction (for debugging), which is
very different from the x86 one, would it be good to clarify that in
the comment. e.g.,

"the vcpu has executed a HLT(x86)/WFI(arm64) instruction"?

Thanks,
/fuad


>     KVM_MP_STATE_SIPI_RECEIVED    the vcpu has just received a SIPI (vector
>                                   accessible via KVM_GET_VCPU_EVENTS) [x86]
>     KVM_MP_STATE_STOPPED          the vcpu is stopped [s390,arm/arm64]
> @@ -1435,8 +1435,9 @@ these architectures.
>  For arm/arm64:
>  ^^^^^^^^^^^^^^
>
> -The only states that are valid are KVM_MP_STATE_STOPPED and
> -KVM_MP_STATE_RUNNABLE which reflect if the vcpu is paused or not.
> +Valid states are KVM_MP_STATE_STOPPED and KVM_MP_STATE_RUNNABLE which reflect
> +if the vcpu is paused or not. If KVM_CAP_ARM_MP_HALTED is present, state
> +KVM_MP_STATE_HALTED is also valid.
>
>  4.39 KVM_SET_MP_STATE
>  ---------------------
> @@ -1457,8 +1458,10 @@ these architectures.
>  For arm/arm64:
>  ^^^^^^^^^^^^^^
>
> -The only states that are valid are KVM_MP_STATE_STOPPED and
> -KVM_MP_STATE_RUNNABLE which reflect if the vcpu should be paused or not.
> +Valid states are KVM_MP_STATE_STOPPED and KVM_MP_STATE_RUNNABLE which reflect
> +if the vcpu should be paused or not. If KVM_CAP_ARM_MP_HALTED is present,
> +KVM_MP_STATE_HALTED can be set, to wait for interrupts targeted at the vcpu
> +before running it.
>
>  4.40 KVM_SET_IDENTITY_MAP_ADDR
>  ------------------------------
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 79d9c44d1ad7..06ba64c49737 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1083,6 +1083,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_SGX_ATTRIBUTE 196
>  #define KVM_CAP_VM_COPY_ENC_CONTEXT_FROM 197
>  #define KVM_CAP_PTP_KVM 198
> +#define KVM_CAP_ARM_MP_HALTED 199
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index d8cbaa0373c7..d6ad977fea5f 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -207,6 +207,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>         case KVM_CAP_SET_GUEST_DEBUG:
>         case KVM_CAP_VCPU_ATTRIBUTES:
>         case KVM_CAP_PTP_KVM:
> +       case KVM_CAP_ARM_MP_HALTED:
>                 r = 1;
>                 break;
>         case KVM_CAP_SET_GUEST_DEBUG2:
> @@ -469,6 +470,9 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>         case KVM_MP_STATE_RUNNABLE:
>                 vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>                 break;
> +       case KVM_MP_STATE_HALTED:
> +               kvm_arm_vcpu_suspend(vcpu);
> +               break;
>         case KVM_MP_STATE_STOPPED:
>                 kvm_arm_vcpu_power_off(vcpu);
>                 break;
> @@ -699,7 +703,12 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
>                         preempt_enable();
>                 }
>
> -               if (kvm_check_request(KVM_REQ_SUSPEND, vcpu)) {
> +               /*
> +                * Check mp_state again in case userspace changed their mind
> +                * after requesting suspend.
> +                */
> +               if (kvm_check_request(KVM_REQ_SUSPEND, vcpu) &&
> +                   vcpu->arch.mp_state == KVM_MP_STATE_HALTED) {
>                         if (!irq_pending) {
>                                 kvm_vcpu_block(vcpu);
>                                 kvm_clear_request(KVM_REQ_UNHALT, vcpu);
> --
> 2.31.1
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
