Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9559435EE21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348491AbhDNHBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348486AbhDNHBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:01:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9CDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cwzxp8DD6+B81/zZ+mGgix3pYwvDbFzL7mvBDlLchy0=; b=XC1IY8PL2HL0UHwv8RqzQLbIEQ
        5CJTe8bJ4KGzeYZhutB7Mtcga2UCz2F3S2qDOeiEX1ck0oXaLmnUG82qkxJdbQ4YyRXtgcC2BTc+b
        pj5SykdD3YHEqRyrFxWbPM7F7GwEC93kfObRtqAGfl5bPqQRxaVF0qiAmhln56ZRGDI7NdgRg7zFA
        gtKKV2FjdEtkU7N1+QfVe2NoNI5xW7mGcL9Ct0fe6qG8KiJeIkv70c5sEvaDD4YthfbnfMsbQ6x4X
        fGzMm+lUDs9R9g4P9TQseT7J5GaS6eNMA9CNyxFDfZxjpWDmbNAlxzhodDatINAmP2U8rteNofce0
        f3roFwgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWZVV-006mAb-Q4; Wed, 14 Apr 2021 07:00:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73C4E30015A;
        Wed, 14 Apr 2021 09:00:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B268203D392D; Wed, 14 Apr 2021 09:00:11 +0200 (CEST)
Date:   Wed, 14 Apr 2021 09:00:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 4/7] mm: Introduce verify_page_range()
Message-ID: <YHaS+4eV7ATwAAWz@hirez.programming.kicks-ass.net>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.769864829@infradead.org>
 <202104121302.57D7EF8@keescook>
 <YHVKACnVLAhbnt4j@hirez.programming.kicks-ass.net>
 <202104131935.B5EBDAE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104131935.B5EBDAE@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 08:01:08PM -0700, Kees Cook wrote:
> So the addr can just be encoded in "int", and no structure is needed at:
> 
> typedef bool (*vpr_fn_t)(pte_t pte);
> 
> static int vpr_fn(pte_t *pte, unsigned long addr, void *data)
> {
> 	vpr_fn_t callback = data;
> 
> 	if (!callback(*pte))
> 		return addr >> PAGE_SIZE;
> 	return 0;
> }
> 
> unsigned long verify_page_range(struct mm_struct *mm,
> 				unsigned long addr, unsigned long size,
> 				vpr_fn_t callback)
> {
> 	return apply_to_page_range(mm, addr, size, vpr_fn, callback) << PAGE_SIZE;
> }
> 
> But maybe I'm missing something?

That covers only (32+12) bits of address space and will mostly work, but
we definitely support architectures (very much including x86_64) with
larger address spaces than that.
