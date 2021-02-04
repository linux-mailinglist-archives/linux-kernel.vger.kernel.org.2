Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86F130F537
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhBDOl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236850AbhBDOiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:38:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96D7A64F42;
        Thu,  4 Feb 2021 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612449452;
        bh=eX/1xnMdBH58oq4Cm//d2eH7lZEj/ruuIIGGb0auhuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFUg2MhCGRwGCnWckleg2a585Xz+UPVroJoNasl+l4uT0swGpvGoFDX9tZU3lQU8T
         /yrQSfPWtuDwynUHzXjcNMRmcL3Hpe9GUojzRx7oLBzcEMnuf5Fugs46AmSYNirHm0
         GOMjZtv2zt6lmt5JUCXfTx3Ou8ZLooidFTn5ePcH+jLvp6JlcZ/wq3kED3EeiOTmV8
         JEyrlU6Zy1/rze1wxKk2PST5LR1xrcY/gBK6mtU2kGkZssp+m9Yz6Ihgp+3PZWtUtX
         O386OeZwIL5OOsEzKkiZf9BK0SHUN10bysPQh3rGOM9NhwGiYRKNzb5RJWkLPFQzp3
         CLQa41rKVOCfA==
Date:   Thu, 4 Feb 2021 14:37:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 26/26] KVM: arm64: Wrap the host with a stage 2
Message-ID: <20210204143725.GB20815@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-27-qperret@google.com>
 <20210203161146.GJ18974@willie-the-truck>
 <YBwEGx1tv8hob9ho@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBwEGx1tv8hob9ho@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 02:26:35PM +0000, Quentin Perret wrote:
> On Wednesday 03 Feb 2021 at 16:11:47 (+0000), Will Deacon wrote:
> > On Fri, Jan 08, 2021 at 12:15:24PM +0000, Quentin Perret wrote:
> > > When KVM runs in protected nVHE mode, make use of a stage 2 page-table
> > > to give the hypervisor some control over the host memory accesses. At
> > > the moment all memory aborts from the host will be instantly idmapped
> > > RWX at stage 2 in a lazy fashion. Later patches will make use of that
> > > infrastructure to implement access control restrictions to e.g. protect
> > > guest memory from the host.
> > > 
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_cpufeature.h       |   2 +
> > >  arch/arm64/kernel/image-vars.h                |   3 +
> > >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  33 +++
> > >  arch/arm64/kvm/hyp/nvhe/Makefile              |   2 +-
> > >  arch/arm64/kvm/hyp/nvhe/hyp-init.S            |   1 +
> > >  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |   6 +
> > >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 191 ++++++++++++++++++
> > >  arch/arm64/kvm/hyp/nvhe/setup.c               |   6 +
> > >  arch/arm64/kvm/hyp/nvhe/switch.c              |   7 +-
> > >  arch/arm64/kvm/hyp/nvhe/tlb.c                 |   4 +-
> > >  10 files changed, 248 insertions(+), 7 deletions(-)
> > >  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > >  create mode 100644 arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > 
> > [...]
> > 
> > > +void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
> > > +{
> > > +	enum kvm_pgtable_prot prot;
> > > +	u64 far, hpfar, esr, ipa;
> > > +	int ret;
> > > +
> > > +	esr = read_sysreg_el2(SYS_ESR);
> > > +	if (!__get_fault_info(esr, &far, &hpfar))
> > > +		hyp_panic();
> > > +
> > > +	prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W | KVM_PGTABLE_PROT_X;
> > > +	ipa = (hpfar & HPFAR_MASK) << 8;
> > > +	ret = host_stage2_map(ipa, PAGE_SIZE, prot);
> > 
> > Can we try to put down a block mapping if the whole thing falls within
> > memory?
> 
> Yes we can! And in fact we can do that outside of memory too. It's
> queued for v3 already, so stay tuned ... :)

Awesome! The Stage-2 TLB thanks you.

Will
