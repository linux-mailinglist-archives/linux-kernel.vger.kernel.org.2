Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D0732209C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 21:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhBVUF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 15:05:56 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:44542 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhBVUFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 15:05:49 -0500
Received: by mail-io1-f69.google.com with SMTP id v20so3343848iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pLRhfTwy0FUDr6U+czrEs8kT0CiU0z5KeTk0hw3Qk44=;
        b=I9bSOHIfBLJwDSsGUHBvXqIW4F9RmiLS18SDHmgXrzIkXsk4NGmbN4KXEvCQMvNlbr
         KDznspDXPLS/1BTN/wRdgpH/TjCuIdd6cIvrAu5hfw8lz8iIuGshFG0a5+0IGXBq9hM+
         vka/dXoFmcS7FcHNaL1o6+TW4ZPE5i3axEZQjazQZiubii7w4Ehgys2j0mHxWdV4BZHA
         HyhVm4Cl4NeGSnmb2EInRYiXwKtnKI9qv51EfMuUg5SclonSIYt6TgiQ11VUfLWRSfD9
         n2kLLDQen+QCCM7yxvuU5du0SWedcE/oYbdHA+WgOdhCIHSjX4DSJg/Fw4H9la/cwrmF
         kKeg==
X-Gm-Message-State: AOAM533wnPkLpeJhVAjedwiJIKW2+pllGJ4IqxJWLyCH6HCYzz19/Zj8
        oE6Quhqt4ZWfry+POKolGUtvFP7dkmCav58PtHD55bd8Q2sN
X-Google-Smtp-Source: ABdhPJwszLmEf05WJAk7l0wSG1p+UlAXJeVI4fkex5PIO3u7zUVcnSOF4SeEDaLWNi51O4a7o1C+CBhUI8f7on020bFHQ1vhJh9q
MIME-Version: 1.0
X-Received: by 2002:a5e:8615:: with SMTP id z21mr9597031ioj.132.1614024309299;
 Mon, 22 Feb 2021 12:05:09 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:05:09 -0800
In-Reply-To: <49ac93fc-57b0-1f94-c43e-f9ab9a3913af@toxicpanda.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d5c1205bbf251b9@google.com>
Subject: Re: KASAN: use-after-free Read in nbd_genl_connect
From:   syzbot <syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com

Tested on:

commit:         2b31ee47 nbd: handle device refs for DESTROY_ON_DISCONNECT..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git nbd-kasan-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ff2a923e3615ffe
dashboard link: https://syzkaller.appspot.com/bug?extid=429d3f82d757c211bff3
compiler:       

Note: testing is done by a robot and is best-effort only.
