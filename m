Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E496E3809CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhENMom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbhENMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:44:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEB6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xzPXVxpZQ3/CjIF6aGZZiQCBKpbTHMrqMNz9kCI13gA=; b=seOhPYN7y8wRUxyL1Lie+I1I/w
        J9lFHSqNMzWXCO7/zbtkyiDQx++1LiYJErzAvIPJFy8MtRJdLs6/7zNEvI8aJKGLZgvB1T9cj2w5o
        N8BYwjk3me/GzE2gOtvctOjDIgRSweJqV/X8WCYvtb+/UdoU7e1T4x1HUuTTmKGdsAh5qYfTAkNv1
        N2FCWKEU+sDynHXrbS+dvBsG7sb7zD5DnPYgKvdia6buUomg0Rm5kfP8WOf5eEdzk0v49aZNctNnN
        EKYl8QV6WL0+vlXOGuYZZiIqiClq+gw7eGzB/Y0eH81d+2IvWzjyxBmLhNL8k+Q+6953DwfW+Og5y
        u/2NnUrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lhX9i-00AMrM-9n; Fri, 14 May 2021 12:43:06 +0000
Date:   Fri, 14 May 2021 13:43:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 26/94] Maple Tree: Add new data structure
Message-ID: <YJ5wVncTFHHmY762@casper.infradead.org>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ5qbS2KJcVp+ocY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ5qbS2KJcVp+ocY@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 02:17:49PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> > +static void mas_set_height(struct ma_state *mas)
> > +{
> > +	unsigned int new_flags = mas->tree->ma_flags;
> > +
> > +	new_flags &= ~MAPLE_HEIGHT_MASK;
> > +	new_flags |= mas->depth << MAPLE_HEIGHT_OFFSET;
> > +	mas->tree->ma_flags = new_flags;
> > +}
> 
> This goes sideways when mas->depth is too large; I didn't quickly see an
> assertion / range checks for mas->depth anywhere.

Not arguing that we shouldn't have such an assertion (to catch bugs),
but with 4 bits, that's a height 15 tree.  At a minimum fanout of 5.5
per level (with a minimum of 8.5 in the leaf), that's 197 x 10^9 entries.
At a more typical fanout of 8 per level and 12 entries in each leaf, it's
52.8 x 10^12 entries in the tree (about 2^46).  You'll run out of memory
and address space first.
