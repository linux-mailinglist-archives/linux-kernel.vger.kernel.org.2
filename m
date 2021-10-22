Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA342437C38
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhJVRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:48:32 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40603 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhJVRs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:48:29 -0400
Received: by mail-il1-f199.google.com with SMTP id t1-20020a922c01000000b00259731998eeso2957529ile.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RrHw7TXIiKdbLCANwDy+z6xoVa/oNS++wThBTPoL/HI=;
        b=67edEvU5aqtDDkXBA7G0G8CVSc506jyW/irdW63ddMEwXvX5BkZ0vlLiFWBJehnanR
         ATtGNKBjuP6/BK688oyAToCunPH2cM4ZyQSt1F6YksRwojpOXkr4psEccJuFJ/iKgGC2
         plS+9mvJmhLqE+qTIgTX2FZWQN/glSuGN8m6Uw0I6kb0P1iOKnZV3aPcVTiF56ILiCJt
         V2woNQ+4PVko4LI98nP4OcBD+u8UQxKVLXzGug3AABpLqqHdCF4xKr5MdiaiSXTEE6wI
         ZzWK/L4tN78dEsrkL9hiyoXI1l/G0ZHcYIJFCkX/RXTRt/JmbsfEWMXEdSnwLHn5SunD
         L+EQ==
X-Gm-Message-State: AOAM53389aY+wdIl9YBqEETpyeC8hjYSfSplkU7QV7aMP5aQ1h4r5hlf
        o9UxUEqNQDTuTvOslHItweS5vwJJiItFm3sJNap7asg7Dn8f
X-Google-Smtp-Source: ABdhPJw6yIyVEJmLjE1guEYATik6TF0vOCw3Equ1/PA4QM9pbSE29jYpfR05Jxmp4ZyNReAsLF56PiiTgLjL0LdBc1iIHrhEq66t
MIME-Version: 1.0
X-Received: by 2002:a02:a60a:: with SMTP id c10mr796118jam.139.1634924771381;
 Fri, 22 Oct 2021 10:46:11 -0700 (PDT)
Date:   Fri, 22 Oct 2021 10:46:11 -0700
In-Reply-To: <000000000000bab70f05b563a6cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b942305cef496a2@google.com>
Subject: Re: [syzbot] WARNING in port100_send_frame_async/usb_submit_urb
From:   syzbot <syzbot+dbec6695a6565a9c6bc0@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com,
        eli.billauer@gmail.com, fw@strlen.de, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, hdanton@sina.com, ingrassia@epigenesys.com,
        k.kozlowski.k@gmail.com, kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, thierry.escande@collabora.com,
        tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit e9edc188fc76499b0b9bd60364084037f6d03773
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Sep 17 22:15:56 2021 +0000

    netfilter: conntrack: serialize hash resizes and cleanups

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1633b4b0b00000
start commit:   c84e1efae022 Merge tag 'asm-generic-fixes-5.10-2' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be70951fca93701
dashboard link: https://syzkaller.appspot.com/bug?extid=dbec6695a6565a9c6bc0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c607f1500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfilter: conntrack: serialize hash resizes and cleanups

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
