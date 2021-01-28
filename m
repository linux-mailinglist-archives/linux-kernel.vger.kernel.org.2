Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763773071DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhA1Ios (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhA1ImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:42:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:41:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i9so3896543wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tz3WgXFPgDJH06BRPqiMzvbO9SluCp9ZzIIjw1Gx/70=;
        b=aH/QGbAv4jvj8FoWIw9gPBiYRFqgrDjIzsR/Q0qOJPjfpx9Z1Xbz+DlKgkIbdjL5Bp
         REdEQ0hqdGvXh8tiS0Lm8hR/dsoilS0sBlDM3HGjlEn9nmw9mzT9HPUDGXNoK9Mj0nKJ
         MXhQvZWD8Pzf3JPQML11qDmzYx4iTMY99xQqyhJy+vkORoV+T+WaoiNx5QoZxkA+neiZ
         0EDGQafi0d2unaJeM6oMYMuMZPqBVz9oGTEkHMFFZq6fMh++OJfe8lzMVBo1RbJWrrgQ
         rD5MFOEQ79DZXDMo5cDF2ZwBS69uOD+V13qTZdc3ZDpnhjidcCGrf+cPSTP1JLShGom+
         Fe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tz3WgXFPgDJH06BRPqiMzvbO9SluCp9ZzIIjw1Gx/70=;
        b=hwBjYjeHq10BuTDTBmftJZU9iiUq5UcFGBH9hjbPS4heDjkoydaGqtK+iH4dy1pUjO
         3i2MLvA5HNHJJ1N0ICTm79J7tSBwXIpUmv4N8YRTz0Y05T35lpm85WNMPVW4pDTAX7k2
         EuCkI0Nag3HSog3cJ/Jn4O5X6BhyF+ZwN4NXf4bEokgv5IuSTNIr7OCdE4P/VAtC7ehL
         4+z/WggXXrsBejI5tBqAv1P924QQHJ6fdjZYaWYlwLDt1BYB8mp7F/s0w+JpVyCsp0l0
         t6YY0LF/7wyWYUI9c1tsuWwFarp6BY5SQT6U20ikVesW6kyOlinKe0oLe6oGHeJ6cnfL
         jcJw==
X-Gm-Message-State: AOAM5305BlWI5Egg5ZfMf+kupV/KiyS5OI11ib7GR6mUdQ+iIzavkgq+
        vFrFKQAYEnOPtzo9e3Mn2a4buku4ZszaTVYZxD5gkw==
X-Google-Smtp-Source: ABdhPJybFfYSYako7tYrbS7cIdHvjhegTnAmdT9SipLr0QTHAYBZpolB5GrAZ47/mXPmVL+zOKl+vtUE/ns/AmASesM=
X-Received: by 2002:a05:600c:4e92:: with SMTP id f18mr7561817wmq.126.1611823314553;
 Thu, 28 Jan 2021 00:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20210128083817.314315-1-surenb@google.com>
In-Reply-To: <20210128083817.314315-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Jan 2021 00:41:43 -0800
Message-ID: <CAJuCfpFn0bpk=6gWhwCBK717fh0VEzkpKjuyJqW36AAO43EDgQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] dma-buf: heaps: Map system heap pages as managed by
 linux vm
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     benjamin.gaignard@linaro.org, Liam Mark <lmark@codeaurora.org>,
        labbott@redhat.com, Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>, christian.koenig@amd.com,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Jones <jajones@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-media <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:38 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Currently system heap maps its buffers with VM_PFNMAP flag using
> remap_pfn_range. This results in such buffers not being accounted
> for in PSS calculations because vm treats this memory as having no
> page structs. Without page structs there are no counters representing
> how many processes are mapping a page and therefore PSS calculation
> is impossible.
> Historically, ION driver used to map its buffers as VM_PFNMAP areas
> due to memory carveouts that did not have page structs [1]. That
> is not the case anymore and it seems there was desire to move away
> from remap_pfn_range [2].
> Dmabuf system heap design inherits this ION behavior and maps its
> pages using remap_pfn_range even though allocated pages are backed
> by page structs.
> Clear VM_IO and VM_PFNMAP flags when mapping memory allocated by the

Agrh, please ignore VM_IO in the description. The patch does not touch
that flag. I'll fix that in the next revision.

> system heap and replace remap_pfn_range with vm_insert_page, following
> Laura's suggestion in [1]. This would allow correct PSS calculation
> for dmabufs.
>
> [1] https://driverdev-devel.linuxdriverproject.narkive.com/v0fJGpaD/using-ion-memory-for-direct-io
> [2] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-October/127519.html
> (sorry, could not find lore links for these discussions)
>
> Suggested-by: Laura Abbott <labbott@kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index 17e0e9a68baf..0e92e42b2251 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -200,11 +200,13 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
>         struct sg_page_iter piter;
>         int ret;
>
> +       /* All pages are backed by a "struct page" */
> +       vma->vm_flags &= ~VM_PFNMAP;
> +
>         for_each_sgtable_page(table, &piter, vma->vm_pgoff) {
>                 struct page *page = sg_page_iter_page(&piter);
>
> -               ret = remap_pfn_range(vma, addr, page_to_pfn(page), PAGE_SIZE,
> -                                     vma->vm_page_prot);
> +               ret = vm_insert_page(vma, addr, page);
>                 if (ret)
>                         return ret;
>                 addr += PAGE_SIZE;
> --
> 2.30.0.280.ga3ce27912f-goog
>
