Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC1341A42
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhCSKlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:41:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:40396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhCSKk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:40:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616150458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zcMdkWdjkhhX9DyRchP3WC3AIFlJ6QbrvM8I9lCcwjE=;
        b=SIy2xAe5u45+/ndf0/uIbR380tAwjZoKdCntzgrBrkawqweQanMaGjD4GATXXUwX+1mz5i
        CSzSo/k1o93KWI4KKlsxkyJd8XB/mFxwqVoPWZGQbDJB9nNUzRb1qNp8x+Pw+3Z5qUXd1v
        1eMy4zasNUCCxWxGV7l05ToIz4LDob4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 669F1AC17;
        Fri, 19 Mar 2021 10:40:58 +0000 (UTC)
Date:   Fri, 19 Mar 2021 11:40:57 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/2] lib/vsprintf: do not show no_hash_pointers message
 multiple times
Message-ID: <YFR/uZBiR8EJYLNf@alley>
References: <20210305194206.3165917-1-elver@google.com>
 <YEX15gn0lfDpc1dw@alley>
 <CANpmjNMYoQ-xE9HY+DH+wO3BSGsuOjCxffchzUhuxWk4zhf3Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMYoQ-xE9HY+DH+wO3BSGsuOjCxffchzUhuxWk4zhf3Yw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-17 20:34:43, Marco Elver wrote:
> On Mon, 8 Mar 2021 at 11:01, Petr Mladek <pmladek@suse.com> wrote:
> > On Fri 2021-03-05 20:42:05, Marco Elver wrote:
> > > Do not show no_hash_pointers message multiple times if the option was
> > > passed more than once (e.g. via generated command line).
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Could you pick up this patch only?
> I think there's still controversy around how to best proceed with
> reducing space and we should drop patch 2/2 for now.
> 
> If you'd like me to re-send this standalone I can do so as well.

I have just committed the patch into printk/linux.git, branch
for-5.13.

Best Regards,
Petr
