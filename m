Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECAB3A379B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFJXGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230368AbhFJXGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623366263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kn4921Fy2QxClPboKoVBlarBT42fXZONHXvZsMc4G14=;
        b=APFp1kQLqm/VxcHMem0c8P4f5Z0Xe0pUOUCRGoIWHkFswrmqOFh++H5j53G/+tmc7rBJFY
        Ayjr4Trg3/tMsFCMLg9ibGgGYkjLInb+RfGvuk7BEJNSiFxx5XULYPz8ljh9dntgnnx9jT
        fQYwjI1WDBM4mXl+/2vbBZZTFB030b8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-1yQC9o8YNNmjJimyUzPI_g-1; Thu, 10 Jun 2021 19:04:22 -0400
X-MC-Unique: 1yQC9o8YNNmjJimyUzPI_g-1
Received: by mail-qt1-f199.google.com with SMTP id z20-20020ac845540000b0290248cbf50215so828100qtn.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 16:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kn4921Fy2QxClPboKoVBlarBT42fXZONHXvZsMc4G14=;
        b=tYGSHShJRV/wQAqbAaoJdqzeb3aQHiA4z3dOtDgis/5aLQdcTHCWc69atcYZsG0Hab
         23/b5FiQfHqS4OuYpASV+5RkEY0sDbQ1CoiIPmneyIfChZn1GxneRnEfgq6rdpk4G1DM
         rJdKoaJIEcbNBX9JEzVrW4fZCY56V7SstjTaZ4qMY/V48aXzMKjlxAi7oQ79Y7L3fP1i
         As4RHCd6uveS9QLGAscqQzmYPmaNKKOfhGvq4adpmsQv2xD9pZEYEiQdNRAKE0JbT8GZ
         /B8C41M0bZOKDmLLHtPa28mfqKZa/utr7Y1Qf38nEEtIMDrBf2imyfdo/pONWkdzg2FX
         /ktQ==
X-Gm-Message-State: AOAM530lxqif3GbV/uSEiPIO7ZOKDSkvy8U42yXW+vVYaxQBzNL4/UFv
        kAzoh9BSTOyPj/MzwS+/FDaCkyeuhVjSwdXDTlqKGTba7hoYZzmd0TtsotTF3ZXb/I1KQ7Gg23P
        ZEyRv6COwHJADgN+FQoz9TCE3
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr1055474qkk.263.1623366261642;
        Thu, 10 Jun 2021 16:04:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrG/yfGVS5sWgTKcNo1dgRgBZLWinZ0GsXIy0VHGuGgZrohA7iNbV+b0qys3C0GTOZDsvbFg==
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr1055448qkk.263.1623366261403;
        Thu, 10 Jun 2021 16:04:21 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-88-174-93-75-200.dsl.bell.ca. [174.93.75.200])
        by smtp.gmail.com with ESMTPSA id j14sm3076434qtj.96.2021.06.10.16.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 16:04:20 -0700 (PDT)
Date:   Thu, 10 Jun 2021 19:04:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        rcampbell@nvidia.com, linux-doc@vger.kernel.org,
        nouveau@lists.freedesktop.org, hughd@google.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@infradead.org, bskeggs@redhat.com, jgg@nvidia.com,
        shakeelb@google.com, jhubbard@nvidia.com, willy@infradead.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 07/10] mm: Device exclusive memory access
Message-ID: <YMKacyNstEM9brUD@t490s>
References: <20210607075855.5084-1-apopple@nvidia.com>
 <2773835.D95cIkl9rl@nvdebian>
 <YMJUM4sx1VclR7oz@t490s>
 <6429491.QiJgnDeYu7@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6429491.QiJgnDeYu7@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:21:26AM +1000, Alistair Popple wrote:
> > Hmm, the thing is.. to me FOLL_SPLIT_PMD should have similar effect to explicit
> > call split_huge_pmd_address(), afaict.  Since both of them use __split_huge_pmd()
> > internally which will generate that unwanted CLEAR notify.
> 
> Agree that gup calls __split_huge_pmd() via split_huge_pmd_address()
> which will always CLEAR. However gup only calls split_huge_pmd_address() if it
> finds a thp pmd. In follow_pmd_mask() we have:
> 
> 	if (likely(!pmd_trans_huge(pmdval)))
> 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
> 
> So I don't think we have a problem here.

Sorry I didn't follow here..  We do FOLL_SPLIT_PMD after this check, right?  I
mean, if it's a thp for the current mm, afaict pmd_trans_huge() should return
true above, so we'll skip follow_page_pte(); then we'll check FOLL_SPLIT_PMD
and do the split, then the CLEAR notify.  Hmm.. Did I miss something?

-- 
Peter Xu

