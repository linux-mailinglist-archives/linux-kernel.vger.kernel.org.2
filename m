Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C245135F109
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbhDNJsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhDNJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:48:26 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92FC061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:48:04 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id d25so3427085vsp.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VnkOL85Wb3szx9IKvjTA5WeF+yCa2dyNADfxmOIGTfg=;
        b=I3pbr7j6o4PC0MV1kzxZXh7ZyZt0CNQ/5a2fYxdV0/rP7d/FCcro0YE6Et2K4cXqL1
         Pxn45gU2vJ9SSEpRn1VV0HBc1J6F01j6LrlAKQFYBD1hwrNFTokMzWvAtTBi+IuTDXDZ
         Obnr1zkzAE0Nv1bZFjvgVBMRJu1Bo633j4i7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VnkOL85Wb3szx9IKvjTA5WeF+yCa2dyNADfxmOIGTfg=;
        b=jdD7agzyG2Q5ZpT/+NORzNJvO9ZmhnUQzMfftQo+aWRFQmFxKXBsst8+Y6pFHGYPkk
         N7H8Hs38nIH6U0Lv+BYxD90I7CnNxolAf/r/11njlUdWQG9zHTlfZ3EHU++UrAuBpE7W
         Xc7jS1QydX80DemR4PdnxUVOSgtMEjcNu8Sr4sWs4x3NJcQDLUwfKTddRDz/twETha0X
         tdQa7NM09ztZVAm2uEmsowLr+HEi04FePWim0jx1i+6HT4zMUaxUIdlp88EwMlqKCInB
         Q/oI95st+PJyTcfc2tmcWu7pURiMhorEV1NtRIjhNIojwAcICXY1JaS4xsV3B78yrRnM
         v5Bw==
X-Gm-Message-State: AOAM530S2hJxgNTLPeOIS7gVGZA2qi944mpBMCSy1s9UH+a0P09pg4zU
        SuMuzcyGYutspJqYeoR39a/Sh5DzwGOmDE5xRKXSRQ==
X-Google-Smtp-Source: ABdhPJyNUHm+B00L1dGXSyJLzDxm0FvABnT09MYzPzsPt7kZy2ZJYAVo5PHUMpYkDgv8J+TYNvXWmbywHWjbi53Cx78=
X-Received: by 2002:a67:b005:: with SMTP id z5mr27366996vse.47.1618393683121;
 Wed, 14 Apr 2021 02:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
 <f72f28cd-06b5-fb84-c7ce-ad1a3d14c016@linux.alibaba.com> <CAJfpegtJ6100CS34+MSi8Rn_NMRGHw5vxbs+fOHBBj8GZLEexw@mail.gmail.com>
 <d9b71523-153c-12fa-fc60-d89b27e04854@linux.alibaba.com> <CAJfpegsurP8JshxFah0vCwBQicc0ijRnGyLeZZ-4tio6BHqEzQ@mail.gmail.com>
 <0fdb09fa-9b0f-1115-2540-6016ce664370@linux.alibaba.com>
In-Reply-To: <0fdb09fa-9b0f-1115-2540-6016ce664370@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 14 Apr 2021 11:47:52 +0200
Message-ID: <CAJfpegvTX9rS0D6TXUUz3urrPFHng_1OntSWah+CU-7Fo5F-7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: Fix possible deadlock when writing back
 dirty pages
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 11:22 AM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2021/4/14 17:02, Miklos Szeredi =E5=86=99=E9=81=93:
> > On Wed, Apr 14, 2021 at 10:42 AM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >
> >> Sorry I missed this patch before, and I've tested this patch, it seems
> >> can solve the deadlock issue I met before.
> >
> > Great, thanks for testing.
> >
> >> But look at this patch in detail, I think this patch only reduced the
> >> deadlock window, but did not remove the possible deadlock scenario
> >> completely like I explained in the commit log.
> >>
> >> Since the fuse_fill_write_pages() can still lock the partitail page in
> >> your patch, and will be wait for the partitail page waritehack is
> >> completed if writeback is set in fuse_send_write_pages().
> >>
> >> But at the same time, a writeback worker thread may be waiting for
> >> trying to lock the partitail page to write a bunch of dirty pages by
> >> fuse_writepages().
> >
> > As you say, fuse_fill_write_pages() will lock a partial page.  This
> > page cannot become dirty, only after being read completely, which
> > first requires the page lock.  So dirtying this page can only happen
> > after the writeback of the fragment was completed.
>
> What I mean is the writeback worker had looked up the dirty pages in
> write_cache_pages() and stored them into a temporary pagevec, then try
> to lock dirty page one by one and write them.
>
> For example, suppose it looked up 2 dirty pages (named page 1 and page
> 2), and writed down page 1 by fuse_writepages_fill(), unlocked page 1.
> Then try to lock page 2.
>
> At the same time, suppose the fuse_fill_write_pages() will write the
> same page 1 and partitail page 2, and it will lock partital page 2 and
> wait for the page 1's writeback is completed. But page 1's writeback can
> not be completed, since the writeback worker is waiting for locking page
> 2, which was already locked by fuse_fill_write_pages().

How would page2 become not uptodate, when it was already collected by
write_cache_pages()?  I.e. page2 is a dirty page, hence it must be
uptodate, and fuse_writepages_fill() will not keep it locked.

Your patch may make sense regardless, but it needs to have a clear
analysis about why the  fuse_wait_on_page_writeback() was needed in
the first place (it's not clear from the history) or why it's okay to
move it.

Thanks,
Miklos
