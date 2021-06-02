Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C48B398A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhFBNUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhFBNUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:20:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B5CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 06:18:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s6so2860718edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8sL249iFh5fLrh4+jcadscDil09cRaUNl+czqTJf9vc=;
        b=gPYKNhkEJakfzzuddkxy7II9Yimt2kWskOlB6F99t+fPqRNgukyZWgW7mbpDGhAhkt
         /6l37/9eUD3HgRrZkZq/Z+BH049YxHcCQ2XE0s01YqBEkMjsjm+bFSto9edmE6OregwJ
         +W7fPneQcN51SdI38E9WhLfBdO0NnEql5uuiTbRH6irmQA6INj1o8T5ETwHasEOnED4K
         ETLqjA1P9KKVZhTsjZNC705Tp/UoqBJ7PhFEXCSR1LvPf94g+BfrGE7ATntmHfNZ+HQl
         kNDaZ7gG+M0epS9KTYqKSk1qbUby5fV+GRhjN1KQTekgaNJa3z5mQf78uhy3SBz5cUxI
         qvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8sL249iFh5fLrh4+jcadscDil09cRaUNl+czqTJf9vc=;
        b=PDvg/Bspz4HOR3IQHHYgdzvWJtk+fVlOSVehGC4RwiRx6j+b49rvs1mS4nM6z/3wi6
         5vtn9P/QkM/uIZrxy5J1UnL/ABttj2yENAh9yOXHlpw2pFs9OppxueaSO6Ho8zx7eRZM
         0X8fj91f76HjLvGSnHhZnZ918l8/PXSrKm/QU+TsXBpwEQ/r6kz108xrKKGQ064b9Mi+
         QDuWWZLGwQOzwg7C140LOyBaugu4LcC2qLn2/oSPrH7vYak8EGRr9wot61bmw5DssRs8
         69tuRR4G1rXYZ0OCBwYrCITfS7gRf8Dw5KqVmFCQUC+AmxE+/AjMLQbYtesZEybYWFQO
         mUlQ==
X-Gm-Message-State: AOAM53251yRDNxs5f8SDPHP/5iDQq5WWA269tpMU1jVVbN4ltlhyBW8U
        alLeukYnX1zkr8SB03t1RkSBl3xVG4jPq0BmZCI=
X-Google-Smtp-Source: ABdhPJz47BocwY9xcSwhxCvikVXfyfuBhdVjPKS/2iDg8AbJPZKbNtAG5EX6IPVWRf+i+9GESg6KeCKKuotUTGvK638=
X-Received: by 2002:a05:6402:4c5:: with SMTP id n5mr37891601edw.322.1622639920272;
 Wed, 02 Jun 2021 06:18:40 -0700 (PDT)
MIME-Version: 1.0
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 2 Jun 2021 21:18:13 +0800
Message-ID: <CAD-N9QUDYbzkZXnDzf2P4b4Qk_kBQ_9ZVL3B4jhe9Xf2rgtpGA@mail.gmail.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in snd_timer_user_ccallback
To:     allen.lkml@gmail.com, alsa-devel@alsa-project.org,
        Joe Perches <joe@perches.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, romain.perier@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit: 5ff2756a Merge tag 'nfs-for-5.13-2' of git://git.linux-nfs..
> git tree: upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17872d5bd00000
> kernel config: https://syzkaller.appspot.com/x/.config?x=770708ea7cfd4916
> dashboard link: https://syzkaller.appspot.com/bug?extid=d102fa5b35335a7e544e
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d102fa...@syzkaller.appspotmail.com
>
> ================================================================================
> UBSAN: shift-out-of-bounds in sound/core/timer.c:1376:23
> shift exponent 105 is too large for 32-bit type 'int'
> CPU: 1 PID: 10368 Comm: syz-executor.1 Not tainted 5.13.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
> __dump_stack lib/dump_stack.c:79 [inline]
> dump_stack+0x141/0x1d7 lib/dump_stack.c:120
> ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
> __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
> snd_timer_user_ccallback.cold+0x19/0x1e sound/core/timer.c:1376
>
> snd_timer_notify1+0x243/0x3b0 sound/core/timer.c:525

The root cause of this bug is in the snd_timer_notify1 [1]. At the end
of this function, it calls "ts->ccallback(ts, event + 100, &tstamp,
resolution)".

Here the variable event is 5. It adds 100 and is passed as 2nd
argument of snd_timer_user_ccallback.

From the variable naming, the 2nd argument should an event, and in the
range of event enumeration. In fact, 105 (event + 100) is out of this
range. I don't quite understand the meaning of adding 100. Any thought
here?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/core/timer.c?id=5ff2756afde08b266fbb673849899fec694f39f1#n497

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
