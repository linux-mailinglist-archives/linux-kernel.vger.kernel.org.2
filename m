Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B633B0E72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhFVUSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFVUSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:18:35 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37889C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:16:19 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id c26so206278vso.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C767tPdPdMoTyOta+1ttzfqbko9nfCsk2O/+WzaTSOc=;
        b=brsp2b6GVfjwXNcqR2+Qwfm6Fvs7W9Zb8Zn4KFCLs0CY1f1BwuGWwZYrwhZbudPH1+
         lJhJglZA1LL0iEJ+qeSpSp6D77Y1qN5OEN3a63A/BFY2t1nUhmFzPgfs/lEk8/qFOzn3
         CK8qTWVM0sDLUdkgcv1yRy1SNqdo0rU1HA5ww/eQCkev99yRXErh0SkON2OSxCs244ZE
         Jzabknghr5ZFRcGCVwkYoPEzIgMBUBLL/C8+1lX2B+yxT6KaSp8qLKFtBdifa25tXLp6
         KDPV0b/lH4D9iDFO+nDg2FlY/9HYE/s54f63iV/To43CAR9pk+2bG8ndyuasBjsUHvmD
         fgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C767tPdPdMoTyOta+1ttzfqbko9nfCsk2O/+WzaTSOc=;
        b=eJT7Hkpq2N3T9ELPPASifmE1YJxBO743oIebbqQu0SIXHeP7Ndy5vXDEbSlJTYqrm0
         7wNHEpokSaM0jk9Hu4GZAPy8C2K0VLxhwN5wlLerj5AJYFTnm41u8OaPGht0fOhCI0tb
         YqPEKpqbJFQZpJxGrhWs4giSlePDds8Yq16ispcgB1J7IGzcXo+hdX0fftl34Jh/9LbY
         bYOP49wLn8yZKkZ0nPkZqJ8cZpBdUb65huSQHMYrzMRBkOznqWNY1GgDLkekUfbZlX0H
         6tsoNPzZRNqNUU8TfLR2OWPlkkFxQSb1exlzO5t30C56X83igNgDkUhZRpGg93hG8jZW
         72Nw==
X-Gm-Message-State: AOAM533/Kk6X9KVZK2815lR3PBj+emGduOuAtUeYagu5c4utt0kBFwta
        /qUBSDUrtHDm3spH1qYj0Q2j41/jybXnZyiTHhI=
X-Google-Smtp-Source: ABdhPJwl5YHZlpHVwKERaOMdceiaG0z1359qLrs+ioFKajlKoThSbOVGz5t1kfVs/copPPM8Bds5BjMmoeVFn8KRjPU=
X-Received: by 2002:a67:6948:: with SMTP id e69mr25073072vsc.26.1624392978322;
 Tue, 22 Jun 2021 13:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxxH9KVgJ7k0P5LX3fTSa4Pumcmu2NMC4P=TrGDVXE2ktQ@mail.gmail.com>
 <YNIaFnfnZPGVd1t3@codewreck.org> <CAJfuBxywD3QrsoGszMnVbF2RYcCF7r3h7sCOg6hK7K60E+4qKA@mail.gmail.com>
In-Reply-To: <CAJfuBxywD3QrsoGszMnVbF2RYcCF7r3h7sCOg6hK7K60E+4qKA@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Tue, 22 Jun 2021 14:15:52 -0600
Message-ID: <CAJfuBxw-JUpnENT9zNgTq2wdHqH-77pAjNuthoZYbtiCud4T=g@mail.gmail.com>
Subject: Re: [V9fs-developer] KCSAN BUG report on p9_client_cb / p9_client_rpc
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     kasan-dev@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 >
> > I had assumed the p9_req_put() in p9_client_cb would protect the tag,
> > but that doesn't appear to be true -- could you try this patch if this
> > is reproductible to you?
> >
>
> I applied your patch on top of my triggering case, it fixes the report  !
> you have my tested-by

I seem to have gotten ahead of my skis,
Im seeing another now, similar to 1st, differing in 2nd block

[    8.730061] Run /bin/sh as init process
[    9.027218] ==================================================================
[    9.028237] BUG: KCSAN: data-race in p9_client_cb / p9_client_rpc
[    9.029073]
[    9.029282] write to 0xffff888005e45ea0 of 4 bytes by interrupt on cpu 0:
[    9.030214]  p9_client_cb+0x1a/0x100
[    9.030735]  req_done+0xd3/0x130
[    9.031171]  vring_interrupt+0xac/0x130
[    9.031752]  __handle_irq_event_percpu+0x64/0x260
[    9.032381]  handle_irq_event+0x93/0x120
[    9.032950]  handle_edge_irq+0x123/0x400
[    9.033502]  __common_interrupt+0x3e/0xa0
[    9.034051]  common_interrupt+0x7e/0xa0
[    9.034608]  asm_common_interrupt+0x1e/0x40
[    9.035173]  native_safe_halt+0xe/0x10
[    9.035826]  default_idle+0xa/0x10
[    9.036299]  default_idle_call+0x38/0xc0
[    9.036845]  do_idle+0x1e7/0x270
[    9.037294]  cpu_startup_entry+0x19/0x20
[    9.037905]  rest_init+0xd0/0xd2
[    9.038354]  arch_call_rest_init+0xa/0x11
[    9.038922]  start_kernel+0xacb/0xadd
[    9.039444]  secondary_startup_64_no_verify+0xc2/0xcb
[    9.040140]
[    9.040369] read to 0xffff888005e45ea0 of 4 bytes by task 1 on cpu 1:
[    9.041283]  p9_client_rpc+0x185/0x860
[    9.041837]  p9_client_getattr_dotl+0x71/0x160
[    9.042645]  v9fs_inode_from_fid_dotl+0x21/0x160
[    9.043418]  v9fs_vfs_lookup.part.0+0x139/0x180
[    9.044059]  v9fs_vfs_lookup+0x32/0x40
[    9.044584]  __lookup_slow+0xc3/0x190
[    9.045095]  walk_component+0x1b8/0x270
[    9.045626]  link_path_walk.part.0.constprop.0+0x336/0x550
[    9.046425]  path_lookupat+0x59/0x340
[    9.046935]  filename_lookup+0x134/0x2a0
[    9.047484]  user_path_at_empty+0x6d/0x90
[    9.048145]  vfs_statx+0x79/0x1a0
[    9.048610]  __do_sys_newfstatat+0x1e/0x40
[    9.049173]  __x64_sys_newfstatat+0x4e/0x60
[    9.049755]  do_syscall_64+0x42/0x80
[    9.050233]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    9.050940]
[    9.051148] Reported by Kernel Concurrency Sanitizer on:
[    9.051893] CPU: 1 PID: 1 Comm: virtme-init Not tainted
5.13.0-rc7-dd7i-00038-g4e27591489f1-dirty #126
[    9.053185] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.14.0-3.fc34 04/01/2014
[    9.054358] ==================================================================




>
> > The tag is actually reclaimed in the woken up p9_client_rpc thread so
> > that would be a good match (reset in the other thread vs. read here),
> > caching the value is good enough but that is definitely not obvious...
> >
> > --
> > Dominique
