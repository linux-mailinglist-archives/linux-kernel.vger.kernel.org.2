Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4048832CF7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhCDJRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235794AbhCDJRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:17:08 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BE264EBB;
        Thu,  4 Mar 2021 09:16:27 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lHk5p-00HDh3-Hy; Thu, 04 Mar 2021 09:16:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Mar 2021 09:16:25 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Justin He <Justin.He@arm.com>
Cc:     Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        James Morse <James.Morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
In-Reply-To: <AM6PR08MB437695640C272E4F065A8B2DF7979@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210303024225.2591-1-justin.he@arm.com>
 <20210303112934.GA18452@willie-the-truck> <87mtvkys1y.wl-maz@kernel.org>
 <20210303211325.GA20055@willie-the-truck>
 <AM6PR08MB437695640C272E4F065A8B2DF7979@AM6PR08MB4376.eurprd08.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5bd4fa0b0590e548288b8f6dc3659ea5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Justin.He@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu, James.Morse@arm.com, julien.thierry.kdev@gmail.com, Suzuki.Poulose@arm.com, Catalin.Marinas@arm.com, gshan@redhat.com, wangyanan55@huawei.com, qperret@google.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-04 00:46, Justin He wrote:
> Hi Marc
> 
>> -----Original Message-----
>> From: Will Deacon <will@kernel.org>
>> Sent: Thursday, March 4, 2021 5:13 AM
>> To: Marc Zyngier <maz@kernel.org>
>> Cc: Justin He <Justin.He@arm.com>; kvmarm@lists.cs.columbia.edu; James
>> Morse <James.Morse@arm.com>; Julien Thierry 
>> <julien.thierry.kdev@gmail.com>;
>> Suzuki Poulose <Suzuki.Poulose@arm.com>; Catalin Marinas
>> <Catalin.Marinas@arm.com>; Gavin Shan <gshan@redhat.com>; Yanan Wang
>> <wangyanan55@huawei.com>; Quentin Perret <qperret@google.com>; 
>> linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu 
>> walking
>> 
>> On Wed, Mar 03, 2021 at 07:07:37PM +0000, Marc Zyngier wrote:
>> > From e0524b41a71e0f17d6dc8f197e421e677d584e72 Mon Sep 17 00:00:00 2001
>> > From: Jia He <justin.he@arm.com>
>> > Date: Wed, 3 Mar 2021 10:42:25 +0800
>> > Subject: [PATCH] KVM: arm64: Fix range alignment when walking page tables
>> >
>> > When walking the page tables at a given level, and if the start
>> > address for the range isn't aligned for that level, we propagate
>> > the misalignment on each iteration at that level.
>> >
>> > This results in the walker ignoring a number of entries (depending
>> > on the original misalignment) on each subsequent iteration.
>> >
>> > Properly aligning the address at the before the next iteration
>> 
>> "at the before the next" ???
>> 
>> > addresses the issue.
>> >
>> > Cc: stable@vger.kernel.org
>> > Reported-by: Howard Zhang <Howard.Zhang@arm.com>
>> > Signed-off-by: Jia He <justin.he@arm.com>
>> > Fixes: b1e57de62cfb ("KVM: arm64: Add stand-alone page-table walker
>> infrastructure")
>> > [maz: rewrite commit message]
>> > Signed-off-by: Marc Zyngier <maz@kernel.org>
>> > Link: https://lore.kernel.org/r/20210303024225.2591-1-justin.he@arm.com
>> > ---
>> >  arch/arm64/kvm/hyp/pgtable.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> > index 4d177ce1d536..124cd2f93020 100644
>> > --- a/arch/arm64/kvm/hyp/pgtable.c
>> > +++ b/arch/arm64/kvm/hyp/pgtable.c
>> > @@ -223,7 +223,7 @@ static inline int __kvm_pgtable_visit(struct
>> kvm_pgtable_walk_data *data,
>> >  		goto out;
>> >
>> >  	if (!table) {
>> > -		data->addr += kvm_granule_size(level);
>> > +		data->addr = ALIGN(data->addr, kvm_granule_size(level));
> 
> What if previous data->addr is already aligned with 
> kvm_granule_size(level)?
> Hence a deadloop? Am I missing anything else?

Indeed, well spotted. I'll revert to your original suggestion
if everybody agrees...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
