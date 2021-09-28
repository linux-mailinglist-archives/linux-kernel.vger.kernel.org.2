Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CDF41B33B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbhI1Psp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhI1Pso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:48:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA9C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=RLhInNF/UixHA5msC5kJ0h7T7fFnfbdQ3PuTDScQ7yQ=; b=PGTlv/HqmrtMPlCrC3ov+Y8nx0
        hSuHDsn40aJKzrwUozP0+RkMFXLfgn5Wrxd3zjO5olAqHGRcUigcKLU0a0OJHwRrGfFD46ShRj3r6
        8+Tyi4MDA5VAWtsR2ghNRJZgw70GdqimBo2GzRzj9BMx0w3PG+M74k0vHFZya28RBBjO6QGr6+CvK
        xaNnt3W1xRphZtBLgBDvo9Fj/rlOzJuEqiUWijxj7kXzJwp3DCsk0+bc9tZZfEiYzwNbJYL2Xa1zk
        PNwuRrTi3zETknPROM+tOJLyLepLnFirLjUjx1XCvkojs9EEENgdA6UrKDInA+yNFspZaczwR/BCx
        vFsJV2gw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVFGn-00AzHa-0U; Tue, 28 Sep 2021 15:44:32 +0000
Date:   Tue, 28 Sep 2021 16:43:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, shakeelb@google.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] slub: Add back check for free nonslab objects
Message-ID: <YVM4NJZWNyOhZIIP@casper.infradead.org>
References: <20210927021538.155991-1-wangkefeng.wang@huawei.com>
 <566f2009-6acf-4fb9-f7c0-edc1d6ce6561@suse.cz>
 <73b662cc-ab1f-b3bf-468a-4cd744e92d71@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73b662cc-ab1f-b3bf-468a-4cd744e92d71@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 03:53:47PM +0800, Kefeng Wang wrote:
> On 2021/9/27 15:22, Vlastimil Babka wrote:
> > On 9/27/21 04:15, Kefeng Wang wrote:
> > > After commit ("f227f0faf63b slub: fix unreclaimable slab stat for bulk
> > > free"), the check for free nonslab page is replaced by VM_BUG_ON_PAGE,
> > > which only check with CONFIG_DEBUG_VM enabled, but this config may
> > > impact performance, so it only for debug.
> > > 
> > > Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
> > > add the ability, which should be needed in any configs to catch the
> > > invalid free, they even could be potential issue, eg, memory corruption,
> > > use after free and double-free, so replace VM_BUG_ON_PAGE to WARN_ON, and
> > > add dump_page() to help use to debug the issue.
> > There are other situations in SLUB (such as with smaller allocations that
> > don't go directly to page allocator) where use after free and double-free
> > are undetected in non-debug configs, and it's expected that anyone debugging
> > them will enable slub_debug or even DEBUG_VM. Why should this special case
> > with nonslab pages be different?
> 
> I want the check back in kfree, this one is used  widely in driver, and the
> probability
> 
> of problem occurred is bigger in driver, especially in some out of tree
> drivers.

Why would we want to improve life for out of tree drivers?  Drivers should
be in-tree.  That's been the Linux Way for thirty years.

I remain sceptical that dump_page() is actually useful for debugging
drivers anyway.  dump_stack(), I could see -- that'll tell you which
driver called kfree() on a bogus pointer.  But how does dump_page() help?
