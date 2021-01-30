Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C593096F5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhA3QzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhA3Qy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 11:54:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A4C061573;
        Sat, 30 Jan 2021 08:54:19 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s7so9026615wru.5;
        Sat, 30 Jan 2021 08:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FW1PIAWLlP/mUtUhVpc1wGSJOXNC9ICNRYLJ/n09dNc=;
        b=oWV8Xdl7iPHXJPwnER8l7PEH1ku1AEi8hG/gy//NINm5Abo3s+iwDp/9uFW8ICyuLe
         76ZHXQcdtlXo3ZaAYr7vDiMQ5SVtF7kJrl5Q9bf+vQFhARQfLAz4sqGrTFmDG8+enjq+
         wMW/T6D33RLzeoN2yqzYrAPN/nraKY7pAT0vmrv+Dasam4Hv4m0VzxYzwYJZIGmiWa17
         6/LUXyuG/LDY3b95dL94zcSWXlDRyqREfHluETrHql67qBRyhPeu3VJR1404HZ2rY6oR
         oRJTrQKJeZeeodl+zHiY0GCM/igVvy5RDEaCKbfCoITaoCB00+JC+T3mbvkNXMrlfKki
         2lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FW1PIAWLlP/mUtUhVpc1wGSJOXNC9ICNRYLJ/n09dNc=;
        b=GY1mWv7GnNVPtrOSUfAZguIOD9RVZeW5vxZOtrJiVK6Hx1ZTmFDVY22T7vtr6/z/pl
         lua/SR9/lsSa2AIJ2SvOKXGVH7vKwHmGecRisPAEnEOuAU6PTZ7I0n+bxHnw5jXMg0Md
         ZqAaDX0M6Pumhj2HRh3POguKkm7ILEWiTtp/icVbRKy3UgCrDruN6Zr+I1Y35XvJT0Jt
         qV/06F+be7sm9BOg0ANUdeze8LwwaGqFfu8MGINsz9769ZTm7Q+W+UXozSCKR3uimnYu
         uIK05Pl/qZFB/K8KvmhvH72sxe8aPCEXI4enXiDhOldQF1IwB+MAlePtYgAo3Lc8QgVO
         d23Q==
X-Gm-Message-State: AOAM531sZiqbSGHYg5WhFUhrTHe98IlwvFeiwTj/4+7ht1i+hk9zSz7V
        2Dkj/5+64Iow/WN99zfQsm0=
X-Google-Smtp-Source: ABdhPJwyh8E+X5zBY3ru7vgqYcDvh+1aoh1C1IDfn8JIs26blVFSdaZILQreVIgvNcWuvXix1UP5Hg==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr10163379wrp.110.1612025658090;
        Sat, 30 Jan 2021 08:54:18 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id p18sm14480246wmc.31.2021.01.30.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 08:54:17 -0800 (PST)
Date:   Sat, 30 Jan 2021 17:54:15 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: arm: sunxi: &83t: WARNING: CPU: 2 PID: 57 at
 drivers/thermal/thermal_core.c:563 thermal_zone_device_update
Message-ID: <YBWPN3ZHkARxmGe9@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When booting next-20210128, I got the following warning on by bpim3
    6.148421] ------------[ cut here ]------------
[    6.153145] WARNING: CPU: 2 PID: 57 at drivers/thermal/thermal_core.c:563 thermal_zone_device_update+0x134/0x154
[    6.163378] 'thermal_zone_device_update' must not be called without 'get_temp' ops set
[    6.171300] Modules linked in: sha256_generic libsha256
[    6.176553] CPU: 2 PID: 57 Comm: kworker/2:1 Not tainted 5.11.0-rc1-00042-gf3788af62cfe #399
[    6.184984] Hardware name: Allwinner A83t board
[    6.189517] Workqueue: events deferred_probe_work_func
[    6.194686] [<c010d568>] (unwind_backtrace) from [<c010a060>] (show_stack+0x10/0x14)
[    6.202438] [<c010a060>] (show_stack) from [<c07e156c>] (dump_stack+0x98/0xac)
[    6.209666] [<c07e156c>] (dump_stack) from [<c07df02c>] (__warn+0xc0/0xd8)
[    6.216545] [<c07df02c>] (__warn) from [<c07df0dc>] (warn_slowpath_fmt+0x98/0xc0)
[    6.224030] [<c07df0dc>] (warn_slowpath_fmt) from [<c0630384>] (thermal_zone_device_update+0x134/0x154)
[    6.233426] [<c0630384>] (thermal_zone_device_update) from [<c0630918>] (__thermal_cooling_device_register+0x334/0x35c)
[    6.244204] [<c0630918>] (__thermal_cooling_device_register) from [<c0633ea0>] (__cpufreq_cooling_register.constprop.0+0x184/0x294)
[    6.256026] [<c0633ea0>] (__cpufreq_cooling_register.constprop.0) from [<c0633ff0>] (of_cpufreq_cooling_register+0x40/0x7c)
[    6.267153] [<c0633ff0>] (of_cpufreq_cooling_register) from [<c064cb44>] (cpufreq_online+0x2b4/0x8f4)
[    6.276379] [<c064cb44>] (cpufreq_online) from [<c064d200>] (cpufreq_add_dev+0x6c/0x78)
[    6.284383] [<c064d200>] (cpufreq_add_dev) from [<c04f7a98>] (subsys_interface_register+0xa4/0xf0)
[    6.293344] [<c04f7a98>] (subsys_interface_register) from [<c064b664>] (cpufreq_register_driver+0x144/0x2dc)
[    6.303169] [<c064b664>] (cpufreq_register_driver) from [<c064de34>] (dt_cpufreq_probe+0x298/0x3b8)
[    6.312215] [<c064de34>] (dt_cpufreq_probe) from [<c04fb540>] (platform_probe+0x5c/0xb8)
[    6.320313] [<c04fb540>] (platform_probe) from [<c04f9374>] (really_probe+0x1dc/0x3b8)
[    6.328231] [<c04f9374>] (really_probe) from [<c04f95ac>] (driver_probe_device+0x5c/0xb4)
[    6.336406] [<c04f95ac>] (driver_probe_device) from [<c04f778c>] (bus_for_each_drv+0x84/0xc8)
[    6.344928] [<c04f778c>] (bus_for_each_drv) from [<c04f9124>] (__device_attach+0xe8/0x154)
[    6.353189] [<c04f9124>] (__device_attach) from [<c04f8440>] (bus_probe_device+0x84/0x8c)
[    6.361365] [<c04f8440>] (bus_probe_device) from [<c04f88d4>] (deferred_probe_work_func+0x64/0x90)
[    6.370321] [<c04f88d4>] (deferred_probe_work_func) from [<c0134b98>] (process_one_work+0x1dc/0x438)
[    6.379456] [<c0134b98>] (process_one_work) from [<c0135050>] (worker_thread+0x25c/0x55c)
[    6.387632] [<c0135050>] (worker_thread) from [<c013b7b4>] (kthread+0x124/0x150)
[    6.395032] [<c013b7b4>] (kthread) from [<c0100150>] (ret_from_fork+0x14/0x24)
[    6.402256] Exception stack(0xc12d1fb0 to 0xc12d1ff8)
[    6.407307] 1fa0:                                     00000000 00000000 00000000 00000000
[    6.415478] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    6.423648] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    6.430301] ---[ end trace bd63a5c976f3611c ]---

I bisected the problem to
ARM: dts: sunxi: Remove thermal zones without trip points

Reverting this commit remove the warning.

Regards
