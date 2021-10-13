Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB3842C813
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhJMRzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMRzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:55:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F3DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:53:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u18so15220638lfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daV7f6edlBjE64Q8UviKTbVUx/C1ouI6DaLQnoPVZz4=;
        b=qUQSNI+tWAI3H3fGeeYhU04G3fOMAvst+PyBREFniFJzQeAaYYZvLlXjo4M2CdAbEk
         33CBKZzgWQE/KbeysNTdrj/G4lK0ogEl1hoCYfF4lpRBHderFOC4xtnyz2dkuw52aKBa
         mgtXifvoYMLq4VkbrmT/456ybO9DIAiepjAsviCPet/52JMxo50teZTsE+9yOWZH/5vW
         vRb8P+fIQX+2QmLaA9tP0jRP7Hvi5YImPLxKZ8mWpc6CRrwZlm/8IV3/RM31yYy56SSb
         2a314RhlkYp6Wv+dF8bEnFZ8q3iHxCcSwKoUTms7GIilHSgXy4iPReWA7lZjDodmxQ8z
         epqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daV7f6edlBjE64Q8UviKTbVUx/C1ouI6DaLQnoPVZz4=;
        b=PNPk62voUfOVvQ1QkXG3Ibfnrr8zKc39bgzdifZQQpoVD/aeMLaZ0RTYYzed2VUY53
         JCHcORygvqEh+VSF/u6EvRgPnm+ebblbVtX4M+a014wWyrE8OTDFXBDfEjTcGvsF86HC
         H7NrWgX816lLmupqScnpuvRe4B/ZtyDizLgR7N5JFCbr2KjdRX+BEcPBkiUfy4Sfbvnu
         mwBrLeW57a3C23rqIRDPKuhpK+ccxfKNcTe66UpcJwSdKNhBf/mF4IvRlL1BdpaW89OT
         QzuVjblAll7ih81Z4eXMaul1K+RBj8w0IQTgzO3FVaiw0TwT3o8lumzAircPB2rMNWP4
         +AiQ==
X-Gm-Message-State: AOAM533DaKlZNIBEeSkOUZNAMt6trU0qCg7E6icextRMbKdlJorUQQBx
        nGAjzD11lRZHsrWftKxFnl8Ui5wx3YHO7nGT56U=
X-Google-Smtp-Source: ABdhPJxA9vh2A+FeRnKkK8PokhkES4JqkDIMOW168Xf4a+v536ilyqGol1spqhD4/jpYqp2hQFLzT5z8D72WX8XZxjY=
X-Received: by 2002:a05:6512:12d3:: with SMTP id p19mr460668lfg.280.1634147580783;
 Wed, 13 Oct 2021 10:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211006174910.2964885-1-daeho43@gmail.com> <5743eeca-a6e8-87d4-5799-c622fbada429@kernel.org>
 <CACOAw_zfDZMB4pLEuHWU5YcKnAtfBBTSuXwXy+L2rNJxXC3ysg@mail.gmail.com> <16840026-35ba-cce6-4e0b-3332b0902d2a@kernel.org>
In-Reply-To: <16840026-35ba-cce6-4e0b-3332b0902d2a@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 13 Oct 2021 10:52:49 -0700
Message-ID: <CACOAw_xW7MZi8BVi-2Zo-=LruZr6k7fC7huYiYuWyaDDDti6WA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: include non-compressed blocks in compr_written_block
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, many parts of userspace already rely on these names.
I wrote that compr_written_blocks shows the block count written after
compression since mount.
So, the count of blocks written as original data after compression
because of no gain would not be an exception.

Thanks,


On Wed, Oct 13, 2021 at 7:17 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/10/12 0:02, Daeho Jeong wrote:
> >>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> >>> index c1bf9ad4c220..9b663eaf4805 100644
> >>> --- a/fs/f2fs/compress.c
> >>> +++ b/fs/f2fs/compress.c
> >>> @@ -1530,6 +1530,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
> >>>        if (cluster_may_compress(cc)) {
> >>>                err = f2fs_compress_pages(cc);
> >>>                if (err == -EAGAIN) {
> >>> +                     add_compr_block_stat(cc->inode, cc->cluster_size);
> >>
> >> Shouldn't we relocate this after 'write' label?
> >>
> >> One more concern, it looks we've changed what compr_block stat indicated,
> >> literally, the block we account should be compressed..., how about accounting
> >> it by introducing .presist_blocks, used_blocks or occupied_blocks.... thoughts?
> >>
> >
> > What I wanted to add here is just one case in which compression was
> > tried, but couldn't save any block, so gave up.
> > If we put this below the "write" label, we will count blocks, even if
> > the file is turned off for compression in "user-controlled
> > compression" mode.
> > Like the commit comment says, I want to estimate the overall compression rate.
> > But, if we include every other compression disabled condition, it
> > won't work like that.
>
> Got it, thanks for the explanation.
>
> Any thoughts about renaming compr_block? since some blocks accounted in
> .compr_block weren't compressed blocks.
>
> Thanks,
>
> >
> > Thanks,
> >
