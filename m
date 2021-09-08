Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D835F4031DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhIHAgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230315AbhIHAgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631061313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fZWZZr44GH/3iutnQw+25r6IM2aag3PM2R58Hrhuans=;
        b=PVtKmcHKOOyQgHNrqq3nWVDXeZjeUiMh0utWLgz+H6DdpYRlJXwZC0VohTBgShvJCTeOUR
        hKaUiqRFaBR2jS/0glKMvFHjNvB9ss5QsX3JLghhn2xc/RTU6ghbJxG6RzTyyA1atKs80b
        UaaglcSNE2n54n9srkBnu06JDK6w7Cg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-bkf-B_VHOxOgi8Rs3aB5yQ-1; Tue, 07 Sep 2021 20:35:12 -0400
X-MC-Unique: bkf-B_VHOxOgi8Rs3aB5yQ-1
Received: by mail-qt1-f199.google.com with SMTP id l22-20020a05622a175600b0029d63a970f6so819706qtk.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 17:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZWZZr44GH/3iutnQw+25r6IM2aag3PM2R58Hrhuans=;
        b=ObxJ3wTrGGkL2G0E3NlZSHLsRmpf2adB+2N9LOR7EOPFzj6jP8kbvBneWyTsMFttPF
         lSp7Zw4604+OJeh8dvpo5+EZPucWUi9eGiNx9dlN6+WNxzCy+UeTXgz3GZNvF3enBm+n
         lkbsqkgA88LMj1wVM6BkTZPcCIUW9udA8yRvzCl1EwvPZ+gxRcqeReSpjdZlSKZuQd1P
         DesaCcN5ry3Qk7E1NHtkE8OdvtA85ceDTYu+8aqB0D7Eje886z20RFJmbP140/EQChRd
         l1CyJDEOaAsGZiS/HSrD9Xr1pZssuXCzpb/uswSY2eXWkhG+57uoQ1Vk3MgC6/mL5t2z
         0aew==
X-Gm-Message-State: AOAM5302zlNW1wVxGsRHG7ZqZDUhtkSk1uepqCrVN2L9QHeE1JHCw6fu
        skxZ49A047FutmU/4KHr5/cToyLlxH0wvCnTAVk9y8plmB6Z8FDqeWD/P0OaBYOBLwIDAilLSlT
        dTR50d5uzz1r42rnQuS3ekOYG4ncE8bTXge3O6xr4Fpkz9Fw1mAih6ZVoUzPZ1gkyQVWPIoIlNw
        ==
X-Received: by 2002:ac8:7194:: with SMTP id w20mr1173290qto.217.1631061311558;
        Tue, 07 Sep 2021 17:35:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK7EAe+v1xcoVx0IGHKJI1Q/uNSOUvI9M0WpH70+Y9fErFaqUKyfL5O/cUYs2gyf92dD7LyA==
X-Received: by 2002:ac8:7194:: with SMTP id w20mr1173257qto.217.1631061311219;
        Tue, 07 Sep 2021 17:35:11 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id d9sm489713qkn.124.2021.09.07.17.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 17:35:10 -0700 (PDT)
Date:   Tue, 7 Sep 2021 20:35:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v2 0/5] mm: A few cleanup patches around zap, shmem and
 uffd
Message-ID: <YTgFPC4qGFflDES+@t490s>
References: <20210902201721.52796-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210902201721.52796-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 04:17:16PM -0400, Peter Xu wrote:
> [Based on tag v5.14, but it should still apply to -mm too.  If not, I can
>  repost anytime]
> 
> Hugh,
> 
> So I found one thing that I feel like a bug of commit 22061a1ffabdb9c3, but I'm
> not sure.  If that's the case, patch 5 of this series may be the fix for it.
> 
> The problem is unmap_mapping_page() in current tree is calling
> unmap_mapping_range_tree() with a details pointer, while by default when detail
> pointer is specified, it means "we want to skip zapping swap entries".
> 
> I didn't mention this in v1 simply because I thought it was fine, e.g., swap
> entry won't be kept in shmem ptes so skipped is okay (it is never okay with
> shmem uffd-wp but uffd-wp code is not landed yet).  However I just remembered
> there could also be e.g. shmem migration entries if I'm not wrong.  From that
> pov, skipping swap entries for unmap_mapping_page() seems wrong.  Would you
> please help check?

I figured this seems to have no problem: firstly commit 22061a1ffabdb9c3 didn't
really change the behavior of the code because previously it was using
unmap_mapping_range(), which will always pass in a "details" pointer anyway.

Meanwhile there won't be migration entry for this page because the new helper
unmap_mapping_page() has page lock held, while migration requires that too
during moving the pages.

Anyway, sorry for the noise. I'll respin but drop these paragraphs, also in the
last patch's commit message.

-- 
Peter Xu

