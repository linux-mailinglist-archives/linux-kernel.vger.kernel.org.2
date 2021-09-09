Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9435404273
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349022AbhIIA5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:57:19 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:43744 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348847AbhIIA5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:57:16 -0400
Received: by mail-il1-f200.google.com with SMTP id i5-20020a056e0212c500b0022b41c6554bso301867ilm.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 17:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1rqEkrZfLlbZFMVjLu3WxnoW6fuQQaO6COqDb9D7ihA=;
        b=ZXk6T3dmQm9QcnbZ6pG+ZVy9WV0HBW0g+XSnHVYvZiZScDAt4b+1DMpH7BcPva6Zh8
         KBA/Y/pWBfpsvYk/kvtCysU2rVHITumxANQrxpzt51Njw5UmrzfVtwJDbA8i9GzIMofG
         tKhR50CgAl6uj7TFjjdoKWpz4O4HPgid6zdGarLfLNl+XEFtjaIPo2h9W9qXfnFhqRIt
         QWH8NaeCraX6WCN26WWXQ3eLveF3AQCS1B0L1oiBSstJNRNwVXXSYykulP8fl55cGQby
         iV1rXijLZLazzSzPp4PwC03opSRcqYq0yLmP3pFnyzEPgopFv96ck2f27gYR/eAW1mhx
         NHzg==
X-Gm-Message-State: AOAM531eL4K3cMQDy2Gao/9YbOycGCvPCf6SZcX5xWU3Gg+83hTnH9Gt
        IIqyAU38Zyd8O/gVlQQ44fmncuuFYYpmJKwc5gIRiOHpmF97
X-Google-Smtp-Source: ABdhPJwrvx/OBoqSlMgQCtxiPhSXc/a63Cq70bYPiOz3kuHakcizjVsAXGVS1e5fCnNZ8t6xmOSAFultwQMqsqPwQ/EtD7w0Y/w9
MIME-Version: 1.0
X-Received: by 2002:a02:630f:: with SMTP id j15mr357790jac.62.1631148967991;
 Wed, 08 Sep 2021 17:56:07 -0700 (PDT)
Date:   Wed, 08 Sep 2021 17:56:07 -0700
In-Reply-To: <3ba69d23-26d0-9c94-bf9d-a0db2bef2ed4@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0227205cb85760c@google.com>
Subject: Re: [syzbot] WARNING in io_wq_submit_work (2)
From:   syzbot <syzbot+bc2d90f602545761f287@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bc2d90f602545761f287@syzkaller.appspotmail.com

Tested on:

commit:         c57a91fb io_uring: fix missing mb() before waitqueue_a..
git tree:       git://git.kernel.dk/linux-block io_uring-5.15
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9bfda6f9dee77cd
dashboard link: https://syzkaller.appspot.com/bug?extid=bc2d90f602545761f287
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
