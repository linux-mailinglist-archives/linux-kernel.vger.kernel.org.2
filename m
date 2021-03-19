Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA7341B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhCSLVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCSLVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:21:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B/c1/v/uJnVkNMZDxHMA1QohOYeIhgtag02G8pqgtdo=; b=X+TgFlLI8t3Wl0yCgHN+igPFq1
        0+0pDKKY0YlazAxJLX3Y+eZrd1B/Gjs+GJUO6YE3ETwpXhzd08SPt52kNoaEeJSJI6dIEJm1IiUjX
        kxV66/aPGzFoxL9VPm1nKKnZ3jIKpHjacb91+XPTbhSliQM9F1gmG+IGm6JDaXalVAWt+HU0OHBzo
        C8XPbx3YGKFY8eSU8wrXyxylPh2yOoShuDFjeEcDRRpkh+OCLIG3tav20YGbNgFLLQe2XoMHRDdPf
        9sEOibXuWI54auy6nYvIY6kDjal/3UpxeTHqvZYnbkOBmfjFXkZ7OlM3LOAfsOpMhGWrwaytcCelZ
        N+46slkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNDBg-007K9K-72; Fri, 19 Mar 2021 11:21:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CF6F304BAE;
        Fri, 19 Mar 2021 12:21:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3635A2B4C3BE7; Fri, 19 Mar 2021 12:21:03 +0100 (CET)
Date:   Fri, 19 Mar 2021 12:21:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] objtool: Allow archs to rewrite retpolines
Message-ID: <YFSJH0/wiHLkteLw@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.131630843@infradead.org>
 <20210319025440.ah5kr7aztz4jbzer@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319025440.ah5kr7aztz4jbzer@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:54:40PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 18, 2021 at 06:11:15PM +0100, Peter Zijlstra wrote:
> > @@ -1212,6 +1225,8 @@ static int handle_group_alt(struct objto
> >  		dest_off = arch_jump_destination(insn);
> >  		if (dest_off == special_alt->new_off + special_alt->new_len)
> >  			insn->jump_dest = next_insn_same_sec(file, last_orig_insn);
> > +		else
> > +			insn->jump_dest = find_insn(file, insn->sec, dest_off);
> >  
> >  		if (!insn->jump_dest) {
> >  			WARN_FUNC("can't find alternative jump destination",
> 
> So I assume this change is because of the ordering change: now this is
> done before add_jump_destinations().

Correct.

> Also the new hunk to be an oversimplified version of
> add_jump_destinations().  I'm not quite convinced that it will always do
> the right thing for this case.

You're right; this is because of the reorder. At the time I thought this
was right, but looking at it now, I'm not sure. Esp. so when ARM64 comes
along and allows more relocations in alternatives.

Let me see if I can come up with something better.

> But doesn't that mean the alternative jump modification (changing the
> dest to the end of the original insns) will get overwritten later?

Good point, should be simple enough to fix by having
add_jump_destination() skip all that already have insn->jump_dest set I
suppose.

> > @@ -1797,11 +1812,15 @@ static int decode_sections(struct objtoo
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = add_jump_destinations(file);
> > +	/*
> > +	 * Must be before add_{jump,call}_destination; for they can add
> > +	 * magic alternatives.
> > +	 */
> > +	ret = add_special_section_alts(file);
> 
> This reordering is unfortunate.  Maybe there's a better way, though I
> don't have any ideas, at least until I get to the most controversial
> patch.

So the thing no longer crashes on the alternatives it writes, so we
*could* read back our own alternatives, but it does seem somewhat
unfortunate to do that. Too easy to get into cycles that way.
