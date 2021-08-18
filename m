Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ADC3F0BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhHRTjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:39:45 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:38541 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhHRTjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:39:41 -0400
Received: by mail-il1-f198.google.com with SMTP id j6-20020a056e02014600b00224bde51e20so490121ilr.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hi/nmEZIRsCU9682LSqAQCuI4L5ah/9l7ujImEmLeeI=;
        b=Ou8HcwGc3hlpxqQj2F5LuXLVCF5C2yUmDNcnokUUBFb0W5aDvjqn5XkUHomRZ8gf6M
         GOPQFPDhowAyAcDdvTKqTOh4OFVsIMbeJzFMRl4Vf1Y3K3lvLi/A/Za5Z7EKwei/nwDB
         1Mq/M0eoI+sjHBTjZQ09zimhJmtB3l1HNrkOVnnBOh9E/P0ZeLAmeT8umpwtfVtG/yPP
         zAaKpsZsCAfgw2x6PIYi+lqWEN0pet9+OxdWcInUleE+r2CwSu2cvWrh3utO0KE9/WN5
         QrHFgCNzfricGdH6Nwt3T3PuvwLl1eDgb2Et/N/fTWPa4hJCU2xaqGpipr318qLE5GiP
         x97g==
X-Gm-Message-State: AOAM531bzARAU8UTos3iQi55rig0cpnfiqU4j4ciYzfQ9/AAg83hZ8x5
        O9etTNeLstsV4Mc+FAIneCoR0mf490PnORFuDh0M4ULVML/3
X-Google-Smtp-Source: ABdhPJx+1qXNY2DPc9vzm8b2fF7TnTSG/qFJQOgpQNBixAmFmzc3OdBX05rj5B1j31EsG5oYRsk82a3qx1lW1+loaoGhr+7Ii+oA
MIME-Version: 1.0
X-Received: by 2002:a92:da11:: with SMTP id z17mr7248141ilm.176.1629315546323;
 Wed, 18 Aug 2021 12:39:06 -0700 (PDT)
Date:   Wed, 18 Aug 2021 12:39:06 -0700
In-Reply-To: <000000000000d77b6505c767b8f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005da16905c9da9643@google.com>
Subject: Re: [syzbot] WARNING in hid_submit_ctrl/usb_submit_urb
From:   syzbot <syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, dvyukov@google.com,
        gregkh@linuxfoundation.org, jikos@kernel.org, johan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mkubecek@suse.cz,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5cc59c418fde9d02859996707b9d5dfd2941c50b
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Sat May 22 02:16:23 2021 +0000

    USB: core: WARN if pipe direction != setup packet direction

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126f1731300000
start commit:   794c7931a242 Merge branch 'linus' of git://git.kernel.org/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=116f1731300000
console output: https://syzkaller.appspot.com/x/log.txt?x=166f1731300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
dashboard link: https://syzkaller.appspot.com/bug?extid=9b57a46bf1801ce2a2ca
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ae58ce300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d71731300000

Reported-by: syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com
Fixes: 5cc59c418fde ("USB: core: WARN if pipe direction != setup packet direction")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
