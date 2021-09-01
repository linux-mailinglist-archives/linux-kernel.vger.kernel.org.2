Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7803FE2A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244650AbhIAS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:57:22 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:44996 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbhIAS5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:57:19 -0400
Received: by mail-il1-f200.google.com with SMTP id d4-20020a923604000000b0022a2b065b0aso159411ila.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=VQewuGl8vlvT5VzG8aIWIaodwgdkpe70I+5H3eoMzUQ=;
        b=XbXr9XyigduaLqSdj0YpuqVdqm97pVlNPfBWYWbWRnzNo3ly+hI2wgE7axbSGxVAuR
         eD1rWdV3hNUxQuK0kfATUS9QbEyeXeMILV+7vjzkBukfeM+1UXZoCeZafdAhw9EHpHLO
         YnVD5gpwbAfsM1v/sAp2ybet1rWPomJTqQpl2tVCFFSj1zTuP4ytGekJ8dYtTMigAGHS
         esyDlfCZKaL+7OZm7JG+iRYA6cnwvZy8J+yCj+fjjP9iDJSgqHj4HdU6ECwWACirbqBS
         Xa10be1zlXT8sJ6bDrx5Hlo8gwpB/DPrfbWlkcyDhKuyCskz0xwmW/DG1o1f5XMIQhuK
         +oNQ==
X-Gm-Message-State: AOAM531Iy2RbsoOnjH3oy4sAv8loZ3Kvc43WXDpum7kyxnpQhQP7P1mh
        96HVVUW+3sRUKfBymxXtipBm0KSaWgqFCbnqN6vwlb9kvs63
X-Google-Smtp-Source: ABdhPJxM7yX6hRmvluGE6iCdPwlVbRSElMJ6CqdrDZmLZzCmeZMG1VGsAztdYS5AollssH6Y3DRleo5zbPs0rl1vufRyPrTo/V7p
MIME-Version: 1.0
X-Received: by 2002:a5e:c905:: with SMTP id z5mr852876iol.33.1630522581929;
 Wed, 01 Sep 2021 11:56:21 -0700 (PDT)
Date:   Wed, 01 Sep 2021 11:56:21 -0700
In-Reply-To: <52d33ff4-5ddc-0103-9312-f75b7e7cb5b6@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b552c05caf39fd8@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in xfrm_get_default
From:   syzbot <syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     antony.antony@secunet.com, christian.langrock@secunet.com,
        davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 8/30/21 23:19, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    eaf2aaec0be4 Merge tag 'wireless-drivers-next-2021-08-29' ..
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1219326d300000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f9d4c9ff8c5ae7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b2be9dd8ca6f6c73ee2d
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e6e3a9300000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10de8a6d300000
>> 
>> The issue was bisected to:
>> 
>> commit 2d151d39073aff498358543801fca0f670fea981
>> Author: Steffen Klassert <steffen.klassert@secunet.com>
>> Date:   Sun Jul 18 07:11:06 2021 +0000
>> 
>>      xfrm: Add possibility to set the default to block if we have no policy
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114523fe300000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=134523fe300000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=154523fe300000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com
>> Fixes: 2d151d39073a ("xfrm: Add possibility to set the default to block if we have no policy")
>> 
>> netlink: 172 bytes leftover after parsing attributes in process `syz-executor354'.
>> ================================================================================
>> UBSAN: shift-out-of-bounds in net/xfrm/xfrm_user.c:2010:49
>> shift exponent 224 is too large for 32-bit type 'int'
>
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git

want 2 args (repo, branch), got 3

>
>
>
>
> With regards,
> Pavel Skripkin
