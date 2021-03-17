Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8352133EBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhCQIkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:40:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhCQIkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:40:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615970422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2tUqR+QOuEtivlT8obcEs1z/76QYTf+NAwPQM3o6OY=;
        b=ArCOUCid4SH2b+7tQUeMQGPCSTqdxfgwR6cdVUoC2Ee8xIK1fXrsGzNa/c6sWDOBokaWte
        h5a0qU6wCqtHzKF2zQAIBGuOvF8kYsfmgIKuxh5ro7arxwwCop9QFTmImByVbqSXXkaJqn
        Hr1L9D4vx2HoZvTvcxS/lj7P73/rIzQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58447AB8C;
        Wed, 17 Mar 2021 08:40:22 +0000 (UTC)
Date:   Wed, 17 Mar 2021 09:40:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YFHAdUB4lu4mJ9Ar@alley>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFDAfPCnS204jiD5@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-16 14:28:12, Chris Down wrote:
> Rasmus Villemoes writes:
> > I think it's pointless renaming the symbol to _printk, with all the
> > churn and reduced readability that involves (especially when reading
> > assembly "why are we calling _printk and not printk here?"). There's
> > nothing wrong with providing a macro wrapper by the same name
> > 
> > #define printk(bla bla) ({ do_stuff; printk(bla bla); })
> > 
> > Only two places would need to be updated to surround the word printk in
> > parentheses to suppress macro expansion: The declaration and the
> > definition of printk. I.e.
> > 
> > int (printk)(const char *s, ...)
> 
> Hmm, I'm indifferent to either. Personally I don't like the ambiguity of
> having both a macro and function share the same name and having to think
> "what's the preprocessor context here?".

I would prefer to keep _printk. I agree that it creates some churn but
it is easier to see what is going on. Also cscope is able to
find the right thing.

Otherwise, Rasmus, thanks a lot for the review and great hints
about the macro storing the metadata into the elf section.
I am not familiar with these things.

Best Regards,
Petr
