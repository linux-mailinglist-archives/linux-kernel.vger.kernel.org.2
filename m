Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACDF35B3F8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhDKMBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:01:25 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45619 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhDKMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:01:20 -0400
Received: by mail-io1-f69.google.com with SMTP id n13so6949959ioh.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LDTjWmZvEWtUCLx2G8NWLUQGZf4eyJlc261DSUtArss=;
        b=d42Cqa2xexslfIYXpX5+zj4DxsLqWt0q4ZxrezMppLRr9QfePa27XMhljzpvf6hJi+
         xlBLtPBLlp2OL+0R8D0OcdfyNDPkg8cPrdJ/NiC/S84zER4DTTf4bIAZrjVyhhpjBtbL
         FLeKfZfSJB8ypMq46c93lQHaWVuFPqk08ki5mYqvL7miBBiFEAV/GWjVmB49mC/8sn/I
         mRQ4bKjnaVaOeVb68TlgIupoVhWOxu/OPmLbm4Z59776C/k5EktRR9JQu4LE0SWmc1fT
         pEhd6gAast3HlCH278bgCGr64BMvpn1Cri4msOM1+79O2mRhRdiSl44O+Ad/vs3lZpoO
         fgqw==
X-Gm-Message-State: AOAM531fKNuM9xiU7tS/WKfKWFCBYQvRpmBJCaCyX8jm6QEDk+wCjxwd
        POecmQAdkE7Z4psgdVrAFQqERRosoRR9i/TXfyMcZSJcfVKF
X-Google-Smtp-Source: ABdhPJyDyqbVyC9mBnLUut7DKqzalFIfytiw7VvqlWdVUVr22Qx+pnaBUnEzBz6/UbxXmD5PMAsFPUDFomYIxpMTQViVD0xC5CXh
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0d:: with SMTP id g13mr19341545ila.99.1618142464099;
 Sun, 11 Apr 2021 05:01:04 -0700 (PDT)
Date:   Sun, 11 Apr 2021 05:01:04 -0700
In-Reply-To: <00000000000086f79105b5553f1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4cba105bfb126a1@google.com>
Subject: Re: [syzbot] general protection fault in drm_client_buffer_vunmap
From:   syzbot <syzbot+10328e8428a896b65119@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        igormtorrente@gmail.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de,
        ztong0001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 874a52f9b693ed8bf7a92b3592a547ce8a684e6f
Author: Tong Zhang <ztong0001@gmail.com>
Date:   Sun Feb 28 04:46:25 2021 +0000

    drm/fb-helper: only unmap if buffer not null

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c27b7ed00000
start commit:   c03c21ba Merge tag 'keys-misc-20210126' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec4c85e44cc3172e
dashboard link: https://syzkaller.appspot.com/bug?extid=10328e8428a896b65119
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d95d7ad00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148da9ccd00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: drm/fb-helper: only unmap if buffer not null

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
