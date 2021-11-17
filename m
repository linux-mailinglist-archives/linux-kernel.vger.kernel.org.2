Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7D454039
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 06:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhKQFfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 00:35:08 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:54858 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhKQFfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:35:08 -0500
Received: by mail-il1-f198.google.com with SMTP id x6-20020a056e021bc600b00292aa8bec6cso469068ilv.21
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=U6kTvO9Oiv+XnDndGB5oJ6WC1Ug39q+jw5GcZf9PM5o=;
        b=Fx9NEYneXfNld/zGMDjacf90riuj1iJabK2y6gwUXMheCdoEHFgRo0Oc+BxagnAdwQ
         cUVfr0AHPrfcq/X9K99hiIrLKbuyhtFcRwel9+6GfvAiYRNGbzcpUjn/AYA7XXfAJnzh
         hvek0K3QQi6WDBt6o0t2FSYlR/66d+IxElb8JGaaIBu8MP8F4//yYyHhdZTWCmxJcDMV
         LsYVA0qW2ywIzWLWNphyzlza8wIeCkkrA/+h4geDwQHcMxE3kgRUujWMuj0a3w5iZTgV
         5UOSV1lBG1vHRN9y/YdNVnjJnu07H3v39fwfaHUib0vNryoAUz/o2lbIRS4p1UwvxUyH
         XJFg==
X-Gm-Message-State: AOAM5314rI3oih50GghYalbGb/43A+mAgcSE+oN9F3QiYva9IuYX3VmM
        AAwpetN16+XWFoqWBcTfb2Bb8eOcKc5GyhjxOaiuRpV2u+VS
X-Google-Smtp-Source: ABdhPJzNTw5YFfZ2o6POW9r7JpKSV/vb4VbOqP26VotgSBS9PYUKclMMIt7aM0nI2J0pC7i+O6r7kqBY+dZvlXu0kzD32nLvQmVL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2f:: with SMTP id e15mr6505013ilu.167.1637127129837;
 Tue, 16 Nov 2021 21:32:09 -0800 (PST)
Date:   Tue, 16 Nov 2021 21:32:09 -0800
In-Reply-To: <000000000000c93bd505bf3646ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006b5b205d0f55d49@google.com>
Subject: Re: [syzbot] WARNING in inc_nlink (2)
From:   syzbot <syzbot+1c8034b9f0e640f9ba45@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 97f044f690bac2b094bfb7fb2d177ef946c85880
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri Oct 22 15:03:02 2021 +0000

    fuse: don't increment nlink in link()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10563ac9b00000
start commit:   1da38549dd64 Merge tag 'nfsd-5.15-3' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2ffb281e6323643
dashboard link: https://syzkaller.appspot.com/bug?extid=1c8034b9f0e640f9ba45
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f16d57300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15758d57300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fuse: don't increment nlink in link()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
