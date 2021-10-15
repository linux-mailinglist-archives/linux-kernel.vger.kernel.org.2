Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C942EC27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhJOI1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:27:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:2223 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232564AbhJOI0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:26:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="228156860"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="228156860"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 01:23:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="492373279"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 01:23:54 -0700
Date:   Fri, 15 Oct 2021 11:23:49 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     "mat.jonczyk" <mat.jonczyk@o2.pl>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jose.souza@intel.com" <jose.souza@intel.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [stable regression] 5.14.12 breaks graphics on an Intel GM45
 laptop
Message-ID: <20211015082349.GA759059@ideak-desk.fi.intel.com>
References: <c23b96a63fea4ebd9e044bbd3c53b74a@grupawp.pl>
 <87k0ievjo0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0ievjo0.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:20:15AM +0300, Jani Nikula wrote:
> On Thu, 14 Oct 2021, mat.jonczyk <mat.jonczyk@o2.pl> wrote:
> > Hello,
> > 
> > Kernel 5.14.12 breaks GPU support on an Dell Satellite E6500 laptop with GM45 integrated graphics. The screen does not update after
> > the i965 module gets loaded. Same problem happens on 5.15.0-rc5.
> > 
> > paź 14 23:05:34 mjonczyk-laptop kernel: pci 0000:00:00.0: Intel GM45 Chipset
> > paź 14 23:05:34 mjonczyk-laptop kernel: pci 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
> > paź 14 23:05:34 mjonczyk-laptop kernel: pci 0000:00:00.0: detected 32768K stolen memory
> > paź 14 23:05:34 mjonczyk-laptop kernel: input: Integrated_Webcam_2M: Integrate as
> > /devices/pci0000:00/0000:00:1a.7/usb1/1-6/1-6:1.0/input/input22
> > paź 14 23:05:34 mjonczyk-laptop kernel: usbcore: registered new interface driver uvcvideo
> > paź 14 23:05:34 mjonczyk-laptop kernel: checking generic (e0000000 3c0000) vs hw (f6c00000 400000)
> > paź 14 23:05:34 mjonczyk-laptop kernel: checking generic (e0000000 3c0000) vs hw (e0000000 10000000)
> > paź 14 23:05:34 mjonczyk-laptop kernel: fb0: switching to inteldrmfb from VESA VGA
> > paź 14 23:05:34 mjonczyk-laptop kernel: Console: switching to colour dummy device 80x25
> > paź 14 23:05:34 mjonczyk-laptop kernel: i915 0000:00:02.0: vgaarb: deactivate vga console
> > paź 14 23:05:34 mjonczyk-laptop kernel: i915 0000:00:02.0: vgaarb: changed VGA decodes:
> > olddecodes=io+mem,decodes=io+mem:owns=io+mem
> > paź 14 23:05:34 mjonczyk-laptop kernel: usb 3-1.3: New USB device found, idVendor=413c, idProduct=8156, bcdDevice= 4.56
> > paź 14 23:05:34 mjonczyk-laptop kernel: usb 3-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > paź 14 23:05:34 mjonczyk-laptop kernel: usb 3-1.3: Product: Dell Wireless 370 Bluetooth Mini-card
> > paź 14 23:05:34 mjonczyk-laptop kernel: usb 3-1.3: Manufacturer: Dell Computer Corp
> > paź 14 23:05:34 mjonczyk-laptop kernel: invalid opcode: 0000 [#1] SMP PTI
> > paź 14 23:05:34 mjonczyk-laptop kernel: CPU: 1 PID: 303 Comm: systemd-udevd Not tainted 5.14.12-051412-generic #202110130438
> > paź 14 23:05:34 mjonczyk-laptop kernel: Hardware name: Dell Inc. Latitude E6500                  /0NY667, BIOS A29 06/04/2013
> > paź 14 23:05:34 mjonczyk-laptop kernel: RIP: 0010:intel_dp_sync_state+0xe0/0xf0 [i915]
> > paź 14 23:05:34 mjonczyk-laptop kernel: Code: 85 69 ff ff ff 48 8b 9f 60 01 00 00 80 bb 73 01 00 00 00 0f 85 64 ff ff ff 48 8d bb 60 01
> > 00 00 e8 a5 cb ff ff e9 53 ff ff ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 55
> > paź 14 23:05:34 mjonczyk-laptop kernel: RSP: 0000:ffff9d6c006bf870 EFLAGS: 00010282
> > paź 14 23:05:34 mjonczyk-laptop kernel: RAX: ffffffffffffffff RBX: ffff9096c7b84000 RCX: ffff9096c76544e0
> > paź 14 23:05:34 mjonczyk-laptop kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9096c7b841a6
> > paź 14 23:05:34 mjonczyk-laptop kernel: RBP: ffff9d6c006bf890 R08: 00000000ffffff92 R09: ffffffffc0797464
> > paź 14 23:05:34 mjonczyk-laptop kernel: R10: 0000000000000002 R11: ffff9096c7b84df0 R12: 0000000000000000
> > paź 14 23:05:34 mjonczyk-laptop kernel: R13: 0000000000000000 R14: 0000000000000004 R15: ffff9096c7b84000
> > paź 14 23:05:34 mjonczyk-laptop kernel: FS:  00007fc523e0a880(0000) GS:ffff9096dbd00000(0000) knlGS:0000000000000000
> > paź 14 23:05:34 mjonczyk-laptop kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > paź 14 23:05:34 mjonczyk-laptop kernel: CR2: 0000559a4efd6110 CR3: 000000010570e000 CR4: 00000000000006e0
> > paź 14 23:05:34 mjonczyk-laptop kernel: Call Trace:
> > paź 14 23:05:34 mjonczyk-laptop kernel:  intel_modeset_readout_hw_state+0x2a4/0xb90 [i915]
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? __cond_resched+0x1a/0x50
> > paź 14 23:05:34 mjonczyk-laptop kernel:  intel_modeset_setup_hw_state+0x17f/0x650 [i915]
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? drm_modeset_lock_all_ctx+0x1a8/0x3c0 [drm]
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? drm_warn_on_modeset_not_all_locked.part.0+0x5e/0x90 [drm]
> > paź 14 23:05:34 mjonczyk-laptop kernel:  intel_modeset_init_nogem+0x293/0x4d0 [i915]
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? intel_irq_postinstall+0x470/0x5b0 [i915]
> > paź 14 23:05:34 mjonczyk-laptop kernel:  i915_driver_probe+0x1ab/0x440 [i915]
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? mutex_lock+0x13/0x40
> > paź 14 23:05:34 mjonczyk-laptop kernel:  i915_pci_probe+0x58/0x140 [i915]
> > paź 14 23:05:34 mjonczyk-laptop kernel:  local_pci_probe+0x48/0x80
> > paź 14 23:05:34 mjonczyk-laptop kernel:  pci_device_probe+0x105/0x1d0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  really_probe+0x20c/0x410
> > paź 14 23:05:34 mjonczyk-laptop kernel:  __driver_probe_device+0x109/0x180
> > paź 14 23:05:34 mjonczyk-laptop kernel:  driver_probe_device+0x23/0x90
> > paź 14 23:05:34 mjonczyk-laptop kernel:  __driver_attach+0xac/0x1b0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? __device_attach_driver+0xe0/0xe0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  bus_for_each_dev+0x7e/0xc0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  driver_attach+0x1e/0x20
> > paź 14 23:05:34 mjonczyk-laptop kernel:  bus_add_driver+0x135/0x1f0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  driver_register+0x95/0xf0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  __pci_register_driver+0x68/0x70
> > paź 14 23:05:34 mjonczyk-laptop kernel:  i915_init+0x66/0x86 [i915]
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? 0xffffffffc0c80000
> > paź 14 23:05:34 mjonczyk-laptop kernel:  do_one_initcall+0x48/0x1d0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? kmem_cache_alloc_trace+0x159/0x2c0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  do_init_module+0x62/0x290
> > paź 14 23:05:34 mjonczyk-laptop kernel:  load_module+0xaa3/0xb30
> > paź 14 23:05:34 mjonczyk-laptop kernel:  __do_sys_finit_module+0xbf/0x120
> > paź 14 23:05:34 mjonczyk-laptop kernel:  __x64_sys_finit_module+0x18/0x20
> > paź 14 23:05:34 mjonczyk-laptop kernel:  do_syscall_64+0x5c/0xc0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? exit_to_user_mode_prepare+0x37/0xb0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? syscall_exit_to_user_mode+0x27/0x50
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? __x64_sys_mmap+0x33/0x40
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? do_syscall_64+0x69/0xc0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? __x64_sys_lseek+0x18/0x20
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? do_syscall_64+0x69/0xc0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? do_syscall_64+0x69/0xc0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? do_syscall_64+0x69/0xc0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? common_interrupt+0x5a/0xa0
> > paź 14 23:05:34 mjonczyk-laptop kernel:  ? asm_common_interrupt+0x8/0x40
> > paź 14 23:05:34 mjonczyk-laptop kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > paź 14 23:05:34 mjonczyk-laptop kernel: RIP: 0033:0x7fc52438c89d
> > paź 14 23:05:34 mjonczyk-laptop kernel: Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca
> > 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
> > paź 14 23:05:34 mjonczyk-laptop kernel: RSP: 002b:00007ffee98db388 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> > paź 14 23:05:34 mjonczyk-laptop kernel: RAX: ffffffffffffffda RBX: 0000559a4f001eb0 RCX: 00007fc52438c89d
> > paź 14 23:05:34 mjonczyk-laptop kernel: RDX: 0000000000000000 RSI: 00007fc524269ded RDI: 0000000000000017
> > paź 14 23:05:34 mjonczyk-laptop kernel: RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000000
> > paź 14 23:05:34 mjonczyk-laptop kernel: R10: 0000000000000017 R11: 0000000000000246 R12: 00007fc524269ded
> > paź 14 23:05:34 mjonczyk-laptop kernel: R13: 0000000000000000 R14: 0000559a4edadd00 R15: 0000559a4f001eb0
> > paź 14 23:05:34 mjonczyk-laptop kernel: Modules linked in: dell_smm_hwmon(+) snd_hda_codec_generic(+) snd_hda_intel kvm(+)
> > snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwdep snd_pcm dell_wmi ledtrig_audio dell_smbios dcdbas
> > uvcvideo cdc_mbim sparse_keymap dell_wmi_descriptor wmi_bmof snd_seq_midi cdc_wdm videobuf2_vmalloc snd_seq_midi_event
> > serio_raw videobuf2_memops i915(+) snd_rawmidi cdc_ncm iwldvm videobuf2_v4l2 snd_seq cdc_ether mac80211 videobuf2_common
> > qcserial usbnet usb_wwan mii libarc4 ttm videodev usbserial snd_seq_device pcmcia input_leds mc drm_kms_helper iwlwifi snd_timer
> > joydev cec yenta_socket rc_core pcmcia_rsrc pcmcia_core i2c_algo_bit fb_sys_fops syscopyarea snd sysfillrect sysimgblt cfg80211
> > soundcore mac_hid sch_fq_codel msr parport_pc ppdev lp drm parport ip_tables x_tables autofs4 wacom hid_generic usbhid gpio_ich
> > hid sdhci_pci firewire_ohci cqhci ahci i2c_i801 firewire_core xhci_pci psmouse lpc_ich libahci i2c_smbus sdhci crc_itu_t xhci_pci_renesas
> > e1000e wmi video
> > paź 14 23:05:34 mjonczyk-laptop kernel: ---[ end trace 80e312eaeb64de58 ]---
> > paź 14 23:05:34 mjonczyk-laptop kernel: RIP: 0010:intel_dp_sync_state+0xe0/0xf0 [i915]
> > paź 14 23:05:34 mjonczyk-laptop kernel: Code: 85 69 ff ff ff 48 8b 9f 60 01 00 00 80 bb 73 01 00 00 00 0f 85 64 ff ff ff 48 8d bb 60 01
> > 00 00 e8 a5 cb ff ff e9 53 ff ff ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 55
> > paź 14 23:05:34 mjonczyk-laptop kernel: RSP: 0000:ffff9d6c006bf870 EFLAGS: 00010282
> > paź 14 23:05:34 mjonczyk-laptop kernel: RAX: ffffffffffffffff RBX: ffff9096c7b84000 RCX: ffff9096c76544e0
> > paź 14 23:05:34 mjonczyk-laptop kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9096c7b841a6
> > paź 14 23:05:34 mjonczyk-laptop kernel: RBP: ffff9d6c006bf890 R08: 00000000ffffff92 R09: ffffffffc0797464
> > paź 14 23:05:34 mjonczyk-laptop kernel: R10: 0000000000000002 R11: ffff9096c7b84df0 R12: 0000000000000000
> > paź 14 23:05:34 mjonczyk-laptop kernel: R13: 0000000000000000 R14: 0000000000000004 R15: ffff9096c7b84000
> > paź 14 23:05:34 mjonczyk-laptop kernel: FS:  00007fc523e0a880(0000) GS:ffff9096dbd00000(0000) knlGS:0000000000000000
> > paź 14 23:05:34 mjonczyk-laptop kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > paź 14 23:05:34 mjonczyk-laptop kernel: CR2: 0000559a4efd6110 CR3: 000000010570e000 CR4: 00000000000006e0
> > paź 14 23:05:35 mjonczyk-laptop kernel: snd_hda_codec_idt hdaudioC0D0: autoconfig for 92HD71B7X: line_outs=1
> > (0xf/0x0/0x0/0x0/0x0) type:line
> > paź 14 23:05:35 mjonczyk-laptop kernel: snd_hda_codec_idt hdaudioC0D0:    speaker_outs=1 (0xd/0x0/0x0/0x0/0x0)
> > 
> > The most likely culprit is "drm/i915/tc: Fix TypeC port init/resume time sanitization", so I'm CCing its authors.
> > I'll test tomorrow with this patch reverted. Please excuse me for writing this in HTML format, but my main machine is temporarily
> > broken.
> 
> Imre, intel_dp_sync_state() is now called on g4x DP encoders where
> encoder->get_hw_state() returns false. Seems like a fragile change
> that's not mentioned in the commit message or ->sync_state
> documentation. Could be the culprit, though the backtrace isn't
> conclusive.

Yes, the above is the culprit commit, thanks for the report and decoding
the crash log. I'll follow up with the fix shortly.

> 
> BR,
> Jani.
> 
> 
> 
> 
> > 
> > I am testing this on Ubuntu 20.04 using kernels from Ubuntu mainline PPA:
> > https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.14.12/
> > https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15-rc5/
> > 
> > Greetings,
> > Mateusz Jończyk
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
