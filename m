Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E663F5252
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhHWUgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:36:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42850 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhHWUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:36:46 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629750962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hyzgwb1o6IVyPBvQ3nUKZSabyVCsPXw9yoBJPqbMIzk=;
        b=pgcLL7tcB8OugO3K3nLEBVJKYpv4acJBACFqSRrAC9tq+r+yiuJA+dmlDQYK/21G5m1N8q
        9QuOK056huFmur9BFFL9r9wPko19l08FwLCbk4nm5kcNyqe0XL6puZ3Qi5Wu2YTFMU4MhW
        vbqadA1hQh/GeGOhflNMKN64TMpXmtxLIXP9LANuMSeAO8+lGGTfG2X9lk0fsoxLeTOvOP
        50D2t7O92a5DW19a0MXlrWBZ9DtojYaPJTHQUmjZKuYjXu28NZvb9v7oB8inV2P0FgSqVr
        cSlaanB2Z/riYjMwGbVw/0kohwwG1DmzaGm+vmiD+hUzxMuKVO5Sdr3eZoFx5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629750962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hyzgwb1o6IVyPBvQ3nUKZSabyVCsPXw9yoBJPqbMIzk=;
        b=dPAH2pc1RfTQqWlJjYXpzmr+tRqSpC30Sk4XSYjPJDrXCDW0obTk5hfkHRQOEr3T5Ye/Ky
        rkobwLZSfcZx83BQ==
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
In-Reply-To: <d37d2de9-b5b2-dbdd-5228-065b475f913a@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-36-vbabka@suse.cz>
 <e907c2b6-6df1-8038-8c6c-aa9c1fd11259@suse.cz>
 <20210817125325.d0ed45d664596d1e80a591d7@linux-foundation.org>
 <d37d2de9-b5b2-dbdd-5228-065b475f913a@suse.cz>
Date:   Mon, 23 Aug 2021 22:36:01 +0200
Message-ID: <871r6j526m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Aug 18 2021 at 13:52, Vlastimil Babka wrote:
> On 8/17/21 9:53 PM, Andrew Morton wrote:
>> On Tue, 17 Aug 2021 12:14:58 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
>
>> What's your confidence level for a 5.15-rc1 merge?
>
> I'd say pretty good. It's part of RT patchset for a while (since early
> July IIRC?) and there has been lot of testing there. Mike and Mel also
> tested under !RT configs, and the bug report from Sven means the mmotm
> in -next also gets testing. The fixups were all thanks to the testing
> and recently shifted to smaller unusual-config-specific issues that
> could be dealt with even during rcX stabilization in case there's
> more.

I can confirm that the series converged nicely from the very beginning
and Vlastimil was quickly addressing review feedback and the really
moderate fallout.

Various stress tests on both RT and mainline with the latest patches
applied look rock solid now. There might be still some small dragons
lurking, but I don't think there is a danger for a big fallout.

>> It isn't terribly
>> well reviewed?
>
> Yeah that could be better, the pool of people deeply familiar with SLUB
> is not large, unfortunately. I hope folks will still step up!

I've reviewed the lot several times with my RT hat on. I'm surely not
qualifiying for deeply familiar, but I've been dealing with taming SLUB
and the page allocator to play nicely with RT for almost 10 years now...

Thanks,

        tglx
