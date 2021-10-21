Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D142E435DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhJUJc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:32:26 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:43821 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhJUJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:32:23 -0400
Received: by mail-il1-f197.google.com with SMTP id s8-20020a92cbc8000000b002582a281a7bso14359698ilq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8PyU5Mj2VjoiXabguVXYfQODn+mSv1LISH3665rY0ms=;
        b=48RZlCVE/dMvVIqWtp62L57yzolaKkzq8qjRkzlxyabc4rZUwncQDl/dBOjOii1Izb
         KNncb2c8Qml/zrOZJLom2jUbTUKeTcmMchis2qQ/i59lry4/njiukHTPVZE1h+trAtlj
         pG8QQmh6CY8lKhAMyXAZWJ5eIqc3opKXpBrzKE6vUY2pPF99HwIm5hjEk/5AxgiPIWc1
         ievrjNwc3LIGMWZHg2ov8/g03CZyuVx+w4H/pu/T1V4h2+hOOuarlin2PWegFANdURjn
         KrUy1IwV47oWcOJ47B1JIdmDywLq7/miwIihU/SEhQkfJHXiML2apfCXLzM82PhaUU1K
         LEqw==
X-Gm-Message-State: AOAM532iKPjsgb1Pps0AWfiFzOTqb2WMSL5QeLgCcW5mtYQWOICZdXJP
        j0V/Zn7BqS2CuriB54RtXcdL1bD/8J4vSSPxF43oPjsvLecy
X-Google-Smtp-Source: ABdhPJzuivB4NB9xmQ9oIDN34OTXIEibrUdziLVht/KsLW7riAywOtkmdpmFE2NkSfJwaM0qnx4LQOG9RGLokYSLPnoMiXC3BQrJ
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:: with SMTP id g3mr2716905ild.103.1634808607418;
 Thu, 21 Oct 2021 02:30:07 -0700 (PDT)
Date:   Thu, 21 Oct 2021 02:30:07 -0700
In-Reply-To: <CAJfpegskcCEZAX+EbnBZyva2NDyhJ9k97ZM_E9OBeXRjDsC_BQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000522fda05ced98aac@google.com>
Subject: Re: [syzbot] general protection fault in fuse_test_super
From:   syzbot <syzbot+74a15f02ccb51f398601@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+74a15f02ccb51f398601@syzkaller.appspotmail.com

Tested on:

commit:         80019f11 fuse: always initialize sb->s_fs_info
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3decadb8235b4dad
dashboard link: https://syzkaller.appspot.com/bug?extid=74a15f02ccb51f398601
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
