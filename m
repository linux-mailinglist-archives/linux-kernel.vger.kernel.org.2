Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84F93573E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355097AbhDGSGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355081AbhDGSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:06:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E499CC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 11:06:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r8so12426955lfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DyBm95F+3/SfdAPdI+iZIYttoNbi6kTKipkfV2vV3q8=;
        b=U02AtdVu7GmuXw614lHDvn33aAMYx6obajAVA6gYKQDX/9ERHsQhYsNVJpx5f8behT
         ZdpkYFxstdbGj+B0lLjtWpDpTPPMJB9o47gxSPScDWB1OdrO7VFImIs2SYNU9yJR6TbZ
         /+wpMxhc6Ge/qXGdcfCxTov7kQH7XVd7Vk3+GRxwz9H1pVPpqDX1jsLkBnerUVmzBE7D
         Fwy6clYk+4BWRDm8UaCLckTU5QmaOgqEXb27jYU2PM/ddHy8CzQKETz2f0xvGPlwyilr
         gXk2cGGfKDWCbyNqeXJS2pWSQvXTCF1TDHGwibnnct2hl8D13iCHOteQRrKzmGjcH1Z5
         y7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DyBm95F+3/SfdAPdI+iZIYttoNbi6kTKipkfV2vV3q8=;
        b=IdK6K6C4G/qoU6aeAAf4+9Wa+0QXB4LWCMupll7VnREULscGTvQvFEWmO3lFzBO6IC
         fnZaLlhFchpZQuMX1ep4upU7NaDJHXT7eklXa+T9s5ZvRAbB7RCf0YgtAdoHOckEC5ut
         7c/7V6u+J2oxbgYZMMKgc77F7P7Ytdby9DJqbBwEjbwG5lrWT7lN5xeVc31MQENpIemX
         kFY5fX0E9j2wYyGn0yhkvj+VdIU+/WIp4pPrbhTnDdSTtVdkayocaQu9RxKPf0ctZwzS
         F/2ZHiTfzyCM4eo408N7D2Bn/u1zkVr1SoTyZcFRXR9X2+hCHRNX/4wL8mn+vNmPl5W4
         sulA==
X-Gm-Message-State: AOAM531yvNkN0AZnziKyw0Kxw6RxI2H0O1z+s+9u6H/KtKow6gp9ujgD
        HQDxZRl2ty1D00uvUr5W36KejctJ9JhRw7sK3hU=
X-Google-Smtp-Source: ABdhPJxbedDQfFngxb5MnIjHVo8kZt/AflxaLuJHiAlFzP3+GOaDxAjS7moJ8B+rFfcC9oBtZQLM3OCXEL+SJnrGyQ8=
X-Received: by 2002:ac2:42cf:: with SMTP id n15mr3262180lfl.573.1617818787412;
 Wed, 07 Apr 2021 11:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPAdv6wCWmzh6OQmDX1LOf_FEu_wH=4K9HDd_rToTdwrQ@mail.gmail.com>
 <7d30982e-a893-858c-2237-a09a183ff2d0@gmail.com>
In-Reply-To: <7d30982e-a893-858c-2237-a09a183ff2d0@gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 7 Apr 2021 23:06:15 +0500
Message-ID: <CABXGCsN6GX4ksbFo9fhd6XGxNyED9qoBqYf0Ph1pwG3qArGtjg@mail.gmail.com>
Subject: Re: Unexpected multihop in swaput - likely driver bug.
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 at 15:46, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> What hardware are you using

$ inxi -bM
System:    Host: fedora Kernel: 5.12.0-0.rc6.184.fc35.x86_64+debug
x86_64 bits: 64 Desktop: GNOME 40.0
           Distro: Fedora release 35 (Rawhide)
Machine:   Type: Desktop Mobo: ASUSTeK model: ROG STRIX X570-I GAMING
v: Rev X.0x serial: <superuser required>
           UEFI: American Megatrends v: 3603 date: 03/20/2021
Battery:   ID-1: hidpp_battery_0 charge: N/A condition: N/A
CPU:       Info: 16-Core (2-Die) AMD Ryzen 9 3950X [MT MCP MCM] speed:
2365 MHz min/max: 2200/3500 MHz
Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Navi 21 [Radeon
RX 6800/6800 XT / 6900 XT] driver: amdgpu v: kernel
           Device-2: AVerMedia Live Streamer CAM 513 type: USB driver:
hid-generic,usbhid,uvcvideo
           Device-3: AVerMedia Live Gamer Ultra-Video type: USB
driver: hid-generic,snd-usb-audio,usbhid,uvcvideo
           Display: wayland server: X.Org 1.21.1 driver: loaded:
amdgpu,ati unloaded: fbdev,modesetting,radeon,vesa
           resolution: 3840x2160~60Hz
           OpenGL: renderer: AMD SIENNA_CICHLID (DRM 3.40.0
5.12.0-0.rc6.184.fc35.x86_64+debug LLVM 12.0.0)
           v: 4.6 Mesa 21.1.0-devel
Network:   Device-1: Intel Wi-Fi 6 AX200 driver: iwlwifi
           Device-2: Intel I211 Gigabit Network driver: igb
Drives:    Local Storage: total: 11.35 TiB used: 10.82 TiB (95.3%)
Info:      Processes: 805 Uptime: 12h 56m Memory: 31.18 GiB used:
21.88 GiB (70.2%) Shell: Bash inxi: 3.3.02


> and how do you exactly trigger this?

I am running heavy games like "Zombie Army 4: Dead War" and switching
to Gnome Activities and other applications while the game is running.


--=20
Best Regards,
Mike Gavrilov.
