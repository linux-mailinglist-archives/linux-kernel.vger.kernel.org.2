Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA533700EE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhD3TDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhD3TD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:03:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E1DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:02:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h36so57465179lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v06I/GWg3EwPlU1YR85dzjFdybBe49tFpVbSc13sT5g=;
        b=Galr3BSlX33rXt2K8EQHGRcZrM5ViYGKWBw38IzYWCRrSddOBancyNAJf2LZtMxP3T
         bF0ymVMvrFneKi7IRMGXFgsKK1yQqrbrajNH0kNjN/vFDn+oQe8qOwe7lgYDibKEbxCT
         BjkEdBDtoriE8DaKOtpJmKPGutBN74277b2es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v06I/GWg3EwPlU1YR85dzjFdybBe49tFpVbSc13sT5g=;
        b=rnhuFzInetbtpOQFD7vxKtfhboa0Kf9J7/nyr6G9n1eEh1XXm6Azl7nwLA7Fu0YAt2
         R3W7i/cmjfuIZlsLCKnctPjW7m7QQe8je0bg93Z4eRpWo7oU6lg+bJQ4MHjbRdwQqIzY
         ix3M7VPfKPST9XlGHApQFEQZtPSFzVibABZl/+tMsg3zQJTFTjw5CaEEjI9FQxhG/z/2
         Z6Y+RxKt/nOh99gZgSp+9ZdQy5NCxWXyAIV887ACx8nu4pq/A+O5MmgihYO+nljqL7/n
         JWPQjbBQPCRCUXm9WwTRNhVIZ3O6iKXEcGf851chhMl/WnHJhuAZd2pGoj6wyBboRG3L
         xqvg==
X-Gm-Message-State: AOAM531H/Bl+GSh8GGOPxnoMKzE6hu2iyJoU0stouTdCoh3Hl0LWdy3I
        sQ8TIja9q0EfvMHcOnG8kIYh9lIyGwEbsoKJ
X-Google-Smtp-Source: ABdhPJzLhQpAU0S4h9UK9zrfSi243Bzw/bpXRdiB71JNNwxNBMFaftVbreqUQY9DsxejEg3AHOFQUw==
X-Received: by 2002:a05:6512:2190:: with SMTP id b16mr4272586lft.122.1619809356935;
        Fri, 30 Apr 2021 12:02:36 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m20sm356091lfu.206.2021.04.30.12.02.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 12:02:35 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v6so5278856ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:02:35 -0700 (PDT)
X-Received: by 2002:a2e:989a:: with SMTP id b26mr4719544ljj.465.1619809355301;
 Fri, 30 Apr 2021 12:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210427025805.GD3122264@magnolia> <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
 <20210427195727.GA9661@lst.de> <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
 <20210428061706.GC5084@lst.de> <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
 <20210428064110.GA5883@lst.de> <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
 <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk> <CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com>
 <26d06c27-4778-bf75-e39a-3b02cd22d0e3@rasmusvillemoes.dk> <CAHk-=whJmDjTLYLeF=Ax31vTOq4PHXKo6JUqm1mQNGZdy-6=3Q@mail.gmail.com>
 <m135v7y5c5.fsf@fess.ebiederm.org>
In-Reply-To: <m135v7y5c5.fsf@fess.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Apr 2021 12:02:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjTongV9B_2gSaY9xVhw9oK8Bc+uOara-CLuSsk7fBpQ@mail.gmail.com>
Message-ID: <CAHk-=wgjTongV9B_2gSaY9xVhw9oK8Bc+uOara-CLuSsk7fBpQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, Jia He <justin.he@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 11:50 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> A printk specific variant could easily be modified to always restart or
> to simply ignore renames and changes to the mount tree.

Exactly. I think a "ignore renames and mount tree changes" version for
printk would be the right thing.

Yeah, you can in theory get inconsistent results, but everything is
RCU-protected, so you'd get the same kind of "its' kind of valid, but
in race situations you might get a mix of two components" that '%pd'
gives for a dentry case.

That would allow people to use '%pD' and get reasonable results,
without having them actually interact with locks (that may or may not
be held by the thread trying to print debug messages).

           Linus
