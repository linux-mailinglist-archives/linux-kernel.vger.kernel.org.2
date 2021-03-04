Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25E732D71B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhCDPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhCDPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:49:49 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A76C061761
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 07:49:09 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a18so19965910wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LhGupbzdEthuR24ULnc5046PaiLJrBs+er9+oVApeFU=;
        b=EWHLHh+IyVUqUgAF4LFZSuMlY9wO0QpbQ806Aov0N14LnzY3kFNc0MBKZlNk0fMhBa
         7g4Vv/tUs3yoiKwACuE890DOhAPuphZYbSCPPuUaBxUgawsBJAdJTCBLXVzt5wVIYVUt
         zc8bT49uF5u2iGpc6PKcZNdkMzvNW6RSaF2yAKzUaTiHmSf1WpEgc5Yhp8f7q+4albDc
         nF4lron7w2kjGuZ+LtZ6whwHeQQrh6JNZcPXFeccx3iXxxUL7VHPFH6MEx27zPsugvH7
         ZyGHw9Tchk2qVIeN2zMA+sCqvgrf1e2fXQObBmKBSPKY2GJeESgGs+oXFyLQCjmcCF1l
         u3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LhGupbzdEthuR24ULnc5046PaiLJrBs+er9+oVApeFU=;
        b=YxuvSSvnNK83IWt8f3+fu7JAVVR+6gVRScKQ1A0NR3cl/5nMosXoDJzbHfPnCxjZWb
         Q1HT/+El1qVREOqieK3cD/2guU00AMlxXzHZokLzCEQ+l0hAerYS9rBxRVFw5Y3W0b5e
         oH6HNyzPSRZdFUYGjADwmQYIq0SlxkCi+CPRGbHTF2TaBhs1GIpaLRvqzEe85euJuqbk
         MMkFAFYGoRwCFgiX/u3AwtpqGEnEl6ysAXWOpYXO4PEaqCbxUjrkFaAi89e+Ct3NMSqI
         b9Xg7e1/UklQnXTmbTM0rn+jBaNuQ/bpRuan1ny7v1xpM3uXx6cEDsPfzw35n7ZNsjLj
         j0aQ==
X-Gm-Message-State: AOAM530tVZxEw2ikmetEYt3uekabxrM3Rl6G9Zd6XqGEYLVOnKVXqH05
        19r4Kfjpntle74O74YrV0nTCGA==
X-Google-Smtp-Source: ABdhPJwAMOHT+NpKRPC4qB1GLJVh8vLpTUsT2vC7aS+EbNwN1mBpqTrXaelCzUyIK9ZPcLvl/WPgqA==
X-Received: by 2002:adf:9bcf:: with SMTP id e15mr4631058wrc.276.1614872947974;
        Thu, 04 Mar 2021 07:49:07 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id m10sm10074082wmh.13.2021.03.04.07.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:49:07 -0800 (PST)
Date:   Thu, 4 Mar 2021 15:49:05 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 12/32] KVM: arm64: Introduce a Hyp buddy page allocator
Message-ID: <YEEBccpDtnJJdwkJ@google.com>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-13-qperret@google.com>
 <20210304153036.GA21507@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304153036.GA21507@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Mar 2021 at 15:30:36 (+0000), Will Deacon wrote:
> On Tue, Mar 02, 2021 at 02:59:42PM +0000, Quentin Perret wrote:
> > +void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
> > +{
> > +	unsigned int i = order;
> > +	struct hyp_page *p;
> > +
> > +	hyp_spin_lock(&pool->lock);
> > +
> > +	/* Look for a high-enough-order page */
> > +	while (i < pool->max_order && list_empty(&pool->free_area[i]))
> > +		i++;
> > +	if (i >= pool->max_order) {
> > +		hyp_spin_unlock(&pool->lock);
> > +		return NULL;
> > +	}
> > +
> > +	/* Extract it from the tree at the right order */
> > +	p = list_first_entry(&pool->free_area[i], struct hyp_page, node);
> > +	p = __hyp_extract_page(pool, p, order);
> > +
> > +	hyp_spin_unlock(&pool->lock);
> > +	hyp_page_ref_inc(p);
> 
> I find this a little scary, as we momentarily drop the lock. It think
> it's ok because the reference count on the page must be 0 at this point,

Yep, @p shouldn't be visible to the caller yet so this should be fine.

> but actually then I think it would be clearer to have a
> hyp_page_ref_init() function which could take the lock, check that the
> refcount is indeed 0 and then set it to 1.

Works for me. Maybe I'll use another name for the API to stay consistent
with the kernel gfp code (hyp_page_ref_inc() and friends are inspired
from their kernel counterpart). And I guess I can hyp_panic() if the
refcount is not 0 at this point to match the VM_BUG_ON_PAGE() in
set_page_refcounted().

Thanks!
Quentin
