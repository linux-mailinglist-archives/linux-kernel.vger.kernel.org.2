Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F5243E08A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJ1MMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1MMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:12:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D2DC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HnIPIz1Bo0Ynwn+sYrbhv3my97lwh0tcbKiXs+mpWtw=; b=R6oXosoLei0qPmZX+wQloT1fva
        deIL4kIjiMx9dwFPJt12fB28g7tvBxefRpn4EAFPJ5Yt+bmq40Qc72vx3EiX4d5ZVD+cmZsSxGaME
        JrTSFYs/15BDjQlB54nz+ajt/Se0czGD6UNKuu7JeMMvPb2osCzy9CqpwIE6BuH4UcR42DDvVWtDY
        VD3zINwLdbFS54x9EMBht0PfPfGCV2uLFUXHtPxf35WcUWL+KMtDtlaJs3xBHEDfj/pxaHJqWvHUW
        L2C4BY/xrP5tSmpKdC1hiFdtR4Cz882C4axWLHDvpwCuAOSxKPioa8swA9vbxuD/AEXH/IrqtoV6d
        JmXsDFaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg4CQ-000kha-PT; Thu, 28 Oct 2021 12:08:19 +0000
Date:   Thu, 28 Oct 2021 13:08:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Do we really need SLOB nowdays?
Message-ID: <YXqSoo+b9RTclW/2@casper.infradead.org>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
 <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:04:14AM +0000, Hyeonggon Yoo wrote:
> On Mon, Oct 25, 2021 at 10:17:08AM +0200, Christoph Lameter wrote:
> > On Mon, 18 Oct 2021, Hyeonggon Yoo wrote:
> > 
> > > > Better for what use case?  SLOB is for machines with 1-16MB of RAM.
> > > >
> > >
> > > 1~16M is smaller than I thought. Hmm... I'm going to see how it works on
> > > tiny configuration. Thank you Matthew!
> > 
> > Is there any reference where we can see such a configuration? Sure it does
> > not work with SLUB too?
> 
> I thought why Matthew said "SLOB is for machines with 1-16MB of RAM"
> is because if memory is so low, then it is sensitive to memory usage.
> 
> (But I still have doubt if we can run linux on machines like that.)

I sent you a series of articles about making Linux run in 1MB.
