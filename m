Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21AB402065
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhIFTaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:30:18 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:48777 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhIFTaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:30:17 -0400
Received: by mail-il1-f200.google.com with SMTP id n4-20020a056e021ba400b0022481cdc803so4511052ili.15
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7ettfkG/1MVnCN+OeWqPq1oditQzjJjaSmv/fEPoEWM=;
        b=s6juwiKs0QZ9cWe5bzkTMfoPQBO9rtcn6CvDp7aspTvthNT0t7lktNl6TQimN2q7Sq
         X/8s+ahTqk1Oaf06an8abymWxcr+CB8Xi9gYRVlfQhzszhmO20TYppDgl8LnVFEjxWwY
         QdMuMed9X7X2ki4u3n0f/v9dRWhYzWxLKorXo8fdwJC8mubvtR1FFQd4Vf9SlgJgMf/C
         8akY7PPKGqnaB4Et4hShI3IJYXhz4PpH48JW9QA8NM89LHxIV9WoqCRxJT8QfdqAtavi
         wPb6PtfPhNbXjisR+ZSF2mJjs/mzc8HiW7QLMIXVRdrQF1yf4eGCFRLvHybdvLuCWAI3
         7tCw==
X-Gm-Message-State: AOAM533vF+utDd0LrCLgsbYyrMERE3theN1CTrzbAmfrmLr3p/QQiDm5
        3T82Fce5WCx708JfZkgf0MS7McuD9aW+HpOwYJ6D4W9QpVgy
X-Google-Smtp-Source: ABdhPJwuKH0oqPsGCRALkhkHi7zB2742Ux1G6h3MuZFuwMHrbGXsCRp9/InlavSqIf85ASbsNAfcsOzLN1JpanjMNy+Vf2AQRM4g
MIME-Version: 1.0
X-Received: by 2002:a6b:e70f:: with SMTP id b15mr10843139ioh.140.1630956552019;
 Mon, 06 Sep 2021 12:29:12 -0700 (PDT)
Date:   Mon, 06 Sep 2021 12:29:12 -0700
In-Reply-To: <00000000000056c3e005b82689d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed630705cb58a93b@google.com>
Subject: Re: [syzbot] general protection fault in xfrm_user_rcv_msg_compat
From:   syzbot <syzbot+5078fc2d7cf37d71de1c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dima@arista.com, herbert@gondor.apana.org.au,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com,
        xiyou.wangcong@gmail.com, zoe.byrne@bpchargemaster.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 4e9505064f58d1252805952f8547a5b7dbc5c111
Author: Dmitry Safonov <dima@arista.com>
Date:   Sat Jul 17 15:02:21 2021 +0000

    net/xfrm/compat: Copy xfrm_spdattr_type_t atributes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b8aa69300000
start commit:   a99163e9e708 Merge tag 'devicetree-for-5.12' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a875029a795d230
dashboard link: https://syzkaller.appspot.com/bug?extid=5078fc2d7cf37d71de1c
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167c1832d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10214f12d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/xfrm/compat: Copy xfrm_spdattr_type_t atributes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
