Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D2414DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhIVQMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:12:38 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:40933 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbhIVQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:12:37 -0400
Received: by mail-il1-f197.google.com with SMTP id x5-20020a92b005000000b00257796f4efbso2486476ilh.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 09:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UmA5fLnL3GwryS2xj+yPX5YOnEleOA06k1MW7m7x+TQ=;
        b=dEUY+WlLDuyGddefgJOJ/D+LaZWF71QsiFLe6k191D2aM9falZ7j1nihxKpIaumXMY
         UsjwxV25sz0+PLp4U1EP85QwKwQ4c6NMXvK5QMZAVlr+5bOYUR3izPNHCQwqv4JUz7Tz
         DzU4rmqYGUYyNvr19q1wbiiYSeLcmLgCA5JRSqmAGMLnPCdEij3cHZGdXN/HNtj5M6Wv
         SzJaInDQ2uZG0pPT6jPJz9w7FAMgXENNzmfMOCkSOkC/mrLe7TC/sPD5wo+xSxk6BOBE
         sLdLw3D3szQUpX3yU49BaitJ1S92tPiWEZOkiUfA/EiuBLKRxCH82pxd+/W6zZwr3vt2
         /qhA==
X-Gm-Message-State: AOAM533SV4YCEQWp86HCaovmA/xT5ZVDsBEdBnqeJp0735dzdu8ns0ZG
        6RPHPT42hwFRt/E3Na2k5pEZE0FAu4TBXanXheolNtoipoOu
X-Google-Smtp-Source: ABdhPJxk7hBdI+nl+8MGWPeeiUS55BURR8MW1W0ABkOhmmB6xfRPaH4Zg21gdAytWslsTLtv90L4YtBUY3Dpl8CGzWDD5CQx3GH8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d86:: with SMTP id i6mr378919ilj.28.1632327067566;
 Wed, 22 Sep 2021 09:11:07 -0700 (PDT)
Date:   Wed, 22 Sep 2021 09:11:07 -0700
In-Reply-To: <000000000000e692c905bbe9192c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000050d0d05cc97c35f@google.com>
Subject: Re: [syzbot] general protection fault in nbd_disconnect_and_put
From:   syzbot <syzbot+db0c9917f71539bc4ad1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cs.temp3@bpchargemaster.com, hdanton@sina.com,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mail@anirudhrb.com, nbd@other.debian.org, nsd-public@police.gov.hk,
        stephen.s.brennan@oracle.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 794ebcea865bff47231de89269e9d542121ab7be
Author: Stephen Brennan <stephen.s.brennan@oracle.com>
Date:   Wed Sep 1 17:51:42 2021 +0000

    namei: Standardize callers of filename_lookup()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1163691d300000
start commit:   acd3d2859453 Merge tag 'fixes-v5.13' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f04bb30bd3c55050
dashboard link: https://syzkaller.appspot.com/bug?extid=db0c9917f71539bc4ad1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f63543d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122c8ef1d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: namei: Standardize callers of filename_lookup()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
