Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248213EE519
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbhHQDdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:33:44 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54975 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhHQDdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:33:42 -0400
Received: by mail-io1-f70.google.com with SMTP id o5-20020a6bf8050000b02905b026202a6fso6691218ioh.21
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 20:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2+HkoneHNqETrotUNTZJ6m3XAQv66R/OQuXYnn+pD9I=;
        b=MiswoLyev349OtnG7bfLnzignLpDKXWVLryBv51vuiwQ5805+lYIR4MwL4grJzog/0
         NHTVwGdfHs/3nyHHS7TepRvH/2C8ekj5+LD/Eb0Yu9QK5F6NP4NsR3Ca8gKXO8sOa31m
         ViU1aewtwktar5/qiRYb6kjad2RYBzdSfI2I6Sf1one+t06paJaE1C8f/sYnAOSsg8a2
         ityIPGlEni1QQdZsBhUYd5HeTkm/H49CrJwEGTIy6e60+41OvOwCwozrxbI+e/TVi+Od
         thNJ8zJ/M01zHvo7Zr6MulATUzNo0egB6Z06LiPxwNRTDf3wWwSTz1GGifG/f7CyLUb6
         13aw==
X-Gm-Message-State: AOAM531KHENHtUa6O1ixoasNSeAryUL9cWl+ZOFaGX4L7PLRY5ZjJMZ7
        VDCGyiiaOaPqWos4QoNRHC9XseNX+UdHvScRsk0nlAjg9MvY
X-Google-Smtp-Source: ABdhPJyXBqIL3mBUbA0KhcVCXbRSKtEHCnXl+W/MPIhAJ1U6L/pF2ETxKqwEJbV7eqn1EbZC3BnxXHvqGSOZaH5BgvMOAVrZiGsk
MIME-Version: 1.0
X-Received: by 2002:a02:7094:: with SMTP id f142mr1044285jac.19.1629171190079;
 Mon, 16 Aug 2021 20:33:10 -0700 (PDT)
Date:   Mon, 16 Aug 2021 20:33:10 -0700
In-Reply-To: <8236fd18-bf97-b7c6-b2c7-84df0a9bd8e5@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010269e05c9b8fac7@google.com>
Subject: Re: [syzbot] general protection fault in __io_queue_sqe
From:   syzbot <syzbot+2b85e9379c34945fe38f@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2b85e9379c34945fe38f@syzkaller.appspotmail.com

Tested on:

commit:         16a390b4 Merge branch 'for-5.15/io_uring' into for-next
git tree:       git://git.kernel.dk/linux-block for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=605725d47562aa78
dashboard link: https://syzkaller.appspot.com/bug?extid=2b85e9379c34945fe38f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
