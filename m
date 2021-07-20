Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89733CF8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 13:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhGTKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbhGTKsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:48:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E1C061768
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:29:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ec55so28034623edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7wkojPSMrqZHIAJp0+Umps/ntjt0k1BRPOgIjoyyXo=;
        b=gd1Cfku3Ue3eszCew3EMHBk5hcPKjgUjJL07dN13W7f3dNiaeW9+hcY55TKM7CNwwJ
         bC8k8kQDReW+C+Sle4P9DpgFKcAPlI1TZET1jYTRmZcrOC9eHxoBvny0KU3Cl3j1/C43
         GtaVQxz/EFP+J+gW+iFGezqrsa4dcIJ/vN28WSzk741Wr/TVyj5B9BBuN/PYbqtYrm5M
         yZz1Zg5aojaPjFBsQ3SgnAc66xV0wku/EIqGcu/HmF3ll4iV3z20QfOVCW4Scv7WBT6M
         N60HrS8bvnD1Pc2ZtEWk6ITZkup4qxV3Gp8txWHLVAMeI96B9pL/m7t3IKvQ3gc9tEYZ
         A4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7wkojPSMrqZHIAJp0+Umps/ntjt0k1BRPOgIjoyyXo=;
        b=gmrmIYwLVxl908yedIAYd9440kEpZFOwA4qgIMcxr6EjYX70CjFUaMCx2zzmTZbEEs
         iPZaP5FL+XIXGnr7M71QFOtoR5Z21wXHPzPffQbPxrclXxGIqjTwI051EFiSnCIu8kKV
         cVDWEXdYuL+HF7Te5yv7obs185hGz7g/4+gLmBzdJixV2pEsaX6OTv+8Px9qPYf8Hbu4
         Pa6MeW9HaGcIlI2zXymaxXsbXJBGFQcs6G1lviVGMpDErJbv0PTyj+qdMnBEXmbmsRMb
         ehgDna4LCIRq9y7csXScI/hLhQU80pGT09l4dHG9DahS8n6hZOWqY3NYfHCCDy6OYtnU
         asPQ==
X-Gm-Message-State: AOAM5336qkOeGJ6ZgLfCveOl37R4MAGkNAyqLbvgOc+OIVIAGNlmQ3/8
        yq9GKTjQneCHYlezx1fSfdo=
X-Google-Smtp-Source: ABdhPJwImlJSPYKWVpuh9U8T9Mx0MLxz8gnFGfO6FCGYzNd68jzf5U1zp/9EinHurWlv8FJrGF5HOw==
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr40568203edt.194.1626780552924;
        Tue, 20 Jul 2021 04:29:12 -0700 (PDT)
Received: from localhost.localdomain ([5.176.2.85])
        by smtp.gmail.com with ESMTPSA id q26sm2804672ejs.115.2021.07.20.04.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:29:12 -0700 (PDT)
Date:   Tue, 20 Jul 2021 14:29:08 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+d04950c1e97f51d0068a@syzkaller.appspotmail.com>
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [syzbot] WARNING in pwq_unbound_release_workfn (2)
Message-ID: <20210720142908.3bbb3b21@gmail.com>
In-Reply-To: <00000000000015c36505c78382e0@google.com>
References: <00000000000015c36505c78382e0@google.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 17:55:20 -0700
syzbot <syzbot+d04950c1e97f51d0068a@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2734d6c1b1a0 Linux 5.14-rc2
> git tree:       upstream
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=1518d3bc300000 kernel
> config:  https://syzkaller.appspot.com/x/.config?x=f7dfeb6dfc05ea19
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=d04950c1e97f51d0068a
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit: Reported-by:
> syzbot+d04950c1e97f51d0068a@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 32 at kernel/locking/lockdep.c:6305
> lockdep_unregister_key+0x19a/0x250 kernel/locking/lockdep.c:6305
> Modules linked in: CPU: 3 PID: 32 Comm: kworker/3:0 Not tainted
> 5.14.0-rc2-syzkaller #0 Hardware name: QEMU Standard PC (Q35 + ICH9,
> 2009), BIOS 1.14.0-2 04/01/2014 Workqueue: events
> pwq_unbound_release_workfn RIP:
> 0010:lockdep_unregister_key+0x19a/0x250 kernel/locking/lockdep.c:6305
> Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 8f 00 00
> 00 4d 89 7d 08 48 b8 22 01 00 00 00 00 ad de 48 89 43 08 eb 02 <0f>
> 0b 4c 89 f7 ba 01 00 00 00 48 89 ee e8 44 fd ff ff 4c 89 f7 e8 RSP:
> 0018:ffffc900007bfcb0 EFLAGS: 00010046 RAX: dffffc0000000000 RBX:
> 0000000000000000 RCX: 1ffffffff1ad87cd RDX: 1ffffffff1fcad55 RSI:
> 0000000000000004 RDI: ffffffff8fe56aa8 RBP: ffff88801416e928 R08:
> 0000000000000001 R09: 0000000000000003 R10: fffff520000f7f8c R11:
> 0000000000086088 R12: 0000000000000246 R13: dffffc0000000000 R14:
> ffffffff8fcd1868 R15: ffff888047033870 FS:  0000000000000000(0000)
> GS:ffff88802cd00000(0000) knlGS:0000000000000000 CS:  0010 DS: 0000
> ES: 0000 CR0: 0000000080050033 CR2: 00000000014a53ad CR3:
> 00000000479f1000 CR4: 0000000000150ee0 DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000 DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400 Call Trace:
> wq_unregister_lockdep kernel/workqueue.c:3468 [inline]
> pwq_unbound_release_workfn+0x223/0x2d0 kernel/workqueue.c:3700
> process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
> worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
> kthread+0x3e5/0x4d0 kernel/kthread.c:319 ret_from_fork+0x1f/0x30
> arch/x86/entry/entry_64.S:295


I think, this should be fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a9a2e0482d647b07b4d45033f4be0854d3ea201e 

Unfortunately, syzbot didn't provide any reproducer, so no chance to
test it :(

 

With regards,
Pavel Skripkin
