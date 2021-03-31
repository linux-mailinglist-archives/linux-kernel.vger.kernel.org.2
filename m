Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31D034F76C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhCaDYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhCaDY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:24:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279C2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:24:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so520645pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FNFeV1THEx0YJSM2iKHTR5ELuwAnphzmvmgnTdnbeIU=;
        b=mrlwgL3jkCGnWhDPLrfQu3CUgGf6iybj45FrMBrjXLrO5aR7NIKUuW/895SYkIK6fl
         7csDYsdgLASvdzuAAl68UhrzAAPlYRZyUB5akfNTrp88ilPxGquve9zK+YgbOQ5mRybq
         RDbKIkVFyrA7jfmLBSpPAh+2m5pLdWSsQWEGlZU4k3WM2yyOOtZ0AaOKRNU8MAYo2lKQ
         mSjXhbCXanNU6bIFwidSqOACOqLS1z5avSe+o/V6/iIOGV3tgnsXDTCwd8zk1TF+Ghje
         uYYNzo6p4NCr5gK/Izlx1Z44S+eKtCNL1K7AQHLrLiwFomfolR8pOZGj2qVoNSpGRRtW
         ch0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNFeV1THEx0YJSM2iKHTR5ELuwAnphzmvmgnTdnbeIU=;
        b=icuLOx20IwRQpEqDz6WF9R8j8s0jJIlXmx8DMoIv1StNpPz7fMpr1ceEDKNqER0Qjg
         kcWvOj78LvI46rC6EfEaqmdMG8eU1Vt7SOhU6ERNTquHlEsUR0NBqWSTyUQLmVevLH3C
         kqHkQNElerjbLLgXaA9z4YWk436VQgCe9rrEr8obyqqBiLIPBuyOuYb0Lp2qr+VHWf7d
         sQOsJOt60xiXgzPLrfDKZvg0s4xN/TfkvtAvYtRnUKEyfLwVKLz26XVvSM4ZfONNK3kw
         1OarKUggKg6JNfnm8uqzei/c/yqGf+EQFS7AvCtBDgpjwBxfCN4IM0fGElyQOLkRCNjM
         hh/w==
X-Gm-Message-State: AOAM532oAyb6KuOl0pJJ3iEGWS6ScUm79m24aUfrsKY90HEEB0v5IfHd
        1AlkXUzNl12EkwnuyVQB+gjEcQ==
X-Google-Smtp-Source: ABdhPJxnlLYH5Pd7r9Rg8gEW16dEzCmgMC7on9vPpf5djZTjGIukA0F8F9/86jVHj91rbgJ8ZqMc8A==
X-Received: by 2002:a17:90a:5889:: with SMTP id j9mr1452688pji.69.1617161067504;
        Tue, 30 Mar 2021 20:24:27 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w22sm383359pfi.133.2021.03.30.20.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:24:26 -0700 (PDT)
Date:   Wed, 31 Mar 2021 03:24:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] KVM: Account memory allocations for 'struct kvm_vcpu'
Message-ID: <YGPrZyIutYQGldO2@google.com>
References: <20210331023025.2485960-1-seanjc@google.com>
 <20210331023025.2485960-2-seanjc@google.com>
 <CANRm+CwowrYPSnFNc11j5aT2JNw_k+NOh1apoxc3raVD4RVaAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CwowrYPSnFNc11j5aT2JNw_k+NOh1apoxc3raVD4RVaAg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021, Wanpeng Li wrote:
> On Wed, 31 Mar 2021 at 10:32, Sean Christopherson <seanjc@google.com> wrote:
> >
> > Use GFP_KERNEL_ACCOUNT for the vCPU allocations, the vCPUs are very much
> > tied to a single task/VM.  For x86, the allocations were accounted up
> > until the allocation code was moved to common KVM.  For all other
> > architectures, vCPU allocations were never previously accounted, but only
> > because most architectures lack accounting in general (for KVM).
> >
> > Fixes: e529ef66e6b5 ("KVM: Move vcpu alloc and init invocation to common code")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  virt/kvm/kvm_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 383df23514b9..3884e9f30251 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -3182,7 +3182,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
> >         if (r)
> >                 goto vcpu_decrement;
> >
> > -       vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
> > +       vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
> 
> kvm_vcpu_cache is created with SLAB_ACCOUNT flag in kvm_init(), this
> flag will guarantee further slab alloc will be charged to memcg.
> Please refer to memcg_slab_pre_alloc_hook(). So the patch is
> unnecessary.

Hmm, I missed that.  However, AFICT only SLAB/SLUB enforce SLAB_ACCOUNT, SLOB
does not appear to honor the flag.   The caveat to SLOB is that the
GFP_KERNEL_ACCOUNT will only come into play when allocating new pages, and so
allocations smaller than a page will be accounted incorrectly (I think).
But, a vcpu is larger than a page (on x86), which means the vcpu allocation will
always be correctly accounted.

I've no idea if anyone actually uses KVM+SLOB, let alone cares about accounting
in the that case.  But, it would be nice for KVM to be consistent with the other
kmem_cache usage in KVM, all of which do double up on SLAB_ACCOUNT +
GFP_KERNEL_ACCOUNT.

Maybe rewrite the changelog and drop the Fixes?
