Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C29F3D9724
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhG1U5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:57:10 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:45645 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhG1U5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:57:09 -0400
Received: by mail-il1-f198.google.com with SMTP id l4-20020a9270040000b02901bb78581beaso2117190ilc.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 13:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=k7avy/HerkLzVt2TDE6cKZ9UT96PiKh/Pc16LGwaHOo=;
        b=JYxiZWFW4+ZLwZ/QWgboZe85YudaWwr8EkEr/xEO6bMgO0ZEEkhiI3Fq4VHF8kNuSe
         xlIiwglAFXfKOTq8cHgmOToNY0aFoa33oTN5Y7U5y+hSpjdukwTW7YbhgZByry9G+kZ9
         URHWpa8pPlkABdVk8RO63msRZpKUFqzFFR+AoDtOPIdMmQZV0PkoRFSBlBbFvGoy3Ewt
         awrSdzMXD9BnC8asD94EbgjzLt02w9uXF0zRzrlOlKL1e0lEDhVx4+UjjbztRIT3KfJ8
         tY8fCQfR+ZMKI4LwhzffBw18jZvt0TIntpAtxfetOwszZO+EK9HTouIEoADnBsQe+oO9
         vDlQ==
X-Gm-Message-State: AOAM533sa4QGcqJJGUfDQY4Rjkt98DT4u7nC0HyDgR32SqNw+C/iEnSL
        XN74bmMhLOvfhjHyrjgn+i4FR8TFCado8Jn4t9dBU+HaoDcY
X-Google-Smtp-Source: ABdhPJyZnAPPwgmg7uF5y/Cxw8Xv6DuGKAwZPuLqUazVOHeSKjzDmsa4PIvTWSOdsoD6wYrDR8P75M72ExNJce5udu9KdgSwzi/G
MIME-Version: 1.0
X-Received: by 2002:a02:cf0e:: with SMTP id q14mr1461977jar.86.1627505827360;
 Wed, 28 Jul 2021 13:57:07 -0700 (PDT)
Date:   Wed, 28 Jul 2021 13:57:07 -0700
In-Reply-To: <CAJfpeguXWAJRyRn=8tLRq41kqjuSnX9VNqNT_V2+jhuttC0nEw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5b15305c8353a74@google.com>
Subject: Re: [syzbot] possible deadlock in iter_file_splice_write (2)
From:   syzbot <syzbot+4bdbcaa79e8ee36fe6af@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4bdbcaa79e8ee36fe6af@syzkaller.appspotmail.com

Tested on:

commit:         cdaddca6 ovl: fix deadlock in splice write
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aa932b5eaeee9ef
dashboard link: https://syzkaller.appspot.com/bug?extid=4bdbcaa79e8ee36fe6af
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
