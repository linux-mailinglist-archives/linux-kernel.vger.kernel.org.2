Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712283EC2C7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbhHNNHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 09:07:48 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:51893 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHNNHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 09:07:33 -0400
Received: by mail-il1-f200.google.com with SMTP id g9-20020a92cda90000b029020cc3319a86so6759037ild.18
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 06:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t5YQUGSZE6EI9BhxfatfxY8kQRFsuaqSI5BxeVjzuZ0=;
        b=WiKvJElvU4piRPBgpQ/cMtMh+siM3caWTjn6pKUp1lr3SanWR29+KtR2G3lXkOhK+w
         1tp+9VdfYMxzHD+1udaq2huC31aVKNKVbwc7YHEKpzwKgaPDBvFJ/89QtjPA5Hcx/27m
         KKZianEl+b8rpRc8nNn5z1EJ/rgwx40tA0dM7FlkcFRJF1ysuMNtpxJbeQA+0nNVm8SD
         s7bIV9hERYGvptsyVxx/ERk+io05SAVP4i2ZTzvIN6SlRzKdomKhbS32FX0SI+yIWMVF
         PDhfbBv9BQfdwml/HRAQMAKdY8IvQ3UvRcXOn27d62i9pgTnEguBXFQ/X4pscjlCWVwG
         kFKA==
X-Gm-Message-State: AOAM530At55N1lucP1+DUZqAw7wp75YY7SA87ZGEiS8iMfRIzgjoWtw/
        GMoq/2Qx7gv/uh8WtzBkAU7mX0/kO9qRQrTbXCgwmRznPyY/
X-Google-Smtp-Source: ABdhPJy2AvLguRSMEmfyW87t0JS484ypKZ9GNlz2YX0HW0onFVHA9gtYaOLblHldyW0ZHNRgbBvtlICabAwh4/WuQloazRiOUvWa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cf:: with SMTP id z15mr2152427ilu.103.1628946425097;
 Sat, 14 Aug 2021 06:07:05 -0700 (PDT)
Date:   Sat, 14 Aug 2021 06:07:05 -0700
In-Reply-To: <00000000000006e7be05bda1c084@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006b42305c984a5d3@google.com>
Subject: Re: [syzbot] general protection fault in scatterwalk_copychunks (4)
From:   syzbot <syzbot+66e3ea42c4b176748b9c@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, bp@alien8.de,
        daniel@iogearbox.net, davem@davemloft.net,
        herbert@gondor.apana.org.au, hpa@zytor.com,
        john.fastabend@gmail.com, kuba@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vfedorenko@novek.ru, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 635d9398178659d8ddba79dd061f9451cec0b4d1
Author: Vadim Fedorenko <vfedorenko@novek.ru>
Date:   Wed May 20 08:41:44 2020 +0000

    net/tls: free record only on encryption error

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=144095e6300000
start commit:   f8fbb47c6e86 Merge branch 'for-v5.14' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=164095e6300000
console output: https://syzkaller.appspot.com/x/log.txt?x=124095e6300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171d57d5a48c8cad
dashboard link: https://syzkaller.appspot.com/bug?extid=66e3ea42c4b176748b9c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b8db9e300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c21581300000

Reported-by: syzbot+66e3ea42c4b176748b9c@syzkaller.appspotmail.com
Fixes: 635d93981786 ("net/tls: free record only on encryption error")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
