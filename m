Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A59C40830F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhIMDI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhIMDIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:08:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2C4C061574;
        Sun, 12 Sep 2021 20:07:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 18so7462684pfh.9;
        Sun, 12 Sep 2021 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pVNO0zZ6yed+HlHm5+s+npBLAVUBPnKD4pEfkjJWdiw=;
        b=Ny6Ka3Bm3j5DTjq/rAe6Th+cYsozUEwE3iTzzrso0m2GLP0vbXzkXYp50V4TZwastM
         3LtI7sskNxT67nkcKM+dzkJAEoW5YAMpG+1i2ArAKkKRA/n+AXCls0x5AFrDH7L7Y9a/
         sNS1qZWY5D3pbOTmzCSGPE75jcUGb91kL0yO3JIZgO3HzwaFLS8ujJXfe6F604NCG1mK
         VJhwMhv2tSlY127ogXb5+X50ouCi8xcFwSogf6+9oOiPNrlGDQ38xhYIMDCy7spr7Ssv
         1BPVXT9Qwxw1dsSKXsTNBdIoUfVe0ML19Exfkqt3vWS0i1HV5AZB0N/Mob0lZO+ugvwV
         eMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pVNO0zZ6yed+HlHm5+s+npBLAVUBPnKD4pEfkjJWdiw=;
        b=dhDBZfRaI4VIb4iV2nR4HcHOjdANh3RbaKuW2dF/nkFDy19R8sFMLHJK4gMtCc7OVk
         k13BTFWusvp/05zVVCJaKainMuonctr+jPIHgjXy4q6pg5lOG6QqaOIiKc7dqDC6aMXG
         4+OnkieTJpS2Jub7xNdqznVMuowhO1+MhhizLuy0IAuyJcsrv6rJRIJqaL9vR3zhk9Kb
         UlQzjBdjSQ5HgzplNk0SQ5GmU+0dV08YfHO2qZ9VDg+H5DqUk7km2F0nY/FINrCy/2fH
         lAbjgic9OUdib/Xsp/BixdvhRdI49K9e8bwjYjoPyVy3+jh1e3MoOdt1CriaRdOEnt5d
         k1JQ==
X-Gm-Message-State: AOAM5326wKWoDqAqIcSdoKj4uYgO1ieOndy93OQLPONTwCgFJ88G1PKZ
        pWGGAl461cXbDk0JYLyA9NtNdPHzYeu4V7z4L57MMwqvVP8t
X-Google-Smtp-Source: ABdhPJzSAK904fj9ZTNC/8VRmssxW0y+nn/hj5ajg2rjoreRTmVpOl8fHjWh6o1IRdArFWoSMbtSIipzpbLaq/PfKWk=
X-Received: by 2002:a05:6a00:2449:b0:43c:4a5e:55a6 with SMTP id
 d9-20020a056a00244900b0043c4a5e55a6mr5247471pfj.43.1631502429412; Sun, 12 Sep
 2021 20:07:09 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 13 Sep 2021 11:06:58 +0800
Message-ID: <CACkBjsYmdk-wjpX2E8+ooTDph2F8ZPMGwBNydbaxwDD9AmZekg@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in imageblit
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the Linux kernel, the following crash was triggered.

HEAD commit: ac08b1c68d1b Merge tag 'pci-v5.15-changes'
git tree: upstream
console output:
https://drive.google.com/file/d/1Vvyiebkb1BAbgnM8QXg4XeotLYE7Xrk6/view?usp=sharing
kernel config: https://drive.google.com/file/d/1qrJUXD8ZIeAkg-xojzDpp04v9MtQ8RR6/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1p79Nwcx6l7pC0qLZnbHFvr5FLSR79x0J/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1MT6DvJG2lMonmimV6XbED-I_STFMvaFo/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

BUG: unable to handle page fault for address: ffffc90007731480
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 8c00067 P4D 8c00067 PUD 8d63067 PMD 1026f8067 PTE 0
Oops: 0002 [#1] PREEMPT SMP
CPU: 0 PID: 10837 Comm: syz-executor Not tainted 5.14.0+ #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
RIP: 0010:sys_imageblit+0x48c/0x830 drivers/video/fbdev/core/sysimgblt.c:275
Code: 04 41 0f be 5d 00 83 fd 1f 0f 87 75 03 00 00 e8 5a d5 f9 fe 89
e9 8b 44 24 14 d3 fb 23 5c 24 08 41 23 04 9f 33 44 24 04 85 ed <41> 89
44 24 fc 75 b9 e8 38 d5 f9 fe 49 83 c5 01 bd 08 00 00 00 e8
RSP: 0018:ffffc9000928f890 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000007
RDX: 0000000000040000 RSI: ffffffff823dbcd6 RDI: ffffc9000928f9f0
RBP: 0000000000000007 R08: 0000000000000018 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffffc90007731484
R13: ffff88810496f13c R14: ffffc90007731500 R15: ffffffff849e52c0
FS:  00007fef7bf33700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90007731480 CR3: 000000001ef3e000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 drm_fb_helper_sys_imageblit+0x18/0x40 drivers/gpu/drm/drm_fb_helper.c:794
 drm_fbdev_fb_imageblit+0x4b/0xa0 drivers/gpu/drm/drm_fb_helper.c:2276
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:139 [inline]
 bit_putcs+0x33c/0x590 drivers/video/fbdev/core/bitblit.c:188
 fbcon_putcs+0x13f/0x1a0 drivers/video/fbdev/core/fbcon.c:1296
 do_update_region+0x163/0x230 drivers/tty/vt/vt.c:676
 invert_screen+0x105/0x280 drivers/tty/vt/vt.c:800
 highlight drivers/tty/vt/selection.c:57 [inline]
 clear_selection+0x48/0x60 drivers/tty/vt/selection.c:84
 vc_do_resize+0x60b/0x6f0 drivers/tty/vt/vt.c:1257
 fbcon_do_set_font+0x188/0x2a0 drivers/video/fbdev/core/fbcon.c:2397
 fbcon_set_font+0x333/0x450 drivers/video/fbdev/core/fbcon.c:2483
 con_font_set drivers/tty/vt/vt.c:4666 [inline]
 con_font_op+0x238/0x4b0 drivers/tty/vt/vt.c:4710
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0xd05/0x1890 drivers/tty/vt/vt_ioctl.c:752
 tty_ioctl+0x114/0xb00 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46a9a9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fef7bf32c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046a9a9
RDX: 0000000020000080 RSI: 0000000000004b72 RDI: 0000000000000004
RBP: 00000000004e4042 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078c0a0
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007fff66610a60
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: ffffc90007731480
---[ end trace b77be2f6638c5c66 ]---
RIP: 0010:fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
RIP: 0010:sys_imageblit+0x48c/0x830 drivers/video/fbdev/core/sysimgblt.c:275
Code: 04 41 0f be 5d 00 83 fd 1f 0f 87 75 03 00 00 e8 5a d5 f9 fe 89
e9 8b 44 24 14 d3 fb 23 5c 24 08 41 23 04 9f 33 44 24 04 85 ed <41> 89
44 24 fc 75 b9 e8 38 d5 f9 fe 49 83 c5 01 bd 08 00 00 00 e8
RSP: 0018:ffffc9000928f890 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000007
RDX: 0000000000040000 RSI: ffffffff823dbcd6 RDI: ffffc9000928f9f0
RBP: 0000000000000007 R08: 0000000000000018 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffffc90007731484
R13: ffff88810496f13c R14: ffffc90007731500 R15: ffffffff849e52c0
FS:  00007fef7bf33700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90007731480 CR3: 000000001ef3e000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
----------------
Code disassembly (best guess):
   0: 04 41                add    $0x41,%al
   2: 0f be 5d 00          movsbl 0x0(%rbp),%ebx
   6: 83 fd 1f              cmp    $0x1f,%ebp
   9: 0f 87 75 03 00 00    ja     0x384
   f: e8 5a d5 f9 fe        callq  0xfef9d56e
  14: 89 e9                mov    %ebp,%ecx
  16: 8b 44 24 14          mov    0x14(%rsp),%eax
  1a: d3 fb                sar    %cl,%ebx
  1c: 23 5c 24 08          and    0x8(%rsp),%ebx
  20: 41 23 04 9f          and    (%r15,%rbx,4),%eax
  24: 33 44 24 04          xor    0x4(%rsp),%eax
  28: 85 ed                test   %ebp,%ebp
* 2a: 41 89 44 24 fc        mov    %eax,-0x4(%r12) <-- trapping instruction
  2f: 75 b9                jne    0xffffffea
  31: e8 38 d5 f9 fe        callq  0xfef9d56e
  36: 49 83 c5 01          add    $0x1,%r13
  3a: bd 08 00 00 00        mov    $0x8,%ebp
  3f: e8                    .byte 0xe8
