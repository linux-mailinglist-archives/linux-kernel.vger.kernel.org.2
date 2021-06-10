Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C963B3A248B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFJGeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:34:09 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B97C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 23:32:13 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i68so22708433qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=rKU7oZHObUw3YMoE26/u+eyLTV4/DZf9d0MBH5vOABo=;
        b=F0gpvRmNqTdYXTGMccw4P8InnlhpGqbHzsWVgdNwC2ILxTgCRe8L+d5SCQnIpv6Xgs
         ffMgTUPESnj+FTlrSZjfGOvHOSfdqy/fqDOobLDEQ9S4aCjGyw9Za+2bndFM7dBrKAVo
         oMXwNbPN/TaUiB8jrv6F0eNw2WzBAL3S22H+a7sdLBeTlsdW/V7TT0W/hguQwZJnTdbH
         FFH/B3oMZVvHMaRNnsQfs1JvmR0a/BaYGIYCEsJDdtHXXivcDpiUgS7d3XAwudZkPgI9
         +YaQgSiaSAh9/RZbqW6OuFSit7nUutF7EnmeDa/WKzdQ+lW2b1cfXjTXITtk8oVegGAM
         fP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=rKU7oZHObUw3YMoE26/u+eyLTV4/DZf9d0MBH5vOABo=;
        b=XssEo9mG5269guKv6OEPMDkmCCvOoQWWXt3O3PJidFho1S+6VRcp+QKpjiSqNb4px5
         EKDN+850fa6L4QEC4XFboaCpcDercsKSGi2fcH+o2xgdMYC5ryG4WvOBzmJ2okmARyyu
         C9t95WU7/z3+KrAVk2VOE7VMmL/HIlfpoZeAa5maVv1Q8bOSrYZrBDUat6FZwcBoIm4P
         1VUaH/gGgswjV0Rd7YyPqZn3A2q0diUhfXmuFAuspBS8/xJYPr4FnhlTZ3Z3euavGHzK
         GwAijo1LeMK9XoknEy9uOfSnUr9j6LJe3r3p84KxFf6N3yJn0y6I5uRXK43J6/YEDk0c
         TFdA==
X-Gm-Message-State: AOAM533bBpvO0s4EQpnkBLwy+NcMHWmYYfpjCnvUEko3pUoGbGP1mXMh
        xQyt88OQ4Jx/U2T6zOLPMj3jRw==
X-Google-Smtp-Source: ABdhPJz+HT2ALNEsStJr5GIZwireXwBnHeXMm8jG5B1+AAK/E1ASC3c1QWpUJ0zGeO+ZMwoJ4IUlEw==
X-Received: by 2002:a37:e215:: with SMTP id g21mr3182478qki.37.1623306732373;
        Wed, 09 Jun 2021 23:32:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i11sm1591461qkl.95.2021.06.09.23.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:32:11 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:31:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] mm: page_vma_mapped_walk() cleanup and THP fixes
Message-ID: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the promised splitup of what I posted a few days ago as
5/7 mm/thp: fix page_vma_mapped_walk() if huge page mapped by ptes.

These are against 5.13-rc5 plus yesterday's mm/thp series:
https://lore.kernel.org/linux-mm/f7fc2e72-b8b1-f132-cdb2-1b256a6f2de@google.com/T/#u
(sorry about the misthreading, I missed linux-mm and lkml at first).
03/10 and 04/10 of that series also touched mm/page_vma_mapped.c.

I've marked all of these for stable: many are merely cleanups,
but I think they are much better before the main fix than after.

01/11 makes the opposite cleanup to the earlier 5/7: that preferred
to use pvmw->page, this prefers to use page - it could go either way.
11/11 is a new fix that I noticed while splitting up.

01/11 mm: page_vma_mapped_walk(): use page for pvmw->page
02/11 mm: page_vma_mapped_walk(): settle PageHuge on entry
03/11 mm: page_vma_mapped_walk(): use pmd_read_atomic()
04/11 mm: page_vma_mapped_walk(): use pmde for *pvmw->pmd
05/11 mm: page_vma_mapped_walk(): prettify PVMW_MIGRATION block
06/11 mm: page_vma_mapped_walk(): crossing page table boundary
07/11 mm: page_vma_mapped_walk(): add a level of indentation
08/11 mm: page_vma_mapped_walk(): use goto instead of while (1)
09/11 mm: page_vma_mapped_walk(): get vma_address_end() earlier
10/11 mm/thp: fix page_vma_mapped_walk() if THP mapped by ptes
11/11 mm/thp: another PVMW_SYNC fix in page_vma_mapped_walk()

 mm/page_vma_mapped.c |  160 +++++++++++++++++++++++++++------------------
 1 file changed, 96 insertions(+), 64 deletions(-)

Hugh
