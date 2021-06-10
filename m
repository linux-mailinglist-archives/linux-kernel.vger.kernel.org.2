Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B403A284D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFJJeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJJeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:34:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEFCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:31:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m21so2134198lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g+Y5ZivuFcmuf7Flo1ol8YPyjTyhr8NhAnLzV5ueT74=;
        b=jaEsEWC8fl4uP6hpimePVfNEmdSw7OHIY0EYdlK9Lqk6IwlaujBFd1RoXVZb6gopsQ
         oTExhfZMQM6DGsxA4GXTZm7a7HuLaA1z8j1IOTRkmi3rFVNWrUzxIsy2fPcuoL3SeKN0
         JhMwOXUv2Wve1RkXXI3Iynp4uRynMrqWvTWkxL6cG5B0MWmV9Dx6WPhgFaia1bwTOdxF
         EAuk3Aen1TxxIJlR3rWyTSfZ45CWTEuRlHCGAd5ZttEi/EFlIVdGpdBuPHo+YhqYRUKM
         QmrHs/rwM7e8V3/8NFcllE+s3jcoTn3e+gRwVSoQJ8FvEs9BFY7Ut3MuqvjBXe3+O3ok
         xekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g+Y5ZivuFcmuf7Flo1ol8YPyjTyhr8NhAnLzV5ueT74=;
        b=qS5EysaRP9DhsrucsZ8vTPN3s5M2lcGLrwu/wGprxUGc8MZDOEmcL3j/IoITUY7ej2
         9+tU2q9gOT+EvVW28UE9Q1qSt1fEiDbc+Ka28G3tz8s14l5bkMDpIVO+QBbVxQPIMO0/
         mCjFjdjkXb3Z+DfCIViKHVRqJLOrZQNKdHHKfXd7Xiahc6pVNByJpddQMQkkqPmhN8EL
         6PKaWYDSu4WFWIA5khbHs+qajpAxrzzGa07exlsm+VG2ele/94ifQEEBh94NnlipMklm
         1E56NlOahTWRR4Ph9qRv8EBfuDN9tIiZmQpgO5YguA1Mjmn3SaTKc5xJNIw3xf5M6+/Q
         RGZA==
X-Gm-Message-State: AOAM531ppKpOL3dJXCKSNctMQ07Yaf5O2ezboudVYkj2Lb0D/aF8QB8W
        V9lOtE3jRa/shHB07V7nWiAK0g==
X-Google-Smtp-Source: ABdhPJyrE2vXn+tTVAuLau4gyY8tBxxXrBVXNu4X49cCz0jE7e1Z15hZFqbdFySt7jw4NvWcUXXLFw==
X-Received: by 2002:a05:6512:3baa:: with SMTP id g42mr1358231lfv.195.1623317508561;
        Thu, 10 Jun 2021 02:31:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h11sm245317lfc.247.2021.06.10.02.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:31:47 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CD8821027EE; Thu, 10 Jun 2021 12:32:03 +0300 (+03)
Date:   Thu, 10 Jun 2021 12:32:03 +0300
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
Subject: Re: [PATCH 06/11] mm: page_vma_mapped_walk(): crossing page table
 boundary
Message-ID: <20210610093203.x42jpifagiavmrlp@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <799b3f9c-2a9e-dfef-5d89-26e9f76fd97@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <799b3f9c-2a9e-dfef-5d89-26e9f76fd97@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:44:10PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: adjust the test for crossing page table
> boundary - I believe pvmw->address is always page-aligned, but nothing
> else here assumed that;

Maybe we should just get it aligned instead? (PMD_SIZE - PAGE_SIZE) is not
most obvious mask calculation.

> and remember to reset pvmw->pte to NULL after
> unmapping the page table, though I never saw any bug from that.

Okay, it's fair enough.

-- 
 Kirill A. Shutemov
