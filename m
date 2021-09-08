Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C3E40351B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348948AbhIHHR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348916AbhIHHRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:17:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B0AC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MnjsixqmosBihT6Q0qVYXXqBZ2K/JeOxHPpv883b1xQ=; b=XbM8Xg3PjSFGTYmv3zW07WfyaY
        yWEdMq1eEqx0RRQqf2r7e6pYKpvEx0oG4KVrQaoCagb/MmI7o0acywnXwpXSPJTo/1MkSPkPOEFJy
        mKVPyz7XoUQE44YQmLjxnlC/1P/RLwrxrspgdaqdkFsWsJpB2cRQfFSd4r+Bz7k7bOYyGJ9XCEdOU
        VV701Kva713ECwwrgTRZcHhYdgohcpF+ORONW/M/BNUXYF7JoqGFO0tJVrTc+1JqjXQEOCwt3RRqO
        IbwKTqnS0QnoY/SeWesV1xBSinYJz2jyaANLtuvExQupl4FPr9q6HdJd1s3vCXjHopyF3JjAZ7vVe
        7+fwQCwQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrml-008b2V-QY; Wed, 08 Sep 2021 07:14:58 +0000
Date:   Wed, 8 Sep 2021 08:14:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 12/12] swiotlb-xen: this is PV-only on x86
Message-ID: <YThiyxG0d2tmCtb+@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <004feaef-f3bb-e4bb-fb10-f205a9f69f28@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004feaef-f3bb-e4bb-fb10-f205a9f69f28@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:13:21PM +0200, Jan Beulich wrote:
> The code is unreachable for HVM or PVH, and it also makes little sense
> in auto-translated environments. On Arm, with
> xen_{create,destroy}_contiguous_region() both being stubs, I have a hard
> time seeing what good the Xen specific variant does - the generic one
> ought to be fine for all purposes there. Still Arm code explicitly
> references symbols here, so the code will continue to be included there.

Can the Xen/arm folks look into that?  Getting ARM out of using
swiotlb-xen would be a huge step forward cleaning up some DMA APIs.

> 
> Instead of making PCI_XEN's "select" conditional, simply drop it -
> SWIOTLB_XEN will be available unconditionally in the PV case anyway, and
> is - as explained above - dead code in non-PV environments.
> 
> This in turn allows dropping the stubs for
> xen_{create,destroy}_contiguous_region(), the former of which was broken
> anyway - it failed to set the DMA handle output.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
