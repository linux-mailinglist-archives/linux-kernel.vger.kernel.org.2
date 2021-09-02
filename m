Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F773FE77D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbhIBCQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:16:15 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55948 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbhIBCQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:16:05 -0400
Received: by mail-io1-f71.google.com with SMTP id o128-20020a6bbe86000000b005bd06eaeca6so316968iof.22
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 19:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0JUwZXH8tXwg/Y0mzczq64iCoCbtgnTNDv2GYMyLZD4=;
        b=AEBf/vHWodjfmsQd+E6toLXFjuqleC+MkdNIFaMeyQ13hLfdLfaOSMShf4P782Ieq4
         uKcWspSZwg8DixGtMdf0ILJ/SuuWS4iBMaObaRFZFW3LgOx4ytTk/0DVh/ABlIb8r6f5
         8l/rvdLMQPihYQGH6C5Hj0zo72iU8h7gowVWpjQZgHs9KFAjHzSr4pwgmF8gAqyZlxiq
         PCTA1sFhTuYgdapjBDCcSIJJ+5u9N75GE/gWB5R2NVTjTCauByQkunIb9USbWVW30abR
         gFCPEcr9poavNtasgY57mFZQ51JGHETLxKcvZjuk8Qc6dSNcnUx0QmKeI4rH32WsTfr0
         IeQA==
X-Gm-Message-State: AOAM531AdaGiyp7JWBSHXl4NMCXyiNx4U4x/3h7IAwW8i+O+nFuTR4Un
        APxCSEYXuVIyVo3fHHywoS25MuE1OjH9ZgFnkRzhmNOq2SsV
X-Google-Smtp-Source: ABdhPJzvo2XBa5Xt8glOx7p+H6enrDvMxXqgaVoutT9Y28986VCjR6HokMFItWtv9YD2/QfiZ32Yg5pL0uuNQzqyuUXRiLagRd+N
MIME-Version: 1.0
X-Received: by 2002:a5d:9617:: with SMTP id w23mr739002iol.115.1630548907681;
 Wed, 01 Sep 2021 19:15:07 -0700 (PDT)
Date:   Wed, 01 Sep 2021 19:15:07 -0700
In-Reply-To: <983049ea-3023-8dbe-cbb4-51fb5661d2cb@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e715f05caf9c044@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in xfrm_get_default
From:   syzbot <syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com>
To:     antony.antony@secunet.com, christian.langrock@secunet.com,
        davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com

Tested on:

commit:         9e9fb765 Merge tag 'net-next-5.15' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd61edfef9fa14b1
dashboard link: https://syzkaller.appspot.com/bug?extid=b2be9dd8ca6f6c73ee2d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12546ba9300000

Note: testing is done by a robot and is best-effort only.
