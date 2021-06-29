Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0AC3B7410
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhF2OSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:18:36 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:50761 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhF2OSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:18:33 -0400
Received: by mail-il1-f197.google.com with SMTP id f7-20020a92c7a70000b02901ee10b89a7fso13180671ilk.17
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Kg5nOcsBqEKYMddrauP1mweIcVDvq/YayRMorfAz0/k=;
        b=JT3yeq2K+jTZrUukrwp8snE34eyQOrKaQjQaYdjjIZCYmFKV6CzVepmO00BQlNCBDT
         /Ju5gYlvBmBh+45M0xzu+kWCijbHrr8r0gXTaqsINEQ2Jgj7Yp/+jEbklDbyjQ56JfTJ
         QmcvxBjrr/TtLeCfcwAgHlr7kVuvdnzFAjc2rSlNifCSP8BIlrRT6MKrFas1NmYNgZ5s
         afMoOQinOvJMzpQXQGFoz1DwylLWiQunWt+273nBP1Szcpjwx+OgL1AxKYmkCxZdSZDI
         xVkd/bzBXh2HXF4/wxJ3HoC1fXj5yw3/KBBw3xN4e4wSpe411s7i9rhaX8+4jYjynRbW
         8eDw==
X-Gm-Message-State: AOAM533qEOsqaoaU81AToqkNro03Q/8r+65zQ161NpGZPsX43XoIAaKU
        iupDv31/e7O0wzTH9BS/F5+4dcUP0doTTjaWUPSBMTx0+1eq
X-Google-Smtp-Source: ABdhPJzJJf9qa4qerHgm/jHnJPF8RRfdFjLMgduFLh5UyYNe4icnAd2Po5OJYIXgHcUJm5omlKixZQuHnfviK/tbAWnI/76uJhaY
MIME-Version: 1.0
X-Received: by 2002:a05:6602:140e:: with SMTP id t14mr4119513iov.42.1624976165142;
 Tue, 29 Jun 2021 07:16:05 -0700 (PDT)
Date:   Tue, 29 Jun 2021 07:16:05 -0700
In-Reply-To: <20210629095543.391ac606@oasis.local.home>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001785c005c5e83fac@google.com>
Subject: Re: [syzbot] WARNING in tracepoint_add_func
From:   syzbot <syzbot+721aa903751db87aa244@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, mingo@kernel.org,
        netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+721aa903751db87aa244@syzkaller.appspotmail.com

Tested on:

commit:         c54b245d Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b55ee8fdb0113c34
dashboard link: https://syzkaller.appspot.com/bug?extid=721aa903751db87aa244
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17938e5fd00000

Note: testing is done by a robot and is best-effort only.
