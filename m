Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17A644313A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhKBPJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 11:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhKBPIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:08:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266FDC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 08:06:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j1so11884420qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VroI1JUj2TTWzELMwXyHiZqn8NIRBkFCrP9dHy/2068=;
        b=TdTfAWEhPGmwY1t5Tz+OjaidTjXzVu37QuKGZvyzGdFPsPQ68kgut5D6vTETHd89zE
         AimP2YcrxRLRuErNCczADVkRGj46k9i6XAe3eHyYE5vAMDKxjRarMr/FmPAYfSzwhXIU
         wASX/WagNYKc6SskYHXWgYWOf2wQ68qiDNZULOWAzsKePq48elWgb2xIo+PYJiVJYV9P
         AACN5g54KbpWXPNtu56dqsgVAWgzk/xF2ji2xrj60KmR6v8yKlBlNBrXcCe1noDQzveV
         BOsfPaO8/txKri8C82ynqyDVRqLkJ0NGDGG/rXToBWpN6tZITiNZIUKDO3YHi2UfX7Mt
         LgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VroI1JUj2TTWzELMwXyHiZqn8NIRBkFCrP9dHy/2068=;
        b=mz07tQqU7j0UNXfcix0KEK28tPDgjh307rOWathaFbVHVeZXDFYXy+p7Q4bif27Zmu
         Wge0P7omam+B4zVLI+na7JtKYAAtnRFiBizI7QQdymPCfqEj5AamNY12IlgZwFa8D5y2
         d9T/J+EDOqSXxorYZ5T3pyleMBGjCyM95+aKZXUHriv1NW4b8zBivKM8I+rgQaK9HNZ1
         jsmAyiXWEI7S0DBUi7J2bU639Q/CpWuK5/nvRwC0ZrY4YRxObveDAg2mnfBAWkqPn6lu
         7OCE6pLaWkpYtHKeW1U8lG5pSPjh/k5bbZGbjqSb7ljpAgQBZHiaX9fhlb98G6f15oDV
         xXzg==
X-Gm-Message-State: AOAM5320uj72TXNpodaJfWjIUOnD+1Z/revvKZdt9vtXp8RD2rRm+IW1
        W1BBZfuuu6lYTNO8CNZQLdUqg9u/s4Jggw==
X-Google-Smtp-Source: ABdhPJxVUzgtID5bD2MMMjfb3b3MU1mwCq6h2NmHyS9aw+r9gLXRj8h6riewjH8XjvjTkse+w0rJig==
X-Received: by 2002:ac8:7dcb:: with SMTP id c11mr38510553qte.12.1635865579154;
        Tue, 02 Nov 2021 08:06:19 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id h14sm8386099qth.23.2021.11.02.08.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:06:18 -0700 (PDT)
Date:   Tue, 2 Nov 2021 11:06:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <YYFT6VtNT1Fvl4Iz@cmpxchg.org>
References: <20210819195533.211756-1-hannes@cmpxchg.org>
 <20210819195533.211756-4-hannes@cmpxchg.org>
 <YS0oV23m5NfyMcJJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0oV23m5NfyMcJJ@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

Sorry about the delay, I'm just now getting back to these patches.

On Mon, Aug 30, 2021 at 11:49:59AM -0700, Minchan Kim wrote:
> Hi Johannes,
> 
> On Thu, Aug 19, 2021 at 03:55:33PM -0400, Johannes Weiner wrote:
> > Currently it requires poking at debugfs to figure out the size of the
> > zswap cache size on a host. There are no counters for reads and writes
> > against the cache. This makes it difficult to understand behavior on
> > production systems.
> > 
> > Print zswap memory consumption in /proc/meminfo, count zswapouts and
> > zswapins in /proc/vmstat.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  fs/proc/meminfo.c             |  4 ++++
> >  include/linux/swap.h          |  4 ++++
> >  include/linux/vm_event_item.h |  4 ++++
> >  mm/vmstat.c                   |  4 ++++
> >  mm/zswap.c                    | 11 +++++------
> >  5 files changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > index 6fa761c9cc78..2dc474940691 100644
> > --- a/fs/proc/meminfo.c
> > +++ b/fs/proc/meminfo.c
> > @@ -86,6 +86,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >  
> >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> > +#ifdef CONFIG_ZSWAP
> > +	seq_printf(m,  "Zswap:          %8lu kB\n",
> > +		   (unsigned long)(zswap_pool_total_size >> 10));
> 
> Since we have zram as well as zswap, it would be great if
> we can abstract both at once without introducing another
> "Zram: " stuff in meminfo. A note: zram can support fs based on
> on zram blk device as well as swap. Thus, term would be better
> to say "compressed" rather than "swap".
> 
> How about this?
> 
> "Compressed: xx kB"

Wouldn't it make more sense to keep separate counters? Zswap and zram
are quite different from each other.

From an MM perspective, zram is an opaque storage backend. zswap OTOH
is an explicit MM cache stage which may in the future make different
decisions than zram, be integrated into vmscan's LRU hierarchy
etc. And in theory, you could put zswap with fast compression in front
of a zram device with denser compression, right?

I agree zram should probably also have memory counters, but I think it
makes sense to recognize zswap as a unique MM layer.
