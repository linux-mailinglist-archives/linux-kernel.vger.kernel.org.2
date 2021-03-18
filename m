Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F813402DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhCRKKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhCRKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:10:10 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA80C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:10:10 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 290A94B4; Thu, 18 Mar 2021 11:10:09 +0100 (CET)
Date:   Thu, 18 Mar 2021 11:10:07 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, ashok.raj@intel.com,
        kevin.tian@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Don't set then immediately clear in
 prq_event_thread()
Message-ID: <YFMm/+JMfySWPzZR@8bytes.org>
References: <20210309004641.3809653-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309004641.3809653-1-baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Tue, Mar 09, 2021 at 08:46:41AM +0800, Lu Baolu wrote:
> The private data field of a page group response descriptor is set then
> immediately cleared in prq_event_thread(). Fix this by moving clearing
> code up.
> 
> Fixes: 5b438f4ba315d ("iommu/vt-d: Support page request in scalable mode")
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Does this fix an actual bug? If so, please state it in the commit
message and also fix the subject line to state what is set/cleared.

Thanks,

	Joerg
