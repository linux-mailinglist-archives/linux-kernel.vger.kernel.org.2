Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AD7380A82
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhENNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhENNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:43:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A94EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WeqnDueLL3Y7hUYBnonhmaWEvwFWa7jko0cCO3KQkUI=; b=LtjvynKQHt3b+rUBpH5xd2fmAy
        B3S2sTGMSlz5ZFgm1kHxSU3VRX4cEhXKagcJpqZ+qWobpAeD+QkfULdzsdN80oLKnwOPk5OuQShUr
        6jSTOEBk0hwY1FyJfVnVxMUnh7u3MBAkKiFlJRmjqFA0B/KbU2CEFbsQ4+rOn6tkaAntCjBlQX2IX
        cStWdyzwyjBeGMiXP3nqu1iloA2mUReXvQXF3QsZAeZ7uxG/lHCcgZ+IlHDOTsZTnKOq3oycj8ahn
        1CFs/XlApHhXvigg5NogZQLOslr8nga1MlN03JHZowYWEQBe7BXqoUbPutqChwKL+XCLf7IuKfxcJ
        B82pLEOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhY4s-008ABK-QI; Fri, 14 May 2021 13:42:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DF3830022A;
        Fri, 14 May 2021 15:42:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA5C82BE0F873; Fri, 14 May 2021 15:42:04 +0200 (CEST)
Date:   Fri, 14 May 2021 15:42:04 +0200
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
Message-ID: <YJ5+LN7FlNjAXQi0@hirez.programming.kicks-ass.net>
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
> + * mte_set_parent() - Set the parent node and encode the slot.
> + * @enode: The encoded maple node.
> + * @parent: The encoded maple node that is the parent of @enode.
> + * @slot: The slot that @enode resides in @parent.
> + *
> + * Type is encoded in the enode->parent
> + * bit 0: 1 = root, 0 otherwise
> + * bit 1: Reserved.
> + * bit 2: 0 = range 32, 1 = [a]range 64
> + *
> + * Slot number is encoded in the enode->parent
> + * range_32, slot number is encoded in bits 3-6
> + * [a]range_64, slot number is encoded in bits 3-6
> + */
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

6 = 4 + 2, which has bit1 set, but the above sayeth bit1 is reserved.

It is also mighty confusing to have two different type fields, is there
no way we can merge the types into a single (shared) space?

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
