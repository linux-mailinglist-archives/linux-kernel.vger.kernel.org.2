Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539BA31F47C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 05:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBSE1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 23:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhBSE1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:27:11 -0500
X-Greylist: delayed 2223 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Feb 2021 20:26:31 PST
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 20:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RuCtoajrjDiFLF6KFXKWAhewndEx9v8lOT3Ngz/AyS4=; b=F3Hx7kADEjYMusHRms+TJzJALw
        M+vjMzQTqMXIz8hdy8jzKn0ste40GPrTkjrUy0fEOcyScC1g0q5fIAKZt8t9+EiRinxmLrs/lsY52
        eixN4pNvcrlAs8LprXCD1lCc43nP+tyLSIBzKwggWH4sR+Lp/jC68/xuG6yDAsPGzE8S2EqFlesr+
        Ot5TY5m1qt8bKAHo9/fQd9w32voylA/r/ECJMm6dy6nn/d4N7U3RMs3p5JW8WPolJo91sS+3LAWIL
        kUa4RDzHlqnmbwTsTgzexMCCXIvbpbr4INXEqB3pqbcGZFNV683jYO9qka6qahRovCkm2BAlWEN/C
        d9ty0qUg==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1lCwnD-0001MW-G8
        for linux-kernel@vger.kernel.org; Fri, 19 Feb 2021 03:49:23 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 25AA21415F5BE; Fri, 19 Feb 2021 12:49:20 +0900 (JST)
Date:   Fri, 19 Feb 2021 12:49:20 +0900
From:   Norbert Preining <norbert@preining.info>
To:     linux-kernel@vger.kernel.org
Subject: amdgpu, 5.11.0, suicide when input of monitor is switched
Message-ID: <YC81QEmBz+yRvaE/@bulldog.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

After switching inputs of the display I use (two computers are
connected, one via DP and the current one via HDMI), the AMD GPU I use
stopped sending signals to the display.

The kernel log showed the following:

[  262.300879] [drm:drm_atomic_helper_wait_for_flip_done [drm_kms_helper]] =
*ERROR* [CRTC:77:crtc-0] flip_done timed out
[  263.068884] [drm:amdgpu_dm_atomic_check [amdgpu]] *ERROR* [CRTC:77:crtc-=
0] hw_done or flip_done timed out
[  267.338757] [drm] amdgpu_dm_irq_schedule_work FAILED src 4
[  273.308861] [drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper=
]] *ERROR* [CRTC:77:crtc-0] flip_done timed out
[  277.928665] [drm] amdgpu_dm_irq_schedule_work FAILED src 4
[  278.528714] [drm] amdgpu_dm_irq_schedule_work FAILED src 4
[  283.548856] [drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper=
]] *ERROR* [PLANE:65:plane-5] flip_done timed out
[  283.611061] ------------[ cut here ]------------
[  283.611063] WARNING: CPU: 6 PID: 214 at drivers/gpu/drm/amd/amdgpu/../di=
splay/amdgpu_dm/amdgpu_dm.c:7754 amdgpu_dm_atomic_commit_tail+0x21c1/0x2250=
 [amdgpu]
[  283.611147] Modules linked in: nf_conntrack_netlink xfrm_user xfrm_algo =
xt_addrtype br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack xt_tcpudp n=
ft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bridge stp l=
lc nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd g=
race nfs_ssc fscache scsi_transport_iscsi ipt_REJECT nf_reject_ipv4 xt_mult=
iport nft_compat nft_counter nf_tables nfnetlink rfkill overlay binfmt_misc=
 x86_pkg_temp_thermal kvm_intel kvm irqbypass crct10dif_pclmul ghash_clmuln=
i_intel aesni_intel crypto_simd cryptd glue_helper pcspkr serio_raw iTCO_wd=
t ee1004 iTCO_vendor_support uvcvideo videobuf2_vmalloc videobuf2_memops vi=
deobuf2_v4l2 videobuf2_common snd_usb_audio snd_usbmidi_lib videodev sg snd=
_rawmidi mc mei_me mei intel_pch_thermal acpi_pad evdev joydev ext4 crc16 m=
bcache jbd2 nvidia_drm(POE) nvidia_modeset(POE) loop nvidia(POE) drivetemp =
i2c_dev parport_pc parport configfs sunrpc ip_tables x_tables autofs4 raid1=
0 raid456 async_raid6_recov
[  283.611185]  async_memcpy async_pq async_xor async_tx raid1 raid0 multip=
ath linear md_mod wacom hid_generic usbhid hid uas usb_storage amdgpu gpu_s=
ched i2c_algo_bit drm_ttm_helper ttm crc32_pclmul psmouse mxm_wmi xhci_pci =
nvme drm_kms_helper xhci_hcd nvme_core cec i2c_designware_platform drm i2c_=
designware_core usbcore
[  283.611201] CPU: 6 PID: 214 Comm: kworker/6:3 Tainted: P           OE   =
  5.11.0 #125
[  283.611203] Hardware name: MSI MS-7A16/Z170A MPOWER GAMING TITANIUM(MS-7=
A16), BIOS 1.10 07/22/2016
[  283.611204] Workqueue: events dm_irq_work_func [amdgpu]
[  283.611264] RIP: 0010:amdgpu_dm_atomic_commit_tail+0x21c1/0x2250 [amdgpu]
[  283.611323] Code: 95 a0 fd ff ff c7 85 a4 fd ff ff 37 00 00 00 c7 85 ac =
fd ff ff 20 00 00 00 e8 3b 50 12 00 e9 4c fb ff ff 0f 0b e9 9b f9 ff ff <0f=
> 0b e9 eb f9 ff ff 0f 0b 0f 0b e9 01 fa ff ff 48 89 c8 44 8b 85
[  283.611324] RSP: 0018:ffffa93340a3fab8 EFLAGS: 00010002
[  283.611326] RAX: 0000000000000297 RBX: 0000000000000001 RCX: ffff942594e=
d9118
[  283.611327] RDX: 0000000000000001 RSI: 0000000000000297 RDI: ffff9425961=
20188
[  283.611328] RBP: ffffa93340a3fdb0 R08: 0000000000000005 R09: 00000000000=
00000
[  283.611329] R10: ffffa93340a3fa18 R11: 0000000000000002 R12: 00000000000=
00297
[  283.611330] R13: ffff9426652bc400 R14: ffff942594ed9000 R15: ffff94258ab=
dcd80
[  283.611331] FS:  0000000000000000(0000) GS:ffff9434bed80000(0000) knlGS:=
0000000000000000
[  283.611332] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  283.611333] CR2: 00007f1c940f0030 CR3: 0000000accc0a002 CR4: 00000000003=
706e0
[  283.611335] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  283.611336] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  283.611337] Call Trace:
[  283.611342]  commit_tail+0x94/0x130 [drm_kms_helper]
[  283.611349]  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
[  283.611354]  dm_restore_drm_connector_state+0xef/0x170 [amdgpu]
[  283.611413]  handle_hpd_irq+0xea/0x120 [amdgpu]
[  283.611470]  dm_irq_work_func+0x49/0x60 [amdgpu]
[  283.611528]  process_one_work+0x1ec/0x380
[  283.611531]  worker_thread+0x53/0x3d0
[  283.611533]  ? process_one_work+0x380/0x380
[  283.611535]  kthread+0x11b/0x140
[  283.611537]  ? __kthread_bind_mask+0x60/0x60
[  283.611538]  ret_from_fork+0x22/0x30
[  283.611541] ---[ end trace 4c7cf81f00d90176 ]---
[  283.611555] ------------[ cut here ]------------
[  283.611555] WARNING: CPU: 6 PID: 214 at drivers/gpu/drm/amd/amdgpu/../di=
splay/amdgpu_dm/amdgpu_dm.c:7354 amdgpu_dm_atomic_commit_tail+0x21ca/0x2250=
 [amdgpu]
[  283.611613] Modules linked in: nf_conntrack_netlink xfrm_user xfrm_algo =
xt_addrtype br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack xt_tcpudp n=
ft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bridge stp l=
lc nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd g=
race nfs_ssc fscache scsi_transport_iscsi ipt_REJECT nf_reject_ipv4 xt_mult=
iport nft_compat nft_counter nf_tables nfnetlink rfkill overlay binfmt_misc=
 x86_pkg_temp_thermal kvm_intel kvm irqbypass crct10dif_pclmul ghash_clmuln=
i_intel aesni_intel crypto_simd cryptd glue_helper pcspkr serio_raw iTCO_wd=
t ee1004 iTCO_vendor_support uvcvideo videobuf2_vmalloc videobuf2_memops vi=
deobuf2_v4l2 videobuf2_common snd_usb_audio snd_usbmidi_lib videodev sg snd=
_rawmidi mc mei_me mei intel_pch_thermal acpi_pad evdev joydev ext4 crc16 m=
bcache jbd2 nvidia_drm(POE) nvidia_modeset(POE) loop nvidia(POE) drivetemp =
i2c_dev parport_pc parport configfs sunrpc ip_tables x_tables autofs4 raid1=
0 raid456 async_raid6_recov
[  283.611643]  async_memcpy async_pq async_xor async_tx raid1 raid0 multip=
ath linear md_mod wacom hid_generic usbhid hid uas usb_storage amdgpu gpu_s=
ched i2c_algo_bit drm_ttm_helper ttm crc32_pclmul psmouse mxm_wmi xhci_pci =
nvme drm_kms_helper xhci_hcd nvme_core cec i2c_designware_platform drm i2c_=
designware_core usbcore
[  283.611655] CPU: 6 PID: 214 Comm: kworker/6:3 Tainted: P        W  OE   =
  5.11.0 #125
[  283.611656] Hardware name: MSI MS-7A16/Z170A MPOWER GAMING TITANIUM(MS-7=
A16), BIOS 1.10 07/22/2016
[  283.611657] Workqueue: events dm_irq_work_func [amdgpu]
[  283.611715] RIP: 0010:amdgpu_dm_atomic_commit_tail+0x21ca/0x2250 [amdgpu]
[  283.611772] Code: ff ff 37 00 00 00 c7 85 ac fd ff ff 20 00 00 00 e8 3b =
50 12 00 e9 4c fb ff ff 0f 0b e9 9b f9 ff ff 0f 0b e9 eb f9 ff ff 0f 0b <0f=
> 0b e9 01 fa ff ff 48 89 c8 44 8b 85 bc fd ff ff bf 04 00 00 00
[  283.611774] RSP: 0018:ffffa93340a3fab8 EFLAGS: 00010086
[  283.611775] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff942594e=
d9118
[  283.611776] RDX: 0000000000000001 RSI: 0000000000000297 RDI: ffff9425961=
20188
[  283.611777] RBP: ffffa93340a3fdb0 R08: 0000000000000005 R09: 00000000000=
00000
[  283.611778] R10: ffffa93340a3fa18 R11: 0000000000000002 R12: 00000000000=
00297
[  283.611779] R13: ffff9426652bc400 R14: ffff942594ed9000 R15: ffff94258ab=
dcd80
[  283.611779] FS:  0000000000000000(0000) GS:ffff9434bed80000(0000) knlGS:=
0000000000000000
[  283.611781] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  283.611782] CR2: 00007f1c940f0030 CR3: 0000000accc0a002 CR4: 00000000003=
706e0
[  283.611783] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  283.611784] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  283.611784] Call Trace:
[  283.611788]  commit_tail+0x94/0x130 [drm_kms_helper]
[  283.611793]  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
[  283.611798]  dm_restore_drm_connector_state+0xef/0x170 [amdgpu]
[  283.611856]  handle_hpd_irq+0xea/0x120 [amdgpu]
[  283.611913]  dm_irq_work_func+0x49/0x60 [amdgpu]
[  283.611969]  process_one_work+0x1ec/0x380
[  283.611971]  worker_thread+0x53/0x3d0
[  283.611973]  ? process_one_work+0x380/0x380
[  283.611975]  kthread+0x11b/0x140
[  283.611976]  ? __kthread_bind_mask+0x60/0x60
[  283.611978]  ret_from_fork+0x22/0x30
[  283.611980] ---[ end trace 4c7cf81f00d90177 ]---


I was running a KDE/Plasma session (5.21) on top of Debian/unstable.
The xsession-error log only shows
   kscreen.kded: Config does not have at least one screen enabled, WILL NOT=
 save this config, this is not what user wants.
and XOrg log didn't say anything.

I tried switching to the console and back, but the screen didn't come
back.

Thanks for any suggestion

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research Labs  +  IFMGA Guide + TU Wien + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
