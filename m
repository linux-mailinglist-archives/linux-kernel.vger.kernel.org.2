Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C4C308BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhA2Rmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:42:39 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:44245 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhA2RhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:37:00 -0500
Received: by mail-il1-f199.google.com with SMTP id a9so8260383ilm.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lfC0qpdQ1T9Xl29m7ejvYwmPN8ZlSIQE5xkZ0CP3l2o=;
        b=NnJgMRI1OGn0v+smPPqrkmvww5bfo6dREJdNXMD7tWgw6HOX90zOQlPWOPHCGKT8LM
         1/q03jXodsVM4MP1/3BgRTGR7GGNTUEgW5B7Iup138mjO+FBehdMeM0JcLNGPNZPzSQR
         QUSDKt5Q8JATa3MP09QK4CVCaYKFkm7E7hZPKtkamubpRNeRVHcye2VyzuRs4Czq9cyp
         mm/wd6JmW9Wi5NEKH+sxCmKW69Rilm/NOWcUv8O8CtpP0mZsiPwuSz+fJt8F3BGqyCod
         qgxKkVy5GsDLIn58ny5kt/SB6wINkz3nnYnBq18umeQmztD+RDV9Q4HDy8//uer4S5c2
         zbQw==
X-Gm-Message-State: AOAM5302PaAfPixWV/4krkUC0xI4i1hL+4LVhu0nQu1Ird5PBVLGBIxf
        DHikAkmwna/ioaW0bHKFK9WlTaDGYi9D62U0hCAyx8f7nNhr
X-Google-Smtp-Source: ABdhPJwBqVzozXEi/mXDr2fTOIGUbDevyAvTt6YrjOmicFDrPHmlaw/gllzSdTT6n1lw8j4CnDsCEL4/dHr1l1MlNOZe/mz1iRWI
MIME-Version: 1.0
X-Received: by 2002:a6b:f107:: with SMTP id e7mr4301666iog.191.1611941767913;
 Fri, 29 Jan 2021 09:36:07 -0800 (PST)
Date:   Fri, 29 Jan 2021 09:36:07 -0800
In-Reply-To: <000000000000d4b96a05aedda7e2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079a40e05ba0d702f@google.com>
Subject: Re: possible deadlock in send_sigio (2)
From:   syzbot <syzbot+907b8537e3b0e55151fc@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, boqun.feng@gmail.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 8d1ddb5e79374fb277985a6b3faa2ed8631c5b4c
Author: Boqun Feng <boqun.feng@gmail.com>
Date:   Thu Nov 5 06:23:51 2020 +0000

    fcntl: Fix potential deadlock in send_sig{io, urg}()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17455db4d00000
start commit:   7b1b868e Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3416bb960d5c705d
dashboard link: https://syzkaller.appspot.com/bug?extid=907b8537e3b0e55151fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e046b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f8b623500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fcntl: Fix potential deadlock in send_sig{io, urg}()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
