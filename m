Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCDB374FB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhEFHDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEFHDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:03:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 00:02:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l2so4375325wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 00:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N3HgVaF3RMzGGbCifmq26jt1yiiaYTugFuDo4ApAevw=;
        b=tsYh3PgWde1L5odLG63YNcORcanS3q3lifJ5W8y+xwW6xWgpZa3zM01cPyPjkoWoPr
         J1rNNFtkKaROzub3zQWoflTXLo9r+lxjEVLZixKxnu7Am9Idww+9XFKUGKy785uQGCDX
         Z1vi0r4b2nHhkcENsU9e+ZC60zRJ5oa4GEVTX4fAGfsHEX9YXZhSHk+LoGzadILMZOUB
         SFDZJGERFFHDeyeL1ESX2IrKfKzGY7MWbRSM1ZHI8NFG4r5FzyfuPkyRsVLeIUTBNgIe
         0evgLvMmMgDnoB3yRdXxaIBPOgSDYsfA8djRXkLVCaGxBovmgibwhYsGp/XXak4UrbCM
         a7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N3HgVaF3RMzGGbCifmq26jt1yiiaYTugFuDo4ApAevw=;
        b=mi6abxbTbNDA9y1MC0dPHxm9ik6LXPEp6p0FYzUBiIqm3RiKsJN2yZqDFVpUeg6P1S
         QMRlk9v57WX2yBhstRDPz76I7C5zR2oC4OzZ77LcgZsYHya9TMMl5yOgsOWWPT51737y
         223jYn/lZXM/iEAQPLNvxFkBSJtl6tNeQGcFndovMRGsvaYhuewrSSfFjORCk37UuOyh
         1qHK5NZur1yPpiPunazCt3bBRZ5R7QKowUnpLkOY+JI6S7nqfqQmdDdH6/ZOJBimszPP
         XgGFgPNMdXAPj9SOFHToYlPKUYzpJoe+a8x70qxMI4jvq3cSq0x2Ibaw5BNiznxco2lH
         i9fg==
X-Gm-Message-State: AOAM530CWJ51FY8xdMyfxLos3Apse5g6+K/GOUU9Bdm+jqe2XnIQL78g
        KKrXKHEjAPyoV3E0/+N9g2+nXTr8w6s8jxtKMi86gg==
X-Google-Smtp-Source: ABdhPJw+PLdeWroPlp8PupbsrelY9U7ubYQpgPEBDaI9LU/6fexgZd1Z6Xj6rzHfVOElekgFGFgarOYfKPvYHt0RABA=
X-Received: by 2002:a5d:6402:: with SMTP id z2mr3106340wru.7.1620284568404;
 Thu, 06 May 2021 00:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210225090610.242623-1-allen.lkml@gmail.com> <20210225090610.242623-2-allen.lkml@gmail.com>
 <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com>
 <9a6c017c-d156-f939-f907-d6dfe83c41ac@linux.microsoft.com>
 <CAHUa44FyGOj5=Z80km_2T-avKiJpGVD8cWjTC3ZCX8csazP3rw@mail.gmail.com> <409F60D9-F0FB-4B69-B64B-CC6B3704038E@linux.microsoft.com>
In-Reply-To: <409F60D9-F0FB-4B69-B64B-CC6B3704038E@linux.microsoft.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 6 May 2021 09:02:37 +0200
Message-ID: <CAHUa44EZprsEKbd_mzGhxQKQgu5XB5nLtREJh2j_9J3zPO4gNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     Allen Pais <allen.lkml@gmail.com>, zajec5@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 3:45 PM Allen Pais <apais@linux.microsoft.com> wrote=
:
>
> Jens,
>
> >>>> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> >>>> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -=
22
> >>>>
> >>>> tee_shm_release() is not invoked on dma shm buffer.
> >>>>
> >>>> Implement .shutdown() method to handle the release of the buffers
> >>>> correctly.
> >>>>
> >>>> More info:
> >>>> https://github.com/OP-TEE/optee_os/issues/3637
> >>>>
> >>>> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> >>>> ---
> >>>>  drivers/tee/optee/core.c | 20 ++++++++++++++++++++
> >>>>  1 file changed, 20 insertions(+)
> >>>
> >>> This looks good to me. Do you have a practical way of testing this on
> >>> QEMU for instance?
> >>>
> >>
> >> Jens,
> >>
> >>   I could not reproduce nor create a setup using QEMU, I could only
> >> do it on a real h/w.
> >>
> >>   I have extensively tested the fix and I don't see any issues.
> >
> > I did a few test runs too, seems OK.
>
>  I carried these changes and have not run into any issues with Kexec so f=
ar.
> Last week, while trying out kdump, we ran into a crash(this is when the
> Kdump kernel reboots).
>
> $echo c > /proc/sysrq-trigger
>
> Leads to:
>
> [   18.004831] Unable to handle kernel paging request at virtual address =
ffff0008dcef6758
> [   18.013002] Mem abort info:
> [   18.015885]   ESR =3D 0x96000005
> [   18.019034]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   18.024516]   SET =3D 0, FnV =3D 0
> [   18.027667]   EA =3D 0, S1PTW =3D 0
> [   18.030905] Data abort info:
> [   18.033877]   ISV =3D 0, ISS =3D 0x00000005
> [   18.037835]   CM =3D 0, WnR =3D 0
> [   18.040896] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000970a7=
8000
> [   18.047811] [ffff0008dcef6758] pgd=3D000000097fbf9003, pud=3D000000000=
0000000
> [   18.054819] Internal error: Oops: 96000005 [#1] SMP
> [   18.059850] Modules linked in: bnxt_en pcie_iproc_platform pcie_iproc =
diagbe(O)
> [   18.067395] CPU: 3 PID: 1 Comm: systemd-shutdow Tainted: G           O=
      5.4.83-microsoft-standard #1
> [   18.077174] Hardware name: Overlake (DT)
> [   18.081219] pstate: 80400005 (Nzcv daif +PAN -UAO)
> [   18.086170] pc : tee_shm_free+0x18/0x48
> [   18.090126] lr : optee_disable_shm_cache+0xa4/0xf0
> [   18.095066] sp : ffff80001005bb90
> [   18.098484] x29: ffff80001005bb90 x28: ffff000037e20000
> [   18.103962] x27: 0000000000000000 x26: ffff00003ed10490
> [   18.109440] x25: ffffca760e975f90 x24: 0000000000000000
> [   18.114918] x23: ffffca760ed79808 x22: ffff00003ec66e18
> [   18.120396] x21: ffff80001005bc08 x20: 00000000b200000a
> [   18.125874] x19: ffff0008dcef6700 x18: 0000000000000010
> [   18.131352] x17: 0000000000000000 x16: 0000000000000000
> [   18.136829] x15: ffffffffffffffff x14: ffffca760ed79808
> [   18.142307] x13: ffff80009005b897 x12: ffff80001005b89f
> [   18.147786] x11: ffffca760eda4000 x10: ffff80001005b820
> [   18.153264] x9 : 00000000ffffffd0 x8 : ffffca760e59b2c0
> [   18.158742] x7 : 0000000000000000 x6 : 0000000000000000
> [   18.164220] x5 : 0000000000000000 x4 : 0000000000000000
> [   18.169698] x3 : 0000000000000000 x2 : ffff0008dcef6700
> [   18.175175] x1 : 00000000ffff0008 x0 : ffffca760e59ca04
> [   18.180654] Call trace:
> [   18.183176]  tee_shm_free+0x18/0x48
> [   18.186773]  optee_disable_shm_cache+0xa4/0xf0
> [   18.191356]  optee_shutdown+0x20/0x30
> [   18.195135]  platform_drv_shutdown+0x2c/0x38
> [   18.199538]  device_shutdown+0x180/0x298
> [   18.203586]  kernel_restart_prepare+0x44/0x50
> [   18.208078]  kernel_restart+0x20/0x68
> [   18.211853]  __do_sys_reboot+0x104/0x258
> [   18.215899]  __arm64_sys_reboot+0x2c/0x38
> [   18.220035]  el0_svc_handler+0x90/0x138
> [   18.223991]  el0_svc+0x8/0x208
> [   18.227143] Code: f9000bf3 aa0003f3 aa1e03e0 d503201f (b9405a60)
> [   18.233435] ---[ end trace 835d756cd66aa959 ]---
> [   18.238621] Kernel panic - not syncing: Fatal exception
> [   18.244014] Kernel Offset: 0x4a75fde00000 from 0xffff800010000000
> [   18.250299] PHYS_OFFSET: 0xffff99c680000000
> [   18.254613] CPU features: 0x0002,21806008
> [   18.258747] Memory Limit: none
> [   18.262310] ---[ end Kernel panic - not syncing: Fatal exception ]=E2=
=80=94
>
> I see that before secure world returns OPTEE_SMC_RETURN_ENOTAVAIL(which
> Should disable and clear all the cache) we run into the crash trying to f=
ree shm.
>
> Thoughts?

It seems that the pointer is invalid, but the pointer doesn't look
like garbage. Could the kernel have unmapped the memory area covering
that address?

Cheers,
Jens
