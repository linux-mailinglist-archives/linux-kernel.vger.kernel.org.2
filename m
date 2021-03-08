Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE7330CAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhCHLtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCHLs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:48:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19F1C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 03:48:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJENb-00079y-6l; Mon, 08 Mar 2021 12:48:55 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:2b48:a475:d90d:3f7e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DD2775F0AAA;
        Mon,  8 Mar 2021 11:48:53 +0000 (UTC)
Date:   Mon, 8 Mar 2021 12:48:52 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de,
        admin@pengutronix.de
Subject: list_add corruption in __percpu_counter_init
Message-ID: <20210308114852.uobxb653nrmgc6i4@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jzlbobv35ppxbtc7"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jzlbobv35ppxbtc7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

since updating one of our compile cluster machines from kernel 4.19+105+deb=
10u9 to
5.10.0-0.bpo.3-amd64 #1 Debian 5.10.13-1~bpo10+1 we're hit by this bug
every 1...2 days:

list_add corruption. next->prev should be prev (ffffffff889a9840), but was =
0000000000000000. (next=3Dffff9c3dcaf2a310).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:25!
invalid opcode: 0000 [#1] SMP PTI
CPU: 9 PID: 3281 Comm: python3 Not tainted 5.10.0-0.bpo.3-amd64 #1 Debian 5=
=2E10.13-1~bpo10+1
Hardware name: Intel Corporation S5520HC/S5520HC, BIOS S5500.86B.01.00.0059=
=2E082320111421 08/23/2011
RIP: 0010:__list_add_valid.cold.0+0x12/0x28
Code: 80 46 32 88 48 89 ef e8 62 3e 01 00 48 c7 c0 f0 ff ff ff e9 bb 1e bf =
ff 48 89 d1 48 c7 c7 f8 46 32 88 48 89 c2 e8 02 2a ff ff <0f> 0b 48 89 c1 4=
c 89 c6 48 c7 c7 50 47 32 88 e8 ee 29 ff ff 0f 0b
RSP: 0018:ffffbb0862ba3910 EFLAGS: 00010046
RAX: 0000000000000075 RBX: ffff9c3dcaf2a268 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff9c46ffb18a00 RDI: ffff9c46ffb18a00
RBP: ffff9c3dcaf2a278 R08: 0000000000000000 R09: c0000000ffffdfff
R10: 0000000000000001 R11: ffffbb0862ba3720 R12: ffff9c3dcaf2a310
R13: ffffffff889a9840 R14: 0000000000000002 R15: 0000000000002800
FS:  00007f4bfc65d740(0000) GS:ffff9c46ffb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001f5b100 CR3: 00000013298c4001 CR4: 00000000000206e0
Call Trace:
 __percpu_counter_init+0x64/0xa0
 blkg_rwstat_init+0x3c/0xb0
 throtl_pd_alloc+0x63/0x230
 blkg_alloc+0x134/0x180
 blkg_create+0x232/0x320
 ? kmem_cache_alloc+0x30c/0x420
 bio_associate_blkg_from_css+0x1cb/0x2c0
 bio_associate_blkg+0x20/0x70
 ? ktime_get+0x3e/0xa0
 linear_map+0x50/0x90 [dm_mod]
 __map_bio+0x3a/0x130 [dm_mod]
 __split_and_process_non_flush+0x190/0x1e0 [dm_mod]
 dm_submit_bio+0x152/0x3b0 [dm_mod]
 submit_bio_noacct+0xfb/0x410
 ? iomap_page_mkwrite_actor+0x70/0x70
 submit_bio+0x43/0x190
 iomap_readahead+0xb5/0x190
 read_pages+0x8e/0x270
 page_cache_ra_unbounded+0x1a2/0x220
 generic_file_buffered_read+0x1a9/0x9b0
 xfs_file_buffered_aio_read+0x44/0xb0 [xfs]
 xfs_file_read_iter+0x6e/0xd0 [xfs]
 new_sync_read+0x118/0x1a0
 vfs_read+0xf1/0x180
 ksys_read+0x59/0xd0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9


and another one:

list_add corruption. next->prev should be prev (ffffffff8bba9840), but was =
0000000000000000. (next=3Dffff9b12c9ce1b10).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:25!
invalid opcode: 0000 [#1] SMP PTI
CPU: 1 PID: 11618 Comm: qtdeclarative-n Not tainted 5.10.0-0.bpo.3-amd64 #1=
 Debian 5.10.13-1~bpo10+1
Hardware name: Intel Corporation S5520HC/S5520HC, BIOS S5500.86B.01.00.0059=
=2E082320111421 08/23/2011
RIP: 0010:__list_add_valid.cold.0+0x12/0x28
Code: 80 46 52 8b 48 89 ef e8 62 3e 01 00 48 c7 c0 f0 ff ff ff e9 bb 1e bf =
ff 48 89 d1 48 c7 c7 f8 46 52 8b 48 89 c2 e8 02 2a ff ff <0f> 0b 48 89 c1 4=
c 89 c6 48 c7 c7 50=20

RSP: 0018:ffffbab42038b580 EFLAGS: 00010046
RAX: 0000000000000075 RBX: ffff9b1629c18268 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff9b1bbfa18a00 RDI: ffff9b1bbfa18a00
RBP: ffff9b1629c18278 R08: 0000000000000000 R09: c0000000ffffdfff
R10: 0000000000000001 R11: ffffbab42038b390 R12: ffff9b12c9ce1b10
R13: ffffffff8bba9840 R14: 0000000000000006 R15: 0000000000002800
FS:  00007f9f93fb2740(0000) GS:ffff9b1bbfa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9f9385dbc0 CR3: 000000082c1f8001 CR4: 00000000000206e0
Call Trace:
 __percpu_counter_init+0x64/0xa0
 blkg_rwstat_init+0x3c/0xb0
 throtl_pd_alloc+0x63/0x230
 blkg_alloc+0x134/0x180
 blkg_create+0x232/0x320
 ? find_busiest_group+0x41/0x360
 bio_associate_blkg_from_css+0x1cb/0x2c0
 bio_associate_blkg+0x20/0x70
 ? ktime_get+0x3e/0xa0
 linear_map+0x50/0x90 [dm_mod]
 __map_bio+0x3a/0x130 [dm_mod]
 __split_and_process_non_flush+0x190/0x1e0 [dm_mod]
 dm_submit_bio+0x152/0x3b0 [dm_mod]
 submit_bio_noacct+0xfb/0x410
 submit_bio+0x43/0x190
 ? bio_add_page+0x62/0x90
 _xfs_buf_ioapply+0x2af/0x410 [xfs]
[...]


and a 3rd one without xfs involved

list_add corruption. next->prev should be prev (ffffffffa4ba9840), but was =
0000000000000000. (next=3Dffff95071f379310).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:25!
invalid opcode: 0000 [#1] SMP PTI
CPU: 21 PID: 12894 Comm: vgs Not tainted 5.10.0-0.bpo.3-amd64 #1 Debian 5.1=
0.13-1~bpo10+1
Hardware name: Intel Corporation S5520HC/S5520HC, BIOS S5500.86B.01.00.0059=
=2E082320111421 08/23/2011
RIP: 0010:__list_add_valid.cold.0+0x12/0x28
Code: 80 46 52 a4 48 89 ef e8 62 3e 01 00 48 c7 c0 f0 ff ff ff e9 bb 1e bf =
ff 48 89 d1 48 c7 c7 f8 46 52 a4 48 89 c2 e8 02 2a ff ff <0f> 0b 48 89 c1 4=
c 89 c6 48 c7 c7 50 47 52 a4 e8 ee 29 ff ff 0f 0b
RSP: 0018:ffffad41c741fa80 EFLAGS: 00010046
RAX: 0000000000000075 RBX: ffff95071f379268 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff950dffc98a00 RDI: ffff950dffc98a00
RBP: ffff95071f379278 R08: 0000000000000000 R09: c0000000ffffdfff
R10: 0000000000000001 R11: ffffad41c741f890 R12: ffff95071f379310
R13: ffffffffa4ba9840 R14: 0000000000000006 R15: 0000000000002800
FS:  00007f320ee69900(0000) GS:ffff950dffc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f320f844000 CR3: 0000000f68ffe004 CR4: 00000000000206e0
Call Trace:
 __percpu_counter_init+0x64/0xa0
 blkg_rwstat_init+0x3c/0xb0
 throtl_pd_alloc+0x63/0x230
 blkg_alloc+0x134/0x180
 blkg_create+0x232/0x320
 bio_associate_blkg_from_css+0x1cb/0x2c0
 bio_associate_blkg+0x20/0x70
 blkdev_direct_IO+0x233/0x490
 ? aio_fsync_work+0x2c0/0x2c0
 generic_file_read_iter+0x92/0x150
 aio_read+0xf9/0x1a0
 ? io_submit_one+0x185/0xbc0
 io_submit_one+0x185/0xbc0
 ? __fsnotify_parent+0x105/0x320
 ? __fsnotify_parent+0x115/0x320
 ? __x64_sys_io_submit+0xa6/0x1a0
 __x64_sys_io_submit+0xa6/0x1a0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The system is a Intel(R) Xeon(R) CPU E5649 @ 2.53GHz with ECC RAM and
runs now stable on v4.19.

Is this a know (or even fixed problem?) Any ideas how to debug this?
I'll ask my admins to compile latest v5.10 and give it a try. As this is
one of our production machines testing is a bit limited.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jzlbobv35ppxbtc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBGDyIACgkQqclaivrt
76kVGAgAlxKYLdh9mCM+PrxqY3W28caYwtySex68c3heo1jcZml1x062nvQcJkyP
H1mwIqNOyyy0UM5ED6rntWD7mH0rPwCU5EWcg33PwmVtwJquMziJURq2OsSUwr+h
QplOrVRMrTN3jKEHTYm68f81xJovGqlXQLhgqdhE9fm3tNrvgQMRqoVklX13kLlA
KeN7igIov8LxjZfDbwSC8rv2HJ5j8BuAZ+X4rs9oOJ3E91kKZxmw0b5FZBFwNjlv
UBKrXn06Y8nRHyqHPGbNrVfv68AeQi1TPX7g0iBhGX+ygmqm9TanRL67afxFojnE
qn+uSoLeUd27K5YCDQMhpL7n+zN/dw==
=BCqC
-----END PGP SIGNATURE-----

--jzlbobv35ppxbtc7--
