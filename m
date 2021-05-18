Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CBF38765F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348446AbhERKZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbhERKZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:25:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA194C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:24:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so1202615wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZzcYCHi4oczNX5v8RqtwGoJp8057rvZdCwxA6gSVHSI=;
        b=YMJuF44+fHnixYFA+J38p2ON5BsdYljj/LxfEg6ub/dZl3DnzOOewy5zNHc6EoGxHJ
         dxM3p+UyeD1AS6KLsR0FLu8gpVN41O5YtaW3l+SsdBFV7v6FWS0SKeGNuQNuAcJu2c46
         MO+aTcs5g9P3zPuAbk92gIKBf7GJwAFh+JfjP4mm+3zTOw1JPqMScYHfamQdpkC+H9l3
         byUI4TM7gUa6dwzvShtbsMS34PIa6/Cu6rrZFaTsyT/kxmlrHIrIho9VU/QMxpSKfIzL
         w1lC0ndh2GEM5YoL0G2ocgwbCTf2NJvuSisQ6R6UlVXhX9n6H3Tm43/zQB2+1AJY8LXN
         p45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZzcYCHi4oczNX5v8RqtwGoJp8057rvZdCwxA6gSVHSI=;
        b=ko1n6grph7at6dIr541/YecSLI5PxBSNByz2Y+E40pyeFM4E81lJj3qSrknN6Ea3jg
         p0PpHXSGBvqRB8kVk04uL4pLpo1ixqoiUf+bkMd8RkWDHO0UTRfgnha/qm8kYCUEIjaX
         4itL2bSBmdyIC3eTOHoaXbrJQIuJ7LYYWKmXprq61/U701+p2pmU07CuNYMwg9uk/43/
         rusEfiWURVi58VPUTsZCJdHt+hUA2V8lUugMRokdhZrPzkTw/PkHjJUC3HY+kwmNrmf0
         SBZhrqW1vLuTdU1zD5DlW5uL1zMfodvS3mq5betGR4ef7jlPsocYL8WUnRg24VzFzUfF
         0GQw==
X-Gm-Message-State: AOAM530Ksa/uBnk9xs59Pwwgz9LbDrEmfqBjE9tcb40Oir71NIYOxPno
        WZEmFN+JcyJYOL3oxMSmPLo=
X-Google-Smtp-Source: ABdhPJwbUiO6MWpfSFN+cfQmihen4aG+jx9u0Zls1xEI1ynCHK9FC0da6y/BZ3nKoKoZQXzAhB6zPg==
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr4736696wmh.42.1621333453921;
        Tue, 18 May 2021 03:24:13 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id s83sm17005964wms.16.2021.05.18.03.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 03:24:13 -0700 (PDT)
Date:   Tue, 18 May 2021 12:24:12 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: REGRESSION: initrd is disabled due to memory overlap
Message-ID: <YKOVzLHGcHoVTqSi@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On my SSI1328 gemini board, I use initrd=0x800000,9M in cmdline.
On next-20210518 and 5.13-rc1 I got:
Booting Linux on physical CPU 0x0
Linux version 5.13.0-rc2-next-20210518+ (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 10.2.0-r5 p6) 10.2.0, GNU ld (Gentoo 2.35.2 p1) 2.35.2) #77 PREEMPT Tue May 18 12:14:41 CEST 2021
CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
CPU: VIVT data cache, VIVT instruction cache
OF: fdt: Machine model: SSI 1328
Memory policy: Data cache writeback
INITRD: 0x00800000+0x00900000 overlaps in-use memory region - disabling initrd
Zone ranges:
  Normal   [mem 0x0000000000000000-0x0000000007ffffff]
  HighMem  empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
Built 1 zonelists, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS0,19200n8 initrd=0x800000,9M
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
Memory: 117480K/131072K available (5459K kernel code, 595K rwdata, 1508K rodata, 180K init, 376K bss, 13592K reserved, 0K cma-reserved, 0K highmem)

On 5.12, initrd is used and works.

I bisected the problem, but without any result:
git bisect start
# bad: [6efb943b8616ec53a5e444193dccf1af9ad627b5] Linux 5.13-rc1
git bisect bad 6efb943b8616ec53a5e444193dccf1af9ad627b5
# good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
git bisect good 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
# good: [6c0029211382011af508273c4fc98a732f841d95] Merge tag 'for-5.13/block-2021-04-27' of git://git.kernel.dk/linux-block
git bisect good 6c0029211382011af508273c4fc98a732f841d95
# bad: [9d31d2338950293ec19d9b095fbaa9030899dcb4] Merge tag 'net-next-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad 9d31d2338950293ec19d9b095fbaa9030899dcb4
# good: [3e1b0c168f6c8648f217c78ed6a4135af8c9d830] netfilter: flowtable: add vlan match offload support
git bisect good 3e1b0c168f6c8648f217c78ed6a4135af8c9d830
# good: [3644286f6cbcea86f6fa4d308e7ac06bf2a3715a] Merge tag 'fsnotify_for_v5.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
git bisect good 3644286f6cbcea86f6fa4d308e7ac06bf2a3715a
# good: [96874c619c200bc704ae2d8e34a3746350922135] net: stmmac: Add HW descriptor prefetch setting for DWMAC Core 5.20 onwards
git bisect good 96874c619c200bc704ae2d8e34a3746350922135
# good: [eb43c081a6df85e3119226b932ddb9a9572b26e4] Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next
git bisect good eb43c081a6df85e3119226b932ddb9a9572b26e4
# good: [0711459095bc9ddb5a0086146d2751e6d5412cbf] Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next
git bisect good 0711459095bc9ddb5a0086146d2751e6d5412cbf
# good: [635de956a7f5a6ffcb04f29d70630c64c717b56b] Merge tag 'x86-mm-2021-04-29' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 635de956a7f5a6ffcb04f29d70630c64c717b56b
# good: [f89271f09f589b8e9f98a9d3373d4868d3e668a5] Merge https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect good f89271f09f589b8e9f98a9d3373d4868d3e668a5
# good: [4a52dd8fefb45626dace70a63c0738dbd83b7edb] net: selftest: fix build issue if INET is disabled
git bisect good 4a52dd8fefb45626dace70a63c0738dbd83b7edb
# first bad commit: [9d31d2338950293ec19d9b095fbaa9030899dcb4] Merge tag 'net-next-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next

Regards
