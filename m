Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFAE3E85D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhHJWBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhHJWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:01:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424FBC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:01:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k2so23186629plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKI2CnsdvFNjqndaNstsi5v6QE1bxINGXNExmIgLnIk=;
        b=RQklxLJzaKm5M8XYcoIxx2s+VbZJEnssRgd9fY2NkyKOraI6mAZUM1sUxYZfk1KDOy
         h0J+BEVcvhbGgefSvBtebh1jgJwBfZifBPxJppyifTFn+V58U1xSvikJhycfXu08UTAp
         hfky0dx4D3LjAWP8lxEbt3sLJEQ8fodBmasFbE+/vNIaakBKdwT9IajR0vc3fJ0iIDem
         Ics4fvJ8RWGrZuVuGqvaQNXCs9enGUASo4+cM1OHo1TmHKtwxfO2iwtkomzWk5AG01o/
         zRUnBmUJogsp55aBu7PIzzTwFhiLXqMxVfi6McoCwfRbJCP8c7vDTZdFotBEI+CC/e2T
         8b7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKI2CnsdvFNjqndaNstsi5v6QE1bxINGXNExmIgLnIk=;
        b=YSN4OnthZnSoWesjhq0Ye6WTDUiUrZItglWfTtDpwBmCAH2LngtjjVsG06Y0xJt2be
         LgmropBwNuvu+8p+kY2YhsSSwHkP2tQmSuwZAk1VQgjt6QHr+f3BxUHRhexSeUfl40i/
         sE6BgiXYLuXjM7yBF7WFtqHaBpLNOrT+zx/0T5R0qoQ9KcdaKJrKR7lXtwEx43GfRhew
         FAL7DjfXgLDgknjBdBK7TFkFRWN50qJq/SNWVYcOa9U7Rozr1ktywLs94tin18ckvX2h
         CrMep0v0rO45LXwA4kCDwa/HiDILqNPJOb6YEu5LAt+RRvYtiWNarmdKuDtE0cCHVdY8
         +RhA==
X-Gm-Message-State: AOAM532a8o3r69GEmB7ekO15rM8mDQS5hWqckHzKdPTLLg7dXtLaKSoa
        Y1KHsPLSMV0F88WWDnkiNjtrtejd17glWZV/uQgcDy8cHjlmpA==
X-Google-Smtp-Source: ABdhPJwKvC0mQoP0/mZH8xtTq4gpHY9Occ3XZipu3kp3Ob0XgH2vxRw/2HxOtR43wGejxmnCZiXgNO1R8MB/4BJxtGs=
X-Received: by 2002:a17:90a:1b0d:: with SMTP id q13mr7125701pjq.217.1628632868528;
 Tue, 10 Aug 2021 15:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210805043503.20252-1-bvanassche@acm.org> <20210805043503.20252-4-bvanassche@acm.org>
 <20210809145953.GB21234@lst.de>
In-Reply-To: <20210809145953.GB21234@lst.de>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Aug 2021 15:00:57 -0700
Message-ID: <CAFd5g46D2KNmsH2qyt_HdWN3peT=HM+We2cgGV5SUzjL2jgSiA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] configfs: Add unit tests
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 7:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > text and binary attribute support. This is how I run these tests:
> >
> > set -e
> > if [ -e .config ]; then
> >     make ARCH=um mrproper
> > fi
> > if [ ! -e .kunit/.kunitconfig ]; then
> >     cat <<EOF >.kunit/.kunitconfig
> > CONFIG_CONFIGFS_FS=y
> > CONFIG_CONFIGFS_KUNIT_TEST=y
> > CONFIG_KUNIT=y
> > CONFIG_PROVE_LOCKING=y
> > CONFIG_SYSFS=y
> > CONFIG_UBSAN=y
> > EOF
> >     cp .kunit/.kunitconfig .kunit/.config
> > fi
> > ./tools/testing/kunit/kunit.py run
>
> This is very useful documentation, but shouldn't it go into a README.kunit
> or similar instead of a commit message?

You could also put this in a .kunitconfig specific to your subsystem
like we did for ext4:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/.kunitconfig

You can then build using this .kunitconfig with something like:

./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig

> > +config CONFIGFS_KUNIT_TEST
> > +     bool "Configfs Kunit test" if !KUNIT_ALL_TESTS
> > +     depends on CONFIGFS_FS && KUNIT=y
> > +     default KUNIT_ALL_TESTS

Cheers!
