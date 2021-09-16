Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D964A40E968
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbhIPRx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357124AbhIPRv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:51:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C623C09B11E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:25:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i7so20638158lfr.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MrqPwjGprB21xOrKUeLYED8somKhoDI07GyEYlbbo4=;
        b=giK/CoBDhVKoZODX7QaMWenK7M0Ef7/VMrMC+JpDOGq7hzKKMIt4+9kYx+W6zhvGu1
         ySoWjCQyGMBQPbPsmJ+MdLSpu5kCyHc8//rajgrLTwILPMxsnm4mLr03RxEorH1wc86u
         czJJF+ua9fGukgNanz1FEl1kMG76Vh0A/SWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MrqPwjGprB21xOrKUeLYED8somKhoDI07GyEYlbbo4=;
        b=YZ3zStiijryHcoBDGkkiTzQtkJMsk+SeLhOXEXT7eWDVegAg5KxSS4sTpGI3DqialL
         oBm6xW5BNzBt9k6oXexVOF2NjWYMpuD8QTD7woO/zmuq5XjpDUVo4RxAs34WdbhB3Hho
         ZokBF2cN6533x89lQhZ+UYJJeUVsYJSwgXP9Q+h4emlWXh22B8jJangj0WqDl33X3oVu
         Fpnu4HAp76Ua9CJ4GbtmvCsHTVTM+XGaqfW5ZIpacN5xhvxjdewKP61A/C+IhrpHyo+X
         nUnxReIRm7HtjVKo83ZWqZ60LdF5zGumOLCoNI+PgJnKSKjqgtcpmxr9zHxdc43DQpA6
         o0KA==
X-Gm-Message-State: AOAM533GG07/hVx3Z/bWlKOnLSwvW5nbMFK5xpdrrAXmINdWsikcdUVn
        Y15u4niE1GbFJem+iQmRMxjh12/jgNP7dBtK
X-Google-Smtp-Source: ABdhPJxx/gCIGjbNreH1B0V8MDqeOfNUAqOR/8N5b980F7BQsF9Qi6d8tR5T8+AWltjjN6/HX9sTcw==
X-Received: by 2002:a2e:804c:: with SMTP id p12mr5649765ljg.118.1631809556233;
        Thu, 16 Sep 2021 09:25:56 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d15sm329358lfn.220.2021.09.16.09.25.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 09:25:55 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id i7so20637627lfr.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:25:54 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr5452535ljg.31.1631809554490;
 Thu, 16 Sep 2021 09:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net> <CAHk-=whSkMh9mc7+OSBZZvpoEEJmS6qY7kX3qixEXTLKGc=wgw@mail.gmail.com>
 <CAHk-=wjynK7SSgTOvW7tfpFZZ0pzo67BsOsqtVHYtvju8F_bng@mail.gmail.com> <5497691.DvuYhMxLoT@alarsen.net>
In-Reply-To: <5497691.DvuYhMxLoT@alarsen.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Sep 2021 09:25:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh84ks6FN2fBWrGZNKNhOmTZL-r5xZG7gYZ==jESG2GgA@mail.gmail.com>
Message-ID: <CAHk-=wh84ks6FN2fBWrGZNKNhOmTZL-r5xZG7gYZ==jESG2GgA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Anders Larsen <al@alarsen.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 12:02 AM Anders Larsen <al@alarsen.net> wrote:
>
> On Wednesday, 2021-09-15 23:19 Linus Torvalds wrote:
> >
> > But hey, maybe it just works so well for the very specialized user base ...
>
> it's actually the latter (although I guess the user base is shrinking)

Hey, so if it's actively used, maybe you can answer a question or two
that I have just because I looked at the code..

In particular, the inode number calculation is odd. Is there a reason
for the "-1"? Because iboth the link case and the direct inode case
have it, but t's a _different_ "-1":

For the "inode_entry", it does

                ino = blknum * QNX4_INODES_PER_BLOCK + ix - 1;

but it's worth noting that "ix" is zero-based (index within the
block), so this kind of oddly removes one from a zero-based thing, and
the 'ino' for the very first entry ends up being -1.

Of course, it's possible that the first entry is always empty, but it
does seem a bit odd.

For the "link_info" case, it does

            ino = ( le32_to_cpu(de->link.dl_inode_blk) - 1 ) *
                    QNX4_INODES_PER_BLOCK +
                    de->link.dl_inode_ndx;

so now it takes the _block_ index, and does that "-1" on it, and then
multiplies it by the "entries per block" number, and adds the index.

So now if both are zero, the inode number is -8, not -1.

But all of this matches what the *lookup* code does. It's very odd, though.

But to make it stranger, then in "qnx4_iget()", the calculations all
makes sense. There it just does "take the inode number, and look up
block and index into the block using it".

Very strange and confusing. Because it means that iget() seems to look
up a *different* inode entry than "lookup" and "readdir" actually look
at.

I must be missing something. I obviously didn't touch any of this
logic, I was just doing the "make the type system clearer for the
compiler".

Also, I have to say, since I was looking at compiler output, the
calculations in readdir() are made much worse by the fact that the
dir->pos is a "loff_t". That's signed. And then you use "%" to get the
index within a block. Using '%' instead of bitops is fairly
equivalent, but only for

 (a) unsigned types

 (b) when the divisor is a compile-time power-of-2

In the qnx4 case, (b) is true, but (a) is not.

Not a big deal. But usually, I tell people to avoid '% ENTRIES',
because it really has very different behavior from '& MASK' for signed
numbers.

                  Linus
