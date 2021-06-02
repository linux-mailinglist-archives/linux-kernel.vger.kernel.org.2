Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E1B398D55
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhFBOp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:45:56 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:42809 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhFBOpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:45:54 -0400
Received: by mail-ej1-f43.google.com with SMTP id qq22so4207119ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asmhKT8Xu8vvlH7hmjEtXyIqg+xK/DCROaP6WgVKpIE=;
        b=HlWzmkBvNTpIJ/E0bwSNmoRzaZ4JpQE53kJHVe2dw2SzExR/f4wHbtPQEWjtca1/Sh
         OnJ6B1FL+/iN0Hmh+kQa9x8iGGxYeLqIan/2hAzD8i9V9EpMtjuSUnN7NAwaOuxmlpA7
         V4H+aGoBGbmw1O3ajPUDuglVqoY3LPZ1PJJSpU1mZK8P6CKfN7B3NSupo1ID0i89OC2z
         Fv08NM0nDAT03osPC/pfSOKJnMYxV3TInye321avjb31qjrEWK/mYEbDvIQc3HeaNBb8
         aHEsS4gGEM8shnWfqjjnSoYuXGQZ1vrGPjpY/wTgsS1lLkc/Insei9J0tk61h4p1DUcK
         b9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asmhKT8Xu8vvlH7hmjEtXyIqg+xK/DCROaP6WgVKpIE=;
        b=dDI4fj3FVJ1aWd/jExFWTOlahO3VHaqw1UBGecytTMLItziNbe+09jrHirzMl5eT9Z
         M5fNjRsl839EUmsQjdIwjlH/NQBAeJun/Psm4I5BDYUATK9jJOpdEblp3ymayEFAI7Ql
         eMee19q+XOQsS3GdbOVG1xjq8waxfDHKX4XE7Ybue3nghZg4hLMsfCOh0o1hQOk86ODO
         y8H3m4Q5DjGM6xyKk3XNUhrKtqe/n/QuchkvlKVfnVkrgFsacO34aL4LjKZm7BjvoUkh
         Q+fhmODN9PwCC+bm3SiJTGEt0KbLpuDywBPCcTb7YLZU3OtdUlmeIic1ccCduMLm5b42
         E9jw==
X-Gm-Message-State: AOAM531G24yyx36WNVaJPJv3hpLNQSNMATehWY0yM3W2Y3QHB5F6t4EX
        nSPgozMZwiRp46lLyMmAcRyBx1hk7Xa+/5/80SU=
X-Google-Smtp-Source: ABdhPJx5CM+Gpez16wZqwedSTYQ2NSEG7h7QE4YR6YTYLeJx9k2NA5IHHabZAYskx25lp+LPCZ4ZHKZ2Yt9MFtQtmlk=
X-Received: by 2002:a17:906:35ca:: with SMTP id p10mr411541ejb.535.1622644981795;
 Wed, 02 Jun 2021 07:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-N9QUDYbzkZXnDzf2P4b4Qk_kBQ_9ZVL3B4jhe9Xf2rgtpGA@mail.gmail.com>
 <5c3fbdf8-bfa3-a50e-edb9-81fbce84d9cb@perex.cz>
In-Reply-To: <5c3fbdf8-bfa3-a50e-edb9-81fbce84d9cb@perex.cz>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 2 Jun 2021 22:42:35 +0800
Message-ID: <CAD-N9QVRgzbWUc+SM2-XX5-vwCiZrOE9MgAEKCO8Czo-15P_yA@mail.gmail.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in snd_timer_user_ccallback
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     allen.lkml@gmail.com, alsa-devel@alsa-project.org,
        Joe Perches <joe@perches.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        pierre-louis.bossart@linux.intel.com, romain.perier@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 10:19 PM Jaroslav Kysela <perex@perex.cz> wrote:
>
> On 02. 06. 21 15:18, Dongliang Mu wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit: 5ff2756a Merge tag 'nfs-for-5.13-2' of git://git.linux-nfs..
> >> git tree: upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=17872d5bd00000
> >> kernel config: https://syzkaller.appspot.com/x/.config?x=770708ea7cfd4916
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=d102fa5b35335a7e544e
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+d102fa...@syzkaller.appspotmail.com
> >>
> >> ================================================================================
> >> UBSAN: shift-out-of-bounds in sound/core/timer.c:1376:23
> >> shift exponent 105 is too large for 32-bit type 'int'
> >> CPU: 1 PID: 10368 Comm: syz-executor.1 Not tainted 5.13.0-rc3-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >> Call Trace:
> >> __dump_stack lib/dump_stack.c:79 [inline]
> >> dump_stack+0x141/0x1d7 lib/dump_stack.c:120
> >> ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
> >> __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
> >> snd_timer_user_ccallback.cold+0x19/0x1e sound/core/timer.c:1376
> >>
> >> snd_timer_notify1+0x243/0x3b0 sound/core/timer.c:525
> >
> > The root cause of this bug is in the snd_timer_notify1 [1]. At the end
> > of this function, it calls "ts->ccallback(ts, event + 100, &tstamp,
> > resolution)".
> >
> > Here the variable event is 5. It adds 100 and is passed as 2nd
> > argument of snd_timer_user_ccallback.
> >
> >>From the variable naming, the 2nd argument should an event, and in the
> > range of event enumeration. In fact, 105 (event + 100) is out of this
> > range. I don't quite understand the meaning of adding 100. Any thought
> > here?
>
> It seems that the original intent was to move the event to the M... events:
>
>      SNDRV_TIMER_EVENT_MSTART = SNDRV_TIMER_EVENT_START + 10,
>
> So the added value should be 10 which should not break the shift range (8
> /resume/ + 10 = 18).

It seems you are right. Then event should be between
SNDRV_TIMER_EVENT_MSTART and SNDRV_TIMER_EVENT_MPAUSE.

I double check all the ccallback site, only snd_timer_notify1 invokes
ccallback with event + 100, others seem ok.

1 timer.c snd_timer_notify1        515 if (ti->ccallback)
2 timer.c snd_timer_notify1        516 ti->ccallback(ti, event,
&tstamp, resolution);
3 timer.c snd_timer_notify1        524 if (ts->ccallback)
4 timer.c snd_timer_notify1        525 ts->ccallback(ts, event + 100,
&tstamp, resolution);
5 timer.c snd_timer_notify        1092 if (ti->ccallback)
6 timer.c snd_timer_notify        1093 ti->ccallback(ti, event,
tstamp, resolution);
7 timer.c snd_timer_notify        1095 if (ts->ccallback)
8 timer.c snd_timer_notify        1096 ts->ccallback(ts, event,
tstamp, resolution);
9 timer.c snd_timer_user_tselect  1782 tu->timeri->ccallback =
snd_timer_user_ccallback;
a aloop.c loopback_snd_timer_open 1137 timeri->ccallback =
loopback_snd_timer_event;



>
>                                         Jaroslav
>
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/core/timer.c?id=5ff2756afde08b266fbb673849899fec694f39f1#n497
> >
> > --
> > My best regards to you.
> >
> >      No System Is Safe!
> >      Dongliang Mu
> >
>
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
