Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7043F1F05
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhHSRZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:25:46 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37788 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhHSRZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:25:43 -0400
Received: by mail-io1-f72.google.com with SMTP id h3-20020a056602008300b005b7c0e23e11so3725570iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IP7asdtdFlXOxOEQ1U/M8uS3b6zpj0naPI5qY7HFuyk=;
        b=keJkcNOAC4UmaK5IkiS8Hlg/HakXZlr18B7je+zGYPzTVdB85L/cdhNfUWGxKKZSek
         SE9ymAzFkX82T84WP+eGkV4hO8B2zO1kXKAXUE6jrgwgV0TrISP+cHEgymPLo0u+HqJw
         IKvFKY3KTmksxv6zjyye/bCBJD4IbhPZGgJvcYJEIQXiE90OUMzhJhKSMakuUWBD1dXl
         OiUDHxbtQzOGSTORwTR2kTBzPE6O98sLNxSTwQAKaTSTquz79j5ciqxaZLFPV3sjhHJ9
         RqUSX00A4ZqGTvfv5S3idwV2Uztb8QCaBR1I20/bTOAcvnm0RxKF6PmwykXxk44EdpgE
         VMng==
X-Gm-Message-State: AOAM532TVcgrUF0Zcn0RE1o0dU21RWIsbCYJOM6HBD8jTUFZCKvu+Ejr
        b2KkBibyqYxx7fwQaQ/gMqt2oA2pvFp+8+QwExrvNdlXY5/L
X-Google-Smtp-Source: ABdhPJz8Eh1WAR5J1R4msOtBq6GuxBX1ajRoAfCtPA8fNLrLBK7DYhscYHz2hkMGcWd3N5eUqC3mwBzGD+WrIO8BgUyaftSYHgNl
MIME-Version: 1.0
X-Received: by 2002:a6b:fb03:: with SMTP id h3mr12381959iog.198.1629393907150;
 Thu, 19 Aug 2021 10:25:07 -0700 (PDT)
Date:   Thu, 19 Aug 2021 10:25:07 -0700
In-Reply-To: <da19f91c-1257-e6b8-7fc7-7f852a489cd8@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008f3c605c9ecd545@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in tctx_task_work (2)
From:   syzbot <syzbot+9c3492b27d10dc49ffa6@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9c3492b27d10dc49ffa6@syzkaller.appspotmail.com

Tested on:

commit:         923ffe35 Revert "io_uring: improve tctx_task_work() ct..
git tree:       https://github.com/isilence/linux.git syztest_ctx_tw
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb4282936412304f
dashboard link: https://syzkaller.appspot.com/bug?extid=9c3492b27d10dc49ffa6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
