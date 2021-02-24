Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12DE323E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 14:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhBXNev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 08:34:51 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:34271 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhBXM6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 07:58:49 -0500
Received: by mail-il1-f199.google.com with SMTP id c16so1457099ile.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 04:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9jxPZuiCA7jaDkmkeef5PEjzR4rry7NtmgRm8f+yUDg=;
        b=BCHLaI5MeNHS+YLnK7EWEDLZed+FkRd0AiJwJpqmFATt6o+Yqp4XIIkMbx2iVfjAMn
         Zld7e1X+ciN1WKwftuH3B0dGOkRLo52RSp80EI8Kthkoqqx4SQHggGnMAcg05tS+nzTY
         mITYcd5FUPQMRZMy9+kidfwFErgDF7/1aK5h2Qa5rGw5H/lHNwkv7M1gNPW3nFbc8eKE
         zHGJx1NtI5xNfwdrb9ztQkQaloAWrJKX+zZRHSPZLLf7CvmQ3z/sKkxu0KBLhTujkFfr
         Gur+ZmPXqc/Jpb19r+75ZWUQ+PkEYCPy//alDxNT5rS5pYv0ZsXeRoLc5l0dO0r4SPoz
         CMrA==
X-Gm-Message-State: AOAM53081D9iYcycWoUw7mXBkHjvy4xhlJIFzkDqJEN3QQp/HMvvbRyQ
        hMFaESZVpluyUSG0gpaC7KriGMpOno5vH2E7/2JIdHexvXCj
X-Google-Smtp-Source: ABdhPJxcfzef5JCwn2Lw5QKonBcY1+Wcl2z02Gc9BPGuIFCres4pcMzhrJkgS0NepGxc+FTfhmXSkMfR4LV4xsUl0+nR7YmDeVug
MIME-Version: 1.0
X-Received: by 2002:a6b:4a0e:: with SMTP id w14mr24411528iob.140.1614171488521;
 Wed, 24 Feb 2021 04:58:08 -0800 (PST)
Date:   Wed, 24 Feb 2021 04:58:08 -0800
In-Reply-To: <0000000000005ccf1b05b7665adc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e14c105bc14962e@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in call_rcu
From:   syzbot <syzbot+9d3ede723bdc58553f13@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        andreyknvl@google.com, aryabinin@virtuozzo.com, dvyukov@google.com,
        elver@google.com, glider@google.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, vincenzo.frascino@arm.com,
        vvs@virtuozzo.com, walter-zh.wu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 97593cad003c668e2532cb2939a24a031f8de52d
Author: Andrey Konovalov <andreyknvl@google.com>
Date:   Tue Dec 22 20:03:28 2020 +0000

    kasan: sanitize objects when metadata doesn't fit

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106689b6d00000
start commit:   614cb589 Merge tag 'acpi-5.11-rc1-2' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=126689b6d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=146689b6d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf519e1e96191576
dashboard link: https://syzkaller.appspot.com/bug?extid=9d3ede723bdc58553f13
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11830e93500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d92057500000

Reported-by: syzbot+9d3ede723bdc58553f13@syzkaller.appspotmail.com
Fixes: 97593cad003c ("kasan: sanitize objects when metadata doesn't fit")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
