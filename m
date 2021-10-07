Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724F64253E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbhJGNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:22:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56164 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbhJGNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:22:00 -0400
Received: by mail-io1-f71.google.com with SMTP id p125-20020a6b8d83000000b005dc38ac1126so3577250iod.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ta8TFCyBY1gpWCj21ajzUB9frfUQOUQio86Er8sxqeo=;
        b=o+DQEZ4JlsxwwMm9tbkcIDcQj+NsursEXUi9xULvZi55jOe5/FAL/kiQeCp5Be75O0
         d1GNgVQC4TkJoQhqGeK2XzEC8zaWz/6jroWrSoprIJujDjFD2562XaeELgldw6Ogjwxb
         VAF07toTXT4hNnQ5uITzWiD3sg1/V49WcKFjJlL+gPZXZ5BPHRH1XGT8PKDVU+7a61mi
         RADHtCJWBx0ay8Uaid7K/GJPiWnmF3kP8cdAbYPVHbLcA8sYlG8tu74D0YorwoEji/mg
         YSFeA0ZKtnF8PlejZTOyL5jdknNodRgnQTFVH2L3pmHY2m6iHABYSkWRywnkYBiL0Yl/
         daEw==
X-Gm-Message-State: AOAM531aXG5kkevkGgehCV9jAG8nLik6djRvHMIjIDlmqMP0hIGx3Ubj
        kiOj0fWP3648PRWt7BMWDUjinV8h7qgfGhv0mosNspjFZDgC
X-Google-Smtp-Source: ABdhPJxX+LmOXMIhLmy2MtMP/zvk5EDCKJa7XQPxqftj0hiiK6+wuzEnrRmw2/+EERMeZYDiNCg0lWg48DkTd7v/EVqDJLrP+z0T
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c2e:: with SMTP id q14mr3187493ilg.109.1633612806720;
 Thu, 07 Oct 2021 06:20:06 -0700 (PDT)
Date:   Thu, 07 Oct 2021 06:20:06 -0700
In-Reply-To: <0000000000000845ce05c9222d57@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b920e05cdc31f01@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in nf_tables_dump_sets
From:   syzbot <syzbot+8cc940a9689599e10587@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a499b03bf36b0c2e3b958a381d828678ab0ffc5e
Author: Florian Westphal <fw@strlen.de>
Date:   Mon Sep 13 12:42:33 2021 +0000

    netfilter: nf_tables: unlink table before deleting it

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13018e98b00000
start commit:   f9be84db09d2 net: bonding: bond_alb: Remove the dependency..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=8075b2614f3db143
dashboard link: https://syzkaller.appspot.com/bug?extid=8cc940a9689599e10587
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fbb98e300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfilter: nf_tables: unlink table before deleting it

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
