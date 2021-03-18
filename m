Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8828340ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhCRQ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhCRQ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:59:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27206C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pBMCG5FN4Ujt4bhtCchnpc3UVNfel7XA97T/t//xc88=; b=CkaN3OxB7tlQh5rjB6XsiU9y00
        9wtcSuBCtpVqrCfjXaQVx8wEJ2/rO3rUS14xLdWa8DGseOxmEHsouD4s9Ll+4Zfri+yPH3lNl/sva
        CswI/ObrGCZQ7Mojh8A7VJ5cap1HmraveY8i6RJbxozjhZaK8mX8Iha8CR9i0GI7fkJo5M7LeYPsP
        ur5ngVNb7tx7URNccnwqmWvTncnFs/D43R/XYK9Vb7kQ3XfVFhjeWxUevniWfsAn/mjvqYB0Lkljb
        Fh+OHaZZmzJzdHOu0KiFhpD3SkpjmCsJXOt+YHsCm/DRT/FXjAtPmx9ux7bb1NvXVgJqDNnITu2js
        sp0zPVZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMvyp-003Ffx-Pi; Thu, 18 Mar 2021 16:58:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C670E3003E1;
        Thu, 18 Mar 2021 17:58:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A98FB21244792; Thu, 18 Mar 2021 17:58:38 +0100 (CET)
Date:   Thu, 18 Mar 2021 17:58:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.739542434@infradead.org>
 <20210318161308.vu3dhezp2lczch6f@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318161308.vu3dhezp2lczch6f@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 11:13:08AM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 18, 2021 at 12:31:59PM +0100, Peter Zijlstra wrote:
> >  			if (!kernel_text_address((unsigned long)site_addr)) {
> > -				WARN_ONCE(1, "can't patch static call site at %pS",
> > +				/*
> > +				 * This skips patching __exit, which is part of

				  This skips patching built-in __exit, ...
?

> > +				 * init_section_contains() but is not part of
> > +				 * kernel_text_address().
> > +				 *
> > +				 * Skipping __exit is fine since it will never

		+ built-in, again

> > +				 * be executed.
> > +				 */
> > +				WARN_ONCE(!static_call_is_init(site),
> > +					  "can't patch static call site at %pS",
> >  					  site_addr);
> >  				continue;
> >  			}
> 
> It might be good to clarify the situation for __exit in modules in the
> comment and/or changelog, as they both seem to be implicitly talking
> only about __exit in vmlinux.

Correct.

> For CONFIG_MODULE_UNLOAD, the code ends up in the normal text area, so
> static_call_is_init() is false and kernel_text_address() is true.
> 
> For !CONFIG_MODULE_UNLOAD, the code gets discarded during module load,
> so static_call_is_init() and kernel_text_address() are both false.  I
> guess that will trigger a warning?

Oh gawd, more variants.

Afaict MODULE_UNLOAD, by virtue of that #ifdef in
rewrite_section_headers() won't even load the .exit sections. Afaict
that will break: alterative, jump_label and static_call patching all in
one go.


