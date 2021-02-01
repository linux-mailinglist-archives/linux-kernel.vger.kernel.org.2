Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0F630AFA2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhBASlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhBASk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:40:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDE4B64EA2;
        Mon,  1 Feb 2021 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612204786;
        bh=RWCEVvMfMr07Mj0Dm990NJYMdt/tnBLc1r3RkW1LOpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sv7mWTQjdOhFcDIMCbW1iFI0zjx5NhutKWWEwARZFwdSFhjVgHc9Uom5VsUoIPSbv
         bbsxnuSIKgBN1r5PdCf0vCJDRfzwhL89aJH52aldgfb3hZjzPRWkZ8XSif8y25PBLn
         OMrHbjZNJSHYSr7y8V3yg6VYCfSgtZSGUtCDFOohMW1atWBUdSRHmjlVw/zDPjdllJ
         S/Iv5U4ieWYllL8w/npt5/62CWCqdJZMDNdtRLuPjdlD47xFGt0PXJR6oBoi6dPegC
         Ox9HxzXwXkB506lhN2unGnFjmaoQhkXP8X5+IGSaS7Yvs3mI8o7KYXXNw9zYFCyREZ
         YeC5KviL9q0gA==
Date:   Mon, 1 Feb 2021 18:39:40 +0000
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
Subject: Re: [RFC PATCH v2 06/26] KVM: arm64: Factor memory allocation out of
 pgtable.c
Message-ID: <20210201183940.GF15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-7-qperret@google.com>
 <20210201181607.GD15632@willie-the-truck>
 <YBhJVPz124QRAYFf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBhJVPz124QRAYFf@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 06:32:52PM +0000, Quentin Perret wrote:
> On Monday 01 Feb 2021 at 18:16:08 (+0000), Will Deacon wrote:
> > On Fri, Jan 08, 2021 at 12:15:04PM +0000, Quentin Perret wrote:
> > > +static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
> > > +	.zalloc_page		= stage2_memcache_alloc_page,
> > > +	.zalloc_pages_exact	= kvm_host_zalloc_pages_exact,
> > > +	.free_pages_exact	= free_pages_exact,
> > > +	.get_page		= kvm_host_get_page,
> > > +	.put_page		= kvm_host_put_page,
> > > +	.page_count		= kvm_host_page_count,
> > > +	.phys_to_virt		= kvm_host_va,
> > > +	.virt_to_phys		= kvm_host_pa,
> > > +};
> > 
> > Idle thought, but I wonder whether it would be better to have these
> > implementations as the default and make the mm_ops structure parameter
> > to kvm_pgtable_stage2_init() optional? I guess you don't gain an awful
> > lot though, so feel free to ignore me.
> 
> No strong opinion really, but I suppose I could do something as simple
> as having static inline wrappers which provide kvm_s2_mm_ops to the
> pgtable API for me. I'll probably want to make sure these are not
> defined when compiling EL2 code, though, to avoid confusion.
> 
> Or maybe you had something else in mind?

No, just food for thought. If we can reduce the changes for normal KVM then
it's probably worth considering if it doesn't add divergent code paths. But
I'm also fine with the proposal you have here, so if it doesn't work then
don't get hung up on it.

Will
