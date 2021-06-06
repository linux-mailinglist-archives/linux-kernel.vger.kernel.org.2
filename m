Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35F539D233
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFFX27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:28:59 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42666 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFFX25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:28:57 -0400
Received: by mail-io1-f70.google.com with SMTP id v21-20020a5d90550000b0290439ea50822eso10882923ioq.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 16:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oU4NTLB/bp0z6BEIAwWBRS3a/Lf5yLyHqXlovXbqmkg=;
        b=PS3qNI18v+XUj6PU7YvtIIiPdEwG29YKmFwJ0cTBkay+W0ba9mt2kZYst6vSgIG0vV
         7tQrJrkgRX3GeHqbDQfrHxisArE77REDXoSGGcovYFdZTYott29F5Vtm64mWPDXYczlb
         dguUmRPLvRcMJIbWypVzT7+MiF7W1z/o9hQQ0Ra5fN292xiGv08zy6Pg7QqibXGOIDmW
         iR6LPE5EFv0HywvcrkNOrIMIMmMAPQ7FeQaNDkBs/EPoU4rPlh22yhKNkjzTTVMVG7Zj
         26NLn6hL/DpyX+wCNkDKaxq3P29sd021Knl+EoSQFxH3wUXV/VpdEbz7r7yzFf+bf8Xh
         Umng==
X-Gm-Message-State: AOAM531vVTXcC8c/FISzuEOBFO2/Zc0YzynDOkNAlL4DAG47NCmEpoMN
        N0uwTgf8vJfQ381hMoCNVJLvKcjxeKM8UDACfYhkcMTz3HS1
X-Google-Smtp-Source: ABdhPJzb3G2hoCzgVwB/T+9VYoq4H8SE2XUt3w03m2CtvaYNrHvF/JrdNZcYD4S0sVLcH/qtUV7Fcmn4qONbNjPoSCWrV9RN4jqe
MIME-Version: 1.0
X-Received: by 2002:a5e:8d16:: with SMTP id m22mr12517729ioj.139.1623022027203;
 Sun, 06 Jun 2021 16:27:07 -0700 (PDT)
Date:   Sun, 06 Jun 2021 16:27:07 -0700
In-Reply-To: <000000000000f8e51405beaebdde@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064e7d505c4214310@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in nfc_llcp_sock_unlink
From:   syzbot <syzbot+8b7c5fc0cfb74afee8d1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, benjamin.tissoires@redhat.com,
        bp@alien8.de, davem@davemloft.net, hpa@zytor.com, jikos@kernel.org,
        jkosina@suse.cz, jmattson@google.com, joro@8bytes.org,
        kuba@kernel.org, kvm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        masahiroy@kernel.org, maxtram95@gmail.com, mingo@redhat.com,
        netdev@vger.kernel.org, pbonzini@redhat.com, peterz@infradead.org,
        rafael.j.wysocki@intel.com, rostedt@goodmis.org, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tseewald@gmail.com, vkuznets@redhat.com, wanpengli@tencent.com,
        will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f567d6ef8606fb427636e824c867229ecb5aefab
Author: Maxim Mikityanskiy <maxtram95@gmail.com>
Date:   Sun Feb 7 14:47:40 2021 +0000

    HID: plantronics: Workaround for double volume key presses

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e41588300000
start commit:   bbd6f0a9 bnxt_en: Fix RX consumer index logic in the error..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=339c2ecce8fdd1d0
dashboard link: https://syzkaller.appspot.com/bug?extid=8b7c5fc0cfb74afee8d1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1712a893d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1298b469d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: HID: plantronics: Workaround for double volume key presses

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
