Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5EB383D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhEQTSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:18:24 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47791 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhEQTSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:18:23 -0400
Received: by mail-io1-f72.google.com with SMTP id q187-20020a6b8ec40000b0290431cccd987fso4152459iod.14
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+kErfEtNYwu/Ybclt9+KOG1egC5Rd9gjqzB3omTYpbk=;
        b=RyUqAc9RUX7T3eSK1sFklPXMw2f3vPS+BhalccuVTCGeBMFdb/B9On8R2lFrR8Iox9
         mEGLKCnpxZ8KyI26r/dW/H/UZkflMgXBtGB06v4xJWpPqZC2a7pLp6W9e0ivs+uCsQtM
         irvYVQeF3q7sOJHo8h6Uaxo08WsWaqT1xVQo9ndMBJIoUV0NOVRdxYeLUxBu8+ADFq9B
         STGT+LUSS4en4pyjwlH+IiBxsT0EbUriJRtnND+LDFUMreFkPRsFuXEJ+D5N5nc7BCRi
         +yhpClNa6Gq2nAvH+S2dW7kj7f9A/rI48fi/YzsKfuTHJxN/cH5VeODEZ4PD5lZmhEoc
         L7Uw==
X-Gm-Message-State: AOAM530eXjgi+f9evf1FlOKY+shdECDImM9tCPECPRBRZSlMUXzSeIzQ
        GN/b8hO8A586fxfFujttL4ypdQdohcchzY2YclkD1J2DQbQf
X-Google-Smtp-Source: ABdhPJz7zkN9b8IfVdrGey2sJgHjnLLqDvLusS/BcEN5YJqN6eyAnKsNyHkgRQQVj44NE68p1mcX55PJfr0Eo4uuuFJEhaxq9slE
MIME-Version: 1.0
X-Received: by 2002:a92:dd04:: with SMTP id n4mr994688ilm.165.1621279026606;
 Mon, 17 May 2021 12:17:06 -0700 (PDT)
Date:   Mon, 17 May 2021 12:17:06 -0700
In-Reply-To: <20210517215904.7d915011@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007676b005c28b70f6@google.com>
Subject: Re: [syzbot] memory leak in zr364xx_start_readpipe
From:   syzbot <syzbot+af4fa391ef18efdd5f69@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        paskripkin@gmail.com, royale@zerezo.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+af4fa391ef18efdd5f69@syzkaller.appspotmail.com

Tested on:

commit:         0723f73e media: zr364xx: fix memory leak in zr364xx_start_..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux refs/changes/96/11196/1
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb9a486f2f311b2e
dashboard link: https://syzkaller.appspot.com/bug?extid=af4fa391ef18efdd5f69
compiler:       

Note: testing is done by a robot and is best-effort only.
