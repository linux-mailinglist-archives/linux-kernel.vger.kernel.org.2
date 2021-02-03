Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D0730D59E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhBCIxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhBCIxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:53:13 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE183C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 00:52:33 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id v1so22651682ott.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXUrCQnAejSUnzy7G5KQj25VP/AJcEkhVg3Q+PK8vz4=;
        b=h89NNkJ28dLA7gdauHFsbCLgf6ShwELHkxmLj9kk3FjCsOPPRSFu5NoS75J7NXyryC
         AnUfyRIg5e9tkqHC6oD1I2yEEZn92J7PRB0ijtGjwLJswlozN8neKq3iV/DJEG8czCN9
         nMTjMXEZmZc7MnsH32Y4HaCC9Qg5+gP1bAYds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXUrCQnAejSUnzy7G5KQj25VP/AJcEkhVg3Q+PK8vz4=;
        b=tORj8bNPM0nVpX2BXEb/GwfMMcG2vXfwfulEQrDyRsL+44ou/o9qLoJy0IYG08k0TJ
         Q4xYYeBEAnTvTyYH8ToB7DKlXJjGfqYwgxl2PyPyM96DU8eQ5DyU+EJszId9JLBWD9HX
         gDfUPswMkF7F6Mwr/RJFC+B8wZ1AN+BGgwPXbY+Wzl3cuC/MC5HAgauHSHbESoi8VU4H
         Op4z8Kr4LThzDraLsp/+mHKmbgZv6nw8FWIxAX1w6HVPB2POyEkqZDYJEGPYlik0O+VJ
         t7ppKuGNML4RnvRiDI8Zn9U29zhJ+IhfkPfvLD2b++qBKrRVyDEPHF52ll2xElCL0Z9d
         tziA==
X-Gm-Message-State: AOAM533/ArPEp9Sxv/QGIIH83/QNGZAA12Y98L743+cAzeIL8TdPG+cu
        MzGjUqZqdvMNMDQ2xOzeNs60xkbMM3II3STtZVmSwA==
X-Google-Smtp-Source: ABdhPJxq0ZEI6IC6j0hBli9D1xyK0kKminNBfdIJ8J0cuKUE95JWskdN1yRslq7D4jprmId2dxKIg9w+bU/AkYBdsjY=
X-Received: by 2002:a9d:2265:: with SMTP id o92mr1340983ota.188.1612342353066;
 Wed, 03 Feb 2021 00:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20210203003134.2422308-1-surenb@google.com> <20210203015553.GX308988@casper.infradead.org>
In-Reply-To: <20210203015553.GX308988@casper.infradead.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 3 Feb 2021 09:52:22 +0100
Message-ID: <CAKMK7uHnNdjOYX5Rhj=uGMz7hSz12JhgkZJCfiqgkpjXnMfL4A@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] mm: replace BUG_ON in vm_insert_page
 with a return of an error
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Sandeep Patil <sspatil@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Android Kernel Team <kernel-team@android.com>,
        James Jones <jajones@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        John Stultz <john.stultz@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 2:57 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Feb 02, 2021 at 04:31:33PM -0800, Suren Baghdasaryan wrote:
> > Replace BUG_ON(vma->vm_flags & VM_PFNMAP) in vm_insert_page with
> > WARN_ON_ONCE and returning an error. This is to ensure users of the
> > vm_insert_page that set VM_PFNMAP are notified of the wrong flag usage
> > and get an indication of an error without panicing the kernel.
> > This will help identifying drivers that need to clear VM_PFNMAP before
> > using dmabuf system heap which is moving to use vm_insert_page.
>
> NACK.
>
> The system may not _panic_, but it is clearly now _broken_.  The device
> doesn't work, and so the system is useless.  You haven't really improved
> anything here.  Just bloated the kernel with yet another _ONCE variable
> that in a normal system will never ever ever be triggered.

Also, what the heck are you doing with your drivers? dma-buf mmap must
call dma_buf_mmap(), even for forwarded/redirected mmaps from driver
char nodes. If that doesn't work we have some issues with the calling
contract for that function, not in vm_insert_page.

Finally why exactly do we need to make this switch for system heap?
I've recently looked at gup usage by random drivers, and found a lot
of worrying things there. gup on dma-buf is really bad idea in
general.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
