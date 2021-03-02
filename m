Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CBF32A335
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378040AbhCBIyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:54:03 -0500
Received: from mx.mylinuxtime.de ([195.201.174.144]:53386 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377921AbhCBIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:45:30 -0500
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Mar 2021 03:45:27 EST
Received: from leda (p200300CF2F0F1c00625718FffE7F1598.dip0.t-ipconnect.de [IPv6:2003:cf:2f0f:1c00:6257:18ff:fe7f:1598])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 0130E9E54F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:34:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eworm.de; s=mail;
        t=1614674059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=/CcH7v3WvuKdI1PQjvWRW2bqm7anDRf0BkmEeWPNKJo=;
        b=dwBjmPBFywx09HQZK5KfBrAZ/sTpG4KD9VJiY/+4PYlFSuIfpUK5ruZqYUK/DhuC9/aXKT
        evx5/+mK3RBkgv/QvJaH1gFW8tBYaMweypgWEUQDx1PcpawWfWoBdofCeBY/m8q4v5aP51
        gLZmqqHn0Y/u3sOXdhbreYnBRAFnHKA=
Date:   Tue, 2 Mar 2021 09:34:15 +0100
From:   Christian Hesse <list@eworm.de>
To:     linux-kernel@vger.kernel.org
Subject: general protection fault in css_release_work_fn()
Message-ID: <20210302093415.7b463ddc@leda>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=nAMvyiMUtroZxKmV0OmWb3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
X-Rspamd-Server: mx
X-Spam-Status: No, score=-6.46
X-Stat-Signature: irznsg4cufrqdfghkiqw7tie8thuexfc
X-Rspamd-Queue-Id: 0130E9E54F
X-Spamd-Result: default: False [-6.46 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.03)[-1.009];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM_SHORT(-0.73)[-0.728];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=nAMvyiMUtroZxKmV0OmWb3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello everybody,

I see this on a git server with lots of ssh logins. It happens every few
hours to days. No idea how to reproduce, guess it's a race condition?

general protection fault, probably for non-canonical address 0xdead00000000=
0122: 0000 [#1] SMP NOPTI
CPU: 3 PID: 2213757 Comm: kworker/3:2 Not tainted 5.10.18-1-lts #1
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference=
 Platform, BIOS 6.00 05/28/2020
Workqueue: cgroup_destroy css_release_work_fn
RIP: 0010:css_release_work_fn+0x3c/0x200
Code: 54 55 53 48 89 fb 48 8b 6f a0 4c 8b 67 98 48 c7 c7 80 d3 ed b4 e8 d4 =
83 91 00 48 8b 43 c0 48 8b 53 b8 83 4b ec 04 48 89 42 08 <48> 89 10 4c 89 6=
b c0 48 85 ed 0f 84 ab 00 00 00 48 8b 53 d8 48 8d
RSP: 0018:ffffb75f4098fe78 EFLAGS: 00010206
RAX: dead000000000122 RBX: ffff9b112c157068 RCX: ffff9b117ddab5a0
RDX: ffff9b110e5c2020 RSI: 807fffffffffffff RDI: ffffffffb4edd380
RBP: ffffffffb4ff6120 R08: ffff9b11012e7eb0 R09: ffff9b11234f5c74
R10: 0000000000000018 R11: 0000000000000018 R12: ffff9b110c01a000
R13: dead000000000122 R14: ffff9b117ddb2600 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff9b117dd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0ff5098620 CR3: 000000000e740000 CR4: 00000000003506e0
Call Trace:
 process_one_work+0x1df/0x370
 worker_thread+0x50/0x400
 ? process_one_work+0x370/0x370
 kthread+0x11b/0x140
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x22/0x30
Modules linked in: vsock_loopback vmw_vsock_virtio_transport_common nf_tabl=
es vmw_vsock_vmci_transport vsock libcrc32c nfnetlink vmwgfx amd_energy joy=
dev crct10dif_pclmul crc32_pclmul ghash_clmulni_intel mousedev aesni_intel =
crypto_simd vmw_balloon ttm cryptd glue_helper rapl drm_kms_helper psmouse =
pcspkr vmxnet3 cec syscopyarea sysfillrect sysimgblt intel_agp vmw_vmci fb_=
sys_fops i2c_piix4 intel_gtt mac_hid drm sg fuse agpgart ip_tables x_tables=
 ext4 crc32c_generic crc16 mbcache jbd2 dm_mod sr_mod cdrom ata_generic pat=
a_acpi crc32c_intel serio_raw vmw_pvscsi ata_piix
---[ end trace e3405678b69341c6 ]---
RIP: 0010:css_release_work_fn+0x3c/0x200
Code: 54 55 53 48 89 fb 48 8b 6f a0 4c 8b 67 98 48 c7 c7 80 d3 ed b4 e8 d4 =
83 91 00 48 8b 43 c0 48 8b 53 b8 83 4b ec 04 48 89 42 08 <48> 89 10 4c 89 6=
b c0 48 85 ed 0f 84 ab 00 00 00 48 8b 53 d8 48 8d
RSP: 0018:ffffb75f4098fe78 EFLAGS: 00010206
RAX: dead000000000122 RBX: ffff9b112c157068 RCX: ffff9b117ddab5a0
RDX: ffff9b110e5c2020 RSI: 807fffffffffffff RDI: ffffffffb4edd380
RBP: ffffffffb4ff6120 R08: ffff9b11012e7eb0 R09: ffff9b11234f5c74
R10: 0000000000000018 R11: 0000000000000018 R12: ffff9b110c01a000
R13: dead000000000122 R14: ffff9b117ddb2600 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff9b117dd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0ff5098620 CR3: 000000000e740000 CR4: 00000000003506e0

--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/=nAMvyiMUtroZxKmV0OmWb3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmA9+IcACgkQiUUh18yA
9HYYOggArn4Lolf8ertRbae4FieFme1AWchST28BbuBlKiNeudMBpC5/jXj4Mx/8
9lGA4545Ne1W7sJw+ajyfnvxfmTk+yXDIWpYiUlGWafo4JV591dRLFNkyPfeNck4
tCgExVQ4QF/PQd2RtJjgPVDYs1Zn+6eS4v8koPCc2tfj8Ya1xcTOII2LPMnvR8AG
JdIyku9N5d7DTCMRqTlR6S2ckcx7EcNSasOyTFyIos+GHU6RFm1CHsbkx8OXhzbr
16Y0/PbYBqnIn/qUu3wmkkl7BCseNnMCuq9G1CE51A5zbhycgrzrKgxk42paCvoh
4h4ZXhN4Umd50V56hZZNGrt3T7zYWQ==
=g7xr
-----END PGP SIGNATURE-----

--Sig_/=nAMvyiMUtroZxKmV0OmWb3--
