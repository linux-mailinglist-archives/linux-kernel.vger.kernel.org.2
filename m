Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF330D258
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 05:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhBCEI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 23:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhBCEI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:08:57 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E2C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 20:08:17 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id a12so22170642qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 20:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiuK79Plnan4/eQkqKREp9OPSNSvuNT4ViEONuYpstE=;
        b=LAZuf82wYt+ahAS6wx+JxLjZzoFu2y/tdF74dlecgKwNFKPgxJKpT+orSt4eTTPfEr
         Fd8FYbHbjbb1i/LSmyM56dO/8oKo+kZpA3OSWGESZoiBD5cgYYTc8NW8vaWvZak6GInh
         E1qb0PNAQvbm/0LuoSvhE+tr2piow8kC3i0VDPFeNZO0Hs/tF59X/4SWXlD9++13A4Qe
         ewUytMJkfYuxVNknMJXaC9DY9QVax1GDoRJrJjWuZHxiChEcPpiQ17Die7cGoyLBBDCV
         QOypivsgJ7JQonbnzARdtrCS/2ZBCVPBCwbqKc11tJsxaiy02MSJTcNmJFRKlPQ/XYm1
         BtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiuK79Plnan4/eQkqKREp9OPSNSvuNT4ViEONuYpstE=;
        b=lgcbTAfJjU3e8V1znEHAsruYVe+uwnaFBvEPM5Qm1kP2nve3CDb5itmuoeiPBA7sR/
         wuHXl/alK2IK+fStbxDisDB1UV8d0Fhkir0lXH4LFAcrfmDf09MeNaCJjKgJCxqkwQyL
         au/yAzth5Y/jOPx8c8h4CUmWc6FbTO8+3BMZmN7koCWckXFh+Lu6TRZoWFwypTsuP1Bu
         7XgWn+gYtrXi/YuetjrMiZTEkPvHWwUDN3HdeM3y83CrCzhZwgNC3xl+/ufv81AmLAVL
         zVoppc+nT0DL3kDiLd9dL6GlImmdXHXC/AWI0gNhVLYNlNtQfldIBjScp/J3NPIj3fmy
         lLVA==
X-Gm-Message-State: AOAM5306NLkobxozDzU9d+Hr3cGZc3kVsbEoLpP6zhfz1Q0Dx0DAiBoO
        FaG+ZJJtMFAVG+lraq0F/g0=
X-Google-Smtp-Source: ABdhPJz5UyytgomPntjDvwsAntwQ5emYwik0rS6cosQWACxURKWwyvmdbGbMzSj1rLVpmUWpCt6v2w==
X-Received: by 2002:a37:62cf:: with SMTP id w198mr940221qkb.146.1612325296351;
        Tue, 02 Feb 2021 20:08:16 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:a44:9c5b:687e:b2f9])
        by smtp.googlemail.com with ESMTPSA id h144sm798239qke.95.2021.02.02.20.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 20:08:15 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH v1] drm/qxl: do not run release if qxl failed to init
Date:   Tue,  2 Feb 2021 23:07:27 -0500
Message-Id: <20210203040727.868921-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if qxl_device_init() fail, drm device will not be registered,
in this case, do not run qxl_drm_release()

[    5.258534] ==================================================================
[    5.258931] BUG: KASAN: user-memory-access in qxl_destroy_monitors_object+0x42/0xa0 [qxl]
[    5.259388] Write of size 8 at addr 00000000000014dc by task modprobe/95
[    5.259754]
[    5.259842] CPU: 0 PID: 95 Comm: modprobe Not tainted 5.11.0-rc6-00007-g88bb507a74ea #62
[    5.260309] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-48-gd9c812dda54
[    5.260917] Call Trace:
[    5.261056]  dump_stack+0x7d/0xa3
[    5.261245]  kasan_report.cold+0x10c/0x10e
[    5.261475]  ? qxl_destroy_monitors_object+0x42/0xa0 [qxl]
[    5.261789]  check_memory_region+0x17c/0x1e0
[    5.262029]  qxl_destroy_monitors_object+0x42/0xa0 [qxl]
[    5.262332]  qxl_modeset_fini+0x9/0x20 [qxl]
[    5.262595]  qxl_drm_release+0x22/0x30 [qxl]
[    5.262841]  drm_dev_release+0x32/0x50
[    5.263047]  release_nodes+0x39e/0x410
[    5.263253]  ? devres_release+0x40/0x40
[    5.263462]  really_probe+0x2ea/0x420
[    5.263664]  driver_probe_device+0x6d/0xd0
[    5.263888]  device_driver_attach+0x82/0x90
[    5.264116]  ? device_driver_attach+0x90/0x90
[    5.264353]  __driver_attach+0x60/0x100
[    5.264563]  ? device_driver_attach+0x90/0x90
[    5.264801]  bus_for_each_dev+0xe1/0x140
[    5.265014]  ? subsys_dev_iter_exit+0x10/0x10
[    5.265251]  ? klist_node_init+0x61/0x80
[    5.265464]  bus_add_driver+0x254/0x2a0
[    5.265673]  driver_register+0xd3/0x150
[    5.265882]  ? 0xffffffffc0048000
[    5.266064]  do_one_initcall+0x84/0x250
[    5.266274]  ? trace_event_raw_event_initcall_finish+0x150/0x150
[    5.266596]  ? unpoison_range+0xf/0x30
[    5.266801]  ? ____kasan_kmalloc.constprop.0+0x84/0xa0
[    5.267082]  ? unpoison_range+0xf/0x30
[    5.267287]  ? unpoison_range+0xf/0x30
[    5.267491]  do_init_module+0xf8/0x350
[    5.267697]  load_module+0x3fe6/0x4340
[    5.267902]  ? vm_unmap_ram+0x1d0/0x1d0
[    5.268115]  ? module_frob_arch_sections+0x20/0x20
[    5.268375]  ? __do_sys_finit_module+0x108/0x170
[    5.268624]  __do_sys_finit_module+0x108/0x170
[    5.268865]  ? __ia32_sys_init_module+0x40/0x40
[    5.269111]  ? file_open_root+0x200/0x200
[    5.269330]  ? do_sys_open+0x85/0xe0
[    5.269527]  ? filp_open+0x50/0x50
[    5.269714]  ? exit_to_user_mode_prepare+0xfc/0x130
[    5.269978]  do_syscall_64+0x33/0x40
[    5.270176]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.270450] RIP: 0033:0x7fa3f685bcf7
[    5.270646] Code: 48 89 57 30 48 8b 04 24 48 89 47 38 e9 1d a0 02 00 48 89 f8 48 89 f7 48 89 d1
[    5.271634] RSP: 002b:00007ffca83048d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    5.272037] RAX: ffffffffffffffda RBX: 0000000001e94a70 RCX: 00007fa3f685bcf7
[    5.272416] RDX: 0000000000000000 RSI: 0000000001e939e0 RDI: 0000000000000003
[    5.272794] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000001
[    5.273171] R10: 00007fa3f68bf300 R11: 0000000000000246 R12: 0000000001e939e0
[    5.273550] R13: 0000000000000000 R14: 0000000001e93bd0 R15: 0000000000000001
[    5.273928] ==================================================================

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 6e7f16f4cec7..41cdf9d1e59d 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -144,6 +144,8 @@ static void qxl_drm_release(struct drm_device *dev)
 	 * reodering qxl_modeset_fini() + qxl_device_fini() calls is
 	 * non-trivial though.
 	 */
+	if (!dev->registered)
+		return;
 	qxl_modeset_fini(qdev);
 	qxl_device_fini(qdev);
 }
-- 
2.25.1

