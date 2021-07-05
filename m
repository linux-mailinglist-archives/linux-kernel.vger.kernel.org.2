Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC9B3BC14E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 18:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhGEQEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 12:04:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:32843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhGEQEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625500860;
        bh=uVp3GwSwAmdwySaZ7yQaqPvJ0DdZ2cEJTxZIeGe5vtA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=iO4pnOUe9HjXXviWrVgfoCmYi2z+Q38+m+VdILSjCeTI1u1HHxsbFspzyJD9jzTn2
         pqdZ4ZfjaW/C+U8xHHG2vJY52PobI9Si/4gqTNfSlBVzK1VdDqyCQ4g3HJZlt1kDUh
         Qj9dEojhDReGfbDLoJ3HC1oB57Do/gAGx6dQQEow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.12]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1lmV4h2emZ-00Mqf9; Mon, 05
 Jul 2021 18:01:00 +0200
Message-ID: <206d6a81e08cb23a2c97e67335be6017e938bac5.camel@gmx.de>
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Date:   Mon, 05 Jul 2021 18:00:58 +0200
In-Reply-To: <20210702182944.lqa7o2a25to6czju@linutronix.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
         <20210702182944.lqa7o2a25to6czju@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g7W42PyyjLey67JhaWKQoU6QGXH2//AO9VgZ6m7h9RSj1gtSJ4e
 d/D11By1RHblBVBixQVuA8BXw/JTyZatGgzWGsj4mZAPH+ft/v6sLllQW6+oVtETx2NMAgU
 /tXqtQo4gL8nfKLNyvgf7T2ydxZ1BGIKaHYeB2Cw1guAvp8RHzoHnXJpsJdSoOdO9FfCnwU
 oyLPj8u1j5l7Hqjybm66w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QDPxW+tJqGI=:u88Ux3Z0nTcGY0KDncvH3g
 bwaPEOxaD4zMfwYzguVWmvs0ucj7mBAz1RtM7DOFwvRtnpywG+IUOm4TzUstly94tNAWbSth3
 Ufmm0K6SkC8bRFaam+DyI+Rwo3A8RLhY1J6+OEQJ6ojnwfHYcy35LPYCV5pQgJcBH4LXV3DPT
 w8s+jAey0a4usCuR54ReTj+RblLLa+U1u0DprPh8wKq2u3MHTvi/RvkENsW3S/noHEs4icw/r
 6AoyiK9TUTkVnPWWIkzPOCzBO1/RUrlhIEKINw22x0uthuQ4bx+Ebibg/ajhL5crbZIC96o+G
 8QcJeIiLu/Y+8zliq4i9NAeDJFf+Q0l52UeSvw2dC/+OClcNhHwvvB4y6EBRg632K3NxIWlvL
 5skDjQCyelDNZhM0EeQPlA5xt/TsTf/eP3prWB4eAUt1plJriu8g1yijzaVeCxQYKwfIzYyah
 gZHmr800NPNRcJNoIlpNGGiAc4RChjVUlERx9whF5Mqp03ECfvLrHpQxnrRvPy+SiRDGNx7W6
 kgXHZIBauy/pWFDUUYxwPCl0ZMVO3djliMEIa1tVM+hle9JowhMnxfQGmKymtgU1ibNBA1Ze+
 Mp+vXuKG9ehw+rlRWCwjWFU9hpWtqxvQUEm6gQSFMSTZyGZAwNgjk5k2SEyx9BViY9xVpDLht
 FVa0UXDxOqhvNctgGb0lxdUqBzk7FKNUpungo6u3+s3B3a+YNW1C37a/rHHmvknHU2br356E0
 jJDxB2iY4+g01CcoEqDiwBMdhbvYL+FxDVmOSA1DQ6CCDHuPFzlbhY5hgleRXWXhCXDC/wjPP
 WIDtkdSgwxILNo8gulYGX6DPaQApAI4TY1u9hlcVBqASz8sjj8UUVXEFGhyDCoUeejyTtyyNA
 fNKms6y4jMU/P9fxFziYIi1FFrMclOvgmax2qMCOq27s1w/jCIk4wkZfZ286j57JNY7dk3iux
 2GbqI49HAGQEFVhy5pP1Jyu73mdJx/COxP4dAYPYXMPriQVSG3AAE5kRtnPCAAziBU7Q3xpIZ
 TBw6DsQklC3jrX2GYRkMPlcdtZMok+4XrAmFMaugaD6ynLEtw8lPFyh2HzV3o2B1MZrIvBv9y
 7kuZ5jyPSQykn1dFYFdDKpOkaHgpQq19STn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-07-02 at 20:29 +0200, Sebastian Andrzej Siewior wrote:
> =20
> > The remaining patches to upstream from the RT tree are small ones
> > related to KConfig. The patch that restricts PREEMPT_RT to SLUB
> > (not SLAB or SLOB) makes sense. The patch that disables
> > CONFIG_SLUB_CPU_PARTIAL with PREEMPT_RT could perhaps be re-
> > evaluated as the series also addresses some latency issues with
> > percpu partial slabs.
>=20
> With that series the PARTIAL slab can be indeed enabled. I have (had)
> a half done series where I had PARTIAL enabled and noticed a slight
> increase in latency so made it "default y on !RT". It wasn't dramatic
> but appeared to be outside of noise.

I'm seeing warnings/explosions while exercising box IFF PARTIAL slab
thingy is enabled.  I aborted -PARTIAL after a little over 4 hours,
whereas the longest survival of 4 +PARTIAL runs was 50 minutes, so I'm
fairly confident that PARTIAL really really is the trigger.

My reproducer is a keep box busy loop of parallel kbuild along with
alternating ltp::controllers (sans swap-from-hell bits), ltp::zram and
hackbench.

The warning may or may not trigger before box explodes.
  =20
[  224.232200] ------------[ cut here ]------------
[  224.232202] WARNING: CPU: 3 PID: 9112 at mm/slub.c:2018 ___slab_alloc.co=
nstprop.100+0xb09/0x13a0
[  224.232210] Modules linked in: sr_mod(E) cdrom(E) zram(E) btrfs(E) blake=
2b_generic(E) xor(E) raid6_pq(E) xfs(E) libcrc32c(E) af_packet(E) ip6table_=
mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft=
(E) iscsi_boot_sysfs(E) nfnetlink(E) ebtable_filter(E) rfkill(E) ebtables(E=
) ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E) x_tables(=
E) bpfilter(E) joydev(E) usblp(E) intel_rapl_msr(E) intel_rapl_common(E) nl=
s_iso8859_1(E) nls_cp437(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) cor=
etemp(E) kvm_intel(E) kvm(E) snd_hda_codec_realtek(E) snd_hda_codec_generic=
(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) irqbypass(E) crct10dif_pclmul(E)=
 crc32_pclmul(E) ghash_clmulni_intel(E) snd_hda_intel(E) aesni_intel(E) snd=
_intel_dspcfg(E) crypto_simd(E) iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap=
_i2c(E) mei_hdcp(E) iTCO_vendor_support(E) cryptd(E) snd_hda_codec(E) snd_h=
wdep(E) pcspkr(E) i2c_i801(E) snd_hda_core(E) i2c_smbus(E) r8169(E) snd_pcm=
(E) realtek(E) snd_timer(E)
[  224.232253]  mei_me(E) mdio_devres(E) lpc_ich(E) snd(E) libphy(E) mei(E)=
 soundcore(E) mfd_core(E) fan(E) thermal(E) nfsd(E) intel_smartconnect(E) a=
uth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sch_fq_codel(E) sunrpc(E) fuse(E=
) configfs(E) hid_logitech_hidpp(E) hid_logitech_dj(E) uas(E) usb_storage(E=
) hid_generic(E) usbhid(E) nouveau(E) wmi(E) drm_ttm_helper(E) ttm(E) i2c_a=
lgo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_=
sys_fops(E) cec(E) ahci(E) rc_core(E) xhci_pci(E) ehci_pci(E) libahci(E) xh=
ci_hcd(E) ehci_hcd(E) drm(E) libata(E) usbcore(E) video(E) button(E) sd_mod=
(E) t10_pi(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_ring(E) vi=
rtio(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) sg(E) dm_multip=
ath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E)=
 msr(E) autofs4(E)
[  224.232295] CPU: 3 PID: 9112 Comm: dd Kdump: loaded Tainted: G          =
  E     5.13.0.g60ab3ed-tip-rt-slub #25
[  224.232297] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  224.232299] RIP: 0010:___slab_alloc.constprop.100+0xb09/0x13a0
[  224.232302] Code: 48 8b 7d 88 4c 89 ee 8b 47 28 4c 01 f8 48 89 c2 48 0f =
ca 48 33 97 b8 00 00 00 48 33 10 e8 cf e5 ff ff e9 b5 00 00 00 4d 89 ce <0f=
> 0b e9 2d fa ff ff 8b 53 38 8b 05 8f 47 4a 01 48 8b 75 80 83 c2
[  224.232303] RSP: 0018:ffff8882047e3ba0 EFLAGS: 00010046
[  224.232305] RAX: ffff888100040f80 RBX: 0000000000000000 RCX: 00000000801=
90019
[  224.232307] RDX: ffffea0005d59a08 RSI: 0000000000000000 RDI: ffffffff817=
7ab54
[  224.232308] RBP: ffff8882047e3c70 R08: ffffffffffffffff R09: 00000000000=
00000
[  224.232309] R10: ffff8882047e3c90 R11: 0000000000000000 R12: ffffea0004d=
60780
[  224.232310] R13: 0000000000000019 R14: 0000000000000000 R15: 00000000801=
90019
[  224.232311] FS:  00007f88ffa09580(0000) GS:ffff88840ecc0000(0000) knlGS:=
0000000000000000
[  224.232312] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  224.232313] CR2: 00007f88ffa4a000 CR3: 000000015606a005 CR4: 00000000001=
706e0
[  224.232315] Call Trace:
[  224.232318]  ? __alloc_file+0x26/0xf0
[  224.232322]  ? prep_new_page+0xab/0x100
[  224.232326]  ? __alloc_file+0x26/0xf0
[  224.232329]  ? __slab_alloc.isra.87.constprop.99+0x2e/0x40
[  224.232331]  __slab_alloc.isra.87.constprop.99+0x2e/0x40
[  224.232333]  ? __alloc_file+0x26/0xf0
[  224.232335]  kmem_cache_alloc+0x4d/0x160
[  224.232338]  __alloc_file+0x26/0xf0
[  224.232340]  alloc_empty_file+0x43/0xe0
[  224.232343]  path_openat+0x35/0xe30
[  224.232345]  ? getname_flags+0x32/0x170
[  224.232347]  ? ___slab_alloc.constprop.100+0xbbb/0x13a0
[  224.232349]  ? filemap_map_pages+0xf0/0x3e0
[  224.232352]  do_filp_open+0xa2/0x100
[  224.232355]  ? __slab_alloc.isra.87.constprop.99+0x36/0x40
[  224.232357]  ? __slab_alloc.isra.87.constprop.99+0x36/0x40
[  224.232359]  ? getname_flags+0x32/0x170
[  224.232361]  ? alloc_fd+0xe2/0x1b0
[  224.232363]  ? do_sys_openat2+0x248/0x310
[  224.232365]  do_sys_openat2+0x248/0x310
[  224.232368]  do_sys_open+0x47/0x60
[  224.232370]  do_syscall_64+0x37/0x80
[  224.232373]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  224.232376] RIP: 0033:0x7f88ff54ab41
[  224.232378] Code: 41 83 e2 40 48 89 54 24 30 75 3e 89 f0 25 00 00 41 00 =
3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48=
> 3d 00 f0 ff ff 77 3f 48 8b 4c 24 18 64 48 33 0c 25 28 00 00 00
[  224.232379] RSP: 002b:00007ffc0916a720 EFLAGS: 00000287 ORIG_RAX: 000000=
0000000101
[  224.232381] RAX: ffffffffffffffda RBX: 0000558d793efcf0 RCX: 00007f88ff5=
4ab41
[  224.232382] RDX: 0000000000080000 RSI: 0000558d793efcb0 RDI: 00000000fff=
fff9c
[  224.232383] RBP: 00007ffc0916a860 R08: 0000000000000000 R09: 00007ffc091=
6a873
[  224.232384] R10: 0000000000000000 R11: 0000000000000287 R12: 0000558d793=
efa88
[  224.232385] R13: 000000000000000b R14: 0000558d793efa60 R15: 00000000000=
0000b
[  224.232387] ---[ end trace 0000000000000002 ]---
...
[ 2010.420941] general protection fault, maybe for address 0xffffea00054ca3=
98: 0000 [#1] PREEMPT_RT SMP NOPTI
[ 2010.420946] CPU: 4 PID: 17541 Comm: dd Kdump: loaded Tainted: G        W=
   E     5.13.0.g60ab3ed-tip-rt-slub #25
[ 2010.420948] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 2010.420949] RIP: 0010:___slab_alloc.constprop.100+0x52b/0x13a0
[ 2010.420955] Code: b7 44 24 2a 31 db 66 25 ff 7f 66 89 45 b8 48 8b 45 88 =
80 4d bb 80 48 8b 4d b8 f6 40 0b 40 0f 84 5b 02 00 00 48 89 f0 4c 89 fa <f0=
> 49 0f c7 4c 24 20 0f 84 8f 01 00 00 4d 89 ce f3 90 48 8b b5 30
[ 2010.420957] RSP: 0018:ffff888102cf7ba0 EFLAGS: 00010002
[ 2010.420959] RAX: ffff888100047e00 RBX: 0000000000000000 RCX: 00000000800=
00000
[ 2010.420961] RDX: 0000000000000000 RSI: ffff888100047e00 RDI: ffff8881000=
40f80
[ 2010.420962] RBP: ffff888102cf7c70 R08: ffffffffffffffff R09: 00000000000=
00000
[ 2010.420963] R10: ffff888102cf7c90 R11: 0000000000000000 R12: ffffea00054=
ca378
[ 2010.420964] R13: 0000000000000000 R14: 80000000000101f8 R15: 00000000000=
00000
[ 2010.420966] FS:  00007f9e8edbb580(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 2010.420967] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2010.420968] CR2: 00007f9e8edfa000 CR3: 0000000102ede004 CR4: 00000000001=
706e0
[ 2010.420970] Call Trace:
[ 2010.420973]  ? __alloc_file+0x26/0xf0
[ 2010.420977]  ? prep_new_page+0xab/0x100
[ 2010.420982]  ? vm_area_alloc+0x1a/0x60
[ 2010.420984]  ? __alloc_file+0x26/0xf0
[ 2010.420987]  ? __slab_alloc.isra.87.constprop.99+0x2e/0x40
[ 2010.420989]  __slab_alloc.isra.87.constprop.99+0x2e/0x40
[ 2010.420992]  ? __alloc_file+0x26/0xf0
[ 2010.420994]  kmem_cache_alloc+0x4d/0x160
[ 2010.420996]  __alloc_file+0x26/0xf0
[ 2010.420999]  alloc_empty_file+0x43/0xe0
[ 2010.421002]  path_openat+0x35/0xe30
[ 2010.421004]  ? getname_flags+0x32/0x170
[ 2010.421006]  ? ___slab_alloc.constprop.100+0xbbb/0x13a0
[ 2010.421008]  ? filemap_map_pages+0xf0/0x3e0
[ 2010.421012]  do_filp_open+0xa2/0x100
[ 2010.421015]  ? __handle_mm_fault+0x8b8/0xa40
[ 2010.421017]  ? __slab_alloc.isra.87.constprop.99+0x36/0x40
[ 2010.421019]  ? __slab_alloc.isra.87.constprop.99+0x36/0x40
[ 2010.421021]  ? getname_flags+0x32/0x170
[ 2010.421023]  ? alloc_fd+0xe2/0x1b0
[ 2010.421026]  ? do_sys_openat2+0x248/0x310
[ 2010.421028]  do_sys_openat2+0x248/0x310
[ 2010.421030]  do_sys_open+0x47/0x60
[ 2010.421033]  do_syscall_64+0x37/0x80
[ 2010.421035]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2010.421039] RIP: 0033:0x7f9e8e8fcb41
[ 2010.421041] Code: 41 83 e2 40 48 89 54 24 30 75 3e 89 f0 25 00 00 41 00 =
3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48=
> 3d 00 f0 ff ff 77 3f 48 8b 4c 24 18 64 48 33 0c 25 28 00 00 00
[ 2010.421043] RSP: 002b:00007ffe8964b7b0 EFLAGS: 00000287 ORIG_RAX: 000000=
0000000101
[ 2010.421044] RAX: ffffffffffffffda RBX: 0000562e1e31b450 RCX: 00007f9e8e8=
fcb41
[ 2010.421045] RDX: 0000000000080000 RSI: 0000562e1e31b230 RDI: 00000000fff=
fff9c
[ 2010.421047] RBP: 00007ffe8964b8f0 R08: 0000000000000000 R09: 00007ffe896=
4b903
[ 2010.421048] R10: 0000000000000000 R11: 0000000000000287 R12: 0000562e1e3=
1b400
[ 2010.421049] R13: 0000000000000009 R14: 0000562e1e31b3e0 R15: 00000000000=
00009
[ 2010.421051] Modules linked in: zram(E) sr_mod(E) cdrom(E) btrfs(E) blake=
2b_generic(E) xor(E) raid6_pq(E) xfs(E) libcrc32c(E) af_packet(E) ip6table_=
mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft=
(E) iscsi_boot_sysfs(E) nfnetlink(E) ebtable_filter(E) rfkill(E) ebtables(E=
) ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E) x_tables(=
E) bpfilter(E) joydev(E) usblp(E) intel_rapl_msr(E) intel_rapl_common(E) nl=
s_iso8859_1(E) nls_cp437(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) cor=
etemp(E) kvm_intel(E) kvm(E) snd_hda_codec_realtek(E) snd_hda_codec_generic=
(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) irqbypass(E) crct10dif_pclmul(E)=
 crc32_pclmul(E) ghash_clmulni_intel(E) snd_hda_intel(E) aesni_intel(E) snd=
_intel_dspcfg(E) crypto_simd(E) iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap=
_i2c(E) mei_hdcp(E) iTCO_vendor_support(E) cryptd(E) snd_hda_codec(E) snd_h=
wdep(E) pcspkr(E) i2c_i801(E) snd_hda_core(E) i2c_smbus(E) r8169(E) snd_pcm=
(E) realtek(E) snd_timer(E)
[ 2010.421093]  mei_me(E) mdio_devres(E) lpc_ich(E) snd(E) libphy(E) mei(E)=
 soundcore(E) mfd_core(E) fan(E) thermal(E) nfsd(E) intel_smartconnect(E) a=
uth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sch_fq_codel(E) sunrpc(E) fuse(E=
) configfs(E) hid_logitech_hidpp(E) hid_logitech_dj(E) uas(E) usb_storage(E=
) hid_generic(E) usbhid(E) nouveau(E) wmi(E) drm_ttm_helper(E) ttm(E) i2c_a=
lgo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_=
sys_fops(E) cec(E) ahci(E) rc_core(E) xhci_pci(E) ehci_pci(E) libahci(E) xh=
ci_hcd(E) ehci_hcd(E) drm(E) libata(E) usbcore(E) video(E) button(E) sd_mod=
(E) t10_pi(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_ring(E) vi=
rtio(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) sg(E) dm_multip=
ath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E)=
 msr(E) autofs4(E) [last unloaded: zram]
[ 2010.421138] Dumping ftrace buffer:
[ 2010.421141]    (ftrace buffer empty)

