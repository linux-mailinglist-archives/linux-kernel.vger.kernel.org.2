Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703A335848D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhDHNYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:24:04 -0400
Received: from 8bytes.org ([81.169.241.247]:34042 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhDHNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:24:03 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2DE0D418; Thu,  8 Apr 2021 15:23:51 +0200 (CEST)
Date:   Thu, 8 Apr 2021 15:23:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Message-ID: <YG8D5ZjSxZm6tF9v@8bytes.org>
References: <20210323210619.513069-1-namit@vmware.com>
 <YG2C42UdIEsWex2L@8bytes.org>
 <71C74038-943D-4041-B6FF-09A8C40CA204@vmware.com>
 <YG6uWFAS6GCWJPGO@8bytes.org>
 <80A4A5F2-5D8C-4F8D-BF7B-CFFF4F770F57@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80A4A5F2-5D8C-4F8D-BF7B-CFFF4F770F57@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:29:25AM +0000, Nadav Amit wrote:
> In the version that you referred me to, iommu_update_domain_tlb() only
> regards the size of the region to be flushed and disregards the
> alignment:
> 
> +	order   = get_order(domain->flush.end - domain->flush.start);
> +	mask    = (0x1000ULL << order) - 1;
> +	address = ((domain->flush.start & ~mask) | (mask >> 1)) & ~0xfffULL;
> 
> 
> If you need to flush for instance the region between 0x1000-0x5000, this
> version would use the address|mask of 0x1000 (16KB page). The version I
> sent regards the alignment, and since the range is not aligned would use
> address|mask of 0x3000 (32KB page).
> 
> IIUC, IOVA allocations today are aligned in such way, but at least in
> the past (looking on 3.19 for the matter), it was not like always like
> that, which can explain the problems.

Yeah, that make sense and explains the data corruption problems. I will
give your patch a try on one of my test machines and consider it for
v5.13 if all goes well.

Thanks,

	Joerg
