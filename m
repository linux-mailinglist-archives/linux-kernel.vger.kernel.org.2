Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E3368467
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbhDVQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235232AbhDVQJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:09:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E18061264;
        Thu, 22 Apr 2021 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619107733;
        bh=zCpRP7eiDwk7J8veDKd9XKtUDSNQOgGDnmNG35QL+Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqN9argi4yFTb1QYEVp71kycCBk55wJ1iYpZTt73yRuzobDNGFlik9GxTjTjG7/Xb
         Zvd3Y65A8V+nZV8ZccvGA90pIUuKjs9yYe/NjA5os5L6bC4B65CylaDUHgQEK3NsSH
         h9b160ntxo+E3k33+Q65MstpCh519ZEhYG7kp31ky2mZPpg7rpBrf9Y2+giUMmbPxY
         jm2RqxlYbzw0pZK77FvGzVkA+NBJnT2FGflH+qWDmEdN/xUpHzCWAVs+Jv1diTMN8u
         UUDSJpdtLU0KkcT4IOHrS542kOBRk2ItZxiwlePPhluX321woy/s91AQck9qftDHkk
         NQbfEoRgsHrUQ==
Date:   Thu, 22 Apr 2021 17:08:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        jean-philippe@linaro.org, julien@xen.org, linuxarm@huawei.com
Subject: Re: [PATCH v4 00/16] kvm/arm: Align the VMID allocation with the
 arm64 ASID one
Message-ID: <20210422160846.GB2214@willie-the-truck>
References: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:22:56PM +0100, Shameer Kolothum wrote:
> Hi,
> 
> This is an attempt to revive this series originally posted by
> Julien Grall[1]. The main motive to work on this now is because
> of the requirement to have Pinned KVM VMIDs and the RFC discussion
> for the same basically suggested[2] to have a common/better vmid
> allocator for KVM which this series provides.
>  
> Major Changes from v3:
> 
> -Changes related to Pinned ASID support.
> -Changes to take care KPTI related bits reservation.
> -Dropped support for 32 bit KVM.
> -Rebase to 5.12-rc7
> 
> Individual patches have change history for any major changes
> from v3.
> 
> Tests were performed on a HiSilicon D06 platform and so far not observed
> any regressions.
> 
> For ASID allocation,
> 
> Avg of 10 runs(hackbench -s 512 -l 200 -g 300 -f 25 -P),
> 5.12-rc7: Time:18.8119
> 5.12-rc7+v4: Time: 18.459
> 
> ~1.8% improvement.
> 
> For KVM VMID,
> 
> The measurement was made with maxcpus set to 8 and with the
> number of VMID limited to 4-bit. The test involves running
> concurrently 40 guests with 2 vCPUs. Each guest will then
> execute hackbench 5 times before exiting.
> 
> The performance difference between the current algo and the
> new one are(ag. of 10 runs):
>     - 1.9% less exit from the guest
>     - 0.7% faster
> 
> For complete series, please see,
>  https://github.com/hisilicon/kernel-dev/tree/private-v5.12-rc7-asid-v4
> 
> Please take a look and let me know your feedback.

Although I think aligning the two algorithms makes sense, I'm not completely
sold on the need to abstract all this into a library and whether the
additional indirection is justified.

It would be great to compare this approach with one where portions of the
code are duplicated into a separate VMID allocator. Have you tried that to
see what it looks like? Doesn't need to be a proper patch set, but comparing
the end result might help to evaluate the proposal here.

Will
