Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647E834666B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCWRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhCWRbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:31:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBECC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=A2jfbE86gmwbDsty01sEM1uPP2
        p5EQ+agBKw+qhZhVcZ12QwNZ9MWVwRWuFXo9CRwUqmAFh+W/ZqjxBZ+ufmx0n7dDIQ8/m2m+nEyjL
        1Qlenw9wmEqU1Nviz60Wlak5hPbJLaDpzfYazZJufS19xrAR/w2vzgwNmHwKgl5WEXRw+pcMana3N
        7FTIQM/TaRlyZOAD8qC9OwHna5orEUyvW7uMyu2XMUSOXDPmOAMe7vmOJhSrR7WQnIjnQGfXhWrPO
        IR4r0ouWX43WJ5gCqxafaac++9pCV7HDgIdhUFF4oYKRy2NkiCb64F8OYOvv8m6KEx5IonnkacXk9
        U1x8wjtQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOkqA-00ALJ4-2L; Tue, 23 Mar 2021 17:29:34 +0000
Date:   Tue, 23 Mar 2021 17:29:14 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove svm_dev_ops
Message-ID: <20210323172914.GC2463754@infradead.org>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
 <20210323010600.678627-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323010600.678627-3-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
