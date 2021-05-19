Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A15388DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346473AbhESMRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237999AbhESMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621426545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpsW6GoLBuPX3m2t6ZDWDsXVHyOzAne0XpIqOVeHL30=;
        b=XWnvgk+gmA8q335ZahEcIfurX3JWiQVieP+ijgBkA8GHETaQzRBva9P8v6AMP2XK5YEGKC
        GUlRBQyHMkN48LWDWQTsMFGIU1EVOzD86oqePIxoihk0KLbXBmuz0Tmux//77FLilHSht1
        6/2bGeSVroWR5pTNFncy9VU+NjMZc5o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-9-BkKdqSPeq7GcZTxChbsg-1; Wed, 19 May 2021 08:15:44 -0400
X-MC-Unique: 9-BkKdqSPeq7GcZTxChbsg-1
Received: by mail-qk1-f198.google.com with SMTP id b3-20020a05620a0cc3b02902e9d5ca06f2so697398qkj.19
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tpsW6GoLBuPX3m2t6ZDWDsXVHyOzAne0XpIqOVeHL30=;
        b=ohYO1JSCyLVctYCPPOxtx2x4ihJkDDKcKZ3GjZIkBzgB9SeoYYMnIRyKU4OdBrgF8S
         YSNUNQOS5ILObVMPwZVarVItnCFWbii94Q8B1i1QkyZ0gtidxEzgjo08nX/a7GqtoB6+
         I0D3SWLz7z4T73MC9KGRbAwjb1Uf/igSB/QNFNHjPqQD5Dsnr5Ni/bDMqOSHiuJ1eOn8
         Pm34xdXi2xZ2OxQnSzv21jeE7M2HrBmrZgitise0feRGkkjqMvIS0NUSukeXA4m6Whp8
         nmMqGVPqMHMdekY6/cYOk97gEnDTeWVFlvguc8nT0lotTKQcmEQ4indrDgdq2SfjVjph
         G1Wg==
X-Gm-Message-State: AOAM533vNKdSTRB2Lnpfu3t7vpVTGh6iKVK8mMJAhmI4VzTa7JgpuRfo
        Tl6zegQQ43KNx2lK+rh2M3V2susSRjkzASP4OQOd035O5uYsqMBX8q+0ZBYa98N21bj9F43ktO9
        ewwgSr/fk60kAVOclXpQuoC1/
X-Received: by 2002:a05:6214:20c4:: with SMTP id 4mr13194996qve.38.1621426543763;
        Wed, 19 May 2021 05:15:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJeMvnD48yKledjvAvmUkVuVahWxfS9KHq8l5vFptQfcG6pDYRH4satuz1xLVBYj0ZmxaSVA==
X-Received: by 2002:a05:6214:20c4:: with SMTP id 4mr13194979qve.38.1621426543531;
        Wed, 19 May 2021 05:15:43 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id y9sm14576208qkm.19.2021.05.19.05.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:15:42 -0700 (PDT)
Date:   Wed, 19 May 2021 08:15:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jhubbard@nvidia.com, rcampbell@nvidia.com, jglisse@redhat.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <YKUBbVuvm5FUJRMl@t490s>
References: <20210407084238.20443-1-apopple@nvidia.com>
 <20210518230327.GG1002214@nvidia.com>
 <YKRRgZmRMdk1vH7A@t490s>
 <2235357.HsqDk0zIjc@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2235357.HsqDk0zIjc@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:04:53PM +1000, Alistair Popple wrote:
> Failing fork() because we couldn't take a lock doesn't seem like the right 
> approach though, especially as there is already existing code that retries. I 
> get this adds complexity though, so would be happy to take a look at cleaning 
> copy_pte_range() up in future.

Yes, I proposed that as this one won't affect any existing applications (unlike
the existing ones) but only new userspace driver apps that will use this new
atomic feature.

IMHO it'll be a pity to add extra complexity and maintainance burden into
fork() if only for keeping the "logical correctness of fork()" however the code
never triggers. If we start with trylock we'll know whether people will use it,
since people will complain with a reason when needed; however I still doubt
whether a sane userspace device driver should fork() within busy interaction
with the device underneath..

In all cases, please still consider to keep them in copy_nonpresent_pte() (and
if to rework, separating patches would be great).

Thanks,

-- 
Peter Xu

