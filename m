Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E3E3F0369
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhHRMJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:09:20 -0400
Received: from 8bytes.org ([81.169.241.247]:36546 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236871AbhHRMJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:09:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8548A24A; Wed, 18 Aug 2021 14:08:28 +0200 (CEST)
Date:   Wed, 18 Aug 2021 14:08:25 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.15
Message-ID: <YRz4OemrkIcDxCC5@8bytes.org>
References: <20210813164735.GA8765@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813164735.GA8765@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 05:47:35PM +0100, Will Deacon wrote:
> This applies cleanly against iommu/next, but I suspect it will conflict
> with Robin's series on the list. Please shout if you need anything from
> me to help with that (e.g. rebase, checking a merge conflict).

For now there were at least no conflicts which git couldn't resolve
automatically, but the compile tests are still running :)

> The following changes since commit ff1176468d368232b684f75e82563369208bc371:
> 
>   Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

So this is pulled now, thanks.

