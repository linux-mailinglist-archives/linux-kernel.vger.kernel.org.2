Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD544096B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbhIMPCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243388AbhIMPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631545209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XExcfJjhYqqFSPxDcdBobpzf/4x6yU+QQaVQ6sYCFc=;
        b=dNwLo3LbSpWgw7yrh79+ZeuXO0TBG3t9CcCQVk4D8D8n8Q2FvbAlJwd05Jj0ofeBrMy5/u
        /E1TMi15NigfXVz9l+i3zhDtU/wTJ4ZCSU/Q85Y5qbNmIkEkzCxHqqIf+3HucR0LRNaUiN
        Woy8pvUsz0ZjI4bq6Z+CBnB11TJeXXg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-bpmaSOHBOFeuHENtDUfqWw-1; Mon, 13 Sep 2021 11:00:02 -0400
X-MC-Unique: bpmaSOHBOFeuHENtDUfqWw-1
Received: by mail-qt1-f199.google.com with SMTP id b15-20020a05622a020f00b0029e28300d94so55420015qtx.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 08:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XExcfJjhYqqFSPxDcdBobpzf/4x6yU+QQaVQ6sYCFc=;
        b=TbU+L+R9f03LRvIL7ejedeMlcfp4elBVgHno86P1+HV0lIrrTWqIN8lxHDStlHBe6J
         8vFw2V/sxINtfdFogDUYsIw7tOIchrsEgNBUt/nhK/bVTKvYBCaayDhpsyD7Vx1PEpDK
         8WNbdC1CL4FO4kauRO6jV5OVtiZ+DkHKXdIEtRal9yd5eJjlEo1nAHYuOvwoPHyhZTZz
         l1SZzv9k789ZJgQm4gb+YvCwxrT74WVARUlyeyWV80hpv/yUORmvy7gKdQa71ze7dGzZ
         1Bhrf20QWFKg8qmQO+YZ1qtXdyOXOx/pykyz/hmiEDfgNXqJhBSy4v7NOWf8qPQPMk2b
         S41g==
X-Gm-Message-State: AOAM533eRjkQ40HjsQWJtZUMHe9Nw738L7H2ezkYdWErnXwydriSpi2X
        qswbT2CyzajeEznyoPkEw/gGwmGNFkELvhR32Q+5q9pUtVMz55Nb+egqnsQrmEk0Kzf5Xjcihrz
        0buNYrG9WR/mnZQ8/du/Hq5Zt0pBvil5gdBH5B9GK
X-Received: by 2002:ac8:4d41:: with SMTP id x1mr9881596qtv.283.1631545202390;
        Mon, 13 Sep 2021 08:00:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIvLA1bOfGt14N8V8eXhYeDcrI9zojosD5e6UEzOrU113k+/xBMMYsIGkeewyg03T/DxlYztmC3UkBtmLTxdU=
X-Received: by 2002:ac8:4d41:: with SMTP id x1mr9881572qtv.283.1631545202194;
 Mon, 13 Sep 2021 08:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210912123429.GA25450@xsang-OptiPlex-9020> <YT8HqsXsHFeMdDxS@yuki>
In-Reply-To: <YT8HqsXsHFeMdDxS@yuki>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 13 Sep 2021 16:59:51 +0200
Message-ID: <CAOssrKdQ0XWqk1nbpRjRAO7E+t5+7qzXm1mkJPObkzsQrbAoKg@mail.gmail.com>
Subject: Re: [LTP] [mm/page] ab19939a6a: ltp.msync04.fail
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Chi Wu <wuchi.zero@gmail.com>, Jan Kara <jack@suse.cz>,
        lkp@intel.com, lkp@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 10:19 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: ab19939a6a5010cba4e9cb04dd8bee03c72edcbd ("mm/page-writeback: Fix performance when BDI's share of ratio is 0.")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> >
> > in testcase: ltp
> > version: ltp-x86_64-14c1f76-1_20210907
> > with following parameters:
> >
> >       disk: 1HDD
> >       fs: xfs
> >       test: syscalls-03
> >       ucode: 0xe2
> >
> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > test-url: http://linux-test-project.github.io/
>
> The msync04 test formats a device with a diffrent filesystems, for each
> filesystem it maps a file, writes to the mapped page and the checks a
> dirty bit in /proc/kpageflags before and after msync() on that page.
>
> This seems to be broken after this patch for ntfs over FUSE and it looks
> like the page does not have a dirty bit set right after it has been
> written to.
>
> Also I guess that we should increase the number of the pages we dirty or
> attempt to retry since a single page may be flushed to the storage if we
> are unlucky and the process is preempted between the write and the
> initial check for the dirty bit.

Weird.  Does this reproduce 100% of the time?  If not, then I guess
it's a race and we can ignore this report (or improve the test to make
it less likely to trigger).

Thanks,
Miklos

