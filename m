Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA36342C09
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCTLUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCTLTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:19:36 -0400
Received: from mail-il1-x146.google.com (mail-il1-x146.google.com [IPv6:2607:f8b0:4864:20::146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19271C0613AF
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 03:44:15 -0700 (PDT)
Received: by mail-il1-x146.google.com with SMTP id f14so8409191ilr.21
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 03:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TY6eWPej2xyMujUIiW14t6MNCP0JG96Bsng7hloAJn4=;
        b=V8vSRPbujCNXvMstUqMp8BSaAcpBFfB809JXtE8vkvmK7QMxD8GGU2d2WJqJSTaFsd
         UA02b9Q6V3As9HIGBDmx4N15T+F/bsW1bheIvIuknDGLSXyeY/vd0UV5Iku3kglVhU9e
         0HZHAhv6AAbTLmyzCiKlu2/Td33SMEvpp+YUxzu2g6Mfj5nAZjzXoOPk6CV+vWJI48jG
         dKCS43HQkgmg2KAj5OVfXyfBF/CWw7DAzUa80V+n/ujjFaUrZIph/DD3Jfd0R4Sg9aVi
         s4I5fasazYipboO4Fwgmhg7EMEbIGVJaewxJFUVkpZ7xfC1GCAZhX93Y9IswEBmmHdEB
         8JOA==
X-Gm-Message-State: AOAM5339mwzrwAHTtYBccfPMG523jk+F3s2x+LUgQrJDje7wvutTGjYr
        6nqHkeQF5EeYm7GaJUIswzFzZSaceySE/z5HkmZZ3BOCSu3e
X-Google-Smtp-Source: ABdhPJzd4Hj0631V/HLa6Uj7/62+FcuBi7Qtrnplas/d5g38qhibrBz0f8jwbnFRIVPYlFVkOb2/5wjN/P0+HfQ/VrrH9dXKJCjr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:: with SMTP id j4mr5426084ila.308.1616228824055;
 Sat, 20 Mar 2021 01:27:04 -0700 (PDT)
Date:   Sat, 20 Mar 2021 01:27:04 -0700
In-Reply-To: <00000000000076ecf305b9f8efb1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef073a05bdf398e0@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in add_adv_patterns_monitor
From:   syzbot <syzbot+3ed6361bf59830ca9138@syzkaller.appspotmail.com>
To:     apusaka@chromium.org, dan.carpenter@oracle.com,
        davem@davemloft.net, finanzas1@logisticaenlinea.net,
        hdanton@sina.com, howardchung@google.com, johan.hedberg@gmail.com,
        johan.hedberg@intel.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, mcchou@chromium.org,
        mmandlik@chromium.org, netdev@vger.kernel.org, sashal@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b4a221ea8a1f890b50838ef389d016c7ff280abc
Author: Archie Pusaka <apusaka@chromium.org>
Date:   Fri Jan 22 08:36:11 2021 +0000

    Bluetooth: advmon offload MSFT add rssi support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ef5ad6d00000
start commit:   b491e6a7 net: lapb: Add locking to the lapb module
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=be33d8015c9de024
dashboard link: https://syzkaller.appspot.com/bug?extid=3ed6361bf59830ca9138
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10628ae8d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12964b80d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: advmon offload MSFT add rssi support

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
