Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9183FF51C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344895AbhIBUrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:47:17 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34318 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhIBUrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:47:13 -0400
Received: by mail-io1-f72.google.com with SMTP id a9-20020a5ec309000000b005baa3f77016so2289744iok.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vZddxkmzzNUqs8xRQqKBJZn3gzD87BQVYbHyMNSJKX0=;
        b=uLKoQ8lwiGgYe5BvtRwU+2ng+R9jhGqioj7MA3OpPs0ZNxH4OG5r94gQDEix8ozVci
         dRIMtNyc5SWrUG4yBMkoVkjvATN0PYp5pPBK3XgGLcy381KB/setscFPgXkON0E5HQiI
         XmyXI8kRnMOolHWQDIyhQz0seEGxJZJAhHPVzW6ae9UwPF/1naoRo47ITj/pXHtFnGpn
         ALcJQ91l899RQgpJoJ6XTS2xe8vMm0v7xDGtw2tsqA25tNXTnghoqLV+wLBlpVb+k82U
         TwBskKfqvtSMiVT+5eCdd8DiSZ3Z4hiyCj6FBoI530hakyBoRezNkDcIeM7qxllGTIV0
         ww0w==
X-Gm-Message-State: AOAM532DsTLB0nlg7VEwYWJhUxXSwjvgCcENrmVo/KLqsocXOCHBWjdS
        D1vDtrzt55RE4cdxo4c+O8658FJx1yFExDI6wx/Un+XohdSh
X-Google-Smtp-Source: ABdhPJxBp06Vus/lGmmaHSEye35bdz53/shEn/WIWJXsVKGgQMpYtb+dAiMQZDJeOF8ZK3xYam4JOHxRRS7J0C0O1zGTkLFKqZbn
MIME-Version: 1.0
X-Received: by 2002:a5d:9409:: with SMTP id v9mr223494ion.170.1630615574684;
 Thu, 02 Sep 2021 13:46:14 -0700 (PDT)
Date:   Thu, 02 Sep 2021 13:46:14 -0700
In-Reply-To: <20210902200406.GB442125@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001827b505cb0946a5@google.com>
Subject: Re: [syzbot] INFO: task hung in do_proc_bulk
From:   syzbot <syzbot+ada0f7d3d9fd2016d927@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ada0f7d3d9fd2016d927@syzkaller.appspotmail.com

Tested on:

commit:         d5ae8d7f Revert "media: dvb header files: move some he..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=2fd902af77ff1e56
dashboard link: https://syzkaller.appspot.com/bug?extid=ada0f7d3d9fd2016d927
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112280a3300000

Note: testing is done by a robot and is best-effort only.
