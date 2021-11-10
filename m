Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026C144B9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 02:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhKJBXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 20:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhKJBXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:23:35 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95FDC061764;
        Tue,  9 Nov 2021 17:20:48 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so698297pjj.0;
        Tue, 09 Nov 2021 17:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=XCSR5iwGqGEBhi6PnLhH0qauR+M79oBnHfHwY8wLXAQ=;
        b=C2XYj00vc0AopmrYfgu/fZXDCXFakY28FRIGUQ1sS2X28aGT0u2/1iC7Q4hczdoyJr
         Jg9gTBYMgD42WoJ5I1I2kbd722u93omHz+cvhG/Z3/UjGKBrbCOuiBG8S1893oGW9nMt
         BW6wi4bVicCPKNjTdA8EEq+OG8PA9UUMGxRFkmaCS0SEeblMrCZuwAO34iAejDlohCzk
         IbASLjI9zLug9emQbcU4mjNLhm7IT/xHeJ8E/kArDfyX+lePEwscvn05qR1po4sI79G2
         iYgsFub0PIQlwrQJ37nsdorPNFkjYTMz5bXDOBrMZX0nWx7tqLHU0UPloWnJUHBFTvOX
         0FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XCSR5iwGqGEBhi6PnLhH0qauR+M79oBnHfHwY8wLXAQ=;
        b=m4ORJC/INp9u4pVrCnpk9uSbQZpEN4tOgsIbUvGWkiMSTlNWFrtAaJqTYfcoL/5/oP
         n0CENOnArQrtgpnSm80kj/D49XzkqCKmCO3i0ASBLZwx8nzKtXD0pM7M2evvVsVSrpPK
         fKJLQJ+5r7gYbR0u1NC4ASBNp3h4WqzHrGvNfmSB4yvQgd6y9Dr4VSD+8gQ7IFrSA57a
         grslb3OXUiLyA4ABSdA4CMB/7vSCi34YjKsmS5dbOmFcv4eDBoPWmJTEAomFd+6xfDVZ
         /XEGmw28tTIn2RbdHlhtmB0wkQsMViZvwGWjV64RXwrhrvdgq4I7S9O4OjtQBkV6ydIs
         91hQ==
X-Gm-Message-State: AOAM532YoxdaYwkj+lnqXFrQYHMM54Z7EUbKCtNwN3TADCsEkFnUYZcd
        mUaSPkAVviv8aS7MV88qTWabp/SsHOzLgvMHaZh2VPeUZ9i5ZKfBHA==
X-Google-Smtp-Source: ABdhPJyjNB39y6S7jrRV0AVGeZPvOKiJj/8ancLMTAlS93BByq/0PacMbe38F8Gg3tWiZh4F0p+6WJXzKqXVPTylh04=
X-Received: by 2002:a17:903:2348:b0:141:d60b:ee90 with SMTP id
 c8-20020a170903234800b00141d60bee90mr11381103plh.15.1636507248024; Tue, 09
 Nov 2021 17:20:48 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 10 Nov 2021 09:20:38 +0800
Message-ID: <CACkBjsasF+eDp4_dtvTBr9Thg-9RyYOQg3nwvRFuu+r3XecHig@mail.gmail.com>
Subject: WARNING in __folio_mark_dirty
To:     konishi.ryusuke@gmail.com, linux-nilfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        akpm@linux-foundation.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 6b75d88fa81b Merge branch 'i2c/for-current'
git tree: upstream
console output: https://paste.ubuntu.com/p/C22bhzvZP6/
kernel config: https://paste.ubuntu.com/p/b62Hp7BfJn/
C reproducer: https://paste.ubuntu.com/p/2mchRNDJr4/
Syzlang reproducer: https://paste.ubuntu.com/p/xM3DQ2f5Qz/

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

NILFS (loop10): segctord starting. Construction interval = 5 seconds,
CP frequency < 30 seconds
------------[ cut here ]------------
WARNING: CPU: 3 PID: 18327 at include/linux/backing-dev.h:269
inode_to_wb include/linux/backing-dev.h:269 [inline]
WARNING: CPU: 3 PID: 18327 at include/linux/backing-dev.h:269
folio_account_dirtied mm/page-writeback.c:2460 [inline]
WARNING: CPU: 3 PID: 18327 at include/linux/backing-dev.h:269
__folio_mark_dirty+0xab2/0xe80 mm/page-writeback.c:2509
Modules linked in:
CPU: 3 PID: 18327 Comm: segctord Not tainted 5.15.0+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:inode_to_wb include/linux/backing-dev.h:269 [inline]
RIP: 0010:folio_account_dirtied mm/page-writeback.c:2460 [inline]
RIP: 0010:__folio_mark_dirty+0xab2/0xe80 mm/page-writeback.c:2509
Code: ff ff ff 48 8d 78 70 e8 8c 69 96 07 31 ff 89 c6 89 44 24 10 e8
ff 52 d8 ff 8b 44 24 10 85 c0 0f 85 13 fa ff ff e8 8e 51 d8 ff <0f> 0b
e9 07 fa ff ff e8 82 51 d8 ff e8 9d 6a 96 07 31 ff 41 89 c7
RSP: 0018:ffffc900076ef7c0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88802c478378 RCX: ffff88802fc33980
RDX: 0000000000000000 RSI: ffff88802fc33980 RDI: 0000000000000002
RBP: ffffea0000b7ca80 R08: ffffffff819f0012 R09: 0000000000000000
R10: 0000000000000005 R11: fffff9400016f950 R12: 0000000000000246
R13: ffff88802c478138 R14: 0000000000000001 R15: 0000000000000001
FS: 0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056054d573c18 CR3: 0000000021c4e000 CR4: 0000000000350ee0
Call Trace:
<TASK>
__set_page_dirty include/linux/pagemap.h:784 [inline]
mark_buffer_dirty+0x501/0x6a0 fs/buffer.c:1108
nilfs_btree_propagate_p fs/nilfs2/btree.c:1889 [inline]
nilfs_btree_propagate+0x4ba/0xce0 fs/nilfs2/btree.c:2085
nilfs_bmap_propagate+0x73/0x170 fs/nilfs2/bmap.c:337
nilfs_collect_dat_data+0x45/0xd0 fs/nilfs2/segment.c:625
nilfs_segctor_apply_buffers+0x149/0x480 fs/nilfs2/segment.c:1009
nilfs_segctor_scan_file+0x3d9/0x570 fs/nilfs2/segment.c:1058
nilfs_segctor_collect_blocks+0xa33/0x2fb0 fs/nilfs2/segment.c:1224
nilfs_segctor_collect fs/nilfs2/segment.c:1494 [inline]
nilfs_segctor_do_construct+0x1228/0x5ef0 fs/nilfs2/segment.c:2036
nilfs_segctor_construct+0x79f/0xb10 fs/nilfs2/segment.c:2372
nilfs_segctor_thread_construct fs/nilfs2/segment.c:2480 [inline]
nilfs_segctor_thread+0x3be/0xe40 fs/nilfs2/segment.c:2563
kthread+0x405/0x4f0 kernel/kthread.c:327
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
</TASK>
