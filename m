Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E1376ED8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 04:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhEHCgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 22:36:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47962 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhEHCgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 22:36:16 -0400
Received: by mail-io1-f69.google.com with SMTP id q187-20020a6b8ec40000b0290431cccd987fso7299560iod.14
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 19:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yRpfOOpyTTcZNtaZ5IFA1pZLlVZkx0zucBbPg4TfvcI=;
        b=eD9ERPfXUQ78+hEufduT9y8laZ9hzABWnl3jFXDlQHOtleeHTpV+vIrlciAJOST0NN
         VIStiM28JNgQbMc2Pivcg5tBkZOShqIT1slAIszb2OjEPzYugfOrL08wx8HFj+BRmGVf
         D5exqEtXUG/nS9pWKW1bCmxh0wJluKeOf8r5QsSZZiljCZ42VS2bIOgE0BRMJiIjVYcV
         ziyNr6NQYuc/iVqMJ/KYZljovAIrh7h9AKIfarcfOk31E1BrQvQHNwZjQKclJbat9But
         7TBrYPAZlEm1zeYgnwxEbXLL/kbdLScKwMTzgFuKqOYliOIP9XMZC0d2ozEPjvbWufr5
         2kMA==
X-Gm-Message-State: AOAM530CNnjRNlNo9jVAgc6uh/GsAoDCY+phTUv0SAcqJX+CuzqEKJWb
        YEb0Tsqz3qk459yb4UzZb8DmwtsXxuF8FdYrLxExU1uajoRV
X-Google-Smtp-Source: ABdhPJzHX9c5ZG3/8fGP0JaqYE7j0K8Z0eec2LcJ8r2KtTJmomlFxyYd/fHhv36H4CjE56fnpZb8C22cwsFriCp5qltYrQjG8+au
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr11998791ils.93.1620441315987;
 Fri, 07 May 2021 19:35:15 -0700 (PDT)
Date:   Fri, 07 May 2021 19:35:15 -0700
In-Reply-To: <c2cab9a3-b821-e4fa-3a8a-c66f15a642c3@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004f05705c1c86547@google.com>
Subject: Re: [syzbot] INFO: task hung in __io_uring_cancel
From:   syzbot <syzbot+47fc00967b06a3019bd2@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+47fc00967b06a3019bd2@syzkaller.appspotmail.com

Tested on:

commit:         50b7b6f2 x86/process: setup io_threads more like normal us..
git tree:       git://git.kernel.dk/linux-block io_uring-5.13
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e1cf8ad694ca2e1
dashboard link: https://syzkaller.appspot.com/bug?extid=47fc00967b06a3019bd2
compiler:       

Note: testing is done by a robot and is best-effort only.
