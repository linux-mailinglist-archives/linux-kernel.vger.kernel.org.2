Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AF536E945
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbhD2K77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:59:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:34249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233114AbhD2K76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619693950;
        bh=1flYkvGScaNDddPhBSz2P3MAFOeEhJHxGx8I1o+gnZI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=HYO/HGQCD+ONOovkO0Vy3mjfUh5qD02H7FnBynkSPU+nAnFqsE5moY6+drCBvjG/u
         BiwzslMJJjSb0gfU4nFle9fofZFznlGWITN36Kn/M3VxiwjTcAIflRQBc0h9zPI9DV
         zdrKPRJq1g2gWOlT5QWBGC0vhbA+cvSO//hsu5W8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.106]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH9Y-1l1eEc1CtI-00ch3J; Thu, 29
 Apr 2021 12:59:10 +0200
Message-ID: <8c38408d27f1032f2a664838e523376c5da09a80.camel@gmx.de>
Subject: block, bfq: NULL pointer dereference in bfq_rq_pos_tree_lookup()
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>
Date:   Thu, 29 Apr 2021 12:59:09 +0200
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:67KmuaUthfhWm4HLWXR2e2dWlogX9A8fb183fL5E1k9g/6Qf2IZ
 jSvmlpGNNVZ26kstpECrCu40T13nBYfiE7QreVMa4LrdEMLciYxv5eYyRQN2oGzw+tH4Ld6
 mWuRXLQinlzD03NnhSgp7tR/gJoRTD7mneNpp5PMXeeC0IKTsfpyS8399q0oxB2Ts1Cm3I9
 fPNr1nBkF664PfFefMnKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:91jb7VCm5zY=:y9zrMEY4QfP/j1v11Oovp8
 MJngxnn22+P89I9Fb7LT1btEHOtWHxXEQNnAbnCc3BW0vNS42kPi0FMnYsHt7k4DvWJWLLjah
 CniqkmpHsEk3zSry8mWhYGrp+K9ZwYz00nqqt1LJGNH2fJlBplQMplQiNA0Kt1cznmTKhClep
 Sn63HMQE0gNDfxv0c6/QgqHi8EEk3uked6j/VBd/x8XJeWSD13PkCMKwGRFumu2k0h4+0rrfh
 wXZcCx+hm/vFH0V4lXN6KavOz2H5Mcn0bfRHEvc37kXRi0L+m1nOtdLT5elM+3kW9K229JtOu
 1K1vs4DFjsi49VvyvQtN1PC/fclBit9og4K5dFlj/kTXwfDzgLIH2yuRttN/LF64I1bGRfiQo
 pBcZtCRLdAAsExKVEiouCwCZcPuUR88xLj+Fqr060ghLULK0Mi7//3w9ABAesNxj3hc0NYVa0
 lvrvRH6rBzeFlLUgp0E8eV4NiXhAew0jlTq0Oj8AbFE3tsrogOjKDfA7q49qhithcSysXpf40
 kFPxTMud8Xllsl+hZmBuUiP9J3GN3pmIUXUY8l7pPRBtraoUyGq8Lm8ZyVR6kI2lnctQyuDna
 KFBaTbJQGa8V5JM6rpS6+7etHVIccSCrT5FBvjKUDr+uVJEdDktEcqSxrPVaVRhr6EW3EKu6l
 TftsycB+n49hfm4c46RwYmDcTyRh8DbFkXxKyzt3pBnFfSm6txy9xC+zUpk/ztbmRF6ZjZNiK
 dWyiKERd5k03N0Ilfh4WQ4kgLiDS+B/aGsfGIBdumPqvpUMhovCaPanYuSxZE1WZakwbwEWcP
 Ynv0cIBnBiqnleiQOFiOlV2avlcnt3SjCMMhrieH5hOeP3futVFNF9CI+NDhmQQMtkSXq/zK6
 bbrBmtNzdhYloJfSxA2Ynw+Des01+HFVGT4HdJQdG805PkqhLIYzdBKZwL/IU8C6aVdg5xuI4
 CkB/4MytKX0EeCs6hOZedPRTfCNRzSreuWHwmKNGwzSxeZmQp+rn/HpT0DtAM3IqdsC3Q9Ti0
 a6z7h5/xyy+nG45Sjq2LsEPeNl4K9Ni2VHwCLopvn5l6H3x9rsWTZbUXrAUXolDbrTLov+DZV
 D7cbEJ4k3OQ60GY5mxp4VZqbQubOltiVZPtuF3TD+zJDTx2wf/ByAbjcNUXRchVsYOd/2nsoN
 vZlniusHnk1/hD4BLInHsO0L+zV/WPR3+CooCZ34qAQ62+zv1wXgpjpQCrsZWSuCiHKQI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build of a distro kernel in master.today got to linking phase, and went bo=
om.

[ 2651.337220] BUG: kernel NULL pointer dereference, address: 000000000000=
0030
[ 2651.337229] #PF: supervisor read access in kernel mode
[ 2651.337231] #PF: error_code(0x0000) - not-present page
[ 2651.337233] PGD 0 P4D 0
[ 2651.337236] Oops: 0000 [#1] SMP NOPTI
[ 2651.337239] CPU: 7 PID: 18691 Comm: ld Kdump: loaded Tainted: G        =
    E     5.12.0.gd72cd4a-master #4
[ 2651.337242] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[ 2651.337244] RIP: 0010:bfq_rq_pos_tree_lookup.isra.26+0x1e/0x90
[ 2651.337249] Code: 00 e8 56 ff ff ff 31 c0 c3 0f 1f 00 0f 1f 44 00 00 53=
 45 31 d2 eb 07 49 8d 71 08 4d 89 ca 4c 8b 0e 4d 85 c9 74 12 49 8b 41 28 <=
48> 39 50 30 72 e7 76 2c 49 8d 71 10 eb e3 31 db 4d 85 c0 4c 89 11
[ 2651.337253] RSP: 0018:ffff8881a0cefa40 EFLAGS: 00010086
[ 2651.337255] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8881a0=
cefa60
[ 2651.337257] RDX: 000000003785bc88 RSI: ffff8881044449b0 RDI: ffff888161=
31d800
[ 2651.337259] RBP: ffff88816131d800 R08: 0000000000000000 R09: ffff8881e1=
1bb288
[ 2651.337261] R10: 0000000000000000 R11: 0000000f00002204 R12: ffff8881e1=
1bb250
[ 2651.337263] R13: ffff88816131d9f0 R14: 000000003785bc88 R15: ffff888104=
13f6b0
[ 2651.337265] FS:  00007f73d1e070c0(0000) GS:ffff88840edc0000(0000) knlGS=
:0000000000000000
[ 2651.337267] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2651.337269] CR2: 0000000000000030 CR3: 00000001a20c8003 CR4: 0000000000=
1706e0
[ 2651.337271] Call Trace:
[ 2651.337275]  bfq_setup_cooperator+0x23c/0x3c0
[ 2651.337279]  ? blk_attempt_req_merge+0xa/0x30
[ 2651.337283]  bfq_insert_requests+0x1bc/0x14c0
[ 2651.337287]  ? submit_bio+0x35/0x100
[ 2651.337290]  ? submit_bio+0x35/0x100
[ 2651.337292]  blk_mq_sched_insert_requests+0x5b/0xf0
[ 2651.337295]  blk_mq_flush_plug_list+0x104/0x180
[ 2651.337298]  blk_flush_plug_list+0xb4/0xd0
[ 2651.337302]  blk_finish_plug+0x27/0x40
[ 2651.337304]  read_pages+0x106/0x1e0
[ 2651.337308]  ? xas_load+0x8/0x80
[ 2651.337311]  ? page_cache_ra_unbounded+0x113/0x1b0
[ 2651.337314]  page_cache_ra_unbounded+0x113/0x1b0
[ 2651.337317]  filemap_get_pages+0xb8/0x4a0
[ 2651.337321]  filemap_read+0x99/0x2d0
[ 2651.337323]  ? __alloc_pages_nodemask+0xff/0x260
[ 2651.337326]  ? page_add_new_anon_rmap+0x50/0xf0
[ 2651.337329]  ? __handle_mm_fault+0xaae/0x1060
[ 2651.337333]  new_sync_read+0x105/0x180
[ 2651.337336]  vfs_read+0x168/0x190
[ 2651.337340]  ksys_read+0x7d/0xb0
[ 2651.337343]  do_syscall_64+0x39/0x80
[ 2651.337347]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2651.337351] RIP: 0033:0x7f73d0ef00c1
[ 2651.337354] Code: fe ff ff 48 8d 3d 27 a1 09 00 48 83 ec 08 e8 d6 03 02=
 00 66 0f 1f 44 00 00 8b 05 ea d2 2c 00 48 63 ff 85 c0 75 13 31 c0 0f 05 <=
48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 55 53 48 89 d5 48 89
[ 2651.337357] RSP: 002b:00007ffcd479d5f8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000000
[ 2651.337359] RAX: ffffffffffffffda RBX: 00005589d27348a0 RCX: 00007f73d0=
ef00c1
[ 2651.337361] RDX: 0000000000001000 RSI: 00005589d273d9e0 RDI: 0000000000=
000007
[ 2651.337363] RBP: 0000000000000d68 R08: 0000000000000000 R09: 0000000000=
000003
[ 2651.337365] R10: ffffffffffffffb0 R11: 0000000000000246 R12: 00007f73d1=
1b87a0
[ 2651.337366] R13: 00007f73d11b92e0 R14: 0000000000000d68 R15: 0000000000=
000008
[ 2651.337369] Modules linked in: fuse(E) msr(E) af_packet(E) xt_tcpudp(E)=
 ip6t_REJECT(E) nf_reject_ipv6(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_connt=
rack(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) libcrc32c(E) n=
fnetlink(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) ip6table_mangle(E) iscsi=
_boot_sysfs(E) ip6table_raw(E) iptable_raw(E) ebtable_filter(E) ebtables(E=
) rfkill(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E=
) x_tables(E) bpfilter(E) usblp(E) joydev(E) intel_rapl_msr(E) iTCO_wdt(E)=
 at24(E) intel_pmc_bxt(E) intel_rapl_common(E) mei_hdcp(E) regmap_i2c(E) i=
TCO_vendor_support(E) snd_hda_codec_realtek(E) nls_iso8859_1(E) snd_hda_co=
dec_generic(E) ledtrig_audio(E) nls_cp437(E) x86_pkg_temp_thermal(E) snd_h=
da_codec_hdmi(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) kvm_inte=
l(E) snd_intel_dspcfg(E) snd_hda_codec(E) kvm(E) snd_hwdep(E) snd_hda_core=
(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) snd_pcm(E) ghash_clmu=
lni_intel(E) snd_timer(E) r8169(E)
[ 2651.337399]  aesni_intel(E) snd(E) realtek(E) crypto_simd(E) mei_me(E) =
i2c_i801(E) mdio_devres(E) lpc_ich(E) cryptd(E) pcspkr(E) i2c_smbus(E) mei=
(E) libphy(E) soundcore(E) mfd_core(E) intel_smartconnect(E) fan(E) therma=
l(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) sch_fq_codel(E) grace(E) s=
unrpc(E) nfs_ssc(E) hid_logitech_hidpp(E) hid_logitech_dj(E) uas(E) usb_st=
orage(E) hid_generic(E) usbhid(E) nouveau(E) wmi(E) drm_ttm_helper(E) ttm(=
E) i2c_algo_bit(E) ahci(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E)=
 sysimgblt(E) fb_sys_fops(E) cec(E) xhci_pci(E) ehci_pci(E) libahci(E) rc_=
core(E) xhci_hcd(E) ehci_hcd(E) libata(E) drm(E) usbcore(E) video(E) butto=
n(E) sd_mod(E) t10_pi(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virti=
o_ring(E) virtio(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) lo=
op(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_=
dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
[ 2651.337447] Dumping ftrace buffer:
[ 2651.337450]    (ftrace buffer empty)
[ 2651.337452] CR2: 0000000000000030

