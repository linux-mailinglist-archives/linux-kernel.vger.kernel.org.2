Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE3736BB29
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhDZV0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhDZV0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:26:19 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEA2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:25:37 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q192so13065163ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=508ovmXS8DpmpNPbL89LJR27EX3QMuO+O3AIb+NoGvQ=;
        b=VTQ6bSOGVug3MmyZAeIZXQ8sbTxH+e90Ylebh+pSEzYa/AYQikD4zIVgKPmf20gLa8
         Bbmkk+RSzFGuiXqWJeAbkwWEL7keR6g5gCKJQDpgOZ3yhVGCWpyu6UDhpvVKTrsUbnro
         eYDUaAKyosYlZoSZ5ibWmoVum9ILLBpVZXgXFpDObvPuRgWAzYtjhBlCOeeR8BS4iYn1
         Y0ssTZVjNGBclfyG1eyzIy+Z55j0Q3NdzzKA9otkvKIg2gAU0hxswK1MUH7glibSS5/z
         97ASA+opSNFE4GPPSKsNoZJ2N2K87V+ND62TL34FWbT24IOrc30UMmUxll6HIRyN+dpu
         yUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=508ovmXS8DpmpNPbL89LJR27EX3QMuO+O3AIb+NoGvQ=;
        b=Zavco7jmQ7qHnZMh+Srgh0bu+XWAhq5Mt3SVZv6IbWEY9NtrpmKgOOicNaYdlAtOYk
         gxFqpAtdY/JxnmbmYuKE/+4cVGBCekjmBFmKZekReQFHbGsK8EQpoD8qBdIvhk1XV5s9
         1CX02/2EcerX3+TbIEcRNS4YUXFw1puKT2jE43sWEeXe8tsxh85J8Qlk89Ddacq3MeZ2
         0/yOerTsmGqLuPN8WuIiEtQT1W9TAB+c8LqG2P/GIeobLu8Maqf4VG3ZxRaUlCXsxkwC
         gPCMiIItvGxQVpRoE0mlfnuMX7y+L2EdgW00V83deWiYXTY4/1jns8ibndpJZh32yV8U
         Zb9A==
X-Gm-Message-State: AOAM5315GBxauJbzEKE0L86HwrfnDWtTMUGhiqVRYOhqyRuIkM7UBLxz
        UWW2zWqAOkeKuh5lt78s4Ok5Rk9TEOQApX1voKa1PQ==
X-Google-Smtp-Source: ABdhPJz9Hft4UOIdQp2htw0zmi/yxVjNy/q9zcG3JEAGDJSbU0S1tQpnvZWHiqueTOsa/WB0ZFTWjQU/vr/xe6Frnrc=
X-Received: by 2002:a5b:a82:: with SMTP id h2mr1073683ybq.20.1619472336867;
 Mon, 26 Apr 2021 14:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vc=FCGcUyS0v6fnxme2YJ+qD+Y-hQDQLa2JhWNON9VmsQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc=FCGcUyS0v6fnxme2YJ+qD+Y-hQDQLa2JhWNON9VmsQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 26 Apr 2021 14:25:00 -0700
Message-ID: <CAGETcx_4B9v-xF+pBCHSSOsEsKeYq=LqtTmGrMcsnNcY7aXT4w@mail.gmail.com>
Subject: Re: Sleeping in atomic context on device release due to device links
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:08 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Hi!
>
> Is the below already fixed somewhere (v5.12 seems still has it)?
> Or I missed something?
>
> [  186.439095] BUG: sleeping function called from invalid context at
> drivers/gpio/gpiolib.c:1952
> [  186.451666] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
> 119, name: kworker/0:2
> [  186.463885] 2 locks held by kworker/0:2/119:
> [  186.470831]  #0: ffff985d8110d338
> ((wq_completion)rcu_gp){....}-{0:0}, at: process_one_work+0x1bc/0x4b0
> [  186.484458]  #1: ffffb1a2c0367e70
> ((work_completion)(&sdp->work)){....}-{0:0}, at:
> process_one_work+0x1bc/0x4b
> 0
> [  186.498732] CPU: 0 PID: 119 Comm: kworker/0:2 Not tainted 5.12.0-rc8+ #168
> [  186.508301] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
> BIOS 542 2015.01.21:18.19.48
> [  186.521000] Workqueue: rcu_gp srcu_invoke_callbacks
> [  186.528515] Call Trace:
> [  186.532288]  dump_stack+0x69/0x8e
> [  186.536964]  ___might_sleep.cold+0x95/0xa2
> [  186.543606]  gpiod_free_commit+0x25/0x170
> [  186.550163]  gpiod_put+0x19/0x40
> [  186.554728]  cleanup+0x1b/0x30 [spi_pxa2xx_platform]
> [  186.562246]  spidev_release+0x24/0x50
> [  186.567243]  device_release+0x34/0x90
> [  186.572228]  kobject_put+0x86/0x1d0
> [  186.577035]  __device_link_free_srcu+0x47/0x70
> [  186.583942]  srcu_invoke_callbacks+0xc8/0x170
> [  186.590720]  process_one_work+0x24d/0x4b0
> [  186.597118]  worker_thread+0x55/0x3c0
> [  186.602030]  ? rescuer_thread+0x390/0x390
> [  186.608373]  kthread+0x137/0x150
> [  186.612834]  ? __kthread_bind_mask+0x60/0x60
> [  186.619446]  ret_from_fork+0x22/0x30
>

This took a few hours to debug, but it looks like a SPI framework bug.
Just that some device link code is exposing the bug.

Basically calling the spi controller cleanup in the device's release
op is wrong for many reasons. I'll send a patch for SPI later.

-Saravana
