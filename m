Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0228541E04B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352778AbhI3RlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352722AbhI3RlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:41:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4109C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:39:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b26so25273355edt.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBFXHARFQ6BmCFJJOsLjYh6MCL2g45Z1Rh5ubIbYOmI=;
        b=V97LYSYIBz7qx56yMPIZqCCA22l4dW7pVidzju2hYTNnI3GhkxlLFTx3AL6I3Pk+dt
         IVsI1mG5mgJ5hkVv+qllmTjeCuWU/PK6yMiPLp52Y4Akg/UHBEDm/7Bbi+AaAF9gwlIt
         t34p8QTgY2PPL8O4sNJuLp3nw+92rgzsbk6gZS/J+QeAl6u2T+QdADs7DYHT8Ocdk8Os
         XcXpz0RGMvNbswAzbD6anG9IwXM3u3SxL8A6YmpctGUPLFuT9kILdYrhn/+Fx7V2uS2a
         +t6UNkq9sFE99cDLgeVgVMMksTk2yKxzqtA1CPYP1c7nU5xfBti4iB6XJrV3ae+/wmw5
         dYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBFXHARFQ6BmCFJJOsLjYh6MCL2g45Z1Rh5ubIbYOmI=;
        b=6GsXh5cpTSvDoRNFZNpVeBSmJpVUccVAyqrxipzxO2JW03NzmpAUJ1CufDuQnbbiSU
         HgkWF59juy/+Wi6IA3H+wqZGJfExWtdajUbVFKLA8aRxRRaGJvMhAyPVShWsyHEnsAjz
         SiPHo+i6DBk8j8PiAnPsqLF8LzM8Iwxxvd53gTU18oMbKBSVfbQCPyvjCIz3+6naRoiy
         DN3FJgafjNeiprs1MxxcTLan+3NyLyb7Iubfskr8toQ1R1gbrqw4D/peDQnAionyRLmT
         fse4XIcB3HBhVgMavE8gM27DK8jdDT5PPFzRpZ/MtCjtKSpdBXxz9LLFXuJk8Pu9n7t3
         C67A==
X-Gm-Message-State: AOAM533QNgUtyDgBGLMDDycqy2a5UXptMChA/qu7tgLYN4EbtOcyI0TK
        gsrWo3iYsTWKsANzoOixLVdAwmkkFNmPY8Rgo7U=
X-Google-Smtp-Source: ABdhPJzG7awZ4BvsrrS64zuGfGd3yEJCDW2Wup/jcoQSvyxqmsIrjCSF48wYWFfCZsLcUvTmnrbW0XTrL5Ddvhd/BBI=
X-Received: by 2002:a50:8d85:: with SMTP id r5mr8583604edh.312.1633023566307;
 Thu, 30 Sep 2021 10:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com> <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com> <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org> <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <67906bf5-4de9-8433-3d70-cc8fc5cc2347@linux.alibaba.com> <CAPhsuW4_-ju9QgB7J4imrhQvH6ZqoOkVtVOVX11Yk_ZRakwQ+A@mail.gmail.com>
 <3d264ed9-f8fd-60d4-7125-f9f745ebeb52@google.com> <YVXXq0ssvW6P525J@casper.infradead.org>
 <f889db88-7b7d-ddb0-a7ed-3eda85d3eb96@google.com>
In-Reply-To: <f889db88-7b7d-ddb0-a7ed-3eda85d3eb96@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 30 Sep 2021 10:39:14 -0700
Message-ID: <CAHbLzkq7=FsXtp4YcjeruJwbYyhsRGCq+eC8uwC-Tg06JBTUUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page cache
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Song Liu <song@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 9:49 AM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 30 Sep 2021, Matthew Wilcox wrote:
> > On Wed, Sep 29, 2021 at 10:24:44PM -0700, Hugh Dickins wrote:
> > >
> > > Aside from the above page->index mischeck in find_lock_entries(),
> > > I now think this bug needs nothing more than simply removing the
> > > VM_BUG_ON_PAGE(PageTail(page), page) from truncate_inode_page().
> >
> > I don't think that's right.  This bug was also observed when calling
> > truncate(), so there's clearly a situation where two concurrent calls
> > to truncate_pagecache() leaves a THP in the cache.
>
> I assume you're thinking of one of the fuzzer blkdev ones:
> https://lore.kernel.org/linux-mm/CACkBjsbtF_peC7N_4mRfHML_BeiPe+O9DahTfr84puSG_J9rcQ@mail.gmail.com/
> or
> https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/
>
> I haven't started on those ones yet: yes, I imagine one or both of those
> will need a further fix (S_ISREG() check somewhere if we're lucky; but
> could well be nastier); but for the bug in this thread, I expect

Makes sense to me. We should be able to check S_ISREG() in khugepaged,
if it is not a regular file, just bail out. Sounds not that nasty to
me AFAIU.

> removing the VM_BUG_ON_PAGE(PageTail) to be enough.
>
> If you're thinking of something else, please send a link if you can - thanks.
>
> Hugh
>
