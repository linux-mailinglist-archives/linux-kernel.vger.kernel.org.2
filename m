Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0F37BA26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhELKOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:14:23 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33735 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhELKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:14:14 -0400
Received: by mail-io1-f70.google.com with SMTP id d13-20020a6b7d4d0000b029043969826f55so7150880ioq.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QsFoIF7+TXSZxLlCnFsTt3IaVFcGwD9RJbkW47UyGlA=;
        b=OKoA1w5U0+GxCGYAr9oNyJJfJPnWXhwQlFS+TAxJd3xhwC+r2OCWS1DwVQvy4fwkYX
         uTq/9pII2kBcF4gL8Wp5+EpiCWiPhd913FSziFBrHxfjKZWawTxQS7wI3Ar7deOqnAou
         3Sx+T7F56AheItvMhgzbuSZXmw4Wz3oYwF4VyYDqNRNt+zDhyf5cFEeU7S/SFhGp0v0R
         3qH8VFz49x3/GtLb9CtXJEHHagVvOClS3fHz1PiSjjDLKIwIVA8qqf9TYaJE0puRcfzd
         EauZo8yvPiZtY1lhubKeV5YklLV7ht41+Hbvi9a1M9ARQUU4ls3hZubF0UkXFJRFlDZ1
         wPxQ==
X-Gm-Message-State: AOAM530vtdMjxM3ZlwtuN/+etSN4r5lLaSC+H1yjVcx8itt2cLQy5Xfh
        8RM3ztq38m6dec8hMzw1U61xpkV34UZcdKpcqw+jwL/lWtIz
X-Google-Smtp-Source: ABdhPJzK9DvyxlU39vr0TQCdZh91ks01LjLIzA5HtsRDNbuPVf/NBs2iiNdzZan43Z1RRmaTXl6CMdSWH9UF16deYyYIUANjpgrl
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144f:: with SMTP id p15mr29977292ilo.143.1620814385945;
 Wed, 12 May 2021 03:13:05 -0700 (PDT)
Date:   Wed, 12 May 2021 03:13:05 -0700
In-Reply-To: <000000000000a16c4f05c21ecc1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8a27f05c21f4195@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in bcm_rx_handler
From:   syzbot <syzbot+0f7e7e5e2f4f40fa89c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e057dd3fc20ffb3d7f150af46542a51b59b90127
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Date:   Mon Sep 28 20:04:04 2020 +0000

    can: add ISO 15765-2:2016 transport protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16883835d00000
start commit:   009fc857 mISDN: fix possible use-after-free in HFC_cleanup()
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15883835d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11883835d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b072be26137971e1
dashboard link: https://syzkaller.appspot.com/bug?extid=0f7e7e5e2f4f40fa89c0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c9f9b3d00000

Reported-by: syzbot+0f7e7e5e2f4f40fa89c0@syzkaller.appspotmail.com
Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
