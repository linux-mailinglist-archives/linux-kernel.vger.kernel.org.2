Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB6429419
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhJKQFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhJKQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:05:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B10C061749
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 09:03:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r19so73074888lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kR8cVcJwKF9GXGV4SLswTft9R5wnSnYpe56HVAjGBfY=;
        b=AiFUgJZSg8qAETiAOyE9EP8tqDeBADXJ6UHtIVcK8TABuDZtWkbDhwKSTJKRegrrDW
         9Ek4iDhd9druNdgiNpgDzrd7A3mMNenBuoJ2fvKrC1jEjLW6AQE3/JCsWAR3Xo2Ds1Gi
         6ihck35sDRZTUOFg8MuMTD3+/ynHUdixAKUEZ6Fj7fpz9Au6TlqwFIraM6QOIkkw7UEg
         q4tPcOvY0GmBAtbgFBP42lYXIK3+uZq+8Uq0b1fkDRfWTDMcsMRBowYgM3J1dCBVYuij
         v5a4Gn/SylpYgXlv81ncLbOEsIy+SvovpaaQ/1o+fm2tYHOfNyjX5UlPE4OIqoTqfURQ
         Lk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kR8cVcJwKF9GXGV4SLswTft9R5wnSnYpe56HVAjGBfY=;
        b=BtxjLJwHWh+PFoM5ekvnKDy5DMDrplUYHqMUtQaxoeAK6zIOm15DPTz9OGnxayOX3J
         hHKE0K+O10BuHiuICIDPYD2G48ae165YFuF0t27H0ZoOpf6izFinAw7dDFj0xhNkL8O1
         etBPl/46xgXaqu6H0u4IBiHx0wF3hAmre/7aM5/FZnKTTcoXxMdUK0XnqUTlhuKYj6y9
         aCOpmONh3c0dZhdiAUGClH+Q2Xd3GA8Pp9MkAVOhxS2rMvPbqXJS98dhPZFD4SDpV+k5
         8OtyHjmvZbgylfrAzCfgbIVPiMfs3pSOo1Mms3dJWtHH6BfAYKYkTiO/s6Sw1P+WT7GK
         E8MQ==
X-Gm-Message-State: AOAM531cSx91o6j5EGyk8DPen3uOXEJ4NHOzyxA7yBCYizSApgNGWoW7
        xXg7FbOeNJU8FioTbNeSF507XuAJwRfq3DY++OlwIy1f6OA=
X-Google-Smtp-Source: ABdhPJxzTdsG5f3qJEq39X5L95WWGuXKApuuacxL9M0wV/cZyW5NowI/jafTFnq3xkTBsGQepLEKzoRs1P7BspxatHY=
X-Received: by 2002:a05:6512:1056:: with SMTP id c22mr1305274lfb.26.1633968178827;
 Mon, 11 Oct 2021 09:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211006174910.2964885-1-daeho43@gmail.com> <5743eeca-a6e8-87d4-5799-c622fbada429@kernel.org>
In-Reply-To: <5743eeca-a6e8-87d4-5799-c622fbada429@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 11 Oct 2021 09:02:47 -0700
Message-ID: <CACOAw_zfDZMB4pLEuHWU5YcKnAtfBBTSuXwXy+L2rNJxXC3ysg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: include non-compressed blocks in compr_written_block
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index c1bf9ad4c220..9b663eaf4805 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -1530,6 +1530,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
> >       if (cluster_may_compress(cc)) {
> >               err = f2fs_compress_pages(cc);
> >               if (err == -EAGAIN) {
> > +                     add_compr_block_stat(cc->inode, cc->cluster_size);
>
> Shouldn't we relocate this after 'write' label?
>
> One more concern, it looks we've changed what compr_block stat indicated,
> literally, the block we account should be compressed..., how about accounting
> it by introducing .presist_blocks, used_blocks or occupied_blocks.... thoughts?
>

What I wanted to add here is just one case in which compression was
tried, but couldn't save any block, so gave up.
If we put this below the "write" label, we will count blocks, even if
the file is turned off for compression in "user-controlled
compression" mode.
Like the commit comment says, I want to estimate the overall compression rate.
But, if we include every other compression disabled condition, it
won't work like that.

Thanks,
