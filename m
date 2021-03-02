Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8041332A0EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576810AbhCBEcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242522AbhCBCyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:54:18 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B49DC061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 18:51:22 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id n16so12021834lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 18:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8E7jhhYaCr8C6xSxrpG64nSWDU98o0HEwhCAOn7PAok=;
        b=CtAXWUOUEPDunoQwsrVEycASyIeLXdyliiw3gjDfZoPH+mu6HRFJOGnvR+MXDvPlDm
         oJEoBKJceAIP2pSJHn+StAUkr8+FPr8L0aB9U0Vy1qM2/Mbuam3IoNYxT5pbkQ80CSz5
         v+n7Dc+u4gZ3D8doFYnzRKlLYdu9QORdgOB+hiY2Y5a++SWfH2tQYDboAkTDYnDaSE0Z
         JRvCN/hTYcNbxkcDEy80hNN15DwQWGSIOoLUUTwsvFme1NaGT/LGKe9KUqplff5A7xWE
         XyhzBmSQ2tNJ2WB0xFUzwBEFK5UX42BcM70Ib0iGxM8OhzGOBsql/eZGL2c4DYIhUEFD
         Xw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8E7jhhYaCr8C6xSxrpG64nSWDU98o0HEwhCAOn7PAok=;
        b=tZCTnLR1GC1zVYvHd757N+PzHJmk23nEtfRwe8fsx7/ycB+5jSHsh2jiZYiMSCmwuA
         dJAXQAMrEzZCNo+XdCsh6/kUKlkrSojOHeSarbouEm1Hq7UHHNTCkD7WCDhZuKSks8Au
         n4Xi7mAfJz5suPHP4OPBQXFzvgjXzNlY0ygHSAGajyfGVvGaWeCT1KL1RfWFYW6XJVQb
         pON8lW+T7Hs8/tRS9FbdYsTmQ2ZGupHHRqFbcWGrtwlKftakrgM3GluRloZ9DlxqOqVk
         6mh52TBYR4Y1KybaRMcXuYSlKcq1eSZow/yrEOOuz4kOlQfKueu9t7K0IVWoi6hEcPRo
         kPOQ==
X-Gm-Message-State: AOAM531mghSX1hEZAFXGRVgog9mLaCYS/y6O3JvnaDKJ4pqEORl7+o+1
        kpCpcdnU87J+tyX8/ymj9zOJRBrBwCY3ngPUIpxvmw==
X-Google-Smtp-Source: ABdhPJz39rZTCGPuL53OOyY7GEDe7aOcYzZlxQr263eEFf2vvM39BGGanu2WFzPxlDI0/hLiEweWlg9234LilyOgSj4=
X-Received: by 2002:a05:6512:547:: with SMTP id h7mr11428172lfl.529.1614653480706;
 Mon, 01 Mar 2021 18:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20210226040908.3274666-1-john.stultz@linaro.org>
 <CAKMK7uHGutJiZ879NAweTHka=gZQBw9zWQSDJn6bTLS6bJwvvg@mail.gmail.com> <20210227094436.GA3130571@infradead.org>
In-Reply-To: <20210227094436.GA3130571@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 1 Mar 2021 18:51:09 -0800
Message-ID: <CALAqxLUcbAWiwxqLRmr4Ve4ecSAJ-jsZy-RDC3jqDONgoRht9Q@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Set VM_PFNMAP in mmap for system and cma heaps
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        lkml <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Koenig <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        "??rjan Eide" <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 1:44 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Feb 26, 2021 at 08:36:55AM +0100, Daniel Vetter wrote:
> > Also given that both deal with struct page there's a ton of divergence
> > between these two that doesn't make much sense. Maybe could even share
> > the code fully, aside from how you allocate the struct pages.
>
> I've been saying that since the code was first submitted.  Once pages
> are allocated from CMA they should be treated not different from normal
> pages.
>
> Please take a look at how the DMA contigous allocator manages to share
> all code for handling CMA vs alloc_pages pages.

I'll take a look at that! Thanks for the pointer!
-john
