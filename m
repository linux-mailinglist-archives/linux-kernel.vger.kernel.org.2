Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96F37ED59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386496AbhELUVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384873AbhELUC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:02:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292AEC06123A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:58:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w3so36781896ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=8raSgKhFeTJ6tUvtJ5IG4FsvccJ6867i6cPal0zUCUk=;
        b=IWDJpmN76GRZlr3FsUSPGtItLNdKRXXhRuHTrf20pdfSKSYkg8i4C42wuN8NSJ0p6x
         Gf8RIoWYCL8xON6tWkmvvzF0wf0IRScYWJIAtsG57GdPaoFQyUB6zVrlZzWOdTF8uHMS
         qW0Q4Li/ggTx/nxezJ3i6d5mCROoHkROU8aUNOK6NEIXKnCTQVu784hEJB4ie9l9xyM0
         Q6vb6B5/xfHioW4V08seYn5KhB6S5qBQtbqIPQ/dAE0nq7en+Xkx6Zv4OmPTnrAAl1Jz
         a69OreHSSt+8Xab5kI6mwtCmBO9frbmbbTAvI6JGslCTWb/woT9MWiXpj25vDnjpY086
         ENHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=8raSgKhFeTJ6tUvtJ5IG4FsvccJ6867i6cPal0zUCUk=;
        b=Cgc4bT9l6VqictnaUIiTBKhQg/uT1IREh5mmIcYBFR1MXI9kCexhW2Z5rCep2k8noF
         SGMPSh+j8ATv4bXgXwm7wyBKnGHS6lSmb8ton+9AEF5Ke36JZway4JgKcvU7P1PMM2Zo
         gu1TaMtTWNM88CrtT8CBNuI0qHJ0dhf6Uzl49yZ8P0QaQ+8+KEd5IJNY5f5l8IkGcvaJ
         M4rBIffQLHFIyXyGA/qVouvU3Uy4sn3X+Fo/owmqqf9MXToeOZWM8LYe6mny4xdVt594
         HOOstr5RvPZR9A9wcxLSRLb3BnAJOMNCpHxpVnzGdrnBWyjt4C5kmLWz4Gvc98Rbf5pt
         u8Ew==
X-Gm-Message-State: AOAM532Z3eVGW5KRD9qoNN9DO/yqOXqGfSyjWeXa0lcNM19W+/TaKu4g
        Ue6E1sC9Zd07tl+h8MXxr/zduw==
X-Google-Smtp-Source: ABdhPJy1dYbbmZHQ6kTc0TZswFB+Nsx/Cl16Ra/LGuWwnsH1YnTRRg3485iqU2Zj1C1bM51LDjw30w==
X-Received: by 2002:a17:906:e105:: with SMTP id gj5mr40783554ejb.388.1620849499924;
        Wed, 12 May 2021 12:58:19 -0700 (PDT)
Received: from localhost.localdomain (p200300d997048700813060682b44a2a4.dip0.t-ipconnect.de. [2003:d9:9704:8700:8130:6068:2b44:a2a4])
        by smtp.googlemail.com with ESMTPSA id r17sm623181edo.48.2021.05.12.12.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 12:58:19 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
Subject: ipc/sem, ipc/msg, ipc/mqueue.c kcsan questions
To:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Davidlohr Bueso <dbueso@suse.de>, 1vier1@web.de
Message-ID: <a9b36c77-dc42-4ab2-9740-f27b191dd403@colorfullife.com>
Date:   Wed, 12 May 2021 21:58:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got a report from kcsan for sem_lock()/sem_unlock(), but I'm fairly 
certain that this is a false positive:

> [  184.344960] BUG: KCSAN: data-race in sem_lock / sem_unlock.part.0
> [  184.360437]
> [  184.375443] write to 0xffff8881022fd6c0 of 4 bytes by task 1128 on 
> cpu 0:
> [  184.391192]  sem_unlock.part.0+0xfa/0x118
0000000000001371 <sem_unlock.part.0>:
static inline void sem_unlock(struct sem_array *sma, int locknum)
     1464:       eb 0f                   jmp    1475 
<sem_unlock.part.0+0x104>
                 sma->use_global_lock--;
     1466:       e8 00 00 00 00          callq  146b 
<sem_unlock.part.0+0xfa>
                         1467: R_X86_64_PLT32    __tsan_write4-0x4
     146b:       41 ff cc                dec    %r12d

> [  184.406693]  do_semtimedop+0x690/0xab3
> [  184.422032]  __x64_sys_semop+0x3e/0x43
> [  184.437180]  do_syscall_64+0x9e/0xb5
> [  184.452125]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  184.467269]
> [  184.482215] read to 0xffff8881022fd6c0 of 4 bytes by task 1129 on 
> cpu 2:
> [  184.497750]  sem_lock+0x59/0xe0
0000000000001bbc <sem_lock>:
         if (!sma->use_global_lock) {
     1c0a:       4c 89 ef                mov    %r13,%rdi
         idx = array_index_nospec(sops->sem_num, sma->sem_nsems);
     1c0d:       0f b7 db                movzwl %bx,%ebx
         if (!sma->use_global_lock) {
     1c10:       e8 00 00 00 00          callq  1c15 <sem_lock+0x59>
                         1c11: R_X86_64_PLT32    __tsan_read4-0x4

> [  184.513121]  do_semtimedop+0x4f6/0xab3
> [  184.528427]  __x64_sys_semop+0x3e/0x43
> [  184.543540]  do_syscall_64+0x9e/0xb5
> [  184.558473]  entry_SYSCALL_64_after_hwframe+0x44/0xae


sma->use_global_lock is evaluated in sem_lock() twice:

>        /*
>          * Initial check for use_global_lock. Just an optimization,
>          * no locking, no memory barrier.
>          */
>         if (!sma->use_global_lock) {
Both sides of the if-clause handle possible data races.

Is

     if (!data_race(sma->use_global_lock)) {

the correct thing to suppress the warning?

>                 /*
>                  * It appears that no complex operation is around.
>                  * Acquire the per-semaphore lock.
>                  */
>                 spin_lock(&sem->lock);
>
>                 /* see SEM_BARRIER_1 for purpose/pairing */
>                 if (!smp_load_acquire(&sma->use_global_lock)) {
Here I would need advise: The code only checks for zero / non-zero.

This pairs with complexmode_tryleave():

>         if (sma->use_global_lock == 1) {
>
>                 /* See SEM_BARRIER_1 for purpose/pairing */
>                 smp_store_release(&sma->use_global_lock, 0);
>         } else {
>                 sma->use_global_lock--;
>         }

If use_global_lock is reduced from e.g. 6 to 5, it is undefined if a 
concurrent reader sees 6 or 5. But it doesn't matter, as both values are 
non-zero.

The change to 0 is protected.

What is the right way to prevent false positives from kcsan?

As 2nd question:

net/netfilter/nf_conntrack_core.c, nf_conntrack_all_lock():

Is a data_race() needed around "nf_conntrack_locks_all = true;"?

--

     Manfred

