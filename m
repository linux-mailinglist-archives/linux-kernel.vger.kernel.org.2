Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22883FE70D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 03:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhIBBPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 21:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhIBBPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 21:15:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19D8C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 18:14:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id s10so433135lfr.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqz6LZdN01vNMwtcP1Z+NsunTL7XUef9xw+Gx1OyCNs=;
        b=N7UDBpi6uLzFIcqYJ6v9E88Lg2ylU4yUaRohLplpblkLd7w9iGOzwRcMveO1xdvQKk
         Ar+hVsUk0v3uMqN3giV/Z9B/66ookTa16ErYKDgXW8o5/sSW3ZR14Vd6WnM6fA1q0pn1
         dnQoqcAy8pExMKy85JEw2hkODrxtjxA1hhmLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqz6LZdN01vNMwtcP1Z+NsunTL7XUef9xw+Gx1OyCNs=;
        b=KX7i+vB18OBIq7qTmECn+5/wbgfuw+4pfLJ9jhNt1jsVM3Ei5qW5oAk5sLKBK2uNFl
         RYkvXSR9l3ag973Hd6NbrlMR/7jLHHrdUu8QfwuVFnojOUkb3mDUZjmzNItuOR/YqkPv
         yA/3+peRwlF8PQWUnnSnHy5itqXzT0A4/VcRSozQPkrpl+485ILCtGNOhKCL5C+8HDLR
         DGXXq2ydAI8uNP1Xlt0aAxrQBmiz2U2d8m20+OKs0gvZwmbGoUq/YlZJW01jnl/JhhB5
         GRaBBQomiu4ueW09jN02np18wmZVbnZotrjTpb5T39FPztMr+zdEux98VBThIjwJN632
         PUlw==
X-Gm-Message-State: AOAM532PLF2wa+Ca5GSwrE4ArTJqQj1o70cMojoesckB9KZyj1CLZdnP
        N3PTCT+hQLn66uOM5hA5tKmSMc4E4e4tFedM
X-Google-Smtp-Source: ABdhPJxul794+nAt7d51VAGEg3id1VvC7obt6SW4akm5idXiZjXnM6nYlx8gRoirdq7Zr5PyClp0Vg==
X-Received: by 2002:ac2:5685:: with SMTP id 5mr529413lfr.466.1630545254825;
        Wed, 01 Sep 2021 18:14:14 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x2sm37893lfu.116.2021.09.01.18.14.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 18:14:13 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s12so566774ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 18:14:12 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr376926ljc.251.1630545252497;
 Wed, 01 Sep 2021 18:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org> <YS+AhXJGsniaHTS4@hsj>
 <YS+NXmDO0yqDEBmD@hsj> <YTATir09urAUTSI+@casper.infradead.org> <CAGsJ_4ySjL9SWaquP4BoWROZ=qPFgyTKnPWuSP_LD08RZB7uzg@mail.gmail.com>
In-Reply-To: <CAGsJ_4ySjL9SWaquP4BoWROZ=qPFgyTKnPWuSP_LD08RZB7uzg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Sep 2021 18:13:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpnaYYAooWWVcAW7ut73t3iyhM3aWuEiY3jt_1kEYU-A@mail.gmail.com>
Message-ID: <CAHk-=wjpnaYYAooWWVcAW7ut73t3iyhM3aWuEiY3jt_1kEYU-A@mail.gmail.com>
Subject: Re: Is it possible to implement the per-node page cache for programs/libraries?
To:     Barry Song <21cnbao@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frank Wang <zwang@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 5:15 PM Barry Song <21cnbao@gmail.com> wrote:
>
> In case we are running mysql on a machine with 128 cores
> (4numa, 32cores in each numa), how will the reflink help the only
> mysql process to leverage its local libc copy?

That's a fundamentally harder problem anyway, and for the foreseeable
future you should expect the answer to that be "Not a way in hell".

Because it's not about "local libc copies" at that point any more,
it's about "a single process only has a single page table".

So a single process will have a particular virtual address mapped to
*one* physical page. And no, it doesn't matter how many threads you
have. What makes them threads - not processes - is that they share the
same VM image.

So the only way you will have local NUMA copies is if you
 (a) run multiple processes
 (b) bind each process to a particular NUMA node
 (c) do something special to then have per-node mappings

That "(c)" is what is up for discussion, whether it be with various
user mode hacks, or the "NUMA COW" thing, or whatever.

But (a) and (b) are basically required.

               Linus
