Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5363D326914
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBZVBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhBZVBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:01:15 -0500
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Feb 2021 13:00:22 PST
Received: from amazon.4net.rs (amazon.4net.co.rs [IPv6:2a01:4f8:1c1c:6668::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F2AC06178C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:00:22 -0800 (PST)
Received: from localhost (amazon.4net.co.rs [127.0.0.1])
        by amazon.4net.rs (Postfix) with ESMTP id DE4936308DA1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 21:50:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 4net.rs
Received: from amazon.4net.rs ([127.0.0.1])
        by localhost (amazon.dyn.4net.co.rs [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ngP06GLlre7C for <linux-kernel@vger.kernel.org>;
        Fri, 26 Feb 2021 21:50:09 +0100 (CET)
Received: from mail.4net.rs (green.4net.rs [10.188.221.8])
        by amazon.4net.rs (Postfix) with ESMTP id E9A596308DA0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 21:50:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.4net.rs (Postfix) with ESMTP id A4783CB79E02E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 21:50:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at 4net.rs
Received: from mail.4net.rs ([127.0.0.1])
        by localhost (green.4net.rs [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 41RimjTKAgjg for <linux-kernel@vger.kernel.org>;
        Fri, 26 Feb 2021 21:50:08 +0100 (CET)
Received: from mail.4net.rs (localhost [127.0.0.1])
        by mail.4net.rs (Postfix) with ESMTP id 69827C846719B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 21:50:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=4net.rs; h=mime-version
        :date:from:to:subject:message-id:content-type
        :content-transfer-encoding; s=4netrs; bh=uDWJEKpuJaDWW+6qoEdUYyK
        IWzk=; b=i3O4R/Ddzgv0GEiTwFUYgowtx/tFo6jloGmLSprlafqcCJqz959aOqm
        mNJszZz1m+DgUR0+yBTHwLfvsH343xclqqUjspqsVH8r8WI7jIjCRQ71PfwegG0I
        a44b8PLUxpocXrfe+uT7rtguY/3CunbStVnnOKrqNggr03fYKEvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=4net.rs; h=mime-version:date
        :from:to:subject:message-id:content-type
        :content-transfer-encoding; q=dns; s=4netrs; b=gmeSVQr0b0A/O5ddV
        vlK50gRJkX3dapncKzf0oFO1WfvdoODCuKus31uHTUwipJF5MSOk6SItox1RNWPH
        Yy2YYvm7c9TcuWZ1mxJbi619w2nJWOyL29lKxOef9n0gvwHr6lC+NCmXwtyL6jMf
        1N+gVF4Xl2D5x69fYiZIiiUpa4=
Received: from 4net.co.rs (localhost [127.0.0.1])
        by mail.4net.rs (Postfix) with ESMTPSA id 2A8F6CB79E02E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 21:50:08 +0100 (CET)
MIME-Version: 1.0
Date:   Fri, 26 Feb 2021 21:50:08 +0100
From:   =?UTF-8?Q?Sini=C5=A1a_Bandin?= <sinisa@4net.rs>
To:     linux-kernel@vger.kernel.org
Subject: AMDGPU unable to resume from suspend in kernel 5.11
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <1e16c5e393212e357785e16cbedca011@4net.rs>
X-Sender: sinisa@4net.rs
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Since I have installed kernel 5.11 on my Lenovo Yoga Slim 7 (AMD Ryzen 7 
4800U with Radeon Graphics) with openSUSE Tumbleweed, laptop is unable 
to resume from suspend. Everything works just fine with any kernel from 
5.3 until 5.10.

I have tested with one of 5.11-rcX, and with 5.11.0-3, 5.11.0-4 andd 
5.11.2, all from openSUSE "kernel-HEAD" or "kernel-stable" repositories. 
Sorry I haven't reported this earlier...

I was able to get these messages from "journalctl -b -1 -k"

This is the part with errors:

[   72.093824] r7 kernel: amdgpu 0000:03:00.0: [drm:amdgpu_ib_ring_tests 
[amdgpu]] *ERROR* IB test failed on gfx (-110).
[   72.094127] r7 kernel: [drm:process_one_work] *ERROR* ib ring test 
failed (-110).
[   82.174244] r7 kernel: [drm:drm_atomic_helper_wait_for_flip_done 
[drm_kms_helper]] *ERROR* [CRTC:67:crtc-0] flip_done timed out
[   92.413958] r7 kernel: [drm:drm_atomic_helper_wait_for_dependencies 
[drm_kms_helper]] *ERROR* [CRTC:67:crtc-0] flip_done timed out
[  102.653784] r7 kernel: [drm:drm_atomic_helper_wait_for_dependencies 
[drm_kms_helper]] *ERROR* [CONNECTOR:78:eDP-1] flip_done timed out
[  112.893973] r7 kernel: [drm:drm_atomic_helper_wait_for_dependencies 
[drm_kms_helper]] *ERROR* [PLANE:55:plane-3] flip_done timed out
[  112.895565] r7 kernel: ------------[ cut here ]------------
[  112.896428] r7 kernel: WARNING: CPU: 15 PID: 112 at 
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7754 
amdgpu_dm_atomic_commit_tail+0x2574/0x2600 [amdgpu]
[  112.897505] r7 kernel: Modules linked in: ccm rfcomm iptable_nat 
xt_MASQUERADE nf_nat cmac algif_hash algif_skcipher af_alg bnep 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bpfilter ip_tables x_tables 
af_packet btusb btrtl btbcm btintel uvcvideo bluetooth videobuf2_vmalloc 
videobuf2_memops videobuf2_v4l2 videobuf2_common bridge videodev stp 
ecdh_generic llc mc ecc iwlmvm snd_hda_codec_realtek 
snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio snd_hda_intel 
intel_rapl_msr amdgpu intel_rapl_common snd_intel_dspcfg mac80211 
soundwire_intel wireguard soundwire_generic_allocation curve25519_x86_64 
edac_mce_amd libchacha20poly1305 soundwire_cadence chacha_x86_64 
snd_hda_codec snd_soc_dmic snd_acp3x_rn snd_acp3x_pdm_dma 
poly1305_x86_64 libblake2s kvm_amd snd_hda_core sp5100_tco snd_hwdep 
iwlwifi soundwire_bus iommu_v2 gpu_sched kvm drm_ttm_helper snd_soc_core 
ttm drm_kms_helper blake2s_x86_64 libcurve25519_generic libchacha 
libblake2s_generic snd_compress snd_pcm_dmaengine snd_pcm irqbypass cec
[  112.897564] r7 kernel:  snd_timer pcspkr binfmt_misc efi_pstore 
wmi_bmof joydev snd rc_core k10temp snd_rn_pci_acp3x cfg80211 
fb_sys_fops dmi_sysfs syscopyarea soundcore snd_pci_acp3x ucsi_acpi 
sysfillrect sysimgblt i2c_piix4 typec_ucsi i2c_algo_bit ideapad_laptop 
typec thermal sparse_keymap tiny_power_button rfkill button ftsteutates 
hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_als 
hid_sensor_trigger hid_sensor_iio_common industrialio_triggered_buffer 
kfifo_buf industrialio acpi_cpufreq ac amd_pmc nls_iso8859_1 nls_cp437 
vfat fat drm fuse configfs xfs libcrc32c hid_multitouch xhci_pci 
xhci_pci_renesas hid_sensor_hub xhci_hcd hid_generic crct10dif_pclmul 
crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel usbcore 
glue_helper nvme crypto_simd cryptd nvme_core ccp serio_raw amd_sfh wmi 
battery video i2c_hid l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel 
udp_tunnel pppox sg ppp_mppe ppp_generic slhc libarc4 dm_multipath 
dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr
[  112.897930] r7 kernel:  efivarfs
[  112.897930] r7 kernel: CPU: 15 PID: 112 Comm: kworker/u32:4 Not 
tainted 5.11.2-1.gee0b277-default #1 openSUSE Tumbleweed (unreleased)
[  112.897930] r7 kernel: Hardware name: LENOVO 82A2/LNVNB161216, BIOS 
DMCN36WW 11/18/2020
[  112.897930] r7 kernel: Workqueue: events_unbound async_run_entry_fn
[  112.897930] r7 kernel: RIP: 
0010:amdgpu_dm_atomic_commit_tail+0x2574/0x2600 [amdgpu]
[  112.897930] r7 kernel: Code: a8 fd ff ff 01 c7 85 a4 fd ff ff 37 00 
00 00 c7 85 ac fd ff ff 20 00 00 00 e8 58 f3 12 00 e9 dd fa ff ff 0f 0b 
e9 2d f9 ff ff <0f> 0b e9 7c f9 ff ff 0f 0b 0f 0b e9 92 f9 ff ff 49 8b 
06 41 0f b6
[  112.897930] r7 kernel: RSP: 0018:ffffb6c54052f8e0 EFLAGS: 00010002
[  112.897930] r7 kernel: RAX: 0000000000000002 RBX: 00000000000009d3 
RCX: ffff9eb0670ac118
[  112.897930] r7 kernel: RDX: 0000000000000001 RSI: 0000000000000297 
RDI: ffff9eb063ac0188
[  112.897930] r7 kernel: RBP: ffffb6c54052fbd8 R08: 0000000000000005 
R09: 0000000000000000
[  112.897930] r7 kernel: R10: ffffb6c54052f840 R11: ffffb6c54052f844 
R12: 0000000000000297
[  112.897930] r7 kernel: R13: ffff9eb0447c6c00 R14: ffff9eb0bbc2f780 
R15: ffff9eb0670ac000
[  112.897930] r7 kernel: FS:  0000000000000000(0000) 
GS:ffff9eb38d3c0000(0000) knlGS:0000000000000000
[  112.897930] r7 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
[  112.897930] r7 kernel: CR2: 0000000000000000 CR3: 000000019cc10000 
CR4: 0000000000350ee0
[  112.897930] r7 kernel: Call Trace:
[  112.897930] r7 kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
[  112.897930] r7 kernel:  drm_atomic_helper_commit+0x113/0x140 
[drm_kms_helper]
[  112.897930] r7 kernel:  drm_client_modeset_commit_atomic+0x1e4/0x220 
[drm]
[  112.897930] r7 kernel:  drm_client_modeset_commit_locked+0x56/0x150 
[drm]
[  112.897930] r7 kernel:  drm_client_modeset_commit+0x24/0x40 [drm]
[  112.897930] r7 kernel:  drm_fb_helper_set_par+0xa5/0xd0 
[drm_kms_helper]
[  112.897930] r7 kernel:  drm_fb_helper_hotplug_event.part.0+0xa3/0xc0 
[drm_kms_helper]
[  112.897930] r7 kernel:  drm_kms_helper_hotplug_event+0x26/0x30 
[drm_kms_helper]
[  112.897930] r7 kernel:  amdgpu_device_resume+0x2d4/0x360 [amdgpu]
[  112.897930] r7 kernel:  ? pci_pm_poweroff_noirq+0x110/0x110
[  112.897930] r7 kernel:  dpm_run_callback+0x4c/0x120
[  112.897930] r7 kernel:  device_resume+0x105/0x270
[  112.897930] r7 kernel:  ? __suspend_report_result.cold+0x14/0x14
[  112.897930] r7 kernel:  async_resume+0x19/0x30
[  112.897930] r7 kernel:  async_run_entry_fn+0x37/0x140
[  112.897930] r7 kernel:  process_one_work+0x1df/0x370
[  112.897930] r7 kernel:  worker_thread+0x50/0x400
[  112.897930] r7 kernel:  ? process_one_work+0x370/0x370
[  112.897930] r7 kernel:  kthread+0x11b/0x140
[  112.897930] r7 kernel:  ? __kthread_bind_mask+0x60/0x60
[  112.897930] r7 kernel:  ret_from_fork+0x1f/0x30
[  112.897930] r7 kernel: ---[ end trace d4c2eab32f4a3307 ]---
[  112.897930] r7 kernel: ------------[ cut here ]------------
[  112.897930] r7 kernel: WARNING: CPU: 15 PID: 112 at 
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7354 
amdgpu_dm_atomic_commit_tail+0x257d/0x2600 [amdgpu]
[  112.897930] r7 kernel: Modules linked in: ccm rfcomm iptable_nat 
xt_MASQUERADE nf_nat cmac algif_hash algif_skcipher af_alg bnep 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bpfilter ip_tables x_tables 
af_packet btusb btrtl btbcm btintel uvcvideo bluetooth videobuf2_vmalloc 
videobuf2_memops videobuf2_v4l2 videobuf2_common bridge videodev stp 
ecdh_generic llc mc ecc iwlmvm snd_hda_codec_realtek 
snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio snd_hda_intel 
intel_rapl_msr amdgpu intel_rapl_common snd_intel_dspcfg mac80211 
soundwire_intel wireguard soundwire_generic_allocation curve25519_x86_64 
edac_mce_amd libchacha20poly1305 soundwire_cadence chacha_x86_64 
snd_hda_codec snd_soc_dmic snd_acp3x_rn snd_acp3x_pdm_dma 
poly1305_x86_64 libblake2s kvm_amd snd_hda_core sp5100_tco snd_hwdep 
iwlwifi soundwire_bus iommu_v2 gpu_sched kvm drm_ttm_helper snd_soc_core 
ttm drm_kms_helper blake2s_x86_64 libcurve25519_generic libchacha 
libblake2s_generic snd_compress snd_pcm_dmaengine snd_pcm irqbypass cec
[  112.897930] r7 kernel:  snd_timer pcspkr binfmt_misc efi_pstore 
wmi_bmof joydev snd rc_core k10temp snd_rn_pci_acp3x cfg80211 
fb_sys_fops dmi_sysfs syscopyarea soundcore snd_pci_acp3x ucsi_acpi 
sysfillrect sysimgblt i2c_piix4 typec_ucsi i2c_algo_bit ideapad_laptop 
typec thermal sparse_keymap tiny_power_button rfkill button ftsteutates 
hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_als 
hid_sensor_trigger hid_sensor_iio_common industrialio_triggered_buffer 
kfifo_buf industrialio acpi_cpufreq ac amd_pmc nls_iso8859_1 nls_cp437 
vfat fat drm fuse configfs xfs libcrc32c hid_multitouch xhci_pci 
xhci_pci_renesas hid_sensor_hub xhci_hcd hid_generic crct10dif_pclmul 
crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel usbcore 
glue_helper nvme crypto_simd cryptd nvme_core ccp serio_raw amd_sfh wmi 
battery video i2c_hid l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel 
udp_tunnel pppox sg ppp_mppe ppp_generic slhc libarc4 dm_multipath 
dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr
[  112.897930] r7 kernel:  efivarfs
[  112.897930] r7 kernel: CPU: 15 PID: 112 Comm: kworker/u32:4 Tainted: 
G        W         5.11.2-1.gee0b277-default #1 openSUSE Tumbleweed 
(unreleased)
[  112.897930] r7 kernel: Hardware name: LENOVO 82A2/LNVNB161216, BIOS 
DMCN36WW 11/18/2020
[  112.897930] r7 kernel: Workqueue: events_unbound async_run_entry_fn
[  112.897930] r7 kernel: RIP: 
0010:amdgpu_dm_atomic_commit_tail+0x257d/0x2600 [amdgpu]
[  112.897930] r7 kernel: Code: ff ff 37 00 00 00 c7 85 ac fd ff ff 20 
00 00 00 e8 58 f3 12 00 e9 dd fa ff ff 0f 0b e9 2d f9 ff ff 0f 0b e9 7c 
f9 ff ff 0f 0b <0f> 0b e9 92 f9 ff ff 49 8b 06 41 0f b6 8e 2d 01 00 00 
48 c7 c6 98
[  112.897930] r7 kernel: RSP: 0018:ffffb6c54052f8e0 EFLAGS: 00010086
[  112.897930] r7 kernel: RAX: 0000000000000001 RBX: 00000000000009d3 
RCX: ffff9eb0670ac118
[  112.897930] r7 kernel: RDX: 0000000000000001 RSI: 0000000000000297 
RDI: ffff9eb063ac0188
[  112.897930] r7 kernel: RBP: ffffb6c54052fbd8 R08: 0000000000000005 
R09: 0000000000000000
[  112.897930] r7 kernel: R10: ffffb6c54052f840 R11: ffffb6c54052f844 
R12: 0000000000000297
[  112.897930] r7 kernel: R13: ffff9eb0447c6c00 R14: ffff9eb0bbc2f780 
R15: ffff9eb0670ac000
[  112.897930] r7 kernel: FS:  0000000000000000(0000) 
GS:ffff9eb38d3c0000(0000) knlGS:0000000000000000
[  112.897930] r7 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
[  112.897930] r7 kernel: CR2: 0000000000000000 CR3: 000000019cc10000 
CR4: 0000000000350ee0
[  112.897930] r7 kernel: Call Trace:
[  112.897930] r7 kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
[  112.897930] r7 kernel:  drm_atomic_helper_commit+0x113/0x140 
[drm_kms_helper]
[  112.897930] r7 kernel:  drm_client_modeset_commit_atomic+0x1e4/0x220 
[drm]
[  112.897930] r7 kernel:  drm_client_modeset_commit_locked+0x56/0x150 
[drm]
[  112.897930] r7 kernel:  drm_client_modeset_commit+0x24/0x40 [drm]
[  112.897930] r7 kernel:  drm_fb_helper_set_par+0xa5/0xd0 
[drm_kms_helper]
[  112.897930] r7 kernel:  drm_fb_helper_hotplug_event.part.0+0xa3/0xc0 
[drm_kms_helper]
[  112.897930] r7 kernel:  drm_kms_helper_hotplug_event+0x26/0x30 
[drm_kms_helper]
[  112.897930] r7 kernel:  amdgpu_device_resume+0x2d4/0x360 [amdgpu]
[  113.037687] r7 kernel:  ? pci_pm_poweroff_noirq+0x110/0x110
[  113.037687] r7 kernel:  dpm_run_callback+0x4c/0x120
[  113.037687] r7 kernel:  device_resume+0x105/0x270
[  113.037687] r7 kernel:  ? __suspend_report_result.cold+0x14/0x14
[  113.037687] r7 kernel:  async_resume+0x19/0x30
[  113.037687] r7 kernel:  async_run_entry_fn+0x37/0x140
[  113.037687] r7 kernel:  process_one_work+0x1df/0x370
[  113.037687] r7 kernel:  worker_thread+0x50/0x400
[  113.037687] r7 kernel:  ? process_one_work+0x370/0x370
[  113.037687] r7 kernel:  kthread+0x11b/0x140
[  113.037687] r7 kernel:  ? __kthread_bind_mask+0x60/0x60
[  113.037687] r7 kernel:  ret_from_fork+0x1f/0x30
[  113.037687] r7 kernel: ---[ end trace d4c2eab32f4a3308 ]---
[  123.133843] r7 kernel: [drm:drm_atomic_helper_wait_for_flip_done 
[drm_kms_helper]] *ERROR* [CRTC:67:crtc-0] flip_done timed out
[  123.143445] r7 kernel: acpi LNXPOWER:09: Turning OFF
[  123.145060] r7 kernel: acpi LNXPOWER:07: Turning OFF
[  123.147403] r7 kernel: OOM killer enabled.
[  123.150214] r7 kernel: Restarting tasks ... done.
[  123.154731] r7 kernel: Bluetooth: hci0: Firmware revision 0.0 build 
26 week 3 2021
[  123.169564] r7 kernel: PM: suspend exit
[  123.481041] r7 kernel: amdgpu 0000:03:00.0: amdgpu: failed send 
message: TransferTableSmu2Dram (28)         param: 0x00000007 response 
0xfffffffb
[  123.481067] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Failed to export 
SMU metrics table!
[  123.482935] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Msg issuing 
pre-check failed and SMU may be not in the right state!
[  123.482957] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Failed to export 
SMU metrics table!
[  123.482984] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Msg issuing 
pre-check failed and SMU may be not in the right state!
[  123.482993] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Failed to export 
SMU metrics table!
[  128.024723] r7 kernel: wlan0: authenticate with 74:4d:28:0c:c3:6f
[  128.038556] r7 kernel: wlan0: send auth to 74:4d:28:0c:c3:6f (try 
1/3)
[  128.067646] r7 kernel: wlan0: authenticated
[  128.069873] r7 kernel: wlan0: associate with 74:4d:28:0c:c3:6f (try 
1/3)
[  128.077800] r7 kernel: wlan0: RX AssocResp from 74:4d:28:0c:c3:6f 
(capab=0x401 status=0 aid=2)
[  128.097492] r7 kernel: wlan0: associated
[  128.109191] r7 kernel: IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link 
becomes ready
[  133.373765] r7 kernel: [drm:drm_atomic_helper_wait_for_dependencies 
[drm_kms_helper]] *ERROR* [CRTC:67:crtc-0] flip_done timed out
[  133.373767] r7 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* 
ring sdma0 timeout, signaled seq=2317, emitted seq=2320
[  133.374205] r7 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* 
Process information: process  pid 0 thread  pid 0
[  133.374514] r7 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
[  133.375233] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Msg issuing 
pre-check failed and SMU may be not in the right state!
[  133.375251] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Failed to disable 
gfxoff!
[  133.470074] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Msg issuing 
pre-check failed and SMU may be not in the right state!
[  133.470098] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Failed to power 
gate SDMA!
[  133.708328] r7 kernel: amdgpu 0000:03:00.0: 
[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_2.1.0 test 
failed (-110)
[  133.708631] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Msg issuing 
pre-check failed and SMU may be not in the right state!
[  133.741795] r7 kernel: [drm] free PSP TMR buffer
[  133.774699] r7 kernel: amdgpu 0000:03:00.0: amdgpu: MODE2 reset
[  133.774728] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Msg issuing 
pre-check failed and SMU may be not in the right state!
[  133.774737] r7 kernel: amdgpu 0000:03:00.0: amdgpu: Mode2 reset 
failed!
[  133.774745] r7 kernel: amdgpu 0000:03:00.0: amdgpu: ASIC reset failed 
with error, -5 for drm dev, 0000:03:00.0
[  133.774821] r7 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset(1) 
failed
[  133.774884] r7 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset end 
with ret = -5
[  143.613934] r7 kernel: [drm:drm_atomic_helper_wait_for_dependencies 
[drm_kms_helper]] *ERROR* [CONNECTOR:78:eDP-1] flip_done timed out
[  143.869782] r7 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* 
ring sdma0 timeout, signaled seq=2320, emitted seq=2320
[  143.870136] r7 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* 
Process information: process  pid 0 thread  pid 0
[  143.870443] r7 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
[  153.853799] r7 kernel: [drm:drm_atomic_helper_wait_for_dependencies 
[drm_kms_helper]] *ERROR* [PLANE:55:plane-3] flip_done timed out





-- 
Srdačan pozdrav/Best regards/Freundliche Grüße/Cordialement/よろしくお願いします
Siniša Bandin

