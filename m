Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832E532BF41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577942AbhCCSBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446220AbhCCPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:02:19 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2801BC06175F;
        Wed,  3 Mar 2021 07:01:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v15so24036642wrx.4;
        Wed, 03 Mar 2021 07:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CF3Q09wjNuQhvOn0CaAMRIF/QXPL5/05Pa3kXq1aDY=;
        b=QBf5WO2hq5679ykZq2r9+u1JEzp0TNABpyxBmd7mJv6VlLOEYeyH73Le+xipIPo6dB
         0VaW03ZoWNTppmTqeqiiLOGVKBrXX4FQnBG3Jtz4o0Z5n7yEfer8IhqzF0hQ7avic/Wc
         LGeCTw0/k4u6phTTJe0jlb6WWe6XWrInuGnqEfTZ+GM9PC3q70DLYyat9VOYp2WgG2bM
         +ZRfcXk3tP/uks/h/b1Tjm838AWv0rtsl09OY3z/rUVoBniAeKcQ945/Imn2/2/y2qrQ
         Q8B60EAqSgAO+YUIsa9nu1LYefJPbErIk6irRCWQS8wjJPxaRWfaVP9c9qtGr5IcFrdy
         Epmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CF3Q09wjNuQhvOn0CaAMRIF/QXPL5/05Pa3kXq1aDY=;
        b=DXI6DNdIwrCs/sCezP/b+/W//x+J7N9QUSrHE5V62QUi0M3t+o8ustS33NShPJS+r4
         uYBtb3/IS5rG3ZZz0Df0e0zG3aSfb1PN71qDNSBYEwUWHwdlohYNmVb4ORVcYnvEiwaC
         RmdaUXbtybBuUTLaXdgr9fKuFeGgesd/Gyaa35TYSvQWhkc4YDk+VWrFLtDbAkV1n+rs
         wLZrwkllJ4dmk0RWnIsqQNJ1j5md2W/V2ZIyL6N6gSQF5FxJM4ANXQV3NbvUA1oFAGqM
         bjoqIOE0Qky3QarmfE5ffAJDrh/lb0S4Fx7pWPzDZVbFb8peJ2J0USk3ElN1Ywmq3fCi
         XF/Q==
X-Gm-Message-State: AOAM531V+tejsRZ88fFDPi656ye2wOW0mR0aEIddwDlBa76OKIolfEWx
        JRdUiwln0QLhFJWkC3LTp7o=
X-Google-Smtp-Source: ABdhPJytVFDSRfrCJqMawLitCkYAqJYItMJitsr9gAHWxSz3n+RknsQV75F+b1X5fU/jkcGIMLi52Q==
X-Received: by 2002:a5d:6809:: with SMTP id w9mr26273461wru.376.1614783687761;
        Wed, 03 Mar 2021 07:01:27 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id i10sm20988874wrs.11.2021.03.03.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 07:01:27 -0800 (PST)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     raychi@google.com
Cc:     badhri@google.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        kyletso@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: [PATCH 0/2] an additional path to control charging current
Date:   Wed,  3 Mar 2021 16:01:26 +0100
Message-Id: <20210303150126.24538-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222115149.3606776-1-raychi@google.com>
References: <20210222115149.3606776-1-raychi@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ray,


> Currently, VBUS draw callback does no action when the
> generic PHYs are used. The patches add an additional path
> to control charging current through power supply property
> POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT.
> 
> Ray Chi (2):
>   usb: dwc3: add a power supply for current control
>   usb: dwc3: add an alternate path in vbus_draw callback

While using next-20210303 this patchset leads to the following kernel crash on my board:

---- 8< ----

[    1.392084] VFIO - User Level meta-driver version: 0.3
[    1.398370] Unable to handle kernel NULL pointer dereference at virtual address 00000000000003a0
[    1.407552] Mem abort info:
[    1.410479]   ESR = 0x96000004
[    1.413668]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.419217]   SET = 0, FnV = 0
[    1.422413]   EA = 0, S1PTW = 0
[    1.425690] Data abort info:
[    1.428705]   ISV = 0, ISS = 0x00000004
[    1.432715]   CM = 0, WnR = 0
[    1.435821] [00000000000003a0] user address but active_mm is swapper
[    1.442458] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    1.448274] Modules linked in:
[    1.451469] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-next-20210303-00005-g090e892099db #126
[    1.461269] Hardware name: Kontron pITX-imx8m (DT)
[    1.466268] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[    1.472538] pc : devm_power_supply_get_by_phandle+0xe4/0x148
[    1.478455] lr : dwc3_probe+0xbac/0xfa0
[    1.482462] sp : ffff800011f1bb00
[    1.485918] x29: ffff800011f1bb00 x28: 0000000000000000 
[    1.491467] x27: ffff800011681078 x26: ffff8000115d048c 
[    1.497016] x25: ffff0000c089ea00 x24: 0000000000000003 
[    1.502564] x23: ffff0000c089ea00 x22: ffff800011b89948 
[    1.508112] x21: 0000000000000003 x20: 00000000fffffdfb 
[    1.513660] x19: ffff0000c03f1080 x18: 00000000000000c0 
[    1.519209] x17: 0000000000000000 x16: 0000000000000000 
[    1.524757] x15: fffffc0000001000 x14: 0000000000000000 
[    1.530306] x13: 0000000000000000 x12: 0000000000000030 
[    1.535853] x11: 0101010101010101 x10: ffff800011f1ba50 
[    1.541402] x9 : ffff0000ff784c70 x8 : 0000000000000010 
[    1.546950] x7 : ffff0000c03a5590 x6 : 0000000000000080 
[    1.552498] x5 : ffff0000c0098000 x4 : 00000000000003a0 
[    1.558047] x3 : ffff800011cb2dc8 x2 : 0000000000000000 
[    1.563596] x1 : 0000000000000001 x0 : 0000000000000000 
[    1.569146] Call trace:
[    1.571700]  devm_power_supply_get_by_phandle+0xe4/0x148
[    1.577248]  dwc3_probe+0xbac/0xfa0
[    1.580890]  platform_probe+0x68/0xd8
[    1.584719]  really_probe+0xe4/0x3c0
[    1.588454]  driver_probe_device+0x58/0xb8
[    1.592733]  device_driver_attach+0x74/0x80
[    1.597100]  __driver_attach+0x58/0xe0
[    1.601016]  bus_for_each_dev+0x74/0xc8
[    1.605020]  driver_attach+0x24/0x30
[    1.608753]  bus_add_driver+0x184/0x1e8
[    1.612758]  driver_register+0x64/0x120
[    1.616764]  __platform_driver_register+0x28/0x38
[    1.621675]  dwc3_driver_init+0x1c/0x28
[    1.625684]  do_one_initcall+0x74/0x1d0
[    1.629691]  kernel_init_freeable+0x1d4/0x23c
[    1.634240]  kernel_init+0x14/0x118
[    1.637885]  ret_from_fork+0x10/0x30
[    1.641624] Code: 88027c01 35ffffa2 17fffe96 f9800091 (885f7c82) 
[    1.647992] ---[ end trace c6e48cea897d0b0d ]---
[    1.652833] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.660822] SMP: stopping secondary CPUs
[    1.664921] Kernel Offset: disabled
[    1.668560] CPU features: 0x00240002,2000200c
[    1.673106] Memory Limit: none
[    1.676296] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---


---- 8< ----

After reverting these 2 patches the problem is gone.

-- 
Heiko
