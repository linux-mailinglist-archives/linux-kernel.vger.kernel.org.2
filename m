Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A292341AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCSLCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:02:32 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:51671 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhCSLCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:02:12 -0400
Received: by mail-il1-f198.google.com with SMTP id y11so34120254ilc.18
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3kE9urkd9NS2DuoN7WUKMGk6xYQqlb0lhJPiUJGc07Q=;
        b=aQKWsAAQRiXwc6qamWv2KFW+Rn7nOesWmdxQl6aA5hBk7wRBBSyzTy6X7cx1tlQUFy
         FAsZtXQO1XWisG3Mt5KmsQhVa8kMFLfYckV8dKvSyG4KjgX+L1fSjf6+T7tR0pVh/h+Z
         wSYgmB5CW+1bt4pR+RDLqj9jwv5erwipaQwFZQxNejS2R4i34iRuRC/hUpX9AHqEGbWB
         d102lAi4PJUvFLiYUzVeXMTDQb93mx9P4Qgqous/6qQZo8trUvLV9bDTXUIJJqzM0JbO
         8FoJBvbcdDIdPQ9IMXyOsb2uVyZTbJJMm0jFZS2Bzcq63ESI0XSsIfcXWyPcsJkPngRk
         rGHQ==
X-Gm-Message-State: AOAM532YA7N6VZGElXRyz8xmgiLcMIX/lpcK2iJBokPgTfQSs/eMSzKK
        cOUPFt/0w0UT2l4DYiHOlCD+5jzOmCAJfY4q6fhnr0pexs0j
X-Google-Smtp-Source: ABdhPJz+kK4gMhywPYy9lQKtIKqExdj6dBXtuhCNKCvGyX4ec6P8xmes238+oDV+K8NqRw7qdQfcXpEuNSpryoDeSuUPHnN4TqSf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:: with SMTP id d1mr2302995ilv.85.1616151731732;
 Fri, 19 Mar 2021 04:02:11 -0700 (PDT)
Date:   Fri, 19 Mar 2021 04:02:11 -0700
In-Reply-To: <cd88eb14-f250-54d1-d36b-7af3917d3bec@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df888f05bde1a5b4@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in idr_for_each (2)
From:   syzbot <syzbot+12056a09a0311d758e60@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+12056a09a0311d758e60@syzkaller.appspotmail.com

Tested on:

commit:         ece5fae7 io_uring: don't leak creds on SQO attach error
git tree:       git://git.kernel.dk/linux-block io_uring-5.12
kernel config:  https://syzkaller.appspot.com/x/.config?x=28f8268e740d48dd
dashboard link: https://syzkaller.appspot.com/bug?extid=12056a09a0311d758e60
compiler:       

Note: testing is done by a robot and is best-effort only.
