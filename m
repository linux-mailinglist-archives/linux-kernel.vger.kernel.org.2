Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179603568A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350506AbhDGKDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbhDGKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:01:20 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74DC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 03:01:11 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3C04A2A6; Wed,  7 Apr 2021 12:01:09 +0200 (CEST)
Date:   Wed, 7 Apr 2021 12:01:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Nadav Amit <namit@vmware.com>,
        Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Message-ID: <YG2C42UdIEsWex2L@8bytes.org>
References: <20210323210619.513069-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323210619.513069-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 02:06:19PM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Currently, IOMMU invalidations and device-IOTLB invalidations using
> AMD IOMMU fall back to full address-space invalidation if more than a
> single page need to be flushed.
> 
> Full flushes are especially inefficient when the IOMMU is virtualized by
> a hypervisor, since it requires the hypervisor to synchronize the entire
> address-space.
> 
> AMD IOMMUs allow to provide a mask to perform page-specific
> invalidations for multiple pages that match the address. The mask is
> encoded as part of the address, and the first zero bit in the address
> (in bits [51:12]) indicates the mask size.
> 
> Use this hardware feature to perform selective IOMMU and IOTLB flushes.
> Combine the logic between both for better code reuse.
> 
> The IOMMU invalidations passed a smoke-test. The device IOTLB
> invalidations are untested.

Have you thoroughly tested this on real hardware? I had a patch-set
doing the same many years ago and it lead to data corruption under load.
Back then it could have been a bug in my code of course, but it made me
cautious about using targeted invalidations.

Regards,

	Joerg

