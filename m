Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E60F3807D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhENLBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhENLA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:00:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB513C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rp0MFY3tjhifvpdQ3ak+U9cvay2sYh6AQ1zrO+iYeuA=; b=UZsUULYKG7CXxhG3WkNhkA1pA5
        ccx270IsOy+j8VbWr7M06WPzOA+si5JQtlE11yRcHBHSCcgLpJDDIzxZnPz487SNZr6DPdMz8MvK1
        rsUhwu9DdRB+QBmaGqfC5zAoImI2uWVwPShZu6qhsYx0d91DzLW+Dyke5TEAHh/ts7oRVcbmkiucH
        WL9Ie5FgbkZJTf2mIkCtD9DtRNKXU34hIo7ynF8fDf9McQ2ehyf7r7TqBOVvPMZ5wyz7xzm4srLqB
        rQC8oeGgZssWyqnADPdrjSFuQaE4bl4lRGUzKaX3/sWA3bIAeHfaLOLk5id2mytx5cRI9LDCgOtim
        P8EOhUkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhVUq-00AIXS-Vg; Fri, 14 May 2021 10:57:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C0EA300223;
        Fri, 14 May 2021 12:56:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8383720829F97; Fri, 14 May 2021 12:56:43 +0200 (CEST)
Date:   Fri, 14 May 2021 12:56:43 +0200
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
Message-ID: <YJ5Xa/4ZFEgfdsOY@hirez.programming.kicks-ass.net>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cc'ing a moderated list is sodding annoying, dropped it.

On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:

> +struct maple_range_64 {
> +	struct maple_pnode *parent;
> +	unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
> +	void __rcu *slot[MAPLE_RANGE64_SLOTS];
> +};
> +
> +struct maple_arange_64 {
> +	struct maple_pnode *parent;
> +	unsigned long pivot[MAPLE_ARANGE64_SLOTS - 1];
> +	void __rcu *slot[MAPLE_ARANGE64_SLOTS];
> +	unsigned long gap[MAPLE_ARANGE64_SLOTS];
> +	unsigned char meta;
> +};
> +
> +struct maple_alloc {
> +	unsigned long total;
> +	unsigned char node_count;
> +	unsigned int request_count;
> +	struct maple_alloc *slot[MAPLE_ALLOC_SLOTS];
> +};
> +
> +struct maple_topiary {
> +	struct maple_pnode *parent;
> +	struct maple_enode *next; /* Overlaps the pivot */
> +};
> +
> +enum maple_type {
> +	maple_dense,
> +	maple_leaf_64,
> +	maple_range_64,
> +	maple_arange_64,
> +};

> +struct maple_node {
> +	union {
> +		struct {
> +			struct maple_pnode *parent;
> +			void __rcu *slot[MAPLE_NODE_SLOTS];
> +		};
> +		struct {
> +			void *pad;
> +			struct rcu_head rcu;
> +			unsigned int ma_flags;
> +			enum maple_type type;
> +		};
> +		struct maple_range_64 mr64;
> +		struct maple_arange_64 ma64;
> +		struct maple_alloc alloc;
> +	};
> +};

This is somewhat inconsistent; would it make sense to have struct
maple_dense and struct maple_leaf_64, and maybe even struct maple_free,
such that one can write:

struct maple_node {
	union {
		/* maple_type: */
		struct maple_dense	md;
		struct maple_leaf_64	ml64;
		struct maple_range_64	mr64;
		struct maple_arange_64	ma64;

		/* internal, life-time: */
		struct maple_alloc	alloc;
		struct maple_free	free;
	};
};

Or something along those lines.
