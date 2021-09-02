Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7470B3FEA1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243631AbhIBHkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhIBHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:39:59 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CBCC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 00:39:01 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BCABEE4; Thu,  2 Sep 2021 09:38:57 +0200 (CEST)
Date:   Thu, 2 Sep 2021 09:38:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, wei.huang2@amd.com
Subject: Re: [PATCH 0/3] iommu/amd: Fix unable to handle page fault due to
 AVIC
Message-ID: <YTB/jWr9vb6xvTQp@8bytes.org>
References: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
 <f2ec4e5c-3bb1-b703-8842-34357e084bad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ec4e5c-3bb1-b703-8842-34357e084bad@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Tue, Aug 31, 2021 at 12:10:27PM -0500, Suthikulpanit, Suravee wrote:
> Here is an dditional tags for this series:
> 
> Fixes: 8bda0cfbdc1a ("iommu/amd: Detect and initialize guest vAPIC log")
> 
> Are there any concerns with this series?

No concerns, please add the tag and re-post when -rc1 is out. I will it
queue for -rc2 then.

Thanks,

	Joerg

