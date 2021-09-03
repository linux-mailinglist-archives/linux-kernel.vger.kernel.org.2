Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38D4400864
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350552AbhICXsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:48:11 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:39922 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbhICXsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:48:10 -0400
Received: by mail-il1-f198.google.com with SMTP id y8-20020a92c748000000b00224811cb945so518770ilp.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 16:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=49GVSL+8Ju2B1QUqKAewsys4rafDwru1aSMpQywZS0A=;
        b=g+CMhB2XXiJLs4z26HZl9L2e6IGROfnyoNOXAIlv/PO1GDgcCXXmgxHLzz01cHkzlw
         7DphrVCKh4mkXJs/wqoihONOe2DVfMZJbwZFrq4+CYKYpWbTeHKV86FEt2sPBMozaxvb
         A6OyoObeMJUyIp2kH3OHHR8yFEKKNys+pgYO6s0eUFbzaVXZyC8AIgFsRHRzMmeDfa6s
         NVSHmmqdzb9Iz7/4MWi+lQMkHMfjKcV7X/Ci6VQpwzTOMTw3wsp5nFnLF7hZcscnrk54
         eIK31FMNwTHLMvLndl7yAaIe5OaV43vZh25eMYP33rolUZic+TDjSYBVRLHjgqX58Kv2
         wigw==
X-Gm-Message-State: AOAM5322X5tr8GQYdH97Zj69bl73H8uO0dyBqID6sMUEP28UEAM2a55f
        fZAkuVNnQH+fpa8wiJa/X7TQR8cNjBs4jYANU3bue1iGYmsh
X-Google-Smtp-Source: ABdhPJxqPcg1k7hijBbzqBZIjUclFN4DkzgpDyRmu2xAWHNnxpFouyfcVn8OUI3wvoEPs0CIY5ocITh0LQ7SVO8c1NZ35abXF4Sk
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d06:: with SMTP id i6mr1009436ila.113.1630712829629;
 Fri, 03 Sep 2021 16:47:09 -0700 (PDT)
Date:   Fri, 03 Sep 2021 16:47:09 -0700
In-Reply-To: <2b424f91-0382-d3ab-26c3-52cf03dab999@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0da6305cb1feacb@google.com>
Subject: Re: [syzbot] general protection fault in __io_arm_poll_handler
From:   syzbot <syzbot+ba74b85fa15fd7a96437@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ba74b85fa15fd7a96437@syzkaller.appspotmail.com

Tested on:

commit:         31efe48e io_uring: fix possible poll event lost in mul..
git tree:       git://git.kernel.dk/linux-block for-5.15/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=914bb805fa8e8da9
dashboard link: https://syzkaller.appspot.com/bug?extid=ba74b85fa15fd7a96437
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
