Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE9F3CB80B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhGPNtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:49:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51796 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGPNtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:49:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 699491FEA9;
        Fri, 16 Jul 2021 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626443204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1tfWnlHj4mVpO7olTLAtvsBtx52Zsghaz5hp48XnhQ=;
        b=RSBi5lWkSGn4UfpBBEcNzs9qgd0A7ijXRR9Po3tyoeU461KU/J2Id8S4kFgXVo9DqRlGwJ
        rW9WKyKZJyATJNxsYJxZugZnqo3mC8CHbh8/fIXWb3wGTqfuQgiFzRvgNCgsNtqNJ0PKC/
        J5HoyGiSSqi0irGRQfMhVzj+O9WV7u4=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07FA1A3BB3;
        Fri, 16 Jul 2021 13:46:44 +0000 (UTC)
Date:   Fri, 16 Jul 2021 15:46:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] bitmap: introduce for_each_set_bitrange
Message-ID: <YPGNw4nRXsdaTHi4@alley>
References: <20210709034519.2859777-1-yury.norov@gmail.com>
 <20210709034519.2859777-3-yury.norov@gmail.com>
 <20210709095950.6a451ccb@oasis.local.home>
 <YPBZPbCgJPjV2qPW@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPBZPbCgJPjV2qPW@yury-ThinkPad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-07-15 08:50:21, Yury Norov wrote:
> On Fri, Jul 09, 2021 at 09:59:50AM -0400, Steven Rostedt wrote:
> > On Thu,  8 Jul 2021 20:45:19 -0700
> > Yury Norov <yury.norov@gmail.com> wrote:
> > 
> > > bitmap_list_string() is very ineffective when printing bitmaps with long
> > > ranges of set bits because it calls find_next_bit for each bit. We can do
> > > better by detecting ranges of set bits.
> > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > > index 87acf66f0e4c..1ee54dace71e 100644
> > > --- a/lib/vsprintf.c
> > > +++ b/lib/vsprintf.c
> > >  
> > > -			buf = number(buf, end, rtop, default_dec_spec);
> > > -		}
> > > +	if (buf > start)
> > > +		buf--;
> > 
> > If the above is to undo the last comma, please put back the first logic.
> 
> You're asking me to move part of the logic inside the loop which generally
> should be avoided. Is there any particular reason to do this?

vsprintf() should write what is needed and keep the rest of the given
buffer intact. There is even a test for this in the test_printf module.

I think that test_printf does not complain here because only a single
character is used and it is later replaced by the trailing '\0'.

By other words, undoing the last comma does not cause visible problems
in the end. But from vsprintf() point of view, it is a hack that does
not trigger the warning only by chance. And it is better to avoid it.

Best Regards,
Petr
