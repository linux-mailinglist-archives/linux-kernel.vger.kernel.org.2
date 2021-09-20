Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BAB4118AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbhITP4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbhITP4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:56:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D08BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:55:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q23so14556684pfs.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ypt/RRITG4KeHBKpsPFjVXvxZMnO9UA0tX+4neKhUYk=;
        b=cHKUZm01QvVJRxXVV0vcJwU6DZ/MTRk5nd0viSm00OhVyIQb9DA/qdfBHBxwzzWaYB
         L+qFOWw/O4BaRLGCTouZ/8t8HfcFw3KaegxM0X/nwZF7Pqnw7eXwtsOEOURfipfKncn6
         gMkTKWUwpa4NWfM+j8OUCQawKwI0PfrEkzqxrnE4LEvf0MRk+WdW5bNS7ESnYUZZ6K+i
         ZyTNFmgaU+dMWM6rWZTtIo/BbGp+jTZGs/absYSAfK3uPRwZttddMe649+AYVVqiY9xe
         hnyPB3tHmdY165xb3hGQ70+JemxRTop04YWCK4KX6xSfpWNSVmQdZCA1TWoIUhdUAeBk
         /2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ypt/RRITG4KeHBKpsPFjVXvxZMnO9UA0tX+4neKhUYk=;
        b=QeMTN/refoDytfWuKEsCrR+4SHaKzf4N6mbYA1FydZEZPf/ZGAfT9Rp87ODB9s2pAY
         6v05l8YkrAN41Twsj6EaTBokYVTf8T7PdhFiPESaW2ndmtc5nAmudb0g9FyYjCYFHlCT
         wLKV9Y/aPJUCJ3Fy3tw4r2mXJCMHg73+85B7DFKHI87sJ3ho2uqjdgThweJkCuePAg88
         Nn6XMy/Tu9xUK5aj6ShpfrsDSWTZmr114ZuEnWRF+zVQdXkGqN8cVVdMbzUWM7nVLrWn
         MncFBkkDJTXu1lLvhn4BbtzAI9VVCwK6WjNl+hXbB/MENfaRYY14BBYolpObymihVP5u
         YsIQ==
X-Gm-Message-State: AOAM5329MPAr7a45MeIxxdcMUikoRRWOjw6pgD54UnbvVk2mVS6aAnGP
        yW2lsiBZ1/vucp7LS79WbeU=
X-Google-Smtp-Source: ABdhPJwrFb5fwvBnS2V1qYm6wmBmNdmeuOIP+kS0q8gOtH0/J260495VhNHYtPBCFKMmF8I0EC/IAg==
X-Received: by 2002:a63:ea58:: with SMTP id l24mr24254590pgk.334.1632153323650;
        Mon, 20 Sep 2021 08:55:23 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id v7sm13687153pjk.37.2021.09.20.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:55:23 -0700 (PDT)
Date:   Mon, 20 Sep 2021 15:55:18 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH] Introducing lockless cache built on top of slab
 allocator
Message-ID: <20210920155518.GB31923@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210919164239.49905-1-42.hyeyoo@gmail.com>
 <YUeM2J7X/i0CHjrz@casper.infradead.org>
 <20210920010938.GA3108@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YUfpniK6ZVeNhaX2@casper.infradead.org>
 <432da236-4d8c-1013-cd57-42c352281862@suse.cz>
 <20210920115536.GA3117@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <a9f9ae14-7805-68f7-cf19-e9e03c87152f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9f9ae14-7805-68f7-cf19-e9e03c87152f@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:02:19PM +0200, Vlastimil Babka wrote:
> On 9/20/21 13:55, Hyeonggon Yoo wrote:
> > On Mon, Sep 20, 2021 at 11:07:36AM +0200, Vlastimil Babka wrote:
> >> I guess making it opt-in only for caches where performance improvement was
> >> measured would make it easier to add, as for some caches it would mean no
> >> improvement, but increased memory usage. But of course it makes the API more
> >> harder to use.
> > 
> > Do you mean "lockless cache" it should be separate from slab because some caches
> > doesn't benefit at all?
> 
> I meant it seems to be a valid approach to have a special kmem_cache flag
> and allocation function variants, as you discussed. That covers the "some
> caches don't benefit at all" while being an integral part of the allocator,
> so others don't have to build ad-hoc solutions on top of it, and possibly it
> can be also more optimized given access to the SLUB internals.

Okay! I sent RFC v2. please check if how does look like to you:
	https://lore.kernel.org/linux-mm/20210920154816.31832-1-42.hyeyoo@gmail.com/T/#u

> >> I'd be careful about the name "lockless", as that's ambiguous. Is it "mostly
> >> lockless" therefore fast, but if the cache is empty, it will still take
> >> locks as part of refill?
> > 
> > It is actually "mostly lockless" so it is ambiguous.
> > Can you suggest a name? like try_lockless or anything?
> 
> "cached" instead of "lockless" ?
>

added kmem_cache_alloc_cached, kmem_cache_free_cached in v2.

Thanks for your opinion Vlastimil,
Hyeonggon.

> >> Or is it lockless always, therefore useful in
> >> contexts that can take no locks, but then the caller has to have fallbacks
> >> in case the cache is empty and nothing is allocated?
> >> 
> >> [1] https://lore.kernel.org/linux-mm/20100804024531.914852850@linux.com/T/#u
> > 
