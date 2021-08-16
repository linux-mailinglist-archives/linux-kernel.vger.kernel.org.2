Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB78F3ECFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhHPHsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhHPHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:48:35 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327AEC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:48:04 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t16so13515870qta.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiQip1UpArazb14cl5xVBxcMGcN52lxGu1QlzdqBSTw=;
        b=ukoe2YDFXvpYJXIYmRcqKDnlzGOh224ZCxRh4fUHog/FHOewK8Fn+ZTHJml9XGc76i
         /vwbv07ryTiuZAyNpvqfR6C5MEG1DzneQ9CGFkWj0YbafTG060Z7DfEyMQoW/TiSa9OY
         zJ+D6px5+SA6+SHlxeHWY9gsuZPT7jvZ9ju6B0DozT3EnSz4B2dEDZbm8PhvXlHUvfEz
         GjTA5M50cZOKUAqsKtPnHCMGOp1WfnKOz8XaqgWWRwaAABsI830vAGO9ylMk3VytYV9B
         M2hcZ7GsYZxFBE1Y3otF8SRqLIEjPHfaw9YhJNeA33nwyupwMq86/aKj6nZJV7DPR9+j
         dFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiQip1UpArazb14cl5xVBxcMGcN52lxGu1QlzdqBSTw=;
        b=DCh6sHxyYrBIO+Qngw4U4J2/pSF3AvEuwGHfoF9YctZeJbomDwNmEk8X+DIBpN8sX9
         /IA2dHVrEBLjKD1iq9kmTjvi1EIX5FXP9HvBnlOMuyJzo/AG7gSjGm75Y5TeZzDhLaLd
         jQQKWHZdqTkRRSeB0tgdLCRZN9K98KCbsfy4vAOucYlyCFq5Oh9hTvzto9sftjMwcVbQ
         SKlm0zRlframbWQC13YJB74b09F0AmKNFWlxuBfC3o4oou7/gihV5Pu3R9JNIKDuPeCN
         OtfANgmbJ+G649/V2WSIIdPkJzv2S90SdMF7IigrHoB+OmqK6Lj1k9edjB5laJOL8n/p
         gM3w==
X-Gm-Message-State: AOAM532GfKXSjamaVwpR0X21nR+A3dxh2jKSWgThQECVWt4ebQCsnHhk
        JXVYM0Rko2G/ZRYLJIPpd5F9J1iC4pXAWW1rzqeoafT9C9LbHy6Y
X-Google-Smtp-Source: ABdhPJwpyJq/YM1ZgbZGYRA98U7ymt62vV/J0oojbzep9dlBmLWdWLG6VTHWwc2SmU1UKFQdp9vBIbce8eJxlUWu8DE=
X-Received: by 2002:a05:622a:289:: with SMTP id z9mr12390971qtw.67.1629100083148;
 Mon, 16 Aug 2021 00:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fbad4305c982f836@google.com> <20210814150652.c61e3c09a58222260fa2d02d@linux-foundation.org>
 <YRhQwOvZNBRZqk9O@casper.infradead.org> <5810d827-c050-52b6-1b98-8deb99ceda9c@oracle.com>
In-Reply-To: <5810d827-c050-52b6-1b98-8deb99ceda9c@oracle.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 16 Aug 2021 09:47:51 +0200
Message-ID: <CACT4Y+aEo5qWg0CmjUQsi3UXwmiCwmK93XUnt+DfRUtD2YLTmg@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in alloc_huge_page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2021 at 20:17, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 8/14/21 4:24 PM, Matthew Wilcox wrote:
> > On Sat, Aug 14, 2021 at 03:06:52PM -0700, Andrew Morton wrote:
> >> On Sat, 14 Aug 2021 04:07:23 -0700 syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com> wrote:
> >>> HEAD commit:    92d00774360d Add linux-next specific files for 20210810
> >>> RIP: 0010:__list_add include/linux/list.h:71 [inline]
> >>> RIP: 0010:list_add include/linux/list.h:86 [inline]
> >>> RIP: 0010:alloc_huge_page+0xdcb/0x11b0 mm/hugetlb.c:2821
> >>
> >> That appears to be
> >>
> >>              list_add(&page->lru, &h->hugepage_activelist);
> >>
> >> I'm suspecting Mike's surplus page changes?
> >
> > Is this not the same as
> > https://lore.kernel.org/linux-mm/846c4502-3332-0d25-87f5-cb3b71afc38f@quicinc.com/
> > which is already patched in your tree?
>
> Yes, I believe it is the same, and already fixed.  RCX: fffffffffffffffc
> makes me 99.9% confident.

Let's tell syzbot about the fix:

#syz fix:
mm/hugetlb: Initialize page to NULL in alloc_buddy_huge_page_with_mpol()
