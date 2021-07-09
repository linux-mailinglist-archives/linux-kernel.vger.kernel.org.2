Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4983C2AE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhGIVfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIVe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:34:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DE0C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 14:32:13 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k16so13951882ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9l8FjfiinC3Z6DIn7ylryI5VVlG/tt6D8A9uicJ/C1E=;
        b=Tkdxel/3NkmvLdudpoPFVTVTPBd3Q7vV80QM0NdlCosjnjVffXu0XHA/qFOjOx/B/T
         PwoRtvuQ/j1R2R4XPJDbpFZ/wg0tTNgV1qc0R4//xWS3A7UjgxdBSBbG+XIhazlqmmMF
         zZoSKG5AoQ50Z0fCCVlZP6D1ev73Crp643Ya4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9l8FjfiinC3Z6DIn7ylryI5VVlG/tt6D8A9uicJ/C1E=;
        b=b2DV1ojfftWlgvTg+iRz5WxDWXq5VEWmeOJuL2/1zO3VeTAdDAe5A+0s1wp8s+uV5p
         rLBcFUdYWLJpwDnk6epdNGcb3Ylt+/KmRePBceQ/QsfEswOrkSEmjkVCVkzsSr/cPAAw
         fdhO/OLSbNBJ4H/1LNPiPL8J/OzoFD/kJMhaGbEIe2Cn0P3KkwynmDdQj0cH4+x4UZ8r
         mbIGBWrfxYP/qgV1zv5L/rcGrXwryvkjFXyANlbkOmY6/WmBwMinG+Hen8yJoW1IC054
         HChfU0ZUU6YUtKXc+8tE/PFk51X+gJKPF+ka+gsb6Wvqjkk+yIfVC0uA0EiODAgQRvCc
         /9QA==
X-Gm-Message-State: AOAM531s86W/72TOdlrbkL7cNEbU6THK9Nlu9VawbQKxcWADMPDeAWTU
        nGT6w035+mgy90b+X3uF/DbwXhpUjtTV6w==
X-Google-Smtp-Source: ABdhPJylXqaivyffaoLBlIpxqF/uc4Bdy4XFPnHI5IUO8HdKmTxGorjuJIRoh1z90WKBVJ1M9IyU6w==
X-Received: by 2002:a5d:9acb:: with SMTP id x11mr30300669ion.133.1625866332243;
        Fri, 09 Jul 2021 14:32:12 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id c19sm3564193ili.62.2021.07.09.14.32.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:32:12 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id h190so14009640iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:32:11 -0700 (PDT)
X-Received: by 2002:a5d:914a:: with SMTP id y10mr30777191ioq.140.1625866331342;
 Fri, 09 Jul 2021 14:32:11 -0700 (PDT)
MIME-Version: 1.0
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 9 Jul 2021 14:31:35 -0700
X-Gmail-Original-Message-ID: <CAE=gft50j2D_UmNNVOj-h6Hyi5ctMztAVDBP442SPinmCwcnpw@mail.gmail.com>
Message-ID: <CAE=gft50j2D_UmNNVOj-h6Hyi5ctMztAVDBP442SPinmCwcnpw@mail.gmail.com>
Subject: thunderbolt: Warning and 20 second delay in S4
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     gil.fine@intel.com, rajmohan.mani@intel.com,
        linux-usb@vger.kernel.org, Prashant Malani <pmalani@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika et al,

I'm experimenting with suspending to disk (hibernate) on a Tigerlake
Chromebook running the chromeos-5.4 kernel. I don't have any USB4
peripherals plugged in. I'm getting this warning, along with a 20
second stall, both when going down for hibernate and coming back up.
The warning is here:

[  603.415425] ------------[ cut here ]------------
[  603.420600] thunderbolt 0000:00:0d.2: interrupt for TX ring 0 is
already disabled
[  603.428984] WARNING: CPU: 2 PID: 14930 at
drivers/thunderbolt/nhi.c:104 ring_interrupt_active+0x1b7/0x1da
[  603.439680] Modules linked in: rfcomm cmac algif_hash
algif_skcipher af_alg veth vhost_vsock vhost
vmw_vsock_virtio_transport_common vsock xt_cgroup uinput xt_MASQUERADE
snd_soc_sof_rt5682 snd_soc_hdac_hdmi btusb btrtl btintel uvcvideo
btbcm videobuf2_vmalloc videobuf2_v4l2 videobuf2_common
videobuf2_memops snd_hda_codec_hdmi bluetooth ecdh_generic
snd_soc_dmic ecc iio_trig_sysfs snd_sof_pci snd_sof_intel_hda_common
snd_sof_xtensa_dsp snd_sof_intel_hda soundwire_intel
soundwire_generic_allocation soundwire_cadence snd_soc_hdac_hda
snd_soc_acpi_intel_match snd_soc_acpi snd_sof snd_hda_ext_core
snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core
mei_hdcp intel_gna snd_soc_max98373_sdw regmap_sdw soundwire_bus
cros_ec_typec acpi_als industrialio_triggered_buffer kfifo_buf
snd_soc_rt5682_i2c snd_soc_max98373_i2c intel_pmc_mux snd_soc_max98373
industrialio snd_soc_rt5682 roles snd_soc_rl6231 typec ip6table_nat
fuse iwlmvm iwl7000_mac80211 iwlwifi lzo_rle zram cfg80211 cdc_ether
[  603.439702]  usbnet r8152 mii joydev
[  603.541617] CPU: 2 PID: 14930 Comm: kworker/2:5 Tainted: G     U  W
        5.4.128 #2
[  603.559714] Workqueue: pm pm_runtime_work
[  603.564202] RIP: 0010:ring_interrupt_active+0x1b7/0x1da
[  603.570050] Code: 45 8b 47 24 48 c7 c6 26 fe 36 82 49 c7 c1 7a 5a
3b 82 45 84 f6 4c 0f 45 ce 48 c7 c7 02 36 3a 82 48 89 c6 31 c0 e8 2c
2e 81 ff <0f> 0b 49 8b 47 18 48 03 58 28 44 89 e7 48 89 de 48 83 c4 08
5b 41
[  603.591036] RSP: 0018:ffffc9000405fc98 EFLAGS: 00010046
[  603.596883] RAX: 62719e41749de400 RBX: 0000000000038200 RCX: 0000000000000007
[  603.604851] RDX: 0000000000000001 RSI: 0000000000000082 RDI: ffff888277e96488
[  603.612826] RBP: ffffc9000405fcc8 R08: 0000000000000001 R09: ffff888276c11800
[  603.620808] R10: 00000000000008a1 R11: ffffffff814f5f05 R12: 0000000000000000
[  603.628792] R13: ffffc90000438c40 R14: 0000000000000000 R15: ffff888274e28480
[  603.636774] FS:  0000000000000000(0000) GS:ffff888277e80000(0000)
knlGS:0000000000000000
[  603.645819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  603.652241] CR2: 00007b08d5421060 CR3: 000000026033e003 CR4: 0000000000760ee0
[  603.660213] PKRU: 55555554
[  603.663233] Call Trace:
[  603.665962]  tb_ring_stop+0x9d/0x17d
[  603.669959]  tb_ctl_stop+0x3c/0x9d
[  603.673772]  tb_domain_runtime_suspend+0x35/0x3a
[  603.678923]  nhi_runtime_suspend+0x1f/0x4c
[  603.683497]  pci_pm_runtime_suspend+0x5c/0x173
[  603.688471]  ? pci_pm_restore_noirq+0x8d/0x8d
[  603.693341]  __rpm_callback+0x87/0x103
[  603.697528]  ? pci_pm_restore_noirq+0x8d/0x8d
[  603.702408]  rpm_callback+0x27/0x80
[  603.706307]  rpm_suspend+0x23d/0x55a
[  603.710302]  pm_runtime_work+0x78/0x90
[  603.714488]  process_one_work+0x1da/0x394
[  603.718965]  worker_thread+0x216/0x375
[  603.723153]  kthread+0x147/0x156
[  603.726770]  ? pr_cont_work+0x58/0x58
[  603.730866]  ? kthread_blkcg+0x2e/0x2e
[  603.735052]  ret_from_fork+0x1f/0x40
[  603.739057] ---[ end trace 6494317f2b096251 ]---

The 20 second timeout comes with this print:
[  189.490022] thunderbolt 0000:00:0d.2: 0: timeout reading config
space 2 from 0x6

I added my own warning so I could see the call stack when the 20
second timeout occurs. Here it is:

[  189.159653] ------------[ cut here ]------------
[  189.164833] WARNING: CPU: 2 PID: 7810 at
drivers/thunderbolt/ctl.c:988 tb_cfg_read+0xbc/0xee
[  189.274592] CPU: 2 PID: 7810 Comm: kworker/u16:56 Tainted: G     U
          5.4.128 #6
[  189.292887] Workqueue: events_unbound async_run_entry_fn
[  189.298836] RIP: 0010:tb_cfg_read+0xbc/0xee
[  189.303514] Code: 44 89 e6 e8 54 00 00 00 89 c3 65 48 8b 04 25 28
00 00 00 48 3b 45 d0 75 3e 89 d8 48 83 c4 20 5b 41 5c 41 5d 41 5e 41
5f 5d c3 <0f> 0b 49 8b 45 00 bf b8 00 00 00 48 03 78 18 48 c7 c6 b6 3e
3a 82
[  189.324506] RSP: 0000:ffffc90003e07c08 EFLAGS: 00010246
[  189.330358] RAX: ffffc90003e07c08 RBX: 00000000ffffff92 RCX: dbdecb3394931000
[  189.338331] RDX: 0000000000015000 RSI: 0000000000000000 RDI: ffffc90003e079c0
[  189.346309] RBP: ffffc90003e07c50 R08: ffff888277e9cb80 R09: 0000000000100000
[  189.354284] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[  189.362265] R13: ffff888276383d00 R14: 0000000000000006 R15: 0000000000000000
[  189.370240] FS:  0000000000000000(0000) GS:ffff888277e80000(0000)
knlGS:0000000000000000
[  189.379282] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  189.385707] CR2: 0000000000000000 CR3: 000000026cd38001 CR4: 0000000000760ee0
[  189.393680] PKRU: 55555554
[  189.396700] Call Trace:
[  189.399443]  usb4_switch_wait_for_bit+0x91/0xf0
[  189.404517]  usb4_switch_set_sleep+0xfe/0x119
[  189.409389]  tb_suspend_noirq+0x7a/0x8b
[  189.413686]  tb_domain_suspend_noirq+0x38/0x60
[  189.418669]  __nhi_suspend_noirq+0x24/0x5a
[  189.423234]  nhi_poweroff_noirq+0x6f/0x8c
[  189.427713]  pci_pm_poweroff_noirq+0x76/0x10f
[  189.432581]  ? pci_pm_thaw_noirq+0x96/0x96
[  189.437169]  dpm_run_callback+0xa5/0x164
[  189.441554]  ? pci_pm_thaw_noirq+0x96/0x96
[  189.446130]  __device_suspend_noirq+0x112/0x20d
[  189.451192]  async_suspend_noirq+0x1f/0x93
[  189.455778]  async_run_entry_fn+0x3d/0xd1
[  189.460258]  process_one_work+0x1da/0x394
[  189.464748]  worker_thread+0x216/0x375
[  189.468943]  kthread+0x147/0x156
[  189.472560]  ? pr_cont_work+0x58/0x58
[  189.476663]  ? kthread_blkcg+0x2e/0x2e
[  189.480860]  ret_from_fork+0x1f/0x40
[  189.484856] ---[ end trace 3e98173d9782f880 ]---

I'm unfamiliar with the thunderbolt driver, so any help or even hints
would be appreciated. I'm suspecting either some sort of imbalance in
suspend/resume calls, or maybe some difference in what PCI does
between suspend and freeze, but so far haven't found the smoking gun.
-Evan
