Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C689C3587FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhDHPRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhDHPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:16:58 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AA9C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 08:16:47 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BBED81B0; Thu,  8 Apr 2021 17:16:45 +0200 (CEST)
Date:   Thu, 8 Apr 2021 17:16:44 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Nadav Amit <namit@vmware.com>,
        Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Message-ID: <YG8eXLft4R+Nq+Ip@8bytes.org>
References: <20210323210619.513069-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323210619.513069-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 02:06:19PM -0700, Nadav Amit wrote:
>  drivers/iommu/amd/iommu.c | 76 +++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 34 deletions(-)

Load-testing looks good here too, so this patch is queued now for v5.13,
thanks Nadav.

Regards,

	Joerg
