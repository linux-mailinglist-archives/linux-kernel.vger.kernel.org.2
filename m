Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF238AF45
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbhETMzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:55:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:60182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243263AbhETMxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:53:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621515111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VbT6WFYy0bkSk8HAYhg7anUqtgOM3QEr3KjCoKwSfHQ=;
        b=gOKAeXWpE3pQwkKpXwPHYoc4ERb31lQ3gBN7nTVt1yldwdnn1/3/XyAFth9rfgDimJkoQH
        agqxk+9Aox0SUUfXdjH85VkMEQazH8fYJyaFRs2tPVAJC3VdcHlyCnVzQyWN5LMIv2YHXJ
        O5RoTQ3j+3gflRxjf1BSBzx8QDoYDOo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A566ABE8;
        Thu, 20 May 2021 12:51:51 +0000 (UTC)
Date:   Thu, 20 May 2021 14:51:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Embedded <linux-embedded@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 3/3] lib/vsprintf: Use pr_crit() instead of long fancy
 messages
Message-ID: <YKZbZhACyIENhM8S@alley>
References: <20210331093104.383705-1-geert+renesas@glider.be>
 <20210331093104.383705-4-geert+renesas@glider.be>
 <CAMuHMdXQArCn9BS_8p0iUAgomfEHWe8ypg=B_SGfvJu8c_L5vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXQArCn9BS_8p0iUAgomfEHWe8ypg=B_SGfvJu8c_L5vg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-05-17 08:21:12, Geert Uytterhoeven wrote:
> On Wed, Mar 31, 2021 at 11:59 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > While long fancy messages have a higher probability of being seen than
> > small messages, they may scroll of the screen fast, if visible at all,
> > and may still be missed.  In addition, they increase boot time and
> > kernel size.
> >
> > The correct mechanism to increase importance of a kernel message is not
> > to draw fancy boxes with more text, but to shout louder, i.e. increase
> > the message's reporting level.  Making sure the administrator of the
> > system is aware of such a message is a system policy, and is the
> > responsability of a user-space log daemon.
> >
> > Fix this by increasing the reporting level from KERN_WARNING to
> > KERN_CRIT, and removing irrelevant text and graphics.
> >
> > This reduces kernel size by ca. 0.5 KiB.
> >
> > Fixes: 5ead723a20e0447b ("lib/vsprintf: no_hash_pointers prints all addresses as unhashed")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> No comments?
> Unlike the cases handled by the other two patches in this series,
> this one cannot be configured out.

IMHO, the best solution would be to create a generic API for
eye-catching messages.

I am sure that WARN() is misused on many locations all over the kernel
because people just wanted eye-catching message, for example, see
https://lore.kernel.org/r/2149df3f542d25ce15d049e81d6188bb7198478c.camel@fi.rohmeurope.com

It might be a win-win solution.

Best Regards,
Petr
