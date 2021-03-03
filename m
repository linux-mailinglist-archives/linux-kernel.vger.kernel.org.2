Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF3632BDB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384831AbhCCQ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:28:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351771AbhCCLuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:50:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B67164EDE;
        Wed,  3 Mar 2021 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614772172;
        bh=Ij+AIShpeMAYkd5iWPOBrQjZXlkiW/5YIu+UuS8glCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foFVp21i4EfsQIt8xvEyoy9aciANAodw7gEORSgUZaZw9WjHCDXEPv2fBv7EBQS9/
         EoVtXyjL7zUZpCeVedc8Rz4n6eLhzkaBD/3UsBf5tI+bQ4x+D9l92frKV579p8fvJF
         ygoLD0BfY0OjGVhYCK3EhYgjypX8Tt0nMSQUy0ChnMNQChVe5F6UNfeuB/EXa/uNej
         VkWCOKhelIUHw6mCRcsc2k01d/i64zJS23cuMbInzMR0vyg4qyu99RuKNP3nd0OZ2U
         DeR/JHSYIFPgrk70zakPbRx3SYLcS0OD/8boKw67k81RZq1ZO5nI/FDzs+E2ASENq7
         7HYOnD8klGLOg==
Date:   Wed, 3 Mar 2021 11:49:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jia He <justin.he@arm.com>, kvmarm@lists.cs.columbia.edu,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Message-ID: <20210303114924.GB18452@willie-the-truck>
References: <20210303024225.2591-1-justin.he@arm.com>
 <87sg5czhny.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg5czhny.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 09:54:25AM +0000, Marc Zyngier wrote:
> Hi Jia,
> 
> On Wed, 03 Mar 2021 02:42:25 +0000,
> Jia He <justin.he@arm.com> wrote:
> > 
> > If the start addr is not aligned with the granule size of that level.
> > loop step size should be adjusted to boundary instead of simple
> > kvm_granual_size(level) increment. Otherwise, some mmu entries might miss
> > the chance to be walked through.
> > E.g. Assume the unmap range [data->addr, data->end] is
> > [0xff00ab2000,0xff00cb2000] in level 2 walking and NOT block mapping.
> 
> When does this occur? Upgrade from page mappings to block? Swap out?
> 
> > And the 1st part of that pmd entry is [0xff00ab2000,0xff00c00000]. The
> > pmd value is 0x83fbd2c1002 (not valid entry). In this case, data->addr
> > should be adjusted to 0xff00c00000 instead of 0xff00cb2000.
> 
> Let me see if I understand this. Assuming 4k pages, the region
> described above spans *two* 2M entries:
> 
> (a) ff00ab2000-ff00c00000, part of ff00a00000-ff00c00000
> (b) ff00c00000-ff00db2000, part of ff00c00000-ff00e00000
> 
> (a) has no valid mapping, but (b) does. Because we fail to correctly
> align on a block boundary when skipping (a), we also skip (b), which
> is then left mapped.
> 
> Did I get it right? If so, yes, this is... annoying.
> 
> Understanding the circumstances this triggers in would be most
> interesting. This current code seems to assume that we get ranges
> aligned to mapping boundaries, but I seem to remember that the old
> code did use the stage2_*_addr_end() helpers to deal with this case.
> 
> Will: I don't think things have changed in that respect, right?

We've maintained stage2_pgd_addr_end() for the top-level iterator, but
it looks like we're failing to do the rounding in __kvm_pgtable_visit()
when hitting a leaf entry, so the caller (__kvm_pgtable_walk()) will
terminate early.

I agree that it's annoying, as you'd have expected us to run into this
earlier on.

Will
