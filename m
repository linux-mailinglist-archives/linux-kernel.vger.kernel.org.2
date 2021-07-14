Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BDD3C859B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhGNN4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 09:56:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36631 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhGNNz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:55:59 -0400
Received: by mail-io1-f72.google.com with SMTP id 18-20020a5d9c520000b029043af67da217so1283026iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 06:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=N/ycyVbAKypvr4aBP5b55WvZDTbuQtOis8h6IsI4I8Y=;
        b=a0Qz9UeOGUsWsCbIGADlA1T398QdEgVhVe9jt3p5FP15szMky11EriVrFWaleLRxgL
         mtDbsvEnmisz1WJNphcxeG+Cx5NfRd85JWFmq7BJlC/xz0pFRxXbkceOe5zi/An0oltm
         6N/wKkKRC2XGx7K8/ZkJ5l105zq3/NhWa79AqwJOczhnToeouH42XHfQ7etpe1gbhJT6
         8ojzOy1hxgdNPl2b8cnkj5xLa3wOYR3B66TFsMNafJnLO2gg1XE/TWOGlKLUTcI+NQkb
         XXUKXAas4YillAp4yJ5LQT9oVvjg1WL5vVcb/fcxPvZY0Pi+/KFGG5Q5cdHUcRcUl2v+
         3D1g==
X-Gm-Message-State: AOAM531VGZfyCuCoIKZbgQgPz1QeXx23Trjms9+Cl7ujVSdhyazm859u
        e1Ui7nEApMvvX/rDi3z1cRw9nUt4PKQvAn405LpthHD50NW7
X-Google-Smtp-Source: ABdhPJwQdxjhrMVlfTQyNZM+LDXFnlq95h5YyTDBNso5mIVX03pNd6lV7JZTvGSZTr60tx1ZMBXA8WcmrMx8Kqoljbod+w0Q8tc6
MIME-Version: 1.0
X-Received: by 2002:a92:9509:: with SMTP id y9mr6815314ilh.18.1626270787271;
 Wed, 14 Jul 2021 06:53:07 -0700 (PDT)
Date:   Wed, 14 Jul 2021 06:53:07 -0700
In-Reply-To: <20210714135300.hrssd4d6ydvvytgb@wittgenstein>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009584d605c715ac7e@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
From:   syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     brauner@kernel.org, christian.brauner@ubuntu.com,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        gscrivan@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org,
        stable@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jul 12, 2021 at 09:12:20PM -0700, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    7fef2edf sd: don't mess with SD_MINORS for CONFIG_DEBUG_BL..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=178919b0300000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=20276914ec6ad813
>> dashboard link: https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120220f2300000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115f37b4300000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/ syzbot+283ce5a46486d6acdbaf 

"syzbot+283ce5a46486d6acdbaf" does not look like a valid git branch or commit.

