Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4B32C2C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352945AbhCDACq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387997AbhCCURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:17:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABD1C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 12:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gndyAcqrFEb63lWZfXawPqTaD/MPoQSVtS2l/6X7nOE=; b=Hy0MCL/pcPG630Jq37Pi6sfRtV
        0ZAZLuuOX51OLePqKr3e/vp3gLmwNjaSSyjBhstskI8wB2Xz9gAbeuYufynBjW8nKF2dWyA42V0/K
        EZOokb4u7ILkr0zMR0LTKoqMo9iFxSe4A0VVeHFTGuhUTKu96Z8uzBtGfOftzb4EI5Lm8AtF2OIob
        nnqQYbFhHVoiNEVnhdMxgKaXkZ/NnyIclhMEny94+NY67y/7QczxPlh6+e2/iimRss70Po2CrPDef
        jJSC41+VTZjuCmP7RPwpxxIv2elYgG565Q0CV0hkbg3DsJktqi+9PzTcoYaNzZ/lPHpEiBRClJLhn
        /BEY3sVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHXvN-0043UN-GD; Wed, 03 Mar 2021 20:16:52 +0000
Date:   Wed, 3 Mar 2021 20:16:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/3] mm/slub: Use percpu partial free counter
Message-ID: <20210303201649.GF2723601@casper.infradead.org>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
 <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com>
 <alpine.DEB.2.22.394.2103021012010.860725@gentwo.de>
 <20210303142612.GC2723601@casper.infradead.org>
 <alpine.DEB.2.22.394.2103032012250.896915@gentwo.de>
 <20210303193038.GE2723601@casper.infradead.org>
 <alpine.DEB.2.22.394.2103032032070.897408@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2103032032070.897408@gentwo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 08:55:48PM +0100, Christoph Lameter wrote:
> On Wed, 3 Mar 2021, Matthew Wilcox wrote:
> 
> > > Can this be allocated in an interrupt context?
> > >
> > > And I am not sure how local_t relates to that? Percpu counters can be used
> > > in an interrupt context without the overhead of the address calculations
> > > that are required by a local_t.
> >
> > As I understand the patch, this counts the number of partially free slabs.
> > So if we start to free an object from a completely full slab in process
> > context, as "load x, add one to x, store x" and take an interrupt
> > between loading x and adding one to x, that interrupt handler might
> > free a different object from another completely full slab.  that would
> > also load the same x, add one to it and store x, but then the process
> > context would add one to the old x, overwriting the updated value from
> > interrupt context.
> 
> this_cpu operations are "atomic" vs. preemption but on some platforms not
> vs interrupts. That could be an issue in kmem_cache_free(). This would
> need a modification to the relevant this_cpu ops so that interrupts are
> disabled on those platforms.

Hmmmm ... re-reading the documentation, it says that this_cpu_x is
atomic against interrupts:

These operations can be used without worrying about
preemption and interrupts::
[...]
        this_cpu_add(pcp, val)
        this_cpu_inc(pcp)
...

