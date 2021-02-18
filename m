Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2710231EEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhBRSuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbhBRQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:44:13 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83142C061786
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:35:42 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z15so1657281pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DqLb1nMq14/rKI2+/NThAnihxh+nHxjLWJAo5ipH1Ws=;
        b=md44/Px+2SYhg3j59P0MfiNu7AvOT5R8yCXllWmXN1HLCn41bzTgMiigaxhw+qQ3nS
         8Vl0kNQwvSu/lWr12I2+sryWC9Xsu5ecLXdqdqfE8/yxOTBGxxFYvHwOS/C84LQ1u0hf
         mxdFswTZrTeNLMuTMil8ktlWYBYm8nzG8PThHZvZefb2zVMvdI7jbE9Dmrv3KnrTtQwO
         ueDZbeL2tBuyZrjKpfd8+hyNtYkuUHaM8qtrpQZk7M+r7jiRjRqNA0nm6vz7+uQ4OmnZ
         bRpUeHSkaUqRPHLH8sp5vDA1/z1wHWhL9iuWOUqh/tsixm5v9XUMFTxxUVMRtOZwWXSe
         M9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DqLb1nMq14/rKI2+/NThAnihxh+nHxjLWJAo5ipH1Ws=;
        b=btLFu0Ne9Ox1zbCHrGRyqWoIuwAYqw0KYfsoEGEcrvHynyWTTR3yJJ2ihFaa50AbfP
         20L0MLm/6csIfEaKuLk49clwkeufLHJzhakUSmo6DncmjjnNoeJYBkCBM4HlYwuJ9qic
         HxX7393h9Gm1QbOqrvXCFVUemTNJ4MYFdPgy3J0A02uZQZ0/OvPysX7l1YMDykN/gUdB
         uraUD4hxbUpgOjuyXHUdt3NX7jFJtYET5cC2re0bFvLXFDyVwXmxNBbKgTZRdg96rKmP
         dLEdjk/aB0rHGcim6qpPTueaeE/JlIAHygXmnioyFPiv+egAQFqyO5lMeTmN1hNUnmwI
         S42w==
X-Gm-Message-State: AOAM5311ZZb4VUsNA5v2BJioa9u/EduB1eJCwalQE9nxFIHY/OItDy0v
        YNE4vhdny0yoeTkNtOArZ9TSwQ==
X-Google-Smtp-Source: ABdhPJx4qmdTfrJEOoVNnYWhC+COxjc2izCvLNNT+7AllgY3YfPaHqJiw+a2Ps64S8Z5Argnnu8NKw==
X-Received: by 2002:a63:214e:: with SMTP id s14mr4641755pgm.101.1613666141653;
        Thu, 18 Feb 2021 08:35:41 -0800 (PST)
Received: from google.com ([2620:15c:f:10:dc76:757f:9e9e:647c])
        by smtp.gmail.com with ESMTPSA id q7sm3116401pfb.185.2021.02.18.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 08:35:40 -0800 (PST)
Date:   Thu, 18 Feb 2021 08:35:34 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Edmondson <dme@dme.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: x86: dump_vmcs should not assume GUEST_IA32_EFER is
 valid
Message-ID: <YC6XVrWPRQJ7V6Nd@google.com>
References: <20210218100450.2157308-1-david.edmondson@oracle.com>
 <708f2956-fa0f-b008-d3d2-93067f95783c@redhat.com>
 <cuntuq9ilg4.fsf@dme.org>
 <8f9d4ef7-ddad-160b-2d94-69f4370e8702@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f9d4ef7-ddad-160b-2d94-69f4370e8702@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021, Paolo Bonzini wrote:
> On 18/02/21 13:56, David Edmondson wrote:
> > On Thursday, 2021-02-18 at 12:54:52 +01, Paolo Bonzini wrote:
> > 
> > > On 18/02/21 11:04, David Edmondson wrote:
> > > > When dumping the VMCS, retrieve the current guest value of EFER from
> > > > the kvm_vcpu structure if neither VM_EXIT_SAVE_IA32_EFER or
> > > > VM_ENTRY_LOAD_IA32_EFER is set, which can occur if the processor does
> > > > not support the relevant VM-exit/entry controls.
> > > 
> > > Printing vcpu->arch.efer is not the best choice however.  Could we dump
> > > the whole MSR load/store area instead?
> > 
> > I'm happy to do that, and think that it would be useful, but it won't
> > help with the original problem (which I should have explained more).
> > 
> > If the guest has EFER_LMA set but we aren't using the entry/exit
> > controls, vm_read64(GUEST_IA32_EFER) returns 0, causing dump_vmcs() to
> > erroneously dump the PDPTRs.
> 
> Got it now.  It would sort of help, because while dumping the MSR load/store
> area you could get hold of the real EFER, and use it to decide whether to
> dump the PDPTRs.

EFER isn't guaranteed to be in the load list, either, e.g. if guest and host
have the same desired value.

The proper way to retrieve the effective EFER is to reuse the logic in
nested_vmx_calc_efer(), i.e. look at VM_ENTRY_IA32E_MODE if EFER isn't being
loaded via VMCS.
