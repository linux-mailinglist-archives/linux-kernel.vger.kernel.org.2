Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79944390584
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhEYPel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:34:41 -0400
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:19993 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhEYPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:34:40 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 11:34:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1621956790; x=1622561590;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qZMZwbbWv+Kk2o96RPsFrv5imCBnigMSnDJV6SMFo8E=;
  b=xY8DN67q8kodTg/arS53QvchgIOasanmwIqoIHBbVt5q9Slw92vg393g
   T+FuvL95u/dpDvMoRLvVoPAEdGaMN2qQKy6tZQjUhI2UYPTZB/kP72/nA
   2rxkZvtWNs1mnNnlr8pJ6dXLrwJNdUAsU+4NR0OCPxrDlWFfEhVXU6ooy
   Y=;
IronPort-SDR: QHrOCE1c+3vExGEdGCGSqkhAvCNanFvorf7dW+5c4WUx/FQIRhVOUmFOLFcdkti0X+b2tUTERi
 4ZVGNut4tfxZoHNTsQPUACx5LofQLCRRsDGe0oia+PpNOXcgot+DdN0sNBTzSvadgrkqpXpXJC
 WQwrpttoXxlO+c7l7lbQCE/lZx890DUT9MuiK4e8q6f00BdmowBgwckPQT+7R+ITdnH7gM5O9X
 4nvblSiEN05tqXMkUry0dD716o0DUI+IC3/wl4r0wyPj7x3zEmt4qmu4Y1nMEnMzZyIqxxrOoY
 4L4=
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 15:26:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvf9QIPO6IeorlM9OXpFk+OzJj3o15+4QyvJ0Izrc3gVfDfny8OXwK17QVmpWeuITLqdRJbGYs0CFGLW+qWNDthunO1La7oBIViu3I1s3jSwiyEguJxILapOiUXKKrxQNCwkj7yOWxc147uWvDNSVu3kg8Vp2b2Tf7Zu9mrnBoXwZmK37y6f/Bi8ng9UHXLmNBCp2texWKZwWvRFIVGP+/KcrYmjA9lpTpPu4Z71tsWE7M6uoZV1EgYpjdlTS6rcjbycL7drQjvrMg1jFIhPMPRj5eZZM+r67RFJs98c/13bNhXUIrba7QDefc0BgOri97yZr2XfgxzjOAZnaRqoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GREY2Zerx1Lv9Atza3/9gkjbx7zsUUKNsczpQ3APa3Q=;
 b=LbJU7xFCaQA9FlvOk2uxVDPakgI3ytXJ4T27MHQoL0VYWifzLrYNZNrtIVpo8dOmpHOduPyUYjvNZCeYAeEWTaLScfFO7NH3pYm89kVA/zUgoGTrrjD+U/ooODsLCNRniul9IgKSYvQerKiDtBqiOEcFHB7BZR6NIybCWNQRFzqglrY4+V0PwNtGqWAztrXpg0kpZda2eCJlNsgPyZPcwuUW6dg+95oHFR/+/OlRdVsfzYCBDKi6Nv1UyKz5ybUl0jCkwRYmp09iBgPUYp9S/w6mb7q/cPe4dwNg7AO/myxPNyl2Xc64ff1sOWemz+l3ov4Q4HFO9Luc/lLNHMxRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM5PR0201MB3557.namprd02.prod.outlook.com (2603:10b6:4:7f::24)
 by DM6PR02MB6858.namprd02.prod.outlook.com (2603:10b6:5:223::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 15:25:59 +0000
Received: from DM5PR0201MB3557.namprd02.prod.outlook.com
 ([fe80::5dd9:4dea:abee:1800]) by DM5PR0201MB3557.namprd02.prod.outlook.com
 ([fe80::5dd9:4dea:abee:1800%3]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 15:25:59 +0000
From:   "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Arm64 crash while reading memory sysfs
Thread-Topic: Arm64 crash while reading memory sysfs
Thread-Index: AddReOlJgH2KJ1uxR3GEgRxceOTONA==
Date:   Tue, 25 May 2021 15:25:59 +0000
Message-ID: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [163.116.135.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cf7969e-759a-41e4-6358-08d91f916623
x-ms-traffictypediagnostic: DM6PR02MB6858:
x-microsoft-antispam-prvs: <DM6PR02MB685854CB25DEF8683C1A39C6F2259@DM6PR02MB6858.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtCg0U6qUNT9Yb2qhDCCWJin0Ai9zaFa4c61tL4YoTsDYOTEl/kPObY13HFR8FoZC+ONhj7/F2OS4O4iGVp4Z27pAA0MJE2Vhro1lsli3AKvKA5+6G+6HzEuWku/aPvkggBbshYbC2i1gCB3Y+PgElSCPM4c/e197QZ6Vz4Twxp0mVRFTcC6Dp8RVOjofzolknwE03RWpNsBK8xod9yCazIHA/se1DZIKB1Rin2CucWv3G+kbqTkIlJDDI+5vwNpeaIbNuSIFPcCrz4Ija+AWY/5Q8MGZbHgWfLL7BPseaQnsemKmzyn0yxR5ZFtSUbET8sMJdJRItk5vaft+cILl8zMlDw31ovj6hN4suZzfMaFFrnhQcTYchev4Eh1lV8QjXHS08s0jHbTVsbkTA0hHzaSEY5vFgM42lj4KtJj7uVKG4gDn7jY1gTbHVs4arCBPL2e4x0amDtZnGqw4t1Mv1yizatRicZgD5EYIIrXF3sSVpDC7reMJCIiNekSEvLFt+x55KBVaaUjKo2ySAN1n5XQcScakkS6FdZofb7y/yzukYVPl3WkI+euGUf9FraKUq/6spgsNS2Ii9euYGo5a0MXIrrgcxIQEwXwPH1TaRqqVk7OYZVmwvcxxOeXhzh2GbULncpoapchmrqMLvLtu+Cvecsrtn3LuRwcbfPXlp4mR6/Yv1DFR4vCaKg/6n2MRFetYXLmFOqjrUAeMzYfGqwye7v8K/eM+QTQY9RV8Vg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0201MB3557.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(66556008)(66446008)(5660300002)(64756008)(66476007)(83380400001)(66946007)(122000001)(478600001)(6916009)(76116006)(52536014)(7696005)(8676002)(54906003)(6506007)(9686003)(86362001)(55016002)(38100700002)(316002)(2906002)(7416002)(45080400002)(26005)(71200400001)(8936002)(186003)(33656002)(4326008)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xSCkkuP9QM42TGwVddI0u46op1eOOQbNnI+c4f008tbQC3KhJHBbReC5gfFH?=
 =?us-ascii?Q?4y0ybX8z/UwD0ai+MzA0mZmiiQkcuiYCRkmPoMRvxF5C6MNB/DLThOeCNdh5?=
 =?us-ascii?Q?lP9Vk6C10k5q0tMeIuN9J25ShlDLRZ1osmBPoxykdfa0U5ne+UiLdfkUJdWS?=
 =?us-ascii?Q?4HcFsTJV1qDasxvQ4lc8RpkCu6uvKPwFnrENSUnavqM2VhXsGl9HyRVbydui?=
 =?us-ascii?Q?//H2EaDSPJITlMy9NKdS9VZyigmvmuiJnXiBCnUj87xpR31O+9qf29RsF8UA?=
 =?us-ascii?Q?Vc/f9dIfLIsexjvzqfXP09/MRnxpCDPQBvfQzTkQaGiTYZezBVIMRgUWLFnZ?=
 =?us-ascii?Q?h9WrpcQTQ5apxRrILdqrUtQ3HQ6OjbHv5Z3uWRD+HvTCJeEuMWiHB9OB+ceV?=
 =?us-ascii?Q?F9FQYGoCdyPiZM7bh0qDUpM49Gd7Sgcx/9LVAJbZrcbAHdQ/JXIlad8QFpAM?=
 =?us-ascii?Q?f0nuX7GGFCbWEAkoLohK79mOShRQuN3jXJDD4ZDNmRY1JscXdnCIoaC7VGup?=
 =?us-ascii?Q?Zn952cjVdIgpyKHQ6s5uhWQu0C+RdFfs4oDCr+gW5ooY51GaRdsVKTof7N5c?=
 =?us-ascii?Q?aISNzOoSGSJhwFJku/MOIfkm2/uP/xtYayTOJD+xIIYDllLq5S5N+MeMZy0a?=
 =?us-ascii?Q?59Hs6grCsKaeWuFdZ1OWlTC7t52pe32bWDzFjjMNDN8hTGSg4WVsMXoJnQpt?=
 =?us-ascii?Q?wvLxjltqCpw3yo/PHPgnFjW/us9JWtggxX7l42hKSzV2dW2RjTIXiUKUaonR?=
 =?us-ascii?Q?bgtOZAWYNGSc6nPcJPNdWTnYdkuER2YceZ0uiqL+afDTcsmvEMvdJGLBzRZy?=
 =?us-ascii?Q?qJzIwClzGC8ZJmynSwEiV/ydC4oWcWQEhBZOEpQMWJtfgVofwvwtBy6U7o7b?=
 =?us-ascii?Q?TT2ATvg280WDGq/u0iKRbdwkmiJhNinBhD37M4oUdg+U0yl5loml0MP2LV9+?=
 =?us-ascii?Q?+8fTGzO51BLhrEb5H3uE7oiofYclLwD1rp4Sogoh?=
x-ms-exchange-antispam-messagedata-1: v9DQD/2JpSHtvBuX0kZzGCqBXfgTkoxlxA0PEYBoDFCY750RgSd6nrlfGySzfhcnTeXq+TFHJNBjVTyIj3c2r23omlJH4+PjLwwBU4X8H9Gek2mM3Tl1tyYo6nR6RobsPvOh9x/WMypAznepu86xMZrXKywnfiOpOVzttO5qAbuFbhSNYVK6lhXRpBc2RuO9k3NIO9YCUpwrRhuUnDYbfctmmhD1rwmXBGZE4xTnrju919d4m5CTD0SiAeVe4u+zzuzulBguxRsmG+waPKvKCwqLb8bBDIsjHGljE/fDkOv5UzXvzsytuvmmtQptptF2D+/Sthv/KNN8HN5Z/HQM5Drq
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0201MB3557.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf7969e-759a-41e4-6358-08d91f916623
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 15:25:59.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqXOo6ZVtyi7TgBrlm7h0CU3uIuLvj/OsyM3JEDIqQe8FPxZK8wGBBjLpzj8benRKW+GvtHJEi9vSEy0w4UmMG/WogKWOFooBMUMLKBgJAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6858
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reverting the patchset "arm64: drop pfn_valid_within() and simplify pfn_val=
id()" [1] from today's linux-next fixed a crash while reading files under /=
sys/devices/system/memory.

[1] https://lore.kernel.org/kvmarm/20210511100550.28178-1-rppt@kernel.org/

[  247.669668][ T1443] kernel BUG at include/linux/mm.h:1383!
[  247.675987][ T1443] Internal error: Oops - BUG: 0 [#1] SMP
[  247.681472][ T1443] Modules linked in: loop processor efivarfs ip_tables=
 x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit nvme mlx5_core i2c_core=
 nvme_core firmware_class
[  247.696894][ T1443] CPU: 15 PID: 1443 Comm: ranbug Not tainted 5.13.0-rc=
3-next-20210524+ #11
[  247.705326][ T1443] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR=
, BIOS 1.6 06/28/2020
[  247.713842][ T1443] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=3D-=
-)
[  247.720536][ T1443] pc : test_pages_in_a_zone+0x23c/0x300
[  247.725935][ T1443] lr : test_pages_in_a_zone+0x23c/0x300
[  247.731327][ T1443] sp : ffff800023f8f670
[  247.735327][ T1443] x29: ffff800023f8f670 x28: 000000000000a000 x27: 000=
000000000a000
[  247.743156][ T1443] x26: ffffffbfffe00000 x25: ffff800011c6f738 x24: dff=
f800000000000
[  247.750984][ T1443] x23: 0000000000002000 x22: ffff009f7efa29c0 x21: 000=
0000000000000
[  247.758812][ T1443] x20: ffffffffffffffff x19: 0000000000008000 x18: fff=
f00084f9d3370
[  247.766640][ T1443] x17: 0000000000000000 x16: 0000000000000007 x15: 000=
0000000000078
[  247.774467][ T1443] x14: 0000000000000000 x13: ffff800011c6eea4 x12: fff=
f60136cee0574
[  247.782295][ T1443] x11: 1fffe0136cee0573 x10: ffff60136cee0573 x9 : dff=
f800000000000
[  247.790123][ T1443] x8 : ffff009b67702b9b x7 : 0000000000000001 x6 : fff=
f009b67702b98
[  247.797951][ T1443] x5 : 00009fec9311fa8d x4 : ffff009b67702b98 x3 : 1ff=
fe00109f3a529
[  247.805778][ T1443] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000=
0000000000034
[  247.813606][ T1443] Call trace:
[  247.816738][ T1443]  test_pages_in_a_zone+0x23c/0x300
[  247.821784][ T1443]  valid_zones_show+0x1e0/0x298
[  247.826483][ T1443]  dev_attr_show+0x50/0xc8
[  247.830747][ T1443]  sysfs_kf_seq_show+0x164/0x368
[  247.835533][ T1443]  kernfs_seq_show+0x130/0x198
[  247.840143][ T1443]  seq_read_iter+0x344/0xd50
[  247.844581][ T1443]  kernfs_fop_read_iter+0x32c/0x4a8
[  247.849625][ T1443]  new_sync_read+0x2bc/0x4e8
[  247.854063][ T1443]  vfs_read+0x18c/0x340
[  247.858066][ T1443]  ksys_read+0xf8/0x1e0
[  247.862068][ T1443]  __arm64_sys_read+0x74/0xa8
[  247.866591][ T1443]  invoke_syscall.constprop.0+0xdc/0x1d8
[  247.872072][ T1443]  do_el0_svc+0xe4/0x298
[  247.876162][ T1443]  el0_svc+0x20/0x30
[  247.879906][ T1443]  el0_sync_handler+0xb0/0xb8
[  247.884429][ T1443]  el0_sync+0x178/0x180
[  247.888435][ T1443] Code: b0005ee1 912b8021 910b0021 97fc57ac (d4210000)
[  247.895217][ T1443] ---[ end trace 4ff9f5cbe7443f54 ]---
[  247.900522][ T1443] Kernel panic - not syncing: Oops - BUG: Fatal except=
ion
[  247.907501][ T1443] SMP: stopping secondary CPUs
[  247.912122][ T1443] Kernel Offset: disabled
[  247.916296][ T1443] CPU features: 0x00000251,20000846
[  247.921340][ T1443] Memory Limit: none
[  247.925100][ T1443] ---[ end Kernel panic - not syncing: Oops - BUG: Fat=
al exception ]---

