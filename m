Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5E93DDC75
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhHBPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhHBPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:30:20 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC75C0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:30:11 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id e4so9707514vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xILzGILWmijJz4hL50F9u9Fw4qso4ZupQveGGxydsiQ=;
        b=oRJlHFxjkREA/3gaJG8FtweNtKYDLMXQJoZdBZ6R5Z5MmuJMTRbLNZ6aZkaKG+6S+F
         PJzkNwWOCrUO0lGPhLbsq/Ou0VGPSgO6KJKij/J8aNhKBI9PRw9xEZ1Y7Wqg/MpNMx6s
         oYRx2UBV0zkp5JW0gSpbFuThh/x2fi4/+Q5j5U+0QI8btj27728IHr2KbXwsLCoEpYgQ
         YARO0hpQ84Q90PRH5tFNf3dcHR0Xm39Qt98sQOVTvjJYON+ne0ZhhbZ4PSWkbho+nbcj
         SF0nHIJDtuCsi8gt02IHOfd7bgcw4mRl5Fg/ReTF10tmOXaQU25KPK/zIIDbzZnlXjhd
         PRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xILzGILWmijJz4hL50F9u9Fw4qso4ZupQveGGxydsiQ=;
        b=dEz5TPxGghdCOoF82/PUXLyr2FvgbGzgK5q6qocA7bid8LYqJnab2tzBgvRNnQ4F2r
         N48p4mkfNrene5u1gTkQN/28U1l3wzV9TbV1xZVQ26PYkn1Ipt6/oWaYvZezl7+gbtu1
         QFFRW2gzPx9XZgRWXQZQi5IpJ8EI3aHZ3l9uP3bqPrcFcCGsz9ZzMx4Ce2Q5SQtnBMs9
         DY87J6VazxVGF53h/ikatVxyjtwUvgHD2FKZOomQg5DleCYvmBKEcOQY2oLm75ONnGNM
         t4v78c2r1KAqjjCzDSUb0GrmHikxNNwy0vbbdBs79SH+c2xtmeXstChgbC+PYelLd3dh
         Yzfg==
X-Gm-Message-State: AOAM533aLLsBGQt7oAdKsOSIUpHYjx/wjQKowc4cPPxbBEXXAtAizLLs
        jR1e2H7UO+KP+du/1oF9vAVYifGpha07dhh2AhZjxA==
X-Google-Smtp-Source: ABdhPJw+TdNUXwlWPq69QLuz1ZOBkAn/1vQFa1mDRcrFy4iev1fIzNDLyDUPh5ZAvA+BI3ucRQHCJi1GgJmYABtyaEs=
X-Received: by 2002:a67:d20f:: with SMTP id y15mr10505358vsi.54.1627918210318;
 Mon, 02 Aug 2021 08:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ6qnrkuckxm6KkoONZZh5Q-H3-CkFiWq627p5OF3GKJ4Q@mail.gmail.com>
 <fc4d994b02f643d480647edc4f2a7a29@intel.com>
In-Reply-To: <fc4d994b02f643d480647edc4f2a7a29@intel.com>
From:   Jue Wang <juew@google.com>
Date:   Mon, 2 Aug 2021 08:29:59 -0700
Message-ID: <CAPcxDJ7_QiM1ZLCUHvqRAAtst8qd_yhhps8V4fE+Fq2YTPMVnw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "dinghui@sangfor.com.cn" <dinghui@sangfor.com.cn>,
        "huangcun@sangfor.com.cn" <huangcun@sangfor.com.cn>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 1:43 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > After cherry picking patch 1 & 2, I saw the following with 2 UC errors injected
> > into the user space buffer passed into write(2), as expected:
> >
> > [  287.994754] Kernel panic - not syncing: Machine checks to different
> > user pages
>
> Interesting.  What are the offsets of the two injected errors in your test (both
> w.r.t. the start of the buffer, and within a page).
They are just random offsets into the first 2 pages of the buffer (4k aligned),
1 error per page. To be precise: 0x440 and 0x1c0 within each page.

>
> > The kernel tested with has its x86/mce and mm/memory-failure aligned with
> > upstream till around 2020/11.
> >
> > Is there any other patch that I have missed to the write syscall etc?
>
> There is a long series of patches from Al Viro to lib/iov_iter.c that are maybe
> also relevent in making the kernel copy from user stop at the first poison
> address in the buffer.
Thanks for the pointer.

Looks like [1],[2] are not yet merged.

Is lib/iov_iter.c the only place the kernel performs a copy from user
and gets multiple
poisons? I suspect not.

For example, lots of kernel accesses to user space memory are from kernel agents
like khugepaged, NUMA auto balancing etc. These paths are not handled by the fix
to lib/iov_iter.c.

I think the fix might have to be made to #MC handler's behavior wrt
the task work.
Send #MC signals and perform memory-failures actions from a task work is fine
for #MCs originated from user space, but not suitable for kernel
accessing poisoned
memory (user space memory). For the latter #MC handler must handle
#MC recovery in the exception context without resorting to task work;
this may be
OK since the recovery action for the later case is minimal: mark PG_hwpoison and
remove the kernel mapping.

1. https://lore.kernel.org/linux-mm/20210326000235.370514-2-tony.luck@intel.com/
2. https://lore.kernel.org/linux-mm/20210326000235.370514-3-tony.luck@intel.com/

>
> -Tony
