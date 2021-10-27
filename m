Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC11943BEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhJ0B0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbhJ0B0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:26:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D3DC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:24:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v20so823102plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXsJNd5q6gyQSVEjEuTnLLXYzsPTKanmnHoHbci90to=;
        b=eX4CXGovCUzUafOweFaJs8Y3wIqmn6BZbxU1qZGgWIq6y+A/txciIPhVIQ3LVYHE1c
         YiJDkyVrm1cRooKON14Rmlrs10ANk7Tgsx9ENzMOwhvaqstdeHZh13i9Cr2RMY+fVpON
         Mr9Mzv/HjXPoiRK/WeFLXyNimHUUMfYsDagjOBIcvtcvNlhMEg1pa7HL2lqIDpNpWH4d
         65QSekSwmIEHD3OKgYIIKhhdSHG00ea2WLQtrjGHGMQ2Xqddq9vwkm1pnVlcCxYAd8BO
         e6l2LLswoa/EK2XcTreccplhSeu7/60H9RxpkiIpJTF9FmPzGLCKL28KL/NKYBSPqMvF
         y/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXsJNd5q6gyQSVEjEuTnLLXYzsPTKanmnHoHbci90to=;
        b=TjZhlR0wdCBKapEMTTz5iqSpYziIqWkOR+J5k7X57Q59nUHn0jmYB3UN3eN41JI+bN
         +m/96sz0lFCG7tCfavXKjFd+936Gckl3JdAmiozRR9HivH2vkehZXcUT9Df+wqyBx3L6
         YTpabvzEyHSqGO9OkjMXTYkAJQZeavqwMzmM4EpPUqyQIQfHV+0fCrqcCwdKWwpWVuEv
         RYdYlwncD1DzV7m6/+rq+X69BhSk2d5/UN+xXgs0/gn+0Frwd/8h9tQooSH7ArYkXAOY
         wZbqcnXiK7oXGYGprDSmbBFhQQLMuSmic/fUdsOqCy6o7mp2o6PgrYrdqHCdzTZMkvpV
         C/lw==
X-Gm-Message-State: AOAM531ynikiywBpI5+zEiCZbKIiclrk82N/EOfXNatvX0iRvx1VUlpq
        EIiJvjlokUUCtE+UFnfHcnX4E4w2uRWYzMq9jw==
X-Google-Smtp-Source: ABdhPJyim1ZRMJz/pIsljW0kD122bfzVJYTOrh9QpF08WjmRXFBnCI46VAGTSpzjmNImiQhOTq9kuzMM+zOkucqGNN4=
X-Received: by 2002:a17:902:7b84:b0:13b:90a7:e270 with SMTP id
 w4-20020a1709027b8400b0013b90a7e270mr25414939pll.21.1635297852720; Tue, 26
 Oct 2021 18:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZ5cRX5t0wCr2MfjBp4=-Utn43MzZD4uEyzznvWuUz05A@mail.gmail.com>
In-Reply-To: <CACkBjsZ5cRX5t0wCr2MfjBp4=-Utn43MzZD4uEyzznvWuUz05A@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 27 Oct 2021 09:23:59 +0800
Message-ID: <CACkBjsa6YhKgq0RjZiE1+32+fe+fn=oT=fC4rN+1MPznZL+bnA@mail.gmail.com>
Subject: Re: UBSAN: shift-out-of-bounds in extAlloc
To:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This bug can still be triggered repeatedly on the latest Linux.

HEAD commit: 519d81956ee2 Linux 5.15-rc6
git tree: upstream
console output:
kernel config: https://drive.google.com/file/d/12PUnxIM1EPBgW4ZJmI7WJBRaY1lA83an/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1658MoTb5EbxCtbsoI--hNQLab0HogUWf/view?usp=sharing

loop13: detected capacity change from 0 to 65534
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_extent.c:511:16
shift exponent -1 is negative
CPU: 2 PID: 31142 Comm: syz-executor Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
ubsan_epilogue+0xb/0x5a lib/ubsan.c:151
__ubsan_handle_shift_out_of_bounds.cold+0x76/0x144 lib/ubsan.c:330
extBalloc fs/jfs/jfs_extent.c:511 [inline]
extAlloc.cold+0x1a/0x92 fs/jfs/jfs_extent.c:125
jfs_get_block+0x662/0xaa0 fs/jfs/inode.c:257
get_more_blocks fs/direct-io.c:673 [inline]
do_direct_IO fs/direct-io.c:959 [inline]
do_blockdev_direct_IO+0x129e/0x6ce0 fs/direct-io.c:1276
blockdev_direct_IO include/linux/fs.h:3272 [inline]
jfs_direct_IO+0x10a/0x2c0 fs/jfs/inode.c:342
generic_file_direct_write+0x1e3/0x4c0 mm/filemap.c:3672
__generic_file_write_iter+0x2d3/0x640 mm/filemap.c:3854
generic_file_write_iter+0xd7/0x220 mm/filemap.c:3929
call_write_iter include/linux/fs.h:2163 [inline]
do_iter_readv_writev+0x47b/0x750 fs/read_write.c:729
do_iter_write fs/read_write.c:855 [inline]
do_iter_write+0x18b/0x700 fs/read_write.c:836
vfs_iter_write+0x70/0xa0 fs/read_write.c:896
iter_file_splice_write+0x723/0xbf0 fs/splice.c:689
do_splice_from fs/splice.c:767 [inline]
direct_splice_actor+0x110/0x180 fs/splice.c:936
splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
do_splice_direct+0x1b3/0x280 fs/splice.c:979
do_sendfile+0xab6/0x1240 fs/read_write.c:1249
__do_sys_sendfile64 fs/read_write.c:1314 [inline]
__se_sys_sendfile64 fs/read_write.c:1300 [inline]
__x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8d8f6f5c4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8d8cc5dc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f8d8f81c0a0 RCX: 00007f8d8f6f5c4d
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 0000000000000007
RBP: 00007f8d8f76ed80 R08: 0000000000000000 R09: 0000000000000000
R10: 00008400fffffffb R11: 0000000000000246 R12: 00007f8d8f81c0a0
R13: 00007ffea1a878ff R14: 00007ffea1a87aa0 R15: 00007f8d8cc5ddc0
================================================================================
