Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7B3EF5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 00:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhHQWVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 18:21:44 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51754 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHQWVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 18:21:43 -0400
Received: by mail-io1-f71.google.com with SMTP id p22-20020a5d8d160000b02905a150b13b20so16099ioj.18
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 15:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=umDmu+4hB/JDNHdbTJk5sLucv5/bOLVHY7bndijJFTA=;
        b=B4xxtDpt7Q8kpAAWowr8HZYBS6BQXcpmB1vN9b95x/WrCS8Q8ZX1JnRt5v6uLABpl3
         LHjpkCktfPq0sc/ufdIBQIzHr4mWFO9gnvZQJSd9ZRUGKi4vXnFNuR836zCvC0WuXq/T
         QVy6f+4WPk3E3xFZbnOoecXoFEBOZlVOrB15JdgZckK43HMo6S4ZS8qBkgs+IDlXPo4V
         4r5O8r+7YrUVthFsnhVahwkdkG3Ru+uKGXrLwN2/lffpiN3aX8qJ5N+iWtupWzRlUHCC
         d1bFEtoZYIq29xiWAma5eDM0QT64l9RU/sE7vSuVUs7TSvgTamXpHCr7K3dl2JW8t6Bh
         SN3A==
X-Gm-Message-State: AOAM531llc91WC49elHibjRtO9xvwaJLxEtAOAVJx7Lf5CapMCLOGy7k
        jcpA6D9xe7TeTL3BcMYpx4h4/UqSdF/1uIMg09lvuy9gNFM/
X-Google-Smtp-Source: ABdhPJzaDcwt4eaiB4ndqrwZbsMFOJdKO3Yu0KMKfK1Kr5midZbCbjKzgjJY5yO6zqRjKZKrk/3nxoTRvoMMG4XwWaB7JHSI/tXL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:547:: with SMTP id i7mr3835170ils.102.1629238869490;
 Tue, 17 Aug 2021 15:21:09 -0700 (PDT)
Date:   Tue, 17 Aug 2021 15:21:09 -0700
In-Reply-To: <00000000000080486305c9a8f818@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012030e05c9c8bc85@google.com>
Subject: Re: [syzbot] KFENCE: use-after-free in kvm_fastop_exception
From:   syzbot <syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, mathew.j.martineau@linux.intel.com,
        matthieu.baerts@tessares.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit c4512c63b1193c73b3f09c598a6d0a7f88da1dd8
Author: Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri Jun 25 21:25:22 2021 +0000

    mptcp: fix 'masking a bool' warning

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122b0655300000
start commit:   b9011c7e671d Add linux-next specific files for 20210816
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112b0655300000
console output: https://syzkaller.appspot.com/x/log.txt?x=162b0655300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a245d1aa4f055cc1
dashboard link: https://syzkaller.appspot.com/bug?extid=7b938780d5deeaaf938f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157a41ee300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f78ff9300000

Reported-by: syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com
Fixes: c4512c63b119 ("mptcp: fix 'masking a bool' warning")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
