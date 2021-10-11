Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD64291E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbhJKOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243011AbhJKOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:34:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13AC061768
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:32:43 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so1050278pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s41J4gSx8D3bzBDjJMiyT/KrwuNQffb89ch9ukkyO/U=;
        b=dkgqEWcPlRS4Nai7Df0sFprljiky8nMSvMqDR2iH3PR+cYjTrNHjJlFcHlXeJOIV1c
         n811IBHO5C88AAlUbmf1Jp7fV9hGDAxakFqJOvJllhFgO0WsWBMi9VQL85KdeDOzBmtt
         sDfH4HwVyW4+TOUvSw28WZjGHoRTiJYOnHPubooyEsscqCFMU4+qslqjaYed1f3sjP2C
         r5/zdowCmuMBDhl2x6/xJVW8wr8JKBlyCsFjkUlAd50PCwbQ3rwA5MRK441VtnM78dCK
         xW8xBHZgTzuaLzrBQCp9bnevlHJloGQ1eQsGFB3bzepnCG4R6yxgopw5AqwGCaVtaBfw
         x0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s41J4gSx8D3bzBDjJMiyT/KrwuNQffb89ch9ukkyO/U=;
        b=hdNh/uyNWxEbMGiTG7Uvwz6KAqiGlNwWNeMTHgf/NnrI5F4ZszrU7Q97nlDNE4FwV/
         Dnq/91TkczT3aiBSvuwcS5jNBIy3W1UPK2ihtJq2Tl62LDrJK/nnPGNLaesPqwXtpVWF
         dPeAL1vRHBYrI2ex1dqT54iYu/dAxy21uAId06eXxhPDz8iszSOh05Pd06fd7zPqBFZK
         uodRfMI+ThlO0xHlOSzHk4Naja9yU0TJjPxZvg6C7IIDx/OrxsJhYBbJ42RJkzBr3Sbi
         H3Qc+QhVbnxLL5RwnSXUU0P7HDxeAd2q8wqkT52n5/u4YGKFN+OcnrgbMMkYwaZpTLqL
         RCmA==
X-Gm-Message-State: AOAM530W6JbqKkhAjsDxfzkt5voxabl0ULXDWxayDlyOaEbXcg49S/IN
        bnLTD8oXx1QxDMYNZkgxUtS8MA==
X-Google-Smtp-Source: ABdhPJyTiWm2sJgS0g6mab8UytWvP9tV7766ExecZivuBqMaHXBpfFTMPSNnWZQ2UdWfqiOMh7UqCw==
X-Received: by 2002:a17:90b:388a:: with SMTP id mu10mr31019836pjb.0.1633962762598;
        Mon, 11 Oct 2021 07:32:42 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d14sm8083832pfr.123.2021.10.11.07.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 07:32:42 -0700 (PDT)
Date:   Mon, 11 Oct 2021 14:32:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "vincent.chen@sifive.com" <vincent.chen@sifive.com>,
        "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] RISC-V: Add SBI HSM extension in KVM
Message-ID: <YWRLBknWXjzPnF1w@google.com>
References: <20211008032036.2201971-1-atish.patra@wdc.com>
 <20211008032036.2201971-6-atish.patra@wdc.com>
 <YWBdbCNQdikbhhBq@google.com>
 <0383b5cacb25e9dc293d891284df9f4cbc06ee3a.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0383b5cacb25e9dc293d891284df9f4cbc06ee3a.camel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021, Atish Patra wrote:
> On Fri, 2021-10-08 at 15:02 +0000, Sean Christopherson wrote:
> > On Thu, Oct 07, 2021, Atish Patra wrote:
> > > +       preempt_disable();
> > > +       loaded = (vcpu->cpu != -1);
> > > +       if (loaded)
> > > +               kvm_arch_vcpu_put(vcpu);
> > 
> > Oof.  Looks like this pattern was taken from arm64. 
> 
> Yes. This part is similar to arm64 because the same race condition can
> happen in riscv due to save/restore of CSRs during reset.
> 
> 
> >  Is there really no better approach to handling this?  I don't see anything
> >  in kvm_riscv_reset_vcpu() that will obviously break if the vCPU is
> >  loaded.  If the goal is purely to effect a CSR reset via
> >  kvm_arch_vcpu_load(), then why not just factor out a helper to do exactly
> >  that?

What about the question here?

> > 
> > >  
> > >         memcpy(csr, reset_csr, sizeof(*csr));
> > >  
> > > @@ -144,6 +151,11 @@ static void kvm_riscv_reset_vcpu(struct
> > > kvm_vcpu *vcpu)
> > >  
> > >         WRITE_ONCE(vcpu->arch.irqs_pending, 0);
> > >         WRITE_ONCE(vcpu->arch.irqs_pending_mask, 0);
> > > +
> > > +       /* Reset the guest CSRs for hotplug usecase */
> > > +       if (loaded)
> > > +               kvm_arch_vcpu_load(vcpu, smp_processor_id());
> > 
> > If the preempt shenanigans really have to stay, at least use
> > get_cpu()/put_cpu().
> > 
> 
> Is there any specific advantage to that ? get_cpu/put_cpu are just
> macros which calls preempt_disable/preempt_enable.
> 
> The only advantage of get_cpu is that it returns the current cpu. 
> vcpu_load function uses get_cpu because it requires the current cpu id.
> 
> However, we don't need that in this case. I am not against changing it
> to get_cpu/put_cpu. Just wanted to understand the reasoning behind your
> suggestion.

It would make the code a bit self-documenting, because AFAICT it doesn't truly
care about being preempted, it cares about keeping the vCPU on the correct pCPU.

> > > +       preempt_enable();
> > >  }
> > >  
> > >  int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
> > > @@ -180,6 +192,13 @@ int kvm_arch_vcpu_create(struct kvm_vcpu
> > > *vcpu)
> > >  
> > >  void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
> > >  {
> > > +       /**
> > > +        * vcpu with id 0 is the designated boot cpu.
> > > +        * Keep all vcpus with non-zero cpu id in power-off state
> > > so that they
> > > +        * can brought to online using SBI HSM extension.
> > > +        */
> > > +       if (vcpu->vcpu_idx != 0)
> > > +               kvm_riscv_vcpu_power_off(vcpu);
> > 
> > Why do this in postcreate?
> > 
> 
> Because we need to absolutely sure that the vcpu is created. It is
> cleaner in this way rather than doing this here at the end of
> kvm_arch_vcpu_create. create_vcpu can also fail after
> kvm_arch_vcpu_create returns.

But kvm_riscv_vcpu_power_off() doesn't doesn't anything outside of the vCPU.  It
clears vcpu->arch.power_off, makes a request, and kicks the vCPU.  None of that
has side effects to anything else in KVM.  If the vCPU isn't created successfully,
it gets deleted and nothing ever sees that state change.
