Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11D376EF9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 04:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhEHCvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 22:51:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36728 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHCvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 22:51:09 -0400
Received: by mail-io1-f70.google.com with SMTP id t9-20020a5edd090000b0290406cd22dc3aso7338197iop.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 19:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ep5Ziog6b4PKDEAUjUK1xGZkkgiBko+vVQSZys20w/w=;
        b=sUfWUoOn1bv6P4qYrwTY4N5WUuq1DVGdMV9M3/spdf0Bij84TMdUS4FvXLad1mLS0H
         XFRsvAp0t7c7i+O4N8pZ8qsKlyQVNOXizerKrLQbL5jd3kseRtUO7d4Q982h0Ggv+Rrx
         UNTkTTOH1f2hFD8+NegJ34PFamh3Ny1m4l1liA4nGjI1B2o2s5NZZanz5ncE5MGe8n8d
         xLCdU74GBrDNBOvSCnO8HtthAw43Y/g9otIUOK9kHk92A9Sm0UECcYSUZcKPw+Bq1Au9
         X9em+LcKy7Wj+vGUYQsDUGvPUW0Jyyw0AXUW08xmSHiqgmGqRFrZ7MjfIp02jt/c097A
         bLXg==
X-Gm-Message-State: AOAM530Qkw0BYp7IMpPzO5dk0JjEYwXim2Nioa+6/5Ovhd0L1yAopwVL
        8Uv5cmhn81pMBBIDOCQfOCYCLryJe+rE+ZVde9pg9SRYtjmJ
X-Google-Smtp-Source: ABdhPJxJyzmD1z8zzw7DF6Q34svdnXoJ9Xh8K888+JYMQuz28+XX+2x/TaSJClKQ4EyWMRjU8m0a1b7xCm9QrsSB+vQf1gKpJGhg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:de7:: with SMTP id m7mr3239161ilj.76.1620442207980;
 Fri, 07 May 2021 19:50:07 -0700 (PDT)
Date:   Fri, 07 May 2021 19:50:07 -0700
In-Reply-To: <e2fe2053-c413-daa4-1151-c4476d32d23a@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f920305c1c89a25@google.com>
Subject: Re: [syzbot] INFO: task hung in io_ring_exit_work
From:   syzbot <syzbot+93f72b3885406bb09e0d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+93f72b3885406bb09e0d@syzkaller.appspotmail.com

Tested on:

commit:         50b7b6f2 x86/process: setup io_threads more like normal us..
git tree:       git://git.kernel.dk/linux-block io_uring-5.13
kernel config:  https://syzkaller.appspot.com/x/.config?x=f81a36128b448b98
dashboard link: https://syzkaller.appspot.com/bug?extid=93f72b3885406bb09e0d
compiler:       

Note: testing is done by a robot and is best-effort only.
