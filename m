Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E889D41CF25
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347072AbhI2WRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:17:49 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:55949 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhI2WRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:17:48 -0400
Received: by mail-il1-f198.google.com with SMTP id c11-20020a928e0b000000b0024eb114af51so3597238ild.22
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=i4mHTYItma881yZNn5hSgHtPa1jzenXJQmwdm1N4k/0=;
        b=S8m6Usi1P5/JgdRbMXrPAbLIy5Z11nVeoDcla+qggvNeB+BUjruf5zZdDRtlWVklXw
         6c9hCHxxlfgVbN9cHRZ5sV1u9NowDFh+Vz5qAU/hAZkniysAtHy6PBo08s8C2gFGDftx
         5GF6FnLUZtZ8KPxW56koPEAu5R39/vzeE0ZCeakVVh4o4tk3aBTxf4RYd8cl4M5BtiU2
         IPaAthsRgbOGJvnw5SamizcBdhSlMcWB5zlzO3CVBJQlgMWXtxt7fdE/Qx7huf9X1iCd
         nSGxInRVqiFzWgoF7DFxCcOBRYIvoZnBGehmEKAEGZTBx1iHTgRP77IiMSJF87lC0S/f
         K7jA==
X-Gm-Message-State: AOAM532aFgULrofwaUgrvPCkxf/iO9/rHG0nAPtrxDe9oAM04NM9cbMJ
        aT4/pKkzJoHrt80ImjFXmFJxexnu8xSPmxhPpqfPZuF4t3Kb
X-Google-Smtp-Source: ABdhPJzBksJAyvFazlCfHnpD6L3OmYxSiJYRrQ2kiWWk5MYKXzFYpgAbzDQlyGj4COhVqkCwVbA1nmbuRhSUaLdV0Pym95WE2uyl
MIME-Version: 1.0
X-Received: by 2002:a5e:c20c:: with SMTP id v12mr1558062iop.46.1632953766654;
 Wed, 29 Sep 2021 15:16:06 -0700 (PDT)
Date:   Wed, 29 Sep 2021 15:16:06 -0700
In-Reply-To: <79069fea-c0f4-2363-6f58-39396689f95e@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000323d2305cd29ade7@google.com>
Subject: Re: [syzbot] memory leak in bsg_register_queue
From:   syzbot <syzbot+cfe9b7cf55bb54ed4e57@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cfe9b7cf55bb54ed4e57@syzkaller.appspotmail.com

Tested on:

commit:         1a0db774 scsi: bsg: Fix device unregistration
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a1f32762f17135
dashboard link: https://syzkaller.appspot.com/bug?extid=cfe9b7cf55bb54ed4e57
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
