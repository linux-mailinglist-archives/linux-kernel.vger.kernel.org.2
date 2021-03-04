Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D8C32D1BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhCDL1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhCDL0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:26:42 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0FDC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 03:26:02 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g185so8010988qkf.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 03:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNth6YEdsgjLCYzqVgWig/pc9y4Z+QwtmWe2ih4v0XE=;
        b=AcvlU5oUc0BsO890tTmp7VgcxyEEUCrD+S/1v8KyznjyRpii3g6BzT4/yVWD/zibyx
         pCxjj0SP2olZtqvv4Ytd8K9HcB8mYhhdrhow6xNktzA5dTfwhFzLYa3p2gWrhU5qU/aV
         8FUdKnjoXD2QdiO/DGqybkzptMHmqzD/gjXLt/C2TSn3ErKMctsLE7E+wxRhMpqgvFBN
         vlI9kRxvYsKhKFRfxeJWIj33NrsbpDeknemick0mRNMw4QGDZLRFBfmnk2ime+Frb9Pn
         HXswFb+I+dLrzonaEgXxy12G1sIfaC0mVtzoRcM1mAXDA65/oWf0x27BXrrK5LtsHq/l
         Pq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNth6YEdsgjLCYzqVgWig/pc9y4Z+QwtmWe2ih4v0XE=;
        b=SwZy4y5OoMC7/2gQP1lj6Lqp1Q4Edn9m4gaZt6oQZF+ArhfVq5suhPm5XYYYurRPfW
         oadHpjuHa5F6/NjT0I3g/zkIv02dn+cgNIOcuXAXqjrwfcgf2r/ANXQ9FLXFIGVSt5W9
         C2aG0sRXtFZC1fnfCEFk87cIYX0BEuiQE4VVvGFGFyKMarDWOWnquz1c1g4z1qAi8srD
         VJ2b1P/jY9cBVK5Oa/xYg6Q3yzbxR11oUoKebdWf3c0lkLsN3gOPDJTV9wXHl985fi2D
         55Z2B1Nhd5DGMNxdNDqZBJJL8J7HLWTPGnmveXyac60lHDnGTMytYGvZJjk0b//+Ru5u
         mDYQ==
X-Gm-Message-State: AOAM5319RI4HpeMiVpgdjWnGS7f7VKrAyzc886o/mim+KSIcsYxt7a4T
        eqD/puqkp9zCAlYnvz8FBksdp86TsPvY/q+kt1cSOQ==
X-Google-Smtp-Source: ABdhPJwLFPr8bB5B1jhGMXdFWwatSnFnI1S44ADZki40Td+bUhcjmVIbNdLph4II/SmzuAa8bdILEBJfYFILN7T+GBM=
X-Received: by 2002:a37:46cf:: with SMTP id t198mr3349950qka.265.1614857161264;
 Thu, 04 Mar 2021 03:26:01 -0800 (PST)
MIME-Version: 1.0
References: <000000000000eb546f0570e84e90@google.com> <20180713145811.683ffd0043cac26a5a5af725@linux-foundation.org>
 <CACT4Y+b1HC5CtFSQJEDBJrP8u1brKxXaFcYKE=g+h3aOW6K3Kg@mail.gmail.com>
 <5f715c98-2b81-4eee-be3c-11cbc1bc36a8@googlegroups.com> <CACT4Y+ZCKFXK+9Bw1__ofUBLy6y8mQRoQHm5Qt135mByOrYk8g@mail.gmail.com>
 <CALMp9eRuaFnav=ZUJdb1AefkCPhzH9rjpSHis_4XNVFG4rRimg@mail.gmail.com>
 <CALMp9eTVzEMpGEOhOKxH8tjyggeXFJ=+3xxipzQ=yFB3cT85GA@mail.gmail.com> <CACT4Y+bCat++Gc5H2JYjsQQ2hzQyEa3H-VKmb93H7tLrTVS31A@mail.gmail.com>
In-Reply-To: <CACT4Y+bCat++Gc5H2JYjsQQ2hzQyEa3H-VKmb93H7tLrTVS31A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Mar 2021 12:25:50 +0100
Message-ID: <CACT4Y+Ze-AjTb2ri6D5-CyDtJvXVmww-DaT-cUBzWGdouwKo5Q@mail.gmail.com>
Subject: Re: unexpected kernel reboot (3)
To:     Jim Mattson <jmattson@google.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com>,
        Peter Shier <pshier@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 8:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Mar 12, 2020 at 9:36 PM Jim Mattson <jmattson@google.com> wrote:
> >
> > On Wed, Mar 11, 2020 at 1:35 PM Jim Mattson <jmattson@google.com> wrote:
> > >
> > > On Wed, Mar 11, 2020 at 1:18 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > > This happened 10K+ times.
> > > > If GCE VM is rebooted by doing something with KVM subsystem, I assume
> > > > it's a GCE bug (?). +Jim
> > >
> > > The L1 guest may have done something that's unsupported, or it may
> > > just be a bug in the L0 hypervisor.
> >
> > I can't reproduce this in GCE with the collateral provided.
>
> As far as I understand, this may depend on GCE host kernel and/or host
> CPU, right? Do we have an ability to unit test on all combinations?
> Looking at the rate and reproducers on the dashboard I see interesting
> patterns. Perhaps the best time to try to reproduce is these periods
> when syzbot comes up with lots of reproducers. But it's not now...


These unexpected VM reboots continue to happen. I can reproduce them
on GCE, but not in qemu.
Jim, Peter, Ben, I can give you access to a VM I just used to
reproduce the reboot.
Here is the latest repro I used:
https://gist.github.com/dvyukov/e9ddb9c3f1117f8cfd85713cf44d81bd
