Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B493408E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhCRP2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhCRP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:28:15 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EFDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:28:15 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 52FFE2DA; Thu, 18 Mar 2021 16:28:12 +0100 (CET)
Date:   Thu, 18 Mar 2021 16:28:10 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, Wei.Huang2@amd.com
Subject: Re: [RFC PATCH 4/7] iommu/amd: Initial support for AMD IOMMU v2 page
 table
Message-ID: <YFNxiiU9jc0+/oU9@8bytes.org>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
 <20210312090411.6030-5-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312090411.6030-5-suravee.suthikulpanit@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Fri, Mar 12, 2021 at 03:04:08AM -0600, Suravee Suthikulpanit wrote:
> @@ -503,6 +504,7 @@ struct amd_io_pgtable {
>  	int			mode;
>  	u64			*root;
>  	atomic64_t		pt_root;    /* pgtable root and pgtable mode */
> +	struct mm_struct	v2_mm;
>  };

A whole mm_struct is a bit too much when all we really need is an 8-byte
page-table root pointer.


> +static pte_t *fetch_pte(struct amd_io_pgtable *pgtable,
> +		      unsigned long iova,
> +		      unsigned long *page_size)
> +{
> +	int level;
> +	pte_t *ptep;
> +
> +	ptep = lookup_address_in_mm(&pgtable->v2_mm, iova, &level);
> +	if (!ptep || pte_none(*ptep) || (level == PG_LEVEL_NONE))
> +		return NULL;

So you are re-using the in-kernel page-table building code. That safes
some lines of code, but has several problems:

	1) When you boot a kernel with this code on a machine with
	   5-level paging, the IOMMU code will build a 5-level
	   page-table too, breaking IOMMU mappings.

	2) You need a whole mm_struct per domain, which is big.

	3) The existing macros for CPU page-tables require locking. For
	   IOMMU page-tables this is not really necessary and might
	   cause scalability issues.

Overall I think you should write your own code to build a 4-level
page-table and use cmpxchg64 to avoid the need for locking. Then things
will not break when such a kernel is suddenly booted on a machine which
as 5-level paging enabled.

Regards,

	Joerg

