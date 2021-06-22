Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE03B0A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFVQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhFVQpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:45:42 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9740C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:43:25 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id c26so2659796vso.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vxFrkh6PfJNY2iqd2AHDe5xeAdZHifSt7a5NfrAQdks=;
        b=Umxe35UwNjjAj+hJrhbXSFm925lsc4u1dcC9gWmt/oNuXPcZf6IMOfyqWba1dlU7XR
         X4j1bnaCLRyZsrXH/XeRxFnDgPsmtS4xkAIG3JnBz2UXpEKN2FBe/RzmEu415j5XWea1
         oK4DVief2uEtFwqgktetSFFwgGh0IrziVEbNxLAZMJ5fooSbie2dHEF061ZIXRxb4BDN
         +JTEHPLyTkDSd3VisOkuY6f/10X/crO0vmAYvGuSFVdHRLJL6yH0j/BlSgUoAEjTOpLD
         8cGuKiMcvnZkaJcd1YtGQEEauTsE5Wn4dj+AsKrzRxXlF7OsL1U+4PFvfNmSX5FTjl99
         wZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vxFrkh6PfJNY2iqd2AHDe5xeAdZHifSt7a5NfrAQdks=;
        b=iYQVogH9++n9uDlJXxybkW6ss7/Peg12KgqkDgiaRV/W+gnIEoMGsThegP42zC8kDa
         5T3lIkgfC6DEFKpAstXbto87K6rkpeoAWKWfCIC/nk/mId7KvEJ27ybLNXGto8Gn58I7
         pCW1x+lzdrlEFkIz9ViWDtbKSZEdeM+eogb9IXuQDqPwvL2LSXJd3jW38Ux9eDVv3K4N
         HsKHYbsbYBT9Zgob61trga2DBmk6FNqLVHqp0eIotZoHee4ir78EYGDQZUqepspZTjMH
         a2ppIpSNqY6tYQjxRcnBtJ3bvUXCldZqdocTRtHSEXrsLchexhN3BIGNOZgiK4npNNGN
         HC/Q==
X-Gm-Message-State: AOAM533N9xak6b9sWlx266txvzWwJcGFeh+39j04Y4TE9qddnn/mwcB5
        IstB71YCqNDwMcY1v1smHH3g2GnWPEAaFCS0eXw=
X-Google-Smtp-Source: ABdhPJwWLkaCAb7h1X1XLmSqxGwnF3HXSwVDTLJg6WxGQusSIoHDNyvkJfDpkK3Yi9UK8mDI+q7uEu0/oTSyBYU2Ax8=
X-Received: by 2002:a05:6102:ed6:: with SMTP id m22mr10980416vst.60.1624380204705;
 Tue, 22 Jun 2021 09:43:24 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Tue, 22 Jun 2021 10:42:58 -0600
Message-ID: <CAJfuBxxH9KVgJ7k0P5LX3fTSa4Pumcmu2NMC4P=TrGDVXE2ktQ@mail.gmail.com>
Subject: KCSAN BUG report on p9_client_cb / p9_client_rpc
To:     kasan-dev@googlegroups.com, v9fs-developer@lists.sourceforge.net
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got this on rc7 + my hacks ( not near p9 )
ISTM someone here will know what it means.
If theres anything else i can do to help,
(configs, drop my patches and retry)
 please let me know



[   14.904783] ==================================================================
[   14.905848] BUG: KCSAN: data-race in p9_client_cb / p9_client_rpc
[   14.906769]
[   14.907040] write to 0xffff888005eb0360 of 4 bytes by interrupt on cpu 0:
[   14.907989]  p9_client_cb+0x1a/0x100
[   14.908485]  req_done+0xd3/0x130
[   14.908931]  vring_interrupt+0xac/0x130
[   14.909460]  __handle_irq_event_percpu+0x64/0x260
[   14.910095]  handle_irq_event+0x93/0x120
[   14.910637]  handle_edge_irq+0x123/0x400
[   14.911156]  __common_interrupt+0x3e/0xa0
[   14.911723]  common_interrupt+0x7e/0xa0
[   14.912270]  asm_common_interrupt+0x1e/0x40
[   14.912816]  native_safe_halt+0xe/0x10
[   14.913350]  default_idle+0xa/0x10
[   14.913801]  default_idle_call+0x38/0xc0
[   14.914361]  do_idle+0x1e7/0x270
[   14.914840]  cpu_startup_entry+0x19/0x20
[   14.915436]  rest_init+0xd0/0xd2
[   14.915878]  arch_call_rest_init+0xa/0x11
[   14.916428]  start_kernel+0xacb/0xadd
[   14.916927]  secondary_startup_64_no_verify+0xc2/0xcb
[   14.917613]
[   14.917819] read to 0xffff888005eb0360 of 4 bytes by task 261 on cpu 1:
[   14.918764]  p9_client_rpc+0x1cf/0x860
[   14.919340]  p9_client_walk+0xcf/0x350
[   14.919857]  v9fs_file_open+0x16c/0x340
[   14.920411]  do_dentry_open+0x298/0x6a0
[   14.920980]  vfs_open+0x58/0x60
[   14.921475]  path_openat+0x1130/0x1860
[   14.922126]  do_filp_open+0x116/0x1f0
[   14.922731]  do_sys_openat2+0x91/0x190
[   14.923267]  __x64_sys_openat+0x9b/0xd0
[   14.923790]  do_syscall_64+0x42/0x80
[   14.924295]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   14.924955]
[   14.925159] Reported by Kernel Concurrency Sanitizer on:
[   14.925899] CPU: 1 PID: 261 Comm: ip Not tainted
5.13.0-rc7-dd7i-00036-gb82eaba47adf-dirty #121
[   14.927094] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.14.0-3.fc34 04/01/2014
[   14.928292] ==================================================================
virtme-init: console is ttyS0
