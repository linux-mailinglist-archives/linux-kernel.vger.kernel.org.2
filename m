Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9503DCE0F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 01:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhHAXNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 19:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhHAXNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 19:13:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCEEC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 16:12:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j3so2429763plx.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 16:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHYj2rikYBVPR1AnfbpEYOnfHEiY6M+Z/Yv6hUYWiYw=;
        b=pP+jd7pno7a/FHKLtzA4tTfY6C9lSutvqYTbX05d9b9vLj5+DzQZmAGfsbII12eiEu
         te9N4ZsfEwPDW/p2X/j3NmEgXTAtSbvvLRO8STp/S6HibGwXgMWWNShzGxUHm6ZN7JOv
         OnF7muihY07NhmnGiv8l67GS22mcTOlQD6PVPohYlWPB+f6e38mg8qFJgxgpt18d27q1
         jZVzWQXPYBUpHDTFHlvGjGw/eUt81NVQTfvZRiK2BfBTxKyBrfNTBmHZOOsoxpBrfOhi
         BOEtCU7xuLBpNO2ZK7tyqslKZ8XPoaSeIpUUrbj7CcEtTOhYNN7YUYOLPoiN7ZLDMf4o
         cRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHYj2rikYBVPR1AnfbpEYOnfHEiY6M+Z/Yv6hUYWiYw=;
        b=YgXeKZZzOs26guuOmVKx3ICA6lDwqVufRGWFQfXbUvCjsbgzOPqeOpzFcMG0PyLWGt
         a1NmlGIfaRqiuIm7OZBnimqu3v+mOVroyDGOusZJrDXHMR5Zgvxp5py+8ojjX76ID9J6
         VTKIEQl1XgdYYpd3kVGs5fs1w9sOwEkW+xx1M8H1oHuq3X1L9ZNGQRb/LuEnPT3wwfl/
         2HJqvhIu7lo0adHaVXO07QpCPVtyUjB2ySHLFrCfF21VdkIpC+hLpJnIV2UiluA3AZ0l
         YUHKNUplwUVp3DWsjeQbYAVsTR1BndqEU0Mtw4gS+Rq9s/zxjLRehuRKIXiTJSa5dI6D
         zXLA==
X-Gm-Message-State: AOAM533XzQFnbxt0kgGWmV7Dd4C+qIX2F5hKcyIRLO5EJA22zw5zEJ0X
        YWhuCxsdE6mbBUbeHuQfbc1N4PaNjpfRJtUW9uruhA==
X-Google-Smtp-Source: ABdhPJx0Xwqam4KlfVojLpYxy9rIzxCZX3GJfhDDIs1AVZrY0/knostamF5zhtfhHHlvzvTlLk8nPWTZ9BJwWwYr5JQ=
X-Received: by 2002:a17:90a:9b03:: with SMTP id f3mr13869141pjp.184.1627859570946;
 Sun, 01 Aug 2021 16:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210730221522.524256-1-almasrymina@google.com> <20210801124917.ca6fce3972866dc738bfcb7b@linux-foundation.org>
In-Reply-To: <20210801124917.ca6fce3972866dc738bfcb7b@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 1 Aug 2021 16:12:39 -0700
Message-ID: <CAHS8izM6p-bbhh+gDJmRfVRk2bWjtDr6Rfpm-rjA_t-i=GBYOQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ken Chen <kenchen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 1, 2021, 12:49 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 30 Jul 2021 15:15:22 -0700 Mina Almasry <almasrymina@google.com> wrote:
>
> > Support mremap() for hugepage backed vma segment by simply repositioning
> > page table entries. The page table entries are repositioned to the new
> > virtual address on mremap().
> >
> > Hugetlb mremap() support is of course generic; my motivating use case
> > is a library (hugepage_text), which reloads the ELF text of executables
> > in hugepages. This significantly increases the execution performance of
> > said executables.
> >
> > Restricts the mremap operation on hugepages to up to the size of the
> > original mapping as the underlying hugetlb reservation is not yet
> > capable of handling remapping to a larger size.
> >
> > Tested with a simple mmap/mremap test case, roughly:
> >
> > void* haddr = mmap(NULL, size, PROT_READ | PROT_WRITE | PROT_EXEC,
> >               MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> >
> > void* taddr = mmap(NULL, size, PROT_NONE,
> >               MAP_HUGETLB | MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> >
> > void* raddr = mremap(haddr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, taddr);
>
> Could we please get testing for this added into tools/testing/selftests/?

Yep sure thing. I'll wait some time to see if there are any other
review comments and then send v2 with tests.
