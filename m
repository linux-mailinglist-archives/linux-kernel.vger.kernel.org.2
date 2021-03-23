Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DBE346165
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhCWOXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:23:16 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:44251 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhCWOXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:23:05 -0400
Received: by mail-io1-f69.google.com with SMTP id e11so1987316ioh.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2CgcKrHeCWGBs2yP0zbh1B1ArVXrjGOfPGKUarVfunQ=;
        b=VHv+5oz88PyrcOfuLLiRXQK7CY9cR81ekCslTWhkkh0Z9LwBt+vPFTCSu+hssaDMfv
         rzgYgaGLM9RR4Yf1AoBqwWkDyVowQ+F46sKE8LLMOPgsyF9u7dSiIggJFV1OD2P6cVvI
         cWQ2V3lnmHfP5gccv6miKwGraWr9qpxlcLj1R5/kQB4haVePrgHsSQKlkC2nltYYlz01
         m914bfarbxk1/F8ri30cYq4fEC6FYWumeT3aD/ID5ffTGfPPCROp+GSr3wMzTwiuUBus
         51rxukw59sLZ/mt8SuWX3aNYyqxQIfcWvLhi9Fh/o/QhN9MYVri1q+AZ6JmoCpib2iV5
         GpIg==
X-Gm-Message-State: AOAM532zQaQngJy+4X4O5cKHMSumi2gLrNlpzTOCfrT13x0DNX/tzrhJ
        +qLaaQcI9jUocjGoafFwZhitfoUg+qDoWMO0nNgBPWv0YNaX
X-Google-Smtp-Source: ABdhPJzgwzFP6+3QtkQvdgHTxAvfMkCaGRBXU5kycZm2+e6m/Rd9tLH2IWwqzc64Az8TvaRN7DDSTSnNIy8qnY2e68q1xXxjnlh2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c21:: with SMTP id m1mr5184931ilh.204.1616509384532;
 Tue, 23 Mar 2021 07:23:04 -0700 (PDT)
Date:   Tue, 23 Mar 2021 07:23:04 -0700
In-Reply-To: <08603c70-64df-5dcc-f5c7-1646056af74b@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a427e805be34eb03@google.com>
Subject: Re: [syzbot] WARNING in io_wq_put
From:   syzbot <syzbot+77a738a6bc947bf639ca@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+77a738a6bc947bf639ca@syzkaller.appspotmail.com

Tested on:

commit:         c95a47c2 io-wq: eliminate the need for a manager thread
git tree:       git://git.kernel.dk/linux-block wq-no-manager
kernel config:  https://syzkaller.appspot.com/x/.config?x=175bf2d0517d3b04
dashboard link: https://syzkaller.appspot.com/bug?extid=77a738a6bc947bf639ca
compiler:       Debian clang version 11.0.1-2

Note: testing is done by a robot and is best-effort only.
