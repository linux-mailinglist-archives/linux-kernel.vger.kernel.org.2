Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B083EC2F9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 15:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhHNNup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 09:50:45 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50040 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhHNNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 09:50:44 -0400
Received: by mail-io1-f72.google.com with SMTP id k6-20020a6b3c060000b0290568c2302268so6766645iob.16
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 06:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QLpRevr8DKNPNbY1ljtut3aO5PfgahsmforNchxlxpQ=;
        b=XyuP+M2ZyUUglh9ADLEm7QaZPN8jNzk4NPHh3rFkD3qMsOqWWgGeVZZfkvROgC1miJ
         yh49KFYU4Ir1qLmC6KMVCWciQ0wBGEbcq9qgKsrOo6xadCrvHj0jSSZs/M45jcAbvN0y
         p35I6KMzBCOqPZztiBpdC1pd1PNDVTO9pcSRO3UiRk5a+ABZ1tRSC4h2UKxKG3840Pwj
         tbqf0lWQmUrSr1evE/rf3YJcXvnxwq/+sg0qc164cfHAaSeV9ig2kryrhlokL3CioY7i
         nDP0C9zfE8zTMD9PPLiQdryxInaK2Rg3D5Ts8T7+C3KSEgjS5vgNSJXklPJS9uMiYRji
         TuQA==
X-Gm-Message-State: AOAM532uSGVLcNlaJIu5pPqa1sX8Q09NK5pU5zMhSiUQTjrQc4cT7AZl
        IxLHmwxnwmWP5l7v0gDy2EzirDihXaNGU4RbPKvPaTYBPk8A
X-Google-Smtp-Source: ABdhPJwPy0yzJOKqej7fSxZKNIV1JyLQPbobhfd0dv6YG3H2b1H6gUZhHcVizwdunzJtASgVayu3ht43n9xAOo66jow2YFDT4wtu
MIME-Version: 1.0
X-Received: by 2002:a05:6602:341:: with SMTP id w1mr5694531iou.40.1628949016117;
 Sat, 14 Aug 2021 06:50:16 -0700 (PDT)
Date:   Sat, 14 Aug 2021 06:50:16 -0700
In-Reply-To: <20210814095036.2972-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076891f05c9853f1e@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in alloc_ucounts
From:   syzbot <syzbot+59dd63761094a80ad06d@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, hdanton@sina.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+59dd63761094a80ad06d@syzkaller.appspotmail.com

Tested on:

commit:         4010a528 Merge tag 'fixes_for_v5.14-rc4' of git://git...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dee114394f7d2c2
dashboard link: https://syzkaller.appspot.com/bug?extid=59dd63761094a80ad06d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a86b4e300000

Note: testing is done by a robot and is best-effort only.
