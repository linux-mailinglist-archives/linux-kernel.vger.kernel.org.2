Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1673C6F14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhGMLE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:04:57 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:38861 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbhGMLE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:04:56 -0400
Received: by mail-il1-f199.google.com with SMTP id s7-20020a92cb070000b02902021736bb95so13494313ilo.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 04:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QhU+r1WicMQK4omfjynROwaD0hxIgZ6hUq3jENUSY5o=;
        b=roLnSZQXgXdJhiaX00X2vebZMwlc+Dw4d9VHfZs4goe3IXFco1GF41NedKVo6Dk+aE
         Io/H/Zg/9fO4PmC5SY9lU5zPXkAIA2CnR7MN5DJiUQXibaSs4nnhZusmUnR6jJqVlhPU
         1Uop95aEtkvjhYvND4aJSjo01fLIgNM0JI80Jf8ts/OtO0CA819i7zasxtqA7SWaHkPG
         Fxkdcpb2W5g35VT06qLGRxZ87Ug5yxrSP5RPx34Gzskv04VC0GGxQkVbGbfPutiP5z7G
         2dYyQQz2PK1vXURtMzKJec+N/hTOaurZ+FEMHLlURH+WNKqPFP6T32+Mce4P31fmJdou
         XMZA==
X-Gm-Message-State: AOAM530bY0DumCRuEXnlIsRr9aoJSNJFOEMQu0T2P3AcLRmBHz5wQECD
        lZqHp0Aj7TpkbyfXr7+Jop27yfG63sA+X/hJN5AHYzbvHsoW
X-Google-Smtp-Source: ABdhPJzMq+q3vPQW5aNE1RNIzO4Gb0NMwpl4gl/8IWFtj5s9PlEpBuPn/bgSJCJIL5wYoiNxnDx4exNYoDCYFAHZLFI3aqNtw0vS
MIME-Version: 1.0
X-Received: by 2002:a6b:da10:: with SMTP id x16mr2725486iob.48.1626174126826;
 Tue, 13 Jul 2021 04:02:06 -0700 (PDT)
Date:   Tue, 13 Jul 2021 04:02:06 -0700
In-Reply-To: <d4edc90a-23bc-34b3-4490-03cce2846283@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c2e2305c6ff2b5e@google.com>
Subject: Re: [syzbot] kernel BUG in io_queue_async_work
From:   syzbot <syzbot+d50e4f20cfad4510ec22@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d50e4f20cfad4510ec22@syzkaller.appspotmail.com

Tested on:

commit:         66af6ccf io_uring: fix io_drain_req()
git tree:       https://github.com/isilence/linux.git drain_fix_syztest
kernel config:  https://syzkaller.appspot.com/x/.config?x=77d8505826d1a1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=d50e4f20cfad4510ec22
compiler:       

Note: testing is done by a robot and is best-effort only.
