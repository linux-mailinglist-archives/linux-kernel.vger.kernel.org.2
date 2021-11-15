Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312BD4501A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhKOJvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:51:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41702 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhKOJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:51:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 029891FD65;
        Mon, 15 Nov 2021 09:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636969685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMLEhCAr/EzWlOcWmhx1Hln3rb0NJGrBCvMunwDh9E4=;
        b=TW1DFmMn7jfxRJ94KzmV/14bVkJYGXDBnUmRSzKAm+kPugntIh1mwX8+cpmGQZrMhrARS/
        EpNdTgHfPb9BMxbTpX2pfV+WMU5dqH/Mw9waZjg3LXDb+R6r5MdCLyZA/WUZwp+2sI9MgY
        98B901w/rpbFg8RgwZmJrgKjL8dWlFE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D42EA3BA2;
        Mon, 15 Nov 2021 09:48:04 +0000 (UTC)
Date:   Mon, 15 Nov 2021 10:48:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] printk: Remove printk.h inclusion in percpu.h
Message-ID: <YZIs1FvxA0hKylNd@alley>
References: <20211112140749.80042-1-andriy.shevchenko@linux.intel.com>
 <YY6vV2zUTdH5SNt5@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY6vV2zUTdH5SNt5@fedora>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-11-12 13:15:51, Dennis Zhou wrote:
> On Fri, Nov 12, 2021 at 04:07:49PM +0200, Andy Shevchenko wrote:
> > After the commit 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> > in NMI") the printk.h is not needed anymore in percpu.h.
> > 
> > Moreover `make headerdep` complains (an excerpt)
> > 
> > In file included from linux/printk.h,
> >                  from linux/dynamic_debug.h:188
> >                  from linux/printk.h:559 <-- here
> >                  from linux/percpu.h:9
> >                  from linux/idr.h:17
> > include/net/9p/client.h:13: warning: recursive header inclusion
> > 
> > Yeah, it's not a root cause of this, but removing will help to reduce
> > the noise.
> > 
> > Fixes: 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> > in NMI")

Yup, the include was there because of printk_func_t definition that
was removed by the above commit.

Reviewed-by: Petr Mladek <pmladek@suse.com>

> Hey Andrew, it doesn't seem like I have anything big coming through
> percpu, do you mind taking this. I might have some stuff due to sh, but
> I'm still working on that with them.

I assume that either Andrew or Dennis will take this patch.

Best Regards,
Petr
