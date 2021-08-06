Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACF13E31A5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 00:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbhHFWUY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Aug 2021 18:20:24 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:57280 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbhHFWUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 18:20:23 -0400
Received: by mail-io1-f72.google.com with SMTP id k24-20020a6bef180000b02904a03acf5d82so7000485ioh.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 15:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=TjZwUUDBCQTtiiphMf5lNNvkaUWGIfnKKUGZRCHod4s=;
        b=ZZQ/3VlKYVAxO/F5phjZPXQPOhspRBDScW5Tth3gB/Nrxt2O8S/Cm0i6N+X+np/rwm
         0WioAL/RnBqMFj/I/xTnxFMkP+3FaN/ePm04wH42US5e2uJZ2fX70s/0s7hlQC7UK+Cn
         45LKfuMx84aY+LXOUpwNSPZYwoBL0MM5GrhRpvs1+uD1szBxPIuSS0yRAYPRKjcfjR7E
         OR1Kf32Jz4bmYvE3uoWPSsnTKjIn1Sm2SWhTg+AVNXGg9EK+zP6NgP5cTuONSWmy8wkz
         X0W5B5fYzq55D/+jt6O3axkCJyULyabe+a8LjLJK6VfIIczMTqC92F2+8SUFEtcxsXh8
         5Daw==
X-Gm-Message-State: AOAM532PfDzpqGsZUYaloKtqU1t1fy4NHbZnkiRHuZ6eKlBNhzT6K0OG
        PV3ho1epYMd5RqcXzHLXPgfP/wShGkP5uPFN5pcm3GescD4L
X-Google-Smtp-Source: ABdhPJzpIVDaCuynJVK3t71sYw7TX40yeX/4nyImc7KlRSQjfeTEFmrDpDfvonESvtNNCm06n335BFZZQFgOc40sQxqK3J4I4gE0
MIME-Version: 1.0
X-Received: by 2002:a92:c266:: with SMTP id h6mr517881ild.273.1628288406528;
 Fri, 06 Aug 2021 15:20:06 -0700 (PDT)
Date:   Fri, 06 Aug 2021 15:20:06 -0700
In-Reply-To: <000000000000b8a3e905c69535e3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000102b9305c8eb70da@google.com>
Subject: Re: [syzbot] kernel BUG in __tlb_remove_page_size
From:   syzbot <syzbot+2f816ba9b71ca9a8e6b0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org,
        aneesh.kumar@linux.ibm.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, npiggin@gmail.com, peterz@infradead.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        toke@redhat.com, will@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit af0efa050caa66e8f304c42c94c76cb6c480cb7e
Author: Toke Høiland-Jørgensen <toke@redhat.com>
Date:   Tue Jul 6 12:23:55 2021 +0000

    libbpf: Restore errno return for functions that were already returning it

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b872fa300000
start commit:   3dbdb38e2869 Merge branch 'for-5.14' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=2f816ba9b71ca9a8e6b0
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151ee572300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: libbpf: Restore errno return for functions that were already returning it

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
