Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02F35C4BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbhDLLL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbhDLLL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:11:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93854C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:11:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n2so19557249ejy.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5LtuTKsb92QbtbqBByEJdHLZe/zQ8e7otPh3ABYb7YU=;
        b=Rd1ufOIVqDDLtX0iBLbga1w1gkMUoU3SjOslxXXoFvC7kq2ePU8wkzOQHSQIReMyL4
         C7TMRCO4HCsDCcqOaUOvgP10SFcg4hMxw++TAaZze3SU+JFGQA5ebO5F/SLCfoAfZcxE
         pBMHZRlMtQW/V4P7pVSZO+P5w5cu3g10ZNj76idQ2fZTnSD6gv0JdeGhj/RbcFUVof1Y
         u369X4AX8K6meOSohhFVU4O1bQFQHGCS/GeCtQRgYth0fXb7xK2P2SnVCJMMx3oi5VjU
         WefFKelKoKNRo67xJNnLQfoSeZqnuG6U7/379y7ubJAac6mINHCDUp8YhOYyfEVGl7Fq
         KlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5LtuTKsb92QbtbqBByEJdHLZe/zQ8e7otPh3ABYb7YU=;
        b=hTRmuuqS0sAWFvzWf0D2fBXtiJgyPm8RRjb8Qw0a+xEw6H/HQ+4D7j/Riyiz+K4XKh
         s+NYRBoRcDZDDkY9o8CpeYy8W8MZKVpPvPGpELw/HNIE/92O9IQTTwgX4jfOLVCTbalU
         WUq6t5Ahn3X9yRO/9Q2vhvBAhtW1Vs83RKH2t0UKgDl22B0/vGX/ndpyZ/07kLF3vy8a
         MbvQDqr0w6p+SuZrIOB+iARRRpVMoCRzaE7TW1+BS7bbY6mSvoRKpKRG6HWw+KyJYbXy
         De7cgh8Dp0Kz1aQenLdmGoRdCpMkSXJZXo+q1fgLcactNp6VdNyD/RVRElJqbmHUJBFA
         buYA==
X-Gm-Message-State: AOAM530AK1OX/fzlLzxQVkxcQHtwF+g3obgivsNuzoUrIUz8+sgFzyYH
        fz4VUJOI6ZBO2fxRTunolMg=
X-Google-Smtp-Source: ABdhPJyGzaUJxdWE7Cxnwp47xvfzILRQlAYxIR8LXURjbNIz0PXel2menqEgA9UTCoZw09oNssk/0g==
X-Received: by 2002:a17:907:689:: with SMTP id wn9mr26459839ejb.485.1618225868405;
        Mon, 12 Apr 2021 04:11:08 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4f4:3b4b:a0ea:d512? ([2a02:908:1252:fb60:4f4:3b4b:a0ea:d512])
        by smtp.gmail.com with ESMTPSA id bs10sm6282943edb.8.2021.04.12.04.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 04:11:07 -0700 (PDT)
Subject: Re: Unexpected multihop in swaput - likely driver bug.
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CABXGCsPAdv6wCWmzh6OQmDX1LOf_FEu_wH=4K9HDd_rToTdwrQ@mail.gmail.com>
 <7d30982e-a893-858c-2237-a09a183ff2d0@gmail.com>
 <CABXGCsN6GX4ksbFo9fhd6XGxNyED9qoBqYf0Ph1pwG3qArGtjg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b2d8efbd-3e2a-eff3-23e7-b620ea584082@gmail.com>
Date:   Mon, 12 Apr 2021 13:11:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABXGCsN6GX4ksbFo9fhd6XGxNyED9qoBqYf0Ph1pwG3qArGtjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

thanks a lot for pointing this out.

Turned out that this is a known issue, but I've forgot to push the fix 
to drm-misc-fixes and just queued it up for the next release.

Please re-test drm-misc-fixes and let's hope there is another -rc before 
the final 5.12 kernel.

Thanks,
Christian.

Am 07.04.21 um 20:06 schrieb Mikhail Gavrilov:
> On Wed, 7 Apr 2021 at 15:46, Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> What hardware are you using
> $ inxi -bM
> System:    Host: fedora Kernel: 5.12.0-0.rc6.184.fc35.x86_64+debug
> x86_64 bits: 64 Desktop: GNOME 40.0
>             Distro: Fedora release 35 (Rawhide)
> Machine:   Type: Desktop Mobo: ASUSTeK model: ROG STRIX X570-I GAMING
> v: Rev X.0x serial: <superuser required>
>             UEFI: American Megatrends v: 3603 date: 03/20/2021
> Battery:   ID-1: hidpp_battery_0 charge: N/A condition: N/A
> CPU:       Info: 16-Core (2-Die) AMD Ryzen 9 3950X [MT MCP MCM] speed:
> 2365 MHz min/max: 2200/3500 MHz
> Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Navi 21 [Radeon
> RX 6800/6800 XT / 6900 XT] driver: amdgpu v: kernel
>             Device-2: AVerMedia Live Streamer CAM 513 type: USB driver:
> hid-generic,usbhid,uvcvideo
>             Device-3: AVerMedia Live Gamer Ultra-Video type: USB
> driver: hid-generic,snd-usb-audio,usbhid,uvcvideo
>             Display: wayland server: X.Org 1.21.1 driver: loaded:
> amdgpu,ati unloaded: fbdev,modesetting,radeon,vesa
>             resolution: 3840x2160~60Hz
>             OpenGL: renderer: AMD SIENNA_CICHLID (DRM 3.40.0
> 5.12.0-0.rc6.184.fc35.x86_64+debug LLVM 12.0.0)
>             v: 4.6 Mesa 21.1.0-devel
> Network:   Device-1: Intel Wi-Fi 6 AX200 driver: iwlwifi
>             Device-2: Intel I211 Gigabit Network driver: igb
> Drives:    Local Storage: total: 11.35 TiB used: 10.82 TiB (95.3%)
> Info:      Processes: 805 Uptime: 12h 56m Memory: 31.18 GiB used:
> 21.88 GiB (70.2%) Shell: Bash inxi: 3.3.02
>
>
>> and how do you exactly trigger this?
> I am running heavy games like "Zombie Army 4: Dead War" and switching
> to Gnome Activities and other applications while the game is running.
>
>

