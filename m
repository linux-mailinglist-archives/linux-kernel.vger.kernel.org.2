Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951D33CBA99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhGPQjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:39:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42941 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:39:05 -0400
Received: by mail-io1-f71.google.com with SMTP id v21-20020a5d90550000b0290439ea50822eso6389801ioq.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CyrLkzoEFYHeaOEbhQdss1e5QObnmG8SnAK1ZSoRFlg=;
        b=KNKT5gPiqNtnM9/g3zM3ZHeLdGFSVbk4e11YFxTHxTXe8EZRwSwNWwv/F8ngV6E52S
         Xe1QgJidIUUdMeXHV6DX0JlFq0HdqqnUZL9pPw5uYrttaxTXoT3kCpgLipoPCJ4oFYeA
         2f/xWTlQA7tFhctlM0GgYgnTBpLoM8befNc97U53R24gVK+l/2RBMns0y5kKVxgAAgKd
         wDE9P2wZOHZ1UyfhQSao3oC9tjt3p3WavjpWXo727IJf4DQFZu7iIIc3MnZI4Qg8G13p
         OTS7gY+TjzawduogC7E3zcMraAG0FJxalO50ReiYQHArd9OeL5Wc50u+yc2n4vueXw1B
         OlQg==
X-Gm-Message-State: AOAM533Re6Ya4x43qLXcHcPYIDHKPHn71y+ktkmTa0vsVUty22kcO1uh
        jJ3T0qiEqwp6Mew37skpmGwDa5W6SnjxObSZsHN2NOLCxcjy
X-Google-Smtp-Source: ABdhPJxdHIIfKDqO2vB4D/gAWY06xyYIYV70agpLPHOtTVt4fyUpyBjVxyxMPHSqWAPYvDcyMpaHdxjc/1IZni9S0t9Bb3CBGeQf
MIME-Version: 1.0
X-Received: by 2002:a5d:9b9a:: with SMTP id r26mr8100565iom.34.1626453369987;
 Fri, 16 Jul 2021 09:36:09 -0700 (PDT)
Date:   Fri, 16 Jul 2021 09:36:09 -0700
In-Reply-To: <20210716173819.07aa5afd@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ca71605c7402faf@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in profile_init
From:   syzbot <syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        penguin-kernel@I-love.SAKURA.ne.jp, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com

Tested on:

commit:         d936eb23 Revert "Makefile: Enable -Wimplicit-fallthrou..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d53336580099d6
dashboard link: https://syzkaller.appspot.com/bug?extid=e68c89a9510c159d9684
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108cb7d2300000

Note: testing is done by a robot and is best-effort only.
