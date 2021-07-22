Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873613D2CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 21:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhGVTLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 15:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhGVTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 15:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626983492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qXpi2JyN6JqKNMKOTuW9PMo4G0XYBoochrqRkCEo4LY=;
        b=DvMhJJSdkTzmJvjddPZquWha+JzpvaYFL09FN5vfhisoksZiiEULUxueafuT7/z6vXWUzr
        pRiIW5GT7aP8pzRrQgmHl1CDUUA8SUNeBgrC8kraCMPxBinjtgdgjI3G1F8DFddC0MKWAj
        /BOj7afVINatUOD9nfEhj0U7JkZO8do=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-MqkkbU7ZMhmU5jUyoAstVQ-1; Thu, 22 Jul 2021 15:51:31 -0400
X-MC-Unique: MqkkbU7ZMhmU5jUyoAstVQ-1
Received: by mail-wm1-f70.google.com with SMTP id o25-20020a05600c5119b0290218757e2783so175383wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXpi2JyN6JqKNMKOTuW9PMo4G0XYBoochrqRkCEo4LY=;
        b=ljzsnPIjLxiLXcLODp5p+2ToXbEqV3w9WB29Xh+sPRDy93rZB7O3l2pYsacApjmnDF
         M2s3wHvt9GJ78eTixFEJOdCNjdEsLC26Y22YXiiU5KFnK+PqxB0Dsk7tVdce3ul6OfXx
         fIanTcvmapmXothrwgHGa3+filoylZSuylL346q4tLuX+h5LNfPx6vquJyeYo3Gku5tU
         ERl90sRpqhpFidnP1epTgwqcnq4ZgGKHtu5AnbLJzFc3pws2GRHnyKehjreVwa6L00nA
         uuoqWBd3D3kd1HC14TcvPK6LS5J5STRXx8vx/O1NyNKW8LubtdpabGQjyWdlU7sDVdj0
         jdGA==
X-Gm-Message-State: AOAM533bdZCEhPbJ8RQOnQfom4JZpcuo3v44EnVT0BXYX6GyxW2mcXxv
        fCMX5oUBzFvgBrjK1EFSfNu3uZ27ZaqDm3BZoHva/fmFDqdNNE84fC2Y8jRb7I7+m3toRaBURxj
        y1KBLqJvrJuvIJLwWH+YVzFTWCAzMhvQm/BA69DM0
X-Received: by 2002:a5d:591c:: with SMTP id v28mr1569232wrd.373.1626983489632;
        Thu, 22 Jul 2021 12:51:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCvMy1GVeTDQxWrY0NoVJqExD8uBBDzNsefGmPxH72xx1aZ2C32827LUiPhERhdksODYRrMcThpPj3olYMDKM=
X-Received: by 2002:a5d:591c:: with SMTP id v28mr1569207wrd.373.1626983489359;
 Thu, 22 Jul 2021 12:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <202107222122.05546.linux@zary.sk>
In-Reply-To: <202107222122.05546.linux@zary.sk>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 22 Jul 2021 21:51:18 +0200
Message-ID: <CACO55tvq0Ksm6x_L3r6B8KhYR6dTqb=xzPaRzAeQgaBnff_sYA@mail.gmail.com>
Subject: Re: nouveau broken again on Riva TNT2 in 5.14.0-rc2
To:     Ondrej Zary <linux@zary.sk>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hey thanks for the report.

This is a known issue and the fix is pending in drm-mist-fixes and
should land in 5.14 soonish.

On Thu, Jul 22, 2021 at 9:29 PM Ondrej Zary <linux@zary.sk> wrote:
>
> Hello,
> nouveau is broken again:
>
> [   58.795794] BUG: kernel NULL pointer dereference, address: 0000017c
> [   58.795835] #PF: supervisor read access in kernel mode
> [   58.795844] #PF: error_code(0x0000) - not-present page
> [   58.795851] *pde = 00000000
> [   58.795862] Oops: 0000 [#1] SMP
> [   58.795875] CPU: 0 PID: 1730 Comm: Xorg Not tainted 5.14.0-rc2+ #391
> [   58.795886] Hardware name: VIA Technologies, Inc. VT82C694X/694X, BIOS 6.00 PG 02/19/2002
> [   58.795894] EIP: nouveau_bo_wr16+0x8/0x27 [nouveau]
> [   58.796716] Code: 85 ff 74 0d 80 7d f3 00 74 07 80 a6 c0 01 00 00 fe 89 f0 e8 e5 ee ff ff 8d 65 f4 89 f8 5b 5e 5f 5d c3 55 01 d2 89 e5 53 89 c3 <03> 93 7c 01 00 00 0f b7 c1 f6 83 84 01 00 00 80 74 07 e8 8a bc 72
> [   58.796728] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> [   58.796736] ESI: 00000020 EDI: c18bc600 EBP: c7c49d88 ESP: c7c49d84
> [   58.796744] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210246
> [   58.796754] CR0: 80050033 CR2: 0000017c CR3: 07e12000 CR4: 00000690
> [   58.796762] Call Trace:
> [   58.796774]  nv04_crtc_cursor_set+0x148/0x1d8 [nouveau]
> [   58.796952]  ? ttm_bo_reserve.constprop.16+0x1c/0x1c [nouveau]
> [   58.797122]  drm_mode_cursor_common+0x13b/0x1ad
> [   58.797150]  ? ttm_bo_reserve.constprop.16+0x1c/0x1c [nouveau]
> [   58.797322]  drm_mode_cursor_ioctl+0x2e/0x36
> [   58.797335]  ? drm_mode_setplane+0x203/0x203
> [   58.797346]  drm_ioctl_kernel+0x66/0x99
> [   58.797366]  drm_ioctl+0x211/0x2d8
> [   58.797377]  ? drm_mode_setplane+0x203/0x203
> [   58.797389]  ? __cond_resched+0x1e/0x22
> [   58.797409]  ? mutex_lock+0xb/0x24
> [   58.797422]  ? rpm_resume.part.14+0x6f/0x362
> [   58.797447]  ? ktime_get_mono_fast_ns+0x5e/0xf2
> [   58.797469]  ? __pm_runtime_resume+0x5b/0x63
> [   58.797480]  nouveau_drm_ioctl+0x65/0x81 [nouveau]
> [   58.797662]  ? nouveau_cli_work+0xc3/0xc3 [nouveau]
> [   58.797838]  vfs_ioctl+0x1a/0x24
> [   58.797850]  __ia32_sys_ioctl+0x6ea/0x704
> [   58.797861]  ? doublefault_shim+0x120/0x120
> [   58.797872]  ? exit_to_user_mode_prepare+0x9e/0x10c
> [   58.797900]  do_int80_syscall_32+0x53/0x6e
> [   58.797910]  entry_INT80_32+0xf0/0xf0
> [   58.797923] EIP: 0xb7f04092
> [   58.797932] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 e8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
> [   58.797943] EAX: ffffffda EBX: 0000000e ECX: c01c64a3 EDX: bf9a15c0
> [   58.797952] ESI: 00997850 EDI: c01c64a3 EBP: 0000000e ESP: bf9a1574
> [   58.797959] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200292
> [   58.797972] Modules linked in: i2c_dev nouveau wmi hwmon drm_ttm_helper psmouse serio_raw via_agp sg parport_pc 8139cp parport
> [   58.798016] CR2: 000000000000017c
> [   58.798147] ---[ end trace 732829d39ed65de9 ]---
>
>
> d02117f8efaa5fbc37437df1ae955a147a2a424a is the first bad commit
>
> --
> Ondrej Zary
>

