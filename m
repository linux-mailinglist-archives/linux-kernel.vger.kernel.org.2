Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201514274B8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 02:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbhJIAg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 20:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhJIAg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 20:36:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E16C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 17:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xql+N3ib1eUlIjDNmObuElGGVllxpdEKF1ivrtTjnA4=; b=wSc1Df6rvCC4r06ynh69vQYqGw
        fe7y5D5XS7RiFwKZLwNYmFEoRjG6XG4H/m8JcH4WzhjljjJJ2tbuzxJqNW22w4ugJtgXCs/SGg0UI
        whzTQZgIjcKM4EICtdR3/bzBiSsRECIve1L+kkDBeGhJp1Ku8NXZmSHcTpjzYQxUqdClwt8O0qLYW
        HIX7MVhwdsfMMJrJgKSwtSUnRAa//y43nX6LPBsHKYt8t2XxZUeanjwEFs7phr48LVDp7VXoyzA+f
        /YLmeeoZUrqVhb9ycDgw+nIKNWVdqA25tSbAFse0c9X8tiXzQC/JGG0YbtNy8fL/ED2Y2INZ/W08L
        wcVJZFrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZ0J5-003kwH-W8; Sat, 09 Oct 2021 00:33:51 +0000
Date:   Sat, 9 Oct 2021 01:33:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC] Some questions and an idea on SLUB/SLAB
Message-ID: <YWDjZ+KlkV2wKShh@casper.infradead.org>
References: <20211009001903.GA3285@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009001903.GA3285@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 12:19:03AM +0000, Hyeonggon Yoo wrote:
>  - Is there a reason that SLUB does not implement cache coloring?
>    it will help utilizing hardware cache. Especially in block layer,
>    they are literally *squeezing* its performance now.

Have you tried turning off cache colouring in SLAB and seeing if
performance changes?  My impression is that it's useful for caches
with low associativity (direct mapped / 2-way / 4-way), but loses
its effectiveness for caches with higher associativity.  For example,
my laptop:

 L1 Data Cache: 48KB, 12-way associative, 64 byte line size
 L1 Instruction Cache: 32KB, 8-way associative, 64 byte line size
 L2 Unified Cache: 1280KB, 20-way associative, 64 byte line size
 L3 Unified Cache: 12288KB, 12-way associative, 64 byte line size

I very much doubt that cache colouring is still useful for this machine.
