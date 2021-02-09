Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B231548C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhBIRAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:00:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:33424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhBIRAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:00:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1899CAD29;
        Tue,  9 Feb 2021 16:59:51 +0000 (UTC)
Message-ID: <0e668a563a66486e1c293a856ab77ae11658aefe.camel@suse.de>
Subject: Re: [PATCH] staging: bcm2835-audio: Replace unsafe strcpy() with
 strscpy()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        gregkh@linuxfoundation.org
Cc:     f.fainelli@gmail.com, sbranden@broadcom.com, rjui@broadcom.com,
        Juerg Haefliger <juergh@canonical.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 09 Feb 2021 17:59:49 +0100
In-Reply-To: <20210205072502.10907-1-juergh@canonical.com>
References: <20210205072502.10907-1-juergh@canonical.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fLxcpaZkAhhjqXtnFjfs"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fLxcpaZkAhhjqXtnFjfs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-02-05 at 08:25 +0100, Juerg Haefliger wrote:
> Replace strcpy() with strscpy() in bcm2835-audio/bcm2835.c to prevent the
> following when loading snd-bcm2835:
>=20
> [   58.480634] ------------[ cut here ]------------
> [   58.485321] kernel BUG at lib/string.c:1149!
> [   58.489650] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [   58.495214] Modules linked in: snd_bcm2835(COE+) snd_pcm snd_timer snd=
 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua btsdio bluetooth ecdh_g=
eneric ecc bcm2835_v4l2(CE) bcm2835_codec(CE) brcmfmac bcm2835_isp(CE) bcm2=
835_mmal_vchiq(CE) brcmutil cfg80211 v4l2_mem2mem videobuf2_vmalloc videobu=
f2_dma_contig videobuf2_memops raspberrypi_hwmon videobuf2_v4l2 videobuf2_c=
ommon videodev bcm2835_gpiomem mc vc_sm_cma(CE) rpivid_mem uio_pdrv_genirq =
uio sch_fq_codel drm ip_tables x_tables autofs4 btrfs blake2b_generic raid1=
0 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xo=
r_neon raid6_pq libcrc32c raid1 raid0 multipath linear dwc2 roles spidev ud=
c_core crct10dif_ce xhci_pci xhci_pci_renesas phy_generic aes_neon_bs aes_n=
eon_blk crypto_simd cryptd
> [   58.563787] CPU: 3 PID: 1959 Comm: insmod Tainted: G         C OE     =
5.11.0-1001-raspi #1
> [   58.572172] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
> [   58.578086] pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=3D--)
> [   58.584178] pc : fortify_panic+0x20/0x24
> [   58.588161] lr : fortify_panic+0x20/0x24
> [   58.592136] sp : ffff800010a83990
> [   58.595491] x29: ffff800010a83990 x28: 0000000000000002
> [   58.600879] x27: ffffb0b07cb72928 x26: 0000000000000000
> [   58.606268] x25: ffff39e884973838 x24: ffffb0b07cb74190
> [   58.611655] x23: ffffb0b07cb72030 x22: 0000000000000000
> [   58.617042] x21: ffff39e884973014 x20: ffff39e88b793010
> [   58.622428] x19: ffffb0b07cb72670 x18: 0000000000000030
> [   58.627814] x17: 0000000000000000 x16: ffffb0b092ce2c1c
> [   58.633200] x15: ffff39e88b901500 x14: 0720072007200720
> [   58.638588] x13: 0720072007200720 x12: 0720072007200720
> [   58.643979] x11: ffffb0b0936cbdf0 x10: 00000000fffff000
> [   58.649366] x9 : ffffb0b09220cfa8 x8 : 0000000000000000
> [   58.654752] x7 : ffffb0b093673df0 x6 : ffffb0b09364e000
> [   58.660140] x5 : 0000000000000000 x4 : ffff39e93b7db948
> [   58.665526] x3 : ffff39e93b7ebcf0 x2 : 0000000000000000
> [   58.670913] x1 : 0000000000000000 x0 : 0000000000000022
> [   58.676299] Call trace:
> [   58.678775]  fortify_panic+0x20/0x24
> [   58.682402]  snd_bcm2835_alsa_probe+0x5b8/0x7d8 [snd_bcm2835]
> [   58.688247]  platform_probe+0x74/0xe4
> [   58.691963]  really_probe+0xf0/0x510
> [   58.695585]  driver_probe_device+0xe0/0x100
> [   58.699826]  device_driver_attach+0xcc/0xd4
> [   58.704068]  __driver_attach+0xb0/0x17c
> [   58.707956]  bus_for_each_dev+0x7c/0xd4
> [   58.711843]  driver_attach+0x30/0x40
> [   58.715467]  bus_add_driver+0x154/0x250
> [   58.719354]  driver_register+0x84/0x140
> [   58.723242]  __platform_driver_register+0x34/0x40
> [   58.728013]  bcm2835_alsa_driver_init+0x30/0x1000 [snd_bcm2835]
> [   58.734024]  do_one_initcall+0x54/0x300
> [   58.737914]  do_init_module+0x60/0x280
> [   58.741719]  load_module+0x680/0x770
> [   58.745344]  __do_sys_finit_module+0xbc/0x130
> [   58.749761]  __arm64_sys_finit_module+0x2c/0x40
> [   58.754356]  el0_svc_common.constprop.0+0x88/0x220
> [   58.759216]  do_el0_svc+0x30/0xa0
> [   58.762575]  el0_svc+0x28/0x70
> [   58.765669]  el0_sync_handler+0x1a4/0x1b0
> [   58.769732]  el0_sync+0x178/0x180
> [   58.773095] Code: aa0003e1 91366040 910003fd 97ffee21 (d4210000)
> [   58.779275] ---[ end trace 29be5b17497bd898 ]---
> [   58.783955] note: insmod[1959] exited with preempt_count 1
> [   58.791921] ------------[ cut here ]------------
>=20
> For the sake of it, replace all the other occurences of strcpy() under
> bcm2835-audio/ as well.
>=20
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-fLxcpaZkAhhjqXtnFjfs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAiv4UACgkQlfZmHno8
x/5/cgf/fDhNsIG/c2vI1L3FhLgIMZu+/WsS6QXWJzYZrXzvUb9uQCXmSmOkBQ1X
23M26eXsyx9zhxDs00h/lmuVZ8YZSqgo5rLtwAcLU2Q6p6MJFZdwfR8Cik1bEf7R
cPom7MA5leJ5TxhGrYDGoFkAbnhg/bTq9o88oeEHuAjfND8Wf5VnANwsAIp0LDvu
xP4Dwupgt+hYXiA8nl7bCjnIvH41uoGp1xI/bqJ1bYuTU0c26VP+401BEOXsLrjz
1sEPX5rp4wh/Go1KCLHsd3fXISaMJCy533PD5kyN7kYiISm7CPu888/QxZkcJCbI
MXLXkhtAvtyMjxI9mcEUt6Abz5XFHQ==
=ciXP
-----END PGP SIGNATURE-----

--=-fLxcpaZkAhhjqXtnFjfs--

