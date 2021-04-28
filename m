Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D90636E09D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhD1U5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhD1U5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:57:45 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D4AC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:57:00 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id d16-20020a4a3c100000b02901f0590a614eso6380963ooa.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTHGJKxd5fMkPz0rkmHu2C+/ivasGowUhftjphYVuN8=;
        b=m6HfXTWP/+QVQb2J+djNG/kK+tv5DzNo+TDzWq15HeA74WFIuYrCAOcbonDtzC+zPo
         DRaikNRsmg0ZzQnTPPkajdtSs9l8BmLvxrixwus7NHba842jNC0/DnNvNz65Sx9XMD7t
         ctvQxDNf5iDxwzF1OL2891U0t7wFDiD8NcyfmR5MyxqNCWwwCCHPpwWRWgh/LH4eWVMN
         JMovb59leuREQyu797UjmPfqhr1UavuSv17GaWEUX2q0gC3CpNT1boi2Z0IdKHYpkF9L
         6hp9UNQjF1t54Vys++E6+CU8U3ufPEeNOVL2ZATysFWMi2+OCqRKfMhgorKeotANjWMj
         Gx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTHGJKxd5fMkPz0rkmHu2C+/ivasGowUhftjphYVuN8=;
        b=ZeTT7XIqxASiUFcmvkhT23P41OFIXCxOGYedgNCh3iz9UlLjVPwp2ORugUvFVEfB6G
         HzLh8p7CX9Pp5Uf/Bu6a0DDI+v45w5jlFtzZrJqsao0dHAwoQu1HVgTmBB2Mgu2Brk7L
         DC+HoPTpDdkmM4FX4MAQSKk3gkk/Ami7Y0LV8E2zxyUqQXFJf2mlo4mLCReQ8KxalQ8E
         1Ne5f3q2VxKDhNnsQ707f3i/cfN/oInkncdLGJo5DZtp3HEN24gsWEGOlZZYVZ57XOET
         V1xxzEvqnl+miKBIBJmiDnBuVopnf9bwfq8DUDegH9CMeOmpUPEIC+YT3NwHEWWOB/FH
         UbGA==
X-Gm-Message-State: AOAM530/i6G0vzUnNtbhHMHWmo4Xwt7pgwgOOdAW0SsrON9UlnqoyKAP
        KJKmYoC3nITpwQ0WrKi05J/0hiFTNustoZgyaPE=
X-Google-Smtp-Source: ABdhPJySXHgyg9ChCHw5sXkO+vrxTLRooDZA1NEzYU/p6K9RO2R2b8Es2/JO6i8p9O/KB8NW23qA/eEh4Tjzawc7kaU=
X-Received: by 2002:a4a:800d:: with SMTP id x13mr24532117oof.61.1619643419529;
 Wed, 28 Apr 2021 13:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210426105002.332935-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210426105002.332935-1-kai.heng.feng@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 28 Apr 2021 16:56:48 -0400
Message-ID: <CADnq5_OA+4c-e1ube301vsj1r7sedNCvvuLYFiPaTE6H4n5DdQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Register VGA clients after init can no
 longer fail
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>,
        shaoyunl <shaoyun.liu@amd.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>, Evan Quan <evan.quan@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 6:50 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> When an amdgpu device fails to init, it makes another VGA device cause
> kernel splat:
> kernel: amdgpu 0000:08:00.0: amdgpu: amdgpu_device_ip_init failed
> kernel: amdgpu 0000:08:00.0: amdgpu: Fatal error during GPU init
> kernel: amdgpu: probe of 0000:08:00.0 failed with error -110
> ...
> kernel: amdgpu 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=3Dio=
+mem,decodes=3Dnone:owns=3Dnone
> kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
> kernel: #PF: supervisor read access in kernel mode
> kernel: #PF: error_code(0x0000) - not-present page
> kernel: PGD 0 P4D 0
> kernel: Oops: 0000 [#1] SMP NOPTI
> kernel: CPU: 6 PID: 1080 Comm: Xorg Tainted: G        W         5.12.0-rc=
8+ #12
> kernel: Hardware name: HP HP EliteDesk 805 G6/872B, BIOS S09 Ver. 02.02.0=
0 12/30/2020
> kernel: RIP: 0010:amdgpu_device_vga_set_decode+0x13/0x30 [amdgpu]
> kernel: Code: 06 31 c0 c3 b8 ea ff ff ff 5d c3 66 2e 0f 1f 84 00 00 00 00=
 00 66 90 0f 1f 44 00 00 55 48 8b 87 90 06 00 00 48 89 e5 53 89 f3 <48> 8b =
40 18 40 0f b6 f6 e8 40 58 39 fd 80 fb 01 5b 5d 19 c0 83 e0
> kernel: RSP: 0018:ffffae3c0246bd68 EFLAGS: 00010002
> kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> kernel: RDX: ffff8dd1af5a8560 RSI: 0000000000000000 RDI: ffff8dce8c160000
> kernel: RBP: ffffae3c0246bd70 R08: ffff8dd1af5985c0 R09: ffffae3c0246ba38
> kernel: R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000246
> kernel: R13: 0000000000000000 R14: 0000000000000003 R15: ffff8dce81490000
> kernel: FS:  00007f9303d8fa40(0000) GS:ffff8dd1af580000(0000) knlGS:00000=
00000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000000018 CR3: 0000000103cfa000 CR4: 0000000000350ee0
> kernel: Call Trace:
> kernel:  vga_arbiter_notify_clients.part.0+0x4a/0x80
> kernel:  vga_get+0x17f/0x1c0
> kernel:  vga_arb_write+0x121/0x6a0
> kernel:  ? apparmor_file_permission+0x1c/0x20
> kernel:  ? security_file_permission+0x30/0x180
> kernel:  vfs_write+0xca/0x280
> kernel:  ksys_write+0x67/0xe0
> kernel:  __x64_sys_write+0x1a/0x20
> kernel:  do_syscall_64+0x38/0x90
> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
> kernel: RIP: 0033:0x7f93041e02f7
> kernel: Code: 75 05 48 83 c4 58 c3 e8 f7 33 ff ff 0f 1f 80 00 00 00 00 f3=
 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d =
00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> kernel: RSP: 002b:00007fff60e49b28 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00001
> kernel: RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f93041e02f7
> kernel: RDX: 000000000000000b RSI: 00007fff60e49b40 RDI: 000000000000000f
> kernel: RBP: 00007fff60e49b40 R08: 00000000ffffffff R09: 00007fff60e499d0
> kernel: R10: 00007f93049350b5 R11: 0000000000000246 R12: 000056111d45e808
> kernel: R13: 0000000000000000 R14: 000056111d45e7f8 R15: 000056111d46c980
> kernel: Modules linked in: nls_iso8859_1 snd_hda_codec_realtek snd_hda_co=
dec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg=
 snd_hda_codec snd_hwdep snd_hda_core snd_pcm snd_seq input_leds snd_seq_de=
vice snd_timer snd soundcore joydev kvm_amd serio_raw k10temp mac_hid hp_wm=
i ccp kvm sparse_keymap wmi_bmof ucsi_acpi efi_pstore typec_ucsi rapl typec=
 video wmi sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables auto=
fs4 btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov as=
ync_memcpy async_pq async_xor async_tx libcrc32c xor raid6_pq raid1 raid0 m=
ultipath linear dm_mirror dm_region_hash dm_log hid_generic usbhid hid amdg=
pu drm_ttm_helper ttm iommu_v2 gpu_sched i2c_algo_bit drm_kms_helper syscop=
yarea sysfillrect crct10dif_pclmul sysimgblt crc32_pclmul fb_sys_fops ghash=
_clmulni_intel cec rc_core aesni_intel crypto_simd psmouse cryptd r8169 i2c=
_piix4 drm ahci xhci_pci realtek libahci xhci_pci_renesas gpio_amdpt gpio_g=
eneric
> kernel: CR2: 0000000000000018
> kernel: ---[ end trace 76d04313d4214c51 ]---
>
> Commit 4192f7b57689 ("drm/amdgpu: unmap register bar on device init
> failure") makes amdgpu_driver_unload_kms() skips amdgpu_device_fini(),
> so the VGA clients remain registered. So when
> vga_arbiter_notify_clients() iterates over registered clients, it causes
> NULL pointer dereference.
>
> Since there's no reason to register VGA clients that early, so solve
> the issue by putting them after all the goto cleanups.
>
> v2:
>  - Remove redundant vga_switcheroo cleanup in failed: label.
>
> Fixes: 4192f7b57689 ("drm/amdgpu: unmap register bar on device init failu=
re")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 28 ++++++++++------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index b4ad1c055c70..7d3b54615147 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3410,19 +3410,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         /* doorbell bar mapping and doorbell index init*/
>         amdgpu_device_doorbell_init(adev);
>
> -       /* if we have > 1 VGA cards, then disable the amdgpu VGA resource=
s */
> -       /* this will fail for cards that aren't VGA class devices, just
> -        * ignore it */
> -       if ((adev->pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
> -               vga_client_register(adev->pdev, adev, NULL, amdgpu_device=
_vga_set_decode);
> -
> -       if (amdgpu_device_supports_px(ddev)) {
> -               px =3D true;
> -               vga_switcheroo_register_client(adev->pdev,
> -                                              &amdgpu_switcheroo_ops, px=
);
> -               vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_p=
m_domain);
> -       }
> -
>         if (amdgpu_emu_mode =3D=3D 1) {
>                 /* post the asic on emulation mode */
>                 emu_soc_asic_init(adev);
> @@ -3619,6 +3606,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (amdgpu_device_cache_pci_state(adev->pdev))
>                 pci_restore_state(pdev);
>
> +       /* if we have > 1 VGA cards, then disable the amdgpu VGA resource=
s */
> +       /* this will fail for cards that aren't VGA class devices, just
> +        * ignore it */
> +       if ((adev->pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
> +               vga_client_register(adev->pdev, adev, NULL, amdgpu_device=
_vga_set_decode);
> +
> +       if (amdgpu_device_supports_px(ddev)) {
> +               px =3D true;
> +               vga_switcheroo_register_client(adev->pdev,
> +                                              &amdgpu_switcheroo_ops, px=
);
> +               vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_p=
m_domain);
> +       }
> +
>         if (adev->gmc.xgmi.pending_reset)
>                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_wo=
rk,
>                                    msecs_to_jiffies(AMDGPU_RESUME_MS));
> @@ -3630,8 +3630,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>  failed:
>         amdgpu_vf_error_trans_all(adev);
> -       if (px)
> -               vga_switcheroo_fini_domain_pm_ops(adev->dev);
>
>  failed_unmap:
>         iounmap(adev->rmmio);
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
