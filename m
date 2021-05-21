Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E69438BDD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 07:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhEUFVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 01:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEUFVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 01:21:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53174C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:20:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j12so13364180pgh.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIFxxwYlV9MeWU9exPU/QeZ0iOFgjcwohsSxCpudCh0=;
        b=tdvKCKEn29Lt+RMvyjqEWsRZGBlFJRCPiht+uMCfYKmgDyefOHpNdYylsmhor0v0Bg
         RvOFP8dVi8iVhzdOq2ZE6PgniqtCf7zzZsIZweSSqBb6xJWHzv2U+9RYzES4bmXHvuzC
         XJEe6o9F6oKap/9Qn8sl9soEyxn38KcxyJJ9vO8QAzdcqIb7g2gBkXNCraht/FRhyKZN
         M8ez7XSeEqVArCJBykfgg/cIp/onyUzSxOTATvrbngj465KTZAIPJy26O9yclGRfCc+S
         E3VKulXAAHq9Spzh1sq3bg1RcT6vJBWrkwUiaq/L/FwkhnuTDWWzdFvbH70BvBEt3Txy
         w2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIFxxwYlV9MeWU9exPU/QeZ0iOFgjcwohsSxCpudCh0=;
        b=I5J8B0gnnCdQS3wWp4FfyFFTUxPUm80G4/JXGye43WGUHGKY10Udjn65hj2EKZhnj9
         /bRnMgJz2Mmspm4eutiHnTKls7MD4I+EIoZ39puO4Hb2gWIzN9aVEuJ2qSOqiNQOjVfO
         hIr1qXiui0buepjNmvYTzG/f2o0+mmvVicHUW0pl+rND7YTyu/qM7g338KU5573xBwgR
         Y7gHuAyAz2xBrY1i1sXqumOkgi10ZltyqmNHpQdNzqHANlNdmiy/2PXGvBxGTy+Vi9Hy
         638/hBQvrShR7elgqfKIRlfQXqBVGi29xydWJNRL7XuTV2qfI1DCsM5oBRDeKTMV7nC2
         LlmA==
X-Gm-Message-State: AOAM532jYzODsEMfIyZMG6dYnaFp+XPgza0W7bF4kM3e4G1ZvUoYLq78
        SBnMnM+NF/IQK2TKf1PAEkaLZl9wGhKZyJOdBk/SxA==
X-Google-Smtp-Source: ABdhPJxr7YCbDSxfJoEk0uo+BeRVOe2Z2bK/QVvKeMvdh2aJ1Wba+eYgeYXvZ8ycn5uvzdKi24DhLiGHNvvW8lqdeDE=
X-Received: by 2002:a63:4f50:: with SMTP id p16mr8045052pgl.40.1621574409590;
 Thu, 20 May 2021 22:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-36-seanjc@google.com>
 <CAAeT=Fx08jBjXoduko_O3v+q67a2fx6byU6z6gM=fBmSWFkt8g@mail.gmail.com> <YKQ1cO7XRJteY/AX@google.com>
In-Reply-To: <YKQ1cO7XRJteY/AX@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Thu, 20 May 2021 22:19:53 -0700
Message-ID: <CAAeT=Fy4_MKNw5DFiXswbm6Unbb0tARLH05hYtVJPnD6SRG45w@mail.gmail.com>
Subject: Re: [PATCH 35/43] KVM: x86: Move setting of sregs during vCPU
 RESET/INIT to common x86
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 2:45 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, May 17, 2021, Reiji Watanabe wrote:
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -1204,12 +1204,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
> > >         init_sys_seg(&save->ldtr, SEG_TYPE_LDT);
> > >         init_sys_seg(&save->tr, SEG_TYPE_BUSY_TSS16);
> > >
> > > -       svm_set_cr0(vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
> > > -       svm_set_cr4(vcpu, 0);
> > > -       svm_set_efer(vcpu, 0);
> > > -       kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
> > > -       vcpu->arch.regs[VCPU_REGS_RIP] = 0x0000fff0;
> >
> > Reviewed-by: Reiji Watanabe <reijiw@google.com>
> >
> > Those your vCPU RESET/INIT changes look great.
> >
> > I think the change in init_vmcb() basically assumes that the
> > function is called from kvm_vcpu_reset(via svm_vcpu_reset()).
> > Although shutdown_interception() directly calls init_mcb(),
> > I would think the change doesn't matter for the shutdown
> > interception case.
> >
> > IMHO it would be a bit misleading that a function named 'init_vmcb',
> > which is called from other than kvm_vcpu_reset (svm_vcpu_reset()),
> > only partially resets the vmcb (probably just to me though).
>
> It's not just you, that code is funky.  If I could go back in time, I would lobby
> to not automatically init the VMCB and instead put the vCPU into
> KVM_MP_STATE_UNINITIALIZED and force userspace to explicitly INIT or RESET the
> vCPU.  Even better would be to add KVM_MP_STATE_SHUTDOWN, since technically NMI
> can break shutdown (and SMI on Intel CPUs).

I see.  Adding KVM_MP_STATE_SHUTDOWN sounds right to me
given the real CPU's behavior.

> Anyways, that ship has sailed, but we might be able to get away with replacing
> init_vmcb() with kvm_vcpu_reset(vcpu, true), i.e. effecting a full INIT.  That
> would ensure the VMCB is consistent with KVM's software model, which I'm guessing
> is not true with the direct init_vmcb() call.  It would also have some connection
> to reality since there exist bare metal platforms that automatically INIT the CPU
> if it hits shutdown (maybe only for the BSP?).

Yes, calling kvm_vcpu_reset(vcpu, true) sounds better than
the direct init_vmcb() call.


> Side topic, the NMI thing got me looking through init_vmcb() to see how it
> handles the IDT and GDT, and surprise, surprise, it fails to zero IDTR.base and
> GDTR.base.  I'll add a patch to fix that, and maybe try to consolidate the VMX
> and SVM segmentation logic.

That's surprising...
It seems init_vmcb() was used only for RESET when the function was
originally introduced and the entire vmcb was zero-cleared before
init_vmcb() was called.  So, I would suspect init_vmcb() was originally
implemented assuming that all the vmcb fields were zero.

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6aa8b732ca01c3d7a54e93f4d701b8aabbe60fb7

Thanks,
Reiji
