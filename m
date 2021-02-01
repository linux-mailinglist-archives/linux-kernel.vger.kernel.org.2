Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF82530AFED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhBATBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhBATBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:01:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57118C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fgOq7F84WfyhkfPnzhyCYr96g+FlgtMswaV08yg0yE4=; b=RoXGhrP2Was+Jin2P0O/pP5PU+
        UszkgEQPN5Sv5YR3shwf87rddmm73hZHr7s8szxxhQOt0a16FxixuzmiMYv+7Zlhw70dtCVAwuwWx
        bUb1VprT6QEQNo2UAijR86NThUhJvn42SfobKO8wUd1oIsobCgAiRaBSoxCP1s0LcLOvX6vqKwDvN
        XIA5PToGWJgxG3pVlU4eYWWbvKZsx19bkjOZ6izzS1JPHM0jnIwItxUQ9LbKcjhdFM9l7+9PY/98R
        /K7QgL28EBVRdHOKkAOemy0b2g3Taa+8FSqmuK3rdn9ANvXmvsfAxHZlWVVUBxwC8i4xYbZa9rYET
        TVE9D92w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6eQG-00EBcI-VK; Mon, 01 Feb 2021 18:59:41 +0000
Date:   Mon, 1 Feb 2021 18:59:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, linmiaohe@huawei.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <20210201185940.GS308988@casper.infradead.org>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
 <20210201115610.87808-4-laoar.shao@gmail.com>
 <20210201141505.GR308988@casper.infradead.org>
 <9c475803276ea2b32cadc8f72d397c180475d0cc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c475803276ea2b32cadc8f72d397c180475d0cc.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 10:51:03AM -0800, Joe Perches wrote:
> On Mon, 2021-02-01 at 14:15 +0000, Matthew Wilcox wrote:
> > On Mon, Feb 01, 2021 at 07:56:10PM +0800, Yafang Shao wrote:
> > > - Before the patch,
> > > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> > > 
> > > - After the patch,
> > > [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)
> > 
> > I would suggest it will be easier to parse as:
> > 
> > flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> > 
> > That should alleviate the concerns about debugfs format change -- we've
> > never guaranteed that flag names won't change, and they now look enough
> > like flags that parsers shouldn't fall over them.
> 
> Seems sensible and would make the generating code simpler too.
> 
> But is it worth the vsprintf code expansion for the 5 current uses?
> 
> mm/debug.c:     pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
> mm/memory-failure.c:                    pr_info("soft offline: %#lx: %s migration failed %d, type %lx (%pGp)\n",
> mm/memory-failure.c:            pr_info("soft offline: %#lx: %s isolation failed, page count %d, type %lx (%pGp)\n",
> mm/memory-failure.c:            pr_info("%s: %#lx: unknown page type: %lx (%pGp)\n",
> mm/page_owner.c:                        "PFN %lu type %s Block %lu type %s Flags %#lx(%pGp)\n",
> 
> Wouldn't it be more sensible just to put this code in a new function
> call in mm?

Does it matter whether the code lives in vsprintf.c or mm/debug.c?  It's
built into the kernel core either way.  I'm not a huge fan of the current
way %pFoo is handled, but unless/until it's drastically revised, I don't
think this proposed patch makes anything worse.
