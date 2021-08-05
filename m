Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DBE3E13BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbhHELVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240797AbhHELVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:21:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 514BA60E52;
        Thu,  5 Aug 2021 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628162479;
        bh=VFjPtC9UhoM5gV86KddMtIiMoUfeT0FE4dm7xQ3W6Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MG0aCq2J0TAoC4bp0QExr9x8nHi3ql8ui5whAPq7792IAnLdi7gSysxE6TMaT6Vjc
         CobHs41s8ZGRZgRFlwEzqxtjqyrimdIFgde5Ir4GX/6KAgLbV1n7YCtfpBU3arbOry
         Ulq3puR70zHNAwVQXxOMuWh/SBagtDDSid7BOav1SvK54ArCtJvuG4Jx+og+oiYWxb
         7vzVlx+cpM+VDVpLidQcgiTTj9lllSlrafW6UJMhB/iaV3il7HMO0esb3c43RLFuhv
         nIETmcSfEzAJESa4I7JAwy5pe7otuCqY4p5wZDfZ5MezC79T/QSBOOq8IAf4njOP+w
         qrfPLNDU1J26w==
Date:   Thu, 5 Aug 2021 12:21:14 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
Message-ID: <20210805112114.GA1029@willie-the-truck>
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <bebc7b1b-e60c-d5e6-812a-63580d7029cc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bebc7b1b-e60c-d5e6-812a-63580d7029cc@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:22:15AM +0100, John Garry wrote:
> On 21/06/2021 17:36, John Garry wrote:
> > Members of struct "llq" will be zero-inited, apart from member max_n_shift.
> > But we write llq.val straight after the init, so it was pointless to zero
> > init those other members. As such, separately init member max_n_shift
> > only.
> > 
> > In addition, struct "head" is initialised to "llq" only so that member
> > max_n_shift is set. But that member is never referenced for "head", so
> > remove any init there.
> > 
> > Removing these initializations is seen as a small performance optimisation,
> > as this code is (very) hot path.
> > 
> 
> Hi Will,
> 
> Any chance you can pick up this small optimisation?

Yup! I've actually queued it locally, but I may end up asking Joerg to take
it directly depending on what else I queue for 5.15. So far, most of the
SMMU stuff is all part of wider refactorings.

Cheers,

Will
