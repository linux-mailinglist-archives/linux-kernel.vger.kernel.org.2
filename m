Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4E39168F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhEZLu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:50:57 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58659 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234176AbhEZLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:49:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B1BFD5808F7;
        Wed, 26 May 2021 07:48:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 26 May 2021 07:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=NVrV83ylHo/JpBsLwqDIkQDDRA6
        5xWvrqb+9zDgBt9M=; b=izB/NiqdB3D7Z0I6K65Ys263RI7tlRdBPoB1qX2qqsx
        ongptN9Q/PLHHo4sup96VaNh5S3HjSCP882F1xU5bTDX7UYG26yQzCSPKxUDTRC0
        6qcii7WdMs9Hav/wLXKDGox3iUTkbEz1gcEOJ/fAMcK4iu7da6SU8DKL2UU5Yr4g
        yk2psoQh2RNDv8EHF6GSPWzVFwjKzpMtvz53OWbOB+Wrg0OlrW5nP0qWkN4fD6YQ
        8fA3+vm0Vbhvv1GHqmnfW77O5EAJuFQyDWp79+F6tXbyv2kZkuc/CfpIrDc3rdB7
        tyP16Ra1r74nVnPefNVPkybfGqQ+isV8+TPgF5+3dww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=NVrV83
        ylHo/JpBsLwqDIkQDDRA65xWvrqb+9zDgBt9M=; b=k3RJMsGHthf0w3lkjiIGCI
        RsVScrta7FzxE1P2bq9qYT03ia7qxsGGOb2owCZbxtmeAbbdcGxPHK3O3gbeNk4X
        +e4LLCk4Px1Mh+7YoIcAlm6KAjAwqZwRzj3xNzZaT7H01jWU1qyKi+IOPLuqcZaj
        xH6zdCV+tdUEFhwP00Fjl10AEmdJXLQj5sdJAtQjyxVuWKUIpW9zKDHyWE3F/X6L
        +KaS7wzb6Vis3oUWwYeIYb5tg5VUVuQyilFbN7xg78OXEPnVLRciI7zgZ/RiixRH
        n4kdQqgkMfZQQ97TIexlLpU1U/a6kmwjhV/MC1e09d27eYk4A177NPkhmpWajTaA
        ==
X-ME-Sender: <xms:ezWuYGgUvm4hQjFnwVU5yRyoGuz22J1J6bBBrC9Admf34Uj14uSxdg>
    <xme:ezWuYHA8GjXADqj2DR02Q2gZ_bGAcPGZLCuwpIRMbX5FMcF8bjVV6jddyFmVAqi1j
    cRGMPdFfuSOUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekfedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuleeltd
    ehkeeltefhleduuddvhfffuedvffduveegheekgeeiffevheegfeetgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghh
    rdgtohhm
X-ME-Proxy: <xmx:ezWuYOGzGP3di7aQIUkXkTyKKjv8KsrOAJp6L6WDgRTGRaoIbSRDXw>
    <xmx:ezWuYPQocCst6HHZTrSUpN6URn-yIuPSAowoWao3vVxAVx711pAU8A>
    <xmx:ezWuYDxswNi7M66YepnZSjBqAF07b3OKjZFcVVUI1rAxXfP8n4CGAw>
    <xmx:fTWuYEFXqNS6mJueIgQRtCj3M67OP7No1zVV6tWiwQpsuLD5DcxMYw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 26 May 2021 07:48:10 -0400 (EDT)
Date:   Wed, 26 May 2021 13:48:08 +0200
From:   Greg KH <greg@kroah.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, glittao@gmail.com,
        vinmenon@codeaurora.org
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <YK41eFeL5j4qqSnV@kroah.com>
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <86d843f0-bbef-7c3b-6b6a-5d6b32434bee@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d843f0-bbef-7c3b-6b6a-5d6b32434bee@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 01:38:55PM +0200, Vlastimil Babka wrote:
> On 5/25/21 9:38 AM, Faiyaz Mohammed wrote:
> > alloc_calls and free_calls implementation in sysfs have two issues,
> > one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> > to "one value per file" rule.
> > 
> > To overcome this issues, move the alloc_calls and free_calls implemeation
> > to debugfs.
> > 
> > Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> > to be inline with what it does.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> These were IIRC bot reports for some bugs in the previous versions, so keeping
> the Reported-by: for the whole patch is misleading - these were not reports for
> the sysfs issues this patch fixes by moving the files to debugfs.
> 
> > Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> > ---
> > changes in V7:
> >         - Drop the older alloc_calls and free_calls interface.
> > changes in v6:
> >         - https://lore.kernel.org/linux-mm/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/
> > 
> > changes in v5:
> >         - https://lore.kernel.org/linux-mm/1620296523-21922-1-git-send-email-faiyazm@codeaurora.org/
> > 
> > changes in v4:
> >         - https://lore.kernel.org/linux-mm/1618583239-18124-1-git-send-email-faiyazm@codeaurora.org/
> > 
> > changes in v3:
> >         - https://lore.kernel.org/linux-mm/1617712064-12264-1-git-send-email-faiyazm@codeaurora.org/
> > 
> > changes in v2:
> >         - https://lore.kernel.org/linux-mm/3ac1d3e6-6207-96ad-16a1-0f5139d8b2b5@codeaurora.org/
> > 
> > changes in v1:
> >         - https://lore.kernel.org/linux-mm/1610443287-23933-1-git-send-email-faiyazm@codeaurora.org/
> > 
> >  include/linux/slub_def.h |   8 ++
> >  mm/slab_common.c         |   9 ++
> >  mm/slub.c                | 353 ++++++++++++++++++++++++++++++++++-------------
> >  3 files changed, 276 insertions(+), 94 deletions(-)
> 
> I don't see any of the symlinks under /sys/kernel/debug/slab/, so I think the
> aliases handling code is wrong, and I can see at least two reasons why it could be:
> 
> > @@ -4525,6 +4535,8 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
> >  			s->refcount--;
> >  			s = NULL;
> >  		}
> > +
> > +		debugfs_slab_alias(s, name);
> 
> Here you might be calling debugfs_slab_alias() with NULL if the
> sysfs_slab_alias() above returned true.
> 
> >  	}
> >  
> >  	return s;
> 
> ...
> 
> > +static int __init slab_debugfs_init(void)
> > +{
> > +	struct kmem_cache *s;
> > +
> > +	slab_debugfs_root = debugfs_create_dir("slab", NULL);
> > +
> > +	slab_state = FULL;
> > +
> > +	list_for_each_entry(s, &slab_caches, list)
> > +		debugfs_slab_add(s);
> > +
> > +	while (alias_list) {
> > +		struct saved_alias *al = alias_list;
> 
> alias_list a single list and both slab_sysfs_init() and slab_debugfs_init()
> flush it. So only the init call that happens to be called first, does actually
> find an unflushed list. I think you
> need to use a separate list for debugfs (simpler) or a shared list with both
> sysfs and debugfs processing (probably more complicated).
> 
> And finally a question, perhaps also for Greg. With sysfs, we hand out the
> lifecycle of struct kmem_cache to sysfs, to ensure we are not reading sysfs
> files of a cache that has been removed.
> 
> But with debugfs, what are the guarantees that things won't blow up when a
> debugfs file is being read while somebody calls kmem_cache_destroy() on the cache?

It's much harder, but usually the default debugfs_file_create() will
handle this for you.  See the debugfs_file_create_unsafe() for the
"other" variant where you know you can tear things down "safely".

That being said, yes there are still issues in this area, be careful
about what tools you expect to be constantly hitting debugfs files.

thanks,

greg k-h
