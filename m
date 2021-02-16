Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEA831C7F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhBPJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhBPJWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:22:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6BAA64DA3;
        Tue, 16 Feb 2021 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613467297;
        bh=yHiDv1iv18QPxJ5y2Do90PnI/N12J3fPYm/QZ2lT6oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNUdg4leUZoz9lcZ/W8cc08y5B8rQ7K9gmnF/goRh9ZRrEaj4IGJ7cewjTjKah2Jt
         TcDBXREdctFu2jOWGJcmhLWJTFEPJAxM8BtB3eOOBp0FjrHDn+1BwlQlYUoXBpwVIJ
         Op2nIm8MLhu5cFuhdKvJBlv3I3RAHTpgLyK6bWRA=
Date:   Tue, 16 Feb 2021 10:21:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Hebb <tommyhebb@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org
Subject: Re: [RFC PATCH] z3fold: prevent reclaim/free race for headless pages
Message-ID: <YCuOnpvM4kM5j+Vn@kroah.com>
References: <8c4f1cb7c51b03d2b2cd451a6404db8e269d94b7.1613465062.git.tommyhebb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8c4f1cb7c51b03d2b2cd451a6404db8e269d94b7.1613465062.git.tommyhebb@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:44:40AM -0800, Thomas Hebb wrote:
> commit ca0246bb97c2 ("z3fold: fix possible reclaim races") introduced
> the PAGE_CLAIMED flag "to avoid racing on a z3fold 'headless' page
> release." By atomically testing and setting the bit in each of
> z3fold_free() and z3fold_reclaim_page(), a double-free was avoided.
>=20
> However, commit 746d179b0e66 ("z3fold: stricter locking and more careful
> reclaim") appears to have unintentionally broken this behavior by moving
> the PAGE_CLAIMED check in z3fold_reclaim_page() to after the page lock
> gets taken, which only happens for non-headless pages. For headless
> pages, the check is now skipped entirely and races can occur again.
>=20
> I have observed such a race on my system:
>=20
>     page:00000000ffbd76b7 refcount:0 mapcount:0 mapping:0000000000000000 =
index:0x0 pfn:0x165316
>     flags: 0x2ffff0000000000()
>     raw: 02ffff0000000000 ffffea0004535f48 ffff8881d553a170 0000000000000=
000
>     raw: 0000000000000000 0000000000000011 00000000ffffffff 0000000000000=
000
>     page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) =3D=3D 0)
>     ------------[ cut here ]------------
>     kernel BUG at include/linux/mm.h:707!
>     invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>     CPU: 2 PID: 291928 Comm: kworker/2:0 Tainted: G    B             5.10=
=2E7-arch1-1-kasan #1
>     Hardware name: Gigabyte Technology Co., Ltd. H97N-WIFI/H97N-WIFI, BIO=
S F9b 03/03/2016
>     Workqueue: zswap-shrink shrink_worker
>     RIP: 0010:__free_pages+0x10a/0x130
>     Code: c1 e7 06 48 01 ef 45 85 e4 74 d1 44 89 e6 31 d2 41 83 ec 01 e8 =
e7 b0 ff ff eb da 48 c7 c6 e0 32 91 88 48 89 ef e8 a6 89 f8 ff <0f> 0b 4c 8=
9 e7 e8 fc 79 07 00 e9 33 ff ff ff 48 89 ef e8 ff 79 07
>     RSP: 0000:ffff88819a2ffb98 EFLAGS: 00010296
>     RAX: 0000000000000000 RBX: ffffea000594c5a8 RCX: 0000000000000000
>     RDX: 1ffffd4000b298b7 RSI: 0000000000000000 RDI: ffffea000594c5b8
>     RBP: ffffea000594c580 R08: 000000000000003e R09: ffff8881d5520bbb
>     R10: ffffed103aaa4177 R11: 0000000000000001 R12: ffffea000594c5b4
>     R13: 0000000000000000 R14: ffff888165316000 R15: ffffea000594c588
>     FS:  0000000000000000(0000) GS:ffff8881d5500000(0000) knlGS:000000000=
0000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 00007f7c8c3654d8 CR3: 0000000103f42004 CR4: 00000000001706e0
>     Call Trace:
>      z3fold_zpool_shrink+0x9b6/0x1240
>      ? sugov_update_single+0x357/0x990
>      ? sched_clock+0x5/0x10
>      ? sched_clock_cpu+0x18/0x180
>      ? z3fold_zpool_map+0x490/0x490
>      ? _raw_spin_lock_irq+0x88/0xe0
>      shrink_worker+0x35/0x90
>      process_one_work+0x70c/0x1210
>      ? pwq_dec_nr_in_flight+0x15b/0x2a0
>      worker_thread+0x539/0x1200
>      ? __kthread_parkme+0x73/0x120
>      ? rescuer_thread+0x1000/0x1000
>      kthread+0x330/0x400
>      ? __kthread_bind_mask+0x90/0x90
>      ret_from_fork+0x22/0x30
>     Modules linked in: rfcomm ebtable_filter ebtables ip6table_filter ip6=
_tables iptable_filter ccm algif_aead des_generic libdes ecb algif_skcipher=
 cmac bnep md4 algif_hash af_alg vfat fat intel_rapl_msr intel_rapl_common =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iwlmvm hid_logitec=
h_hidpp kvm at24 mac80211 snd_hda_codec_realtek iTCO_wdt snd_hda_codec_gene=
ric intel_pmc_bxt snd_hda_codec_hdmi ledtrig_audio iTCO_vendor_support mei_=
wdt mei_hdcp snd_hda_intel snd_intel_dspcfg libarc4 soundwire_intel irqbypa=
ss iwlwifi soundwire_generic_allocation rapl soundwire_cadence intel_cstate=
 snd_hda_codec intel_uncore btusb joydev mousedev snd_usb_audio pcspkr btrt=
l uvcvideo nouveau btbcm i2c_i801 btintel snd_hda_core videobuf2_vmalloc i2=
c_smbus snd_usbmidi_lib videobuf2_memops bluetooth snd_hwdep soundwire_bus =
snd_soc_rt5640 videobuf2_v4l2 cfg80211 snd_soc_rl6231 videobuf2_common snd_=
rawmidi lpc_ich alx videodev mdio snd_seq_device snd_soc_core mc ecdh_gener=
ic mxm_wmi mei_me
>      hid_logitech_dj wmi snd_compress e1000e ac97_bus mei ttm rfkill snd_=
pcm_dmaengine ecc snd_pcm snd_timer snd soundcore mac_hid acpi_pad pkcs8_ke=
y_parser it87 hwmon_vid crypto_user fuse ip_tables x_tables ext4 crc32c_gen=
eric crc16 mbcache jbd2 dm_crypt cbc encrypted_keys trusted tpm rng_core us=
bhid dm_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel =
aesni_intel crypto_simd cryptd glue_helper xhci_pci xhci_pci_renesas i915 v=
ideo intel_gtt i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgbl=
t fb_sys_fops cec drm agpgart
>     ---[ end trace 126d646fc3dc0ad8 ]---
>=20
> To fix the issue, re-add the earlier test and set in the case where we
> have a headless page.
>=20
> Fixes: 746d179b0e66 ("z3fold: stricter locking and more careful reclaim")

This commit id is not in Linus's tree :(

thanks,

greg k-h
