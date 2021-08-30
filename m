Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64F93FB017
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 05:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhH3DvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 23:51:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47079 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhH3DvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 23:51:04 -0400
Received: by mail-io1-f70.google.com with SMTP id s6-20020a5ec646000000b005b7f88ffdd3so7805928ioo.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 20:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aPj2TWnuDlBBweogJjWY/JGFaEJrBHfPmSKpxgNvZiU=;
        b=YhmnRqF2dzyCGiz4x8hAY+J4i54MFzEITDq03rbJv2q/8DAARUPJ9NAFWDGYf7LMG6
         +Bfus+144KDbrvC6OTf35IKhv6eVF6u2DEzcmcdYZ8OZRqNy5sCGqO2M7QifqF3NuHqQ
         zNAjuPJllHm/6FoYO1o/uPvlAIbvjxQrSp5ZVwjv+6hmJGaDJ5a7ArQXMAnT6lFYy/QB
         PS4dp5Hwtc/zyuLwWq+AH0FYmjuuQ3oXJ7Z4a4khItvlwZW6RpLdMo5KNIw622U4RwrD
         2+1+w4b6vCHmuUWh1FNRxYo39vWDGo/q1FupQvkZp9DZ1q/EBTlWNhR1wPxkqDWwZ7xu
         Mibg==
X-Gm-Message-State: AOAM532ZKmNkj5gtNOPGkGAVeWU6yzD0IDB6PySmaeH2WikQjOWRLlv4
        MbyfGWIEmjKWnoASusApvnHRB7o5Aam3j1dKTh/XkqPO3ZoG
X-Google-Smtp-Source: ABdhPJy+Gj4J94WdetktCJfOEdZLLQt7q/2b2MyG4vRH7zjuGJWFiubLKIITRmf5mdwjudyvT2VLSHlhjDXPPZ6V+hAs6E7qGM0+
MIME-Version: 1.0
X-Received: by 2002:a6b:5c0c:: with SMTP id z12mr10646897ioh.171.1630295411206;
 Sun, 29 Aug 2021 20:50:11 -0700 (PDT)
Date:   Sun, 29 Aug 2021 20:50:11 -0700
In-Reply-To: <9b1afb1f-45d5-8664-eeb6-e8373d95cad3@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd337505cabebaab@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com>
To:     desmondcheongzx@gmail.com, hdanton@sina.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com

Tested on:

commit:         e3f30ab2 Merge branch 'pktgen-samples-next'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef482942966bf763
dashboard link: https://syzkaller.appspot.com/bug?extid=2bef95d3ab4daa10155b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12580a25300000

Note: testing is done by a robot and is best-effort only.
