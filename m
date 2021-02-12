Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC77A319C46
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhBLKC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:02:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:37962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhBLKCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:02:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613124094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cs26kCY0hsa0aqGGjDhuczNNgwFlToJBee0N36Ijfno=;
        b=gcuuKi2TtnV5+jXy9s7w1VdNVK1dg2XQ/Dq9U+YusvASWdvTKqTejXs5UO4WatYwBHsf07
        wOmdsYw1e34GLKTdAOnPiQnx76B9Sqs3dKr4emz0te5C5a6iyK2/KKLSkNN426ZdAtYrSI
        WvzdKglFl1TfnFx8S4QiwMk5646i6LQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95028ADDB;
        Fri, 12 Feb 2021 10:01:34 +0000 (UTC)
Date:   Fri, 12 Feb 2021 11:01:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Timur Tabi <timur@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] [v3] lib/vsprintf: debug_never_hash_pointers prints
 all addresses as unhashed
Message-ID: <YCZR/VQ6M61JIEN0@alley>
References: <20210210213453.1504219-1-timur@kernel.org>
 <20210210213453.1504219-4-timur@kernel.org>
 <20210211123118.GB31708@amd>
 <9f0c02d9-29d6-95ce-b9b7-27342aa70c6f@kernel.org>
 <20210211172026.GL308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211172026.GL308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-11 17:20:26, Matthew Wilcox wrote:
> On Thu, Feb 11, 2021 at 11:08:12AM -0600, Timur Tabi wrote:
> > 
> > 
> > On 2/11/21 6:31 AM, Pavel Machek wrote:
> > > Can we make this something shorter? Clearly you don't want people
> > > placing this in their grub config, so they'll be most likely typing
> > > this a lot...
> > > 
> > > debug_pointers or debug_ptrs would be better.
> > 
> > dbg_unhash_ptrs?  "debug_ptrs" is too vague IMHO, and I want to keep the
> > word "hash" somewhere there to indicate exactly what's happening.
> 
> no_hash_pointers ?

I am fine with this.

I am still a bit scared of a bikeshedng. But AFAIK, Mathew was most
active on proposing clear names. So, when he is fine with this...

Anyway, we should use the same name also for the variable.

Best Regards,
Petr
