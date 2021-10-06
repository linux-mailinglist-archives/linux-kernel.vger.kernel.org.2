Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA16424A23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbhJFWvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:51:01 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:47631 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhJFWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:51:00 -0400
Received: by mail-il1-f198.google.com with SMTP id i2-20020a056e02152200b002587ac62443so2746980ilu.14
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ALMwBzPbcoiTV5PvRTqV3OLyZh+7yR20m1kSW7tZ0Q8=;
        b=Gqd/YSwMGoODuTxJVCYj0ND+DaWLzF1G8zYVfEKoKXXUT64ziExvxCk5zVQHlnyPq8
         CE+OnPsWoBUW7jA5Nc8hB96HS+ixSPiSvlhhY4/x3PpBwopm/9EeIxBZNXqvS7a52nR3
         XDw5U1kDm0zzhcmpt+/1RikdPYOce1q6xIT45twJiKP8RJSj/ZBKSQvf9C+2GiSoXE8I
         PoB6oA5pUY5KVs0d6XDcvnHDHEWDKpQvQUbeLQwj9NB4WODHGnrF3OBA2H8XmLvGzb5y
         Mbb4qSyBpoGrjtPIfoL37hn8rfU2StcRPgdLaZP5Fjr7UZ2QnHrLxP1WZyyQhh7Y80fN
         noVQ==
X-Gm-Message-State: AOAM530WSe4Bxv/MHelNIDJODBUj0ZZfqz2abbi36Udg4ZVt3QpiVfKW
        cMs0RJKmEsZ/zGUbYBc9PVjr3DpheYzn7L8kTzdPznSnIBdh
X-Google-Smtp-Source: ABdhPJwgwn/+rLH5RBRah4vMGortYwfLv2GVM+OBafmkhb+7f5XXAOfDEsT5zmnO/gT3pUMne6hbUFquDJ/YSRFvAwQE1LhtB5Xz
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d0e:: with SMTP id q14mr262061jaj.139.1633560548022;
 Wed, 06 Oct 2021 15:49:08 -0700 (PDT)
Date:   Wed, 06 Oct 2021 15:49:08 -0700
In-Reply-To: <00000000000084943605c64a9cbd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f208405cdb6f447@google.com>
Subject: Re: [syzbot] general protection fault in rcu_segcblist_enqueue
From:   syzbot <syzbot+7590ddacf9f333c18f6c@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bp@alien8.de, hpa@zytor.com, jack@suse.cz,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        paolo.valente@linaro.org, pbonzini@redhat.com, reijiw@google.com,
        seanjc@google.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 067a456d091d05fdae32cae350410d905968b645
Author: Sean Christopherson <seanjc@google.com>
Date:   Tue Jul 13 16:32:43 2021 +0000

    KVM: SVM: Require exact CPUID.0x1 match when stuffing EDX at INIT

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d871b7300000
start commit:   0319b848b155 binfmt: a.out: Fix bogus semicolon
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=faed7df0f442c217
dashboard link: https://syzkaller.appspot.com/bug?extid=7590ddacf9f333c18f6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1308d0ed300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: KVM: SVM: Require exact CPUID.0x1 match when stuffing EDX at INIT

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
