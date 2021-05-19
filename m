Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ABF389528
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhESSSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhESSSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:18:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF67C061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:16:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id i6so2689053plt.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLFOMXpBdE9Bfa/vJlsX+au0pL0rCjWGCqtbO53j0sI=;
        b=ESQcwON7SLUKOrT+MYax0/AVotfmbb0XsyujjM3thAc1uAFm4jqxH6aP4XxEsmxMWl
         zuSg/rvCmZyHfkq0P2FIwTYF8PllSOMntj/U7PCjRb1tGOV7WVosv/ibZILgjPXG5UqB
         ASLIID4F0DTslwl85Dhyd5vhZ59htMiZPWck3Q727lnHUka96w+25PncyAnKvwn7/C8T
         Ujxg0wat5cPzrjNV1tpUkBXF8VO5o9OJqBABp6fl+dyt1EXr8VzZYfVVnK/jQph6unH3
         eutzxDSGV4mfzMJ+hD9wK79iQWjXFbXPqkDPzfRwMkwU4N4MeIcnVz2+9CYdNAq8WK4B
         2wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLFOMXpBdE9Bfa/vJlsX+au0pL0rCjWGCqtbO53j0sI=;
        b=kjntVLtfssZoJMimdIU2UeFPsHH9D4zZgGKcsRosc5jK7k6/H6e5NTxw5e9P6deCGX
         CrCorhDpMuMjoa4Rk78eKzo7Kmb0meyj7492pc4gc2w8jeyBi+eKcRGBbH9axZA4KAaj
         zeB4ivjDjbyTOcMUeAnBSG5KeBIO8iR4ZwQJB+V8+sXk+1bUn3Ov9gPke1UZd2ST3Q/i
         TGqm+JkpmFYqZGczqqOKguSUkNodSXbycQrz1TDoPrAMM5zynO2Oj+UI4NG9e51ni5EM
         kcm2JmfnZKVYaQlqhbWiVeytJ+2+WnARgqHHJ91C4mK60A+nQEk1GjnOU21JnPy/slO0
         KuvA==
X-Gm-Message-State: AOAM532CpQ2TqHQwRrKnkrlCLw63duV9PSMAr5EREJqD0YIE5KYyjF3f
        KiYSCFjP1S7nduEqqjfTwivqqpR2F+RlWVm3U8gycw==
X-Google-Smtp-Source: ABdhPJy6NwBBDCQq6YpwLGD5OciCit48q01GnkJo6wDYjUBiUy8kpthyQ0i0x3sO1MiZsK3ub10BV25cuLZsjOfmiZE=
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr262354pjb.168.1621448213191;
 Wed, 19 May 2021 11:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-30-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-30-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Wed, 19 May 2021 11:16:37 -0700
Message-ID: <CAAeT=FzpUBXpzuCT3eD=3sRnV14OYLA+28Eo7YFioC+vc=xVsA@mail.gmail.com>
Subject: Re: [PATCH 29/43] KVM: SVM: Tweak order of cr0/cr4/efer writes at RESET/INIT
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

> @@ -1204,18 +1204,13 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>         init_sys_seg(&save->ldtr, SEG_TYPE_LDT);
>         init_sys_seg(&save->tr, SEG_TYPE_BUSY_TSS16);
>
> +       svm_set_cr0(vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
>         svm_set_cr4(vcpu, 0);
>         svm_set_efer(vcpu, 0);
>         save->dr6 = 0xffff0ff0;
>         kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
>         vcpu->arch.regs[VCPU_REGS_RIP] = 0x0000fff0;
>
> -       /*
> -        * svm_set_cr0() sets PG and WP and clears NW and CD on save->cr0.
> -        * It also updates the guest-visible cr0 value.
> -        */
> -       svm_set_cr0(vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);

AMD's APM Vol2 (Table 14-1 in Revision 3.37) says CR0 After INIT will be:

   CD and NW are unchanged
   Bit 4 (reserved) = 1
   All others = 0

(CR0 will be 0x60000010 after RESET)

So, it looks the CR0 value that init_vmcb() sets could be
different from what is indicated in the APM for INIT.

BTW, Intel's SDM (April 2021 version) says CR0 for Power up/Reset/INIT
will be 0x60000010 with the following note.
-------------------------------------------------
The CD and NW flags are unchanged,
bit 4 is set to 1, all other bits are cleared.
-------------------------------------------------
The note is attached as '2' to all Power up/Reset/INIT cases
looking at the SDM.  I would guess it is erroneous that
the note is attached to Power up/Reset though.

Thanks,
Reiji
