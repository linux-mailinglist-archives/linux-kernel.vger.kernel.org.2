Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453B2380D34
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhENPe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhENPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:34:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FE9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ujz0E1kl/lI1r0fDUys7Yf4Hsl5e6CIz72CabqA7X6A=; b=WmNrbMeq/NOUTX6gnAk9Rvek3L
        N8/hfwN6Ngr6oHr83EF45M5aI1J0tGrdW5gU5i9ic5sUr8jerIEPeBm4Wc+9CHH9ICKBMzVSN+tRv
        Y0ZLgSWU+vbKouSEd0fpFtzJ8U9zR7YCkpa15KIcUzX+p8r2Lhe2utZmw1nscX5C9FjvDj1iU1nW8
        f6hjyLc0/r/U3LHRgG42yLSq2Toj/SldMMCPeLrA7C4k1dfP48hXJ+1N5QDbt0T7fBp/Jj9tG+uSq
        J22V1tAR0jZz8Cgl38vsL5f5Al+MQz3tfG+R1Zvz9ddO6BeB1OIdK+hTgSzdI3ruzUsHlwEtk03BB
        3mBxpLcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhZnX-008PGY-0s; Fri, 14 May 2021 15:32:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3C5E30001C;
        Fri, 14 May 2021 17:32:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB0A520298BDE; Fri, 14 May 2021 17:32:15 +0200 (CEST)
Date:   Fri, 14 May 2021 17:32:15 +0200
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
Message-ID: <YJ6X/wrP/El8KLdh@hirez.programming.kicks-ass.net>
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
> +enum maple_type {
> +	maple_dense,
> +	maple_leaf_64,
> +	maple_range_64,
> +	maple_arange_64,
> +};

> +static inline unsigned long *ma_pivots(struct maple_node *node,
> +					   enum maple_type type)
> +{
> +	switch (type) {
> +	case maple_arange_64:
> +		return node->ma64.pivot;
> +	case maple_range_64:
> +	case maple_leaf_64:
> +		return node->mr64.pivot;
> +	case maple_dense:
> +	default:
> +		return NULL;
> +	}
> +}

> +static inline unsigned long *ma_gaps(struct maple_node *node,
> +				     enum maple_type type)
> +{
> +	switch (type) {
> +	case maple_arange_64:
> +		return node->ma64.gap;
> +	case maple_range_64:
> +	case maple_leaf_64:
> +	case maple_dense:
> +	default:
> +		return NULL;
> +	}
> +}

> +static inline unsigned long mte_pivot(const struct maple_enode *mn,
> +				 unsigned char piv)
> +{
> +	struct maple_node *node = mte_to_node(mn);
> +
> +	switch (mte_node_type(mn)) {
> +	case maple_arange_64:
> +		return node->ma64.pivot[piv];
> +	case maple_range_64:
> +	case maple_leaf_64:
> +		return node->mr64.pivot[piv];
> +	case maple_dense:
> +	default:
> +		return 0;
> +	}
> +}

I would suggest removing the default: case. Without it the cases are
complete and the compiler should not complain. Then if you extend the
enum and forget to add a case, the switch is no longer complete and will
trigger a warning, forcing you to update it (hopefully correct).

If you have the default, you'll not get a warning and it'll do whatever.
