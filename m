Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8787544E1CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhKLGTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:19:11 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:42730 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhKLGTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:19:06 -0500
Received: by mail-io1-f70.google.com with SMTP id n25-20020a056602341900b005e7a312f86dso5022127ioz.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 22:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=h95aiI2OL6pv1tC2hySS8sQH6YMt5Au+h2zaEiTNf9I=;
        b=vP9bLLiG6LA9cjcnYuECZzN9LhqnF3GEFweN9DYtQQDWJbHxjs1AbjQCTYfsefQOZl
         L5czGg4pTRubAeLrL5v8QsckqqxNQzSiiw/FQPtSduG3DCR2wTJsKj7zc5TMS16GeDxq
         M+JECMpgeu4zhn21MFwRy4cNb9CHl/9XpDMSWEQR3inSt6l2OAS4QdcenZsWP4hzfUNa
         ms37DC+yJmDZvAve6YtytOukaHkYGsGRXyl7/hALDI+kO4tCIbWt9Do0QhYuEKLQEJs9
         JnnKS5pnlPzuguDM0rZjLwRrgYdDLh69zJt3Ldhf0GlxPA6iNh2P8qEA6FcNXYLG9fTo
         kzkw==
X-Gm-Message-State: AOAM531plU88ml7oh1WrNPPhFLs8TKWEk3hDFcFmUjSqu7BSfDNvLvaR
        JeltIhB+8ur+iavzrr4vBqyipY5EcIsFqiFolnzcQ4AqCFup
X-Google-Smtp-Source: ABdhPJwv38CoU5xFFHLAfMljQmhviZ0VQHuWT5jYXeqzV9JTP0D7iodZtEDh0DaBNHjBTsUZE61GqMmigEYSnELQ7Rq0Rd1doAEE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0e:: with SMTP id l14mr7470656ilh.8.1636697775906;
 Thu, 11 Nov 2021 22:16:15 -0800 (PST)
Date:   Thu, 11 Nov 2021 22:16:15 -0800
In-Reply-To: <0000000000003991b905c9cb527a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089a5e805d0916571@google.com>
Subject: Re: [syzbot] INFO: task hung in hwrng_register
From:   syzbot <syzbot+fa0abe20d13faf06353d@syzkaller.appspotmail.com>
To:     f.fangjian@huawei.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvivier@redhat.com, mpm@selenic.com, mst@redhat.com,
        syzkaller-bugs@googlegroups.com, tangzihao1@hisilicon.com,
        yuehaibing@huawei.com, zhangshaokun@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 2bb31abdbe55742c89f4dc0cc26fcbc8467364f6
Author: Laurent Vivier <lvivier@redhat.com>
Date:   Thu Oct 28 10:11:09 2021 +0000

    hwrng: virtio - don't wait on cleanup

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d4141ab00000
start commit:   f8e6dfc64f61 Merge tag 'net-5.14-rc6' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=171d57d5a48c8cad
dashboard link: https://syzkaller.appspot.com/bug?extid=fa0abe20d13faf06353d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cfe231300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hwrng: virtio - don't wait on cleanup

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
