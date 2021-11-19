Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871A54567DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 03:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhKSCKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 21:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhKSCKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 21:10:54 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53784C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 18:07:53 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 28so7220462pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 18:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/E5YbLCgj0qYAmaRMzm+csLlxRRBB6J73kLY09p9kMA=;
        b=Scpjwb7CfQN41UBUFwKVHsu+sTysCuIwCWRrnCa/jZDn5dl7+nQZA27ZbVnY3eMF9v
         4EuXQ+6AchxIZpgpdAGqhEBj12HtMAtKSGcunbD/5w5mGd8U5ZJty3nQTrDFPF6rAvg5
         I0zFmUpQxF7d8TLHEs6933OOGsEXw0Boe4G/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/E5YbLCgj0qYAmaRMzm+csLlxRRBB6J73kLY09p9kMA=;
        b=4RH4Ly4jKG75LNHeh+rpBpfUUXCMd6+BUbrk7bVawGj7PJQRbDGEDUg9DfIk7YZhEi
         bVoqr4eHjIX2UoJbAA7QqI0C3AKsGPnqv8/IXI6oOHzmp//I2B8eWwmiX13fqjfWlgeh
         qbtFrz+M0C7NygT2trp9SXzPkdE4Qu2GtN1QJX9I6jgNDAT5vMRauqF0fu1s6tajb82F
         gOwF/x1l+Uh3I1tmTmZxIHMnmjjtcCiwY+sX2+pMMfW8wN7IALIi7+vS2QOTq+bI5VGF
         0pe4mukScg9O+JG/xDbZU4OHtkpm2SSVSgUnLVDNCJ4Exgc2YtT/BQ/1QPZ6QOt74m7q
         E3FQ==
X-Gm-Message-State: AOAM531bJvBL3svxjwkAU3YeFZHWl8rvY1b2UOK1kx60pyfNhthozV4G
        Urs5ChvqGdBixnLTQJN6axjs0g==
X-Google-Smtp-Source: ABdhPJw5qWjzDItxnffOwBfIoPka7CSIpAIa7NqjP5EFsdVpj4otr00Z/3WiKXX02KrcNqSVU6KTEg==
X-Received: by 2002:a63:8bca:: with SMTP id j193mr13138617pge.231.1637287672847;
        Thu, 18 Nov 2021 18:07:52 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:f3c1:d25d:4dc6:f786])
        by smtp.gmail.com with ESMTPSA id p17sm678080pgj.93.2021.11.18.18.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 18:07:52 -0800 (PST)
Date:   Fri, 19 Nov 2021 11:07:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: mm: gdb fails if binary is on a DAX-enabled filesystem
Message-ID: <YZcG82pQUTK3sIuD@google.com>
References: <YZb7PgQ6Bw26cpsh@google.com>
 <CAPcyv4h_S_fgD8EY2qX9zqFPz__1uCByZUoPvosZDUvjRp3Jzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h_S_fgD8EY2qX9zqFPz__1uCByZUoPvosZDUvjRp3Jzg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/11/18 17:35), Dan Williams wrote:
> > We are running into issues on a DAX enabled system: both
> > __copy_from_user_inatomic() fail.
> >
> > [   28.914865] ------------[ cut here ]------------
> > [   28.915800] WARNING: CPU: 0 PID: 106 at mm/memory.c:2822 wp_page_copy+0x136/0x320
> > [   28.916857] CPU: 0 PID: 106 Comm: gdb Not tainted 5.15.0-01277-g6be711548944 #1
> > [   28.917823] Hardware name: ChromiumOS crosvm, BIOS 0
> > [   28.918455] RIP: 0010:wp_page_copy+0x136/0x320
> > [   28.919001] Code: f1 79 00 4c 89 7b 50 48 8b 43 38 31 d2 49 39 07 75 23 48 8b 7d c8 48 8b 75 c0 ba 00 10 00 00 e8 6f 23 78 00 b2 01 85 c0 74 0b <0f> 0b 48 8b 7d c8 e8 8e 1f 78 00 48 8b 7b 58 88 55 c8 e8 2e f2 79
> > [   28.920642] RSP: 0018:ffffc900005dfbd8 EFLAGS: 00010206
> > [   28.921135] RAX: 0000000000001000 RBX: ffffc900005dfc40 RCX: 0000000000001000
> > [   28.921762] RDX: 0000000000001001 RSI: 0000000000448000 RDI: ffff8880007bb000
> > [   28.922410] RBP: ffffc900005dfc28 R08: ffff8880031884c8 R09: 0000000000000000
> > [   28.923058] R10: ffff88800f8234c8 R11: 0000000000000000 R12: ffffea000001eec0
> > [   28.923718] R13: 0000000000000000 R14: ffff88800e18e630 R15: ffff888000884240
> > [   28.924404] FS:  00007e5b49744180(0000) GS:ffff88800f800000(0000) knlGS:0000000000000000
> > [   28.925146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   28.925688] CR2: 0000000000448000 CR3: 000000000e0d6000 CR4: 0000000000350eb0
> > [   28.926368] Call Trace:
> > [   28.926622]  __handle_mm_fault+0x67e/0xbd7
> > [   28.927018]  handle_mm_fault+0x16b/0x23d
> > [   28.927390]  __get_user_pages+0x2d6/0x4b7
> > [   28.927797]  __get_user_pages_remote+0xbe/0x20c
> > [   28.928224]  __access_remote_vm+0xb3/0x1c8
> > [   28.928655]  ptrace_access_vm+0x97/0xb0
> > [   28.929036]  generic_ptrace_pokedata+0x22/0x31
> > [   28.929452]  arch_ptrace+0x1ce/0x1dd
> > [   28.929801]  __do_sys_ptrace+0xa9/0xda
> > [   28.930161]  do_syscall_64+0x75/0x8b
> > [   28.930511]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [   28.930996] RIP: 0033:0x7e5b4c86fe5a
> > [   28.931332] Code: 70 41 83 f8 03 c7 44 24 10 08 00 00 00 48 89 44 24 18 48 8d 44 24 30 8b 70 08 4c 0f 43 d1 48 89 44 24 20 b8 65 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3e 48 85 c0 78 06 41 83 f8 02 76 1b 48 8b 4c
> > [   28.933086] RSP: 002b:00007ffdc3369150 EFLAGS: 00000202 ORIG_RAX: 0000000000000065
> > [   28.933767] RAX: ffffffffffffffda RBX: 0000000000448620 RCX: 00007e5b4c86fe5a
> > [   28.934476] RDX: 0000000000448620 RSI: 000000000000006d RDI: 0000000000000005
> > [   28.935206] RBP: 0000000000000001 R08: 0000000000000004 R09: 0000000000448620
> > [   28.935916] R10: 00841f0f2e6666cc R11: 0000000000000202 R12: 0000000000000001
> > [   28.936672] R13: 00841f0f2e6666cc R14: 0000000000000000 R15: 00007e5b49743958
> > [   28.937389] ---[ end trace 2808c0ffd7259839 ]---
> > Program received signal SIGSEGV, Segmentation fault.
> >
> > Is there anything we can do about it?
> 
> I'll take a look, can you send a bit more info about your
> configuration? Which filesystem, and which driver is providing the dax
> access?

The 'shared' directory is on ext4 on the host and is mounted in the guest
VM as mount -t virtiofs -o dax shared /mnt
