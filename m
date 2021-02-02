Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF530BA31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhBBIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhBBIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:45:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BB8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:44:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d16so19472769wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xF8qedlJolmxjBdAS9Sywdm5NC/I3fz6Ssj86vPbp9Q=;
        b=nmh/0ol5uk8pnSQmOGqt5K+oG9m/FjeGJIk0NTKlL8ZgvuGa8p1neScVJUkY7ukkQG
         AqsofN2KljvUHs5ZtCuSyeIYsxvqXegjpdJiq0Xfn+6czRRXlz8jU/EWBRoiTv0Hk47N
         hu04jb44kmVuStIgWubzXJXisr55AgYzM++/mqxGDul53FkOWZ6XxIZCYEXd0o/cU33Y
         4yrrbiFICwviSZL4z/hVtMmNW+9tgbjoST/WEhTcVa0GyEtWVkYg5IUMYNZwwYs1l4f+
         9QaKNKErlpGfCcVia2qHuffZFIj5v0lmyXBo7SgUdSelOi8phh7UQCjCNKL3Gf2tcOCe
         W5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xF8qedlJolmxjBdAS9Sywdm5NC/I3fz6Ssj86vPbp9Q=;
        b=F2YWMo7ZuX2HG3kCZwGv2yluGcCLsJiDcIidgRz3NZEP8efzoTqirMnLv+GiniA+3J
         JkiBpJ4EiyRWM0neOYfv1OmMr6E/Z/CZZcKveuSaqM/QvzLuPE8adrfJcsuXYs7+cCFD
         R4hBE4ZWaHKXpf8aZOlGBSAEjw0Wr8XDBjEii0lpSjZSCzrQ7LchkFUURkensSSNsg+u
         ZHDqIvEirWY+c4OHA/U9DPi7+xxibOCm0Uy8lVvHzKjJVSn3+uPLePqJVf+QlKrXtszo
         w8EbQe5BERYTxggluiCIMjpvibufUwtUJUeqXzI8wX6GrjSpldEaARGb0KjkOg9NZBQP
         F09A==
X-Gm-Message-State: AOAM533owq6Sx1R/UQPulXLhPNlTLG5cOdcTiQBznNJsDet4r7MnBt7B
        rTTQnjwPEE/M++7sRtR5UVCVr8/+SzujjvBtN7kgFw==
X-Google-Smtp-Source: ABdhPJyIcGuuSym0awOVNMXB2Bhi1rD0SlTVRtk+EYonkDPzcHjZReKVITS7PVf3SKTHsvL5JyeM/K20x3otaInPs6I=
X-Received: by 2002:adf:ed45:: with SMTP id u5mr22294772wro.358.1612255495607;
 Tue, 02 Feb 2021 00:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20210128083817.314315-1-surenb@google.com> <20210128091348.GA1962975@infradead.org>
 <CAJuCfpFUhJozS98WJpH0KQKBzyGXvqS1fitu-mgSyhaJ1xL8SQ@mail.gmail.com>
 <YBMAGRIwcbPF17cU@google.com> <CAJuCfpF78RYedBoAgkDdgMdfSmNwC2AQk-zZxAqkhCdtBB9gtQ@mail.gmail.com>
 <CAJuCfpH5nwvtMR+32G0-xa_hY-b_Hnw=Figqq9xcsTGgJhOiww@mail.gmail.com> <20210202070336.GA3535861@infradead.org>
In-Reply-To: <20210202070336.GA3535861@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 Feb 2021 00:44:44 -0800
Message-ID: <CAJuCfpHWVcL1Cw=nm4THf0EzEan0jyVgLRNOdKr2ZbXex3DUcg@mail.gmail.com>
Subject: Re: [PATCH 1/1] dma-buf: heaps: Map system heap pages as managed by
 linux vm
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "(Exiting) Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>, labbott@redhat.com,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        "Christian K??nig" <christian.koenig@amd.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        "??rjan Eide" <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Jones <jajones@nvidia.com>,
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

On Mon, Feb 1, 2021 at 11:03 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> IMHO the
>
>         BUG_ON(vma->vm_flags & VM_PFNMAP);
>
> in vm_insert_page should just become a WARN_ON_ONCE with an error
> return, and then we just need to gradually fix up the callers that
> trigger it instead of coming up with workarounds like this.

For the existing vm_insert_page users this should be fine since
BUG_ON() guarantees that none of them sets VM_PFNMAP. However, for the
system_heap_mmap I have one concern. When vm_insert_page returns an
error due to VM_PFNMAP flag, the whole mmap operation should fail
(system_heap_mmap returning an error leading to dma_buf_mmap failure).
Could there be cases when a heap user (DRM driver for example) would
be expected to work with a heap which requires VM_PFNMAP and at the
same time with another heap which requires !VM_PFNMAP? IOW, this
introduces a dependency between the heap and its
user. The user would have to know expectations of the heap it uses and
can't work with another heap that has the opposite expectation. This
usecase is purely theoretical and maybe I should not worry about it
for now?
