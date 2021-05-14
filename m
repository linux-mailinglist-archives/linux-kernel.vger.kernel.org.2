Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FA2380872
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhENL2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhENL2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:28:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0837C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mCCyvpSutI8noyt1HNcq373sVHNhz9AT4dX+rpfCZkQ=; b=leLuXHsAYlKLMBPzk/T2noDdB0
        iQwvag3bNqeyX1jJhtpNdbdKIRS+SSmLTZYR8DehrZTrn0HM88g+PhX5UWIZGO6tMw6ZmQCRf32ii
        ooSaBFFzI/XBm/eMmW7ursLe211u6/w0WxbsTQkU07MjTRIBz0WaV+7F/4xkUjJXpoOyMFtptTXAy
        rXpjsF3YTPorbxjUjUcTLazh6ZIhg7yVn0FrQQsCtOOV4Z9sB8Nogy3a+LFyRji/ZZ7z6qGR31KRo
        UbGPvRW1sxqPsLfgZAymXplaE4v1xp9GqyQZFVjAlekFPmYpkZS4GAIrhYZjo9BS3dDlNgbpHzzoG
        hcXr+C2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhVyM-007tq5-Fb; Fri, 14 May 2021 11:27:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE55530001C;
        Fri, 14 May 2021 13:27:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF4EE20298BDE; Fri, 14 May 2021 13:27:13 +0200 (CEST)
Date:   Fri, 14 May 2021 13:27:13 +0200
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
Message-ID: <YJ5ekZAddvWI3Hzk@hirez.programming.kicks-ass.net>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ5bbw70JLfNi8Q7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ5bbw70JLfNi8Q7@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 01:13:51PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:

> > +static inline struct maple_node *mte_to_node(const struct maple_enode *entry)
> > +{
> > +	return (struct maple_node *)((unsigned long)entry & ~127);
> > +}
> 
> > +static inline struct maple_topiary *mte_to_mat(const struct maple_enode *entry)
> > +{
> > +	return (struct maple_topiary *)((unsigned long)entry & ~127);
> > +}
> 
> Can we please write masks as hex, also do they want a pretty name?
> 
> 
> This has more magic mask values, proper names might be good:
> 
> > +static inline void mte_set_parent(struct maple_enode *enode,
> > +				 const struct maple_enode *parent,
> > +				 unsigned char slot)
> > +{
> > +	unsigned long bitmask = 0x78;
> > +	unsigned long val = (unsigned long) parent;
> > +	unsigned long type = 0;
> > +
> > +	switch (mte_node_type(parent)) {
> > +	case maple_range_64:
> > +	case maple_arange_64:
> > +		type = 6;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	val &= ~bitmask; // Remove any old slot number.
> > +	val |= (slot << MAPLE_PARENT_SHIFT); // Set the slot.
> > +	val |= type;
> > +	mte_to_node(enode)->parent = ma_parent_ptr(val);
> > +}
> 
> > +static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
> > +{
> > +	unsigned long bitmask = 0x7C;
> > +	unsigned long val = (unsigned long) mte_to_node(enode)->parent;
> > +
> > +	if (val & 1)
> > +		return 0; // Root.
> > +
> > +	return (val & bitmask) >> MAPLE_PARENT_SHIFT;
> 
> 7c is 1111100, but then you're shifting out the one bit that makes the
> difference from the above magic 0x78. What gives?

IMO the more obvious way is something like:

	(val >> MAPLE_PARENT_SHIFT) & ((1 << MAPLE_SLOT_BITS)-1);

And then we also see that 3+4 gives 7, which is that magical 127 above,
are them the same? Related names would be good in that case.
