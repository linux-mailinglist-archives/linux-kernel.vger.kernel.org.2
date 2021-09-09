Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091C4404882
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhIIKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:33:21 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:50930 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbhIIKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:33:20 -0400
Received: by mail-il1-f198.google.com with SMTP id x4-20020a92b004000000b0022b3cb3b4deso1537634ilh.17
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 03:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wYGQ6jwHlyJRKwQ0wASVxdo20+iSeZwpNWcEYrVI0Mg=;
        b=ZBgkTo28WjMtdh8TWyJbceeHOaOoDPSLpQTtjLJnGJzMsf8dJJb8wZFaWq4b0oMjsQ
         CVlk7zkwXD+vroSfHXi7YwXXgkG+tGMR9C9WjXtgNBfixRjSQdeENIBxDn9128c14yXe
         GB4bm36F5i4E7zF2yL8HyBngTBxHs8+B9TgO0KHfUk8Sxxcl/9FMfyPUZVGZxN3C8UUC
         WtD43PvIIHWRyN9C5R6SoRVQwj+tIW7m+kh8gjDJVby8lOwu6XtVKqPeeV5ZUO0Yiao+
         9SgzMWlFWBNSt2M34xYfhF1Ka9Yo6+iuwr0JeGyuFwJWv/pD7Ov2onyDOe4ZUA5blIvX
         my/Q==
X-Gm-Message-State: AOAM531TqTqxbRcxIuYR/VkQry7VQvA64noujj4aZye/mZd8Gemt1FKR
        o3CSZ2H8c9u6VU0EWRhVcou2pyDOTMrOAUaeHnpZ0NN2QCW8
X-Google-Smtp-Source: ABdhPJyLqRh/TbRtIHt72BPFNapbFg9OeSZoFGu+kZ/Sb6A9wM8KjD+jiurXOZXjz8P6xfgVBECN1lEOE5FmMsE/lX8rlWQ2Uj5i
MIME-Version: 1.0
X-Received: by 2002:a02:ba1a:: with SMTP id z26mr2259499jan.98.1631183531325;
 Thu, 09 Sep 2021 03:32:11 -0700 (PDT)
Date:   Thu, 09 Sep 2021 03:32:11 -0700
In-Reply-To: <0000000000006173bf05cb892427@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2bcea05cb8d8266@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_ipport_create
From:   syzbot <syzbot+a568bbab323b96631e61@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, fw@strlen.de, kadlec@netfilter.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, w@1wt.eu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 7661809d493b426e979f39ab512e3adf41fbcc69
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jul 14 16:45:49 2021 +0000

    mm: don't allow oversized kvmalloc() calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15bb0a93300000
start commit:   626bf91a292e Merge tag 'net-5.15-rc1' of git://git.kernel...
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17bb0a93300000
console output: https://syzkaller.appspot.com/x/log.txt?x=13bb0a93300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e23f04679ec35e
dashboard link: https://syzkaller.appspot.com/bug?extid=a568bbab323b96631e61
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178b5d0d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fad1dd300000

Reported-by: syzbot+a568bbab323b96631e61@syzkaller.appspotmail.com
Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
