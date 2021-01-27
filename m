Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B66D30640B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhA0Tap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhA0Taf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:30:35 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:29:55 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id n7so3383064oic.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlYVfDYZNtUxR3D2jc9HgqXSl2liyEmxOtLZdP+BkB0=;
        b=gCsqjkEGiRlYvjOVIzeYFkvQ76TbgDtPT7OmwzckLWXJP2RuuqJicKWLfKOtQior4c
         jb8kgyhkpwcrXkoJvF6WsbIeslWLYmNLEby+lVNLKa5KBKSGw6CVk6Xj40xewewVdzbS
         6/JyonA1byvMbnslWp/L2Rm+YdoPMrka2xk8ZXWP6kC6289PuZrLeJEheJ7kHzER2df4
         RPBwohwE3ksr6ijyHBfcxGmS8YoLvpilURFwh+ExJmlPZiumvAueHOZisrz2/GV7RtHY
         N8dXwFuX6c+4jkGUA4vBfNzAVUCGE3yHtvdvy+mTfCGeP4Mk6pCtv3asx32QPViIcEyb
         mX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlYVfDYZNtUxR3D2jc9HgqXSl2liyEmxOtLZdP+BkB0=;
        b=bgiZN6r0hyvss8G7o++9SC3/tiMpzCzJDtaCFs+bZXMWkO6AW/mbZDen4c8y1P5LZc
         FC9CN5jEesVeqX7Ip4AA5yLbldEcWPkYML68tQzVITostfRfpxNAFpLwo1GYK9YOkMja
         Gm8L2aaQkLT/GWxsfIIlCLb8Y2DbDSNMSmMjumv5I1ViLBEVzPTwZIgwX2XrKfh3X6j3
         bbN0yuDCGEZTgEKZ5qRmACrtuMamRmlGBOHV0P9CpG23uPyADm27BfJRJctStu0Z/6FF
         Qdq+zow+JLEMUQotJOP+8yJ/hvua62r9MXNLgiZyRFQY+ad5ychIeQEfgFGaYHP4ipYt
         WQSQ==
X-Gm-Message-State: AOAM532n9hhsjKSqA0VjOuaunNPPsG2Lj0EihTjvUp2KLP6k/NNlgtnj
        2qXlZwqM2qlwFlHghUL/CEhrolR/i4eYjQ8I4i4=
X-Google-Smtp-Source: ABdhPJz+UCetS0Gknm87yOCnXVfwxM5/mvnp7iCsFAZyQ5SYAp7ptbGvUrkt9YDW1e+4dBThHm59laJtYx+wBc60XjY=
X-Received: by 2002:aca:5e03:: with SMTP id s3mr4297258oib.125.1611775795123;
 Wed, 27 Jan 2021 11:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20190126200005.GB27513@amd> <12171.1548557813@turing-police.cc.vt.edu>
 <20190127141556.GB9565@techsingularity.net> <20190127160027.GA9340@amd>
 <13417.1548624994@turing-police.cc.vt.edu> <20190128091627.GA27972@quack2.suse.cz>
 <14875.1548810399@turing-police.cc.vt.edu> <9618.1548822577@turing-police.cc.vt.edu>
 <20190130104020.GE9565@techsingularity.net> <20210125195438.c8d0e7980da0c2931d4f3056@gmail.com>
 <20210126091737.GA3592@techsingularity.net>
In-Reply-To: <20210126091737.GA3592@techsingularity.net>
From:   Tibor Bana <bana.tibor@gmail.com>
Date:   Wed, 27 Jan 2021 20:29:43 +0100
Message-ID: <CAKLhPeEctZ3P0O+2a7OxMz0QK69Sz2k54xzcLJFOMPvLmNT2Ug@mail.gmail.com>
Subject: Re: [regression -next0117] What is kcompactd and why is he eating
 100% of my cpu?
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     valdis.kletnieks@vt.edu, Jan Kara <jack@suse.cz>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry for the delay. I had time to do a full system upgrade yesterday
evening and fortunately Archlinux already ships 5.10.10, today I used
my computer as usual to test it. I haven't experienced the symptoms,
but since I disabled transparent huge pages it showed up sporadically.
If I face it again I will let you know.

On Tue, Jan 26, 2021 at 10:17 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Jan 25, 2021 at 07:54:38PM +0100, Tibor Bana wrote:
> > Greetings!
> >
> > I don't know if it still actual, but I am strugling with this problem right now and searching the internet for solutions.
> > I read the thread and saw that you are strugling to reproduce the problem, and I can reproduce it almost every day.
> >
> > - Install vmware player, and a linux guest.
> > - Configure the virtual machine to have a good amount of memory and cpu
> > - run resource intensive tasks on the guest
> > - when the host used up almost it's all memory and start to reuse caches kcompactd will kick in.
> >
> > As I know the problem is related to transparent huge pages, but I tried to disable it.
> > Today I saw the problem again and kcompactd shown an interesting status in top. It hasn't used any memory, all zeroes but it used up one core completely.
> >
> > My machine is a core-i7 with 4 physical cores and hyper threading and 24GB Memory
> > 5.9.11-arch2-1 #1 SMP PREEMPT Sat, 28 Nov 2020 02:07:22 +0000 x86_64 GNU/Linux
> >
> > Hope this can help, to point out the problem.
> >
>
> Is 5.10.10 affected because it included two patches related to halting
> compaction that are relevant.
>
> d20bdd571ee5c9966191568527ecdb1bd4b52368 mm/compaction: stop isolation if too many pages are isolated and we have pages to migrate
> 38935861d85a4d9a353d1dd5a156c97700e2765d mm/compaction: count pages and stop correctly during page isolation
>
> --
> Mel Gorman
> SUSE Labs
