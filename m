Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809224118A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbhITPvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbhITPvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:51:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F8DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:50:15 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g184so17764019pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MHA6cle2COOzC1F3A5ypPTe3bj1qYPzRBiklAem487U=;
        b=XP9FAEda72txv8/MXs2FtVTKXNbRlJslWeMwkb1Gm776FHvz4QvVdmkPsh9oGK5FAk
         C6zOXQ2gFvfJBVs0MUctBPn8jyDR2k9A1GNZ89D9TWy2NDxHKVmKJm3sgXX1ADgMCZ/Z
         1ADyA0DAJJ2Kc+V2LLUZqbh0+8JSH2RGyQYdbyiKB4wmhXQd9tl7KsR5x+c7BqwP+p1i
         osOxuU294wYKdPh+pYhVs7OicOQqUJKUIXA3fiMxQ61vvnsTNOQ4QhTdzYYvKIAN76s8
         tdCq0GusbVmvJihCNfQYz/Ut3F6gKIyBfUNbJVwlcy7qR8vGNJZiR4dyCi+gnslC0SlM
         2d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHA6cle2COOzC1F3A5ypPTe3bj1qYPzRBiklAem487U=;
        b=OubQ+h1T3vyALKNucLN0fQbQhyLhAWq3iYL9vggFihbzS2Q+0/wHdFEYubcSzmodfv
         awVIsX6nzG/HXeF4vF5bSjfPQGO65T+lpE8IrXN+prG4Ti1ZYtKNiI8raaCFgM6hfyx1
         SgrUdj0kDMStOp23LyuhPKAUp+X8Tur5aQ/fX6iFvJVX60mlF6M+q60kbTU5WoyOkbD+
         49DK0rsoUqlbbmjrQRRGqASWytlawIqCvBa2eK4Mb1UOaTG/iacZ1wzjA+QQ/S/5ywlJ
         8KuUSRmZvtu/UtQB/6Pto8RS2PWnoZHXsVJn/COp4cVvhAyu3NXcZtwISw+j4d3EAjDk
         umww==
X-Gm-Message-State: AOAM531fPNmwz63q1+7lwKw4j+Srrh3ykyjnA1Ih49jF4Dbq7WDf/CWI
        BRzWOMvNpIapgwtKjNO1qKo=
X-Google-Smtp-Source: ABdhPJyrxYQB0ArbEGvIMAMC7ESi/3O+3dYcc37ha7C77WrJ3Nr1c8MPhEyBgC068eU9OO+AIcEYZQ==
X-Received: by 2002:a05:6a00:983:b0:444:ac28:1ee1 with SMTP id u3-20020a056a00098300b00444ac281ee1mr18959367pfg.49.1632153015188;
        Mon, 20 Sep 2021 08:50:15 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id n185sm15745891pfn.171.2021.09.20.08.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:50:14 -0700 (PDT)
Date:   Mon, 20 Sep 2021 15:50:10 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH] Introducing lockless cache built on top of slab
 allocator
Message-ID: <20210920155010.GA31923@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210919164239.49905-1-42.hyeyoo@gmail.com>
 <YUeM2J7X/i0CHjrz@casper.infradead.org>
 <20210920010938.GA3108@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YUfpniK6ZVeNhaX2@casper.infradead.org>
 <56f30136-23ce-dd73-705c-4e1326768c9d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f30136-23ce-dd73-705c-4e1326768c9d@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 03:41:16PM +0100, John Garry wrote:
> On 20/09/2021 02:53, Matthew Wilcox wrote:
> > On Mon, Sep 20, 2021 at 01:09:38AM +0000, Hyeonggon Yoo wrote:
> > > Hello Matthew, Thanks to give me a comment! I appreciate it.
> > > 
> > > On Sun, Sep 19, 2021 at 08:17:44PM +0100, Matthew Wilcox wrote:
> > > > On Sun, Sep 19, 2021 at 04:42:39PM +0000, Hyeonggon Yoo wrote:
> > > > > It is just simple proof of concept, and not ready for submission yet.
> > > > > There can be wrong code (like wrong gfp flags, or wrong error handling,
> > > > > etc) it is just simple proof of concept. I want comment from you.
> > > > 
> > > > Have you read:
> > > > 
> > > > https://www.usenix.org/legacy/event/usenix01/full_papers/bonwick/bonwick_html/
> > > > The relevant part of that paper is section 3, magazines.  We should have
> > > > low and high water marks for number of objects
> > > 
> 
> In case unknown, jfyi there is an implementation of this in
> drivers/iommu/iova.c

Thanks for good information. I'll take a look at it!

Thanks,
Hyeonggon

> Thanks,
> John
> 
> > > I haven't read that before, but after reading it seems not different from
> > > SLAB's percpu queuing.
> > > > and we should allocate
> > > > from / free to the slab allocator in batches.  Slab has bulk alloc/free
> > > > APIs already.
> > > > 
