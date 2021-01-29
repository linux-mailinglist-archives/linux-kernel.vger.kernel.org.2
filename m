Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AA4308352
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhA2Bi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:38:58 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:55008 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhA2Bir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:38:47 -0500
Received: by mail-il1-f200.google.com with SMTP id l68so6343854ild.21
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 17:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lm16eCirJMAjlWtITfJJw0jmgaMJxdBabVfxLijbAp0=;
        b=gpwC15//4wav4qJO25sXW0POwUCOhFRZckDg72YW8CtLy8yqLh0k7453FbycJaV7E3
         8wppcUNHPlZMrmdmp0S0wl3UXBjyiO+7c8k6XwcoCfC0hWJK5FePV2TvVjNIZyV84kH4
         hW5X3DESRve0No8z4KIL7Napnu2zkCcV/QLODSP9Q9aSHIrNpj5g0fLOwUAd0YVnT+4T
         6qT9SXua3/4gxf9O9EXWQ/1InvSbs74IPXdPhN67L5QqlG78VPOC9RuDcrVJvEmPWitP
         0Sgvv+pHErheFMJsAe/jhouOQGbPV3OH7xF2BL21hZGI7Dx6u1/T61Ry/+jrwsRyGmjb
         nShQ==
X-Gm-Message-State: AOAM531npmAL1RcjDFKeNwyFHasePOnecRMbdlwUtpl42MOnAw6vBss3
        LxyhRVL7EieY1FKo8fXPszgjaNnsyIO5QZ/bRawcNdsGAr6Z
X-Google-Smtp-Source: ABdhPJzaeeto+90vKfwCqIzrB5cp8eqdHC8gCKgD33zO40cOrw2abKT9qoVAFdgqqOolzOUWECqyCPq1B3LE/EP9Hzwa53UUwB8D
MIME-Version: 1.0
X-Received: by 2002:a6b:f714:: with SMTP id k20mr2029676iog.70.1611884286518;
 Thu, 28 Jan 2021 17:38:06 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:38:06 -0800
In-Reply-To: <000000000000619ae405b9f8cf6e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000512a7f05ba000ead@google.com>
Subject: Re: WARNING in io_uring_cancel_task_requests
From:   syzbot <syzbot+3e3d9bd0c6ce9efbc3ef@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, stable@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 4d004099a668c41522242aa146a38cc4eb59cb1e
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Oct 2 09:04:21 2020 +0000

    lockdep: Fix lockdep recursion

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133f3090d00000
start commit:   d03154e8 Add linux-next specific files for 20210128
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10bf3090d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=173f3090d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6953ffb584722a1
dashboard link: https://syzkaller.appspot.com/bug?extid=3e3d9bd0c6ce9efbc3ef
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a924c4d00000

Reported-by: syzbot+3e3d9bd0c6ce9efbc3ef@syzkaller.appspotmail.com
Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
