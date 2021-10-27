Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3561E43C140
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhJ0EWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:22:38 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33483 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhJ0EWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:22:37 -0400
Received: by mail-io1-f72.google.com with SMTP id f19-20020a6b6213000000b005ddc4ce4deeso1183800iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DItX2Jx563fphZQYl00QAo1gQ6VTrK2Edi6aJMGrJSY=;
        b=1sH2Fh2W5x5Ie7GJr1wzy4cC35ylDO0LQvfeM4+9D3g4qzdlwY2lUEtZoQbcRc0YQs
         U+Lw3KFTlncWsGYMSRVo8E/EPHLJV3jSYpqhO8YjBdFv7JWbl1cwZZhLcHL/DkX7ZfDu
         nwYDP2/iTzsye4a7votyCbjOTPKPXVtXpwwNp8JLxmyqTzPsmQCWgl6rWGQElUIIvLXo
         LKi6oQlkm01C8lzW0zXK+YKEhzEQ3fpYkVD5n3YrRuzP/xIYKuwjlOSGltughuCS5jWw
         Q0G8Yzt/Tfo5R5oi9+Rc5tLkC6B3ds8GXiJZJjh+qB2Nh9ERH9x6q5cHbGickoPwJHGs
         ndIw==
X-Gm-Message-State: AOAM532Hk358xaGqRwBbuNCI1VsCbvGhWcGJbojMx3wN8LByKvlRWMXf
        j3dULX0NXK3w1/yRfsqCjyQMgaLHK973OSN7O2r3ptqoBhXc
X-Google-Smtp-Source: ABdhPJyvjtwipEQfhFOp99qhFGQZdvk+SXLy1uQsj5GuLmHrMps+749rQFA16esm/vE9CjUSwpO68o4YhIeioq3+kbLro1DrGcss
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba4:: with SMTP id n4mr10941844ili.93.1635308412367;
 Tue, 26 Oct 2021 21:20:12 -0700 (PDT)
Date:   Tue, 26 Oct 2021 21:20:12 -0700
In-Reply-To: <000000000000016ca805beaf4d26@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000477e405cf4de9b8@google.com>
Subject: Re: [syzbot] WARNING in emulate_vsyscall
From:   syzbot <syzbot+2698183e871d8a137f9d@syzkaller.appspotmail.com>
To:     bp@alien8.de, bp@suse.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, keescook@chromium.org, krisman@collabora.com,
        liangjs@pku.edu.cn, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wad@chromium.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d4ffd5df9d18031b6a53f934388726775b4452d3
Author: Jiashuo Liang <liangjs@pku.edu.cn>
Date:   Fri Jul 30 03:01:52 2021 +0000

    x86/fault: Fix wrong signal when vsyscall fails with pkey

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bb466f300000
start commit:   009c9aa5be65 Linux 5.13-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ca96a2d153c74b0
dashboard link: https://syzkaller.appspot.com/bug?extid=2698183e871d8a137f9d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e1a704300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125a92d0300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: x86/fault: Fix wrong signal when vsyscall fails with pkey

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
