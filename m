Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978CC439081
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhJYHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:44:30 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36506 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJYHo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:44:29 -0400
Received: by mail-il1-f198.google.com with SMTP id c17-20020a92c791000000b0025929f440f0so6121755ilk.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 00:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FRp5DFjNkB5DYili8ZiV7kEXz8tHdesF7it/j+y3PY0=;
        b=GHESFR7tpvWAAH0nbuQOSd3NlTa/+dwoD2jzBm7fTIYfjBRVjERLOOEXhxo16aFn2F
         wg5/83s3wkUNxxvxjriruVpb0hvFtwEL1AXa7wLMY/zQJOoa1gDpwmo4LN6R+wJP9toO
         E+qtGovZZ3X64GyLfqbXZhgmnz4mOtWUJkv1DliTWIynA+AFWuzJE+n9hySBxnzYfPPx
         X33TXlGPzxVB0/yIlz0PLsYFKu3mrwbMTfgpIDQkEf8E6oNaSTP5/PY5Zr3z1VRILeSo
         6jB1hZihrKDrxo3OBwLadAZy+oEJHLbeclLhPUh52+R+doz7YgD2C5AccDZSqPFga5NO
         1eWQ==
X-Gm-Message-State: AOAM5300n4WBtEvDwvz2rpq/AM+rSw26E+iZDyJ8n4uz4iGiR2IUuccO
        vkz/jITJQWV5T2gLehNElgSzYseHftiQlDeckLdLOSzb8kvv
X-Google-Smtp-Source: ABdhPJyY3BE6Hexn4GAHUITeNQNHgSQLr4zZ1XijU4QpLsYOvdQlTqckWVWab9qr7zgTSAsIBnAEP48S7JkF97KWJ3GsV36XpeUH
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1607:: with SMTP id t7mr9303589ilu.296.1635147727196;
 Mon, 25 Oct 2021 00:42:07 -0700 (PDT)
Date:   Mon, 25 Oct 2021 00:42:07 -0700
In-Reply-To: <000000000000d5efd605ccc6a5df@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f55c405cf287f25@google.com>
Subject: Re: [syzbot] general protection fault in nf_tables_dump_tables
From:   syzbot <syzbot+0e3358e5ebb1956c271d@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13efcb0cb00000
start commit:   9bc62afe03af Merge tag 'net-5.15-rc3' of git://git.kernel...
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=e917f3dfc452c977
dashboard link: https://syzkaller.appspot.com/bug?extid=0e3358e5ebb1956c271d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14374e5f300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfilter: nf_tables: unlink table before deleting it

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
