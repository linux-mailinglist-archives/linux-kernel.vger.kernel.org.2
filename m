Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFDC4385D0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 00:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhJWWd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 18:33:26 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50164 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhJWWdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 18:33:25 -0400
Received: by mail-io1-f70.google.com with SMTP id l17-20020a05660227d100b005d6609eb90eso5969828ios.16
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 15:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=y6UVuCPrdtTddXTos1RIRLhbRs6e5xn4XnoqoWxYGdQ=;
        b=3f4QEtVA6HiEecxX5kybv7/qzYk92tyqm45ZqF13zm+kSi5EjHdWo4kEOeu6qrnR0S
         XlNhOsvNIJVkiTpYeJAmhpT/6y1VNtptmNmRLw0XsYBUiBDyb18z5XkdhkR1QOthKbk8
         QI2FYws3f4uZmZWR3M8UueLreHvo27A/Ng2vxRquP7ngIO6D/hOpHUe722HpWc+Hc1La
         welS30ph0cHZt0EFMd5u1L48ZZNmI324F8mEMijbHxWatKDF/kVtoKgodRxzznhpaWR+
         +eIi8iHf8cmfByi8M5fctWDc7TZmmVbeOY8upp+t/iWFZIiLPh80B9Gp+zF9V9FpIGUA
         nLbg==
X-Gm-Message-State: AOAM530ShjU+7YvTaVqWhyUSrV3EYvSk7xjEsdvfdz/WmTXVED0DlPln
        tRws7SQv2OJAgAmmhqkPiymR9qJjMVX97XS/ywPc8UjnhEe5
X-Google-Smtp-Source: ABdhPJwP6tTurFlZ9o0vQaqQm5mJ3oifEukw7svE5mRW0VVfKPNpcyTBnnnGAQbbppoLu024rpggCzziglm1vUsKV5ACLvnAwZPy
MIME-Version: 1.0
X-Received: by 2002:a5e:db06:: with SMTP id q6mr5382107iop.43.1635028266212;
 Sat, 23 Oct 2021 15:31:06 -0700 (PDT)
Date:   Sat, 23 Oct 2021 15:31:06 -0700
In-Reply-To: <00000000000062d0fc05cef24c57@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001612405cf0cafeb@google.com>
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
From:   syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com,
        fmdefrancesco@gmail.com, jordy@jordyzomer.github.io,
        jordy@pwning.systems, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, rppt@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 110860541f443f950c1274f217a1a3e298670a33
Author: Jordy Zomer <jordy@jordyzomer.github.io>
Date:   Wed Sep 8 02:56:18 2021 +0000

    mm/secretmem: use refcount_t instead of atomic_t

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141a071cb00000
start commit:   9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=161a071cb00000
console output: https://syzkaller.appspot.com/x/log.txt?x=121a071cb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be398dd7862f4b36
dashboard link: https://syzkaller.appspot.com/bug?extid=b904a1de3ec43711eba5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130cabdcb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175b91acb00000

Reported-by: syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com
Fixes: 110860541f44 ("mm/secretmem: use refcount_t instead of atomic_t")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
