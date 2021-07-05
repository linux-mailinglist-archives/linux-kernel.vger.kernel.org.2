Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636483BBC62
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhGELuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGELuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:50:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADB0C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 04:47:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f20so12046346qtk.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2anXc9o1J5CUj8jZ7vD+flFV6tAYlW07LvmjqUmo+tI=;
        b=oxBNCd9Z7tczjNhggQLh1dJeHudhfX2gRTQ8wDfrhGLFD0rWLTz17tCZHuyEXiaOKY
         mV/71KSXIKh0Ix007SELqjmbtfIE6GumGUOFFS4rITFAx2a1l+2afvUiK0mK10flTjla
         tHvrupXy90S/hoD/eaatukQegq06J0gcsEaLn+C6PcI6qW4gebM13Z5b3zsX8HWZSr+y
         Fem1uNfSMB/ftuT3uGabU+vw2I+jE2to+2tVq6REqGfzUCaFJjut7w2pMLGGYES7ElP9
         XXRfg2PwFy2BOFmkKYjb394ND5hZV70MiX+bPzydnDGQ3s9pSxczREa4AA0tXwgHY8kx
         KxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2anXc9o1J5CUj8jZ7vD+flFV6tAYlW07LvmjqUmo+tI=;
        b=R9/8lG2zjg4bSGd+ziiRdEdSefB8jcSrtp5UNA/BJBaAKpDZh9womEIYVBKGfLJWxn
         73zu7/t3Kn5swG7gNdg7+bEqdJP5cpT9M5HWRO9Dpi3KMXNdXWeAOadYItV7DgpJzONf
         BrXxf8r8O/iKNHfksGJkWVE4D04fQJCcO1djewiFTHMWSPxeDLGVRbKSdC6gMPQOGVfF
         z5jJ0JIQRGXakUkLoKX8iQcVJ5ZQifZ6ZL4mffZQQfHOPlXRsDI40qhrCaPTv2KLffYE
         +J8cFkR2i2ACZ5Z3H1hsnx05CSck2FDDanvXULu6bxbZWYz5N3qzqKYO+8Iadx8h8epu
         wBiA==
X-Gm-Message-State: AOAM5304ctFX9uU0AUJvcqRY6qKuk7lLZOiyKa6vckTB2GfuKfXCi4ot
        VymhPZNywnINN5OCK8TbfiNL4nPnhFV+d3MGXTCP+A==
X-Google-Smtp-Source: ABdhPJyHoyhfKlNbJ2OsQycTXwCVU8GNncHeEg3OytdDPbIjB4lfgNxZkC9kiRwZKQa/qKaVC/xOeHXux5M2duVYUe4=
X-Received: by 2002:ac8:60ca:: with SMTP id i10mr9991952qtm.43.1625485662468;
 Mon, 05 Jul 2021 04:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bfb6cf05c631db0b@google.com> <20210703101243.45cbf143@gmail.com>
 <CACT4Y+Yk5v3=2V_t77RSqACNYQb6PmDM0Mst6N1QEgz9CdYrqw@mail.gmail.com> <20210705143652.56b3d68b@gmail.com>
In-Reply-To: <20210705143652.56b3d68b@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 5 Jul 2021 13:47:30 +0200
Message-ID: <CACT4Y+aeiQ9=p6esuAseErekJnLzxFL1eG7qpWehZHUfb8UoNw@mail.gmail.com>
Subject: Re: [syzbot] memory leak in kvm_dev_ioctl
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     syzbot <syzbot+c87d2efb740931ec76c7@syzkaller.appspotmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 1:36 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On Mon, 5 Jul 2021 07:54:59 +0200
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Sat, Jul 3, 2021 at 9:12 AM Pavel Skripkin <paskripkin@gmail.com>
> > wrote:
> > >
> > > On Fri, 02 Jul 2021 23:05:26 -0700
> > > syzbot <syzbot+c87d2efb740931ec76c7@syzkaller.appspotmail.com>
> > > wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    e058a84b Merge tag 'drm-next-2021-07-01' of
> > > > git://anongit... git tree:       upstream
> > > > console output:
> > > > https://syzkaller.appspot.com/x/log.txt?x=171fbbdc300000 kernel
> > > > config:
> > > > https://syzkaller.appspot.com/x/.config?x=8c46abb9076f44dc
> > > > dashboard link:
> > > > https://syzkaller.appspot.com/bug?extid=c87d2efb740931ec76c7 syz
> > > > repro: https://syzkaller.appspot.com/x/repro.syz?x=119d1efc300000
> > > > C reproducer:
> > > > https://syzkaller.appspot.com/x/repro.c?x=16c58c28300000
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to
> > > > the commit: Reported-by:
> > > > syzbot+c87d2efb740931ec76c7@syzkaller.appspotmail.com
> > > >
> > >
> > > Corresponding fix was sent about 2 days ago
> > > https://patchwork.kernel.org/project/kvm/patch/20210701195500.27097-1-paskripkin@gmail.com/
> >
> > Hi Pavel,
> >
> > Thanks for checking. Let's tell syzbot about the fix:
> >
> > #syz fix: kvm: debugfs: fix memory leak in kvm_create_vm_debugfs
>
>
> Hi, Dmitry!
>
> Sorry for stupid question :)
>
> I don't see, that my patch was applied, so syzbot will save the patch
> name and will test it after it will be applied? I thought about
> sending `syz fix` command, but I was sure that syzbot takes only
> accepted patches.

Hi Pavel,

Please see if http://bit.do/syzbot#communication-with-syzbot answers
your questions.
