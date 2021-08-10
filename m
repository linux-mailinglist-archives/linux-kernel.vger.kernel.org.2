Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7943E8310
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhHJSf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhHJSf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:35:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF91760E09;
        Tue, 10 Aug 2021 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628620535;
        bh=Ml4HBc7HBEfIexLPEgG1MMBsjGmO0+Y5qNWSj4KGzcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkm7yW6lRJB1FQ0aqqeK2ZiM9DHp0v0a+I3UCVNwRGRgumFxs5ZJ41y5ITGoJoYYU
         ORX371bNKwo7fiLCD7okXzruLK1VEsPaRqGsbxyPPE3/Wgx07zl9jrGOgCowLRaOcB
         fG69V3faVO8F0/ckJcWahrUUabRtq+9H9c2G8RwfBRK9scyh3EPKy1jbCl/MwhxsXo
         /iAlwvz8CeBe/H+L8RGbcrQgEfJGaQb2O/RYx5R4QgccUBOef5L4kFjN80dH9VC3py
         GozgiFgdNYptBv0yYqMZCkdLB++GBeT2xSsu/R9ONnnA/wbiN/1pKvVdqKj8nEtyAo
         kvYvruxP76MWQ==
Date:   Tue, 10 Aug 2021 19:35:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/8] iommu/arm-smmu-v3: add support for ECMDQ
 register mode
Message-ID: <20210810183529.GC3296@willie-the-truck>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626110130.2416-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 07:01:22PM +0800, Zhen Lei wrote:
> SMMU v3.3 added a new feature, which is Enhanced Command queue interface
> for reducing contention when submitting Commands to the SMMU, in this
> patch set, ECMDQ is the abbreviation of Enhanced Command Queue.
> 
> When the hardware supports ECMDQ and each core can exclusively use one ECMDQ,
> each core does not need to compete with other cores when using its own ECMDQ.
> This means that each core can insert commands in parallel. If each ECMDQ can
> execute commands in parallel, the overall performance may be better. However,
> our hardware currently does not support multiple ECMDQ execute commands in
> parallel.
> 
> In order to reuse existing code, I originally still call arm_smmu_cmdq_issue_cmdlist()
> to insert commands. Even so, however, there was a performance improvement of nearly 12%
> in strict mode.
> 
> The test environment is the EMU, which simulates the connection of the 200 Gbit/s NIC.
> Number of queues:    passthrough   lazy   strict(ECMDQ)  strict(CMDQ)
>       6                  188        180       162           145        --> 11.7% improvement
>       8                  188        188       184           183        --> 0.55% improvement

Sorry, I don't quite follow the numbers here. Why does the number of queues
affect the classic "CMDQ" mode? We only have one queue there, right?

> In recent days, I implemented a new function without competition with other
> cores to replace arm_smmu_cmdq_issue_cmdlist() when a core can have an ECMDQ.
> I'm guessing it might get better performance results. Because the EMU is too
> slow, it will take a while before the relevant data is available.

I'd certainly prefer to wait until we have something we know is
representative. However, I can take the first four prep patches now if you
respin the second one. At least that's then less for you to carry.

I'd also like review from the Arm side on this (and thank you for adopting
the architecture unlike others seem to have done judging by the patches
floating around).

Will
