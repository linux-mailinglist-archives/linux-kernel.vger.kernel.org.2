Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F53D2CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 21:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhGVSx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhGVSx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:53:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6185C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:34:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k14-20020a05600c1c8eb02901f13dd1672aso3079756wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jhYsOx1LWs0cX/jFmHSeQJdM5hC2M39ceQWiy7371d4=;
        b=KTUsRkXf4ffoeh8ZbMqm31lud2SqLwVvOFo7Cl2jnZ4J7pYL55bBrPIbwLHe7pbaIo
         QmdCWIukoUmVQDGqMENWtc6ektd6uNOD0Zx6uv2T51mssBNN+QkOjO2Kf02iUMGrSdFP
         rvHBMP34dGJ4DxuBpgwrmtNKsX0N6bwKa8S1iKjblT/SMsr/37cPbcPC5Qq4d2kyughj
         NRfdclkQgGSeOoeH2m4zQvPUyHu5Ljw7VTnHtEDlEu1QZCJVkS6wsAYhqdUjNad07ELy
         SvHcE1/bVW4/ZNw9ppykjxm++rFPjlt4PDvgUvZj5IpOG2vzz13X2TOIiU7OhY6ONeY1
         Cvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jhYsOx1LWs0cX/jFmHSeQJdM5hC2M39ceQWiy7371d4=;
        b=ML4rLY2tw80osTt6TKpA5FYQozIeiPp+QgnE5RPhxucBMcye5k/HxkmG9d87Fa9f7u
         EvMt/cDcAO+vC9xIz2Xjo7QJOrxcr9aH/MY22mADZ+ELLL2XCBiJUnTNo1aF/TiqnUw+
         nTzXrmtLQCeYHxhs8v5S6T2jZClQ3MkHVdurxkK9mE3A4XLNwkBBLVrhK17s9RHH7uz/
         dJFUzir19JaJsqBDR0CFPlbb6RlqkkiY/5B6gaP14NLkCq6YOWxL/YChMzTViuOFW2HZ
         e2HGcK+fyKBSyINH1x0I4L52seR1lhY+nV9gKExG39n0wANixOqM8E2QeKxUwJo4+aXt
         dX4A==
X-Gm-Message-State: AOAM5319V+Z3NT0FBCyteZpg/FeQ6MbsMBu50JrRLbrWOezaXGoyg/wz
        bA3cmBnJq5/wpAnxQNCn7EqEiA==
X-Google-Smtp-Source: ABdhPJzAV0SGTymmduCOhJtF1fux4J5JcXs5+NUVNCIiqHcjF/y0IV5ZQ7B4UnjMDgV+7PIFPHmd6A==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr1121772wmj.120.1626982440145;
        Thu, 22 Jul 2021 12:34:00 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:f1d2:f5fd:de90:c735])
        by smtp.gmail.com with ESMTPSA id t6sm31102302wru.75.2021.07.22.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 12:33:59 -0700 (PDT)
Date:   Thu, 22 Jul 2021 21:33:52 +0200
From:   Marco Elver <elver@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "Alexandru.Elisei@arm.com" <Alexandru.Elisei@arm.com>,
        Linuxarm <linuxarm@huawei.com>, mark.rutland@arm.com
Subject: Re: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the arm64
 ASID one
Message-ID: <YPnIIAARHNhx9npt@elver.google.com>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-4-shameerali.kolothum.thodi@huawei.com>
 <20210721163138.GD11003@willie-the-truck>
 <f7d708704fb84380af85298a98f7a48c@huawei.com>
 <YPk2XqrOeP6dEtPL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPk2XqrOeP6dEtPL@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 10:11AM +0100, Quentin Perret wrote:
> On Thursday 22 Jul 2021 at 06:45:14 (+0000), Shameerali Kolothum Thodi wrote:
> > > From: Will Deacon [mailto:will@kernel.org]
> > > > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > > index 4b60c0056c04..a02c4877a055 100644
> > > > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > > @@ -106,8 +106,7 @@ int kvm_host_prepare_stage2(void *mem_pgt_pool,
> > > void *dev_pgt_pool)
> > > >  	mmu->pgd_phys = __hyp_pa(host_kvm.pgt.pgd);
> > > >  	mmu->arch = &host_kvm.arch;
> > > >  	mmu->pgt = &host_kvm.pgt;
> > > > -	mmu->vmid.vmid_gen = 0;
> > > > -	mmu->vmid.vmid = 0;
> > > > +	atomic64_set(&mmu->vmid.id, 0);
> > > 
> > > I think this is the first atomic64 use in the EL2 object, which may pull in
> > > some fatal KCSAN instrumentation. Quentin, have you run into this before?
> > > 
> > > Might be simple just to zero-initialise mmu for now, if it isn't already.
> > 
> > I will check that.
> 
> Yes I think what saves us here is that, AFAICT. arm64 doesn't support
> KCSAN yet. But the day it does, this should fail to link (hopefully)
> because of out-of-line calls into e.g. __kasan_check_write().
> 
> So yes, a simple zeroing here is probably preferable.

Note: Do not worry about hypothetically breaking with sanitizers here --
whether it's KASAN or KCSAN, they both instrument atomics. In files that
enable instrumentation but the atomic instrumentation should not be
pulled in, use the arch_ variants, but this doesn't apply here because
instrumentation shouldn't even be on.

The indicator that when KCSAN is supported on arm64, the Makefile here
just needs KCSAN_SANITIZE := n, is that all other instrumentation is
also killed entirely:

  $ grep -E "(PROFILE|SANITIZE|INSTRUMENT)" arch/arm64/kvm/hyp/nvhe/Makefile
  GCOV_PROFILE	:= n
  KASAN_SANITIZE	:= n
  UBSAN_SANITIZE	:= n
  KCOV_INSTRUMENT	:= n

KCSAN isn't supported on arm64 yet, and when it does, I believe Mark's
arm64 KCSAN series should take care of things like this.

Thanks,
-- Marco
