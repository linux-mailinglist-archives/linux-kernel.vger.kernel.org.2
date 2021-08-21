Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699763F38BA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 06:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhHUEbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 00:31:51 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:46980 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUEbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 00:31:48 -0400
Received: by mail-il1-f198.google.com with SMTP id f20-20020a056e020c74b02902243d481d97so6574283ilj.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 21:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SF7CJ7/rhuB732OlNTU5mo9NpnEHv8CCUjOPhiyovzs=;
        b=rbOxFg6OObBBbV83oaSf2fbO8B5WxGZbElWOIyOMfQG/TXDoZtGCb+mpLMHUI2SIBz
         s/9pOV5CrkeH6/9LnXIwocxaZb0iR2naic7R5oXJKz5/VkLvkpWpe537BMey1EGOvH4i
         FEMqEweKHuR6IGZ0bwuCXBHjJGeE0CV2TREaMsAfNENFY3rq2GBknVbNsdzhxRjLNxF0
         QJfTqz3BKRTWgjKMWOkTGWAp2zuT+/yUJv6Sqtx6Vq4SjGHOwmmKA4I1AHb2PD+CD1N9
         +0Ft3a8qH69urSq6aEh6n109lLaLQu5aIicqY6UZyrzr7Y5S7OaE2tAfpuTIL7dKJmtF
         WN6Q==
X-Gm-Message-State: AOAM5324reg4z0d9+sBgBc6H7SrjC82mTa3uPH2HIc9mWs0pBNJz/1tB
        GNA3r6Pi2NA1iwYmkdrQcJnpa8MLDbAgpqLETcAWMbzlBGBX
X-Google-Smtp-Source: ABdhPJycMqq/kBL2U5zB47hNjELZkvB5idcY6iW8Hlasb11U5hpKLy4m+yBfr4uFPLYUMUrNouEoNKeSUgoD52HA2d7TvQtxdc9v
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1905:: with SMTP id p5mr20766782jal.25.1629520268905;
 Fri, 20 Aug 2021 21:31:08 -0700 (PDT)
Date:   Fri, 20 Aug 2021 21:31:08 -0700
In-Reply-To: <YSB7AENonC6a0rCH@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8531505ca0a4047@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in ext4_write_inline_data
From:   syzbot <syzbot+1bd003b0dbaa786227e6@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, bvanassche@acm.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1bd003b0dbaa786227e6@syzkaller.appspotmail.com

Tested on:

commit:         9e445093 ext4: fix race writing to an inline_data file..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=7273c75708b55890
dashboard link: https://syzkaller.appspot.com/bug?extid=1bd003b0dbaa786227e6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
