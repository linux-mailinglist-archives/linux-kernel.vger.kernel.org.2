Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA33CECFB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbhGSRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:39:51 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:46729 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352830AbhGSQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:34:29 -0400
Received: by mail-il1-f200.google.com with SMTP id i11-20020a056e02004bb029020269661e11so11074890ilr.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 10:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lKM2UD/yHgWjmA2szMEkHx9fCrO+nHy0wS5xCM2jOV0=;
        b=Oa0On8zsCLZ+G/6hSsGWUUzcQMjPB+MP3a59Ubv9BdcoHeOQ5816Q1BdMv82IqPOZD
         G+3CbfNBPLvem4GYuiiZGMta+evy+kopeSlDwTwQ0L8d+iW7mTIzkAqJKKkOa0fX2e87
         x58Y7j+VFUxNN6rpFjM6rNx8ETGJwgtr0xN3YzchYl59bQNfg9uN+ymXbz/NAViqZ1Dd
         g/L5HIJ4BYkiq6yhG/bk659YW/dnlPUeTsurIRTdR3kmhugKZjpnAQvPU1uQ0wh9ePF+
         9jN4dsADBfZ40ocTwryoFJEJ0G1rUgQSufKgZW9q6GBqmCjyxofxvOSRjJCbe+1hmeoP
         AtNA==
X-Gm-Message-State: AOAM531kCTVMS/KIzC6sVB250+leW7UsTSoWQGVCskfAX+d/Z5XJZK2M
        J+MxVZKEIXYn/cprIrAr/Wq5Gz4UZR4s5g7AwV1byfvfPx0H
X-Google-Smtp-Source: ABdhPJwZFFssLOoNLjRgimHgZ+etxG2tvmGaw4gHR0vTxbgH8LEXycoYsMuGqxgNsK4/cw1XQ5fBDAiLlYO2sfpx4t7XP/Ndktqa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1142:: with SMTP id o2mr18396207ill.277.1626714909265;
 Mon, 19 Jul 2021 10:15:09 -0700 (PDT)
Date:   Mon, 19 Jul 2021 10:15:09 -0700
In-Reply-To: <c57f80f7-440b-9f12-a7b7-a58ed7ab400a@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051553205c77d143c@google.com>
Subject: Re: [syzbot] INFO: task hung in io_sq_thread_park (2)
From:   syzbot <syzbot+ac957324022b7132accf@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ac957324022b7132accf@syzkaller.appspotmail.com

Tested on:

commit:         61d27d88 io_uring: double remove on poll arm failure
git tree:       https://github.com/isilence/linux.git syztest_sqpoll_hang
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfe2c0e42bc9993d
dashboard link: https://syzkaller.appspot.com/bug?extid=ac957324022b7132accf
compiler:       

Note: testing is done by a robot and is best-effort only.
