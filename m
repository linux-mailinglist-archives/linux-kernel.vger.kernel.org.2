Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F51410B1C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhISKL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 06:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhISKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 06:11:58 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60648C061574;
        Sun, 19 Sep 2021 03:10:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so53796904lfu.5;
        Sun, 19 Sep 2021 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=E9znJvYkFHspj7voVBnpo6GFe+XXUJrxw6eT1zZq4n4=;
        b=hymLAQa24/5cCb73yNtsUv05BH6AmH9mkZDgO9DaMKV2yqug2tuDvzRC/5F8lmDCg7
         ylkuXnBuIj+IkaFteW4+HsOcOFON/W5RGiUD/nyQHUP99iHTiL3LU254g7xoF0kzBnDG
         Nnu+NQLwJHXSvWCa67p7PTsudX+z3zdPSarmUAy1ZzUKt+ke4AMf3+MRfd6Fwe+nBQsn
         7AB2AKH5VGyWnFL/LXYG++1t2nVwuS933V0hZkXr21bgtSP7I60CQTtdgWyWAhgsbIAE
         ZUsbrbF6ckb90MzaAi/rvI/iJez7jkQRtuy/UFMOV+N7a8xxLRhtnje7YGMIqIsgfSjY
         xAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E9znJvYkFHspj7voVBnpo6GFe+XXUJrxw6eT1zZq4n4=;
        b=IwFDAw+2fqj5y2es0Aqv94yyuXsa238CPR0PuPhg2ozuFf5Yc1/WJU9SN7LCxHSu4v
         9/fc9XxgWcOA3PjHgbHcNjlGniSxa/IyD22rBS+IT8OkglEQr6OVLVkt2vLaWvVrvyYS
         AVrcClwLec7W8HeNoTjpfA0w5RdMex682cld3N+vKGsmnwVLtxIjhIzpTfovzvcHy1ru
         9Sz7aWOTP2KVZh381nptN10hgPTRqJ2cPmwS31G+mpw5SBIFoW1AeAmq6jJiYJ/iZGP+
         NQ8N4FwRM70C00r6eKpI5RW5svqIuN/Gw6/0Y30SFd+qYofMIysVAs/QyASwRxgCMYCL
         2tew==
X-Gm-Message-State: AOAM531ZC7Y9mgxJrt1eCVPBYU5Kh5k9rDwt2YH/xNLgbwquk0c/wZDF
        Ic2ZNeJOm2LcK2DBzg7zolaoMAQDWD6Wy17QblGHwRkH8i84VQ==
X-Google-Smtp-Source: ABdhPJz1tfjldI9CNu+EmnxD0cYp7aTN8DhWKKXfL+ob767AB9EQZboc7ir26hXDx9abBr0QzKgJ0VwV8YuR6T2j/34=
X-Received: by 2002:a05:6512:1326:: with SMTP id x38mr14615689lfu.591.1632046230676;
 Sun, 19 Sep 2021 03:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
In-Reply-To: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Sun, 19 Sep 2021 12:10:19 +0200
Message-ID: <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com>
Subject: Re: imx8mm board crash in drivers/usb/chipidea/ci_hdrc_imx.c
To:     Fabio Estevam <festevam@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Am So., 19. Sept. 2021 um 08:58 Uhr schrieb Heiko Thiery
<heiko.thiery@gmail.com>:
>
> Hi all,
>
> I see the following crash on a imx8mm board implementation. I cannot
> find a reason for this at the moment. This can be reproduced with the
> imx8mm-kontron-n801x-s dtb.Has anyone seen the same issue?
>
> The position in the code is here:
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/chipidea/usbmisc_imx.c#L819
>
> [    1.489344] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000098
> [    1.498170] Mem abort info:
> [    1.500966]   ESR = 0x96000044
> [    1.504030]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.509356]   SET = 0, FnV = 0
> [    1.512416]   EA = 0, S1PTW = 0
> [    1.515569]   FSC = 0x04: level 0 translation fault
> [    1.520458] Data abort info:
> [    1.523349]   ISV = 0, ISS = 0x00000044
> [    1.527196]   CM = 0, WnR = 1
> [    1.530176] [0000000000000098] user address but active_mm is swapper
> [    1.536544] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> [    1.542125] Modules linked in:
> [    1.545190] CPU: 3 PID: 7 Comm: kworker/u8:0 Not tainted 5.14.0-dirty #3
> [    1.551901] Hardware name: Kontron i.MX8MM N801X S (DT)
> [    1.557133] Workqueue: events_unbound deferred_probe_work_func
> [    1.562984] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> [    1.568998] pc : imx7d_charger_detection+0x3f0/0x510
> [    1.573973] lr : imx7d_charger_detection+0x22c/0x510
> [    1.578947] sp : ffff800011f1b5d0
> [    1.582266] x29: ffff800011f1b5d0 x28: 0000000000000000 x27: 0000000000000000
> [    1.589416] x26: ffff000000294c10 x25: ffff800011a6d678 x24: ffff000002ff3680
> [    1.596567] x23: ffff000002ff3688 x22: ffff000002ff3680 x21: 0000000000000000
> [    1.603715] x20: 0000000000000000 x19: ffff000003118a80 x18: 0000000000000001
> [    1.610867] x17: 000000040044ffff x16: 00400032b5503510 x15: 0000000000000000
> [    1.618019] x14: ffff0000000d44c0 x13: ffff80002e7ed000 x12: 0000000034d4d91d
> [    1.625172] x11: 0000000000000000 x10: 0000000000000960 x9 : ffff800011f1b460
> [    1.632321] x8 : ffff00003fdb1d40 x7 : ffff00003fdb7f00 x6 : 0000000004ce61f4
> [    1.639475] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [    1.646625] x2 : 11246917acc78900 x1 : 0000000000000000 x0 : 0000000000000001
> [    1.653779] Call trace:
> [    1.656230]  imx7d_charger_detection+0x3f0/0x510
> [    1.660854]  imx_usbmisc_charger_detection+0x40/0xc8
> [    1.665825]  ci_hdrc_imx_notify_event+0xec/0x120
> [    1.670455]  ci_udc_vbus_session+0x70/0xa0
> [    1.674560]  usb_gadget_vbus_connect+0x20/0x38
> [    1.679013]  ci_handle_vbus_change+0x64/0x70
> [    1.683290]  ci_hdrc_probe+0x4e0/0x838
> [    1.687047]  platform_probe+0x68/0xd8
> [    1.690717]  really_probe+0xb0/0x318
> [    1.694300]  __driver_probe_device+0x78/0xe0
> [    1.698576]  driver_probe_device+0xb0/0x110
> [    1.702767]  __device_attach_driver+0x90/0xe0
> [    1.707131]  bus_for_each_drv+0x7c/0xd0
> [    1.710974]  __device_attach+0xe8/0x148
> [    1.714816]  device_initial_probe+0x14/0x20
> [    1.719009]  bus_probe_device+0x9c/0xa8
> [    1.722852]  device_add+0x3f0/0x840
> [    1.726349]  platform_device_add+0x110/0x238
> [    1.730626]  ci_hdrc_add_device+0x538/0x5a8
> [    1.734818]  ci_hdrc_imx_probe+0x3fc/0x810
> [    1.738927]  platform_probe+0x68/0xd8
> [    1.742598]  really_probe+0xb0/0x318
> [    1.746178]  __driver_probe_device+0x78/0xe0
> [    1.750458]  driver_probe_device+0xb0/0x110
> [    1.754651]  __device_attach_driver+0x90/0xe0
> [    1.759013]  bus_for_each_drv+0x7c/0xd0
> [    1.762858]  __device_attach+0xe8/0x148
> [    1.766703]  device_initial_probe+0x14/0x20
> [    1.770896]  bus_probe_device+0x9c/0xa8
> [    1.774739]  deferred_probe_work_func+0x88/0xc0
> [    1.779278]  process_one_work+0x1e8/0x360
> [    1.783295]  worker_thread+0x210/0x480
> [    1.787049]  kthread+0x150/0x160
> [    1.790284]  ret_from_fork+0x10/0x18
> [    1.793873] Code: a8c47bfd d50323bf d65f03c0 52800020 (b9009aa0)
> [    1.799975] ---[ end trace d43a19cb0f4746b6 ]---

Meanwhile I figured out that in ci_hdrc_imx_probe() the "fsl,usbphy"
node is not found [1]. But I do not understand why.

The following failure leads to the return code of -19 (ENODEV) and
sets the pyh to NULL:
"failed to get fsl,usbphy phandle in /soc@0/bus@32c00000/usb@32e40000 node"

[1] https://elixir.bootlin.com/linux/latest/source/drivers/usb/chipidea/ci_hdrc_imx.c#L420


--
Heiko
