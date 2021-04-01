Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FBE3511B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhDAJPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:15:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhDAJOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:14:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617268488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNVeVEJsE2NrNnpG1ONXT+uOw5bYJLkau4SXRA3zVtY=;
        b=GRFP7NyKhoU4R3Df8eXeg/mty4f651aCNMyk12y/rdwQeK6fl4bVrfiimdQlcVB0giY/k6
        NLUIG/qpYN1Odp3Xmygn+0Z+MjnFMv47Lp9hQJTw4JhqBOsBl8MNXXPsZhYruek/IXkQzp
        GNzwnEg1mD2Q4UsVtqYP3SO7sHaryIc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3BD8AE6D;
        Thu,  1 Apr 2021 09:14:47 +0000 (UTC)
Date:   Thu, 1 Apr 2021 11:14:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>,
        Gary R Hook <gary.hook@amd.com>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-embedded@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing: Use pr_crit() instead of long fancy messages
Message-ID: <YGWPB8hPVVOIx4AG@alley>
References: <20210331093104.383705-1-geert+renesas@glider.be>
 <20210331093104.383705-3-geert+renesas@glider.be>
 <20210331094007.77aa5194@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331094007.77aa5194@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-31 09:40:07, Steven Rostedt wrote:
> On Wed, 31 Mar 2021 11:31:03 +0200
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> > This reduces kernel size by ca. 0.5 KiB.
> 
> If you are worried about size, disable tracing and it will go away
> entirely. 0.5KiB is a drop in the bucket compared to what tracing adds in
> size overhead.
> 
> Sorry, but NAK.
> 
> This has been very successful in stopping people from adding trace_printk()
> to the kernel, and I like to keep it that way.

I agree with Steven. I believe that the eye-catching form is
important.

Anyway, all three patches are replacing text that have
many common parts. It is:

	pr_warn("\n");
	pr_warn("**********************************************************\n");
	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
	pr_warn("**                                                      **\n");
	pr_warn("** <Something is enabled/used.>			 **\n");
	pr_warn("**                                                      **\n");
	pr_warn("** <Description of the effect and why it should not     **\n");
	pr_warn("** happen on production kernel>			**\n");
	pr_warn("**                                                      **\n");
	pr_warn("** If you see this message and you are not debugging    **\n");
	pr_warn("** the kernel, report this immediately to your vendor!  **\n");
	pr_warn("**                                                      **\n");
	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
	pr_warn("**********************************************************\n");

It might be useful to avoid cut&pasting this entire blob and unify the
common parts.

My only concern is how to define the caller-specific lines so that
they fit with the common ones. They should not be longer than the
header and footer. We need to find a good compromise between
usability and over-engineering.

Also we have to keep bikeshading under control ;-)

Best Regards,
Petr
