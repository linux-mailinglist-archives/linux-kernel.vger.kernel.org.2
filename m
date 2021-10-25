Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD794391B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhJYIt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhJYItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:49:25 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9040FC061764
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:47:03 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id k11-20020a4aa5cb000000b002b73749f3cdso3422351oom.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QD6S5FcXqbMWnr2NhEbAy6feKFx0sh0idDAxYvo4UWA=;
        b=sygHC/VOYcly0K34H6f+G/9jVVFyNzaaI0rIUf/2HPloUI5E5b7L6u/6Kr9GqjMNIj
         31oj9Wj7ZylE/zaHSup06g+cQ8AML1nHrYqo139tQ8UI+yN/J6v/cf4pgskmxAT00PeE
         s3ho9bL8M8Zr5m8lvJFG9lL3vh796cl9hPObufKgDYkD4n+Fvz3XmAjKLhlaW23tSPzq
         ZxTfVrYWUANJeaE+fu4gcGTE/Hnllut8n5RYkcLo5GEfyvcgNtD64AC9g5ugn1iywCqU
         W/CD+r77Goc592kGebk2POeFo/H0UGQhkkJQb2UmmRLiZwBR3PpVlSI2IYw3Ner/bwCg
         3neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QD6S5FcXqbMWnr2NhEbAy6feKFx0sh0idDAxYvo4UWA=;
        b=D1FgEY2jJTv8O5+LfZxxg8nP78/Z49OIjABs3x8FPIlRnfE3x/i/tO0XstP7YI5ECm
         GK8fwQnBlLC83gAykZ9nfZTOBUQgw02sEKUgGKhXacMLnX73Co4K4pBqjCbdzOiR+PJF
         E/tJzkSIleADtrBfq0g4IJgl4V2J6I0iNem+wZGWi9ZgSL8Bw/tQ9C5bnj8M85HMUSsf
         2FBQNzRh6GQQSkp3Txe5RuAZX/cq7W0v722NejvxrLNQBZhnuiU9rEdfvOHX0wWZk+eM
         njJqoO8JdnPxN+yUpy13/ZxXqH80UT4wLlnqZWtcZ5zTd9DfQoVCj6h6Zx4FnBZHJSEh
         qs4g==
X-Gm-Message-State: AOAM531Nkg5KNoMFD6GXJ0+MSqHi0/pXCZHlkh4ZTXHyl2PEObK4RWn1
        ElLC3o1+5vvneOMopIIa01FZFgb3jyaKxpXG8Y4tFw==
X-Google-Smtp-Source: ABdhPJzRvj0Lq8NOJOOfTnmTc0kuAGX3WevBNcmF8DvEpgpKBbKX0g1yV0hUJ9yXTFboNOIAfsIzf6KGrK8XFDEAaMQ=
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr11131804oot.18.1635151622652;
 Mon, 25 Oct 2021 01:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d4e1e105cf235f15@google.com> <a189d065-fb64-b76f-9f45-f866f9d5638c@huawei.com>
In-Reply-To: <a189d065-fb64-b76f-9f45-f866f9d5638c@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Oct 2021 10:46:51 +0200
Message-ID: <CACT4Y+acFmP4kiSTAWniyqVfGf2cHfqNqvy7vfa-Hc1RVigFzg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in blk_mq_sched_tags_teardown
To:     John Garry <john.garry@huawei.com>
Cc:     syzbot <syzbot+412ca156285f619b8b62@syzkaller.appspotmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 10:39, John Garry <john.garry@huawei.com> wrote:
>
> On 25/10/2021 02:35, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    51dba6e335ff Add linux-next specific files for 20211020
> > git tree:       linux-next
> > console output:https://syzkaller.appspot.com/x/log.txt?x=10171dc8b00000
> > kernel config:https://syzkaller.appspot.com/x/.config?x=1adca843ed814d57
> > dashboard link:https://syzkaller.appspot.com/bug?extid=412ca156285f619b8b62
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:https://syzkaller.appspot.com/x/repro.syz?x=14f768b4b00000
> > C reproducer:https://syzkaller.appspot.com/x/repro.c?x=1295a8c7300000
> >
> > The issue was bisected to:
> >
> > commit 645db34e50501aac141713fb47a315e5202ff890
>
> I think that it should be e155b0c238b2 ("blk-mq: Use shared tags for
> shared sbitmap support")
>
> > Author: John Garry<john.garry@huawei.com>
> > Date:   Tue Oct 5 10:23:36 2021 +0000
> >
> >      blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()
> >
> > bisection log:https://syzkaller.appspot.com/x/bisect.txt?x=1597e130b00000
> > final oops:https://syzkaller.appspot.com/x/report.txt?x=1797e130b00000
> > console output:https://syzkaller.appspot.com/x/log.txt?x=1397e130b00000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by:syzbot+412ca156285f619b8b62@syzkaller.appspotmail.com
> > Fixes: 645db34e5050 ("blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()")
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in blk_mq_sched_tags_teardown+0x2a1/0x2d0 block/blk-mq-sched.c:544
> > Read of size 4 at addr ffff8880760b81e0 by task systemd-udevd/6750
>
> #syz fix: blk-mq-sched: Don't reference queue tagset in
> blk_mq_sched_tags_teardown()

Hi John,

Thanks for updating the bug.
It looks like the title was line wrapped. There is a hack specifically
for gmail to put the title onto separate line, it's still parsable
this way (if the whole title fits into 78 cols of course :))

#syz fix:
blk-mq-sched: Don't reference queue tagset in blk_mq_sched_tags_teardown()
