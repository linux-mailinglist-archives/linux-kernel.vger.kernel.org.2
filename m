Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD7B309A86
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 06:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhAaFe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 00:34:29 -0500
Received: from mail-vs1-f42.google.com ([209.85.217.42]:44753 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhAaFe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 00:34:28 -0500
Received: by mail-vs1-f42.google.com with SMTP id f22so7227370vsk.11;
        Sat, 30 Jan 2021 21:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/M1OqFZm+CaFShpXA+2vZYzW25UMozffA2UsAAu7sJM=;
        b=Q6aP9S3NRu7Jf4zZh0MAWEkJ+JIBK859qs3WzblvMVxGUPJmzRHQ6b9p6YgZWI+qAR
         Ii88eqn1tIfm2R5ChN0fHXhbShK3lmDpK4Qru+5gQSpxBgkDvYoe/rPFdmO7d94vqMKY
         ytaJA2Rdp6JqKA91US24+FEdRLjkgWbsA+YzaN1ivAg3tnwY6sbeQ5fahgYBxxAjNOg1
         bN38OpW++GyuV30MJPtmRakYRs9SCRcKXJDZLlVilfrpr2AUNXPknh6zCS6WaAuqaAQX
         LKFFGuTDcjci++ezGbPVq8DGNXvNKohujSxzdALgOK1jgs2m/tkgn+iJ9b7bH1mDd9kw
         Y4pA==
X-Gm-Message-State: AOAM5338QJ+xNJClt4ZNHwUzmhLAbdXO2yYh0JgLu/dLYVWslgvrz6q1
        NTSCgCmR4xB7SqOoFYce7fpFtz/k6lnrWg==
X-Google-Smtp-Source: ABdhPJzScxI731HKTfYZtrez5SXuh1W8sQos5fYxoLDRsnUtFlZKYR1go4KZBLeRSDdwUntCyh8lcA==
X-Received: by 2002:a67:8945:: with SMTP id l66mr6389836vsd.48.1612071226097;
        Sat, 30 Jan 2021 21:33:46 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id p9sm354056vsq.6.2021.01.30.21.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 21:33:45 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id p20so7252747vsq.7;
        Sat, 30 Jan 2021 21:33:44 -0800 (PST)
X-Received: by 2002:a67:99c6:: with SMTP id b189mr6367302vse.58.1612071223894;
 Sat, 30 Jan 2021 21:33:43 -0800 (PST)
MIME-Version: 1.0
References: <YBWPN3ZHkARxmGe9@Red>
In-Reply-To: <YBWPN3ZHkARxmGe9@Red>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 31 Jan 2021 13:33:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v67bWu0n--REsmmMo9oqdSu8wh6ys0b4omEQ57223W7suw@mail.gmail.com>
Message-ID: <CAGb2v67bWu0n--REsmmMo9oqdSu8wh6ys0b4omEQ57223W7suw@mail.gmail.com>
Subject: Re: arm: sunxi: &83t: WARNING: CPU: 2 PID: 57 at drivers/thermal/thermal_core.c:563
 thermal_zone_device_update
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 31, 2021 at 12:54 AM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> Hello
>
> When booting next-20210128, I got the following warning on by bpim3
>     6.148421] ------------[ cut here ]------------
> [    6.153145] WARNING: CPU: 2 PID: 57 at drivers/thermal/thermal_core.c:563 thermal_zone_device_update+0x134/0x154
> [    6.163378] 'thermal_zone_device_update' must not be called without 'get_temp' ops set
> [    6.171300] Modules linked in: sha256_generic libsha256
> [    6.176553] CPU: 2 PID: 57 Comm: kworker/2:1 Not tainted 5.11.0-rc1-00042-gf3788af62cfe #399
> [    6.184984] Hardware name: Allwinner A83t board
> [    6.189517] Workqueue: events deferred_probe_work_func
> [    6.194686] [<c010d568>] (unwind_backtrace) from [<c010a060>] (show_stack+0x10/0x14)
> [    6.202438] [<c010a060>] (show_stack) from [<c07e156c>] (dump_stack+0x98/0xac)
> [    6.209666] [<c07e156c>] (dump_stack) from [<c07df02c>] (__warn+0xc0/0xd8)
> [    6.216545] [<c07df02c>] (__warn) from [<c07df0dc>] (warn_slowpath_fmt+0x98/0xc0)
> [    6.224030] [<c07df0dc>] (warn_slowpath_fmt) from [<c0630384>] (thermal_zone_device_update+0x134/0x154)
> [    6.233426] [<c0630384>] (thermal_zone_device_update) from [<c0630918>] (__thermal_cooling_device_register+0x334/0x35c)
> [    6.244204] [<c0630918>] (__thermal_cooling_device_register) from [<c0633ea0>] (__cpufreq_cooling_register.constprop.0+0x184/0x294)
> [    6.256026] [<c0633ea0>] (__cpufreq_cooling_register.constprop.0) from [<c0633ff0>] (of_cpufreq_cooling_register+0x40/0x7c)
> [    6.267153] [<c0633ff0>] (of_cpufreq_cooling_register) from [<c064cb44>] (cpufreq_online+0x2b4/0x8f4)
> [    6.276379] [<c064cb44>] (cpufreq_online) from [<c064d200>] (cpufreq_add_dev+0x6c/0x78)
> [    6.284383] [<c064d200>] (cpufreq_add_dev) from [<c04f7a98>] (subsys_interface_register+0xa4/0xf0)
> [    6.293344] [<c04f7a98>] (subsys_interface_register) from [<c064b664>] (cpufreq_register_driver+0x144/0x2dc)
> [    6.303169] [<c064b664>] (cpufreq_register_driver) from [<c064de34>] (dt_cpufreq_probe+0x298/0x3b8)
> [    6.312215] [<c064de34>] (dt_cpufreq_probe) from [<c04fb540>] (platform_probe+0x5c/0xb8)
> [    6.320313] [<c04fb540>] (platform_probe) from [<c04f9374>] (really_probe+0x1dc/0x3b8)
> [    6.328231] [<c04f9374>] (really_probe) from [<c04f95ac>] (driver_probe_device+0x5c/0xb4)
> [    6.336406] [<c04f95ac>] (driver_probe_device) from [<c04f778c>] (bus_for_each_drv+0x84/0xc8)
> [    6.344928] [<c04f778c>] (bus_for_each_drv) from [<c04f9124>] (__device_attach+0xe8/0x154)
> [    6.353189] [<c04f9124>] (__device_attach) from [<c04f8440>] (bus_probe_device+0x84/0x8c)
> [    6.361365] [<c04f8440>] (bus_probe_device) from [<c04f88d4>] (deferred_probe_work_func+0x64/0x90)
> [    6.370321] [<c04f88d4>] (deferred_probe_work_func) from [<c0134b98>] (process_one_work+0x1dc/0x438)
> [    6.379456] [<c0134b98>] (process_one_work) from [<c0135050>] (worker_thread+0x25c/0x55c)
> [    6.387632] [<c0135050>] (worker_thread) from [<c013b7b4>] (kthread+0x124/0x150)
> [    6.395032] [<c013b7b4>] (kthread) from [<c0100150>] (ret_from_fork+0x14/0x24)
> [    6.402256] Exception stack(0xc12d1fb0 to 0xc12d1ff8)
> [    6.407307] 1fa0:                                     00000000 00000000 00000000 00000000
> [    6.415478] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    6.423648] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    6.430301] ---[ end trace bd63a5c976f3611c ]---
>
> I bisected the problem to
> ARM: dts: sunxi: Remove thermal zones without trip points
>
> Reverting this commit remove the warning.

The thermal subsystem seems to require a thermal zone be present for each
thermal sensor that is registered.

So maybe a better solution is not to remove the thermal zones without trip
points, but just add the standard passive and critical trip points based
on the SoC's thermal limits.


ChenYu
