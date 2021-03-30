Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1F34EA77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhC3Odz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:33:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:54172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231873AbhC3Od1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:33:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617114806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wBgZ8tlZn3Xixh8yXIPbPVU7d9PQptM+o2bcwOjOm30=;
        b=BTzZdQ9MYcl7OPDNQG625jiwI2Vw3U2cUsGpzLB4NG1ERtogcEinUyPJnWqchFiYSjbvyf
        6dkcFb64RlHf4Io+xSlyrtNH+LH0uy3P4JptrUNoF9BYbKKv6pWxB60ZJzn/XRiSKljnGG
        N9iRDSVqa04MfRFx4UIrxxFh4QUKP/8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F1B6B312;
        Tue, 30 Mar 2021 14:33:26 +0000 (UTC)
Date:   Tue, 30 Mar 2021 16:33:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: rename vprintk_func to vprintk
Message-ID: <YGM2tZrypKIzTBmF@alley>
References: <20210323144201.486050-1-linux@rasmusvillemoes.dk>
 <YGMad9xq1avluv5T@alley>
 <87k0po4x1o.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0po4x1o.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-30 14:59:31, John Ogness wrote:
> On 2021-03-30, Petr Mladek <pmladek@suse.com> wrote:
> > On Tue 2021-03-23 15:42:01, Rasmus Villemoes wrote:
> >> The printk code is already hard enough to understand. Remove an
> >> unnecessary indirection by renaming vprintk_func to vprintk (adding
> >> the asmlinkage annotation), and removing the vprintk definition from
> >> printk.c. That way, printk is implemented in terms of vprintk as one
> >> would expect, and there's no "vprintk_func, what's that? Some function
> >> pointer that gets set where?"
> >> 
> >> The declaration of vprintk in linux/printk.h already has the
> >> __printf(1,0) attribute, there's no point repeating that with the
> >> definition - it's for diagnostics in callers.
> >> 
> >> linux/printk.h already contains a static inline {return 0;} definition
> >> of vprintk when !CONFIG_PRINTK.
> >> 
> >> Since the corresponding stub definition of vprintk_func was not marked
> >> "static inline", any translation unit including internal.h would get a
> >> definition of vprintk_func - it just so happens that for
> >> !CONFIG_PRINTK, there is precisely one such TU, namely printk.c. Had
> >> there been more, it would be a link error; now it's just a silly waste
> >> of a few bytes of .text, which one must assume are rather precious to
> >> anyone disabling PRINTK.
> >> 
> >> $ objdump -dr kernel/printk/printk.o
> >> 00000330 <vprintk_func>:
> >>  330:   31 c0                   xor    %eax,%eax
> >>  332:   c3                      ret
> >>  333:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
> >>  33a:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
> >> 
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >
> > Nice clean up!
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> >
> > John,
> >
> > it conflicts with the patchset removing printk safe buffers[1].
> > Would you prefer to queue this into the patchset?
> > Or should I push it into printk/linux.git, printk-rework and you would
> > base v2 on top of it?
> 
> Please push it to printk-rework. I will base my v2 on top of it.

The patch is committed in printk/linux.git, branch printk-rework.
It is queued for 5.13.

Best Regards,
Petr
