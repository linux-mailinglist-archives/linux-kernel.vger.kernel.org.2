Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D436DE48
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbhD1R3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbhD1R3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:29:08 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3EEC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:28:23 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id j6so7184932ybh.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGZv/hgPQ6a1thzvfyFJbXRoiHEcaDvdCEGYQc0FjoE=;
        b=o4tWt6X6AmhzUShVPeltTrxmtrRtYGxgW5r5wS7uLQPByA5ytvZy+j2GfFU42lD9OB
         XGxtsgvkynDztHuEeif8zH4ptUpYJeC4h3BYrGEX4jwswnPBhb2zW9ravthLY8VkWtTv
         KH/OdILeS79POCYq4W/9eyjJdpWuxHCAhqOgB+bG04eOjWSUIuvCz3LlFsxamGN5yOlx
         yiqYdh0HDKdrE4JRfDSnXzSutOmDd9E9LzIM5TR7Yc45D+uM+5KJkHiqo6dmlSO9VrAU
         yc4Ff24SpMLWlKBv1znEquuNiqCONlVoT7luTllkgSXre366dHTD676xRGIBsXFacqFj
         QHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGZv/hgPQ6a1thzvfyFJbXRoiHEcaDvdCEGYQc0FjoE=;
        b=mdfgnOv86kIc7wH6KzjPqBshKI6CE/Iqya2i2xVTJf6jkoLjTL6ThvSoNdHHHy0ftF
         OQU9wfbeYS+PLUZVJ92pWABMRvmncszAoEbgW/Q3thUjEC192dR/aMay9GAv0YkKc0Av
         x9Lvkd3oI14eYig5Hd2CM7RqByX5pmsO1IpqOB6sDnIPK5+a+EjRpf5cDY22vx3ezdim
         fs0IF58RJ1TCtWFFvFFeqr6W8DvfTd2vXbVbUBtvk03vKbojLAU0S1TV+J0L4byfsqrJ
         2MIb/qhLXeHQcditNZM8XJMRPyZPadaqAU3rl4CGLoBX+RcvCZxUtJZtpjHUsqR9GjVg
         nmLQ==
X-Gm-Message-State: AOAM531A6X54IYb0wk5EsRAGWacBLkS5pmDgXBkM6AlQ3RCUnk8GzA8i
        G4xmUxYTHJpaLFhG3Xk1g/zg/Z0kZLurgk0PVUMAnA==
X-Google-Smtp-Source: ABdhPJz6JipmuVX5HEgnGZwyoYd0momnTEFDV3DOBlqm1VkMkmbPMfVvTYEf6tb/xPbrgiktAPM6NhR+a41iBXtSI+w=
X-Received: by 2002:a25:d98a:: with SMTP id q132mr23157373ybg.310.1619630902140;
 Wed, 28 Apr 2021 10:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vc=FCGcUyS0v6fnxme2YJ+qD+Y-hQDQLa2JhWNON9VmsQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc=FCGcUyS0v6fnxme2YJ+qD+Y-hQDQLa2JhWNON9VmsQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 28 Apr 2021 10:27:46 -0700
Message-ID: <CAGETcx80xSZ8d4JbZqiSz4L0VNtL+HCnFCS2u3F9aNC0QQoQjg@mail.gmail.com>
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

Hi Rafael,

So it looks like put_device() is not guaranteed to be atomic and
srcu_invoke_callbacks() runs in atomic context. I haven't dug into why
the SRCU implementation is needed for device links and what needs to
be in the srcu callback vs be done earlier in the actual caller
context.

Can you please look into this and give your thoughts?

-Saravana

> [  186.590720]  process_one_work+0x24d/0x4b0
> [  186.597118]  worker_thread+0x55/0x3c0
> [  186.602030]  ? rescuer_thread+0x390/0x390
> [  186.608373]  kthread+0x137/0x150
> [  186.612834]  ? __kthread_bind_mask+0x60/0x60
> [  186.619446]  ret_from_fork+0x22/0x30
>
>
> --
> With Best Regards,
> Andy Shevchenko
