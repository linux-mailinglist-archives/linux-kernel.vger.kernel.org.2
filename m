Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB345400807
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhICXBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbhICXBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:01:33 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C270EC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 16:00:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a93so1320229ybi.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsvzwFNEnHsJ1uh4maplzk+1wE8dN+TE2VMxmxzZ8dE=;
        b=PBU4sqqsgc91PcPcW74ICTqra+X+Cm9xwQ2IrcYvnj62aQUwZPOKGX2rbHaS/Q+/a9
         B74FbvWF42ssnJGpDSm+1mRq6GhgZNDoQBS8Q4VikE+fKrezUEIbBI/z9HqMxo9LNDWj
         8U316TRqIvkQ0tRPdF0AQFkWwcDaPK7ldE2zKfbN2AjJbkUNdMTVofPLIkpBT9TKtk9G
         EzdqEI3EOa19Ly2sEnC/of46Gbexh3xoz+WF3iDhSxuf+fza0X3NGclxdYZbLlTKs5tm
         f/ahvgIpH7ShIbSzn3JD4oWTBnvO+z56MNSYYRPGyfV5CNsW/zUZVQp/9x08FchffD1m
         UE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsvzwFNEnHsJ1uh4maplzk+1wE8dN+TE2VMxmxzZ8dE=;
        b=qHqR5hFlN+egtHQ4/0u9576MpgbivT2n0vXoa4mPHKjoY1tRpeC5xihXldOcl6/DQl
         MyhG1GM0dZt+afujdMqo+EN+wMcK+Vh+ADE5IJFkBzEeiGjAIwGpYTvh7GCtIYIo3Rt8
         IeKrU7B1lvWDRLuBVM/faewfJRAAymF84i/PeN5eh5/iKQu4DpvFNgvK3CnwJkS8sl4j
         auGpPkQach4V0F7It+vpcMbj+jWL9IXgqk1DZanXfggT1oWnurpeGv1O3vE8jxGquA0T
         mOH/n4GuOrUhDLuBxuyf/6uhohcydOeI+o/TlyoyOkMzZWIFuXiVFgzpnpDZM1/70f8j
         zA7w==
X-Gm-Message-State: AOAM531gpvG8CAd0hdLGAhpVAKuC89AhLLFBtKayzpR1lLRdDyiKsd05
        +MHqQ1ceutUfGdFM0Edu0OxPOr050fl6MzBNOtaGN+drZJoJXQ==
X-Google-Smtp-Source: ABdhPJyS6Ti+uIYGWdQNqPa38qjtj41Cw3Fi4NR7qHUNN5FNhg3Q8d88RM5DIy4pvt7sMeHfzdULwiJhybLvc5GsdOE=
X-Received: by 2002:a25:ad02:: with SMTP id y2mr1904050ybi.78.1630710031602;
 Fri, 03 Sep 2021 16:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <acdf065c-256d-47b0-5c20-203ff4b213d6@gmail.com> <CAHk-=wiENdk_AXGRrmbbOYqq9zYptdv=vYszgG2ZzztDUTJwRA@mail.gmail.com>
In-Reply-To: <CAHk-=wiENdk_AXGRrmbbOYqq9zYptdv=vYszgG2ZzztDUTJwRA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 3 Sep 2021 16:00:20 -0700
Message-ID: <CANn89iJ5Q-PeZ=+87DT-BY4EVhWZATtieid59W7Tq0bkCvRQbw@mail.gmail.com>
Subject: Re: dozens of sysbot reports
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 3:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 3, 2021 at 1:44 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> > I have a pile of (still under triage) sysbot reports coming after one of your patch
> >
> > Typical stack trace:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 24889 at mm/util.c:597 kvmalloc_node+0x111/0x120 mm/util.c:597
> > Call Trace:
> >  hash_ipport_create+0x3dd/0x1220 net/netfilter/ipset/ip_set_hash_gen.h:1524
> >  ip_set_create+0x782/0x15a0 net/netfilter/ipset/ip_set_core.c:1100
> >  nfnetlink_rcv_msg+0xbc9/0x13f0 net/netfilter/nfnetlink.c:296
>
> So the real question is mainly just whether those huge allocations
> actually make sense or not.
>
> If they truly are sensible, we can remove the warning. But it would be
> good to perhaps look at them more.
>
> Because no:
>
> > Do we want to fix all problematic callers, with ad-hoc patches like
>
> Not insane patches like this, no.
>
> >  ip_set_alloc(size_t size)
> >  {
> > +       if (size > INT_MAX)
> > +               return NULL;
> >         return kvzalloc(size, GFP_KERNEL_ACCOUNT);
> >  }
>
> But does that kind of size really make sense? I'm looking at the
> particular caller, is it *really* senseible to have a 4GB+ hash table
> size?
>
> IOW, I don't think we want that warning to cause the above kinds of
> ad-hoc patches.
>
> But I _do_ want that warning to make people go "is that allocation
> truly sensible"?
>
> IOW, it sounds like you can send some netlink message that causes
> insane hash size allocations. Shouldn't _that_ be fixed?
>

Probably, but as I said there are many different reports.

If there was only one or two, I would simply have sent a fix(es).

I will probably release these bugs, so that they can be spread among
interested parties.

 WARNING: CPU: 1 PID: 26011 at mm/util.c:597 kvmalloc_node+0x111/0x120
mm/util.c:597
Modules linked in:
CPU: 1 PID: 26011 Comm: syz-executor.2 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
RIP: 0010:kvmalloc_node+0x111/0x120 mm/util.c:597
Code: 01 00 00 00 4c 89 e7 e8 8d 12 0d 00 49 89 c5 e9 69 ff ff ff e8
f0 21 d1 ff 41 89 ed 41 81 cd 00 20 01 00 eb 95 e8 df 21 d1 ff <0f> 0b
e9 4c ff ff ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 e8 c6
RSP: 0018:ffffc90003a77720 EFLAGS: 00010216
RAX: 0000000000000e48 RBX: ffffc90003a77e18 RCX: ffffc9000df6d000
RDX: 0000000000040000 RSI: ffffffff81a4f621 RDI: 0000000000000003
RBP: 0000000000002dc0 R08: 000000007fffffff R09: 00000000ffffffff
R10: ffffffff81a4f5de R11: 0000000000000000 R12: 000000020008a100
R13: 0000000000000000 R14: 00000000ffffffff R15: ffff88802032c000
FS:  00007fbfc5618700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000540198 CR3: 000000006e529000 CR4: 0000000000350ee0
Call Trace:
 kvmalloc include/linux/mm.h:806 [inline]
 kvmalloc_array include/linux/mm.h:824 [inline]
 kvcalloc include/linux/mm.h:829 [inline]
 check_btf_line+0x1a9/0xad0 kernel/bpf/verifier.c:9925
 check_btf_info kernel/bpf/verifier.c:10049 [inline]
 bpf_check+0x1636/0xbd20 kernel/bpf/verifier.c:13759
 bpf_prog_load+0xe57/0x21f0 kernel/bpf/syscall.c:2301
 __sys_bpf+0x67e/0x5df0 kernel/bpf/syscall.c:4587
 __do_sys_bpf kernel/bpf/syscall.c:4691 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:4689 [inline]
 __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4689
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
