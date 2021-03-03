Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A932BF91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835661AbhCCSE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378980AbhCCP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:29:31 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426FC06175F;
        Wed,  3 Mar 2021 07:26:50 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id p10so9571052ils.9;
        Wed, 03 Mar 2021 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/+b0M2H+gosoJ79u2UNSRkbC9BoMHMgNBTho8YdX/KY=;
        b=kZ0CQxzwwczsSO7NNjvLv/B37Rl82nhUefag/iMQi+vlJRuQ+dcg5uvxQPndxyLMRt
         ZzFVY/t5NxZsMD6somA13llXxwht8oeDLhc22TPrQZv3hq1YxSRJU8+5S73XwPqMO9q8
         Y/VJ3iLEzLlsYqJa21hDdIA3UJ7PaC0ixuNzLXjIRCvd8Rk6QIeQO0HOHsX08j1ykBxL
         lwiaXlpaTsD+MMYZdA44ZptH2fURcLYgR/ChKxFwK1XPUmuvDiEJqhCzT7lNaI4eJWrd
         13sQjbS37+kPJArOmItifDZ7+f2h+Jd8B0Vm6lzRSVEdHDcrk3pRZX5ZDK+eLTeSEAdb
         7trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/+b0M2H+gosoJ79u2UNSRkbC9BoMHMgNBTho8YdX/KY=;
        b=fsGYzuAkSAmV8cchf3hvDizq4zBBAk+SUHnLeGwZSGzPA3cNe5R/hpAs13Ksu7OMq1
         dHJT4qB/Wh+oIwfDrgLLi81l//MRZdB5RKDpnyCKNsv7CXCU5jEr+rYiUODXAQ5Woe+b
         ghIhp3hReif8hwAu9W2yI4lQbTOQHMmopcmgO5PVdV9/3zTk0TqGKo+fg2krHwwU19og
         iFhX85HmPYnSK2l9qR9OWjsV9ol6xN6iU4AHjX89v6CYU+7NrDzpnxeftHbQ/30X4Dky
         nNMO6udKAMTGEKig6yfEUXEL/2It20C7I3ALqYHAQN/6sQPA5pMUv0RRwPrZm80b1L7r
         qGRA==
X-Gm-Message-State: AOAM531Z+AylmMeZDFCE4jI7cCBV+LKrj49SrqfmLTYhjhOHHae0W1Yp
        FNmqcwIXoe9eJtNCOhmMQPukXfaPabC5TqgsDyWYE2SOyILXcw==
X-Google-Smtp-Source: ABdhPJzy7T6Q07FleS45PUV9vTkuaDh8XD/58Tp6UHQ1BCU1D4Fu/wOPrCP0/cVRnB0Zb3JxtCj8tWZCEKKnzqZJFCs=
X-Received: by 2002:a92:d981:: with SMTP id r1mr21922502iln.98.1614785209987;
 Wed, 03 Mar 2021 07:26:49 -0800 (PST)
MIME-Version: 1.0
References: <20210222115149.3606776-1-raychi@google.com> <20210303150126.24538-1-heiko.thiery@gmail.com>
In-Reply-To: <20210303150126.24538-1-heiko.thiery@gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Wed, 3 Mar 2021 16:26:38 +0100
Message-ID: <CAEyMn7bc8F940WZc0Xf-p9Ri6K4sKcLvG-VfYh2o+bjuhT82NQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] an additional path to control charging current
To:     raychi@google.com
Cc:     badhri@google.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        kyletso@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mi., 3. M=C3=A4rz 2021 um 16:01 Uhr schrieb Heiko Thiery <heiko.thiery@g=
mail.com>:
>
> Hi Ray,
>
>
> > Currently, VBUS draw callback does no action when the
> > generic PHYs are used. The patches add an additional path
> > to control charging current through power supply property
> > POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT.
> >
> > Ray Chi (2):
> >   usb: dwc3: add a power supply for current control
> >   usb: dwc3: add an alternate path in vbus_draw callback
>
> While using next-20210303 this patchset leads to the following kernel cra=
sh on my board:
>
> ---- 8< ----
>
> [    1.392084] VFIO - User Level meta-driver version: 0.3
> [    1.398370] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000000000003a0
> [    1.407552] Mem abort info:
> [    1.410479]   ESR =3D 0x96000004
> [    1.413668]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    1.419217]   SET =3D 0, FnV =3D 0
> [    1.422413]   EA =3D 0, S1PTW =3D 0
> [    1.425690] Data abort info:
> [    1.428705]   ISV =3D 0, ISS =3D 0x00000004
> [    1.432715]   CM =3D 0, WnR =3D 0
> [    1.435821] [00000000000003a0] user address but active_mm is swapper
> [    1.442458] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    1.448274] Modules linked in:
> [    1.451469] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-next-=
20210303-00005-g090e892099db #126
> [    1.461269] Hardware name: Kontron pITX-imx8m (DT)
> [    1.466268] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=3D--)
> [    1.472538] pc : devm_power_supply_get_by_phandle+0xe4/0x148
> [    1.478455] lr : dwc3_probe+0xbac/0xfa0
> [    1.482462] sp : ffff800011f1bb00
> [    1.485918] x29: ffff800011f1bb00 x28: 0000000000000000
> [    1.491467] x27: ffff800011681078 x26: ffff8000115d048c
> [    1.497016] x25: ffff0000c089ea00 x24: 0000000000000003
> [    1.502564] x23: ffff0000c089ea00 x22: ffff800011b89948
> [    1.508112] x21: 0000000000000003 x20: 00000000fffffdfb
> [    1.513660] x19: ffff0000c03f1080 x18: 00000000000000c0
> [    1.519209] x17: 0000000000000000 x16: 0000000000000000
> [    1.524757] x15: fffffc0000001000 x14: 0000000000000000
> [    1.530306] x13: 0000000000000000 x12: 0000000000000030
> [    1.535853] x11: 0101010101010101 x10: ffff800011f1ba50
> [    1.541402] x9 : ffff0000ff784c70 x8 : 0000000000000010
> [    1.546950] x7 : ffff0000c03a5590 x6 : 0000000000000080
> [    1.552498] x5 : ffff0000c0098000 x4 : 00000000000003a0
> [    1.558047] x3 : ffff800011cb2dc8 x2 : 0000000000000000
> [    1.563596] x1 : 0000000000000001 x0 : 0000000000000000
> [    1.569146] Call trace:
> [    1.571700]  devm_power_supply_get_by_phandle+0xe4/0x148
> [    1.577248]  dwc3_probe+0xbac/0xfa0
> [    1.580890]  platform_probe+0x68/0xd8
> [    1.584719]  really_probe+0xe4/0x3c0
> [    1.588454]  driver_probe_device+0x58/0xb8
> [    1.592733]  device_driver_attach+0x74/0x80
> [    1.597100]  __driver_attach+0x58/0xe0
> [    1.601016]  bus_for_each_dev+0x74/0xc8
> [    1.605020]  driver_attach+0x24/0x30
> [    1.608753]  bus_add_driver+0x184/0x1e8
> [    1.612758]  driver_register+0x64/0x120
> [    1.616764]  __platform_driver_register+0x28/0x38
> [    1.621675]  dwc3_driver_init+0x1c/0x28
> [    1.625684]  do_one_initcall+0x74/0x1d0
> [    1.629691]  kernel_init_freeable+0x1d4/0x23c
> [    1.634240]  kernel_init+0x14/0x118
> [    1.637885]  ret_from_fork+0x10/0x30
> [    1.641624] Code: 88027c01 35ffffa2 17fffe96 f9800091 (885f7c82)
> [    1.647992] ---[ end trace c6e48cea897d0b0d ]---
> [    1.652833] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x0000000b
> [    1.660822] SMP: stopping secondary CPUs
> [    1.664921] Kernel Offset: disabled
> [    1.668560] CPU features: 0x00240002,2000200c
> [    1.673106] Memory Limit: none
> [    1.676296] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x0000000b ]---
>
>
> ---- 8< ----

This fixes the crash.

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d15f065849cd..94fdbe502ce9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1628,7 +1628,7 @@ static int dwc3_probe(struct platform_device *pdev)
 assert_reset:
        reset_control_assert(dwc->reset);

-       if (!dwc->usb_psy)
+       if (dwc->usb_psy)
                power_supply_put(dwc->usb_psy);

        return ret;
@@ -1653,7 +1653,7 @@ static int dwc3_remove(struct platform_device *pdev)
        dwc3_free_event_buffers(dwc);
        dwc3_free_scratch_buffers(dwc);

-       if (!dwc->usb_psy)
+       if (dwc->usb_psy)
                power_supply_put(dwc->usb_psy);

        return 0;


--=20
Heiko
