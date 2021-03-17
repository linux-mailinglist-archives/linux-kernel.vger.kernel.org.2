Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E195533EC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhCQI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCQI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:58:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A741C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:58:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ox4so1275017ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=91W10dzgQl25gCGsYWOMCi8T9nay/doytnoIqugJpTk=;
        b=b+8TKjZ/IWbV0uBJxFF6G8JZe1k0XwASF2cOHWHpI94FyNPHQWQ/ZbHmCyiBCAkMr+
         AqjO2Zj77mqrARbeEYd8CN+UF2dugYjuq3dpTdYvk39d2cIE//WP/URi00QBMbeUJeG7
         AkICBL0uUY1uGZPhi9eFru7PqLZznuF78iE9rf7acW08CQj+CP6QMjT9QVCl9qritIKN
         p6OY5BY2sQ8JatVRe9ZShK36VsF+rNDsbO01x9x1f/5PLJOjxBaOinzpBMA0sa7G20wU
         gZu6ULWboBs3kqK+0vWVuBGypPHgH8IWpDSFiXVztPGEskzNsNeYrQ92SWKtpaf7MqaI
         A0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=91W10dzgQl25gCGsYWOMCi8T9nay/doytnoIqugJpTk=;
        b=FN2aACQl6qCmr+S4H1e3h99LvBgumz68rBONl3N67pFA2BMDp8eWUtgth2inkIijqe
         kVN2Uz+xBoesAsk47N8xp9dWjv+Ua65BHU6EFQBimiWrQmrw49VHsSQfVh7PI7ucq52M
         YccKtBqXwG+/fLaOp+WlTmM5eCftSxBo7gJBjCh/TBB7+ghucim9CXre9fdWwQcLQdkC
         IhZWsk8zALsT5H7BDYOJmm1udnsDGLibTvF8cSPg0uJy7OtatTRp8ovmpyCu65ntJu6b
         BVfOYbP/IGg50Q6TNeZ8X+O9ub2Fhoo0a0xZhX+zakZMkD1JycKXZOF6Ll12SFhEQ9sb
         T9mA==
X-Gm-Message-State: AOAM530OWUagtRuFd310v0siEQ3819rYq6Advb2YDg7i/DBbKjAbzOC6
        SJuGD8ETy7yy1YK0iJllevm2ZfLr36Ghy6auvcNxe8aWahFc3+HA
X-Google-Smtp-Source: ABdhPJyUEzs1cPU/OB2GqbxoW1r+FRO7iw4VNvlttwipmb8rkpplXArBuf7gmbiTfAcJ1OEhltz/KjnQBWuFfPOF1S4=
X-Received: by 2002:a17:906:2a16:: with SMTP id j22mr23202741eje.247.1615971531323;
 Wed, 17 Mar 2021 01:58:51 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Mar 2021 14:28:40 +0530
Message-ID: <CA+G9fYsKBLOvvxOfB6AAzjarsABQiEUhGd4JB3FDq3q1OrFmOw@mail.gmail.com>
Subject: BUG: KFENCE: memory corruption in usb_get_device_descriptor
To:     open list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Yan <yanaijie@huawei.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While booting Linux mainline master 5.12.0-rc2 and 5.12.0-rc3 on arm64
Hikey device the following KFENCE bug was found.

Recently, we have enabled CONFIG_KFENCE=y and started seeing this crash.
kernel BUG log:

[   18.243075] BUG: KFENCE: memory corruption in
usb_get_device_descriptor+0x80/0xb0
[   18.243075]
[   18.253016] Corrupted memory at 0x00000000bb4567e7 [ ! ! . . . . .
. . . . . . . . . ] (in kfence-#118):
[   18.263817]  usb_get_device_descriptor+0x80/0xb0
[   18.268978]  hub_port_init+0x3e8/0xb70
[   18.273189]  hub_event+0x578/0x1628
[   18.277109]  process_one_work+0x1c8/0x488
[   18.281593]  worker_thread+0x54/0x428
[   18.285692]  kthread+0x120/0x158
[   18.289320]  ret_from_fork+0x10/0x34
[   18.293330]
[   18.295018] kfence-#118 [0x00000000b55b54e8-0x000000001fc57965,
size=18, cache=kmalloc-128] allocated by task 204:

[   18.306534]  usb_get_device_descriptor+0x40/0xb0
[   18.311693]  hub_port_init+0x3e8/0xb70
[   18.315900]  hub_event+0x578/0x1628
[   18.319819]  process_one_work+0x1c8/0x488
[   18.324301]  worker_thread+0x54/0x428
[   18.328397]  kthread+0x120/0x158
[   18.332024]  ret_from_fork+0x10/0x34
root@hikey:~# [   18.33603. /lava-2388200/environment
3]
[   18.338544] CPU: 7 PID: 204 Comm: kworker/7:2 Not tainted 5.12.0-rc2 #2
[   18.345902] Hardware name: HiKey Development Board (DT)
[   18.351715] Workqueue: usb_hub_wq hub_event
[   18.356428] ==================================================================
. /lava[   18.805771]
==================================================================
[   18.813861] BUG: KFENCE: memory corruption in
__usbnet_read_cmd.isra.0+0xd0/0x1a0
[   18.813861]
[   18.823804] Corrupted memory at 0x000000007cedde53 [ ! ! ! . . . .
. . . . . . . . . ] (in kfence-#121):
[   18.834603]  __usbnet_read_cmd.isra.0+0xd0/0x1a0
[   18.839765]  usbnet_read_cmd+0x70/0xa8
[   18.843965]  asix_read_cmd+0x60/0xa0
[   18.847981]  ax88772a_hw_reset+0x148/0x468
[   18.852570]  ax88772_bind+0x1c8/0x310
[   18.856683]  usbnet_probe+0x29c/0x7d8
[   18.860788]  usb_probe_interface+0xe0/0x2c0
-[   18.865236]  really_probe+0xf0/0x4d8
[   18.869016]  driver_probe_device+0xfc/0x168
[   18.873430]  __device_attach_driver+0x94/0x120
[   18.878116]  bus_for_each_drv+0x80/0xd8
[   18.882165]  __device_attach+0xfc/0x180
[   18.886214]  device_initial_probe+0x1c/0x28
[   18.890627]  bus_probe_device+0xa4/0xb0
[   18.894676]  device_add+0x3a8/0x7e8
[   18.898357]  usb_set_configuration+0x488/0x8e8
[   18.903044]  usb_generic_driver_probe+0x58/0x98
[   18.907823]  usb_probe_device+0x44/0x108
[   18.911964]  really_probe+0xf0/0x4d8
2[   18.924600]  driver_probe_device+0xfc/0x168
[   18.937379]  __device_attach_driver+0x94/0x120
[   18.950406]  bus_for_each_drv+0x80/0xd8
[   18.960383]  __device_attach+0xfc/0x180
[   18.969078]  device_initial_probe+0x1c/0x28
3[   18.977855]  bus_probe_device+0xa4/0xb0
[   18.986226]  device_add+0x3a8/0x7e8
[   18.994190]  usb_new_device+0x1e0/0x590
[   19.002475]  hub_event+0x5ec/0x1628
[   19.010352]  process_one_work+0x1c8/0x488
[   19.018792]  worker_thread+0x54/0x428
[   19.026921]  kthread+0x120/0x158
[   19.034614]  ret_from_fork+0x10/0x34
8[   19.042712]
[   19.048623] kfence-#121 [0x000000008a763b3c-0x000000008a763b3c,
size=1, cache=kmalloc-128] allocated by task 204:
[   19.063612]  __usbnet_read_cmd.isra.0+0x60/0x1a0
[   19.072924]  usbnet_read_cmd+0x70/0xa8
[   19.081325]  asix_read_cmd+0x60/0xa0
[   19.089503]  ax88772a_hw_reset+0x148/0x468
8[   19.098163]  ax88772_bind+0x1c8/0x310
[   19.106312]  usbnet_probe+0x29c/0x7d8
[   19.114407]  usb_probe_interface+0xe0/0x2c0
[   19.122950]  really_probe+0xf0/0x4d8
[   19.130811]  driver_probe_device+0xfc/0x168
[   19.139273]  __device_attach_driver+0x94/0x120
[   19.148025]  bus_for_each_drv+0x80/0xd8
[   19.156148]  __device_attach+0xfc/0x180
2[   19.164287]  device_initial_probe+0x1c/0x28
[   19.172782]  bus_probe_device+0xa4/0xb0
[   19.180948]  device_add+0x3a8/0x7e8
[   19.188758]  usb_set_configuration+0x488/0x8e8
[   19.197455]  usb_generic_driver_probe+0x58/0x98
[   19.206120]  usb_probe_device+0x44/0x108
[   19.214175]  really_probe+0xf0/0x4d8
0[   19.221885]  driver_probe_device+0xfc/0x168
[   19.230202]  __device_attach_driver+0x94/0x120
[   19.238794]  bus_for_each_drv+0x80/0xd8
[   19.246780]  __device_attach+0xfc/0x180
[   19.254790]  device_initial_probe+0x1c/0x28
[   19.263145]  bus_probe_device+0xa4/0xb0
[   19.271111]  device_add+0x3a8/0x7e8
0[   19.278682]  usb_new_device+0x1e0/0x590
[   19.286583]  hub_event+0x5ec/0x1628
[   19.294055]  process_one_work+0x1c8/0x488
[   19.302102]  worker_thread+0x54/0x428
[   19.309743]  kthread+0x120/0x158
[   19.316894]  ret_from_fork+0x10/0x34
[   19.324306]
[   19.329495] CPU: 7 PID: 204 Comm: kworker/7:2 Tainted: G    B
      5.12.0-rc2 #2
/[   19.341360] Hardware name: HiKey Development Board (DT)
[   19.350439] Workqueue: usb_hub_wq hub_event


Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git commit: f296bfd5cd04cbb49b8fc9585adc280ab2b58624
  git describe: v5.12-rc2-487-gf296bfd5cd04
  make_kernelversion: 5.12.0-rc2
  kernel-config: https://builds.tuxbuild.com/1pfztfszUNcDwOAyMrw2wPMKNfc/config


-- 
Linaro LKFT
https://lkft.linaro.org
