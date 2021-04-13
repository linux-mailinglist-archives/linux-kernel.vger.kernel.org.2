Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A1E35D91B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhDMHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhDMHjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:39:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D365C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qiMozfse1ylK7l2xDfgLoNIFT6bNFBlMbrxg4GooV1s=; b=UD2Y8PFbs0xVNGOqw1H3pLJCRv
        wM10LfvBbRL/39M1Tyjp+W5Q+mR5BNpFWb7KXu6tZm+tnHEvSyk0C5w0fJtwR/UskSnCusTB3e0NU
        EMP9ZcmBl6xwdPN9iT/s3Y6oZjklp4ypiOiure0d6oRT+SbRL4iavkFCy7q0G4+fLDo+uK/Bv5+Hn
        UIo+fN58zb4+E01+fySJsDy2qxFujCk3xmTbkEIri1+0HZ7I0paj26LBh+HHZcz5eaAuGlhrDT0H+
        XrotGzlHsbobL1ruJrjlTHn3+1bFMRI4Eb8ET0Sg2x/EGHSq1wHxZcqV4tHjVCXFJLjxetbZpAetf
        MwHSazIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWDb7-005PuV-Hl; Tue, 13 Apr 2021 07:37:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B71A30022D;
        Tue, 13 Apr 2021 09:36:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DA2920224209; Tue, 13 Apr 2021 09:36:32 +0200 (CEST)
Date:   Tue, 13 Apr 2021 09:36:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 4/7] mm: Introduce verify_page_range()
Message-ID: <YHVKACnVLAhbnt4j@hirez.programming.kicks-ass.net>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.769864829@infradead.org>
 <202104121302.57D7EF8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104121302.57D7EF8@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 01:05:09PM -0700, Kees Cook wrote:
> On Mon, Apr 12, 2021 at 10:00:16AM +0200, Peter Zijlstra wrote:
> > +struct vpr_data {
> > +	int (*fn)(pte_t pte, unsigned long addr, void *data);
> > +	void *data;
> > +};
> 
> Eeerg. This is likely to become an attack target itself. Stored function
> pointer with stored (3rd) argument.
> 
> This doesn't seem needed: only DRM uses it, and that's for error
> reporting. I'd rather plumb back errors in a way to not have to add
> another place in the kernel where we do func+arg stored calling.

Is this any better? It does have the stored pointer, but not a stored
argument, assuming you don't count returns as arguments I suppose.

The alternative is refactoring apply_to_page_range() :-/

---

struct vpr_data {
	bool (*fn)(pte_t pte, unsigned long addr);
	unsigned long addr;
};

static int vpr_fn(pte_t *pte, unsigned long addr, void *data)
{
	struct vpr_data *vpr = data;
	if (!vpr->fn(*pte, addr)) {
		vpr->addr = addr;
		return -EINVAL;
	}
	return 0;
}

/**
 * verify_page_range() - Scan (and fill) a range of virtual memory and validate PTEs
 * @mm: mm identifying the virtual memory map
 * @addr: starting virtual address of the range
 * @size: size of the range
 * @fn: function that verifies the PTEs
 *
 * Scan a region of virtual memory, filling in page tables as necessary and
 * calling a provided function on each leaf, providing a copy of the
 * page-table-entry.
 *
 * Similar apply_to_page_range(), but does not provide direct access to the
 * page-tables.
 *
 * NOTE! this function does not work correctly vs large pages.
 *
 * Return: the address that failed verification or 0 on success.
 */
unsigned long verify_page_range(struct mm_struct *mm,
				unsigned long addr, unsigned long size,
				bool (*fn)(pte_t pte, unsigned long addr))
{
	struct vpr_data vpr = {
		.fn = fn,
		.addr = 0,
	};
	apply_to_page_range(mm, addr, size, vpr_fn, &vpr);
	return vpr.addr;
}
EXPORT_SYMBOL_GPL(verify_page_range);
