Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718E7413791
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhIUQbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhIUQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632241815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cvXMhGakfRvwam1AwXwENHJLraWpPC0CvrXKzv+4e2g=;
        b=B2/v4P9xwRaZMn7dRhy4YiFz+XWspsAv5Nv8U3O9+hgVQBQrcoQGU7XRiLxYQRTgCnOnbp
        vPGMT91l1yEToyW0WkJIukVUmXLNb0+2IapkxJLuYNqi0Xmd28xl38edWPAuWFkaEtcpnR
        6q+jrkikzLHvZ+wWzY/2WB9HCMlRXVE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-1guuNCgKNtSch7tms6NeeA-1; Tue, 21 Sep 2021 12:30:14 -0400
X-MC-Unique: 1guuNCgKNtSch7tms6NeeA-1
Received: by mail-qv1-f69.google.com with SMTP id ci14-20020a056214054e00b0037a75ff56f9so228624191qvb.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cvXMhGakfRvwam1AwXwENHJLraWpPC0CvrXKzv+4e2g=;
        b=LKHcSGAcKJl5x0HgcxEaeuj9L1q6qZ0l2A9R3VHMAQSoEdSLUjXXiUDX+aO1ZUVVrO
         wyZOTm4MiALwrTZFlifCNKt5TdMrr4eWcJnIx66FZKrwUw0mqpqNdhfATURHmY8UZfBm
         4pPZjdIXSN6gyNgKV60IPRr9pGXz8Lt2YaTbBYiW2WP2XPBtJ+K2DKcqBcAGSVXqFmHY
         Pp/sG3U4273+eY+pOKFpDRL4lMljPaLOXyP3fX8D2EGLByfbZ5vLo0C5ovAiFIihtEUc
         pb7kxaRjhsVfynu4FvA4bFGmf0gjn8a9lvdtzeoKGzjgG2CD+/IAH/4yhQ7NvdTf1gd1
         ZwyQ==
X-Gm-Message-State: AOAM531twRDJfOy877lPZOonr7DWnT+/TiEW1JF1KWxE9Vw0MlvLereW
        0IffCzQ1qjZyxMoLg1zcgxi2dZOApfALSKHYwPt0UdIrk8k7rKrWZe5y4KnVYkmTWAc+cdTco/Y
        2ZzVgbA9Xb4Bwl/k0u9kuZDEU
X-Received: by 2002:a37:a152:: with SMTP id k79mr4734852qke.358.1632241814341;
        Tue, 21 Sep 2021 09:30:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA/BiE/VLlRf8pfn0lR/MXGfaprXd3avo4u1T1KPZaeFF4KcokyiBLbt3MnRhkYORRG/A1NA==
X-Received: by 2002:a37:a152:: with SMTP id k79mr4734811qke.358.1632241814099;
        Tue, 21 Sep 2021 09:30:14 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id r10sm9339894qkk.95.2021.09.21.09.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:30:13 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:30:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "david@redhat.com" <david@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>
Subject: Re: [PATCH v2 1/1] Documentation: update pagemap with shmem
 exceptions
Message-ID: <YUoIk247W1Sbt6Lf@t490s>
References: <20210920164931.175411-1-tiberiu.georgescu@nutanix.com>
 <20210920164931.175411-2-tiberiu.georgescu@nutanix.com>
 <YUjb91tWhd/YAgQW@t490s>
 <F6A49621-C7A4-4643-95C2-F47B02F132D2@nutanix.com>
 <YUn0ikP4Gip3Yc6L@t490s>
 <C983908F-7AF4-410B-90FF-DB4B9A06E917@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C983908F-7AF4-410B-90FF-DB4B9A06E917@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:08:29PM +0000, Tiberiu Georgescu wrote:
> Hmmm, so if we put emphasis on the accuracy of swap info, or accuracy in
> general, we need to use frontswap. Otherwise, mincore() could suffer from
> race conditions, and mark pages in the swap cache as being present.

IMHO it's not a race condition, but by design.

Quotting again from the mincore() man page:

       The vec argument must point to an array containing at least
       (length+PAGE_SIZE-1) / PAGE_SIZE bytes.  On return, the least
       significant bit of each byte will be set if the corresponding page is
       currently resident in memory, and be clear otherwise.

I think "within swap cache" does mean that it still resides in memory, so it's
not violating what it's designed to me, at least from the manpage.

> 
> Do you reckon this info (frontswap for mincore) should be present in
> the pagemap docs? I wouldn't want to bloat the section either.

I don't think the type of swap matters in this document, but imho mentioning
mincore() as the alternative to fetch swap is still meaningful as that's what's
missing for pagemap right now on shmem typed memories.

Even if it cannot identify some cases between "page presents", "page stays in
page cache", or "page stays in swap cache", it'll still be good enough to me.

Thanks,

-- 
Peter Xu

