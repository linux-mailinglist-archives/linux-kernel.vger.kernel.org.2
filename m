Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681EC4252EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhJGM0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:26:40 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:37446
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233073AbhJGM0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:26:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofSWNxwRBbDY77vZJQY6/1H2CoAQ5yLsSmzyQ68RZts7EPwUz+GNUdEQHvvj1reOgM2Px98XykZgo6bIpaePUd55n9GfBGXdwiBhFzjj2CucKSDprnYNmfC5VVh6pulFAK2tyVhv+xYPg7A3AY+1XnPN6gERTPgMUApl+R5/vvVlzrwfEOJa/lPszQ4vNJOc9aSHdscJgSDLHLG4rHk2lXAW9tghG/KFjVgAOD5MDQbOVXaeG1/0ZhTlpNz+02q3wGWIpAnSpn3H/hOiOD+WLnm40//jik4vR6ZskW+as5VMVbWBJlSnxKi3stoLIcrjxFkesnH3yRisaiuwZumksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lJ0HBLPL20+gpOI80eGlDJw9y0CPmXDb5zFv65gzcU=;
 b=fts7C6eIhT8JLBOaoUZ/KD0zIogdxLu+/S1DxwfAvWvQDpUC49vj8MuLkYHB3hwLc0hjWqMmqjS43ka5AALVP5yzv3vgzvdG/yHbQ6+3ArAYLQLwEDwz4isQDnV0j8YLPXH9tYJOHZ2FOQGy0yKG2P53ozvOeTmNj6Ea9WvkqDgQIfM60g8hIOkdapJwWQK2rkul5e2/OA+N5uOrhksGb0aYwdIpvshyRHAI1S36UdzvKLBogvD/79JFv/KYY4TVBOB3c0OKwUKgWPy0d/OeWQMvo+k8mOLd56n5O9//fjkc/wCMw1iObbTWd+Zor543wyA5XCsCsKPKoGT25GszTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lJ0HBLPL20+gpOI80eGlDJw9y0CPmXDb5zFv65gzcU=;
 b=eNjErf8cjzmgwb7JnqfGffS2Nt3Z/OMKPkp21tkQQECn7m0pcHDZaozWCz90uJbBZIlGzgffQVEKewFKJCReSTg1oQ3QhebYPh31sv3HuHf7EpyWaQDdkL668cwvnDAOZ6uF2RlvWf1QKBKaEXPGfdwsf8z+700cf2nAY142W84=
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13) by AM8PR04MB7812.eurprd04.prod.outlook.com
 (2603:10a6:20b:245::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:24:43 +0000
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726]) by AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726%8]) with mapi id 15.20.4566.023; Thu, 7 Oct 2021
 12:24:43 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "Youri Querry (OSS)" <youri.querry_1@oss.nxp.com>
Subject: Re: [PATCH v2] soc: dpio: fix cleanup on error
Thread-Topic: [PATCH v2] soc: dpio: fix cleanup on error
Thread-Index: AQHXuRZ0VfjSBnS31kCsmuq7g1DGlavHem8A
Date:   Thu, 7 Oct 2021 12:24:43 +0000
Message-ID: <20211007122442.4nyof6jf3w6s4shy@skbuf>
References: <20211004115323.7454-1-laurentiu.tudor@nxp.com>
In-Reply-To: <20211004115323.7454-1-laurentiu.tudor@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 776a21da-4abd-46b3-ed40-08d9898d717b
x-ms-traffictypediagnostic: AM8PR04MB7812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM8PR04MB7812DB8C9DEF8ECCC4F40EEBE0B19@AM8PR04MB7812.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4XpP+TcYwrd1hhLJGxmyW8z/os6ohz6s8nThj5zNnIWFmwtiGzeORT1JcF6cErdFNsZay2kQq/T3uNRleo/oPU6JvRBonB+CY5yNthdUyBPM53e73BI5smA1sN+IO3M/89ibyzYKwkEAnjUWJaPHm26YYybYfgHc/GoQLrx9jn18843vaf+C2eoOiQW+YnJ6E31z5TI+NSJXR2PQSLpxkVdi4Q7OqJszy/kJh0j1n56GhgAz1q5d+ztvxFg2UB2fsBvYs9hA5duXrFTo/DlTwyFbHvYS8ZaH/qHjeACWI7sXX9J4qQC56oQt2m6yl7EocximEt690rWf2EdgGCd9m+aJwcD1/cR/AXtXKSvoJz1c7R7nojNgvtVKZgzS1Yz94+GYgZhl9bA45uoHcF0apYblqKFWKrvyiZ8xvPkarCPX7ryxvVRPs6r25xvdWqlg3CfJ+F5JmM0E4GqPiqgCf/C7GYHFgMxZZENgpCYXl4wAUngHSeKjjIqmy+AjIXiR3KzHjFuH8yk2KSzYMcuNrMfkmH8ODzonB2U21oMcUGTBhULinZZz9ejyjU/Z75Bc8Za7OldqSgZSIeEir1BiF0JsZgDAdHJ9FYZQJv+0sVdN4mUJUzgcceKK4f0GTOBx4c+RPXFe4A74wF8nFN/hZqUGT34jApgezhIip37vRbZiLKX1/2CAfrSMhOkB4iyr5vmJN4AhWar/tYpVlYoa2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2308.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(122000001)(1076003)(54906003)(508600001)(4326008)(83380400001)(33716001)(38100700002)(316002)(6862004)(2906002)(71200400001)(8676002)(66946007)(6636002)(8936002)(91956017)(76116006)(64756008)(186003)(9686003)(66446008)(86362001)(44832011)(6512007)(6486002)(6506007)(38070700005)(5660300002)(66476007)(66556008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IkV+gpE9CDEt1uSgL/eh/6eoC5BZrlTXffZPbi5eTTXegtp09DmxnBKtpYzK?=
 =?us-ascii?Q?xqOrqtB2vhgln331ujS2OfoGP0ejxJwAwCvjWe+OPlFe5aOnoYEd6QGtsBt+?=
 =?us-ascii?Q?SQiXr4vxo84kjEzbjYsHyAsoRZpBzgeBpM7HL68zuMDGW87mEEEM7rwgtaF4?=
 =?us-ascii?Q?2Uct5S7c8dckfbsmHYqJaXigmuEb1udz6Gyq69K1Mop8w/VUCx/q/r/znoaR?=
 =?us-ascii?Q?wAmapfkMTx5DhhfeKEENVEtepEC3Vmu1FGm/ZTr9pkGyJGDXKpg9almnw9oI?=
 =?us-ascii?Q?UA6Lr0O+QTKH/hgv8aSG9ts3bhWTQglp1qzrvLnoYeT1cCn9I5SPq1k7c6Fl?=
 =?us-ascii?Q?59OKb/jMOo7ixlFqD05/Vq5bWKlXbgEjxPSxi/lHkfkVWchGCxNBNkvovETv?=
 =?us-ascii?Q?krDfwX/LMfpxyZsB/1WiVbetM2P44wXYcH+SlIJcarqTM+u7bTH/x2My+aHU?=
 =?us-ascii?Q?ZMbeWCYQb1M+km7sbFKKnX3TAp5ibZX97u4F6+aP1NXKIfGzNl7FwSTe/wth?=
 =?us-ascii?Q?xbdhgvp6vPve3n+U6zh3bHSeEEQP6FkJsewFDwLjkJt2zecNycnxVSXfQqFc?=
 =?us-ascii?Q?7V+iAWx+Wt/xizQqAvISRWtq7Eye5pdP/+T7NIRWwYPO0eCWqeXe+121Iqa6?=
 =?us-ascii?Q?A6STqU6ZdbLNa//saStRE4f5U1N4uDMlG0Jggz+Ua7kpk2Co1hpNp/uCDYgM?=
 =?us-ascii?Q?hSCfvU++ZMMcMdPcY/UB29DLunc3pBwVOJXVTWWR5PlFowVHB/0hOTW53SmH?=
 =?us-ascii?Q?+2C+bvTl5vK+ORayDBXk6OU5XJg15BpiTXtmz5G/1d7BDk6eDzEv8HeS1dZ2?=
 =?us-ascii?Q?M8tt8EaAeWoRS8IuNhAwkn+Zh9RDwv0QvdQ1+aj8z0EdhKHfX/JzQhVFVqMS?=
 =?us-ascii?Q?qoa++kwv4v1aTqDRhfwy0qMWzHgIlYZ7T7TgEwiebqA7eF76YAeGlEPsLNJ/?=
 =?us-ascii?Q?4LsKEMz+2I5+X68sjXa3xzua9GlqifL3MBmgavrs3weAUCjzJaJgwR9+BnTm?=
 =?us-ascii?Q?uFfhsCvvtKMfGvpV3/AnAYATWB2ePaGThX7ReIrtC6kG3D2PM0nrv/OWPPIX?=
 =?us-ascii?Q?rySIK4gSInxqYse7HLuRZaWXra8M1JWVdQ0GdOHEWn14ZSbdXaZ0re7W1CeQ?=
 =?us-ascii?Q?/aEFc+6GaZwgd87U5KZV450rGGPsHwacB2PE7yEtkbyKrn4b14IkD7pmV1z9?=
 =?us-ascii?Q?cmqLbdP1tsK+70yycyu5DwHxpZy45PJiETOJjVTMGjAGIEpDqXKQ9WAPWh8n?=
 =?us-ascii?Q?ab5zibXNfQSUWC5OTrBmlhsn/jm4UhihbrlzWPCSYE9qgyujaKivaBMEVdih?=
 =?us-ascii?Q?hokgC+gYqBXhnxd+HLKmSb6YgCJWcOJAIzsdrK8coRM2Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80523CB512837B4B89E94F2E53BA4322@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2308.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776a21da-4abd-46b3-ed40-08d9898d717b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 12:24:43.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lULZDIb1AHIKTe8zZBmByJ1YIPu5gmNniBe6UQNjxWo8NDvJNIiW9nYh/uz3EpxK8+wXt6/sTKA74BmSnk+W4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7812
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 02:53:23PM +0300, Laurentiu Tudor wrote:
> dpaa2_io_service_register() adds an element to a linked list but
> doesn't remove it on the error path, leading to the below kasan
> use-after-free splat. Fix it.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in dpaa2_io_service_register+0xb8/0x1d4
> Write of size 8 at addr ffff05d2b13af028 by task kworker/u32:2/151
>=20
> CPU: 9 PID: 151 Comm: kworker/u32:2 Not tainted 5.14.0-rc1-00222
> Hardware name: NXP NXP LX2160ARDB Platform, BIOS EDK II Apr 16 2021
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
>  dump_backtrace+0x0/0x2a4
>  show_stack+0x1c/0x30
>  dump_stack_lvl+0x68/0x84
>  print_address_description.constprop.0+0x74/0x2b8
>  kasan_report+0x1e0/0x24c
>  __asan_store8+0xa8/0xd0
>  dpaa2_io_service_register+0xb8/0x1d4
>  dpaa2_eth_probe+0x93c/0x21cc
>  fsl_mc_driver_probe+0x3c/0x80
>  really_probe.part.0+0xec/0x480
>  __driver_probe_device+0xd4/0x180
>  driver_probe_device+0xf8/0x1e0
>  __device_attach_driver+0x120/0x190
>  bus_for_each_drv+0xec/0x15c
>  __device_attach+0x168/0x250
>  device_initial_probe+0x18/0x24
>  bus_probe_device+0xec/0x100
>  deferred_probe_work_func+0xe8/0x130
>  process_one_work+0x3b8/0x650
>  worker_thread+0xa4/0x72c
>  kthread+0x1f8/0x210
>  ret_from_fork+0x10/0x18
>=20
> Allocated by task 1192:
>  kasan_save_stack+0x2c/0x60
>  __kasan_kmalloc+0x90/0xb4
>  dpaa2_eth_probe+0x830/0x21cc
>  fsl_mc_driver_probe+0x3c/0x80
>  really_probe.part.0+0xec/0x480
>  __driver_probe_device+0xd4/0x180
>  driver_probe_device+0xf8/0x1e0
>  __device_attach_driver+0x120/0x190
>  bus_for_each_drv+0xec/0x15c
>  __device_attach+0x168/0x250
>  device_initial_probe+0x18/0x24
>  bus_probe_device+0xec/0x100
>  device_add+0x570/0xca0
>  fsl_mc_device_add+0x360/0x8f0
>  fsl_mc_obj_device_add+0x140/0x16c
>  dprc_scan_objects+0x2c4/0x480
>  dprc_probe+0x48/0x17c
>  fsl_mc_driver_probe+0x3c/0x80
>  really_probe.part.0+0xec/0x480
>  __driver_probe_device+0xd4/0x180
>  device_driver_attach+0x70/0xf0
>  bind_store+0xf8/0x160
>  drv_attr_store+0x50/0x6c
>  sysfs_kf_write+0x94/0xb0
>  kernfs_fop_write_iter+0x19c/0x264
>  new_sync_write+0x1c4/0x2bc
>  vfs_write+0x30c/0x390
>  ksys_write+0xc4/0x170
>  __arm64_sys_write+0x48/0x60
>  invoke_syscall+0x60/0x190
>  el0_svc_common+0x84/0x130
>  do_el0_svc+0x88/0xa4
>  el0_svc+0x24/0x34
>  el0t_64_sync_handler+0xa8/0x130
>  el0t_64_sync+0x198/0x19c
>=20
> Freed by task 1192:
>  kasan_save_stack+0x2c/0x60
>  kasan_set_track+0x2c/0x40
>  kasan_set_free_info+0x2c/0x50
>  __kasan_slab_free+0xdc/0x140
>  kfree+0xd4/0x360
>  dpaa2_eth_probe+0x11b4/0x21cc
>  fsl_mc_driver_probe+0x3c/0x80
>  really_probe.part.0+0xec/0x480
>  __driver_probe_device+0xd4/0x180
>  driver_probe_device+0xf8/0x1e0
>  __device_attach_driver+0x120/0x190
>  bus_for_each_drv+0xec/0x15c
>  __device_attach+0x168/0x250
>  device_initial_probe+0x18/0x24
>  bus_probe_device+0xec/0x100
>  device_add+0x570/0xca0
>  fsl_mc_device_add+0x360/0x8f0
>  fsl_mc_obj_device_add+0x140/0x16c
>  dprc_scan_objects+0x2c4/0x480
>  dprc_probe+0x48/0x17c
>  fsl_mc_driver_probe+0x3c/0x80
>  really_probe.part.0+0xec/0x480
>  __driver_probe_device+0xd4/0x180
>  device_driver_attach+0x70/0xf0
>  bind_store+0xf8/0x160
>  drv_attr_store+0x50/0x6c
>  sysfs_kf_write+0x94/0xb0
>  kernfs_fop_write_iter+0x19c/0x264
>  new_sync_write+0x1c4/0x2bc
>  vfs_write+0x30c/0x390
>  ksys_write+0xc4/0x170
>  __arm64_sys_write+0x48/0x60
>  invoke_syscall+0x60/0x190
>  el0_svc_common+0x84/0x130
>  do_el0_svc+0x88/0xa4
>  el0_svc+0x24/0x34
>  el0t_64_sync_handler+0xa8/0x130
>  el0t_64_sync+0x198/0x19c
>=20
> The buggy address belongs to the object at ffff05d2b13af000
>  which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 40 bytes inside of
>  1024-byte region [ffff05d2b13af000, ffff05d2b13af400)
> The buggy address belongs to the page:
> page:0000000091873dc7 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x22313a8
> head:0000000091873dc7 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0xbfffc0000010200(slab|head|node=3D0|zone=3D2|lastcpupid=3D0xffff)
> raw: 0bfffc0000010200 0000000000000000 dead000000000122 ffff05d1000028c0
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>=20
> Memory state around the buggy address:
>  ffff05d2b13aef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff05d2b13aef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff05d2b13af000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                   ^
>  ffff05d2b13af080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff05d2b13af100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>=
