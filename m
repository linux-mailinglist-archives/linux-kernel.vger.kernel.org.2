Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E03C7A55
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhGMX5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhGMX5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:57:07 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396C3C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:54:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 23so2260876qke.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=psNqCrBwCGRPV0GMx0UJi9q1GTstXYN3y24OgE9aFHA=;
        b=nAn1ZBctObW5/4rzcwbWcXacQkKZzr+xNKjOPvXZEJkFWoXKOXpGusecOIwp2Bkkg8
         gQx0KPcNl3VanNIuObMwevvxTyfI3v5ASEzsLaWrlzElfTAv2KwigogKaIDDqyk38nTU
         21v2QUakO9PeQqSV/k9mHvzbQmbPMvbgbHCedUgtf8szFThAeyNt6Q3ek3wTC6RZEUhl
         p37zswHknxz2+J7q4tV+WF/DUblIwzz73KSWFvdWA5MatZv4P5NRdAihrggZKv4IBWl5
         mwqZuMZZS6cpQPBZL17XvkhZOGLnGW81B9ErVPSttvz6F20wjdSYJm+vC9ceHZQq20qv
         wjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=psNqCrBwCGRPV0GMx0UJi9q1GTstXYN3y24OgE9aFHA=;
        b=bnvV+eAwaYMu1qyD4lfAAMU0KykWZa7OoteqdLJoZ/B685WSMGOcv5ihK8aP5ARzV7
         LaafgvulCt8Q36eb1hckHxTGkyphrn4XZy8ZEcIooibJv6iAmbwN/pp1iHI03ZkWFizK
         ejA8vWA+ynci4VYUqL21Qw0VU3FWuQKBKgCXgG90UkGVHp7nqTsctaguswuSOvkZdjdU
         mjtSscnA4UL3yd6FjpeeGPVYt0qwT5pR2sa8YHp09dZSzS6BS439PPKQaqOqMGj9CKS5
         Vu+6oXObCohBkEBYzc5wZbaAAoLaG6Z5TbHDovbgLZJ5JMv6pIO3Q97V502piGuBTNtc
         jvKg==
X-Gm-Message-State: AOAM5314mdbYw2Ly2sSPJtCt3BrFPuAHm/e+0Z8rFhdxdkJq8ayWiWE6
        waltK19RC+ms/6NI+6fIq60=
X-Google-Smtp-Source: ABdhPJy9aRtw6TRboqtQn9nRqg1AhyGHGFH4KJheCNecEuLTHHQvQx/DiTyi4lhZrGrHwKCG81Niug==
X-Received: by 2002:a05:620a:709:: with SMTP id 9mr6857281qkc.493.1626220455313;
        Tue, 13 Jul 2021 16:54:15 -0700 (PDT)
Received: from fedora ([130.44.160.152])
        by smtp.gmail.com with ESMTPSA id l4sm206872qkd.77.2021.07.13.16.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:54:14 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Tue, 13 Jul 2021 19:54:12 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org,
        Bumyong Lee <bumyong.lee@samsung.com>,
        iommu@lists.linux-foundation.org,
        Chanho Park <chanho61.park@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swiotlb: add overflow checks to swiotlb_bounce
Message-ID: <YO4npNvmgEKFotvq@fedora>
References: <20210707051254.2121603-1-dominique.martinet@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707051254.2121603-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 02:12:54PM +0900, Dominique Martinet wrote:
> This is a follow-up on 5f89468e2f06 ("swiotlb: manipulate orig_addr
> when tlb_addr has offset") which fixed unaligned dma mappings,
> making sure the following overflows are caught:
> 
> - offset of the start of the slot within the device bigger than
> requested address' offset, in other words if the base address
> given in swiotlb_tbl_map_single to create the mapping (orig_addr)
> was after the requested address for the sync (tlb_offset) in the
> same block:
> 
>  |------------------------------------------| block
>               <----------------------------> mapped part of the block
>               ^
>               orig_addr
>        ^
>        invalid tlb_addr for sync
> 
> - if the resulting offset was bigger than the allocation size
> this one could happen if the mapping was not until the end. e.g.
> 
>  |------------------------------------------| block
>       <---------------------> mapped part of the block
>       ^                               ^
>       orig_addr                       invalid tlb_addr
> 
> Both should never happen so print a warning and bail out without trying
> to adjust the sizes/offsets: the first one could try to sync from
> orig_addr to whatever is left of the requested size, but the later
> really has nothing to sync there...
> 
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Bumyong Lee <bumyong.lee@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
> 
> Hi Konrad,
> 
> here's the follow up for the swiotlb/caamjr regression I had promissed.

Awesome!
> It doesn't really change anything, and I confirmed I don't hit either of
> the warnings on our board, but it's probably best to have as either
> could really happen.

:nods:

I put it in the devel/for-linus-5.14 and linux-next. Thank you!
