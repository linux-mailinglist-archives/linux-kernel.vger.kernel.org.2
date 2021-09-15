Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1394C40C2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhIOJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:52:30 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41976 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbhIOJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:52:24 -0400
Received: by mail-io1-f72.google.com with SMTP id s22-20020a5e98160000b02905afde383110so1373208ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OaUs54KYE2dDB55GtbB/YxbBBPa+RBaXGRBRYMoLDKU=;
        b=lD2doA+UZvWWAG88xaNU9YL2/qrCqEPoY5pqL5afYTk6MlC3WcL1U5OZ618v2dDkgV
         A7/fS/WPXBfeDFzXm+gmlgBHVW5c5reG1M3sTh+F62+T+OTnmzXv/9P3szXu/WGMI6su
         NIvzFTvvKF83dF0TGK0t5L/HusJZDEQljkDyWHybTXMdAXgySaKTvSRhBcp4GAHCHBZr
         O2zRE1Xy+A0139X7AT+2JwlfX6dvU9KWDuFsVGLGTS3tAq7bVrNnyK/0/BtQbpV2lZgT
         KaOJZrMrKNuWwdvZwQiPfdt91JJmGJ3/n60AZWStO417XIVZmI4XlsTMj6s7mzIZv4Sx
         RcKA==
X-Gm-Message-State: AOAM530DIZGLMrdwvrT+GhvdZqy+P4s4fteTkJo+0MTZSdFO4eUvtODW
        6qTFPXbJpc5g41+ac1xPVijgCmvi8g1qjGDA1w6GdGCB/c7V
X-Google-Smtp-Source: ABdhPJxjyFHohDbIEXYdADd0QU860qw30kCuDJ3L5SMpqY/Ye8pmCqxqNT1+TDyRuqO1aqUby62HwN40PgfqFyKNbZdzfBLlMBT7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dce:: with SMTP id l14mr10147510ilj.272.1631699466084;
 Wed, 15 Sep 2021 02:51:06 -0700 (PDT)
Date:   Wed, 15 Sep 2021 02:51:06 -0700
In-Reply-To: <000000000000a5339205c9e53883@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e753105cc05a31d@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in h4_recv_buf
From:   syzbot <syzbot+a06c3db558cbb33d7ff9@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org,
        stephen.s.brennan@oracle.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 0766ec82e5fb26fc5dc6d592bc61865608bdc651
Author: Stephen Brennan <stephen.s.brennan@oracle.com>
Date:   Wed Sep 1 17:51:41 2021 +0000

    namei: Fix use after free in kern_path_locked

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b29973300000
start commit:   7c60610d4767 Linux 5.14-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
dashboard link: https://syzkaller.appspot.com/bug?extid=a06c3db558cbb33d7ff9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147f96ee300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112b3629300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: namei: Fix use after free in kern_path_locked

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
