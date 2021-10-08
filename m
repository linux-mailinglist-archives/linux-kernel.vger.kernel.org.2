Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8DD426CEC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbhJHOrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhJHOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:47:54 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BEEC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 07:45:59 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id u20-20020a9d7214000000b0054e170300adso11889800otj.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7dFLhYeU1UnQtPmj8GBiVDqhCnFKhWUtLpXtWU1raQ=;
        b=qvzgYiP6LG4BagREHkQijuL6mPyn0h/8qd0XmGwgktSBjwG5IHKfO3FW2pLyiQhZMG
         ZePH8+Z5nZR5CUh7KG3qamkxSdT20BMvIphWs/80jLVeRQZu6/DxwDCAhWOlfC18uLgm
         iLHB/CAbOanNDWvWblwyyvHQB44m/4CsoXHQUGTfd5khC6fxvv/gCkV4niBVcy9Rge1f
         rRJzl6NgNCBqBtaW9cgy9wXkBMngaPU+pQXdvXnnEjkGATYlGlAHlkCbYf0wcvVr/N1Y
         glzPESgoIm98CP+WUjd8wCNQsYcpRjaVG/H5sPeFqnXaZ3UH7+vraDsATSferHJZ7JSa
         KS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7dFLhYeU1UnQtPmj8GBiVDqhCnFKhWUtLpXtWU1raQ=;
        b=B3Lrp6qRbFU1CPmehdrfUOj4rFVpBHQZQEpFjbEYIB8xj001kzFlrlx1Dz3Me0rAI/
         IbkKNz/rtNUWYzkxmHHJ2+4WCaBMBK/GElp0YKLAugOdFs32sBX7SGBqvsdmXbSIdV4O
         DB+QBOtTLFbF720JHQAaH2SRahTCTMUewRCXJbqN9FgMkeXn/dteD44eKgj3tA2tM74R
         WWargV7rrUVuUf46aupxOrQ8XgE1RvQ3/T/9dMKsnDOPR8ItqKKzCz0VbHjJ32YCsuCF
         Kzh0zO2bnRD3vmexHBzXQUcXPYtwsmyvAbEsvoWpu67/tIefUYG8YREVVw/WEnNZlJI2
         ObsA==
X-Gm-Message-State: AOAM533402fGOeQPx7argqOCeqMthNNV2TDclG2d8f2zpFv0KJlMMKq6
        bVSfsvTSZnrWZWJqRHs6a/QSB88QeLQJXH562Qw=
X-Google-Smtp-Source: ABdhPJyjogsCGr5BH/t6EujYjI/O4sMv1JpWYeo4LEeOtpAzXzAZV3sMsi0ISOiYHV0rIMJlFzxGipK3vppJnpcwrLE=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr8914719otd.200.1633704358481;
 Fri, 08 Oct 2021 07:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <YV81vidWQLWvATMM@zn.tnic>
In-Reply-To: <YV81vidWQLWvATMM@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Oct 2021 10:45:47 -0400
Message-ID: <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
To:     Borislav Petkov <bp@alien8.de>, "Quan, Evan" <Evan.Quan@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 2:03 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi folks,
>
> commit in $Subject breaks rebooting an HP laptop here with a Carrizo
> chipset: after typing "reboot" and pressing Enter, it powers off the
> machine up to a certain point but the fans remain on, screen goes black
> and nothing happens anymore. No reboot. I have to power it off by
> holding the power key down for 4 seconds.
>
> Reverting the patch fixes the issue.

@Quan, Evan any ideas?  I don't have a CZ system handy at the moment.
Worse comes to worst we could just wrap the changes in an asic_type
check or !APU check.

Alex

>
> GPU info on that machine:
>
> [    1.462214] [drm] amdgpu kernel modesetting enabled.
> [    1.465150] amdgpu 0000:00:01.0: vgaarb: deactivate vga console
> [    1.466259] Console: switching to colour dummy device 80x25
> [    1.466844] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874 0x103C:0x807E 0xC4).
> [    1.467242] amdgpu 0000:00:01.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
> [    1.467552] [drm] register mmio base: 0xD0C00000
> [    1.467750] [drm] register mmio size: 262144
> [    1.467901] [drm] add ip block number 0 <vi_common>
> [    1.468067] [drm] add ip block number 1 <gmc_v8_0>
> [    1.468266] [drm] add ip block number 2 <cz_ih>
> [    1.468436] [drm] add ip block number 3 <gfx_v8_0>
> [    1.468603] [drm] add ip block number 4 <sdma_v3_0>
> [    1.468809] [drm] add ip block number 5 <powerplay>
> [    1.468975] [drm] add ip block number 6 <dm>
> [    1.469120] [drm] add ip block number 7 <uvd_v6_0>
> [    1.469282] [drm] add ip block number 8 <vce_v3_0>
> [    1.485350] [drm] BIOS signature incorrect 20 7
> [    1.485494] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000c0000-
> 0x000c3fff window]
> [    1.485922] caller pci_map_rom+0x68/0x1b0 mapping multiple BARs
> [    1.486273] amdgpu 0000:00:01.0: amdgpu: Fetched VBIOS from ROM BAR
> [    1.486488] amdgpu: ATOM BIOS: SWBRT27354.001
> [    1.486701] [drm] UVD is enabled in physical mode
> [    1.486862] [drm] VCE enabled in physical mode
> [    1.487061] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
> [    1.487339] amdgpu 0000:00:01.0: amdgpu: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
> [    1.487652] amdgpu 0000:00:01.0: amdgpu: GART: 1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF
> [    1.487939] [drm] Detected VRAM RAM=512M, BAR=512M
> [    1.488101] [drm] RAM width 128bits UNKNOWN
> [    1.488309] [drm] amdgpu: 512M of VRAM memory ready
> [    1.488522] [drm] amdgpu: 3072M of GTT memory ready.
> [    1.488707] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [    1.488997] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
> [    1.491962] amdgpu: hwmgr_sw_init smu backed is smu8_smu
> [    1.492544] [drm] Found UVD firmware Version: 1.91 Family ID: 11
> [    1.492764] [drm] UVD ENC is disabled
> [    1.494177] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
> [    1.495765] amdgpu: smu version 18.62.00
> [    1.501983] [drm] DM_PPLIB: values for Engine clock
> [    1.502201] [drm] DM_PPLIB:   300000
> [    1.502321] [drm] DM_PPLIB:   360000
> [    1.502441] [drm] DM_PPLIB:   423530
> [    1.502561] [drm] DM_PPLIB:   514290
> [    1.502680] [drm] DM_PPLIB:   626090
> [    1.502799] [drm] DM_PPLIB:   720000
> [    1.502919] [drm] DM_PPLIB: Validation clocks:
> [    1.503069] [drm] DM_PPLIB:    engine_max_clock: 72000
> [    1.503242] [drm] DM_PPLIB:    memory_max_clock: 80000
> [    1.503415] [drm] DM_PPLIB:    level           : 8
> [    1.503578] [drm] DM_PPLIB: values for Display clock
> [    1.503745] [drm] DM_PPLIB:   300000
> [    1.503864] [drm] DM_PPLIB:   400000
> [    1.503984] [drm] DM_PPLIB:   496560
> [    1.504147] [drm] DM_PPLIB:   626090
> [    1.504275] [drm] DM_PPLIB:   685720
> [    1.504403] [drm] DM_PPLIB:   757900
> [    1.504526] [drm] DM_PPLIB: Validation clocks:
> [    1.504678] [drm] DM_PPLIB:    engine_max_clock: 72000
> [    1.504891] [drm] DM_PPLIB:    memory_max_clock: 80000
> [    1.505063] [drm] DM_PPLIB:    level           : 8
> [    1.505225] [drm] DM_PPLIB: values for Memory clock
> [    1.505389] [drm] DM_PPLIB:   333000
> [    1.505508] [drm] DM_PPLIB:   800000
> [    1.505628] [drm] DM_PPLIB: Validation clocks:
> [    1.505777] [drm] DM_PPLIB:    engine_max_clock: 72000
> [    1.505950] [drm] DM_PPLIB:    memory_max_clock: 80000
> [    1.506123] [drm] DM_PPLIB:    level           : 8
> [    1.506375] [drm] Display Core initialized with v3.2.149!
> [    1.584817] [drm] UVD initialized successfully.
> [    1.784234] [drm] VCE initialized successfully.
> [    1.784415] amdgpu 0000:00:01.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 8
> [    1.787958] [drm] fb mappable at 0xA0EE4000
> [    1.788118] [drm] vram apper at 0xA0000000
> [    1.788258] [drm] size 14745600
> [    1.788367] [drm] fb depth is 24
> [    1.788503] [drm]    pitch is 10240
> [    1.789198] fbcon: amdgpu (fb0) is primary device
> [    1.880014] Console: switching to colour frame buffer device 320x90
> [    1.903779] amdgpu 0000:00:01.0: [drm] fb0: amdgpu frame buffer device
> [    1.918353] [drm] Initialized amdgpu 3.42.0 20150101 for 0000:00:01.0 on minor 0
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
