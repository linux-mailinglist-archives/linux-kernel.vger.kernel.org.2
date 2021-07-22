Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A90C3D208C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhGVIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhGVIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:31:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEE3C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:12:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c15so5126924wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NaNS9AMgRmwWpk7IwOuTN+Dqg/nfKEvds147rH9Tsw4=;
        b=ecOgwWM0pxO8mzTAh4/Y9NmnUmrXKIT5LaCzZ6YB70MqSZc0e2QHL4FSMP/Cs70w71
         Ur5QgKQQr5sD1sSbh/MO/Y1K1b3JmBpFyxtSX8JKjxNlzPtdQUIQFCtpPh4MgPMaNI9J
         6U6SnNmQQ2n+xayFQbhYElJ3CYfYnE2pkowTi2ZIsJM7lyiug/9KoE7fly4mp3uddkFW
         GNC496bmEs61CWvpFoFpFZmXdcQMUMP9MqRZYnmhYUG+IWztvLd2Kn3z01attIDw7zl1
         A6jjXrbGH/PXNwY93OuFBHFGKmxWI5l+QIRigCPrc5YLVDdDFo0ziiuYJa7DFXmruZx4
         BEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NaNS9AMgRmwWpk7IwOuTN+Dqg/nfKEvds147rH9Tsw4=;
        b=TIM/OYt0VZ7hlRI+tByVzRTNFPmih0AieV11oZIhKWGb7PNxP8Fn/pkbZlAIAaKYEV
         JF9NNKxFje7oxZuYFnNR72ye6rZcb+I/lSEYLZagbBZiUq9vohEeyvu4C68PXFcavmp5
         aUgvjdpaC082p3NBuQfAKGSc/Typ9+xY5Xt32PTgs8CIon1kfZWB4QgyRwuWNzzgQ/mT
         aJXrBf5ruyKWEfkTc/YtoI8imCkwCUlYWcanPSqNZyK4DOJCCjOt5f8j+EfAfWPIy920
         Sfo0FiXoYDyqflJoluPIeClGKQ+UxN1aQRzQls5m/PRZpsbU8dEyjcWVsBUBtNoZyFyJ
         Ru1w==
X-Gm-Message-State: AOAM531chWcG71NvtE+pnFe/xxtFsujaS0BJ3t9GOQBUzkR1HWC3WINg
        HTACC4sBfwQLOx+Y8hG2s18rAQ==
X-Google-Smtp-Source: ABdhPJyLWiHBnDA36VBmChvvNm3hWvX+VZpa3Rz7wOqMiZ8+/dewGGLnMKuFbyZcmEza8fsTByf6lg==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr28245004wrv.293.1626945121506;
        Thu, 22 Jul 2021 02:12:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:efb1:2fcc:e84:52ad])
        by smtp.gmail.com with ESMTPSA id f26sm24174882wmc.29.2021.07.22.02.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 02:12:01 -0700 (PDT)
Date:   Thu, 22 Jul 2021 10:11:58 +0100
From:   Quentin Perret <qperret@google.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
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
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the arm64
 ASID one
Message-ID: <YPk2XqrOeP6dEtPL@google.com>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-4-shameerali.kolothum.thodi@huawei.com>
 <20210721163138.GD11003@willie-the-truck>
 <f7d708704fb84380af85298a98f7a48c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d708704fb84380af85298a98f7a48c@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 Jul 2021 at 06:45:14 (+0000), Shameerali Kolothum Thodi wrote:
> > From: Will Deacon [mailto:will@kernel.org]
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > index 4b60c0056c04..a02c4877a055 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > @@ -106,8 +106,7 @@ int kvm_host_prepare_stage2(void *mem_pgt_pool,
> > void *dev_pgt_pool)
> > >  	mmu->pgd_phys = __hyp_pa(host_kvm.pgt.pgd);
> > >  	mmu->arch = &host_kvm.arch;
> > >  	mmu->pgt = &host_kvm.pgt;
> > > -	mmu->vmid.vmid_gen = 0;
> > > -	mmu->vmid.vmid = 0;
> > > +	atomic64_set(&mmu->vmid.id, 0);
> > 
> > I think this is the first atomic64 use in the EL2 object, which may pull in
> > some fatal KCSAN instrumentation. Quentin, have you run into this before?
> > 
> > Might be simple just to zero-initialise mmu for now, if it isn't already.
> 
> I will check that.

Yes I think what saves us here is that, AFAICT. arm64 doesn't support
KCSAN yet. But the day it does, this should fail to link (hopefully)
because of out-of-line calls into e.g. __kasan_check_write().

So yes, a simple zeroing here is probably preferable.

Thanks,
Quentin
