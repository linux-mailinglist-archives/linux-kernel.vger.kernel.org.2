Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77294332B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhJSJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhJSJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:42:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C6C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:40:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k7so46397732wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+v4Hfkg/w1/B4R5A/ecV7kDZ1+BpxRgtZ9ZYRUTGvYQ=;
        b=SKdRW7siAk731anszKLFJ7LCVf1ZukxuHCQa9UfvTaS+LMfaeSqnc+PdFEyz2b9Vql
         R9n2h4pfsBE+hTtl9Ghcf73/JuT7EvSbvrayRN4ynnOPhQo2YSbaa2uPZt5r4puv5gfK
         GaTMyTPjRRQgvhLvowqAFIDI+9cKrp/IeO9ZAC8t6pdqf4w8t/Q1YC4NIoHvacb0FPms
         Cgm3gUBIOrm4FhPkuzjC6bGgzVMTNnDNWmpEOZz92J1kYF54KTktv+6+qRpIPIOleMfH
         7rW14/k/BiowMiLxGBg2YIKmhi2tV85quWfj9WotO4rPM5TGN+7tWvTBQUosIYMhYK9X
         v8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+v4Hfkg/w1/B4R5A/ecV7kDZ1+BpxRgtZ9ZYRUTGvYQ=;
        b=Oq5ehedJSFXgqqV71DBzuQ/rkmsayz3pPTtlqlrOkZjJPzpRRqSwC/+XzCDBYlORxw
         4HGzVvpiGCGVg4No8QYVoYoSY/4raMpNyLk5h0gZrh7qocWunhqpr9815bvqX7z5LU+p
         U8A1X04X+Oxybkq3kkgh4xNeqbbIuFT9+viCMkWQRuk1uam4w/QQaT6wYg24Xgu9m6m2
         P9BwEodJE1Cw8z7FF8zdluTPbWyujRYDoTrjK2mcPBlFurVAyvBXz0DIpeOTsjyhS2tL
         ckD6YuYhAqgFY5Rk4r+qWMuucBXOZjM9cO8ZYMhSEC87j4FRVkXFjQBdnuvtp9FYElLc
         dfHQ==
X-Gm-Message-State: AOAM531EzRiGDTJt52QQgQ/e+9bFN9rkPCINNbUvw+cU3sDm8sn9fSe2
        XxZNA0I5z+oRZyt2MsVzw5HsbQ==
X-Google-Smtp-Source: ABdhPJy9ly25Wdf1sCClM7a9Zz77DNMQFpedsH5Fh26mLWFifdz5sv78JyKVIUA8hXD5r5R+3vWcpA==
X-Received: by 2002:adf:ec46:: with SMTP id w6mr29994052wrn.240.1634636427307;
        Tue, 19 Oct 2021 02:40:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
        by smtp.gmail.com with ESMTPSA id g33sm1594777wmp.45.2021.10.19.02.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:40:26 -0700 (PDT)
Date:   Tue, 19 Oct 2021 10:40:24 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 16/16] KVM: arm64: pkvm: Unshare guest structs during
 teardown
Message-ID: <YW6SiMLU19YN1ARe@google.com>
References: <20211013155831.943476-1-qperret@google.com>
 <20211013155831.943476-17-qperret@google.com>
 <87h7dhupfa.wl-maz@kernel.org>
 <YW1NLb9Pn9NyEYZF@google.com>
 <YW1+mQ6Bn2HXwl34@google.com>
 <3ec8ab06f9950a13818109051835fdb9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec8ab06f9950a13818109051835fdb9@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 Oct 2021 at 18:12:22 (+0100), Marc Zyngier wrote:
> On 2021-10-18 15:03, Quentin Perret wrote:
> > On Monday 18 Oct 2021 at 11:32:13 (+0100), Quentin Perret wrote:
> > > Another option is to take a refcount on 'current' from
> > > kvm_arch_vcpu_run_map_fp() before sharing thread-specific structs with
> > > the hyp and release the refcount of the previous task after unsharing.
> > > But that means we'll have to also drop the refcount when the vcpu
> > > gets destroyed, as well as explicitly unshare at that point. Shouldn't
> > > be too bad I think. Thoughts?
> > 
> > Something like the below seems to work OK on my setup, including
> > SIGKILL'ing the guest and such. How much do you hate it?
> 
> It is annoyingly elegant! Small nitpick below.
> 
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h
> > b/arch/arm64/include/asm/kvm_host.h
> > index f8be56d5342b..50598d704c71 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -322,6 +322,7 @@ struct kvm_vcpu_arch {
> > 
> >  	struct thread_info *host_thread_info;	/* hyp VA */
> >  	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
> > +	struct task_struct *parent_task;
> > 
> >  	struct {
> >  		/* {Break,watch}point registers */
> > @@ -738,6 +739,7 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
> >  void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
> >  void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
> >  void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
> > +void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu);
> > 
> >  static inline bool kvm_pmu_counter_deferred(struct perf_event_attr
> > *attr)
> >  {
> > diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> > index 2fe1128d9f3d..27afeebbe1cb 100644
> > --- a/arch/arm64/kvm/fpsimd.c
> > +++ b/arch/arm64/kvm/fpsimd.c
> > @@ -15,6 +15,22 @@
> >  #include <asm/kvm_mmu.h>
> >  #include <asm/sysreg.h>
> > 
> > +void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
> > +{
> > +	struct task_struct *p = vcpu->arch.parent_task;
> > +	struct user_fpsimd_state *fpsimd;
> > +	struct thread_info *ti;
> > +
> > +	if (!static_branch_likely(&kvm_protected_mode_initialized) || !p)
> 
> Shouldn't this be a check on is_protected_kvm_enabled() instead?
> The two should be equivalent outside of the initialisation code...

Yup, it'd be nice to do checks on kvm_protected_mode_initialized only
when they're strictly necessary, and that's not the case here. I'll fold
that change in v2.

Cheers
Quentin
