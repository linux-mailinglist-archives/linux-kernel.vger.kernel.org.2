Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9A3E516A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 05:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhHJDSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 23:18:45 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:53054 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhHJDSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 23:18:30 -0400
Received: by mail-io1-f70.google.com with SMTP id n22-20020a6bf6160000b0290520c8d13420so13673463ioh.19
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 20:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5BRXu3w+C12fxdxN1C+eVxxxv4+y9P7u8pANMPW2JlA=;
        b=Rv3e6ih6lT9+kiqGDZlyjPXw+RTjRgJFFbkCvyvUt5MtjT51gSKdlAEsRjzb8ZZf/J
         XmU6B2Ws6mxiGI1roVpMRW4+323U7OFAmghSTfkbQKAsM71l4+Ecg1CU7Ro5GvobjsG3
         ULcxKQtEMXAmzR2YgLzi4PYeLCN9xO7+DBs7Z5nraPoeori3p7hzt+xKfYphAxokqVe8
         IpWZgxu+tqB40NaIRpkstciC9xYcDl10tyBjBiyWnVI6fK0jYXzfFcpnEBaMbBRNL4Xd
         jNjZGzgNeW6wpU6Oo0xI8zExaMutUKenJNBdH7kXiYeMa10stQkKyQdWZwvUy7yy0ajd
         q9ag==
X-Gm-Message-State: AOAM5328vP6+KPWa1fOTF9XfJhuo3NvF7AeGDc6sYYFnexGeGG4sYeKs
        Vk+4wyrdDMW/642dHar+w6uMz2ANvcfh1bcY/MmQo53jMFEp
X-Google-Smtp-Source: ABdhPJzSejOHZF2vwRQa08jvFtWilpXHY4p8/eqRrMxxZV+P6Xpydk/aba2JEJl1ObwHXQ0rqs6Y+cSJYd76Qvyoc+6FLgQKYkyI
MIME-Version: 1.0
X-Received: by 2002:a6b:4015:: with SMTP id k21mr139228ioa.28.1628565488642;
 Mon, 09 Aug 2021 20:18:08 -0700 (PDT)
Date:   Mon, 09 Aug 2021 20:18:08 -0700
In-Reply-To: <2d002841-402c-2bc3-2b33-3e6d1cd14c23@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071b06d05c92bf331@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in nft_ct_tmpl_put_pcpu
From:   syzbot <syzbot+649e339fa6658ee623d3@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+649e339fa6658ee623d3@syzkaller.appspotmail.com

Tested on:

commit:         9a73fa37 Merge branch 'for-5.14-fixes' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3a20bae04b96ccd
dashboard link: https://syzkaller.appspot.com/bug?extid=649e339fa6658ee623d3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d6baf6300000

Note: testing is done by a robot and is best-effort only.
