Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00A439895
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhJYOcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhJYOce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:32:34 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B32C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:30:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t4so15795814oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecXjdeuJlerx+ehZLpdS9uH72mGz1gRkt8PH2iIoiyc=;
        b=fgTudzKro276crsTGJpTyeoaB6sAoJ8XDuI+R0PiyVw/UZkgembqtSpXJruu/I3WdJ
         GqP3gQPgvpBVg73g5TN4GHQW6RvBpLIMl8SCGRQ0xgarpr39VSGNsobtfOCvJW0TEdiZ
         dXPMKznjHlCVrLFQr1TLGcn5RTBmRqjCxc0F6P3A7GeTzSiTLApvozJFv4WM7InQVJFv
         qZrKjSsVMvHiN0s58JzCECwX+Akow+FOWh3ZUUI63jtUhB8QRMNhBO8LTo3HE2XFNmXr
         oMVywlcPGl3VnRyd+KB9xWKre3utI99r0QMuJxPnk9Kcp23UzZYBMJb5BXPbFkv2sYLM
         99yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecXjdeuJlerx+ehZLpdS9uH72mGz1gRkt8PH2iIoiyc=;
        b=kHxYOf2/wNnYBnxf+r7pMUYlQ7yUAhT4e4y2XoIeLBlR05GU9w7RsEugjMO7A2A8H5
         Ip9vVdA6RT/CB90Ku79CGo64IiAOFGPCyFIc1GNWIXYb6BhdXVEoeucO5TTpVD93qIwk
         YuR4MT+c3wotTyGo8HICOyekUmvkVEI22S6BIEE942WWSWhlv9oxl9lDV05mtSFS2HWS
         sfYBY9fxPjIjOpMf3QTZjZxFlRqHKe6mFggA8K6vYL0mBIQ+6fo6FQlMTdtul0KeXtiz
         Ckrs1DWq7xOm1MDtZps5mBPZsy2MsWy8NCyfU7Gf/DC+bFI+2RdKdqcUCLn6CT+23Smq
         RLtQ==
X-Gm-Message-State: AOAM531QSaayZ3p1ufsoHq4psh4mdo7s3H4WKq5Z3MAdjgsa3dHyIOX8
        MwdNu01WZt4y6dfrHObuDJh1l1ChsEwVl+38qUe1b/c3R250QQ==
X-Google-Smtp-Source: ABdhPJxiMfXQeHoEbqfro5PPSN/sZ5fupF/PtRxrPbin+qhcUk7QSAU+7CiaIHIXYL9S4/Xy09CVmTg7RA3En0WJmMI=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr12234154oil.65.1635172209605;
 Mon, 25 Oct 2021 07:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000089871905cf2b7d09@google.com> <f37aa186-8820-451f-6fa2-eee45799a428@kernel.dk>
In-Reply-To: <f37aa186-8820-451f-6fa2-eee45799a428@kernel.dk>
From:   Marco Elver <elver@google.com>
Date:   Mon, 25 Oct 2021 16:29:57 +0200
Message-ID: <CANpmjNO1kTswzGp03o_=wMiFekXoq-kvDCy+zKSP3r5+EeOvMg@mail.gmail.com>
Subject: Re: [syzbot] KCSAN: data-race in sbitmap_queue_clear /
 sbitmap_queue_clear (3)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+4f8bfd804b4a1f95b8f6@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 15:36, Jens Axboe <axboe@kernel.dk> wrote:
[...]
> > write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 1:
> >  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
> >  blk_mq_put_tag+0x82/0x90
> >  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
> >  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
> >  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
> >  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
> >  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
> >  blk_complete_reqs block/blk-mq.c:584 [inline]
> >  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
> >  __do_softirq+0x12c/0x26e kernel/softirq.c:558
> >  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
> >  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
> >  kthread+0x262/0x280 kernel/kthread.c:319
> >  ret_from_fork+0x1f/0x30
> >
> > write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 0:
> >  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
> >  blk_mq_put_tag+0x82/0x90
> >  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
> >  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
> >  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
> >  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
> >  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
> >  blk_complete_reqs block/blk-mq.c:584 [inline]
> >  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
> >  __do_softirq+0x12c/0x26e kernel/softirq.c:558
> >  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
> >  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
> >  kthread+0x262/0x280 kernel/kthread.c:319
> >  ret_from_fork+0x1f/0x30
>
> This is just a per-cpu alloc hint, it's racy by nature. What's the
> preferred way to silence these?

That was my guess, but couldn't quite say. We started looking at
write/write races as more likely to be harmful (vs. just read/write),
and are inclined to let syzbot send out more of such reports. Marking
intentional ones would be ideal so we'll be left with the
unintentional ones.

I would probably use WRITE_ONCE(), just to make sure the compiler
doesn't play games here; or if the code is entirely tolerant to even
the compiler miscompiling things, wrap the thing in data_race().

[ A summary of a bunch of recommendations currently lives here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
]

Thanks,
-- Marco
