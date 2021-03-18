Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5723408F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhCRPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:32:03 -0400
Received: from 8bytes.org ([81.169.241.247]:59756 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhCRPbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:31:37 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8050E2DA; Thu, 18 Mar 2021 16:31:34 +0100 (CET)
Date:   Thu, 18 Mar 2021 16:31:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, Wei.Huang2@amd.com
Subject: Re: [RFC PATCH 5/7] iommu/amd: Add support for Guest IO protection
Message-ID: <YFNyUZg0JAgBLWwX@8bytes.org>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
 <20210312090411.6030-6-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312090411.6030-6-suravee.suthikulpanit@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:04:09AM -0600, Suravee Suthikulpanit wrote:
> @@ -519,6 +521,7 @@ struct protection_domain {
>  	spinlock_t lock;	/* mostly used to lock the page table*/
>  	u16 id;			/* the domain id written to the device table */
>  	int glx;		/* Number of levels for GCR3 table */
> +	bool giov;		/* guest IO protection domain */

Could this be turned into a flag?

Regards,

	Joerg
