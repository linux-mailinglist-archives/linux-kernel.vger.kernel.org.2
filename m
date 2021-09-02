Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429703FF3F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347306AbhIBTPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:15:07 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:45668 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbhIBTPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:15:06 -0400
Received: by mail-il1-f197.google.com with SMTP id o12-20020a92dacc000000b00224baf7b16fso1904176ilq.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 12:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lHEO6j/wPdM6LnGvV1Hipd6kqZE+sNmD8+mgNJqLZk4=;
        b=gdoBt0bAjWnbeXxt+OoGfdRz4bdKey/E/yJXbEHE6KFqNlJ7kqQblY9ayUI795jucx
         OJDDacxiGJ6GqrfMGdoPTWha0nCHZfEHTgc9KSAQd27Uv8+IwYEBn0tGjJgFPg6tZ1yk
         OTZgFRHAX2mHSoT7WH1/G3UtIbIHFOtxvXCvuOxqJzytAmeI55e2ANw+DgVz8Fer3hvq
         wQ1nDvpbxt7/BMtNlF1V/OYbNjcKE5620a9Xs3Wz4rlqB/bXoYaP9e/g6AFeN62NoD2Z
         e349XPuxG7pFtI9TicgF+xGxXZsRUfjze0z0aLIQWZFnSZ0HRDSdXxEWdzq/BTfkaNe6
         7spw==
X-Gm-Message-State: AOAM533tuSfDnPuNkbyVfPrCY/mitIKx7DmK6ADAw0Ur0cg/iCwrUYtF
        UXNP8p2IyFlmk+PLBLljyThDTMaNfQGb+0HCcG5E35jhax3Y
X-Google-Smtp-Source: ABdhPJxGjsrbI8ElYwmjAQu37MqywmihHOSkKWTcxafm3fLR8bAPLCN7f1Pvixq3+gIaNHWyY2Iqq74GTuldPLMjoJGTthAcFGl2
MIME-Version: 1.0
X-Received: by 2002:a6b:fb03:: with SMTP id h3mr4014831iog.198.1630610047629;
 Thu, 02 Sep 2021 12:14:07 -0700 (PDT)
Date:   Thu, 02 Sep 2021 12:14:07 -0700
In-Reply-To: <3d956ccb-8f2d-e3aa-eee3-254185314915@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7fb9d05cb07fc90@google.com>
Subject: Re: [syzbot] general protection fault in io_issue_sqe
From:   syzbot <syzbot+de67aa0cf1053e405871@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, haoxu@linux.alibaba.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+de67aa0cf1053e405871@syzkaller.appspotmail.com

Tested on:

commit:         dbce491b io_uring: prolong tctx_task_work() with flush..
git tree:       git://git.kernel.dk/linux-block for-5.15/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa8e68781da309a
dashboard link: https://syzkaller.appspot.com/bug?extid=de67aa0cf1053e405871
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
