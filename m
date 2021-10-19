Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B77433115
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhJSIdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:33:16 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47012 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbhJSIdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:33:12 -0400
Received: by mail-io1-f71.google.com with SMTP id z15-20020a5ec90f000000b005dcd32f83a7so12744976iol.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=g5ucrH3D4aJ8v2V4UuUZZDEXNE8re1s/NaWn5r42864=;
        b=HRSCEkuDbOCBgWiJwYgrL4B54bS+e1iLF8VSCWDUQo9UV91xuFQ1kCDQmibZc2CAai
         tSDtOeEV6dv96y3greJIgQhzZsaaelyZIiQSajh2x4oSRHL8VVFGmxMsX7YOXwEI0B6X
         6I5lP1ylBLQChSKY9tlAyjGONC2iYR+hojKH2HQcFfCKAIw97XfTkgqCjcz5hHHgSjkF
         93eMuKfVOgYXJPE6rTgPw89OknhiOZ31gJPdCCDdH4JwKceAepTYAVgN51M2EipsVq7N
         RWTRUM0/Oa4lYrSMEprM6CdcBy7meVxMma6Vx/GwvleKy5EiF+teXLaoPtOJUTWGyWR9
         HQTQ==
X-Gm-Message-State: AOAM531McYylgPJbxgmTQa+k6Y8R3Mc027g6S5C6e8NEATlhqrKcyZgh
        YJRreETmXNRTe+P1E9X36ZozqomfO6pr5cohdYGnRk1b8zR0
X-Google-Smtp-Source: ABdhPJzBmbgKRZyZ9iff3KS0pyPveoENcLIRI0M6r2myijAkt2hpFt/jh99jDKOa+mGvekHo7ZuA1ecxCKJdoRLewL2TVQd/tbFq
MIME-Version: 1.0
X-Received: by 2002:a5e:dd46:: with SMTP id u6mr18075445iop.217.1634632259876;
 Tue, 19 Oct 2021 01:30:59 -0700 (PDT)
Date:   Tue, 19 Oct 2021 01:30:59 -0700
In-Reply-To: <535d2ad0-1667-403a-9771-ad9c7b9748a8@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030395e05ceb07bce@google.com>
Subject: Re: [syzbot] divide error in genelink_tx_fixup
From:   syzbot <syzbot+a6ec4dd9d38cb9261a77@syzkaller.appspotmail.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On 18.10.21 20:55, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    660a92a59b9e usb: xhci: Enable runtime-pm by default on AM..
>> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1506ccf0b00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5016916cdc0a4a84
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a6ec4dd9d38cb9261a77
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11308734b00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f56f68b00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+a6ec4dd9d38cb9261a77@syzkaller.appspotmail.com
>
> #syz test:https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git c03fb16bafdf

unknown command "test:https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git"

>
>
