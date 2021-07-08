Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721BF3C14C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhGHOA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhGHOAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:00:55 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975FC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 06:58:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id v14so15903912lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RTQMNsYkH54gTZYg5JDo/dsYjbW4P2+8PHeW4ZHkno8=;
        b=gKecfPmI02OLNoie4L136UAox+LToVyA9H3yfCLewhc3MAJfq5CB1cnK+BK9W7USVP
         YiEOEFddz6oVpWLL1RF9gOYp0iwEcL0KzMwnV15wdxQU2z/pcH3wSNA7v9O9D+hPflQi
         MObaUt7NIL//UMryaxKl17vqo2IjBFZgAt/YGKGntBI/SXxEM+qUxtBytKPPzN4SffLo
         G5nnsk++yww4Sc/oYiP21+5bFLVHjIrk2R54VjDaiXgfltun4gPgA3NU1j2WfDFBq5AV
         rkU1DjmGXhFZVjafaJczJHgVrNBwE9kTcTSF05Ij+FxZ1tX0IA9diuO5AnYHLFNwIXrA
         lwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RTQMNsYkH54gTZYg5JDo/dsYjbW4P2+8PHeW4ZHkno8=;
        b=tgcdH6U0zNcHmEXoNHL1ZE6Vz9HKQj2xEBI3rWYMeMH5NJtxSJ5qUmLSE82NoBSIs9
         AAUE3CmbCuJsgK3OIGDKeeTpOXjuQwtXfyGQ0nBNVac7xASSMhEsoF7PIK1ydW3BaTL2
         0cZiA25TaYF1YLQmu7VEj7aPwuO5rsHhVUNCVd9SQO7YPO9vMPpNXb2fxj4GY+f3ADRm
         V7wwKJyzKbEjgHcV68JsPX1wuAVdpxkWEbpIoyjx7lVTQbXj0E+JKp8fbwgF+hp//8x3
         sj+hg1uJEVJU+UOUq9cJYu0Jyr5QLNu+s7UXgkcpj9yH7yWkvEBU/TBb2eSYwklj6n7G
         n8kg==
X-Gm-Message-State: AOAM533w+3hvV9mL81qjYJc9HR0Z+0LIO5GpTdvRMjZdeCVFiea8S+Lm
        Dy+KNuPWBlSzphP3dDq8lD0/1y1h0S5qaA==
X-Google-Smtp-Source: ABdhPJwW+Ex9xsSpyg9Pb3vhDSaDTE/P+lD1YFK0vaxIg4+WDF9ongDtWtza8/vtU8CtMb8nCLtx/w==
X-Received: by 2002:a05:651c:178b:: with SMTP id bn11mr24068444ljb.43.1625752691451;
        Thu, 08 Jul 2021 06:58:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z1sm205549lfh.137.2021.07.08.06.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 06:58:10 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C77E5102878; Thu,  8 Jul 2021 16:58:11 +0300 (+03)
Date:   Thu, 8 Jul 2021 16:58:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm/rmap: fix old bug: munlocking THP missed other
 mlocks
Message-ID: <20210708135811.775drqgwkwc76vcb@box.shutemov.name>
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
 <cfa154c-d595-406-eb7d-eb9df730f944@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfa154c-d595-406-eb7d-eb9df730f944@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 01:08:53PM -0700, Hugh Dickins wrote:
> The kernel recovers in due course from missing Mlocked pages: but there
> was no point in calling page_mlock() (formerly known as try_to_munlock())
> on a THP, because nothing got done even when it was found to be mapped in
> another VM_LOCKED vma.
> 
> It's true that we need to be careful: Mlocked accounting of pte-mapped
> THPs is too difficult (so consistently avoided); but Mlocked accounting
> of only-pmd-mapped THPs is supposed to work, even when multiple mappings
> are mlocked and munlocked or munmapped.  Refine the tests.

Well, that's true that it should be fine to mlock only-pmd-mapped THPs,
but the refined check doesn't gurantee that the page is not mapped with
PTEs. !PageDoubleMap(page) only guarantees that the page in not mapped
with both PMDs and PTEs at the same time. For anon pages, we clear the
flag when the last PMD mapping is gone and only PTEs left.

Do I miss some detail here? Maybe we exclude anon pages here somehow?
I don't see it.

-- 
 Kirill A. Shutemov
