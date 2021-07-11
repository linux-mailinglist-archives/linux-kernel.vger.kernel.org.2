Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397A33C3F98
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 00:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhGKWH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 18:07:56 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50828 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKWHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 18:07:55 -0400
Received: by mail-io1-f72.google.com with SMTP id x3-20020a5e83030000b029050f93606dd4so10296206iom.17
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 15:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MLkBS3KT/C1xWdnQv4mpgem4i/D3ft2NwGzrdexe+l4=;
        b=t56DbUH7aSCNnIQpMsPKGGc2wHTAqB8gnsKA88a1m7pA4QCTbUT9bVW/2qaL/oNRgy
         MXolh+ci5tdpRpaORWDnjVA+jzwSryvVmJtbKXxjou7GC7YuIrREYwSueSu7XcRjltKO
         aLHM0Ek7M+W3rlQLPfiihbtLO3+ttcLCs/dyjEokXG/tQw4FG5u/44hDFhHjfeb+fUZV
         BF/1bWiDhknT/yL54nEO3rTFIgHOag+mgfJgQ0ysV4+7xF1jcif2LjU8x6Zy2I67uerY
         MieRgJxe7Trf7q2lVPKLXyoJly5GEy0Ohiy7OL0XV9mUNNWhbyRfMONF+JzV9jKpkoBG
         rHyg==
X-Gm-Message-State: AOAM531coTb/PaIIYHhQpkPfr7y6VuWmRToLO8YBmzVS3OmwKjCNafhT
        iRe0BMBo4sR0VohSlu/ChErQMI1PMqF6Ggtrorot0Am4TsWm
X-Google-Smtp-Source: ABdhPJxQEaFbT8ZPZ5vkDb06CFAtXVfmVLqYpkYhIJ+dgydxAHWEByp1j5TtQDHamkf8o2ezJNsadfWZyoW8JNFdcM3zJRUQhGhW
MIME-Version: 1.0
X-Received: by 2002:a5d:9958:: with SMTP id v24mr36817517ios.4.1626041108475;
 Sun, 11 Jul 2021 15:05:08 -0700 (PDT)
Date:   Sun, 11 Jul 2021 15:05:08 -0700
In-Reply-To: <f58dd424-b33b-ebaf-b38c-235bd42b643f@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9315305c6e032ee@google.com>
Subject: Re: [syzbot] INFO: task hung in io_uring_cancel_generic
From:   syzbot <syzbot+ba6fcd859210f4e9e109@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ba6fcd859210f4e9e109@syzkaller.appspotmail.com

Tested on:

commit:         66af6ccf io_uring: fix io_drain_req()
git tree:       https://github.com/isilence/linux.git drain_fix_syztest
kernel config:  https://syzkaller.appspot.com/x/.config?x=c650d78cfe48974c
dashboard link: https://syzkaller.appspot.com/bug?extid=ba6fcd859210f4e9e109
compiler:       

Note: testing is done by a robot and is best-effort only.
