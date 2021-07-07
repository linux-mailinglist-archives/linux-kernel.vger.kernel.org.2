Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6343BF0B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhGGUZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhGGUZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:25:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6495C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:22:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c28so7405373lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMZjIRwNGBTcmBaDjaDTIcE/+ESvd0yHScJIZfRhmRY=;
        b=XoGbXnrt2rSUgGiqSBd0+7Hv2ga602pEquNuyDtc82Q43CE4P4MFWL0EOTW+b8RfCc
         VhhEV1PFIxBZMVV3PpI+e94VGk9Hn4dQwLF5ZKxBbbPm+SwxAAncSIYwmHgaz868PtEU
         qUNs2hzLuukpSusfK7kVLSKzQzmP2IB/sCq+gAQJRjX4Wmett98cbg6A2iuPXsLyDhpx
         sV67WWpOKZgVUYIZvI71hYG85X5QImJ9F3IcLmrkViH52Gew08lc+VoEkAutVlkAPYan
         z+iByA9/ouV9tPZdasi1Z2u518puoIegI5cqDV8ifX2u+bGyM92nF+xLJ9xegJ02IK8p
         QXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMZjIRwNGBTcmBaDjaDTIcE/+ESvd0yHScJIZfRhmRY=;
        b=lnhaRtK8W2nNFG5Ivw/bgT/culaPE4PGzCMvNPKX4rU1q6zu8U6zLWvnhcMBjSZxjf
         pP3wAxCN5Qjpry1Og7hUK1Bjho6btNoDMO6E2ODcH/rJr/F7S3FMuLAC8JRjf80/fOXg
         5c+78q9Lcp5N6VQ8XJNTP/oKRCy02ZdMpN4OgCKJ+1+DDNpu0w8zNlOUzG3TF5gUwLbL
         213jLH68aYQOO/fKHAA1vFL+o59lYXLoIsAh/jD/l7Hk+bNvXiv26fSQA+ZO6eNvESk+
         DZXLH8fI9BqSObtd0Az0PCLgu/ZI1SnSOMS2tk7RFS6i2D2zCFk6no5apPcd2EZOQoPI
         DDYA==
X-Gm-Message-State: AOAM532cfx8ZwCUuw1wtKy8iJX9NWhYKkOAv/2bGJiNQfCcwfdY0AOGd
        ASF/LZffFehQ0Jue7kcXUONI7K9Mj5duQqcXGwq3pg==
X-Google-Smtp-Source: ABdhPJw5CFgnUoZ8OVZt6kqTwXENxQxQzBoRTuafQDIqikZS/299FK1fHjud/10xn99u575DWL5ZUyKvIzqZy9nXMKs=
X-Received: by 2002:a2e:8215:: with SMTP id w21mr20276932ljg.160.1625689339809;
 Wed, 07 Jul 2021 13:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
In-Reply-To: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 7 Jul 2021 13:22:08 -0700
Message-ID: <CALvZod4T1FRy2smMm9LU+VAo=A4Dcb749k9PZCBhFypHvAxBVw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/rmap: fix comments left over from recent changes
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 1:06 PM Hugh Dickins <hughd@google.com> wrote:
>
> Parallel developments in mm/rmap.c have left behind some out-of-date
> comments: try_to_migrate_one() also accepts TTU_SYNC (already commented
> in try_to_migrate() itself), and try_to_migrate() returns nothing at all.
>
> TTU_SPLIT_FREEZE has just been deleted, so reword the comment about it in
> mm/huge_memory.c; and TTU_IGNORE_ACCESS was removed in 5.11, so delete
> the "recently referenced" comment from try_to_unmap_one() (once upon a
> time the comment was near the removed codeblock, but they drifted apart).
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
