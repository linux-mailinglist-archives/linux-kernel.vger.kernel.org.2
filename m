Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9E237936B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhEJQL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhEJQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:11:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91269C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:10:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so10622304pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CX+Gzy8S2NRsd+JFFnUGO9u9gfBBFq4ctkjerG3ZRMY=;
        b=JtLg4u+tLSkQOnuMYeoTxSx6xqMqwSESwpiXAuNiNhYrhj9SS2zK1VVXWPyUuVu9J/
         YFiItPcFGaMiKjX/hHBjSWuXtb1b6LhPxjzFZ0fBzOhen1eBUkp5nGI1/LCNmcSvU9Sr
         I7nk7Pbvnn6pEXEx2ApbNIy4SAUkDLP5HSoHUvqqsbyeNDKtGFlclkW64v15OA4R6bVb
         FwglvFRsggrxrP6TxmQiZH4uwhww1HpLVTW+NqCuY7uysthcvSBsG0+rzBPCA8uJqKmf
         EmJ4RqAIgvjrdiNUWePf7egBL/a7IynTZFf/F3yNvsGyPut4JqQK1ZZKJbHEtzoscTuF
         /z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CX+Gzy8S2NRsd+JFFnUGO9u9gfBBFq4ctkjerG3ZRMY=;
        b=KVH8hV4LIO8ENkqgvhnpb+fcmpzeKG4GhGXpWbO/4L/ucP8DCoKEm8c1Iz9ubDENnR
         HCGCI9b+memCV0HEAuaDGLs8gjglXSVVA+IaKDSOT1rvjNqwgeFj+jDX/86lhsihXzoC
         zBAsvKU6hElV+FL/MvtqzxpqC6vCHKaiRQaxot5YH3Fpwj/VKuf2Rucbf7s76paaGJxk
         PninXfXoukCbIA1Tax+iye+WI6mL1aIHOTJqE4Fx7jelLlDaL6ud+0thy8RVVo+p/dcE
         uKM3B7XeHh2unY4e4FK/58nTg4wu6RUDtCBbFSCHgcI5nSKmlR6gqnRidNbFKqCCu5dW
         64Vw==
X-Gm-Message-State: AOAM530LkVwa80Apv4L1kbPV+SbnIkKW7IUbL4D0VYpB2mlJn/ulDLEK
        UtD15mTx/bXhClNdiXrckTMWZA==
X-Google-Smtp-Source: ABdhPJzp6AmuZV2a68NqXugdCDXRowe0aqTe18NdmUWKh2QeovrjlvkmGjKZWOlnxTkZObO8Itendw==
X-Received: by 2002:a17:902:a987:b029:ef:117:fae3 with SMTP id bh7-20020a170902a987b02900ef0117fae3mr21372976plb.69.1620663030932;
        Mon, 10 May 2021 09:10:30 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id ga1sm12208228pjb.5.2021.05.10.09.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:10:30 -0700 (PDT)
Date:   Mon, 10 May 2021 16:10:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 2/2] KVM: x86: Allow userspace to update tracked sregs
 for protected guests
Message-ID: <YJla8vpwqCxqgS8C@google.com>
References: <20210507165947.2502412-1-seanjc@google.com>
 <20210507165947.2502412-3-seanjc@google.com>
 <5f084672-5c0d-a6f3-6dcf-38dd76e0bde0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f084672-5c0d-a6f3-6dcf-38dd76e0bde0@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021, Tom Lendacky wrote:
> On 5/7/21 11:59 AM, Sean Christopherson wrote:
> > Allow userspace to set CR0, CR4, CR8, and EFER via KVM_SET_SREGS for
> > protected guests, e.g. for SEV-ES guests with an encrypted VMSA.  KVM
> > tracks the aforementioned registers by trapping guest writes, and also
> > exposes the values to userspace via KVM_GET_SREGS.  Skipping the regs
> > in KVM_SET_SREGS prevents userspace from updating KVM's CPU model to
> > match the known hardware state.
> 
> This is very similar to the original patch I had proposed that you were
> against :)

I hope/think my position was that it should be unnecessary for KVM to need to
know the guest's CR0/4/0 and EFER values, i.e. even the trapping is unnecessary.
I was going to say I had a change of heart, as EFER.LMA in particular could
still be required to identify 64-bit mode, but that's wrong; EFER.LMA only gets
us long mode, the full is_64_bit_mode() needs access to cs.L, which AFAICT isn't
provided by #VMGEXIT or trapping.

Unless I'm missing something, that means that VMGEXIT(VMMCALL) is broken since
KVM will incorrectly crush (or preserve) bits 63:32 of GPRs.  I'm guessing no
one has reported a bug because either (a) no one has tested a hypercall that
requires bits 63:32 in a GPR or (b) the guest just happens to be in 64-bit mode
when KVM_SEV_LAUNCH_UPDATE_VMSA is invoked and so the segment registers are
frozen to make it appear as if the guest is perpetually in 64-bit mode.

I see that sev_es_validate_vmgexit() checks ghcb_cpl_is_valid(), but isn't that
either pointless or indicative of a much, much bigger problem?  If VMGEXIT is
restricted to CPL0, then the check is pointless.  If VMGEXIT isn't restricted to
CPL0, then KVM has a big gaping hole that allows a malicious/broken guest
userspace to crash the VM simply by executing VMGEXIT.  Since valid_bitmap is
cleared during VMGEXIT handling, I don't think guest userspace can attack/corrupt
the guest kernel by doing a replay attack, but it does all but guarantee a
VMGEXIT at CPL>0 will be fatal since the required valid bits won't be set.

Sadly, the APM doesn't describe the VMGEXIT behavior, nor does any of the SEV-ES
documentation I have.  I assume VMGEXIT is recognized at CPL>0 since it morphs
to VMMCALL when SEV-ES isn't active.

I.e. either the ghcb_cpl_is_valid() check should be nuked, or more likely KVM
should do something like this (and then the guest needs to be updated to set the
CPL on every VMGEXIT):

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a9d8d6aafdb8..bb7251e4a3e2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2058,7 +2058,7 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
        vcpu->arch.regs[VCPU_REGS_RDX] = ghcb_get_rdx_if_valid(ghcb);
        vcpu->arch.regs[VCPU_REGS_RSI] = ghcb_get_rsi_if_valid(ghcb);

-       svm->vmcb->save.cpl = ghcb_get_cpl_if_valid(ghcb);
+       svm->vmcb->save.cpl = 0;

        if (ghcb_xcr0_is_valid(ghcb)) {
                vcpu->arch.xcr0 = ghcb_get_xcr0(ghcb);
@@ -2088,6 +2088,10 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
        if (ghcb->ghcb_usage)
                goto vmgexit_err;

+       /* Ignore VMGEXIT at CPL>0 */
+       if (!ghcb_cpl_is_valid(ghcb) || ghcb_get_cpl_if_valid(ghcb))
+               return 1;
+
        /*
         * Retrieve the exit code now even though is may not be marked valid
         * as it could help with debugging.
@@ -2142,8 +2146,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
                }
                break;
        case SVM_EXIT_VMMCALL:
-               if (!ghcb_rax_is_valid(ghcb) ||
-                   !ghcb_cpl_is_valid(ghcb))
+               if (!ghcb_rax_is_valid(ghcb))
                        goto vmgexit_err;
                break;
        case SVM_EXIT_RDTSCP:

> I'm assuming it's meant to make live migration a bit easier?

Peter, I forget, were these changes necessary for your work, or was the sole root
cause the emulated MMIO bug in our backport?

If KVM chugs along happily without these patches, I'd love to pivot and yank out
all of the CR0/4/8 and EFER trapping/tracking, and then make KVM_GET_SREGS a nop
as well.
