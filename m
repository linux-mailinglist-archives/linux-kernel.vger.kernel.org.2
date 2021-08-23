Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF93F42A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 02:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhHWAos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 20:44:48 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:37597 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhHWAop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 20:44:45 -0400
Received: by mail-il1-f199.google.com with SMTP id w12-20020a92ad0c000000b00227fc2e6eaeso732219ilh.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 17:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Uwxvn5atNhE0NIH/RYoJlbaLRjbzmMnZlC4pPIKHaCg=;
        b=a1eEUJ7y2Y8nuVIBxNcMeA4goLAP/haPU+niWVLJKe1ooOzwbJ4C1loA9v2bzC0y2B
         s4YpfeowdOIPSIcuYIdrRDwAl5pSa4wsU5ILv73QDI4jz3m0IAWrmEILAFZbTEPoRKVO
         OdTNTEZI4IqTq2Pf+PGXAxDk6DcsfDN8xoTX1GmCPY+lGbTv5rI0QhJ+/xaoybplfU/m
         YIwnCORL6uGSyMRcUov5i/eFhVeeO81FS8WFxBIDXtaw7NX3CLck68C3a6cs5ERlmgkp
         yVWPPzjdHi0GlZzUFjZBM+fuaekdmP/J5w6R7qSklcl3jYWHCmuuUqBHy9Q+gyJkVPjS
         kMUg==
X-Gm-Message-State: AOAM531iWi8s0dexm9hvXd3kaiMUTAng5hqv/y3txXduu1bdLQaonmTS
        RCkeRCx3sPsJscaqI4xIcLXkca+RoyjvSPkoklmJFvtCaALo
X-Google-Smtp-Source: ABdhPJzRzRs/Duz0wgM23JTziNfzEd6x9/41lSnGWLMkUw4RlM/yKekx0NVzSt7Y6yEF9dPTYoeP0ODdMtKxgxe5AaTww1CkJUtS
MIME-Version: 1.0
X-Received: by 2002:a02:2a88:: with SMTP id w130mr27207095jaw.60.1629679443921;
 Sun, 22 Aug 2021 17:44:03 -0700 (PDT)
Date:   Sun, 22 Aug 2021 17:44:03 -0700
In-Reply-To: <6e5f874d-ac61-9556-8d7e-575ec7d9682a@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a4e8105ca2f509c@google.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in iov_iter_revert
From:   syzbot <syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com

Tested on:

commit:         b917c794 io_uring: fix revert truncated vecs
git tree:       https://github.com/isilence/linux.git syztest_trunc2
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aa932b5eaeee9ef
dashboard link: https://syzkaller.appspot.com/bug?extid=9671693590ef5aad8953
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
