Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405FB38083F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhENLQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhENLQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:16:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C644C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tYLc3GsyfFBaMQ+RDwOHUMKnirmCetzH9ttjQf1YUdo=; b=YR412PtVNoEzxYeawP4MP1QM5A
        Q/+1RKjNTTOW8llHIEif9QCXY9IgFDK1frnn7UwkBCUTt86KkqT7jixb5PMqIzTQdylwQ5diNkhGt
        nEb65FhT0RXGQGfWqINuIZBYGLChTU8k3PuKVowzqIaA5iM5dMXAD+EMaddxf25VukWFcsssQWdRk
        e8x18e8O/NgYs5vuv90qtOjcCur8ejsIMBb7zw1fHC/DRT5rwVUYiXxFsDm9B4eH4+fLBBpI0vr29
        DDoQ+z78md+NubYpJzzRQsHf0XGHqsZaSdgp6kfGOklsTDWXw7c20CHEgkVMCMQaXnEo3Y67XBbeC
        WnX29fUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhVlQ-00AJHJ-LC; Fri, 14 May 2021 11:13:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0251F30022A;
        Fri, 14 May 2021 13:13:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5D6020298BDE; Fri, 14 May 2021 13:13:51 +0200 (CEST)
Date:   Fri, 14 May 2021 13:13:51 +0200
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
Message-ID: <YJ5bbw70JLfNi8Q7@hirez.programming.kicks-ass.net>
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

> +/*
> + * Special values for ma_state.node.
> + * MAS_START means we have not searched the tree.
> + * MAS_ROOT means we have searched the tree and the entry we found lives in
> + * the root of the tree (ie it has index 0, length 1 and is the only entry in
> + * the tree).
> + * MAS_NONE means we have searched the tree and there is no node in the
> + * tree for this entry.  For example, we searched for index 1 in an empty
> + * tree.  Or we have a tree which points to a full leaf node and we
> + * searched for an entry which is larger than can be contained in that
> + * leaf node.
> + * MA_ERROR represents an errno.  After dropping the lock and attempting
> + * to resolve the error, the walk would have to be restarted from the
> + * top of the tree as the tree may have been modified.
> + */
> +#define MAS_START	((struct maple_enode *)1UL)
> +#define MAS_ROOT	((struct maple_enode *)5UL)
> +#define MAS_NONE	((struct maple_enode *)9UL)
> +#define MA_ERROR(err) \
> +		((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
> +

> +static inline enum maple_type mte_node_type(const struct maple_enode *entry)
> +{
> +	return ((unsigned long)entry >> 3) & 15;
> +}

> +static inline struct maple_node *mte_to_node(const struct maple_enode *entry)
> +{
> +	return (struct maple_node *)((unsigned long)entry & ~127);
> +}

> +static inline struct maple_topiary *mte_to_mat(const struct maple_enode *entry)
> +{
> +	return (struct maple_topiary *)((unsigned long)entry & ~127);
> +}

Can we please write masks as hex, also do they want a pretty name?


This has more magic mask values, proper names might be good:

> +static inline void mte_set_parent(struct maple_enode *enode,
> +				 const struct maple_enode *parent,
> +				 unsigned char slot)
> +{
> +	unsigned long bitmask = 0x78;
> +	unsigned long val = (unsigned long) parent;
> +	unsigned long type = 0;
> +
> +	switch (mte_node_type(parent)) {
> +	case maple_range_64:
> +	case maple_arange_64:
> +		type = 6;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	val &= ~bitmask; // Remove any old slot number.
> +	val |= (slot << MAPLE_PARENT_SHIFT); // Set the slot.
> +	val |= type;
> +	mte_to_node(enode)->parent = ma_parent_ptr(val);
> +}

> +static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
> +{
> +	unsigned long bitmask = 0x7C;
> +	unsigned long val = (unsigned long) mte_to_node(enode)->parent;
> +
> +	if (val & 1)
> +		return 0; // Root.
> +
> +	return (val & bitmask) >> MAPLE_PARENT_SHIFT;

7c is 1111100, but then you're shifting out the one bit that makes the
difference from the above magic 0x78. What gives?

> +}

