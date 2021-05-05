Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8970D373CED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhEEODW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:03:22 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:55986 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhEEODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:03:13 -0400
Received: by mail-il1-f197.google.com with SMTP id a15-20020a927f0f0000b02901ac2bdd733dso1606988ild.22
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nzZoGSaNk15eVdCdhLg/lhOvD5F94kAlun8vvUPZwmQ=;
        b=HURbBW9Z/jShopXT0w3Zp1q8tq/BXFWDVbaa6IFT8Tqjgx0qedteDuo9Sc0w8i6l93
         C9qjxs993TDmUKty+yfu7MrYhOmmjxnVgEo3v9TkPc2p666a+qHfTQkRafYx76mAwAUw
         539eM0B5Ea3OPUlXPx5H0JhIjhZ/9MJpJacJS3p/tJn8bTSM6UfYAD69xJPTvfvlBAoI
         69qrjAkThOZX+9PTjYu/7A5y1QpMHDPNQKY+tbV4M9T3cAhPC8n8gjone3FkY0aQkocf
         rrByPgKwf72rn9tuZ80rPZ66TXVeI2d4dj9WTJqoM2XJUHT97z1GrqKOjZWe9llVPnrT
         y3NA==
X-Gm-Message-State: AOAM531Qsbr8DKDth+p3UifLuUb4B8e2F3QXWD++8bhkmjY/cc1O5kcH
        qTINFO0iAQG0vZZ7rujpy6uE3z3JsS2tUzw16md/I5IKl+zz
X-Google-Smtp-Source: ABdhPJyzXTlJHMJewy9XPDfpGTO6uV+D2lMNp4D6HM6CPyTnpKZnxTn33UszVOcVPYTRNmf41wg5cAcE/fYy+ivpY2DfwadJnrsy
MIME-Version: 1.0
X-Received: by 2002:a92:b74a:: with SMTP id c10mr24963547ilm.72.1620223335870;
 Wed, 05 May 2021 07:02:15 -0700 (PDT)
Date:   Wed, 05 May 2021 07:02:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006438bb05c195a467@google.com>
Subject: [syzbot] WARNING in drm_wait_one_vblank
From:   syzbot <syzbot+6f7fe2dbc479dca0ed17@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c5b2c3d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
dashboard link: https://syzkaller.appspot.com/bug?extid=6f7fe2dbc479dca0ed17

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f7fe2dbc479dca0ed17@syzkaller.appspotmail.com

------------[ cut here ]------------
platform vkms: vblank wait timed out on crtc 0
WARNING: CPU: 0 PID: 11785 at drivers/gpu/drm/drm_vblank.c:1269 drm_wait_one_vblank+0x2be/0x500 drivers/gpu/drm/drm_vblank.c:1269
Modules linked in:
CPU: 0 PID: 11785 Comm: syz-executor.0 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:drm_wait_one_vblank+0x2be/0x500 drivers/gpu/drm/drm_vblank.c:1269
Code: 85 f6 0f 84 a3 01 00 00 e8 6f f0 32 fd 4c 89 ef e8 97 68 13 00 44 89 e1 4c 89 f2 48 c7 c7 e0 eb d6 89 48 89 c6 e8 57 35 86 04 <0f> 0b e9 87 fe ff ff e8 46 f0 32 fd 31 ff 4c 89 ee e8 5c f8 32 fd
RSP: 0018:ffffc90008f7fb40 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 00000000000038f8 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815c7bd5 RDI: fffff520011eff5a
RBP: ffff8881437b0000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815c1a3e R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801a1c4010 R14: ffff8880161746b8 R15: ffff888142ddc830
FS:  00007f8eba6e2700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000014a53ad CR3: 0000000021583000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 drm_fb_helper_ioctl+0x159/0x1a0 drivers/gpu/drm/drm_fb_helper.c:1197
 do_fb_ioctl+0x1d5/0x690 drivers/video/fbdev/core/fbmem.c:1171
 fb_ioctl+0xe7/0x150 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8eba6e2188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 00000000004665f9
RDX: 0000000000000000 RSI: 0000000040044620 RDI: 0000000000000006
RBP: 00000000004bfce1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 0000000000a9fb1f R14: 00007f8eba6e2300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
