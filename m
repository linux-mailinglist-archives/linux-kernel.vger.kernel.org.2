Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4516B4284D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 03:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhJKBqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 21:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhJKBqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 21:46:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B633C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 18:44:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so13540337pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 18:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XHhGuz+XprWcRZlX2mia8Y6kjwxUAUx+3iJusRDWyfg=;
        b=hac24URoTl5lw7ZUyU/t5U8m74C4Qni855om3yf4J2+QCP+OjmyC9KC3NAOR/XfPgo
         3QbeXH37eqpwShP5+7kZw1FtZn7hJ/R7EbtiAxQ/QpfIGGHnOrS9s9dk5AlymEJGrYBY
         JihGdkNsPF41x3i0U8xcry4OQWdYAnaWc2/d97GATppo+N2TeAzxPJiSZs1tcJDsCYgS
         8cFf/ZvxfEGWsyiD70Z19N5fbh1hr6zq5EZQlJOjBVfF7G2cg6yCRFRqDP6N2nz3tZAx
         FaC4vQOuAa1ZtD/Q/bKBGK2PkL/q8d205AfFK/JyxUVIagBXgdIVwSa6CX9WT3EORx7Y
         IwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XHhGuz+XprWcRZlX2mia8Y6kjwxUAUx+3iJusRDWyfg=;
        b=4d5VSKc8y4rqBOquwPqHTtPH+w8+tebqR+nMS39yHOimJEQiqsgWBpNtNjCAJva+8I
         4ZGOLNLr/IIde4y1AqHXmpeWs+AwAP0ZN/6XPna2NrleVoP7gD5+N764raH8g1H+d6wQ
         hdMsnkvaE3SfxiqVrMnDY9esA4Ow0QtxB9xvj9XyaCxzQ2IW5w6SwG81zGPHepIVI+Hr
         szQzpQoYGjmOYNUcqZ7PSWQkXRzerzbHbqeK+YB31ljArdT8XDR9jkoa8mGi5uhxUQHt
         jhpJs+BFoQcm72l1sTioBr54gz8xGPkLoY+IDB+ap479OJwlPrGWmFQzpq5/6+6E42BB
         fzOg==
X-Gm-Message-State: AOAM530/j3VsuhPpOo/YnVZVkke/buxb2kRLnMvyERqmUK3+hBFoWucM
        2TkFrHtkcikKQn5v57S/jCN0jkFjaEi+iPesULmFYnsK2hyP
X-Google-Smtp-Source: ABdhPJwoPyl/vws4WDbd76yyRcCCa83VSVOCjTGZp7jj2tOM8W7CVSREIu5ltxZoYLWBrgK0LhlMMdoZ/FID64aRiYI=
X-Received: by 2002:a17:902:7b84:b0:13b:90a7:e270 with SMTP id
 w4-20020a1709027b8400b0013b90a7e270mr21910103pll.21.1633916661767; Sun, 10
 Oct 2021 18:44:21 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 11 Oct 2021 09:44:11 +0800
Message-ID: <CACkBjsZ5cRX5t0wCr2MfjBp4=-Utn43MzZD4uEyzznvWuUz05A@mail.gmail.com>
Subject: UBSAN: shift-out-of-bounds in extAlloc
To:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 60a9483534ed Merge tag 'warning-fixes-20211005'
git tree: upstream
console output:
https://drive.google.com/file/d/1IM13hIeSrriEEkaACcmQaVYfOJ85xKZQ/view?usp=sharing
kernel config: https://drive.google.com/file/d/1u-ncYGLkq3xqdlNQYJz8-G6Fhf3H-moP/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop9: detected capacity change from 0 to 65534
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_extent.c:511:16
shift exponent -1 is negative
CPU: 0 PID: 12367 Comm: syz-executor Not tainted 5.15.0-rc4+ #22
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 ubsan_epilogue+0xa/0x4e lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds+0x161/0x182 lib/ubsan.c:330
 extBalloc fs/jfs/jfs_extent.c:511 [inline]
 extAlloc+0x699/0x6c0 fs/jfs/jfs_extent.c:125
 jfs_get_block+0x290/0x3f0 fs/jfs/inode.c:257
 nobh_write_begin+0x29d/0x990 fs/buffer.c:2648
 jfs_write_begin+0x37/0x80 fs/jfs/inode.c:321
 generic_perform_write+0xce/0x220 mm/filemap.c:3770
 __generic_file_write_iter+0x20d/0x240 mm/filemap.c:3897
 generic_file_write_iter+0x6d/0xd0 mm/filemap.c:3929
 call_write_iter include/linux/fs.h:2163 [inline]
 new_sync_write+0x18d/0x260 fs/read_write.c:507
 vfs_write+0x43b/0x4a0 fs/read_write.c:594
 ksys_write+0xd2/0x120 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f58ac19fc48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 00000000ffffff6a RSI: 0000000020043440 RDI: 000000000000000a
RBP: 00000000004e4809 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078c0a0
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffdbff36e60
================================================================================
