Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CCE4034B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhIHHHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhIHHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:06:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7F4C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u0jDPhGZwBkm+JMr6omQzYQizJyYgqZlwoU/jhm0G5s=; b=MlbsyzCdFKeIEDRfx1McK2amJc
        sZxrTxkScG/1WgXYGHD4V+bhWBRDZcajEMfSC3Rwh7B9lDj5xGPybecP4NGCxlvEnCQ5dAOw/mvQC
        Ne+YzN2biFxXb0cqjqdD5AOk5OTnSO86XUY8fGrf5F9OLSg1zVss0ee990dy8gbMeXRwV80gqaQDr
        AB/je8uC8iu7fwxs1wpvfFnQHp9bbN0RhMh1Yv+PeKByy9sQeiTX39GFwbTWNr1IIAGhJtTj1RjEi
        nMjgdiOKSed2JDSqDn7hI5nd+A9lN6PF4SsxMBk0Yvlq7ucqDs2VuYNkj6v52X1Qm7lpLLWu3Xn5N
        JDT+ugtg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrdA-008aSO-K1; Wed, 08 Sep 2021 07:04:35 +0000
Date:   Wed, 8 Sep 2021 08:04:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 08/12] swiotlb-xen: arrange to have buffer info logged
Message-ID: <YThgeOiR0PU+iNlC@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <2e3c8e68-36b2-4ae9-b829-bf7f75d39d47@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e3c8e68-36b2-4ae9-b829-bf7f75d39d47@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:07:21PM +0200, Jan Beulich wrote:
> I consider it unhelpful that address and size of the buffer aren't put
> in the log file; it makes diagnosing issues needlessly harder. The
> majority of callers of swiotlb_init() also passes 1 for the "verbose"
> parameter. 
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
