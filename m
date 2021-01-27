Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D113064FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhA0UWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhA0UWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:22:08 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF660C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:21:27 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id k22so1212072ual.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkWQEhwAUNLuJiPKeTazkmms8jXTo1ixUZEQclL+Lbo=;
        b=r9q6TDXOq/oTKZfsDu88FKmFK1jFkobThy3I5RX5yDOWeZCqbXkAPofOZhwyzoX0S4
         lmw2aOQ11GEmGdt9SOTMz11LnKqrdTCNN4gnubxwe3dHZMhv+VsV8YZVjYxDcM5GYvec
         yEt+m/lAgrwWi3TGc166UztCAqnGYfmm3+WjObS9ymcp0mxV2NdAFelIasNCR9kP04OH
         EwBxAVdECFQaUOAnYMyIv8j85clAcXLfBlFscijmq8Zod7kAQCoW/+/203JvholLWk+4
         l4wJqVoFVxOmT+KnOdgd6PKD/9pTOcZiIb4GqWwjjWcspeNyAIXi9wFcN6CZ161qe0cV
         R4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkWQEhwAUNLuJiPKeTazkmms8jXTo1ixUZEQclL+Lbo=;
        b=LzDrjPu+O935rz5dJEFnyrX/cDq+haX7L8wO531ZKhqBb1Y5mSLneuOjq+yWm4TkrJ
         UfpNH53zFZLxDgvNj/Plvu2zPzLITFhJ4Rpe2nfImNCJGO3nCY5s8B16FEAJIqi7uo+Q
         6VEBl5yW/8AJJ2Kil9z1ZAEkZ3UsUNicuRJQ2Hts8u7tzidkDl9znJ573PsUFTqyf1Zm
         0UFL2p9kdFkYlrgqvASFgzRAKn4ZIH+WueTVwGeXqf0vQBewoc2dbIisbQhez0+LEtNh
         64ic95hiZHmLNWvICxxq8QiZpG0Agno6+c979i4k612sdvIL5xiYPfTy6b0JCdAPTxAW
         UHZQ==
X-Gm-Message-State: AOAM530hEIDPj+gzo75fLfZeyPmWg9UzACtAVZ7IqUssEwvABecqCn23
        nwEyVmOYecKkrCevD4tkVEn5y+VJzqfL8VWP9I4VNeIQCxrpuw==
X-Google-Smtp-Source: ABdhPJwGX8VLBXNChAV3Mpumim5+i60b+XOkzruAqORvpUqhkGg7ml8LK+TG1dC8IipynSj3q3fq1jXMWQAsSKX643o=
X-Received: by 2002:ab0:7584:: with SMTP id q4mr9773201uap.35.1611778886742;
 Wed, 27 Jan 2021 12:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20210123034655.102813-1-john.stultz@linaro.org> <20210123034655.102813-2-john.stultz@linaro.org>
In-Reply-To: <20210123034655.102813-2-john.stultz@linaro.org>
From:   Daniel Mentz <danielmentz@google.com>
Date:   Wed, 27 Jan 2021 12:21:15 -0800
Message-ID: <CAE2F3rA3a-MWBHPZhGP9dMhEUqMkkvm6wXYYh6LDZ1zF9CAyUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dma-buf: system_heap: Add pagepool support to
 system heap
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 7:47 PM John Stultz <john.stultz@linaro.org> wrote:
> +static int system_heap_clear_pages(struct page **pages, int num, pgprot_t pgprot)
> +{
> +       void *addr = vmap(pages, num, VM_MAP, pgprot);
> +
> +       if (!addr)
> +               return -ENOMEM;
> +       memset(addr, 0, PAGE_SIZE * num);
> +       vunmap(addr);
> +       return 0;
> +}

I thought that vmap/vunmap are expensive, and I am wondering if
there's a faster way that avoids vmap.

How about lifting this code from lib/iov_iter.c
static void memzero_page(struct page *page, size_t offset, size_t len)
{
        char *addr = kmap_atomic(page);
        memset(addr + offset, 0, len);
        kunmap_atomic(addr);
}

Or what about lifting that code from the old ion_cma_heap.c

if (PageHighMem(pages)) {
        unsigned long nr_clear_pages = nr_pages;
        struct page *page = pages;

        while (nr_clear_pages > 0) {
                void *vaddr = kmap_atomic(page);

                memset(vaddr, 0, PAGE_SIZE);
                kunmap_atomic(vaddr);
                page++;
                nr_clear_pages--;
        }
} else {
        memset(page_address(pages), 0, size);
}
