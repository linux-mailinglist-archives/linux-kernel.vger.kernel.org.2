Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E363439F5F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhFHMEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:04:38 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:45776 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhFHMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:04:37 -0400
Received: by mail-qk1-f182.google.com with SMTP id d196so14711407qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7GrlCKInRHwinOrKZ1wqy6YkpdctxLsTgU+gfy4jB+o=;
        b=CGoheWvkuPtRqaZ+7Tf129L50H3/R+jhpu7NCmpmE2SHWpJvx5RZPy1MhDH70Wa8bG
         HiG9gBkZhiNGRbUgQMMb4D5SMZN/j5SkCQU81eJo7UefWL5gv5D2+oPcVZfJwXOLkXj9
         AmD02ecSa9st3Am/8RQr/0KEDNSzLy9bL16x6YWmW2sCEOQRFeTgA8NUScQIwSD43xE8
         MAMDAMS2iwQW4mIyyrH9IztufHeNYf5Vf1jzuN0g9VZ+1czLk9zF4tFlFZpexrjhoUHF
         Wu70sN8NpAe7fO7LMTEv6GRaO7sowvV47wPVIK0VzR5/211Gqj+hJmAw7cciA0Kydam2
         XXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7GrlCKInRHwinOrKZ1wqy6YkpdctxLsTgU+gfy4jB+o=;
        b=QixG2r45YQLFHHVdyJdx8f3aS7Nae1D+gmrkXLjB7uHaV/NGM0OULcU2S3TM6zgUBr
         gmiaQno8OK86gmhK1mzDZu/kHEz9aoMCMjC2Qv+cjaP3MXeCCq6xgBfrNmaRSnN27UDK
         rS8+Wl1Lq5cG8HmHww6BjaW7GQ1vJSPa8A4M8IqgUO+c/cQgW1GZFuq6Wg0g8KVuukcP
         th3tqExfeLpRjJNWoFEWFQoJiAafbr8Ur/P5RPQ7VKaZDXuZDD0sBqeQ/v4hSmaL56Bd
         LGgKYQHMB4XVzWSpvx5Um6rKiYrT9xOB6NRy8x6wJnWPX3P8ZTZfEMW5+Ri92PPPcJor
         9bLg==
X-Gm-Message-State: AOAM530Owkgunp0d+RgrXucuIXeNTunXtY6dn3wsc5sm3wZAYeN+5oi4
        F6aUdrTKkgM04NJ0y/auPyAIRd+5d06+U/1+9ccx9g==
X-Google-Smtp-Source: ABdhPJzvRW//gdtd/Udm84t39KhHzId6doN3FQoptO5rzUO537RabS36u7WFCQWo2VkmaiqOZJMqylfEKxiGQkJD60Q=
X-Received: by 2002:a37:9d93:: with SMTP id g141mr21071495qke.350.1623153691261;
 Tue, 08 Jun 2021 05:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000bdfa905c3f6720f@google.com> <b9cb6dc4-3dfe-de60-a933-1f423301b3ca@linux.alibaba.com>
In-Reply-To: <b9cb6dc4-3dfe-de60-a933-1f423301b3ca@linux.alibaba.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 8 Jun 2021 14:01:19 +0200
Message-ID: <CACT4Y+az0ZsTRyj+FjA08ZjpoesoxSde+1vxn-WQnTgXM1rPGQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in io_wqe_enqueue
To:     Hao Xu <haoxu@linux.alibaba.com>
Cc:     syzbot <syzbot+ea2f1484cffe5109dc10@syzkaller.appspotmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 11:47 AM Hao Xu <haoxu@linux.alibaba.com> wrote:
>
> =E5=9C=A8 2021/6/5 =E4=B8=8A=E5=8D=884:22, syzbot =E5=86=99=E9=81=93:
> > syzbot has bisected this issue to:
> >
> > commit 24369c2e3bb06d8c4e71fd6ceaf4f8a01ae79b7c
> > Author: Pavel Begunkov <asml.silence@gmail.com>
> > Date:   Tue Jan 28 00:15:48 2020 +0000
> >
> >      io_uring: add io-wq workqueue sharing
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17934777=
d00000
> > start commit:   f88cd3fb Merge tag 'vfio-v5.13-rc5' of git://github.com=
/aw..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D14534777=
d00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10534777d00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D82d85e75046=
e5e64
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dea2f1484cffe5=
109dc10
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16d5772fd=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10525947d00=
000
> >
> > Reported-by: syzbot+ea2f1484cffe5109dc10@syzkaller.appspotmail.com
> > Fixes: 24369c2e3bb0 ("io_uring: add io-wq workqueue sharing")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
> >
> This is not a bug, the repro program first set RLIMIT_NPROC to 0, then
> submits an unbound work whcih raises a warning of
> WARN_ON_ONCE(!acct->max_workers). Since unbound->max_workers is
> task_rlimit(current, RLIMIT_NPROC), so it is expected.

Hi Hao,

Then this is a mis-use of WARN_ON. If this check is intended for end
users, it needs to use pr_err (also print understandable message and
no stack trace which is most likely not useful for end users):
https://elixir.bootlin.com/linux/v5.13-rc5/source/include/asm-generic/bug.h=
#L71
