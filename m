Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6A32BDA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452738AbhCCQSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:18:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234416AbhCCLmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:42:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BE0D64EE3;
        Wed,  3 Mar 2021 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614770980;
        bh=X7znKVskg1MlkzK8CLsnoOUCSQ1ohITe7zhHreZVWvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7Px4czelhdxpnQqPohTeAkivJu14CrWiCChoxyi1u+XEAGiMgtLkXZS9u39tk0iC
         l4/9e3Z4DXcJA0j3KX467gCLH+t8DTdunFYUD9ntLfXo5l55Om6BZL6ymwlb51i2iz
         5zH6uKZVR5hWvP1Kw+nLxcrV/+YNwn505/gqmWjqTKerlDBA7YDc9UALsm2h1lyfhw
         zX4n2c5kvLYSWzATKD2Zi+r/6HIXXev+o8tcc8vSVaz+sXZzQUUXXxoE1/NOpvcHj8
         wvoYNa9UeC/HIVOfHJvMsTXGdKb3mx75IkVg8DjaPUCupMuPFzGRPRA1JReXPzPiZd
         Xxk7dmhide6QQ==
Date:   Wed, 3 Mar 2021 11:29:34 +0000
From:   Will Deacon <will@kernel.org>
To:     Jia He <justin.he@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Message-ID: <20210303112934.GA18452@willie-the-truck>
References: <20210303024225.2591-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303024225.2591-1-justin.he@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 10:42:25AM +0800, Jia He wrote:
> If the start addr is not aligned with the granule size of that level.
> loop step size should be adjusted to boundary instead of simple
> kvm_granual_size(level) increment. Otherwise, some mmu entries might miss
> the chance to be walked through.
> E.g. Assume the unmap range [data->addr, data->end] is
> [0xff00ab2000,0xff00cb2000] in level 2 walking and NOT block mapping.
> And the 1st part of that pmd entry is [0xff00ab2000,0xff00c00000]. The
> pmd value is 0x83fbd2c1002 (not valid entry). In this case, data->addr
> should be adjusted to 0xff00c00000 instead of 0xff00cb2000.
> 
> Without this fix, userspace "segment fault" error can be easily
> triggered by running simple gVisor runsc cases on an Ampere Altra
> server:
>     docker run --runtime=runsc -it --rm  ubuntu /bin/bash
> 
> In container:
>     for i in `seq 1 100`;do ls;done
> 
> Reported-by: Howard Zhang <Howard.Zhang@arm.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index bdf8e55ed308..4d99d07c610c 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -225,6 +225,7 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
>  		goto out;
>  
>  	if (!table) {
> +		data->addr = ALIGN_DOWN(data->addr, kvm_granule_size(level));
>  		data->addr += kvm_granule_size(level);

Can you replace both of these lines with:

	data->addr = ALIGN(data->addr, kvm_granule_size(level));

instead?

Will
