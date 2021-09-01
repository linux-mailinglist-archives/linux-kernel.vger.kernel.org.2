Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BE23FE170
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347074AbhIARvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347522AbhIARvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630518607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AOn7fSZJaIGeWUiIESF3Y7phWVytJU/xylBpJF5XsWA=;
        b=TGnqTOC34uHWLR9MLa6TVgPjFOK1ME/LYtLFuZkdBCpasFm/QiQkS9Nvvi8BKf1sqOsh+P
        XrcirCsd5v0Qv+QcaW9pEaF2v19KtrsfnxR3RCgqVnW5xXiJD+sZkLd8/xTBpHd6CnKgqs
        5kMhG0vD/o+srX3xKXWEmt3X728YW0M=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-rMwFWYAHM1-f4S3-Sr45ig-1; Wed, 01 Sep 2021 13:50:06 -0400
X-MC-Unique: rMwFWYAHM1-f4S3-Sr45ig-1
Received: by mail-lf1-f70.google.com with SMTP id bi21-20020a0565120e9500b003df0c58083fso106857lfb.16
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AOn7fSZJaIGeWUiIESF3Y7phWVytJU/xylBpJF5XsWA=;
        b=GIVq6UJLBRccU9wxaVEte7oWw3De+ZjIr99wmKe4j3BNUBqHRxrGg63f2dLdmSCWMy
         DECCCdGfsNnjn5rXDYa5BiFSi3ObB1iBfRALhxKjQGNYqo2sa4sTs4S3UItwoVTGkhF6
         30JzfXM2Y9EkImmcCypRE1B4ZvrKAzY1D45HvgfOF9n8fcXzFmhZpImn1ngZJ04/bk9d
         4FQDnFCpP2kiLYHZqUMQu8AKYLGDjdt7t98fsdLOLYAPbqa7fEXZyMNct0LGmLTw/Dqd
         BD2Xt4/nCaOQm3thXmMuKpTjY3HbDgPp+S+JYISKoagwFXKyWN0OyYVHn/znexIFbLfN
         GrMw==
X-Gm-Message-State: AOAM531g/kL/TyKcT+sQWheqcVIojVkWXmYkniSPFrAAZhHwELAa/NgV
        6pY4sgBz9ImMCSvIgEkaRemIWKywnLVAEyjpFT4X4rXgLMBINdWi8HyKSGeFwwdTMsgyD3N84mH
        ruNpHokIYOu+Njvp52/dRYGnTcfUilET1aitEtnOc
X-Received: by 2002:a05:6512:128b:: with SMTP id u11mr497506lfs.384.1630518604930;
        Wed, 01 Sep 2021 10:50:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEDNBVG4gILtj0UYj77EqEvvd8q6fLfcY7Frsta/WGEY0WxRYqF0jJY35AtfStIVSBSdqSz9M5rI0y4po0/80=
X-Received: by 2002:a05:6512:128b:: with SMTP id u11mr497486lfs.384.1630518604722;
 Wed, 01 Sep 2021 10:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210824152423.300346181@fuller.cnet> <20210824152646.706875395@fuller.cnet>
 <CAFki+Lnso5j+cbDsd74+YM+-sT-zTYuymyJLY2Sw1ho3SHW74Q@mail.gmail.com> <20210901173401.GB48995@fuller.cnet>
In-Reply-To: <20210901173401.GB48995@fuller.cnet>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Wed, 1 Sep 2021 13:49:53 -0400
Message-ID: <CAFki+L=wYqKZon8TRdMhOHfS3goh7yHXQFDb7RXM=iOJeZJBPw@mail.gmail.com>
Subject: Re: [patch V3 2/8] add prctl task isolation prctl docs and samples
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 1:38 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Wed, Sep 01, 2021 at 09:11:56AM -0400, Nitesh Lal wrote:
> > On Tue, Aug 24, 2021 at 11:42 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > >
> > > Add documentation and userspace sample code for prctl
> > > task isolation interface.
> > >
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > >
> > > ---
> > >  Documentation/userspace-api/task_isolation.rst |  211 +++++++++++++++++++++++++
> > >  samples/Kconfig                                |    7
> > >  samples/Makefile                               |    1
> > >  samples/task_isolation/Makefile                |    9 +
> > >  samples/task_isolation/task_isol.c             |   83 +++++++++
> > >  samples/task_isolation/task_isol.h             |    9 +
> > >  samples/task_isolation/task_isol_userloop.c    |   56 ++++++
> > >  7 files changed, 376 insertions(+)
> >
> > [...]
> >
> > > +       if (ret) {
> > > +               perror("mlock");
> > > +               return EXIT_FAILURE;
> > > +       }
> > > +
> > > +       ret = task_isol_setup();
> > > +       if (ret)
> > > +               return EXIT_FAILURE;
> >
> > The above check condition should be 'ret == -1', isn't it?
>
> task_isol_setup returns 0 on success, so fail to see the point
> of testing for ret == -1 rather than ret != 0 ?
>

Hmm, could be something that I misinterpreted.
I will double-check.

-- 
Thanks
Nitesh

