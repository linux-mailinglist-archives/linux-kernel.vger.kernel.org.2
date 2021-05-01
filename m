Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224173705B1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 07:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhEAFFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 01:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhEAFFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 01:05:31 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10EFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 22:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619845481; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=nRZfoo813GNy5ZLZUGZ2bJgXOBhdjd9VR0ztKnAnN+c=;
 b=hkLMsUB5PsrVKLDLi3uVJ93mD/Wa7e7oVM4dEbcK/nnoLSKUCMhp6Mt2RL/WixV8jzUYG
 9LRpNRlHN6SMIqwCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619845481; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=nRZfoo813GNy5ZLZUGZ2bJgXOBhdjd9VR0ztKnAnN+c=;
 b=dcKXKGQLiPseYjbnvxU0U7plyfHV9OaDEgVBLXFqtrXd6IvfheCxOYm0tvBnS0fU9w0iG
 BuOkqeKPu1L1Wq3AffxI8PyE0TH6wi6HdQS2cwag0wEuiZjzMZbTwqBeS9NUIi0arJVSnRn
 bxIH5ZFSA7PyepoRUzdUzHUsM6esOfb4+Wrt3CBuGQLL/l5XOB8fZdEexjQK1u2SXfHydVB
 h9uNSAUpC6W6J7om5UHypL7I+7H4nFO7DqyQbKS2kX7LR0CQEgZQ3mOewLHU5H465pkMthp
 606ZaIIdMX2TdfSUgWQNdJbgLk/PFjlgphbJTUfn6kkiom/7gQ9+x+LgIAxQ==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 0F583160324; Fri, 30 Apr 2021 22:04:41 -0700 (PDT)
Date:   Fri, 30 Apr 2021 22:04:41 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 01/94] mm: Add vma_lookup()
Message-ID: <20210501050441.GB5188@lespinasse.org>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-2-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428153542.2814175-2-Liam.Howlett@Oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:35:43PM +0000, Liam Howlett wrote:
> Many places in the kernel use find_vma() to get a vma and then check the
> start address of the vma to ensure the next vma was not returned.
> 
> Other places use the find_vma_intersection() call with add, addr + 1 as
> the range; looking for just the vma at a specific address.
> 
> The third use of find_vma() is by developers who do not know that the
> function starts searching at the provided address upwards for the next
> vma.  This results in a bug that is often overlooked for a long time.
> 
> Adding the new vma_lookup() function will allow for cleaner code by
> removing the find_vma() calls which check limits, making
> find_vma_intersection() calls of a single address to be shorter, and
> potentially reduce the incorrect uses of find_vma().
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

This seems like a good API to have, and I agree it's less error prone than
having every caller check the vma->vm_start address.

Minor nitpick, I would prefer if the implementation used find_vma()
and then checked the vma->vm_start address - I don't like using [i, i+1)
intervals to implement stabbing queries.

But other than that, I think this (and the other patches adding
corresponding call sites) is safe for merging.

--
Michel "walken" Lespinasse
