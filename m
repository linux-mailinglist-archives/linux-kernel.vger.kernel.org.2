Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78213905C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhEYPpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:45:38 -0400
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:34143 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhEYPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:45:35 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 11:45:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1621957446; x=1622562246;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=iIlRrNaj4YSM3dxuA+FLy4aw59Mp818DmF64mLAQ9Eo=;
  b=l71L1zAvkDS7BKJkWwJcA4JZ4dY4SQU9wjLol9mNHq+rmuvx2jFDXsi3
   BekK0dneYI4VtZtMdk1LpULtbf8+OAboUuUtd+unh76zCSptv6SYiI47a
   aeU1cQzV4X//8HS/0meFCwKFNaGTs3U2BqrSjDII79Pw9nRrjYPe6W/2B
   E=;
IronPort-SDR: VKxNpqiZox759QG3BRkqykruEs/whYDENFKX5VTgnqWJS+F2prLyHRa1kO9QQXQgTaqT0ih8vv
 6r6MMp7ChlbW7PB+iAQfor2Og52+BtlYuQhRePmsOW/kSvCeotEN8xv8SsMKQFa1bxPNSA+V5o
 O5p1N00i9o8pffqG4mYbkgMQvA7PQ63PuedIA16utCXqjIxLTdVhNBuxzJ8h8dXAe6b6s9eUKr
 gLwwTVRYzuPlkQB0hPz91ge6cMRCd8DNeFLdwHQnIsM1DdZcDH59FwrPUZrK3/+3rpw3ReDyuh
 F9k=
Received: from mail-sn1anam02lp2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.49])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 15:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiiYapotQF9zFc/c6Sz30RyVfGYL0ogaLhWrHWc7fZ2t8pzxEwDPvTj8eyj0uG4wzaGnTs53r4SJvu4OxtFXU5LWVfXpkcWeBbbhvCL+CZNAE82k5nm2VgKWBFLHyUfnP15CZemKmUFXqFZrkDcqq9EQ4qfr3QJGcUFEgnG1xqZZlyhDyoIHNxKQ9hcYXghxkOxmG1BnOfI8f8VBzxDc06cQJRXvLTT2OszLJ6gcNDNdusnySRI6lHLvhemOvCMstrGqyscrPH888g5Tj1qDER7w846CS2Ejq/Kza72MLgBtzpddii9sasLojHEBNzSOqadLSPl+TO1LQr6B4DzI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3KvhoZCPhw4BJwt+Lkcc3NTbXQVwSQiASy+AU9QEEU=;
 b=nD5kaJClcOaP+51RCgEbjRHfeNM3fdLMc5oBNsw/1dV50u6zDdJsY8uvF7lHidX7nJewFH/gUaGmHphaHBEX2ZwUUDpU3Nn0YFmf8vLVVcgKYAUZiuRxiOaAMFChzbAW7c2ECPYmlqF8jcKkz2te4goJz0jce1JdC7h30idViuLBrWTKnGxfJ+I/Xl0Qv7LbQ//z9UJdPRFB0nArYcoWDnXFOFYdWw3JUNb18l3GPr48zbjccgUUp9+8zHhMOwj7bBZ5zDNebXZFh3pjzwUMiLE8Qh7yEeOPHKW6Ucdm6aAeQ/flZ2NEksAKdugGzUxdlTs1PH0tG/vATEr6odsKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM5PR0201MB3557.namprd02.prod.outlook.com (2603:10b6:4:7f::24)
 by DM6PR02MB4202.namprd02.prod.outlook.com (2603:10b6:5:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 15:36:56 +0000
Received: from DM5PR0201MB3557.namprd02.prod.outlook.com
 ([fe80::5dd9:4dea:abee:1800]) by DM5PR0201MB3557.namprd02.prod.outlook.com
 ([fe80::5dd9:4dea:abee:1800%3]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 15:36:56 +0000
From:   "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Arm64 crash while online/offline memory sections
Thread-Topic: Arm64 crash while online/offline memory sections
Thread-Index: AddRetGCwamVTZ1PQ4mClPUkiBXM1g==
Date:   Tue, 25 May 2021 15:36:55 +0000
Message-ID: <DM5PR0201MB35576EF9B568FEE05FE58CF08E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [163.116.135.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74dc43c6-1ef8-419a-565d-08d91f92ed8e
x-ms-traffictypediagnostic: DM6PR02MB4202:
x-microsoft-antispam-prvs: <DM6PR02MB4202C285741BF09F4B97B042F2259@DM6PR02MB4202.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0H2CQtTX3+jTEZEZbZ+psiPj5AzzLbg1i77x2Uyj+LRpwq/fwXHlNxuebETrIXSNpdtV1/edR9Ytqa8x8/siLIpvENUU9KP7IzlgP/AccRdLi+iz+CIHhZe4uzFG1zHGSKNxPviJKfiZeD6k2okCpScBcH6r0m9I3LW0iUClTEaSlH4/CYfh5SnUr8DjHcAAYsJX2f4yaDUynAYEsPS1Uz+31vdMB+F5PYxZhayGBLSrBwXOqX7S/8rMu48JPox+vhW04dVXGBQ5qD2dLR33KynhkWec12zaFHndWYPh+DQLbdDI/wYlVV1bcTxVei+43EZ+SUvxtrHygXgB4n/5WTwjgBh/BXaiJWIKF+5aTZOEMjkmlB+fqye6go9B2afEDOlBw9/FB2HkLQRnL4kDmk7lukeEoD1s5qHYYtMqNtj4bA6oWH0TY3JtzhjdGqPSATYrtboZJWcPauG+1u2d2AE7pGQQ4K0lnOgeAT1ek4QVrA1f+ItFNOUtsISe2zR9l19jsA6d51K6FedNKwmFKrQf9ndGNrXCvFVh8x7umaXes71okEMXtxRhp0TvffTpjpC6Se9z3rGvP720rMaZm7qK18uiQdpe2r9uZc27NZSgTwTCccjxaZCX4sPeZ+/aRZvrJDp02Yk4N/M47XjvK/9XAQn4WLvhGMAEDN0Pqzga14vWY54235iYMN4TsD0HuK6NbFOrJIu5IObJY6XACRoHa6pCzSYUhcY18hENo5U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0201MB3557.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(8936002)(966005)(6916009)(86362001)(66446008)(38100700002)(64756008)(2906002)(52536014)(66476007)(55016002)(26005)(45080400002)(122000001)(5660300002)(54906003)(66946007)(186003)(6506007)(76116006)(33656002)(9686003)(7696005)(316002)(4326008)(83380400001)(71200400001)(66556008)(478600001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TgnYbFUYTmDQJdSeIRMZQw6/bicAWseVvWk4tBt5UFWwuNQkM9CNC59GkPsb?=
 =?us-ascii?Q?LCIIxPK55X4zoGG7rCRnPSt2uGgEyOQBUSk8EdpWx8GFWhGRq4y3pnBb7RNS?=
 =?us-ascii?Q?5yRqGH+49os4yWOGBCpzqfL1m+rbe+enWPzigAPPAw4hRQfU2j3wTB+R4zMb?=
 =?us-ascii?Q?lntPgjGjtAth1z8eB3J/ijV4ZZvFqOSlT4+ujBF6gyPVEHgrh9HQ0+IDo9Kg?=
 =?us-ascii?Q?XXChiv/ZdadxgnsWgLjvvroVzBHAIhMwbS2OZ/e/7aCRPhyRe0vJ+mKQ/qtl?=
 =?us-ascii?Q?W4S5sKPCSUHpnZnEAF9Vj6YohpsKAn138KHeg/g7zZ4MOhx73czohpYp2GgY?=
 =?us-ascii?Q?tqTbkSsVKBZHhBz3W3m7O/BnDvyI8jFmLuUq8M8pL5fWDtmcSmmMzTB2Bg5x?=
 =?us-ascii?Q?9y1iWWnDEryqYuvjAUSpM1l4jKOfWTuexPqMrsei0NYMLeMvUdaU3sjVtXEI?=
 =?us-ascii?Q?LIE35ZiYOHzfgRIoJzwtYQiZoRF4QRlYHPziota6791qY0oczXvRRRKDzBlV?=
 =?us-ascii?Q?4m/5xGqFaEru09y8r8YeyF9jDp4hcgAEEbYpSwE9aNuMLSoJkWqAXDpESt1S?=
 =?us-ascii?Q?y9q9Ks2PIddlSX4ERevCurg/1ES47Y0oK3m/Gpm+VRIk7P1zkJPduwzcPc0J?=
 =?us-ascii?Q?oidOBKSXILZGHHi+pro2MRpR8Z/pN6XkVg2bGd6Q4H5UCHRXwusEvlza4Ujf?=
 =?us-ascii?Q?YBLnm9BGK1Yh0p0NM07vyMVCDpF/az0UbzHVxIQIxZrkuoO2D3/6ggl0FXc4?=
 =?us-ascii?Q?j6zeTtLLSmrtb+N13Yg9F0ckQKXryWzGG/Fw1BqRX5gPD0nfLSXza681bCXD?=
 =?us-ascii?Q?SBhwGUS+4rqqiLEF4lYdGqCZNE5OyAp6mYo6LZg4rPqk+8+nYtK3X6X9nQON?=
 =?us-ascii?Q?FNTtnUVwQR8139WT6r7VI0/SiDxuslSf86NE6Da/HjO2m/kJzJinq4DGpR5N?=
 =?us-ascii?Q?5xATY6zBAYPpZbb3dIefYO9bkR6K+bNsTBiVfzuG?=
x-ms-exchange-antispam-messagedata-1: 1AGrfNV5O0NKFIpJyfDIr1DTHrYHwhRjnjK+VZ0Lk3QYHEGDHoyfXDdw31uDyaRk4nihDxawNVxddSIbwLDE73YZUfibkz+5h6dvUE0yWrp64dTMKx4sWy8WdBMpQ+47HAQa9wSRBdUsp9BidWYgx7UICfEq8w2hT/iJa2IApKow1XpR7Woa/o+zYg/YPs7tui8TVdZzTkHE7GtsfsZARRzvZVmx5J9ZSjqi/D0KUsMCAUeNUIWQgXHNrV02dv+WFjtiIaWcY/z0Wq3QCLhBwug6FX9JOuyPlGlmoKm9lx8UaQW6MjMu9JTW9OPCYCCsMVn8jS/tSSqBwaRXhrzoho2p
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0201MB3557.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dc43c6-1ef8-419a-565d-08d91f92ed8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 15:36:55.8831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1xUiKUzIAKYMuNMBboApJCyF1P335UFI5VOY3/culTXt12AriGBrP+wc9MfxGZG4sDfheJR7bfbMopBsQR/xxWm4rBwwtaefEFSk2IFtxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4202
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reverting the patchset "Allocate memmap from hotadded memory (per device)" =
[1] from today's linux-next fixed a crash while online/offline memory secti=
ons.

[1] https://lore.kernel.org/linux-mm/20210421102701.25051-1-osalvador@suse.=
de/

[  162.327720][ T1694] kernel BUG at include/linux/mm.h:1383!
[  162.333695][ T1694] Internal error: Oops - BUG: 0 [#1] SMP
[  162.339181][ T1694] Modules linked in: loop processor efivarfs ip_tables=
 x_tables ext4 mbcache jbd2 dm_mod igb nvme i2c_algo_bit mlx5_core i2c_core=
 nvme_core firmware_class
[  162.354604][ T1694] CPU: 13 PID: 1694 Comm: ranbug Not tainted 5.12.0-ne=
xt-20210524+ #4
[  162.362601][ T1694] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR=
, BIOS 1.6 06/28/2020
[  162.371116][ T1694] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=3D-=
-)
[  162.377811][ T1694] pc : memory_subsys_offline+0x1f8/0x250
[  162.383295][ T1694] lr : memory_subsys_offline+0x1f8/0x250
[  162.388773][ T1694] sp : ffff80002458f8e0
[  162.392773][ T1694] x29: ffff80002458f8e0 x28: ffff800010914d30 x27: 000=
0000000000000
[  162.400602][ T1694] x26: 0000000000002000 x25: 1fffe00002550401 x24: fff=
f000012a82008
[  162.408431][ T1694] x23: fffffc0000000000 x22: 0000000000008000 x21: 000=
0000000000001
[  162.416259][ T1694] x20: ffffffffffffffff x19: ffff000012a82018 x18: fff=
f0008527b6a70
[  162.424086][ T1694] x17: 0000000000000000 x16: 0000000000000007 x15: 000=
00000000000c8
[  162.431914][ T1694] x14: 0000000000000000 x13: ffff800011c6eea4 x12: fff=
f60136ceb8574
[  162.439742][ T1694] x11: 1fffe0136ceb8573 x10: ffff60136ceb8573 x9 : dff=
f800000000000
[  162.447570][ T1694] x8 : ffff009b675c2b9b x7 : 0000000000000001 x6 : fff=
f009b675c2b98
[  162.455398][ T1694] x5 : 00009fec93147a8d x4 : ffff009b675c2b98 x3 : 1ff=
fe0010a4f6c09
[  162.463226][ T1694] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000=
0000000000034
[  162.471054][ T1694] Call trace:
[  162.474186][ T1694]  memory_subsys_offline+0x1f8/0x250
[  162.479318][ T1694]  device_offline+0x154/0x1d8
[  162.483844][ T1694]  online_store+0xa4/0x118
[  162.488107][ T1694]  dev_attr_store+0x44/0x78
[  162.492457][ T1694]  sysfs_kf_write+0xe8/0x138
[  162.496896][ T1694]  kernfs_fop_write_iter+0x26c/0x3d0
[  162.502028][ T1694]  new_sync_write+0x2bc/0x4f8
[  162.506552][ T1694]  vfs_write+0x718/0xc88
[  162.510643][ T1694]  ksys_write+0xf8/0x1e0
[  162.514732][ T1694]  __arm64_sys_write+0x74/0xa8
[  162.519342][ T1694]  invoke_syscall.constprop.0+0x78/0x1e8
[  162.524824][ T1694]  do_el0_svc+0xe4/0x298
[  162.528914][ T1694]  el0_svc+0x20/0x30
[  162.532658][ T1694]  el0_sync_handler+0xb0/0xb8
[  162.537181][ T1694]  el0_sync+0x178/0x180
[  162.541187][ T1694] Code: f00033e1 91318021 91090021 97e38d8b (d4210000)
[  162.547968][ T1694] ---[ end trace 2a1964462a219f20 ]---
[  162.553273][ T1694] Kernel panic - not syncing: Oops - BUG: Fatal except=
ion
[  162.560250][ T1694] SMP: stopping secondary CPUs
[  162.564871][ T1694] Kernel Offset: disabled
[  162.569045][ T1694] CPU features: 0x00000251,20000846
[  162.574089][ T1694] Memory Limit: none
[  162.577849][ T1694] ---[ end Kernel panic - not syncing: Oops - BUG: Fat=
al exception ]---

Occasionally, it failed like this,

[  119.319732][ T1387] Unable to handle kernel paging request at virtual ad=
dress dfff800000000000
[  119.328575][ T1387] Mem abort info:
[  119.332073][ T1387]   ESR =3D 0x96000004
[  119.335879][ T1387]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  119.341895][ T1387]   SET =3D 0, FnV =3D 0
[  119.345697][ T1387]   EA =3D 0, S1PTW =3D 0
[  119.349542][ T1387] Data abort info:
[  119.353121][ T1387]   ISV =3D 0, ISS =3D 0x00000004
[  119.358387][ T1387]   CM =3D 0, WnR =3D 0
[  119.362055][ T1387] [dfff800000000000] address between user and kernel a=
ddress ranges
[  119.370166][ T1387] Internal error: Oops: 96000004 [#1] SMP
[  119.375739][ T1387] Modules linked in: loop processor efivarfs ip_tables=
 x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit nvme mlx5_core i2c_core=
 nvme_core firmware_class
[  119.391164][ T1387] CPU: 2 PID: 1387 Comm: ranbug Not tainted 5.13.0-rc3=
+ #16
[  119.398294][ T1387] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR=
, BIOS 1.6 06/28/2020
[  119.406810][ T1387] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=3D-=
-)
[  119.413504][ T1387] pc : hex_dump_to_buffer+0x3ac/0x9f0
[  119.418728][ T1387] lr : print_hex_dump+0x10c/0x1d8
[  119.423600][ T1387] sp : ffff800021b4f3a0
[  119.427600][ T1387] x29: ffff800021b4f3a0 x28: dfff800000000000 x27: fff=
f800021b4f500
[  119.435429][ T1387] x26: 0000000000000083 x25: fffffffffffffffe x24: 000=
0000000000008
[  119.443257][ T1387] x23: 0000000000000045 x22: 0000000000000083 x21: 000=
0000000000020
[  119.451084][ T1387] x20: 0000000000000000 x19: ffff800021b4f500 x18: fff=
f0008650187e8
[  119.458912][ T1387] x17: 0000000000000000 x16: 0000000000000007 x15: 000=
00000000000c8
[  119.466740][ T1387] x14: 0000000000000000 x13: ffff800011c6eea4 x12: 000=
000000000f1f1
[  119.474568][ T1387] x11: 0000000000000005 x10: ffff8000112eec80 x9 : 000=
00000f3f3f3f3
[  119.482396][ T1387] x8 : 0000000000000010 x7 : 0000000000000000 x6 : fff=
ffffffffffffe
[  119.490224][ T1387] x5 : 0000000000000083 x4 : 0000000000000000 x3 : 1ff=
fffffffffffff
[  119.498051][ T1387] x2 : ffff8000112eecc0 x1 : 0000000000000006 x0 : 000=
0000000000000
[  119.505879][ T1387] Call trace:
[  119.509011][ T1387]  hex_dump_to_buffer+0x3ac/0x9f0
[  119.513884][ T1387]  print_hex_dump+0x10c/0x1d8
[  119.518407][ T1387]  __dump_page+0x8c8/0xba8
[  119.522672][ T1387]  dump_page+0x20/0x50
[  119.526587][ T1387]  memory_subsys_offline+0x1f8/0x250
[  119.531722][ T1387]  device_offline+0x154/0x1d8
[  119.536247][ T1387]  online_store+0xa4/0x118
[  119.540511][ T1387]  dev_attr_store+0x44/0x78
[  119.544860][ T1387]  sysfs_kf_write+0xe8/0x138
[  119.549298][ T1387]  kernfs_fop_write_iter+0x26c/0x3d0
[  119.554429][ T1387]  new_sync_write+0x2bc/0x4f8
[  119.558953][ T1387]  vfs_write+0x718/0xc88
[  119.563042][ T1387]  ksys_write+0xf8/0x1e0
[  119.567130][ T1387]  __arm64_sys_write+0x74/0xa8
[  119.571740][ T1387]  invoke_syscall.constprop.0+0x78/0x1e8
[  119.577222][ T1387]  do_el0_svc+0xe4/0x298
[  119.581311][ T1387]  el0_svc+0x20/0x30
[  119.585054][ T1387]  el0_sync_handler+0xb0/0xb8
[  119.589578][ T1387]  el0_sync+0x178/0x180
[  119.593583][ T1387] Code: 1200080b 120008c1 d343fc00 38fc6864 (38fc6803)
[  119.600364][ T1387] ---[ end trace b03c958bc1accb66 ]---
[  119.605669][ T1387] Kernel panic - not syncing: Oops: Fatal exception
[  119.612124][ T1387] SMP: stopping secondary CPUs
[  119.616747][ T1387] Kernel Offset: disabled
[  119.620923][ T1387] CPU features: 0x00000251,20000846
[  119.625968][ T1387] Memory Limit: none
[  119.629728][ T1387] ---[ end Kernel panic - not syncing: Oops: Fatal exc=
eption ]---
