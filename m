Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D55C31E9FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhBRMkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:40:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:46680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhBRK7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:59:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613645912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yx8UvHFLOEGyp2IMZSmLxmNPWrPsYDF4mvl1D+05RmM=;
        b=FHRDnC7nZxhhDmbOuUlR8ZwgW5TILFG68B0oEDs1K23l/u6IRFNjB0G1/xKfgWBeUKyiBm
        k06uYThkSppb9bqeaC+PInhd3fFXChzCgBfFcsRjvGmcpPlnsXEI4c3M1gav3S4Cmc60Xy
        7I/0wFWmKG6i1X8IXZYC+R0SIpYUBE8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38196ACD4;
        Thu, 18 Feb 2021 10:58:32 +0000 (UTC)
Date:   Thu, 18 Feb 2021 11:58:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YC5IV9yAAg2t8PoX@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
 <YCwAbGoVuZJspcx5@chrisdown.name>
 <YCwycC8hPsPD7ArU@cmpxchg.org>
 <YCwzrLTaE9PwNihj@chrisdown.name>
 <YC06LyPGmytXJ8Iu@alley>
 <YC08tgirtDsZumkK@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC08tgirtDsZumkK@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-02-17 15:56:38, Chris Down wrote:
> Petr Mladek writes:
> > > > How about config PRINTK_INDEX?
> > > 
> > > Ah yes, I also like that. PRINTK_INDEX is fine from my perspective and is
> > > more straightforward than "enumeration", thanks.
> > 
> > It is better than enumeration. But there is still the same
> > problem. The word "index" is used neither in the code
> > nor in the debugfs interface. It is like enabling cars and
> > seeing apples.
> > 
> > What about CONFIG_PRINTK_DEBUGFS?
> > 
> > It seems that various subsystems use CONFIG_<SUBSYSTEM>_DEBUGFS
> > pattern when they expose some internals in debugfs.
> 
> The thing I don't like about that is that it describes a largely
> inconsequential implementation detail rather than the semantic intent of the
> config change, which is what the person deciding what to include in their
> config is likely to care about.  Often when I see "XXX debug interface" when
> doing `make oldconfig` I think to myself "yes, but what does the debugfs
> interface _do_?".

I see.

> If someone else was writing this patch, and I saw "CONFIG_PRINTK_DEBUGFS"
> appear in my prod kernel, I'd probably say N, because I don't need printk
> debugging information. On the other hand, if I saw "CONFIG_PRINTK_INDEX", I'd
> immediately understand that it's probably applicable to me.
> 
> I'm happy to rename the debugfs structure as <debugfs>/printk/fmt_index if it
> helps, but personally I really feel CONFIG_PRINTK_{INDEX,ENUMERATION,CATALOGUE}
> is a lot more descriptive than just saying "it has a debugfs interface" in the
> config name for that reason.

PRINTK_INDEX sounds the best to me. Keep in mind that I am not a
native speaker.

And my concern will be gone when we use it also in the API and debugfs
hierarchy as suggested by Johannes.

Another compromise might be to have CONFIG_PRINTK_FORMATS_INDEX.
Then the prefix printk_format_, pf_ would still match the option.
Or we could use printk_format_index_m, pfi_ indexes.

Best Regards,
Petr

PS: I feel that I have enough bike-shading. I think that I will be
    fine with anything that you choose ;-)
