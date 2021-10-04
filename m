Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D73420A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhJDLdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232978AbhJDLdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:33:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 389166126A;
        Mon,  4 Oct 2021 11:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633347087;
        bh=9eIlIsfHP4knhIwYLjRza2zeq4D4+bTC9yyALw6VTm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhFX7IxCrBvKVHXdciM4UfP5k4cacZRr1l06EUPGJXrcOuYunFNiT4xMiLyuZCT42
         KDxOue4JEnyYteWXJmd0fWgHOj9NdG+vEp/JiJn9DVWVmvSQf+gEnpGN8TdRwYmEtZ
         K/Gw5H5WxgrKuM1LBoIj8H/j+0alUyW4rbigV0ZMFx+s66MgILJQ/bT9xf7oeItxeh
         81Ix7t4dclBKnzEmOPGgs+HZT6BHPhVefzfHy+Q+JuobaPA/wy2AiRq7o8EyE2YYiD
         0RDRy2AA046P+g1nby14u6nUPJSMLI2ovH/0SnWjPj8nxB1hsPIpW33g7nChVl2zWA
         p6lOfMXB3P2wQ==
Date:   Mon, 4 Oct 2021 12:31:21 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, mst@redhat.com, jasowang@redhat.com,
        robin.murphy@arm.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH 1/5] iova: Move fast alloc size roundup into
 alloc_iova_fast()
Message-ID: <20211004113121.GA27373@willie-the-truck>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632477717-5254-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:01:53PM +0800, John Garry wrote:
> It really is a property of the IOVA rcache code that we need to alloc a
> power-of-2 size, so relocate the functionality to resize into
> alloc_iova_fast(), rather than the callsites.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/dma-iommu.c            | 8 --------
>  drivers/iommu/iova.c                 | 9 +++++++++
>  drivers/vdpa/vdpa_user/iova_domain.c | 8 --------
>  3 files changed, 9 insertions(+), 16 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
