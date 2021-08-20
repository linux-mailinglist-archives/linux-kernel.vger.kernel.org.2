Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA50B3F3604
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbhHTV35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:29:57 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55989 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhHTV3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:29:53 -0400
Received: by mail-io1-f69.google.com with SMTP id f10-20020a6b620a0000b02904e5ab8bdc6cso6192035iog.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=irP4+a4MqOno9gjzxCYV4LkdM8U6+CH4E7PsJC0/pm4=;
        b=rnOS5WQc+FYUopmq04BL4wfHMOcssqSV45egvXTzk76sRjrrID32aO+kGl6wImJMyX
         zQdmXbM6zWFspFFBqPHnIS6dXFCOY1znyNYIau/3/m28/WqCRluDVvyir1iOBkS+Esl/
         zRQx9tFxdRDv7BU4WX1jpgZ2AQyP3m6V8RMayVvT/4W07Ul5Mck34LVjOjZU6W4W2ev9
         ISUZPlVwpvRN7/uFZscs31tnLMnx8yCkzyO1s52JlHGGcytM3Z4wCRRIi5WtH6RQLitC
         e8SMglb6SYUlbN0SxokHIw8l99KckbWhs3IAkPM66kuCmtNL6MPbRlb0eWaJMsVyGxjO
         MBOA==
X-Gm-Message-State: AOAM533D2RYnsvR8xVpOnRA6QLnP4kml5+BkRiY+uY+GowRdancLjquY
        U9z+kSC/S7s7AQYJ0P9BFfwRG2VkTUAuqYtN/EEK7ef9Klci
X-Google-Smtp-Source: ABdhPJzwQnqnBvNJw3VYBFYSQJOZJNIfjhdUk4XZi5YP/GetgfyT4o7ZYLOJzWzalZHwhX6L41qpYmxt/NbXjWGg30XqrAwCrd24
MIME-Version: 1.0
X-Received: by 2002:a92:7108:: with SMTP id m8mr10061663ilc.238.1629494954973;
 Fri, 20 Aug 2021 14:29:14 -0700 (PDT)
Date:   Fri, 20 Aug 2021 14:29:14 -0700
In-Reply-To: <0000000000000845ce05c9222d57@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f460a305ca045b3e@google.com>
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

syzbot has bisected this issue to:

commit 6001a930ce0378b62210d4f83583fc88a903d89d
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Mon Feb 15 11:28:07 2021 +0000

    netfilter: nftables: introduce table ownership

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d34475300000
start commit:   f9be84db09d2 net: bonding: bond_alb: Remove the dependency..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d34475300000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d34475300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8075b2614f3db143
dashboard link: https://syzkaller.appspot.com/bug?extid=8cc940a9689599e10587
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fbb98e300000

Reported-by: syzbot+8cc940a9689599e10587@syzkaller.appspotmail.com
Fixes: 6001a930ce03 ("netfilter: nftables: introduce table ownership")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
