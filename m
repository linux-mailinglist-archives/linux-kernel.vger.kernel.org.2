Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF2420A47
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhJDLqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJDLqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:46:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF52361360;
        Mon,  4 Oct 2021 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633347863;
        bh=mQRvQ3f408AEkWZq+4V4qIbeNN7Z/LBzAzfPMOSXCA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdPqz8NgYpjdUX+B1Ny6xDGh7zzNANIXH7XUdlxCGRwgl+PTCAK3SdPPjyqc6wO3T
         1H68ZLVZlseYCQBzr8vVzrunQsjJ1v9E0bKjOQY1IAmjWFa6KruOcNHjv7OTKHt2TU
         1gk3/B0SxIW5uDlMt3EXEA6PsNf9V3a29ojU4UqI6E773Q5+DYyZmKUnVKHCQkiSpY
         Md9LoC1M+gmmBm5r+XfZ5uLTbCsMIeUU/Q8QU7ts3rESzt2SB+wo3W8PtU1lzHG7yt
         Nw9Qovt/LahYFO84PBclT04b3wSKuyenDETSx2eTbNjERsgXPmgenGFtnzeuwvG+LF
         PWS+f+GQHmE+A==
Date:   Mon, 4 Oct 2021 12:44:18 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, mst@redhat.com, jasowang@redhat.com,
        robin.murphy@arm.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH 0/5] iommu: Some IOVA code reorganisation
Message-ID: <20211004114418.GC27373@willie-the-truck>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:01:52PM +0800, John Garry wrote:
> The IOVA domain structure is a bit overloaded, holding:
> - IOVA tree management
> - FQ control
> - IOVA rcache memories
> 
> Indeed only a couple of IOVA users use the rcache, and only dma-iommu.c
> uses the FQ feature.
> 
> This series separates out that structure. In addition, it moves the FQ
> code into dma-iommu.c . This is not strictly necessary, but it does make
> it easier for the FQ domain lookup the rcache domain.
> 
> The rcache code stays where it is, as it may be reworked in future, so
> there is not much point in relocating and then discarding.
> 
> This topic was initially discussed and suggested (I think) by Robin here:
> https://lore.kernel.org/linux-iommu/1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com/

It would be useful to have Robin's Ack on patches 2-4. The implementation
looks straightforward to me, but the thread above isn't very clear about
what is being suggested.

To play devil's advocate: there aren't many direct users of the iovad code:
either they'll die out entirely (and everybody will use the dma-iommu code)
and it's fine having the flush queue code where it is, or we'll get more
users and the likelihood of somebody else wanting flush queues increases.

Will
