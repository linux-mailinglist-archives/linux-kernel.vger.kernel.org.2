Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598BD3DDAA0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbhHBORB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:17:01 -0400
Received: from 8bytes.org ([81.169.241.247]:53234 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234708AbhHBONk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:13:40 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E41C83C3; Mon,  2 Aug 2021 16:13:29 +0200 (CEST)
Date:   Mon, 2 Aug 2021 16:13:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>, rizzo.unipi@gmail.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] amd/iommu: fix logic bug in amd_iommu_report_page_fault()
Message-ID: <YQf9h+qvWCx6D7XT@8bytes.org>
References: <20210731192637.3653796-1-lrizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731192637.3653796-1-lrizzo@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 12:26:37PM -0700, Luigi Rizzo wrote:
> amd_iommu_report_page_fault() has two print paths, depending on whether or
> not it can find a pci device. But the code erroneously enters the second
> path if the rate limiter in the first path triggers:
>   if (dev_data && ratelimit(A)) { A; } else if (ratelimit(B)) { B; }
> The correct code should be
>   if (dev_data) { if (ratelimit(A)) { A;} } else if (ratelimit(B)) { B; }
> 
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Thanks, but I queued this patch already:

	https://lore.kernel.org/r/YPgk1dD1gPMhJXgY@wantstofly.org

Regards,

	Joerg

