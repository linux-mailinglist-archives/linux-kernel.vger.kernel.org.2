Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4055932C264
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376485AbhCCTnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:43:10 -0500
Received: from vmi485042.contaboserver.net ([161.97.139.209]:38388 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387439AbhCCTY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:24:29 -0500
Received: by gentwo.de (Postfix, from userid 1001)
        id 5B7F3B007D1; Wed,  3 Mar 2021 20:15:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 59AE2B005D8;
        Wed,  3 Mar 2021 20:15:58 +0100 (CET)
Date:   Wed, 3 Mar 2021 20:15:58 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/3] mm/slub: Use percpu partial free counter
In-Reply-To: <20210303142612.GC2723601@casper.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2103032012250.896915@gentwo.de>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com> <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com> <alpine.DEB.2.22.394.2103021012010.860725@gentwo.de> <20210303142612.GC2723601@casper.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021, Matthew Wilcox wrote:

> On Tue, Mar 02, 2021 at 10:14:53AM +0100, Christoph Lameter wrote:
> > On Mon, 10 Aug 2020, Xunlei Pang wrote:
> > > -	atomic_long_t partial_free_objs;
> > > +	atomic_long_t __percpu *partial_free_objs;
> >
> > A percpu counter is never atomic. Just use unsigned long and use this_cpu
> > operations for this thing. That should cut down further on the overhead.
>
> What about allocations from interrupt context?  Should this be a local_t
> instead?

Can this be allocated in an interrupt context?

And I am not sure how local_t relates to that? Percpu counters can be used
in an interrupt context without the overhead of the address calculations
that are required by a local_t.
