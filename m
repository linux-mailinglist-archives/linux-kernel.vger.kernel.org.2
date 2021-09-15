Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71BE40CD68
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 21:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhIOTu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 15:50:57 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:52283 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhIOTuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:50:55 -0400
Date:   Wed, 15 Sep 2021 19:49:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail; t=1631735373;
        bh=Kzo/FE8G5q953Lxm0/XW9G81Ha9l76W4Mmjg/cMipHM=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=HqPu7vKH7qspnMEGjMQ4CxaUdKAn2LZnYGqo8+sq0XCUkYGuTpHnbv7k+uh/LSPxj
         6ib28BlfPOG83k0KuLN4SBcgR0vPFuZguM1kJ1WtyXEsPwJIE6743UlELNa4+J2oX9
         rc5NaZyd4HQQBYrISZBj8uDPdYpw+Kcq/l/iFxUE=
To:     LKML <linux-kernel@vger.kernel.org>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: linux 5.14.3: free_user_ns causes NULL pointer dereference
Message-ID: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
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

Hi, recently I hit system freeze after I was closing few containerized apps=
 on my system. As for now it occurred only once on linux 5.14.3. I think it=
 maybe be related to "Count rlimits in each user namespace" patchset merged=
 during 5.14 window

https://lore.kernel.org/all/257aa5fb1a7d81cf0f4c34f39ada2320c4284771.161909=
4428.git.legion@kernel.org/T/#u

Logs below:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 26546 at kernel/ucount.c:253 dec_ucount+0x43/0x50
Modules linked in: nft_ct nft_fib_ipv4 nft_fib wireguard curve25519_x86_64 =
libcurve25519_generic libchacha20poly1305 chacha_x86_64 poly1305_x86_64 udp=
_tunnel libblake2s blake2s_x86_64 libblake2s_generic libchacha ccm algif_ae=
ad des_generic libdes ecb algif_skcipher cmac md4 algif_hash af_alg hid_sen=
sor_custom_intel_hinge hid_sensor_als hid_sensor_magn_3d hid_sensor_rotatio=
n hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_trigger industrialio_tr=
iggered_buffer hid_sensor_iio_common kfifo_buf industrialio hid_sensor_cust=
om hid_sensor_hub cros_ec_ishtp cros_ec intel_ishtp_loader nft_counter inte=
l_ishtp_hid snd_hda_codec_hdmi intel_rapl_msr xt_mark ipt_REJECT nf_reject_=
ipv4 snd_ctl_led xt_LOG snd_hda_codec_conexant nf_log_syslog snd_hda_codec_=
generic xt_addrtype xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv4 mei_=
hdcp snd_hda_intel nft_compat wmi_bmof nf_tables intel_rapl_common libcrc32=
c think_lmi intel_tcc_cooling snd_intel_dspcfg firmware_attributes_class nf=
netlink iwlmvm
 intel_wmi_thunderbolt mac80211 x86_pkg_temp_thermal snd_hda_codec intel_po=
werclamp coretemp libarc4 vfat fat kvm_intel rapl intel_cstate snd_hwdep in=
tel_uncore iwlwifi snd_hda_core mousedev joydev snd_pcm psmouse cfg80211 sn=
d_timer mei_me ucsi_acpi wacom intel_ish_ipc intel_xhci_usb_role_switch mei=
 intel_pch_thermal typec_ucsi roles typec intel_ishtp wmi thinkpad_acpi led=
trig_audio platform_profile snd soundcore rfkill tpm_crb i2c_hid_acpi i2c_h=
id acpi_pad tpm_tis mac_hid tpm_tis_core pkcs8_key_parser fuse zram ip_tabl=
es x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid dm_crypt cbc encr=
ypted_keys trusted asn1_encoder tee tpm rng_core dm_mod rtsx_pci_sdmmc mmc_=
core serio_raw atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_intel ghas=
h_clmulni_intel aesni_intel crypto_simd cryptd xhci_pci rtsx_pci xhci_pci_r=
enesas i8042 serio kvmgt mdev vfio_iommu_type1 vfio i915 i2c_algo_bit intel=
_gtt ttm agpgart video drm_kms_helper syscopyarea sysfillrect sysimgblt fb_=
sys_fops cec
 drm kvm irqbypass
CPU: 1 PID: 26546 Comm: kworker/1:1 Not tainted 5.14.3 #1 c719caf0c6c208968=
387ed83e3061ac05d0faf2f
Workqueue: events free_user_ns
RIP: 0010:dec_ucount+0x43/0x50
Code: 14 01 48 8b 02 48 89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b =
41 10 48 8b 88 e8 01 00 00 48 85 c9 75 d9 e9 0d fd ff ff <0f> 0b eb e7 66 0=
f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 f8 48
RSP: 0018:ffffa82cc2bd7e60 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffffa2f53298ee50 RCX: ffffa2f3c0061000
RDX: ffffa2f3c0061020 RSI: ffffffffffffffff RDI: ffffa2f3c0061000
RBP: ffffa2f53298ebe0 R08: 0000000000000020 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffa2f3c0061000
R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffffa2f599680000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000628f892be9f8 CR3: 000000002880e004 CR4: 00000000003706e0
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
---[ end trace eb7a8d38b64b2d3a ]---
BUG: kernel NULL pointer dereference, address: 00000000000001e8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
Oops: 0000 [#1] SMP PTI
CPU: 1 PID: 26546 Comm: kworker/1:1 Tainted: G        W         5.14.3 #1 c=
719caf0c6c208968387ed83e3061ac05d0faf2f
Workqueue: events free_user_ns
RIP: 0010:dec_ucount+0x32/0x50
Code: 74 34 89 f6 48 89 f9 4c 8d 04 f5 20 00 00 00 4a 8d 14 01 48 8b 02 48 =
89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b 41 10 <48> 8b 88 e8 01 0=
0 00 48 85 c9 75 d9 e9 0d fd ff ff 0f 0b eb e7 66
RSP: 0018:ffffa82cc2bd7e60 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffffa2f53298ee50 RCX: ffffa2f3c0061000
RDX: ffffa2f3c0061020 RSI: ffffffffffffffff RDI: ffffa2f3c0061000
RBP: ffffa2f53298ebe0 R08: 0000000000000020 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffa2f3c0061000
R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffffa2f599680000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000001e8 CR3: 000000002880e004 CR4: 00000000003706e0
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

