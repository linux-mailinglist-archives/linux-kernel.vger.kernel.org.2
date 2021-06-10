Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C14D3A2787
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhFJI7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhFJI7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:59:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693F9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:56:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r5so2016757lfr.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jRYyk3EbV8ykUwHzFQPKAhHsarVLGupggo1jrWfbO38=;
        b=v5Ao0GMnVycjqJk6Mpy+4+jSeS5Bi8Gw0i1gFO4cXsigiqW/8yiFmbgF0k+D/puZxK
         KE3pdoBidoXaCUzJXwo3GBleBv1rL6l1Tsq6lOpg2DGkNvuaKbuJStHapIj/81BEVNLt
         tVcw469DeDqZjnYy/ACEDxECqOWyyHmGLAwA3f8jS7OfUswuKq86iEmJIbMSwi7raMC0
         tCVJbCudj6bVhuqoHKyp+4UXJwD28A/t794ceGHe3LsskxpH8Xhjfq4NOGF3pbPiNlDf
         SvBZUEG8Fb2YEuwqPuxQmZUN1Opz8dxyCehcC+DGb4pL/xQDiYMuyGCwBzdghuJb9GWS
         rfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jRYyk3EbV8ykUwHzFQPKAhHsarVLGupggo1jrWfbO38=;
        b=XWyXDTmzoYMb0ePfJkrl59GjPLBhhcT2Ep/e4KHPRwDHt0kJJbXJ9tBehIN8Qtgwvw
         w30ZL+ZsYMFECkJPF20VErG/4WfUXZLEQ7CD/RnTk45sYiJ3lST747XsLqpXOCL8ed4D
         d99D6pHNcXEqdehpkkBAbnS8poygtUIv8G+K/81OjtJZT0zrocwKDyo2inDcn2Re8/1Z
         V5Sxis2m8oxSSd6PzWWf4ZashsPCpUm+WDZ5OCWhdv2vu4r/Z8Ogdgbif+PQvf7LrQ7c
         9As++ywly3Dzbg0U5SkamgPda3iiD9gbM74wdVtxov5M9gSIXiX8YmOb7W2TU8Rp5w6O
         Yjiw==
X-Gm-Message-State: AOAM5304tG7FSEhugmirfx4V3N0s0qtwqHOG2LipIbSQR34OpzAi/Q8S
        OrSe1Z8f9uG/HtHhn9tW3E+U2A==
X-Google-Smtp-Source: ABdhPJzPbLO9sDp98FfvgVWezBqX3cN2pgde8sPN+g7m+FvfUPZXJemAdIBqzK3wSNJEDyZfh0UoQw==
X-Received: by 2002:ac2:551d:: with SMTP id j29mr1241216lfk.319.1623315410884;
        Thu, 10 Jun 2021 01:56:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p6sm254866lfc.280.2021.06.10.01.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:56:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3A53E1027EE; Thu, 10 Jun 2021 11:57:06 +0300 (+03)
Date:   Thu, 10 Jun 2021 11:57:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] mm: page_vma_mapped_walk(): settle PageHuge on
 entry
Message-ID: <20210610085706.zyvdoypn6vy43fm3@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <e31a483c-6d73-a6bb-26c5-43c3b880a2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31a483c-6d73-a6bb-26c5-43c3b880a2@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:36:36PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: get the hugetlbfs PageHuge case
> out of the way at the start, so no need to worry about it later.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
