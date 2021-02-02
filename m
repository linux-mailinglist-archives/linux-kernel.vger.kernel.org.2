Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528FF30C0B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhBBOFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:05:41 -0500
Received: from 8bytes.org ([81.169.241.247]:54030 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233507AbhBBN6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:58:37 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 354083D4; Tue,  2 Feb 2021 14:57:52 +0100 (CET)
Date:   Tue, 2 Feb 2021 14:57:50 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        kernel-team@android.com, yong.wu@mediatek.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.12
Message-ID: <20210202135750.GY32671@8bytes.org>
References: <20210201154633.GC15263@willie-the-truck>
 <20210202133456.GT32671@8bytes.org>
 <20210202135339.GC17070@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202135339.GC17070@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 01:53:41PM +0000, Will Deacon wrote:
> On Tue, Feb 02, 2021 at 02:34:56PM +0100, Joerg Roedel wrote:
> > On Mon, Feb 01, 2021 at 03:46:33PM +0000, Will Deacon wrote:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> > 
> > Pulled, thanks Will.
> 
> Cheers, Joerg. Doug spotted a thinko in one of the patches, so you'll want
> to apply this guy on top:
> 
> https://lore.kernel.org/r/20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid

Yes, applied on-top of your pull-request.

Thanks,

	Joerg
