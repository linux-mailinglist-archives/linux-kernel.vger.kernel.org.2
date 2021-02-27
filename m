Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB44F326A98
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 01:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhB0AB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 19:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhB0AB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 19:01:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9C9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 16:00:46 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d3so16337058lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 16:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYTn2RsRhI2Df4daFJ4TP47tBaYxEFBrTiAP9a7aC0g=;
        b=o6kPKv3wxHpYD7k0rSRibyaVaAgQcF7OL+FgLZX5IjA8o9dsnsMMZTQRZK+6EXxWJC
         uvIgLCy/2HjaZo30sdFqu2ProOkM14RhejEz+IbJLZhfw7/HuPpEdpybozAIDg5jVlBh
         E/hWwYj8syeS8vW3FPsSZUSnbdQ3rnDKGLQwqxYim8+jPVjTVLJVqsz5JIpPxtWncwcV
         RTHTwex6oYezFpoiIrQpPclJS0rfYzXkUWoMpC08RmIb138+XIz93D9ZqEvQt8rpuHsm
         8RA/KfM1IcODGdWZwIAoK2PQSlqayTV2h3aq2KlfyK/8EjHXcGsQPRYWszFHbQ62lOvq
         pm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYTn2RsRhI2Df4daFJ4TP47tBaYxEFBrTiAP9a7aC0g=;
        b=Yd5Rh/Bn4hMP0akUGFrILhurq08W8weNUMjhUiiDXhWNJhC+2VU98NLQ5BfpOHaCL3
         /TiV9/OBZIfcxBXxwqtJOqTb/TnDvJsDE0RHR86PL1LTtef857bq16P8Vvb7R5i0wSQM
         fPkBWbcHCL0uCPVbcphwTkzR50QzotBnLMAsy3WgKMIty5KUrpqcTSYfjrjYS8B7usvY
         H3/e+UdGP8TMCMMPpbdn1Zgnwd1FC4Zgb6GThd4sZMjB2XvvR7nLinTFC41dc1bmlwi2
         oqtmPkerXX3w9V3/gFeXLKgOGSpxqN/kt4RrIsBW9/XOKjO35c7tOgSX+NRgSSpmoGRz
         0zFg==
X-Gm-Message-State: AOAM530KDKqxCqNVYREJEkn7eA4ZjGsaExSaeRnw4mIoWXomdmKkjOZR
        RPaUiI1anSxjBhR1NEC2wzYp8j2cXqy7Ty8yruH4Mw==
X-Google-Smtp-Source: ABdhPJwOLCGXvB6scWEWV0XJGGu89gKZEPooyWEQwZolS/vKBxz5Gv+zx3mcESOVxxhMMU10WmGnMlbyLNlZ41ABbQo=
X-Received: by 2002:a05:6512:942:: with SMTP id u2mr3106548lft.117.1614384044474;
 Fri, 26 Feb 2021 16:00:44 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f1c03b05bc43aadc@google.com> <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
 <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
In-Reply-To: <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 26 Feb 2021 16:00:30 -0800
Message-ID: <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
Subject: Re: possible deadlock in sk_clone_lock
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 3:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Cc: Michal
>
> On 2/26/21 2:44 PM, Shakeel Butt wrote:
> > On Fri, Feb 26, 2021 at 2:09 PM syzbot
> > <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com> wrote:
> <snip>
> >> other info that might help us debug this:
> >>
> >>  Possible interrupt unsafe locking scenario:
> >>
> >>        CPU0                    CPU1
> >>        ----                    ----
> >>   lock(hugetlb_lock);
> >>                                local_irq_disable();
> >>                                lock(slock-AF_INET);
> >>                                lock(hugetlb_lock);
> >>   <Interrupt>
> >>     lock(slock-AF_INET);
> >>
> >>  *** DEADLOCK ***
> >
> > This has been reproduced on 4.19 stable kernel as well [1] and there
> > is a reproducer as well.
> >
> > It seems like sendmsg(MSG_ZEROCOPY) from a buffer backed by hugetlb. I
> > wonder if we just need to make hugetlb_lock softirq-safe.
> >
> > [1] https://syzkaller.appspot.com/bug?extid=6383ce4b0b8ec575ad93
>
> Thanks Shakeel,
>
> Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in non-task
> context") attempted to address this issue.  It uses a work queue to
> acquire hugetlb_lock if the caller is !in_task().
>
> In another recent thread, there was the suggestion to change the
> !in_task to in_atomic.
>
> I need to do some research on the subtle differences between in_task,
> in_atomic, etc.  TBH, I 'thought' !in_task would prevent the issue
> reported here.  But, that obviously is not the case.

I think the freeing is happening in the process context in this report
but it is creating the lock chain from softirq-safe slock to
irq-unsafe hugetlb_lock. So, two solutions I can think of are: (1)
always defer the freeing of hugetlb pages to a work queue or (2) make
hugetlb_lock softirq-safe.
