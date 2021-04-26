Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D724F36B791
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhDZRJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbhDZRJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:09:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:08:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y22-20020a17090a8b16b0290150ae1a6d2bso5693910pjn.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0Am48mKBZdvN9X0MYjIzLU7/CnVEz/Ii8JHXmnfMxc4=;
        b=ZHfFnEJyCojyDrLz6janxmJh5OcHW8Ea4UdE3dmFfsGUzPmCfQh0H3sJkbxFr+NruC
         bWkNYu/WjvNFP79gAwikXmFFcdc/IcdZIPQYkwHEoC4s605I4IfBxdnmfcfWfms9xJ1X
         KmEstB8YbFtsZaGxAWoGI0XMmrtYK0ZLhuvGVsVOXGCFNMOQxf05ERSQZEOpmwXTCYUA
         9FcMXdZXOqPgzT7Yb5IHq2XFrqMjj7SDWON+a4znw843uMZg987PR/bfS/ZOiMTJZSUF
         CTphZVDK4IMdMJEyFLKJWxgcayvHMXKrHChyDWE6+S3ylLCZt1m/x4+7Dl4qTH6dhLQR
         9k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0Am48mKBZdvN9X0MYjIzLU7/CnVEz/Ii8JHXmnfMxc4=;
        b=lMJlqDUfAkrUePdcDwK7J9IDzduzLsJzLQ4ssVkaXDcxYbsDahnBbNkMdbw04OxgZh
         g0tMjlTdF71kfT3prU7FO7qT67aXfjDn9gMAnTPAfI9FuoIh2J3CYJSjpe4bpazL3ioi
         HLzbc67S9blEMxgSKeQ77/QV4zneeMDnoMJsJ4InwD0U8YKq3M+9D2CnkcNN8lNhri6R
         TvLVghwTb8UhCQzDkc7PKfR9E8FOgi2hnWlIuhAQC5ORGTMMHEfWw8Mbg3kLxUSFPYnx
         XNoH0uPLS9FtMQV0gbpfTWNJ5p3+f+9PP3skTYw14bmo7Hv7MrTuId3nsWIYw3zz2/BS
         2gjw==
X-Gm-Message-State: AOAM533rKhP3iwfAp2TK3LzINFO9RQF3RqZy4aSpw/OOyHjSgg9Ey3ZU
        EuA33/HzZsamsQaJU9jnSVWhuWRyfpQOv+Kx1hOTenvfYGhBTQ==
X-Google-Smtp-Source: ABdhPJx4z19+t+xf9FuRMM6dhtQplN7F5XZX0O6d2IA8mPKW7CC//BDMl8XDkfDaNnumVOE0RxMipu/eLlPYZjR2TXA=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr19378281plq.17.1619456918269; Mon, 26
 Apr 2021 10:08:38 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 26 Apr 2021 20:08:22 +0300
Message-ID: <CAHp75Vc=FCGcUyS0v6fnxme2YJ+qD+Y-hQDQLa2JhWNON9VmsQ@mail.gmail.com>
Subject: Sleeping in atomic context on device release due to device links
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is the below already fixed somewhere (v5.12 seems still has it)?
Or I missed something?

[  186.439095] BUG: sleeping function called from invalid context at
drivers/gpio/gpiolib.c:1952
[  186.451666] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
119, name: kworker/0:2
[  186.463885] 2 locks held by kworker/0:2/119:
[  186.470831]  #0: ffff985d8110d338
((wq_completion)rcu_gp){....}-{0:0}, at: process_one_work+0x1bc/0x4b0
[  186.484458]  #1: ffffb1a2c0367e70
((work_completion)(&sdp->work)){....}-{0:0}, at:
process_one_work+0x1bc/0x4b
0
[  186.498732] CPU: 0 PID: 119 Comm: kworker/0:2 Not tainted 5.12.0-rc8+ #168
[  186.508301] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
BIOS 542 2015.01.21:18.19.48
[  186.521000] Workqueue: rcu_gp srcu_invoke_callbacks
[  186.528515] Call Trace:
[  186.532288]  dump_stack+0x69/0x8e
[  186.536964]  ___might_sleep.cold+0x95/0xa2
[  186.543606]  gpiod_free_commit+0x25/0x170
[  186.550163]  gpiod_put+0x19/0x40
[  186.554728]  cleanup+0x1b/0x30 [spi_pxa2xx_platform]
[  186.562246]  spidev_release+0x24/0x50
[  186.567243]  device_release+0x34/0x90
[  186.572228]  kobject_put+0x86/0x1d0
[  186.577035]  __device_link_free_srcu+0x47/0x70
[  186.583942]  srcu_invoke_callbacks+0xc8/0x170
[  186.590720]  process_one_work+0x24d/0x4b0
[  186.597118]  worker_thread+0x55/0x3c0
[  186.602030]  ? rescuer_thread+0x390/0x390
[  186.608373]  kthread+0x137/0x150
[  186.612834]  ? __kthread_bind_mask+0x60/0x60
[  186.619446]  ret_from_fork+0x22/0x30


-- 
With Best Regards,
Andy Shevchenko
