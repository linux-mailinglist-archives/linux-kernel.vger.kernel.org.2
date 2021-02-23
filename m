Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE39323436
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhBWX0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:26:19 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:44541 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhBWXRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:17:53 -0500
Received: by mail-il1-f199.google.com with SMTP id a9so166021ilm.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gxwmyLE4SO4oZCr9Sp7tYxHthtIvfwFjtggaVC9TLEY=;
        b=mNQABjCZsszLfNcadDXKlORVcOrhT6yAOdriakgQ6GNcKdzTt1qqo6olh7V93MVqw1
         oJ/KBv+UR+qsv/pUg/WnAgGIY0+Hts41a2dVjrQjefu9nMapJNQRNrNWnld33dPXsaSl
         yKuj3T8/2dYdncii7vBGxJyBJf/rUHxUTZE5n+56WwIgyNSI/wkWaGUUUuHowaW3VtJR
         QYTg3gGcRiGyyqKA/T4xTVPyH0+WfO+UAHJsbU8mIZ8Ozzbkl1EPIQGk1UnmRchyOdwy
         O9emIAQ2XBwesJ4likOMIT4zYf9QqmPr19b/G8MaHVpkmgIOe0OnWJq6ldGZbUgktLLb
         XTPQ==
X-Gm-Message-State: AOAM530ngbNuCl5G9LRkNLjFkCk6Gf/fqkgpGfqWYeTlP5zOf7wqOsiq
        r2pguBcoDOR7k4t3+e1UzOd3VotL25Id+VU1tdZSy5ZAhHRl
X-Google-Smtp-Source: ABdhPJxYMQRLjCGcu4le9+pAKne7p4M1hhMXnq5Lth1vDibAlbh+oMC6vk0slJxcCfpjngyHErXn1JGb1zpfvJVCqGsT9oaRHYFP
MIME-Version: 1.0
X-Received: by 2002:a02:1909:: with SMTP id b9mr23360492jab.141.1614122227911;
 Tue, 23 Feb 2021 15:17:07 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:17:07 -0800
In-Reply-To: <0000000000007ff56205ba985b60@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004e7d105bc091e06@google.com>
Subject: Re: general protection fault in vmx_vcpu_run (2)
From:   syzbot <syzbot+42a71c84ef04577f1aef@syzkaller.appspotmail.com>
To:     bp@alien8.de, bp@suse.de, dave.hansen@intel.com, hpa@zytor.com,
        jmattson@google.com, joro@8bytes.org,
        kirill.shutemov@linux.intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lstoakes@gmail.com, mingo@redhat.com,
        pbonzini@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 167dcfc08b0b1f964ea95d410aa496fd78adf475
Author: Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Tue Dec 15 20:56:41 2020 +0000

    x86/mm: Increase pgt_buf size for 5-level page tables

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fe3ea8d00000
start commit:   a99163e9 Merge tag 'devicetree-for-5.12' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10013ea8d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17fe3ea8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49116074dd53b631
dashboard link: https://syzkaller.appspot.com/bug?extid=42a71c84ef04577f1aef
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141f3f04d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17de4f12d00000

Reported-by: syzbot+42a71c84ef04577f1aef@syzkaller.appspotmail.com
Fixes: 167dcfc08b0b ("x86/mm: Increase pgt_buf size for 5-level page tables")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
