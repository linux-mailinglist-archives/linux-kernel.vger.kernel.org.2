Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E739E346688
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhCWRiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhCWRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:37:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158D3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yco9lEeprdhGCEE6HK4haJS01ehzRP1EIp35HUW10WA=; b=tH2VnIedWVKpR/Jk3w7khUgEvB
        3Fv6Sy9eGiZe1SCHBOsyoOkPLO4KOo+ciyc1df2ErRMU+czLwlpEAyp+4plLFTBzoA/7ALcVQrUO3
        zgbKkmLCoNCPyIXz15/xkSBECtPZ4rx7gKa8UO1y2AMgkt8NhyrJa9Z1bNCxdE3CB5ICnZXkNXr/F
        kyxh+zLA0rvrgktyOYxe7XUMc/W04ZAfNh9VSi36lDyNJkVf5xVCMlOiWISs6RW8NGFr4eFnkM5uM
        8YpOyXecZLVZJfmZE85GyL94828IJP4YSu6TH/R8GSTFAyB7rygsiBt2ZfH4GJvb6YVy2YeJV48iZ
        g/8sEZ/A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOkxg-00ALkt-Us; Tue, 23 Mar 2021 17:37:12 +0000
Date:   Tue, 23 Mar 2021 17:37:00 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iommu/vt-d: Make unnecessarily global functions
 static
Message-ID: <20210323173700.GF2463754@infradead.org>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
 <20210323010600.678627-6-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323010600.678627-6-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:06:00AM +0800, Lu Baolu wrote:
> Make some functions static as they are only used inside pasid.c.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
