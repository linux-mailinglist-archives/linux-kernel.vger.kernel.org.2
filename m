Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE5540D077
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhIOXtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:49:01 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:42154 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhIOXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:48:50 -0400
Date:   Wed, 15 Sep 2021 23:47:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail; t=1631749641;
        bh=776+rPQKpJ34JYA0ndo424L7KOgpTkkvyFVJy6GGWLw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=LeFhWEQ92er+OR6QWYcU9uMm2ukJ5Qg5s9cZqkpdeocleERvtN6/TPp5gJL/mpmRp
         9KOF/nut15x+K2NHrNBZ6Bua25u8FT5uH6NLhJz/kYUqqCpbgieAIwRLkA3qc3C0YV
         pz3OHQ0YIw9yemD8XrxgiaFqkV4cudUeLppdH2IA=
To:     ebiederm@xmission.com
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm\\@kvack.org" <linux-mm@kvack.org>,
        "legion\\@kernel.org" <legion@kernel.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
Message-ID: <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
In-Reply-To: <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch> <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 15th, 2021 at 10:42 PM, Jordan Glover <Golden_Mille=
r83@protonmail.ch> wrote:
>
> I had about 2 containerized (flatpak/bubblewrap) apps (browser + music pl=
ayer) running . I quickly closed them with intent to shutdown the system bu=
t instead get the freeze and had to use magic sysrq to reboot. System logs =
end with what I posted and before there is nothing suspicious.
>
> Maybe it's some random fluke. I'll reply if I hit it again.

Heh, it jut happened again. This time closing firefox alone had such effect=
:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 351 at kernel/ucount.c:253 dec_ucount+0x43/0x50
Modules linked in: nft_ct nft_fib_ipv4 nft_fib wireguard curve25519_x86_64 =
libcurve25519_generic libchacha20poly1305 chacha_x86_64 poly1305_x86_64 udp=
_tunnel libblake2s blake2s_x86_64 libblake2s_generic libchacha ccm algif_ae=
ad des_generic libdes ecb algif_skcipher cmac md4 algif_hash af_alg hid_sen=
sor_custom_intel_hinge hid_sensor_als hid_sensor_gyro_3d hid_sensor_accel_3=
d hid_sensor_rotation hid_sensor_magn_3d hid_sensor_trigger industrialio_tr=
iggered_buffer hid_sensor_iio_common kfifo_buf industrialio hid_sensor_cust=
om hid_sensor_hub cros_ec_ishtp cros_ec intel_ishtp_loader intel_ishtp_hid =
intel_rapl_msr nft_counter xt_mark ipt_REJECT nf_reject_ipv4 mei_hdcp intel=
_rapl_common xt_LOG nf_log_syslog intel_tcc_cooling x86_pkg_temp_thermal th=
ink_lmi wmi_bmof xt_addrtype firmware_attributes_class xt_tcpudp intel_powe=
rclamp xt_conntrack nf_conntrack nf_defrag_ipv4 snd_hda_codec_hdmi nft_comp=
at intel_wmi_thunderbolt nf_tables libcrc32c coretemp iwlmvm snd_ctl_led nf=
netlink
 snd_hda_codec_conexant mac80211 snd_hda_codec_generic libarc4 vfat snd_hda=
_intel kvm_intel fat iwlwifi snd_intel_dspcfg rapl intel_cstate joydev snd_=
hda_codec mousedev intel_uncore snd_hwdep snd_hda_core psmouse snd_pcm snd_=
timer cfg80211 mei_me wacom ucsi_acpi typec_ucsi mei intel_pch_thermal inte=
l_xhci_usb_role_switch intel_ish_ipc roles intel_ishtp typec wmi thinkpad_a=
cpi ledtrig_audio platform_profile snd soundcore tpm_crb rfkill i2c_hid_acp=
i tpm_tis tpm_tis_core i2c_hid mac_hid acpi_pad pkcs8_key_parser fuse zram =
ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid dm_crypt c=
bc encrypted_keys trusted asn1_encoder tee tpm rng_core dm_mod rtsx_pci_sdm=
mc mmc_core serio_raw atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_int=
el ghash_clmulni_intel aesni_intel crypto_simd cryptd rtsx_pci xhci_pci xhc=
i_pci_renesas i8042 serio kvmgt mdev vfio_iommu_type1 vfio i915 i2c_algo_bi=
t intel_gtt ttm agpgart video drm_kms_helper syscopyarea sysfillrect sysimg=
blt
 fb_sys_fops cec drm kvm irqbypass
CPU: 1 PID: 351 Comm: kworker/1:3 Not tainted 5.14.3 #1 c719caf0c6c20896838=
7ed83e3061ac05d0faf2f
Workqueue: events free_user_ns
RIP: 0010:dec_ucount+0x43/0x50
Code: 14 01 48 8b 02 48 89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b =
41 10 48 8b 88 e8 01 00 00 48 85 c9 75 d9 e9 0d fd ff ff <0f> 0b eb e7 66 0=
f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 f8 48
RSP: 0018:ffffaa06c08bbe60 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffff894ecb0c35a0 RCX: ffff894e25cdfcc0
RDX: ffff894e25cdfce0 RSI: ffffffffffffffff RDI: ffff894e25cdfcc0
RBP: ffff894ee393d380 R08: 0000000000000020 R09: ffff894ee393d5f0
R10: ffff894f617fd000 R11: 0000000000031678 R12: ffff894e25cdfcc0
R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff894f59680000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056ffceff6b10 CR3: 0000000147a0e005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 free_user_ns+0x73/0x110
 process_one_work+0x1e1/0x380
 worker_thread+0x50/0x3a0
 ? rescuer_thread+0x360/0x360
 kthread+0x127/0x150
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
---[ end trace ff45ac39689f43c1 ]---
BUG: kernel NULL pointer dereference, address: 00000000000001e8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
Oops: 0000 [#1] SMP PTI
CPU: 1 PID: 351 Comm: kworker/1:3 Tainted: G        W         5.14.3 #1 c71=
9caf0c6c208968387ed83e3061ac05d0faf2f
Workqueue: events free_user_ns
RIP: 0010:dec_ucount+0x32/0x50
Code: 74 34 89 f6 48 89 f9 4c 8d 04 f5 20 00 00 00 4a 8d 14 01 48 8b 02 48 =
89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b 41 10 <48> 8b 88 e8 01 0=
0 00 48 85 c9 75 d9 e9 0d fd ff ff 0f 0b eb e7 66
RSP: 0018:ffffaa06c08bbe60 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffff894ecb0c35a0 RCX: ffff894e25cdfcc0
RDX: ffff894e25cdfce0 RSI: ffffffffffffffff RDI: ffff894e25cdfcc0
RBP: ffff894ee393d380 R08: 0000000000000020 R09: ffff894ee393d5f0
R10: ffff894f617fd000 R11: 0000000000031678 R12: ffff894e25cdfcc0
R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff894f59680000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000001e8 CR3: 0000000147a0e005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 free_user_ns+0x73/0x110
 process_one_work+0x1e1/0x380
 worker_thread+0x50/0x3a0
 ? rescuer_thread+0x360/0x360
 kthread+0x127/0x150
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
Modules linked in: nft_ct nft_fib_ipv4 nft_fib wireguard curve25519_x86_64 =
libcurve25519_generic libchacha20poly1305 chacha_x86_64 poly1305_x86_64 udp=
_tunnel libblake2s blake2s_x86_64 libblake2s_generic libchacha ccm algif_ae=
ad des_generic libdes ecb algif_skcipher cmac md4 algif_hash af_alg hid_sen=
sor_custom_intel_hinge hid_sensor_als hid_sensor_gyro_3d hid_sensor_accel_3=
d hid_sensor_rotation hid_sensor_magn_3d hid_sensor_trigger industrialio_tr=
iggered_buffer hid_sensor_iio_common kfifo_buf industrialio hid_sensor_cust=
om hid_sensor_hub cros_ec_ishtp cros_ec intel_ishtp_loader intel_ishtp_hid =
intel_rapl_msr nft_counter xt_mark ipt_REJECT nf_reject_ipv4 mei_hdcp intel=
_rapl_common xt_LOG nf_log_syslog intel_tcc_cooling x86_pkg_temp_thermal th=
ink_lmi wmi_bmof xt_addrtype firmware_attributes_class xt_tcpudp intel_powe=
rclamp xt_conntrack nf_conntrack nf_defrag_ipv4 snd_hda_codec_hdmi nft_comp=
at intel_wmi_thunderbolt nf_tables libcrc32c coretemp iwlmvm snd_ctl_led nf=
netlink
 snd_hda_codec_conexant mac80211 snd_hda_codec_generic libarc4 vfat snd_hda=
_intel kvm_intel fat iwlwifi snd_intel_dspcfg rapl intel_cstate joydev snd_=
hda_codec mousedev intel_uncore snd_hwdep snd_hda_core psmouse snd_pcm snd_=
timer cfg80211 mei_me wacom ucsi_acpi typec_ucsi mei intel_pch_thermal inte=
l_xhci_usb_role_switch intel_ish_ipc roles intel_ishtp typec wmi thinkpad_a=
cpi ledtrig_audio platform_profile snd soundcore tpm_crb rfkill i2c_hid_acp=
i tpm_tis tpm_tis_core i2c_hid mac_hid acpi_pad pkcs8_key_parser fuse zram =
ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid dm_crypt c=
bc encrypted_keys trusted asn1_encoder tee tpm rng_core dm_mod rtsx_pci_sdm=
mc mmc_core serio_raw atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_int=
el ghash_clmulni_intel aesni_intel crypto_simd cryptd rtsx_pci xhci_pci xhc=
i_pci_renesas i8042 serio kvmgt mdev vfio_iommu_type1 vfio i915 i2c_algo_bi=
t intel_gtt ttm agpgart video drm_kms_helper syscopyarea sysfillrect sysimg=
blt
 fb_sys_fops cec drm kvm irqbypass
CR2: 00000000000001e8
---[ end trace ff45ac39689f43c2 ]---
RIP: 0010:dec_ucount+0x32/0x50
Code: 74 34 89 f6 48 89 f9 4c 8d 04 f5 20 00 00 00 4a 8d 14 01 48 8b 02 48 =
89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b 41 10 <48> 8b 88 e8 01 0=
0 00 48 85 c9 75 d9 e9 0d fd ff ff 0f 0b eb e7 66
RSP: 0018:ffffaa06c08bbe60 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffff894ecb0c35a0 RCX: ffff894e25cdfcc0
RDX: ffff894e25cdfce0 RSI: ffffffffffffffff RDI: ffff894e25cdfcc0
RBP: ffff894ee393d380 R08: 0000000000000020 R09: ffff894ee393d5f0
R10: ffff894f617fd000 R11: 0000000000031678 R12: ffff894e25cdfcc0
R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff894f59680000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000001e8 CR3: 0000000147a0e005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
