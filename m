Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810E8346680
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhCWRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhCWRgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:36:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B7AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TduDshJQGkQTjlXrbKj6sW7pDov6LaUmnXncWO3w/7Y=; b=b5tQHF2+SVbcHrAfokqu3fZeIN
        X5xgQjPTckJ/wRBvW02WErtEBqHyWn7JOzdl8jQqw2xPs168p/Xrmnaf0YF4/eDPWMmLR68bTSy4u
        I6x1UB3yoAKCfBr3qH6cTZAS8NL8rItv4AmIyUyVc2Rroa8hU+lZ/ZYSw0q3aYZFRJETKNbVn5L1X
        oRwCw4ygN9MLtQg22Qvq0/pwNNWvrc3aOLYxxwP0IqqeW8lDV012aKJj5M3P9MOnNDjiP1uAuwTde
        yOXUaIMby4buKf4maMlPPoFypmz7jkWhp2EGfehdusaIfTRWOLqRc4Em04fi45MPnBbes9KBEZQG/
        DdeuVLRQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOkwO-00ALgm-DC; Tue, 23 Mar 2021 17:35:50 +0000
Date:   Tue, 23 Mar 2021 17:35:40 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/vt-d: Remove unused function declarations
Message-ID: <20210323173540.GE2463754@infradead.org>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
 <20210323010600.678627-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323010600.678627-5-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:05:59AM +0800, Lu Baolu wrote:
> Some functions have been deprecated. Remove the remaining function
> delarations.

s/deprecated/removed/g

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
