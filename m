Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FB1378487
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhEJKwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhEJKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:42:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D3C061378
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:32:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gx5so23693833ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yzGPdHIX1YVPICo21NSbsVP+5SzkHjx7KZyNtATokC0=;
        b=uYAu4V/LeEg5u+DgmXF7iqUeNrnhR4WjCGORvFJ+56Kt8VC2RgF3VWolTYz8P0qFPU
         EQNB8hJFCQDhuOFa7O3TOuy7I+m73RGNncUMQmB8Lo6I4CpMUmbzufaKNcV6mP7s4kPF
         zNxNqn9ET5OuBrO8uDmbsSlavty0T9kMLQ4e4VDDpf80y76uvBkoYgtj3Gj1REYHX4Wd
         0r//nWnPy/9MvkKeVIlFJqhmithbhgVmVQvHfNgLGZqxbCnrYm8Jh91og6Dh/Z4iEm7t
         rGjmxPjixyquBB6bXXktzsANEr/TMXn2m9HV0Gb+taMD8KTIP0KJAavfJd2EY1olo0Gd
         wzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yzGPdHIX1YVPICo21NSbsVP+5SzkHjx7KZyNtATokC0=;
        b=WtUb/U9bprHiILvGO/Hga8W2f45DP+vpTWQ8BgBXZtQ+6SWVeIfQLQJwpeA28qgD3Y
         4ySZuUIe0hbfEr5i6mObDSwTCLcu4hiZvA8KSvFKfsA5gcTM7wUZO56Zmf3vTDfUleCY
         cbb/G1XS2g9UTyfBxNE4VRzw/Wzri40PuTjsmh3ZH5XWJvaepOGxvRKFGnqY+1FncA0C
         BsBSIsd5SGkTAl5qWrqA6ShZ6BBbbm5gbG7i9TBLnGjri6Qg6+puZbykG7FUgdMlN9/9
         tfNPKw/WcPVYX7zCFh//2UqojA/sLWaxYZ4U6g6EvXbjzJExQWOeEGnCXSGyEMpUQEjv
         jz9A==
X-Gm-Message-State: AOAM5306Jn4kyWC+hZGNEztb2vZEmbcnoh2wV7BjFP3+v6JtQKkBgW1p
        t6kqTJCFs0X00OvgHOK6OPPeL/htr1kx1usdG7XOzA==
X-Google-Smtp-Source: ABdhPJwarSwqVLHiEz0uPy8CPJcfTaBuTgSEX2xNNrA94gTE6jIH+vmcFm1kljI+VZdsi/fOsM4Cmx8LYEE2xJji/GQ=
X-Received: by 2002:a17:906:17cc:: with SMTP id u12mr24741674eje.170.1620642747002;
 Mon, 10 May 2021 03:32:27 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 May 2021 16:02:14 +0530
Message-ID: <CA+G9fYtZZoX53PjJ0VV54beMN6COccES9agttNYSzW=FbC=NFg@mail.gmail.com>
Subject: Unhandled fault: imprecise external abort (0x1406) at 0x00000000 - PC
 is at xhci_hub_control
To:     linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     peter.chen@kernel.org, jackp@codeaurora.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        mathias.nyman@intel.com, Li Jun <jun.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel crash reported on arm architecture BeagleBoard-X15 device running
Linux next 5.13.0-rc1-next-20210510 while booting the device.

[    4.956085] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    4.961639] xhci-hcd xhci-hcd.1.auto: new USB bus registered,
assigned bus number 2
[    4.969360] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    4.976165] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    4.985321] hub 2-0:1.0: USB hub found
[    4.989196] hub 2-0:1.0: 1 port detected
[    5.002197] Waiting for root device
PARTUUID=6b10e805-12ad-b44e-88b8-3abf3d5f52ed...
[    5.022918] 8<--- cut here ---
[    5.026000] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
[    5.033root
081] pgd = ff6a1748
[    5.035797] [00000000] *pgd=00000000
[    5.039398] Internal error: : 1406 [#1] SMP ARM
[    5.043975] Modules linked in:
[    5.047027] CPU: 0 PID: 22 Comm: kworker/0:1 Not tainted
5.13.0-rc1-next-20210510 #1
[    5.054809] Hardware name: Generic DRA74X (Flattened Device Tree)
[    5.060943] Workqueue: pm pm_runtime_work
[    5.065002] PC is at xhci_hub_control+0xd00/0x248c
[    5.069824] LR is at arm_heavy_mb+0x44/0x48
[    5.074035] pc : [<c0e9ae4c>]    lr : [<c031c968>]    psr: a0000093
[    5.080322] sp : c2371ac0  ip : c2371ab0  fp : c2371b54
[    5.085571] r10: c2370000  r9 : 0e0002a0  r8 : c33d0000
[    5.090820] r7 : c33afc54  r6 : 00000000  r5 : c33d0190  r4 : c33d2000
[    5.097381] r3 : 00000132  r2 : 00000000  r1 : c33afd80  r0 : c1f44c18
[    5.103942] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[    5.111206] Control: 10c5387d  Table: 8020406a  DAC: 00000051
[    5.116973] Register r0 information: non-slab/vmalloc memory
[    5.122680] Register r1 information: slab kmalloc-64 start c33afd80
pointer offset 0 size 64
[    5.131164] Register r2 information: NULL pointer
[    5.135925] Register r3 information: non-paged memory
[    5.140991] Register r4 information: slab kmalloc-8k start c33d2000
pointer offset 0 size 8192
[    5.149688] Register r5 information: slab kmalloc-8k start c33d0000
pointer offset 400 size 8192
[    5.158538] Register r6 information: NULL pointer
[    5.163269] Register r7 information: slab kmalloc-64 start c33afc40
pointer offset 20 size 64
[    5.171844] Register r8 information: slab kmalloc-8k start c33d0000
pointer offset 0 size 8192
[    5.180541] Register r9 information: non-paged memory
[    5.185607] Register r10 information: non-slab/vmalloc memory
[    5.191406] Register r11 information: non-slab/vmalloc memory
[    5.197174] Register r12 information: non-slab/vmalloc memory
[    5.202972] Process kworker/0:1 (pid: 22, stack limit = 0x6f4f02a1)
[    5.209259] Stack: (0xc2371ac0 to 0xc2372000)
[    5.213653] 1ac0: c2371af4 c2371ad0 c030db6c c030eaec c2370000
00000000 ffffe000 c1f23660
[    5.221862] 1ae0: c0e1559c c33b478c c2371b2c c2371af8 00000000
00000000 00000000 c33d0160
[    5.230072] 1b00: 00000000 00000001 c33afd80 0000001b c33afd80
00000001 c0e1559c 20000013
[    5.238311] 1b20: c33de2c0 90964de0 c0448b48 c33b4780 00000000
c33d2000 c2370000 c33de280
[    5.246520] 1b40: 00002303 c0e9a14c c2371c14 c2371b58 c0e13e34
c0e9a158 c33de280 00000000
[    5.254760] 1b60: c0f9d690 c2370000 00000000 00000701 0000001b
00000000 00000000 c1fb2b70
[    5.262969] 1b80: 00000000 00000001 0000040c 00000000 00000001
00000000 00007735 eeb24b00
[    5.271179] 1ba0: c2371bd4 c2371bb0 c030db6c c030eaec c2370000
00000000 ffffe000 c1f23660
[    5.279418] 1bc0: c129a57c 00000000 c2371c0c c2371bd8 c030eb74
c030db48 c2371c3c 00000000
[    5.287628] 1be0: c129a57c 90964de0 c1ca4c90 c33b4780 00000384
c33c9400 00000c00 00000000
[    5.295867] 1c00: 00000000 00000000 c2371c5c c2371c18 c0e1559c
c0e13ac8 c2371c5c c2371c28
[    5.304077] 1c20: c2371c54 c2371c30 c030db6c 00000001 c2370000
c33b4780 00000000 000003e8
[    5.312286] 1c40: c2370000 c2371cc0 c2371c70 0000001b c2371cac
c2371c60 c0e165b4 c0e153d4
[    5.320526] 1c60: c050a374 c0e15acc c33b4800 0000187b 00000000
00000000 c2371c78 c2371c78
[    5.328735] 1c80: c33de240 90964de0 c2370000 c33c9400 00000000
c33de240 00000000 00000701
[    5.336944] 1ca0: c2371cf4 c2371cb0 c0e16790 c0e16550 c030db6c
00000000 80000100 00000023
[    5.345184] 1cc0: c2371cf4 90964de0 c036bbd0 00000002 00000002
c33f6200 c33c9400 c2370000
[    5.353393] 1ce0: c1a0b6c8 c33c9800 c2371d1c c2371cf8 c0e08a68
c0e166c0 0000001b 00000701
[    5.361633] 1d00: 00000000 00000000 000003e8 00000010 c2371d64
c2371d20 c0e0d894 c0e08a20
[    5.369842] 1d20: c2143a00 00000010 c03a4b90 00000402 c2371d64
90964de0 c030db6c 00000000
[    5.378051] 1d40: c33c9400 c33c9800 c0e1b814 c2370000 00000001
00000402 c2371dac c2371d68
[    5.386291] 1d60: c0e1a498 c0e0d6c8 ffffe000 00000000 c1a0cde4
00000400 c1ca4c90 90964de0
[    5.394500] 1d80: ffffe000 c33c9400 c33c9480 00000000 c0e1b814
00000008 c03a4b90 c2370000
[    5.402709] 1da0: c2371dc4 c2371db0 c0e1b84c c0e1a404 c33c9480
c0e1b814 c2371dec c2371dc8
[    5.410949] 1dc0: c0b91700 c0e1b820 c33c9480 c0e1b814 00000008
c2370000 00000008 c03a4b90
[    5.419158] 1de0: c2371e0c c2371df0 c0b917bc c0b91620 c33c9480
c0e1b814 00000008 c2370000
[    5.427398] 1e00: c2371e64 c2371e10 c0b90a7c c0b91798 c12a1aec
00000001 c2371e4c c2371e28
[    5.435607] 1e20: c0448dc8 c030eb1c c33c9504 60000013 00000000
90964de0 00000000 c33c9480
[    5.443817] 1e40: 00000008 60000013 c33c9504 00000000 00000000
c1f22a80 c2371e84 c2371e68
[    5.452056] 1e60: c0b91ec4 c0b90974 c33c9480 c33c9480 00000000
c0e1b8b4 c2371e9c c2371e88
[    5.460266] 1e80: c0e1b8f0 c0b91e64 c33c9480 c33c9480 c2371ec4
c2371ea0 c0b91700 c0e1b8c0
[    5.468475] 1ea0: 00000000 c33c9480 00000002 eeb28f00 00000000
00000000 c2371ee4 c2371ec8
[    5.476715] 1ec0: c0b91108 c0b91620 c33c9560 c234f900 eeb24680
eeb28f00 c2371efc c2371ee8
[    5.484924] 1ee0: c0b920dc c0b9106c c33c9560 c234f900 c2371f3c
c2371f00 c036e1f8 c0b92044
[    5.493133] 1f00: eeb24680 eeb24680 eeb24680 eeb24698 c1d03d00
c234f900 eeb24680 c234f914
[    5.501373] 1f20: eeb24698 c1d03d00 00000008 eeb24680 c2371f74
c2371f40 c036e5a4 c036e004
[    5.509582] 1f40: c2371f74 c2370000 c0374d20 c21e0140 c234ddc0
00000000 c2370000 c036e558
[    5.517791] 1f60: c234f900 c2193e7c c2371fac c2371f78 c037620c
c036e564 c21e0164 c21e0164
[    5.526031] 1f80: c2371fac c234ddc0 c03760c8 00000000 00000000
00000000 00000000 00000000
[    5.534240] 1fa0: 00000000 c2371fb0 c030017c c03760d4 00000000
00000000 00000000 00000000
[    5.542480] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    5.550689] 1fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[    5.558898] Backtrace:
[    5.561370] [<c0e9a14c>] (xhci_hub_control) from [<c0e13e34>]
(usb_hcd_submit_urb+0x378/0xa70)
[    5.570037]  r10:c0e9a14c r9:00002303 r8:c33de280 r7:c2370000
r6:c33d2000 r5:00000000
[    5.577911]  r4:c33b4780
[    5.580444] [<c0e13abc>] (usb_hcd_submit_urb) from [<c0e1559c>]
(usb_submit_urb+0x1d4/0x57c)
[    5.588958]  r10:00000000 r9:00000000 r8:00000000 r7:00000c00
r6:c33c9400 r5:00000384
[    5.596832]  r4:c33b4780
[    5.599365] [<c0e153c8>] (usb_submit_urb) from [<c0e165b4>]
(usb_start_wait_urb+0x70/0x170)
[    5.607757]  r10:0000001b r9:c2371c70 r8:c2371cc0 r7:c2370000
r6:000003e8 r5:00000000
[    5.615631]  r4:c33b4780
[    5.618194] [<c0e16544>] (usb_start_wait_urb) from [<c0e16790>]
(usb_control_msg+0xdc/0x134)
[    5.626678]  r9:00000701 r8:00000000 r7:c33de240 r6:00000000
r5:c33c9400 r4:c2370000
[    5.634460] [<c0e166b4>] (usb_control_msg) from [<c0e08a68>]
(set_port_feature+0x54/0x5c)
[    5.642700]  r10:c33c9800 r9:c1a0b6c8 r8:c2370000 r7:c33c9400
r6:c33f6200 r5:00000002
[    5.650543]  r4:00000002
[    5.653106] [<c0e08a14>] (set_port_feature) from [<c0e0d894>]
(hub_suspend+0x1d8/0x258)
[    5.661163] [<c0e0d6bc>] (hub_suspend) from [<c0e1a498>]
(usb_suspend_both+0xa0/0x24c)
[    5.669128]  r10:00000402 r9:00000001 r8:c2370000 r7:c0e1b814
r6:c33c9800 r5:c33c9400
[    5.676971]  r4:00000000
[    5.679534] [<c0e1a3f8>] (usb_suspend_both) from [<c0e1b84c>]
(usb_runtime_suspend+0x38/0x7c)
[    5.688110]  r10:c2370000 r9:c03a4b90 r8:00000008 r7:c0e1b814
r6:00000000 r5:c33c9480
[    5.695983]  r4:c33c9400
[    5.698516] [<c0e1b814>] (usb_runtime_suspend) from [<c0b91700>]
(__rpm_callback+0xec/0x178)
[    5.707000]  r5:c0e1b814 r4:c33c9480
[    5.710601] [<c0b91614>] (__rpm_callback) from [<c0b917bc>]
(rpm_callback+0x30/0x90)
[    5.718383]  r9:c03a4b90 r8:00000008 r7:c2370000 r6:00000008
r5:c0e1b814 r4:c33c9480
[    5.726165] [<c0b9178c>] (rpm_callback) from [<c0b90a7c>]
(rpm_suspend+0x114/0x6f8)
[    5.733856]  r7:c2370000 r6:00000008 r5:c0e1b814 r4:c33c9480
[    5.739562] [<c0b90968>] (rpm_suspend) from [<c0b91ec4>]
(__pm_runtime_suspend+0x6c/0x15c)
[    5.747863]  r10:c1f22a80 r9:00000000 r8:00000000 r7:c33c9504
r6:60000013 r5:00000008
[    5.755737]  r4:c33c9480
[    5.758270] [<c0b91e58>] (__pm_runtime_suspend) from [<c0e1b8f0>]
(usb_runtime_idle+0x3c/0x44)
[    5.766937]  r7:c0e1b8b4 r6:00000000 r5:c33c9480 r4:c33c9480
[    5.772644] [<c0e1b8b4>] (usb_runtime_idle) from [<c0b91700>]
(__rpm_callback+0xec/0x178)
[    5.780853]  r5:c33c9480 r4:c33c9480
[    5.784454] [<c0b91614>] (__rpm_callback) from [<c0b91108>]
(rpm_idle+0xa8/0x3a8)
[    5.791992]  r9:00000000 r8:00000000 r7:eeb28f00 r6:00000002
r5:c33c9480 r4:00000000
[    5.799774] [<c0b91060>] (rpm_idle) from [<c0b920dc>]
(pm_runtime_work+0xa4/0xb4)
[    5.807281]  r7:eeb28f00 r6:eeb24680 r5:c234f900 r4:c33c9560
[    5.812988] [<c0b92038>] (pm_runtime_work) from [<c036e1f8>]
(process_one_work+0x200/0x560)
[    5.821380]  r5:c234f900 r4:c33c9560
[    5.824981] [<c036dff8>] (process_one_work) from [<c036e5a4>]
(worker_thread+0x4c/0x57c)
[    5.833129]  r10:eeb24680 r9:00000008 r8:c1d03d00 r7:eeb24698
r6:c234f914 r5:eeb24680
[    5.840972]  r4:c234f900
[    5.843536] [<c036e558>] (worker_thread) from [<c037620c>]
(kthread+0x144/0x170)
[    5.850982]  r10:c2193e7c r9:c234f900 r8:c036e558 r7:c2370000
r6:00000000 r5:c234ddc0
[    5.858856]  r4:c21e0140
[    5.861389] [<c03760c8>] (kthread) from [<c030017c>]
(ret_from_fork+0x14/0x38)
[    5.868652] Exception stack(0xc2371fb0 to 0xc2371ff8)
[    5.873718] 1fa0:                                     00000000
00000000 00000000 00000000
[    5.881958] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    5.890167] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.896820]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c03760c8
[    5.904693]  r4:c234ddc0
[    5.907226] Code: f57ff04f e3040c18 e34c01f4 e3003132 (e19030b3)
[    5.913360] ---[ end trace 218234384e5dd78e ]---
[    5.918029] 8<--- cut here ---
[    5.921081] Unable to handle kernel paging request at virtual
address f880350c
[    5.928344] pgd = ff6a1748
[    5.931060] [f880350c] *pgd=00000000
[    5.934661] Internal error: Oops: 5 [#2] SMP ARM
[    5.939300] Modules linked in:
[    5.942382] CPU: 0 PID: 22 Comm: kworker/0:1 Tainted: G      D
     5.13.0-rc1-next-20210510 #1
[    5.951568] Hardware name: Generic DRA74X (Flattened Device Tree)
[    5.957672] Workqueue: pm pm_runtime_work
[    5.961730] PC is at l3_interrupt_handler+0x80/0x39c
[    5.966705] LR is at 0xf880350c
[    5.969879] pc : [<c0893cc0>]    lr : [<f880350c>]    psr: 20000193
[    5.976165] sp : c2371770  ip : 00000003  fp : c237182c
[    5.981414] r10: 00000060  r9 : c1f229a0  r8 : 00000060
[    5.986663] r7 : f8000000  r6 : c21e34c0  r5 : c1dfce78  r4 : c21e51c0
[    5.993225] r3 : 00000000  r2 : c1dfcc04  r1 : c21e34c8  r0 : 0000000c
[    5.999786] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[    6.007049] Control: 10c5387d  Table: 8020406a  DAC: 00000051
[    6.012817] Register r0 information: non-paged memory
[    6.017913] Register r1 information: slab kmalloc-128 start
c21e3480 pointer offset 72 size 128
[    6.026672] Register r2 information: non-slab/vmalloc memory
[    6.032379] Register r3 information: NULL pointer
[    6.037109] Register r4 information: slab kmalloc-64 start c21e51c0
pointer offset 0 size 64
[    6.045623] Register r5 information: non-slab/vmalloc memory
[    6.051300] Register r6 information: slab kmalloc-128 start
c21e3480 pointer offset 64 size 128
[    6.060058] Register r7 information: 0-page vmalloc region starting
at 0xf8000000 allocated at iotable_init+0x0/0xfc
[    6.070648] Register r8 information: non-paged memory
[    6.075744] Register r9 information: non-slab/vmalloc memory
[    6.081420] Register r10 information: non-paged memory
[    6.086608] Register r11 information: non-slab/vmalloc memory
[    6.092376] Register r12 information: non-paged memory
[    6.097534] Process kworker/0:1 (pid: 22, stack limit = 0x6f4f02a1)
[    6.103851] Stack: (0xc2371770 to 0xc2372000)
[    6.108215] 1760:                                     c0a8c794
c03ba2ac c1d2a410 00000000
[    6.116455] 1780: ffffffea 000001bc 000001bc 00000000 00000000
c23717a0 c2370000 c03b9f2c
[    6.124664] 17a0: 00000000 00000034 c2370000 00000001 00000400
c1f5da88 00000001 00000000
[    6.132904] 17c0: 00000000 c2371810 00000000 00000000 ffffefff
00000001 00000001 90964de0
[    6.141113] 17e0: c237180c c1f5de90 00000000 c1d2a398 c1f5deb0
c1d09fc4 c1f5d970 90964de0
[    6.149322] 1800: c2371824 c21e51c0 c21e8100 00000000 c21e8100
c2371878 c1f229a0 00000060
[    6.157562] 1820: c2371874 c2371830 c03bc328 c0893c4c c23718b4
c2370000 c1f22103 c1d09f50
[    6.165771] 1840: c2370000 c1f229c0 c2370000 c2370000 c21e8100
c21e816c 00000000 c20f4000
[    6.174011] 1860: c2371938 c21ba440 c237189c c2371878 c03bc504
c03bc284 00000000 90964de0
[    6.182220] 1880: 82000024 c21e8100 c1d130ec c21e816c c23718bc
c23718a0 c03bc5ac c03bc4d0
[    6.190429] 18a0: c21e8100 c1d130ec 00000001 00000000 c23718d4
c23718c0 c03c1900 c03bc564
[    6.198669] 18c0: c1ca52d8 00000000 c23718e4 c23718d8 c03bb2e0
c03c1860 c237190c c23718e8
[    6.206878] 18e0: c03bbb40 c03bb2a8 c1d0a980 c1dfa734 fa212000
c1ca52e4 fa21200c c2371938
[    6.215087] 1900: c2371934 c2371910 c030192c c03bbae0 c03fe488
60000113 ffffffff c237196c
[    6.223327] 1920: 00000000 c2370000 c23719a4 c2371938 c0300bb0
c0301898 c03fe484 00000000
[    6.231536] 1940: 2ce7e000 60000193 c21ba440 c21ba9bc 00000494
ffffe000 00000000 60000193
[    6.239776] 1960: c21ba440 c23719a4 00000000 c2371988 c0448b48
c03fe488 60000113 ffffffff
[    6.247985] 1980: 00000051 bf000000 c21ba440 00000000 0000000b
ffffe000 c23719bc c23719a8
[    6.256195] 19a0: c034bd88 c03fe438 c21ba440 00000000 c23719e4
c23719c0 c0354e00 c034bd74
[    6.264434] 19c0: 0000000b c1d0fe3c c23719e4 90964de0 c034ee50
c1d0fe3c c2371a24 c23719e8
[    6.272644] 19e0: c030e458 c0354c14 c2370220 0000000b c2371a34
ffffe000 c1282914 c1d108ac
[    6.280853] 1a00: 00001406 00000000 c03181d0 c2371a70 c2370000
c2370000 c2371a34 c2371a28
[    6.289093] 1a20: c030e4c4 c030e0bc c2371a6c c2371a38 c031846c
c030e470 00000000 00001406
[    6.297302] 1a40: 00000000 c030db48 c0e9ae4c c0e9ae4c a0000093
ffffffff c2371aa4 c33d0000
[    6.305511] 1a60: c2371b54 c2371a70 c0300afc c03183ac c1f44c18
c33afd80 00000000 00000132
[    6.313751] 1a80: c33d2000 c33d0190 00000000 c33afc54 c33d0000
0e0002a0 c2370000 c2371b54
[    6.321960] 1aa0: c2371ab0 c2371ac0 c031c968 c0e9ae4c a0000093
ffffffff 00000051 00000000
[    6.330200] 1ac0: c2371af4 c2371ad0 c030db6c c030eaec c2370000
00000000 ffffe000 c1f23660
[    6.338409] 1ae0: c0e1559c c33b478c c2371b2c c2371af8 00000000
00000000 00000000 c33d0160
[    6.346618] 1b00: 00000000 00000001 c33afd80 0000001b c33afd80
00000001 c0e1559c 20000013
[    6.354858] 1b20: c33de2c0 90964de0 c0448b48 c33b4780 00000000
c33d2000 c2370000 c33de280
[    6.363067] 1b40: 00002303 c0e9a14c c2371c14 c2371b58 c0e13e34
c0e9a158 c33de280 00000000
[    6.371276] 1b60: c0f9d690 c2370000 00000000 00000701 0000001b
00000000 00000000 c1fb2b70
[    6.379516] 1b80: 00000000 00000001 0000040c 00000000 00000001
00000000 00007735 eeb24b00
[    6.387725] 1ba0: c2371bd4 c2371bb0 c030db6c c030eaec c2370000
00000000 ffffe000 c1f23660
[    6.395935] 1bc0: c129a57c 00000000 c2371c0c c2371bd8 c030eb74
c030db48 c2371c3c 00000000
[    6.404174] 1be0: c129a57c 90964de0 c1ca4c90 c33b4780 00000384
c33c9400 00000c00 00000000
[    6.412384] 1c00: 00000000 00000000 c2371c5c c2371c18 c0e1559c
c0e13ac8 c2371c5c c2371c28
[    6.420623] 1c20: c2371c54 c2371c30 c030db6c 00000001 c2370000
c33b4780 00000000 000003e8
[    6.428833] 1c40: c2370000 c2371cc0 c2371c70 0000001b c2371cac
c2371c60 c0e165b4 c0e153d4
[    6.437042] 1c60: c050a374 c0e15acc c33b4800 0000187b 00000000
00000000 c2371c78 c2371c78
[    6.445281] 1c80: c33de240 90964de0 c2370000 c33c9400 00000000
c33de240 00000000 00000701
[    6.453491] 1ca0: c2371cf4 c2371cb0 c0e16790 c0e16550 c030db6c
00000000 80000100 00000023
[    6.461730] 1cc0: c2371cf4 90964de0 c036bbd0 00000002 00000002
c33f6200 c33c9400 c2370000
[    6.469940] 1ce0: c1a0b6c8 c33c9800 c2371d1c c2371cf8 c0e08a68
c0e166c0 0000001b 00000701
[    6.478149] 1d00: 00000000 00000000 000003e8 00000010 c2371d64
c2371d20 c0e0d894 c0e08a20
[    6.486389] 1d20: c2143a00 00000010 c03a4b90 00000402 c2371d64
90964de0 c030db6c 00000000
[    6.494598] 1d40: c33c9400 c33c9800 c0e1b814 c2370000 00000001
00000402 c2371dac c2371d68
[    6.502807] 1d60: c0e1a498 c0e0d6c8 ffffe000 00000000 c1a0cde4
00000400 c1ca4c90 90964de0
[    6.511047] 1d80: ffffe000 c33c9400 c33c9480 00000000 c0e1b814
00000008 c03a4b90 c2370000
[    6.519256] 1da0: c2371dc4 c2371db0 c0e1b84c c0e1a404 c33c9480
c0e1b814 c2371dec c2371dc8
[    6.527465] 1dc0: c0b91700 c0e1b820 c33c9480 c0e1b814 00000008
c2370000 00000008 c03a4b90
[    6.535705] 1de0: c2371e0c c2371df0 c0b917bc c0b91620 c33c9480
c0e1b814 00000008 c2370000
[    6.543914] 1e00: c2371e64 c2371e10 c0b90a7c c0b91798 c12a1aec
00000001 c2371e4c c2371e28
[    6.552124] 1e20: c0448dc8 c030eb1c c33c9504 60000013 00000000
90964de0 00000000 c33c9480
[    6.560363] 1e40: 00000008 60000013 c33c9504 00000000 00000000
c1f22a80 c2371e84 c2371e68
[    6.568572] 1e60: c0b91ec4 c0b90974 c33c9480 c33c9480 00000000
c0e1b8b4 c2371e9c c2371e88
[    6.576782] 1e80: c0e1b8f0 c0b91e64 c33c9480 c33c9480 c2371ec4
c2371ea0 c0b91700 c0e1b8c0
[    6.585021] 1ea0: 00000000 c33c9480 00000002 eeb28f00 00000000
00000000 c2371ee4 c2371ec8
[    6.593231] 1ec0: c0b91108 c0b91620 c33c9560 c234f900 eeb24680
eeb28f00 c2371efc c2371ee8
[    6.601470] 1ee0: c0b920dc c0b9106c c33c9560 c234f900 c2371f3c
c2371f00 c036e1f8 c0b92044
[    6.609680] 1f00: eeb24680 eeb24680 eeb24680 eeb24698 c1d03d00
c234f900 eeb24680 c234f914
[    6.617889] 1f20: eeb24698 c1d03d00 00000008 eeb24680 c2371f74
c2371f40 c036e5a4 c036e004
[    6.626129] 1f40: c2371f74 c2370000 c0374d20 c21e0140 c234ddc0
00000000 c2370000 c036e558
[    6.634338] 1f60: c234f900 c2193e7c c2371fac c2371f78 c037620c
c036e564 c21e0164 c21e0164
[    6.642547] 1f80: c2371fac c234ddc0 c03760c8 00000000 00000000
00000000 00000000 00000000
[    6.650787] 1fa0: 00000000 c2371fb0 c030017c c03760d4 00000000
00000000 00000000 00000000
[    6.658996] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    6.667205] 1fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[    6.675445] Backtrace:
[    6.677886] [<c0893c40>] (l3_interrupt_handler) from [<c03bc328>]
(__handle_irq_event_percpu+0xb0/0x24c)
[    6.687438]  r10:00000060 r9:c1f229a0 r8:c2371878 r7:c21e8100
r6:00000000 r5:c21e8100
[    6.695312]  r4:c21e51c0
[    6.697845] [<c03bc278>] (__handle_irq_event_percpu) from
[<c03bc504>] (handle_irq_event_percpu+0x40/0x94)
[    6.707550]  r10:c21ba440 r9:c2371938 r8:c20f4000 r7:00000000
r6:c21e816c r5:c21e8100
[    6.715423]  r4:c2370000
[    6.717956] [<c03bc4c4>] (handle_irq_event_percpu) from
[<c03bc5ac>] (handle_irq_event+0x54/0x78)
[    6.726898]  r6:c21e816c r5:c1d130ec r4:c21e8100
[    6.731536] [<c03bc558>] (handle_irq_event) from [<c03c1900>]
(handle_fasteoi_irq+0xac/0x128)
[    6.740112]  r7:00000000 r6:00000001 r5:c1d130ec r4:c21e8100
[    6.745788] [<c03c1854>] (handle_fasteoi_irq) from [<c03bb2e0>]
(generic_handle_irq+0x44/0x54)
[    6.754455]  r5:00000000 r4:c1ca52d8
[    6.758056] [<c03bb29c>] (generic_handle_irq) from [<c03bbb40>]
(__handle_domain_irq+0x6c/0xc0)
[    6.766815] [<c03bbad4>] (__handle_domain_irq) from [<c030192c>]
(gic_handle_irq+0xa0/0xc0)
[    6.775207]  r9:c2371938 r8:fa21200c r7:c1ca52e4 r6:fa212000
r5:c1dfa734 r4:c1d0a980
[    6.782989] [<c030188c>] (gic_handle_irq) from [<c0300bb0>]
(__irq_svc+0x70/0x98)
[    6.790527] Exception stack(0xc2371938 to 0xc2371980)
[    6.795593] 1920:
    c03fe484 00000000
[    6.803802] 1940: 2ce7e000 60000193 c21ba440 c21ba9bc 00000494
ffffe000 00000000 60000193
[    6.812042] 1960: c21ba440 c23719a4 00000000 c2371988 c0448b48
c03fe488 60000113 ffffffff
[    6.820251]  r9:c2370000 r8:00000000 r7:c237196c r6:ffffffff
r5:60000113 r4:c03fe488
[    6.828033] [<c03fe42c>] (futex_exit_release) from [<c034bd88>]
(exit_mm_release+0x20/0x30)
[    6.836425]  r7:ffffe000 r6:0000000b r5:00000000 r4:c21ba440
[    6.842132] [<c034bd68>] (exit_mm_release) from [<c0354e00>]
(do_exit+0x1f8/0xaf8)
[    6.849731]  r5:00000000 r4:c21ba440
[    6.853332] [<c0354c08>] (do_exit) from [<c030e458>] (die+0x3a8/0x3b4)
[    6.859893]  r7:c1d0fe3c
[    6.862457] [<c030e0b0>] (die) from [<c030e4c4>] (arm_notify_die+0x60/0x64)
[    6.869445]  r10:c2370000 r9:c2370000 r8:c2371a70 r7:c03181d0
r6:00000000 r5:00001406
[    6.877319]  r4:c1d108ac
[    6.879882] [<c030e464>] (arm_notify_die) from [<c031846c>]
(do_DataAbort+0xcc/0xd0)
[    6.887664] [<c03183a0>] (do_DataAbort) from [<c0300afc>]
(__dabt_svc+0x5c/0xa0)
[    6.895111] Exception stack(0xc2371a70 to 0xc2371ab8)
[    6.900177] 1a60:                                     c1f44c18
c33afd80 00000000 00000132
[    6.908386] 1a80: c33d2000 c33d0190 00000000 c33afc54 c33d0000
0e0002a0 c2370000 c2371b54
[    6.916625] 1aa0: c2371ab0 c2371ac0 c031c968 c0e9ae4c a0000093 ffffffff
[    6.923278]  r8:c33d0000 r7:c2371aa4 r6:ffffffff r5:a0000093 r4:c0e9ae4c
[    6.929992] [<c0e9a14c>] (xhci_hub_control) from [<c0e13e34>]
(usb_hcd_submit_urb+0x378/0xa70)
[    6.938659]  r10:c0e9a14c r9:00002303 r8:c33de280 r7:c2370000
r6:c33d2000 r5:00000000
[    6.946533]  r4:c33b4780
[    6.949066] [<c0e13abc>] (usb_hcd_submit_urb) from [<c0e1559c>]
(usb_submit_urb+0x1d4/0x57c)
[    6.957580]  r10:00000000 r9:00000000 r8:00000000 r7:00000c00
r6:c33c9400 r5:00000384
[    6.965454]  r4:c33b4780
[    6.967987] [<c0e153c8>] (usb_submit_urb) from [<c0e165b4>]
(usb_start_wait_urb+0x70/0x170)
[    6.976379]  r10:0000001b r9:c2371c70 r8:c2371cc0 r7:c2370000
r6:000003e8 r5:00000000
[    6.984252]  r4:c33b4780
[    6.986816] [<c0e16544>] (usb_start_wait_urb) from [<c0e16790>]
(usb_control_msg+0xdc/0x134)
[    6.995300]  r9:00000701 r8:00000000 r7:c33de240 r6:00000000
r5:c33c9400 r4:c2370000
[    7.003082] [<c0e166b4>] (usb_control_msg) from [<c0e08a68>]
(set_port_feature+0x54/0x5c)
[    7.011291]  r10:c33c9800 r9:c1a0b6c8 r8:c2370000 r7:c33c9400
r6:c33f6200 r5:00000002
[    7.019165]  r4:00000002
[    7.021728] [<c0e08a14>] (set_port_feature) from [<c0e0d894>]
(hub_suspend+0x1d8/0x258)
[    7.029754] [<c0e0d6bc>] (hub_suspend) from [<c0e1a498>]
(usb_suspend_both+0xa0/0x24c)
[    7.037719]  r10:00000402 r9:00000001 r8:c2370000 r7:c0e1b814
r6:c33c9800 r5:c33c9400
[    7.045593]  r4:00000000
[    7.048156] [<c0e1a3f8>] (usb_suspend_both) from [<c0e1b84c>]
(usb_runtime_suspend+0x38/0x7c)
[    7.056732]  r10:c2370000 r9:c03a4b90 r8:00000008 r7:c0e1b814
r6:00000000 r5:c33c9480
[    7.064605]  r4:c33c9400
[    7.067138] [<c0e1b814>] (usb_runtime_suspend) from [<c0b91700>]
(__rpm_callback+0xec/0x178)
[    7.075622]  r5:c0e1b814 r4:c33c9480
[    7.079223] [<c0b91614>] (__rpm_callback) from [<c0b917bc>]
(rpm_callback+0x30/0x90)
[    7.087005]  r9:c03a4b90 r8:00000008 r7:c2370000 r6:00000008
r5:c0e1b814 r4:c33c9480
[    7.094787] [<c0b9178c>] (rpm_callback) from [<c0b90a7c>]
(rpm_suspend+0x114/0x6f8)
[    7.102478]  r7:c2370000 r6:00000008 r5:c0e1b814 r4:c33c9480
[    7.108184] [<c0b90968>] (rpm_suspend) from [<c0b91ec4>]
(__pm_runtime_suspend+0x6c/0x15c)
[    7.116485]  r10:c1f22a80 r9:00000000 r8:00000000 r7:c33c9504
r6:60000013 r5:00000008
[    7.124359]  r4:c33c9480
[    7.126892] [<c0b91e58>] (__pm_runtime_suspend) from [<c0e1b8f0>]
(usb_runtime_idle+0x3c/0x44)
[    7.135559]  r7:c0e1b8b4 r6:00000000 r5:c33c9480 r4:c33c9480
[    7.141235] [<c0e1b8b4>] (usb_runtime_idle) from [<c0b91700>]
(__rpm_callback+0xec/0x178)
[    7.149475]  r5:c33c9480 r4:c33c9480
[    7.153076] [<c0b91614>] (__rpm_callback) from [<c0b91108>]
(rpm_idle+0xa8/0x3a8)
[    7.160583]  r9:00000000 r8:00000000 r7:eeb28f00 r6:00000002
r5:c33c9480 r4:00000000
[    7.168365] [<c0b91060>] (rpm_idle) from [<c0b920dc>]
(pm_runtime_work+0xa4/0xb4)
[    7.175903]  r7:eeb28f00 r6:eeb24680 r5:c234f900 r4:c33c9560
[    7.181579] [<c0b92038>] (pm_runtime_work) from [<c036e1f8>]
(process_one_work+0x200/0x560)
[    7.190002]  r5:c234f900 r4:c33c9560
[    7.193572] [<c036dff8>] (process_one_work) from [<c036e5a4>]
(worker_thread+0x4c/0x57c)
[    7.201721]  r10:eeb24680 r9:00000008 r8:c1d03d00 r7:eeb24698
r6:c234f914 r5:eeb24680
[    7.209594]  r4:c234f900
[    7.212127] [<c036e558>] (worker_thread) from [<c037620c>]
(kthread+0x144/0x170)
[    7.219573]  r10:c2193e7c r9:c234f900 r8:c036e558 r7:c2370000
r6:00000000 r5:c234ddc0
[    7.227447]  r4:c21e0140
[    7.230010] [<c03760c8>] (kthread) from [<c030017c>]
(ret_from_fork+0x14/0x38)
[    7.237274] Exception stack(0xc2371fb0 to 0xc2371ff8)
[    7.242340] 1fa0:                                     00000000
00000000 00000000 00000000
[    7.250549] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    7.258789] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    7.265441]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c03760c8
[    7.273284]  r4:c234ddc0
[    7.275848] Code: e4917004 e595e000 e080e00e e087e00e (e59e4000)
[    7.281982] ---[ end trace 218234384e5dd78f ]---
[    7.286621] Kernel panic - not syncing: Fatal exception in interrupt
[    7.292999] CPU1: stopping
[    7.295745] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
  5.13.0-rc1-next-20210510 #1
[    7.304656] Hardware name: Generic DRA74X (Flattened Device Tree)
[    7.310791] Backtrace:
[    7.313232] [<c1282244>] (dump_backtrace) from [<c12825f0>]
(show_stack+0x20/0x24)
[    7.320861]  r7:c1df9d14 r6:60000193 r5:00000000 r4:c1df9d14
[    7.326538] [<c12825d0>] (show_stack) from [<c1287cac>]
(dump_stack+0xe4/0x104)
[    7.333892] [<c1287bc8>] (dump_stack) from [<c031133c>]
(do_handle_IPI+0x324/0x358)
[    7.341613]  r10:c21a6000 r9:c21a7f10 r8:c20f4000 r7:c2004c40
r6:00000001 r5:c1f228a0
[    7.349487]  r4:c1f57680 r3:da8933e3
[    7.353057] [<c0311018>] (do_handle_IPI) from [<c0311398>]
(ipi_handler+0x28/0x30)
[    7.360687]  r9:c21a7f10 r8:c20f4000 r7:c2004c40 r6:00000014
r5:c1d0a980 r4:c20f3c00
[    7.368469] [<c0311370>] (ipi_handler) from [<c03c2620>]
(handle_percpu_devid_irq+0x9c/0x214)
[    7.377044] [<c03c2584>] (handle_percpu_devid_irq) from
[<c03bb2e0>] (generic_handle_irq+0x44/0x54)
[    7.386138]  r7:00000000 r6:00000001 r5:00000000 r4:c1ca52d8
[    7.391845] [<c03bb29c>] (generic_handle_irq) from [<c03bbb40>]
(__handle_domain_irq+0x6c/0xc0)
[    7.400573] [<c03bbad4>] (__handle_domain_irq) from [<c030192c>]
(gic_handle_irq+0xa0/0xc0)
[    7.408996]  r9:c21a7f10 r8:fa21200c r7:c1ca52e4 r6:fa212000
r5:c1dfa734 r4:c1d0a980
[    7.416778] [<c030188c>] (gic_handle_irq) from [<c0300bb0>]
(__irq_svc+0x70/0x98)
[    7.424285] Exception stack(0xc21a7f10 to 0xc21a7f58)
[    7.429382] 7f00:                                     00000000
00001c8c fe600000 00000000
[    7.437591] 7f20: c1f236c0 c21a6000 c1d09f50 c1d09fa4 00000000
00000000 c21a6000 c21a7f6c
[    7.445800] 7f40: c21a7f4c c21a7f60 c0336560 c030a0f8 60000013 ffffffff
[    7.452453]  r9:c21a6000 r8:00000000 r7:c21a7f44 r6:ffffffff
r5:60000013 r4:c030a0f8
[    7.460235] [<c030a0c8>] (arch_cpu_idle) from [<c12a14f0>]
(default_idle_call+0x54/0x104)
[    7.468475] [<c12a149c>] (default_idle_call) from [<c038e670>]
(do_idle+0x254/0x2c8)
[    7.476257]  r5:c21a6000 r4:00000001
[    7.479858] [<c038e41c>] (do_idle) from [<c038ea24>]
(cpu_startup_entry+0x28/0x2c)
[    7.487457]  r10:00000000 r9:412fc0f2 r8:8020406a r7:c21a7ff8
r6:10c0387d r5:00000001
[    7.495330]  r4:00000093
[    7.497894] [<c038e9fc>] (cpu_startup_entry) from [<c0311cf0>]
(secondary_start_kernel+0x17c/0x1a0)
[    7.506988] [<c0311b74>] (secondary_start_kernel) from [<803022f0>]
(0x803022f0)
[    7.514434]  r5:00000051 r4:8219c06a
[    7.518035] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/2665557#L2214

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git commit: e6f67ebd93efb1234126d4d1e71bc9ec03e600fe
  git describe: next-20210510
  make_kernelversion: 5.13.0-rc1
  kernel-config: https://builds.tuxbuild.com/1sKeVJRzVqV266BEdeSbPcVtcE5/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/300036735

--
Linaro LKFT
https://lkft.linaro.org
