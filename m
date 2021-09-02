Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDF03FF30D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346924AbhIBSOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:14:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:39438 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346866AbhIBSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:14:06 -0400
Received: by mail-io1-f69.google.com with SMTP id a17-20020a5d89d1000000b005c2233d0074so1462932iot.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SKqbmxS+RsaX2s2wlkIqfPl2jpAwEZUOKc/WPcjCCI4=;
        b=gNd50aU/nU670w8V1LOYWuv7tGHtJTE8uRkDSf50aMX84rzk8540LL7xkF8OmHgCDG
         tEF98V5NqWSmhbGnD79/pbQs5+dMJimx4dzq3byzfIsWf1xbI8oQRpWNnNAuvlASKvKo
         YOuJgMjuoWbwMhThpFCxl+gDYylzredbFZ/sRs9bEgKL91Bh8F0j0rkbiNIIpaLN1WcD
         I8VbBaxBkesvYYzv93WtkyK70HbZcI01nK2H9TStT/qMLe/mnoHVfWgOc2HpQLlSOFNg
         Ne6LvpT/2jBDtO5o5u0Sq1FG5esfU+Y6ly8ltdztVyOmY7HAUuFGfgx5sJD8QaStxdYH
         W3Rw==
X-Gm-Message-State: AOAM531b+oCtClBzviqpojX16UAvybbDYP3cUUx46m0E0TEorb22qbe9
        QjQzvbrP/l9zNs2iqq65adM14UiSVepl9p4URVaRn/TTB/w6
X-Google-Smtp-Source: ABdhPJwD0D7+AptQ8EA9ckgdTuikiRxn9vuAi6y42y6HBFgaRe792GZ/6WBHMCptEET95qkqIwwzNODir9aTMaslfmsTvAlBugdE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:: with SMTP id h28mr3424101ila.266.1630606387606;
 Thu, 02 Sep 2021 11:13:07 -0700 (PDT)
Date:   Thu, 02 Sep 2021 11:13:07 -0700
In-Reply-To: <00000000000034712e05ca9741e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080826005cb07223c@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in __pm_runtime_resume
From:   syzbot <syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com>
To:     abhishekpandit@chromium.org, apusaka@chromium.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        hildawu@realtek.com, johan.hedberg@gmail.com, kuba@kernel.org,
        len.brown@intel.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 66f077dde74943e9dd84a9205b4951b19556c9ea
Author: Archie Pusaka <apusaka@chromium.org>
Date:   Fri Jul 23 11:31:55 2021 +0000

    Bluetooth: hci_h5: add WAKEUP_DISABLE flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17258e45300000
start commit:   835d31d319d9 Merge tag 'media/v5.15-1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14a58e45300000
console output: https://syzkaller.appspot.com/x/log.txt?x=10a58e45300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d793523866f2daea
dashboard link: https://syzkaller.appspot.com/bug?extid=7d41312fe3f123a6f605
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17608125300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17465ffe300000

Reported-by: syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com
Fixes: 66f077dde749 ("Bluetooth: hci_h5: add WAKEUP_DISABLE flag")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
