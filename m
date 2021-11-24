Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71C445C50F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 14:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349730AbhKXNyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 08:54:46 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:54256 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354339AbhKXNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 08:50:16 -0500
Received: by mail-io1-f72.google.com with SMTP id a12-20020a056602148c00b005e7052734adso1878954iow.20
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 05:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=w8KNWN5k8usq5kIs6yZF5uGq4fyHvwNbxGeGmIcl1SI=;
        b=no4AYiMsIie0GlwiXONDMx5/blRG7Sb6OHxrhcpg5Iy0u/HcngI20pOFJZ9WreARiJ
         n6QBwQKlaPhdj9xp6UGX3JhlmoQP7rkBK8B+tBOXDc+UJjQeew7ZQ3b0QF46F3+2fnIt
         3FQpev3QYiX030CvqcQm5MxgYv8yilJq4nfQKt2AoEtZZf70YXQSbfJ1K85YIKNrEac/
         J1XP4eZDVHbc+hQ7nfrmiB7BbGaHtTGllTqT3XnNiJsbod1sNyQMBFIQENDxskNrSKYF
         iDmYF7Uuw2m+YazRd/7kPG873e5nXX6NzyN7aEvbojQbCMz9w4OyJgn54CrG2vnk+XDx
         a/Bw==
X-Gm-Message-State: AOAM533CR2AFuW7R4SaYQ95j0W90YKnB8GYY7ybESr9x2K4Wbs5zOmYp
        cCewcbsoI2WDyUtyVm4UlZ/24fqIiimkmfjFI+HydWwSj6Lx
X-Google-Smtp-Source: ABdhPJwq3s1JeTA8P4XTcawFUqUpzwHD16hTfE6M5zYXq6aiMGdlavvBPwbljhdJQnalmbuiYvAPEqfkqFTBwMpSHwtAfGUkz3lZ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:587:: with SMTP id c7mr13176266ils.311.1637761626006;
 Wed, 24 Nov 2021 05:47:06 -0800 (PST)
Date:   Wed, 24 Nov 2021 05:47:06 -0800
In-Reply-To: <00000000000062d0fc05cef24c57@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1ea7c05d189175f@google.com>
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
From:   syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com,
        fgheet255t@gmail.com, fmdefrancesco@gmail.com,
        jordy@jordyzomer.github.io, jordy@pwning.systems,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rppt@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 87066fdd2e30fe9dd531125d95257c118a74617e
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Oct 24 19:48:33 2021 +0000

    Revert "mm/secretmem: use refcount_t instead of atomic_t"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11cccf06b00000
start commit:   9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=be398dd7862f4b36
dashboard link: https://syzkaller.appspot.com/bug?extid=b904a1de3ec43711eba5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130cabdcb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175b91acb00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Revert "mm/secretmem: use refcount_t instead of atomic_t"

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
