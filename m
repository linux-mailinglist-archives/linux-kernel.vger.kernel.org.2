Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E248B3D8458
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 01:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhG0X5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 19:57:15 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:54926 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhG0X5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:57:15 -0400
Received: by mail-il1-f197.google.com with SMTP id o6-20020a056e020926b0290221b4e37e75so478271ilt.21
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 16:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ty4TQPGEDKcGdMb6gqnGGhBMQQtzNle2IFTM2JBzdpw=;
        b=fd61lH6l+ZSBRYXu92SNxNyun53nXrscF7gqLF/HAljPkLNOWoq+xx1j1Ret59HkXn
         HBfui4BwzHUy8N3SFWZNJ46bec6J4ykWo/JxjhtuSiMi6WGBiulI70JSFQwzG4aXcHZj
         shk1vCcwTqyjhTutNTIAosKKCB+PBFqB3Mj4C+/iBWHRRixMBjeEJSnr7C47zasB9ZPs
         Nw02BgdFZi12baM5RfDAujcc7J6D/Q65iHKdgHOqx+ntNTqUf8kk3unBsJyfNA9ODIeI
         fd3Jqofp8p0pNLbuVDD2WJXwjMTw1AlahgIbCouYaL/OijpfNwaPzX1Rtz0egkY4OSxQ
         cDyg==
X-Gm-Message-State: AOAM531n/d8joKyKM6tJ9Iekd5sRfMbTTwdwfdmYcs6fguiBwrqY8jC1
        ONHxdj3+PG8YzFAx58nYwcqG8q8vxgnqzFO+4zu+XHMtvek6
X-Google-Smtp-Source: ABdhPJxi794p2hLFiirgR9Foy8pLJY+506lpsOX3kCxS6r/0n5vf9hy+CWYYNJ5uvcSGBDxKN6zzTZCed5eyrCSZB1mmLDJ5Xp/t
MIME-Version: 1.0
X-Received: by 2002:a5d:8d83:: with SMTP id b3mr21141726ioj.179.1627430233390;
 Tue, 27 Jul 2021 16:57:13 -0700 (PDT)
Date:   Tue, 27 Jul 2021 16:57:13 -0700
In-Reply-To: <CAOssrKdqbOr0jeE1pYqkWnFysVbdi+H7sfoc3c4CaiqBUqQz_g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f541e805c823a0fd@google.com>
Subject: Re: [syzbot] possible deadlock in pipe_lock (5)
From:   syzbot <syzbot+579885d1a9a833336209@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+579885d1a9a833336209@syzkaller.appspotmail.com

Tested on:

commit:         7d549995 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=40eef000d7648480
dashboard link: https://syzkaller.appspot.com/bug?extid=579885d1a9a833336209
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104bb746300000

Note: testing is done by a robot and is best-effort only.
