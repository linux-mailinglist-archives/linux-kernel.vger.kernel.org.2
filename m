Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD464390FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhJYITc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:19:32 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:34558 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhJYITa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:19:30 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 3AA29B00100; Mon, 25 Oct 2021 10:17:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 377EAB0006A;
        Mon, 25 Oct 2021 10:17:08 +0200 (CEST)
Date:   Mon, 25 Oct 2021 10:17:08 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Do we really need SLOB nowdays?
In-Reply-To: <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021, Hyeonggon Yoo wrote:

> > Better for what use case?  SLOB is for machines with 1-16MB of RAM.
> >
>
> 1~16M is smaller than I thought. Hmm... I'm going to see how it works on
> tiny configuration. Thank you Matthew!

Is there any reference where we can see such a configuration? Sure it does
not work with SLUB too?

