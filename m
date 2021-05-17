Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED5382B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbhEQLkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:40:24 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:47968 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbhEQLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:40:22 -0400
Received: by mail-il1-f197.google.com with SMTP id l12-20020a056e0205ccb02901bb79cf40f9so3475221ils.14
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=64ByleF0eKIUeLMwAQcZCrEU9s7jm+g71Yg7H37B1eE=;
        b=qbzsvIzy/nVMZdeW034qDgQwtdry58zVEKWiJfaqRlAxg9XygQNvYYghD4iWMXkHY9
         VxlZXugdKCEJz6Gt+EX87sAw+ZpWS9IGjONS7p8d1FTmOWtAGinP8c3I71KKkcIvfQDG
         JcQKjFCWd0xNV+CfuoH5OCVupMKrCo8/cwykgZ3wU/2b01BlL37FFHugvp4713Wml7OX
         ZIMIregm8IAz9Lf8dOMc993z6Q1p73ZceQkAA5uKPpI7D2/tNvB6+WQcP1kAzQHPTcBn
         gFWXenf40T616vUag3FAHE7fr4AEkuNByTgkaBL/u38qqajAzMKNgONqiOLVpbdRegX1
         DqTw==
X-Gm-Message-State: AOAM533iWgnfluilODmkhbLgm99S1vi+rZX0iKgivtOtMItQIA6Fu7vU
        7N8kaTuFdk/W+MtO/Gmgodzn/S/3gaMdFw3qjZoNaHEg5mV2
X-Google-Smtp-Source: ABdhPJxdR1T5mJ0Hz94LylFjjrFcVztce0EuuJVoIk6yn6ufYbfAnVpUJDXApHuCLfnDF/bIaK/55SNcREKfnVW4XoHmzI3nOeXD
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:: with SMTP id i5mr2362132ilm.101.1621251546286;
 Mon, 17 May 2021 04:39:06 -0700 (PDT)
Date:   Mon, 17 May 2021 04:39:06 -0700
In-Reply-To: <a6a87693-f994-6e56-78a2-6e39e1060484@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000820f7005c2850ab5@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in corrupted (3)
From:   syzbot <syzbot+a84b8783366ecb1c65d0@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a84b8783366ecb1c65d0@syzkaller.appspotmail.com

Tested on:

commit:         667dd097 io_uring: don't modify req->poll for rw
git tree:       https://github.com/isilence/linux.git syz_test10
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae2e6c63d6410fd3
dashboard link: https://syzkaller.appspot.com/bug?extid=a84b8783366ecb1c65d0
compiler:       

Note: testing is done by a robot and is best-effort only.
