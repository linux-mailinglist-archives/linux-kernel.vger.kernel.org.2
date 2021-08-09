Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CD53E4802
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhHIOyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhHIOyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:54:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1060361019;
        Mon,  9 Aug 2021 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520865;
        bh=bmXVwPlv6jk+hRMVAM5D4Cs70KB/HmWxl8NzlqT1h3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7uTiTy2Kf1c07ZG3hdoJ0Z0CAd7XAPl8BYfYNci13TAph9dskWb7jRojZJIntqy0
         Z5TLF+8ycGekFWW2v+N94vRD3YKFQkQAWZc9PsE2q4D+uJsXpTQL6LQk1iS+yn2U6p
         8awKSOLddbyn7XQ3tCY5bqnVPkJIdkv7DE97jO1qJP/EY6E8rEyWfLhp+k9B6cgdQ4
         mgvkx/fnD/U32LrnmYk6XDiYt6z5v7N/Qzkp3hBvMw0+m4LZ9uEGD9Ypj553UiVlU+
         xY1Ik/3nNsdT7bs14C5m1wF3tXjF3bCgTpB/4hnVAEg3TXDHF4aMEKzroKESa84wSz
         LoNspFqPTrubw==
Date:   Mon, 9 Aug 2021 15:54:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ashish Mhetre <amhetre@nvidia.com>, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch V2 0/2] iommu/arm-smmu: Fix races in iommu domain/group
 creation
Message-ID: <20210809145420.GB1458@willie-the-truck>
References: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
 <20210802151607.GF28735@willie-the-truck>
 <9c38c53c-c145-097a-4c7e-40f1c06a1f01@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c38c53c-c145-097a-4c7e-40f1c06a1f01@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 04:46:37PM +0100, Robin Murphy wrote:
> On 2021-08-02 16:16, Will Deacon wrote:
> > On Fri, Jun 18, 2021 at 02:00:35AM +0530, Ashish Mhetre wrote:
> > > Multiple iommu domains and iommu groups are getting created for the devices
> > > sharing same SID. It is expected for devices sharing same SID to be in same
> > > iommu group and same iommu domain.
> > > This is leading to context faults when one device is accessing IOVA from
> > > other device which shouldn't be the case for devices sharing same SID.
> > > Fix this by protecting iommu domain and iommu group creation with mutexes.
> > 
> > Robin -- any chance you could take a look at these, please? You had some
> > comments on the first version which convinced me that they are needed,
> > but I couldn't tell whether you wanted to solve this a different way or not.
> 
> Sorry, I was lamenting that this came to light due to the
> of_iommu_configure() flow being yucky, but that wasn't meant to imply that
> there aren't - or couldn't be in future - better reasons for
> iommu_probe_device() to be robust against concurrency anyway. I do think
> these are legitimate fixes to make in their own right, even if the current
> need might get swept back under the rug in future.
> 
> I would say, however, that the commit messages seem to focus too much on the
> wrong details and aren't overly useful, and patch #2 is missing Ashish's
> sign-off.

Ashish -- please can you send a v3 fixing these issues?

Will
