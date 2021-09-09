Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4951F4042AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348960AbhIIBQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:16:28 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40593 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhIIBQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:16:23 -0400
Received: by mail-io1-f69.google.com with SMTP id i26-20020a5e851a000000b005bb55343e9bso254696ioj.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 18:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pKMCZVg6cR9WvW2VYzENzm73CCK4MaLG6KWqwM4tTuM=;
        b=6FcNYNw3fjCm2Ciqj7ghsBYQGxse63OZd5dBiVb5rJwImA7tWZZk7xzLSHy0fWoHsE
         svxRRAzGEI+RR8lVx0p1qaI32bBcQ9YQiiWb/LqEuX105NFf0snPzx3PavkuHcm6HCl5
         oR77JWbr8MWQRlRIEtQ2/nGk7mm39NylhJg7TKtm23/1Y/10+kKBp33T6FWa3mRKd9Hz
         QZzPDh+jBcM+qJPG+ASSl1zwcJN5pO5FtW1SUuQfs+4MeiilKZS5Ab2QFpNxdLu9fOf7
         hRKv6dOkxNR58KobCB7h4ZgYbcZyVWhvy2kaTXUAtIXknaAI/m3F/qxhhODv44Oays34
         hDTw==
X-Gm-Message-State: AOAM531t8EkMC5uaFWwhHvECGPBbVuxSIReqMgaMk2/iPnUNJ05WF3UI
        NzJQTi3nfkHE00+64tM+vmUY2eYmJkImHEFrJK7hezIycN8n
X-Google-Smtp-Source: ABdhPJzK8JlpHcQNND2R0juetArIP0azEXM9Eh+omcDscivIcYmXECYKvxpKS3o7G98SXfgzw05ubafLATGIlGlGe56cfOT7ZJCu
MIME-Version: 1.0
X-Received: by 2002:a6b:6f18:: with SMTP id k24mr378847ioc.196.1631150114505;
 Wed, 08 Sep 2021 18:15:14 -0700 (PDT)
Date:   Wed, 08 Sep 2021 18:15:14 -0700
In-Reply-To: <1ec6e8e0-d253-5f84-982e-4146db278655@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026886605cb85bbf5@google.com>
Subject: Re: [syzbot] INFO: task hung in io_wq_put_and_exit
From:   syzbot <syzbot+f62d3e0a4ea4f38f5326@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f62d3e0a4ea4f38f5326@syzkaller.appspotmail.com

Tested on:

commit:         cee36720 Revert "io-wq: make worker creation resilient..
git tree:       https://github.com/isilence/linux.git syztest_iowq_workers
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9bfda6f9dee77cd
dashboard link: https://syzkaller.appspot.com/bug?extid=f62d3e0a4ea4f38f5326
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
