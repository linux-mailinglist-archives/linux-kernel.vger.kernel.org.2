Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA726380862
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhENLXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhENLXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:23:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5587AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oObc2ElFqvGeUqGFyXfuB3LXrl7Py+nxdu8iVeG7i3k=; b=bW/lwAuvZLN7NXaCbawN9Ge/xk
        Ju3a7laLSS3ZtOgtwUzf2lW/9iEVPcpPZ0XPxuzUIFWqj7lLAj7DoUuF2gDRxHE4+8ycNFE+tywXk
        As2TxkgDXCd4s0Rx0lYoREbh8nQHtMwW2GklsX2xlBC7wnnuGi9gdYiGduNx7UMsqAuea8/9s5nNX
        UQczZ0andXRoh/iqv6WEQZM9uFYimkJ8+kKrXyLecq4nzAJu19LJl/jqB/B6rvrZ5FFFIKHxO8QMm
        vmRTr6uspexWa6HtezkIat9h2lyGeGFOdjjep6VfkcndMGk5rPLoz3VPrKky68ttSdFsb+M4bxBMp
        CYA3y5Rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhVrf-00AJZe-3K; Fri, 14 May 2021 11:20:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BFF430001C;
        Fri, 14 May 2021 13:20:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F13E20298BDE; Fri, 14 May 2021 13:20:18 +0200 (CEST)
Date:   Fri, 14 May 2021 13:20:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Message-ID: <YJ5c8vcvLyWRhs2d@hirez.programming.kicks-ass.net>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> +/* ma_free_rcu() - Use rcu callback to free a maple node
> + * @node: The node to free
> + *
> + * The maple tree uses the parent pointer to indicate this node is no longer in
> + * use and will be freed.
> + */

If this was supposed to be a kernel doc, then it would need to start
with /**, if it was not then it's an inconsistent comment style; by far
the majority of comments in this file have the regular:

 /*
  * multiline-
  *   comment
  */

style.

Like

> +/*
> + * We also reserve values with the bottom two bits set to '10' which are
> + * below 4096
> + */

> +/*
> + * mte_to_mat() - Convert a maple encoded node to a maple topiary node.
> + * @entry: The maple encoded node
> + *
> + * Return: a maple topiary pointer
> + */

And:

> +/*
> + * mas_mn() - Get the maple state node.
> + * @mas: The maple state
> + *
> + * Return: the maple node (not encoded - bare pointer).
> + */

But then you also have:

> +	// Removing the pivot overflow optimizes the loop below.
> +	// Check the first implied pivot.

> +	// Check end implied pivot which can only be a gap on the right most
> +	// node.

And:

> +		/* If the split is less than the max slot && the right side will
> +		 * still be sufficient, then increment the split on NULL.
> +		 */

> +		/* Avoid having a range less than the slot count unless it
> +		 * causes one node to be deficient.
> +		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
> +		 */


Single line comments are also an inconsistent mess:

> +	/* Avoid ending a node on a NULL entry */

> +	// Possible underflow of piv will wrap back to 0 before use.

> +	// Copy start data up to insert.

Even in a single function, you can't be consistent:

> +static inline void mast_topiary(struct maple_subtree_state *mast)
> +{
> +	unsigned char l_off, r_off, offset;
> +	unsigned long l_index,  range_min, range_max;
> +	struct maple_enode *child;
> +	void __rcu **slots;
> +	enum maple_type mt;
> +
> +	// The left node is consumed, so add to the free list.
> +	l_index = mast->orig_l->index;
> +	mast->orig_l->index = mast->orig_l->last;
> +	mt = mte_node_type(mast->orig_l->node);
> +	mas_node_walk(mast->orig_l, mt, &range_min, &range_max);
> +	mast->orig_l->index = l_index;
> +	l_off = mast->orig_l->offset;
> +	r_off = mast->orig_r->offset;
> +	if (mast->orig_l->node == mast->orig_r->node) {
> +		slots = ma_slots(mte_to_node(mast->orig_l->node), mt);
> +		for (offset = l_off + 1; offset < r_off; offset++)
> +			mat_add(mast->destroy, mas_slot_locked(mast->orig_l,
> +							slots, offset));
> +
> +		return;
> +	}
> +	/* mast->orig_r is different and consumed. */
> +	if (mte_is_leaf(mast->orig_r->node))
> +		return;
> +
> +	/* Now destroy l_off + 1 -> end and 0 -> r_off - 1 */
> +	offset = l_off + 1;
> +	slots = ma_slots(mte_to_node(mast->orig_l->node), mt);
> +	while (offset < mt_slots[mt]) {
> +		child = mas_slot_locked(mast->orig_l, slots, offset++);
> +		if (!child)
> +			break;
> +
> +		mat_add(mast->destroy, child);
> +	}
> +
> +	slots = ma_slots(mte_to_node(mast->orig_r->node),
> +			     mte_node_type(mast->orig_r->node));
> +	for (offset = 0; offset < r_off; offset++)
> +		mat_add(mast->destroy,
> +				mas_slot_locked(mast->orig_l, slots, offset));
> +}

This mixing of C and C++ style comments is a mess.
