Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41985425A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbhJGSCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:02:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50656 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242977AbhJGSCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:02:30 -0400
Received: from zn.tnic (p200300ec2f1265004099ae2673030416.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:6500:4099:ae26:7303:416])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8AE71EC04B9;
        Thu,  7 Oct 2021 20:00:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633629634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=0HErzW2Xgd+VAD7lO25L8kiE23nsQSgkQGKELNJ6VJo=;
        b=VWyU/9ueUrqDniR8A788IwMfLzyokAUUvacI7Zz2k0dx7L2hj7NoEOgfDYcn4BgtAr5YJF
        NWMzSYI1Y7AnnFQUc4JhjGm4TSmSPRODvBV01iYQnTkYIGStpairtzbm7owOHJoRI10hia
        WF2QukU/B8YydOqJr1TSqRwWkl1sA1c=
Date:   Thu, 7 Oct 2021 20:00:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, xinhui pan <xinhui.pan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>
Subject: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Message-ID: <YV81vidWQLWvATMM@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

commit in $Subject breaks rebooting an HP laptop here with a Carrizo
chipset: after typing "reboot" and pressing Enter, it powers off the
machine up to a certain point but the fans remain on, screen goes black
and nothing happens anymore. No reboot. I have to power it off by
holding the power key down for 4 seconds.

Reverting the patch fixes the issue.

GPU info on that machine:

[    1.462214] [drm] amdgpu kernel modesetting enabled.
[    1.465150] amdgpu 0000:00:01.0: vgaarb: deactivate vga console
[    1.466259] Console: switching to colour dummy device 80x25
[    1.466844] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874 0x103C:0x807E 0xC4).
[    1.467242] amdgpu 0000:00:01.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[    1.467552] [drm] register mmio base: 0xD0C00000
[    1.467750] [drm] register mmio size: 262144
[    1.467901] [drm] add ip block number 0 <vi_common>
[    1.468067] [drm] add ip block number 1 <gmc_v8_0>
[    1.468266] [drm] add ip block number 2 <cz_ih>
[    1.468436] [drm] add ip block number 3 <gfx_v8_0>
[    1.468603] [drm] add ip block number 4 <sdma_v3_0>
[    1.468809] [drm] add ip block number 5 <powerplay>
[    1.468975] [drm] add ip block number 6 <dm>
[    1.469120] [drm] add ip block number 7 <uvd_v6_0>
[    1.469282] [drm] add ip block number 8 <vce_v3_0>
[    1.485350] [drm] BIOS signature incorrect 20 7
[    1.485494] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000c0000-
0x000c3fff window]
[    1.485922] caller pci_map_rom+0x68/0x1b0 mapping multiple BARs
[    1.486273] amdgpu 0000:00:01.0: amdgpu: Fetched VBIOS from ROM BAR
[    1.486488] amdgpu: ATOM BIOS: SWBRT27354.001
[    1.486701] [drm] UVD is enabled in physical mode
[    1.486862] [drm] VCE enabled in physical mode
[    1.487061] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[    1.487339] amdgpu 0000:00:01.0: amdgpu: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[    1.487652] amdgpu 0000:00:01.0: amdgpu: GART: 1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF
[    1.487939] [drm] Detected VRAM RAM=512M, BAR=512M
[    1.488101] [drm] RAM width 128bits UNKNOWN
[    1.488309] [drm] amdgpu: 512M of VRAM memory ready
[    1.488522] [drm] amdgpu: 3072M of GTT memory ready.
[    1.488707] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    1.488997] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
[    1.491962] amdgpu: hwmgr_sw_init smu backed is smu8_smu
[    1.492544] [drm] Found UVD firmware Version: 1.91 Family ID: 11
[    1.492764] [drm] UVD ENC is disabled
[    1.494177] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[    1.495765] amdgpu: smu version 18.62.00
[    1.501983] [drm] DM_PPLIB: values for Engine clock
[    1.502201] [drm] DM_PPLIB:   300000
[    1.502321] [drm] DM_PPLIB:   360000
[    1.502441] [drm] DM_PPLIB:   423530
[    1.502561] [drm] DM_PPLIB:   514290
[    1.502680] [drm] DM_PPLIB:   626090
[    1.502799] [drm] DM_PPLIB:   720000
[    1.502919] [drm] DM_PPLIB: Validation clocks:
[    1.503069] [drm] DM_PPLIB:    engine_max_clock: 72000
[    1.503242] [drm] DM_PPLIB:    memory_max_clock: 80000
[    1.503415] [drm] DM_PPLIB:    level           : 8
[    1.503578] [drm] DM_PPLIB: values for Display clock
[    1.503745] [drm] DM_PPLIB:   300000
[    1.503864] [drm] DM_PPLIB:   400000
[    1.503984] [drm] DM_PPLIB:   496560
[    1.504147] [drm] DM_PPLIB:   626090
[    1.504275] [drm] DM_PPLIB:   685720
[    1.504403] [drm] DM_PPLIB:   757900
[    1.504526] [drm] DM_PPLIB: Validation clocks:
[    1.504678] [drm] DM_PPLIB:    engine_max_clock: 72000
[    1.504891] [drm] DM_PPLIB:    memory_max_clock: 80000
[    1.505063] [drm] DM_PPLIB:    level           : 8
[    1.505225] [drm] DM_PPLIB: values for Memory clock
[    1.505389] [drm] DM_PPLIB:   333000
[    1.505508] [drm] DM_PPLIB:   800000
[    1.505628] [drm] DM_PPLIB: Validation clocks:
[    1.505777] [drm] DM_PPLIB:    engine_max_clock: 72000
[    1.505950] [drm] DM_PPLIB:    memory_max_clock: 80000
[    1.506123] [drm] DM_PPLIB:    level           : 8
[    1.506375] [drm] Display Core initialized with v3.2.149!
[    1.584817] [drm] UVD initialized successfully.
[    1.784234] [drm] VCE initialized successfully.
[    1.784415] amdgpu 0000:00:01.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 8
[    1.787958] [drm] fb mappable at 0xA0EE4000
[    1.788118] [drm] vram apper at 0xA0000000
[    1.788258] [drm] size 14745600
[    1.788367] [drm] fb depth is 24
[    1.788503] [drm]    pitch is 10240
[    1.789198] fbcon: amdgpu (fb0) is primary device
[    1.880014] Console: switching to colour frame buffer device 320x90
[    1.903779] amdgpu 0000:00:01.0: [drm] fb0: amdgpu frame buffer device
[    1.918353] [drm] Initialized amdgpu 3.42.0 20150101 for 0000:00:01.0 on minor 0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
