Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C758D34816C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbhCXTPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbhCXTOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:14:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6435C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xuIXN9DM58+ZI8uF5gWtrlgkEUmr5H+lsfiHvYZCbvk=; b=lwLYjlDDMzJc46I6P6XGkqMlRe
        FI/p74FHeQbkx9MqAUcXx7WJn0tyA4WLBq84BBk33U1wz5JgWtlXDXBuia0ujzql0EqTMemlBPjyp
        6Qlu+twXcCKY608qUPN++VRj/IfPH0pHyDx9eg8YSmQDA24q34fyOuAjhB+2PwRwgowi2VHk3dfCn
        jFbwmAPmbbmQz0dg2K+ppalqPbQjFlVbytaZRObMQp67gXzDnv/BwBJBxgFgbHUWUIimqQKUAJvND
        dINY1Aq8oybQJPkRNxDZJxQjioXwIrfbVzctxEECQFj3bNg9c+t/bgCOxgZE4V3g7t0iZpyBnPoGh
        9cxx5IFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lP8xI-00Bkmd-Cz; Wed, 24 Mar 2021 19:14:17 +0000
Date:   Wed, 24 Mar 2021 19:14:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add Vlad Rezki as vmalloc maintainer
Message-ID: <20210324191412.GR1719932@casper.infradead.org>
References: <20210324150518.2734402-1-willy@infradead.org>
 <20210324150518.2734402-5-willy@infradead.org>
 <fb2923d-3eef-974-c56b-3d95a031c98d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb2923d-3eef-974-c56b-3d95a031c98d@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:52:37AM -0700, David Rientjes wrote:
> >  MAINTAINERS                   | 7 +++++++
> >  arch/arm64/kernel/module.c    | 3 +--
> >  arch/arm64/net/bpf_jit_comp.c | 3 +--
> >  arch/parisc/kernel/module.c   | 5 ++---
> >  arch/x86/hyperv/hv_init.c     | 3 +--
> >  5 files changed, 12 insertions(+), 9 deletions(-)
> 
> Looks like we got some extra cleanups with this :)

Oops, those should have been squashed into 1/4.  I'll do a v3 later
this week.

> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8c44fd8fd85d..8b9cb5525cb1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19282,6 +19282,13 @@ S:	Maintained
> >  F:	drivers/vlynq/vlynq.c
> >  F:	include/linux/vlynq.h
> >  
> > +VMALLOC
> > +M:	Uladzislau Rezki <urezki@gmail.com>
> 
> Should be 'M' or 'R'?  (Not sure if Vlad will be pushing patches or not.)

Well, you & others are listed as M: for SLAB so I just copied what
was there.  I don't know what's best practice these days, but I think
they should match?

> > +L:	linux-mm@kvack.org
> > +S:	Maintained
> > +F:	mm/vmalloc.c
> > +F:	include/linux/vmalloc.h
