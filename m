Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5833FE631
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbhIBAAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhIBAAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:00:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A3DC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NS2CxBpdM7T3fz0/+Dj80k1I+SuLflnA7x6FaBAQ2IE=; b=YBL1898AGSPsCRxznQ0d1JRo8r
        ZgcAwbgTL4YwbAs7tRU/VZZ+DV6TsoLBRilDMxeqa/i04qHVWKVUPpC7hH/KUvY8tTQdD6bL0WDQ8
        UCetGH/beP+vX75Z7Rqm3TlVSnn3W4XCbKfk1245sa5KwQVVrbLlx0W++oPYRWMPj3s1/qhMxchNJ
        U6G143Xr274AFCP4KwcQRqbk0QTXBKd9NCo4B4oP326BPlYTju9Cse4iCsRGK+0z0ikfRb2VC0rrb
        640Mp7v2NBMz3nRYBNoKbz/IDCNeGYIoCxechl4tiTN3/k8L47UlQVWczBK2HQCfE3Y9+78R3aad1
        vfD7SuKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLa7G-002vNq-P4; Wed, 01 Sep 2021 23:58:15 +0000
Date:   Thu, 2 Sep 2021 00:58:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, linux-kernel@vger.kernel.org,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YTATir09urAUTSI+@casper.infradead.org>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org>
 <YS+AhXJGsniaHTS4@hsj>
 <YS+NXmDO0yqDEBmD@hsj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS+NXmDO0yqDEBmD@hsj>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 02:25:34PM +0000, Huang Shijie wrote:
> On Wed, Sep 01, 2021 at 01:30:45PM +0000, Huang Shijie wrote:
> > On Wed, Sep 01, 2021 at 04:25:01AM +0100, Matthew Wilcox wrote:
> > > On Wed, Sep 01, 2021 at 11:07:41AM +0800, Shijie Huang wrote:
> > > >     In the NUMA, we only have one page cache for each file. For the
> > > > program/shared libraries, the
> > > > remote-access delays longer then the  local-access.
> > > > 
> > > > So, is it possible to implement the per-node page cache for
> > > > programs/libraries?
> > > 
> > > At this point, we have no way to support text replication within a
> > > process.  So what you're suggesting (if implemented) would work for
> > 
> > I created a glibc patch which can do the text replication within a process.
> The "text replication" means the shared libraries, not program itself.

Thinking about it some more, if you're ok with it only being shared
libraries, you can do this:

for i in `seq 0 3`; do \
	cp --reflink=always /lib/x86_64-linux-gnu/libc.so.6 \
		/lib/x86_64-linux-gnu/libc.so.6.numa$i; \
done

Reflinked files don't share page cache, so you can do this all in
userspace with no kernel changes.
