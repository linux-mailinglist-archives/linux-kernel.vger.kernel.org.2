Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1F9389B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 04:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhETCec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 22:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhETCeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 22:34:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26461C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 19:29:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w12so9830860edx.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 19:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMvb0n4LbT0TuR0D9FQ2CMeCBbUPAKGZCz3Dr44PaW0=;
        b=Txx4en7He1hssPu2O0K85osEJQZOh7gSdD0fTc0HK9bfCb4tHcSPL5Vzmbo+HxZeG7
         URkI9280Aidu0068F+2W+uFM9mZJXhAmzADK/uBcrE4inPGAc6xCDE//RUM4fSma2JL2
         TRZ3uDScXtitVVNjSxFcVatkWzABu9gj6SfwwD2f67V+Dm8GZUa+l5YckeU5nhyJ4LDW
         rYQftnJ6n7XnGyTKVTt1+fpEwwiijkrkn6b7tJMrxKLyhKQyO3zTkFDHL+S0P2J00drS
         3mztBgaPdlwObdd5gZ9XoIDvAiDsAhG5whNcEk1SVLmzj+sbrBkIA3ERcR9ut7kG5eBC
         aNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMvb0n4LbT0TuR0D9FQ2CMeCBbUPAKGZCz3Dr44PaW0=;
        b=Qm/77nBe82LfSYkyXlrQ7X27+H/sQ+1GRJNqHSolULT9TgHt06j6VUciMDUe295El+
         YXNRmMujkVEJSgUOa9C4cV250xZBHr0XfS0xr6+PMHPiA+7pGi1cbAkkNyOwLsR5r99Y
         /fg6DoH+Zc2gKhWEyvty93+YK2pauX+TiyGiSAWHAiuvW2zWCm1EPi3mt92W1MfurKmI
         VgxYONFuTyIB4fkKpNr6781SUr1eUxY+v9K/iD8jUcMt9vOjZ37Qyu3Nd+dlAHR4eykg
         iOssO3nxJ0SazT/EaoIfeXpvkUjh/oiy6nAaB/nMzlBpG8rQAX6nIT6jCOGQIzluEESb
         tTmw==
X-Gm-Message-State: AOAM530s7GyroBG7iH07Nr8NSoz88qcVAhG4VC0Vu+dVfh7OTWHkDSf5
        ynSqeG26dWYKi2bv9Uvypd5iqniRBfiqUvgNVCOb
X-Google-Smtp-Source: ABdhPJyoLkr8GyC3B4QaWLzLx+0i5610F7svY2rfiE3HwXPDEKHBBbrmg3LGiwaDCUWU9nCiE/UURZPi4UjfuiE0tBE=
X-Received: by 2002:aa7:de9a:: with SMTP id j26mr2395605edv.269.1621477796545;
 Wed, 19 May 2021 19:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210519113058.1979817-1-memxor@gmail.com> <20210519113058.1979817-2-memxor@gmail.com>
 <CAHC9VhTBcCJ1TfvB-HbzrByroeqfFE-SF_REik9PDSdqmJbuYA@mail.gmail.com> <20210519230710.k3hzomsr27onevhf@apollo>
In-Reply-To: <20210519230710.k3hzomsr27onevhf@apollo>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 May 2021 22:29:45 -0400
Message-ID: <CAHC9VhSV8Y=kR2NH8AYzZ550DhpXn2ccepq1NO=z34aLC4DhsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: anon_inodes: export anon_inode_getfile_secure helper
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     io-uring@vger.kernel.org, Pavel Emelyanov <xemul@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 7:07 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Wed, May 19, 2021 at 08:52:51PM IST, Paul Moore wrote:
> > On Wed, May 19, 2021 at 7:37 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > This is the non-fd installing analogue of anon_inode_getfd_secure. In
> > > addition to allowing LSMs to attach policy to the distinct inode, this
> > > is also needed for checkpoint restore of an io_uring instance where a
> > > mapped region needs to mapped back to the io_uring fd by CRIU. This is
> > > currently not possible as all anon_inodes share a single inode.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  fs/anon_inodes.c            | 9 +++++++++
> > >  include/linux/anon_inodes.h | 4 ++++
> > >  2 files changed, 13 insertions(+)
> >
> > [NOTE: dropping dancol@google as that email is bouncy]
> >
> > > diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> > > index a280156138ed..37032786b211 100644
> > > --- a/fs/anon_inodes.c
> > > +++ b/fs/anon_inodes.c
> > > @@ -148,6 +148,15 @@ struct file *anon_inode_getfile(const char *name,
> > >  }
> > >  EXPORT_SYMBOL_GPL(anon_inode_getfile);
> >
> > This function should have a comment block at the top similar to
> > anon_inode_getfile(); in fact you can likely copy-n-paste the bulk of
> > it to use as a start.
> >
> > If you don't want to bother respinning, I've got this exact patch
> > (+comments) in my patchset that I'll post later and I'm happy to
> > give/share credit if that is important to you.
> >
>
> That'd be great; no credit is fine :). Please CC me when you post it.

Will do.  I dug out my system which had the patches and I'm working on
forward porting them to v5.13-rc2; if I don't have them cleaned up
enough for posting by Thursday, I'll make sure they are at least RFC
ready by Friday.

-- 
paul moore
www.paul-moore.com
