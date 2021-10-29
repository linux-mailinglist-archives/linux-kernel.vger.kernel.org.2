Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E49440463
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhJ2Uzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 16:55:40 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35609 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhJ2Uzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:55:39 -0400
Received: by mail-io1-f70.google.com with SMTP id g24-20020a056602249800b005db75d2a291so7595407ioe.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 13:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mZR1Ffgh9GUeY1nvfeVVdOqzzFuN2C/+L0bUpcqSOr4=;
        b=bdF5ZpNcKU45UTC9wUcEymRqp+WLPE+8XWD1ki1AQmCZ99W87TWnIhmqK3vMuE71ZA
         G0PGytPLd6wFgq2kM2Yp+KtPafvpCPiFTIUy/SJjNS6yNM0dJ8fvpJX4Yn/haeF0fCRe
         EkaGEic66sfGNcfi1k6B6O59bAg9PqCOnXgL/uh8bhg3KGcYQhrj8t7RkzMdurRacW/v
         M/yUZ9ZmCakVP2Iv1ylOPjTwh9ygLovd3t+LHgCxDYUdb1oTDqFlJ7lf5DoFT1qUfeaW
         HghI7sGR9R0J2fp3b5XodHfPS+FrLxtlFx7dJei0sI8YSpYyIO5mJOvQqPvdRSmngf+j
         026Q==
X-Gm-Message-State: AOAM530xsE75rEiVG1jNq8xOgUsDryjOVL9oNRObeeGcPhGwpAjYs7nR
        4k9scIIhkzqG2lE8RVeiAD25SWGWYjqR65VMLqRY23MkMHSy
X-Google-Smtp-Source: ABdhPJyg7+CkIZhRFcuuSE69HNyMf6UDU7ZvRRKf1co95w/1Krr48Gg72H+2mTFxBZR0Aql8UGNCzvAEgwqDLIoCoGWEBKHdw9ya
MIME-Version: 1.0
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr9940649ior.152.1635540790308;
 Fri, 29 Oct 2021 13:53:10 -0700 (PDT)
Date:   Fri, 29 Oct 2021 13:53:10 -0700
In-Reply-To: <ef640d96-750f-d92e-50ff-27c97f6dcc51@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2737805cf8403c9@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in __io_free_req
From:   syzbot <syzbot+78b76ebc91042904f34e@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+78b76ebc91042904f34e@syzkaller.appspotmail.com

Tested on:

commit:         1d5f5ea7 io-wq: remove worker to owner tw dependency
git tree:       git://git.kernel.dk/linux-block for-5.16/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=10c050a45aafafcc
dashboard link: https://syzkaller.appspot.com/bug?extid=78b76ebc91042904f34e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
