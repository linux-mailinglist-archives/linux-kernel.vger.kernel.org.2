Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5818380D71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhENPkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbhENPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:40:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C29C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XNun8oTMQZMoUdApTbcm2jZivlJuomdOXiFmXBYhctg=; b=kLH1L+Dzrp7b3zuNybr327vObB
        D2kzIl4ZatoesCrtADWi0TvuKx/S6mvichGy2v+iahvbtp1vYI3IC2Ag+1q4kbfE77fnu6YeNzdju
        mC4/Oj6LpDO+pOpMREuB3WQLC8mhqKxEi8L3vdPwzCE8WaVqZ+80GfhXEvzdpQ6Y5/1oEYYc3fxWv
        HdD/V1O1ZwHzHPKkuZJSk1hSonNlvCv8VFG9MkNMNo89HL8hne0vqd48ZWE7hJUkLHLf7wB71/EZl
        K0oprd9ocWWDlpzo4D7/ignae42v3mA9Xbo5l9HJbI3F3m8YwNKoEmkzaU2wQBOJFcxGbYowjkyfD
        gm4vpgyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhZq1-00AUHO-9Y; Fri, 14 May 2021 15:35:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9A8A30001C;
        Fri, 14 May 2021 17:34:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91EBD20298BDE; Fri, 14 May 2021 17:34:52 +0200 (CEST)
Date:   Fri, 14 May 2021 17:34:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
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
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 26/94] Maple Tree: Add new data structure
Message-ID: <YJ6YnJv99AEdu0it@hirez.programming.kicks-ass.net>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ6X/wrP/El8KLdh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ6X/wrP/El8KLdh@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 05:32:15PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> > +static inline unsigned long mte_pivot(const struct maple_enode *mn,
> > +				 unsigned char piv)
> > +{
> > +	struct maple_node *node = mte_to_node(mn);
> > +
> > +	switch (mte_node_type(mn)) {
> > +	case maple_arange_64:
> > +		return node->ma64.pivot[piv];
> > +	case maple_range_64:
> > +	case maple_leaf_64:
> > +		return node->mr64.pivot[piv];
> > +	case maple_dense:
> > +	default:
> > +		return 0;
> > +	}
> > +}

Why is @piv 'unsigned char' ? Does that actually generate better code on
any architecture?

At the same time; there's no bounds check.
