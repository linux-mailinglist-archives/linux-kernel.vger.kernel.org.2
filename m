Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E81341F25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCSOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhCSOOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:14:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QHmsNWz5erj7LZSGlBMXaH8wQMGk/AE3dcxSEMqyrnE=; b=DpI7zKfWzFNb9DfteSYNkmk8G4
        ZpQqWZzYzJOR0G64GSTjVNUwxPndWcYq4tAPRh92BJ+DtBNdUThV/uoIzis9zvBWhossBby7d/P9J
        Pgzg3yj3Z8Sy13/y+/uPLVX61u8zLk5biedSd+gHSob7MftTAQtLndethcH1WzXxb5aAh3+ZGbxmc
        cJhuShFg6eYyQYw9+Yd/2BZmUGwRZFQhSwvSr6eCL2SaWwmXhhwogJJylxY+1sPq71+d28oy6UUo1
        CURDlj4/qAagGEqtWWXqZ34ekF5rfR8rnTK6atgH+uUWCaLgSpnfaJm3/8Z0QjZM4g7fKvCnUOE48
        0CNrkOjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNFsx-007Wbh-Rd; Fri, 19 Mar 2021 14:13:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E90683006E0;
        Fri, 19 Mar 2021 15:13:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDD082846DE2B; Fri, 19 Mar 2021 15:13:54 +0100 (CET)
Date:   Fri, 19 Mar 2021 15:13:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: Re: [PATCH 2/3] static_call: Align static_call_is_init() patching
 condition
Message-ID: <YFSxorIVeuA2zCXt@hirez.programming.kicks-ass.net>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.636651340@infradead.org>
 <f5ce3975-bda6-0e83-3a59-2fac25cc4f08@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ce3975-bda6-0e83-3a59-2fac25cc4f08@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 02:31:19PM +0100, Rasmus Villemoes wrote:
> On 18/03/2021 12.31, Peter Zijlstra wrote:
> > The intent is to avoid writing init code after init (because the text
> > might have been freed). The code is needlessly different between
> > jump_label and static_call and not obviously correct.
> > 
> > The existing code relies on the fact that the module loader clears the
> > init layout, such that within_module_init() always fails, while
> > jump_label relies on the module state which is more obvious and
> > matches the kernel logic.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/static_call.c |   14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> > 
> > --- a/kernel/static_call.c
> > +++ b/kernel/static_call.c
> > @@ -149,6 +149,7 @@ void __static_call_update(struct static_
> >  	};
> >  
> >  	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
> > +		bool init = system_state < SYSTEM_RUNNING;
> 
> I recently had occasion to look at whether that would be a suitable
> condition for knowing whether __init stuff was gone, but concluded that
> it's not. Maybe I'm wrong. init/main.c:

Ha, me too:

 https://lkml.kernel.org/r/YFMToXI/3qjlMur4@hirez.programming.kicks-ass.net

and I share your concern.

> Dunno, probably overkill, but perhaps we could have an atomic_t (or
> refcount, whatever) init_ref inited to 1, with init_ref_get() doing an
> inc_unless_zero, and iff you get a ref, you're free to call (/patch)
> __init functions and access __initdata, but must do init_ref_put(), with
> PID1 dropping its initial ref and waiting for it to drop to 0 before
> doing the *free_initmem() calls.

I'd as soon simply add another SYSTEM state. That way we don't have to
worry about who else looks at RUNNING for what etc..


