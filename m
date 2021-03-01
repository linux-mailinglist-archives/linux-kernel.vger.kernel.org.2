Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4313D327EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhCAM4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:56:52 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:47091 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbhCAM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:56:48 -0500
Received: by mail-io1-f71.google.com with SMTP id w8so12389767iox.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 04:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nQymcUIFYias8gCT71HYL6ML7ZvTT1Jm9pVu9Eri+4I=;
        b=IxidlpXQ/PrEewKl/9WciDV8OmED2ww+bWflnrDJC3h8MbfQh+nmwfBGML3pjMFhG6
         qar82E8qE2xzKjokeD0F3XgpT6aaHupG6j+cAN0a9hp7LJgTXsCMVC2o8HsR0VFzrue6
         AYDP41lC8n2uJf1JrMluEkLhZv1dMCgFYyDhmDaS5dQG5G5/2r0y0Vct8W0tA94A+Qec
         1Di5UCd9hUTOaedjKuiUJA831mRy5cGw3GPgjJU6IbegM/yZxvnFzkRjP1eVJj4CtPTG
         Ac4XlS0maymM6Xs4xxWCdm2Hl/DjWF8JJNqgZCubaEhYTvivHoCIrvevz7dUVnedIS89
         UUTg==
X-Gm-Message-State: AOAM5320mmmwikHZpjVXE+ZxWqkhATUVndHunOb1mvJMCNj9kyYhWup1
        HNiLuDAH6sXoUlDdLEST2bSC1daxBgtz2THSQOlkt6sLmlao
X-Google-Smtp-Source: ABdhPJxYFXn/qXiKcwCG+2wJepq4EIpagF1BGYLUytmXoy7n1TGaADpttBHAHpNrDhuSufi1cnYq1zSXAwLSv2jaqWsLZUyQm4Wg
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2047:: with SMTP id t7mr15580860jaj.134.1614603367762;
 Mon, 01 Mar 2021 04:56:07 -0800 (PST)
Date:   Mon, 01 Mar 2021 04:56:07 -0800
In-Reply-To: <0000000000002525c205b604547a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030504905bc792423@google.com>
Subject: Re: KASAN: null-ptr-deref Write in bdi_put
From:   syzbot <syzbot+aded2f2ab94d81727898@syzkaller.appspotmail.com>
To:     aik@ozlabs.ru, akpm@linux-foundation.org, axboe@kernel.dk,
        hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 2d2f6f1b4799428d160c021dd652bc3e3593945e
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Jan 7 18:36:40 2021 +0000

    block: pre-initialize struct block_device in bdev_alloc_inode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1424a5b6d00000
start commit:   71c061d2 Merge tag 'for-5.11-rc2-tag' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=33b7f56c5bf0f684
dashboard link: https://syzkaller.appspot.com/bug?extid=aded2f2ab94d81727898
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143f7fc0d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1089023f500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: pre-initialize struct block_device in bdev_alloc_inode

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
