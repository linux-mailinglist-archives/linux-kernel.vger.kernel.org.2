Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5FD35EB34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 05:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345223AbhDNDBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 23:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbhDNDBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:01:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66748C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:01:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y16so12775088pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TAR5yqsN9HoAFUY9r76iY0/Z55yb+yClu81GmGqClH8=;
        b=AxctJN4YKisiNN3mi+jR9a4PjDrVydjLyKAjdhLsmYrQmMrpv2qEobv2Nvyg0HNTWx
         7szvLEm1gEw15HdvEMw40HI+RO95vOD0oLwcO6a8e7OFu4XSukj3DnnIKTZ8dpsRwLw0
         podg0eVzOhWXD4N6oDRZgcgEPZIKqHA6fEZeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TAR5yqsN9HoAFUY9r76iY0/Z55yb+yClu81GmGqClH8=;
        b=X2VQG/Lrr3RDW2JVUabRlJIKG/XEFtF/qDqUhsOLhPlNNE6UD9eo1+KQN349q3Mp5E
         8g6bQlKR+SxCz+oSajlB0fqbMi/KuNn+SIXonbW7CsC5Oe5cpRWD0pZxlVp4iJkLQVIT
         0Nd267zIqaRElR+4Y16cncpvi1GyvlxxrLWsNkrghpO7FHRAIN2p3Qkb9kopylUMwpn5
         kCrIOJ0AC5KKLACLqn1YoXWKCv2HdY8hvYTTc4J0oQxJCHQQB//Q9GeDb92kuWokP2Kg
         grDbjw+2YhFjwcvYu/LKclq4kYUNA2UbZNSJKZXuJjumvp9iHPjzJ3CqQbpDTfRHBO9X
         Pr7A==
X-Gm-Message-State: AOAM5321lxKaisOTkixnKH4p6oKWySXf6Bwc/XHA+e+uUo+dykE9rRcv
        TmunzdYpQb4WymwVaIla6X9fJA==
X-Google-Smtp-Source: ABdhPJxny0HhvRRvjLB4ExxpMb0WRmAlIu/+/yKctZz3k66U0emA0Hktzp0YxGEbXWZI5dhhte4d4Q==
X-Received: by 2002:a05:6a00:796:b029:247:7a27:d612 with SMTP id g22-20020a056a000796b02902477a27d612mr22006953pfu.78.1618369269985;
        Tue, 13 Apr 2021 20:01:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c128sm13632751pfb.81.2021.04.13.20.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 20:01:09 -0700 (PDT)
Date:   Tue, 13 Apr 2021 20:01:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 4/7] mm: Introduce verify_page_range()
Message-ID: <202104131935.B5EBDAE@keescook>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.769864829@infradead.org>
 <202104121302.57D7EF8@keescook>
 <YHVKACnVLAhbnt4j@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHVKACnVLAhbnt4j@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 09:36:32AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 12, 2021 at 01:05:09PM -0700, Kees Cook wrote:
> > On Mon, Apr 12, 2021 at 10:00:16AM +0200, Peter Zijlstra wrote:
> > > +struct vpr_data {
> > > +	int (*fn)(pte_t pte, unsigned long addr, void *data);
> > > +	void *data;
> > > +};
> > 
> > Eeerg. This is likely to become an attack target itself. Stored function
> > pointer with stored (3rd) argument.
> > 
> > This doesn't seem needed: only DRM uses it, and that's for error
> > reporting. I'd rather plumb back errors in a way to not have to add
> > another place in the kernel where we do func+arg stored calling.
> 
> Is this any better? It does have the stored pointer, but not a stored
> argument, assuming you don't count returns as arguments I suppose.

It's better in the sense that it's not the func/arg pair that really
bugs me, yes. :)

> The alternative is refactoring apply_to_page_range() :-/

Yeah, I'm looking now, I see what you mean.

> ---
> 
> struct vpr_data {
> 	bool (*fn)(pte_t pte, unsigned long addr);
> 	unsigned long addr;
> };
> 
> static int vpr_fn(pte_t *pte, unsigned long addr, void *data)
> {
> 	struct vpr_data *vpr = data;
> 	if (!vpr->fn(*pte, addr)) {
> 		vpr->addr = addr;
> 		return -EINVAL;
> 	}
> 	return 0;
> }

My point about passing "addr" was that nothing in the callback actually
needs it -- the top level can just as easily report the error. And that
the helper is always vpr_fn(), so it doesn't need to be passed either.

So the addr can just be encoded in "int", and no structure is needed at:

typedef bool (*vpr_fn_t)(pte_t pte);

static int vpr_fn(pte_t *pte, unsigned long addr, void *data)
{
	vpr_fn_t callback = data;

	if (!callback(*pte))
		return addr >> PAGE_SIZE;
	return 0;
}

unsigned long verify_page_range(struct mm_struct *mm,
				unsigned long addr, unsigned long size,
				vpr_fn_t callback)
{
	return apply_to_page_range(mm, addr, size, vpr_fn, callback) << PAGE_SIZE;
}

But maybe I'm missing something?

-- 
Kees Cook
