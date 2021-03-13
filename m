Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90C5339BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 05:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhCMEFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 23:05:25 -0500
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:43947
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231597AbhCMEE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:04:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGbQe9kNto4UL6R5xHFoSBhS4ec/xHId2kdtpJ3uWmwipJBfWqHSQIWQNSiKPuZ3A20/wlhukMLV4ATZULbpX0nw8f1gY92SN2rgUIWYhPzWMGh0N09IjVbkXdmWCEEYhaBwzjjbhHFRG5pj56RdgnnWbZiTj254qwBDtCPbyKVSwtWpixCgGrm/dpIKvWbRWHmT4/CStT0mnOkE8vdTDvR1y76LVa2fkaOOVpjIi/lo27AYQMMtWmQKPBuj4+UbSHDmt7+9vwWXL7V+oedCxPFKT8O4GQchzTZFJzRUD7IPSS2A61WnkwuKfnUuTO+wCKOK3d7RtwGXtXe9Wbu8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gl4ZSv1MyWAJyjIzthMUHGCCcWykjSfPG16bLjmKLRk=;
 b=Rf+BGcwGfcQltDiMP8SR2cD744MKwjS0piYmBu5W+Nq+aNwn9QhhBjMuZikjxnZo4ezi7uY7PbGtfCN/Ck3do26j0XMxMpL2+Lo515dagIDrm4qhd4X2otaRWPAMbUD5aC4/wo6vg11k7ifIIrJgT5k3cNAt+Hev5Ge9iEFsLf6GIu48iz84hRMlrDQoCj8UDTHJFbctntSU8oiVntqn4yLE2IoDvYE9HEO85LrEM1nXXK2N12E3qSjJskfegUolx03ILcjhkIldbTYXqLFcgLj2FGspSyLtSHEhxT6HBuMTxektZ0j1u/8REqD2rWIjgXPhUHCzogHuNVmTl9dTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gl4ZSv1MyWAJyjIzthMUHGCCcWykjSfPG16bLjmKLRk=;
 b=CKZ/AWD8PCebtmMTXw39PbNB288XIFM04WFMN681yyRgWVLzBZGjhKct5fOeXLCyU4UkHO/z2LhVvlR3OnVFG0slxutoW6aE8M7mCus1ozd2hn3AQrlSMKW2fVevXtjfSHVuCBQAAxmT/lZgzCDaZvCH6CL0jU4W4eBnKVrC8as=
Received: from MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22)
 by MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sat, 13 Mar
 2021 04:04:46 +0000
Received: from MW3PR12MB4537.namprd12.prod.outlook.com
 ([fe80::89a6:6618:7616:30d3]) by MW3PR12MB4537.namprd12.prod.outlook.com
 ([fe80::89a6:6618:7616:30d3%4]) with mapi id 15.20.3933.032; Sat, 13 Mar 2021
 04:04:45 +0000
From:   "Liang, Liang (Leo)" <Liang.Liang@amd.com>
To:     David Hildenbrand <david@redhat.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
Subject: RE: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Topic: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Index: AdcWgujrowoM8ON/Tmy0Tmhi9senVQABLLQAADBH9CAAADxQgAACUAfQAAIipgAAAPKqgAAXm64w
Date:   Sat, 13 Mar 2021 04:04:44 +0000
Message-ID: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
References: <MN2PR12MB448872F0BE8F49C78AF908F3F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
 <2f7c20ea-888f-65b6-6607-c86aab65acce@redhat.com>
 <MN2PR12MB44886034D18F900F4FE45D8DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <15faeb97-d031-f70a-adab-f2966e0b1221@redhat.com>
 <MN2PR12MB44884289499B6B16A0E9017DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MW3PR12MB4537D9D86FB67A288A8EC4E7F36F9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <a434cc35-13f1-7eb2-5828-73cbb1896cea@redhat.com>
In-Reply-To: <a434cc35-13f1-7eb2-5828-73cbb1896cea@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-13T04:04:40Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4a66b9f8-be46-40d6-bb96-bac1e95fdc83;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4378a871-ca37-45d4-fc20-08d8e5d52351
x-ms-traffictypediagnostic: MW2PR12MB2380:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB238012ADFBA9BF1D8358F19BF36E9@MW2PR12MB2380.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uosbfGBmPpA4nW77dYexwkR/PP+j4Ol4ichPlxzOfS6fysAcxcvhU40WMAcsaT5vmvFlFwcAJCKU6lHZnyZrK59wF7FtUujZjwxUyKZR7NIVMynP4H3aQELCprdxfqp1LdoPzJ+hSLElqkINyMFZY2l35Wk9hsfWMM3eQiA6x/OsZfZT+2mmNjKQHbu/3FRvFI7Hp4sTHu3oeUVT8qzD1bTeE+oxLUk/xWoU7XTNZMGurGlsueF5BFv222JRdSuyz4nHKKOGWjCCI58VyT3jD93JlyhmAmbH2JOk6tlvR7CctqqkkQ5vrT9cWS1MnBK/2QUbEL/PeBrk4PJ0f6ocuM/23glNgBrqn+HrG0I/Ib4EyosWPtRO2eIGdhx9vZ4nSGRLf50Ah5+ePMSKzp3c8/bDyUSvwXR9X6jHwZccitRJMb8ZDXEU3ulFpVP3Hl65GC0MwnrZEsZw60A6nKM1yYZ+hvSS6SaZX7PMavjyD6kLpqCPzqBmHY2suUF+PI/rwcf3JH34TaqPO+ULCNfRZQnqYXGa33IWl2E6WEG/yOzDKOOP9STGwdmCff8gJ6xI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4537.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(33656002)(83380400001)(64756008)(66946007)(76116006)(66476007)(66446008)(66556008)(86362001)(54906003)(316002)(6506007)(26005)(186003)(8676002)(53546011)(2906002)(71200400001)(110136005)(8936002)(7696005)(478600001)(5660300002)(4326008)(55016002)(9686003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qOHFpF216vKwbTn1UafgFJv3OCZzgxGcpEv1hUJ6CQYo2WHDqX/tqPbOdvOU?=
 =?us-ascii?Q?u3sBKSHNzHhpKiLtgLnKJEtdYR4IvnZO2ZL7887bpL2j3uTEs/OhrizLxzYs?=
 =?us-ascii?Q?lunuo8uVV/iNRdUFYIRdf8jZ+9E5znbMdi1mPvdj0JgDYiE2CUvfJDzUIGA8?=
 =?us-ascii?Q?LFxEdoluAtqSlMK+2YlPFPHP85+RsHRBB2KzspBvNxEDEAwANmVvGFlSyfPR?=
 =?us-ascii?Q?GGDis2Gi1kwEZAYUp+5VjKEjVg+aBL348qvPCCaIPu+bQAc+kKQ3v0Lhut8Y?=
 =?us-ascii?Q?vbbZXRgIlHs3TE7nxIeF/mCY9GS5tUswqX7x0Om5d8uJnbnBjdZu5ad3rKlH?=
 =?us-ascii?Q?Ort4nkAWoTApzlE2AxjUt850tOfSeOMlfqvXJ8y3IIRdJO1Y9mUNDvzGxtZJ?=
 =?us-ascii?Q?xD4sYrm4C5Ell4D+CF2z8ZPc0abRZQoRG5YaNv4ekJM0fzjFcSlmYl7ZJvWj?=
 =?us-ascii?Q?A/t+byM0+jQGO9jIJgXUdEbz+PIdz0Mj1t+Fj8G5/GBwKGBW1Jmeg5UOJ925?=
 =?us-ascii?Q?Z/GQt5Nv1rQiSGEVegOLMDSKSbFX9NlzP9j1KjrHSNKz5DbFfFa3w/XttPIB?=
 =?us-ascii?Q?W0diQamtEEOoaq1rVumZ4p/FYn/ccDLHc6qC7giLDjDCBeNChlpAFzaRNcb2?=
 =?us-ascii?Q?mhEkCv6iYMr4VbMxB5UcuV/YeDCwc30B26XO49mipIUs3W4p0x4hNKU1ShJv?=
 =?us-ascii?Q?QAOobg8x6wWpqgF9nYyROFbHhPAkln7zasx9LFRPjp66iESXUWOqClI/9KmO?=
 =?us-ascii?Q?y/bCztXjck85NSEyGaaeECTLMyBCydEt9s0/5xjizzppkLOQnjShBhlUnvOt?=
 =?us-ascii?Q?OxxbGxFcwteV3vt0D88F8colfLqZILt8ISFgWBHte+uTL4mCNTM8nxUgBZ9c?=
 =?us-ascii?Q?SZi/UZyOpyw3ZszQRGOASYHMxFIuOKZ7dG+R8fRZbkCFFi5m33p6S1ZYhqNK?=
 =?us-ascii?Q?/Jb77bdtUJMKKwt7u3qCgdyYL7wbqCEj5LQzR28SK2/FA61R2HvpSALCQG65?=
 =?us-ascii?Q?h85qVbFq7aemAjqnHS6E9TgZX7HqQzel0rp7q0wZNjGZCeX7UyAy93o7Ujrn?=
 =?us-ascii?Q?DdXMFyubUbGnR/DeV0ZyXcfZtPxL6j4ftEBMzd6JUWryLP4jR6BKyy6Iuftn?=
 =?us-ascii?Q?zy3Mo0b9ljFwq3GFVgoEwil9mO+aRNXzPNpOFIHlOys1q4HgJgl6/Z9jU+qk?=
 =?us-ascii?Q?xOtDBFzekK2VOOMJ0yjgWZoHBTdMj5qx/kVCqkV8PJhlXyI6BethnJGEJmc7?=
 =?us-ascii?Q?zVI00wpz30JiK5dNtLVx7qYXubpiBYPWVXZzZs/gJwR3v1hH2hmJyLul21RO?=
 =?us-ascii?Q?hvWfz+q+XSlPzhFcVMU9m1k/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4537.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4378a871-ca37-45d4-fc20-08d8e5d52351
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2021 04:04:45.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O87GltfdSEbiuu+teCMFlI0Z3l0EBOBnhCM4hqstVhmXlR0ArE/dsdX9LbH+6LMB8hbPCUuq6yq0bDnWC02qJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2380
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

Hi David,

Which benchmark tool you prefer? Memtest86+ or else?

BRs,
Leo
-----Original Message-----
From: David Hildenbrand <david@redhat.com>=20
Sent: Saturday, March 13, 2021 12:47 AM
To: Liang, Liang (Leo) <Liang.Liang@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; linux-kernel@vger.kernel.org; amd-gfx list <amd-gfx@list=
s.freedesktop.org>; Andrew Morton <akpm@linux-foundation.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd=
.com>; Mike Rapoport <rppt@linux.ibm.com>; Rafael J. Wysocki <rafael@kernel=
.org>; George Kennedy <george.kennedy@oracle.com>
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to ta=
il in __free_pages_core()")

On 12.03.21 17:19, Liang, Liang (Leo) wrote:
> [AMD Public Use]
>=20
> Dmesg attached.
>=20


So, looks like the "real" slowdown starts once the buddy is up and running =
(no surprise).


[    0.044035] Memory: 6856724K/7200304K available (14345K kernel code, 969=
9K rwdata, 5276K rodata, 2628K init, 12104K bss, 343324K reserved, 0K cma-r=
eserved)
[    0.044045] random: get_random_u64 called from __kmem_cache_create+0x33/=
0x460 with crng_init=3D1
[    0.049025] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, =
Nodes=3D1
[    0.050036] ftrace: allocating 47158 entries in 185 pages
[    0.097487] ftrace: allocated 185 pages with 5 groups
[    0.109210] rcu: Hierarchical RCU implementation.

vs.

[    0.041115] Memory: 6869396K/7200304K available (14345K kernel code, 343=
3K rwdata, 5284K rodata, 2624K init, 6088K bss, 330652K reserved, 0K cma-re=
served)
[    0.041127] random: get_random_u64 called from __kmem_cache_create+0x31/=
0x430 with crng_init=3D1
[    0.041309] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, =
Nodes=3D1
[    0.041335] ftrace: allocating 47184 entries in 185 pages
[    0.055719] ftrace: allocated 185 pages with 5 groups
[    0.055863] rcu: Hierarchical RCU implementation.


And it gets especially bad during ACPI table processing:

[    4.158303] ACPI: Added _OSI(Module Device)
[    4.158767] ACPI: Added _OSI(Processor Device)
[    4.159230] ACPI: Added _OSI(3.0 _SCP Extensions)
[    4.159705] ACPI: Added _OSI(Processor Aggregator Device)
[    4.160551] ACPI: Added _OSI(Linux-Dell-Video)
[    4.161359] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    4.162264] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[   17.713421] ACPI: 13 ACPI AML tables successfully acquired and loaded
[   18.716065] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[   20.743828] ACPI: EC: EC started
[   20.744155] ACPI: EC: interrupt blocked
[   20.945956] ACPI: EC: EC_CMD/EC_SC=3D0x666, EC_DATA=3D0x662
[   20.946618] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle tran=
sactions
[   20.947348] ACPI: Interpreter enabled
[   20.951278] ACPI: (supports S0 S3 S4 S5)
[   20.951632] ACPI: Using IOAPIC for interrupt routing

vs.

[    0.216039] ACPI: Added _OSI(Module Device)
[    0.216041] ACPI: Added _OSI(Processor Device)
[    0.216043] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.216044] ACPI: Added _OSI(Processor Aggregator Device)
[    0.216046] ACPI: Added _OSI(Linux-Dell-Video)
[    0.216048] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.216049] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.228259] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.229527] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.231663] ACPI: EC: EC started
[    0.231666] ACPI: EC: interrupt blocked
[    0.233664] ACPI: EC: EC_CMD/EC_SC=3D0x666, EC_DATA=3D0x662
[    0.233667] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.233670] ACPI: Interpreter enabled
[    0.233685] ACPI: (supports S0 S3 S4 S5)
[    0.233687] ACPI: Using IOAPIC for interrupt routing

The jump from 4.1 -> 17.7 is especially bad.

Which might in fact indicate that this could be related to using some very =
special slow (ACPI?) memory for ordinary purposes, interfering with actual =
ACPI users?

But again, just a wild guess, because the system is extremely slow afterwar=
ds, however, we don't have any pauses without any signs of life for that lo=
ng.


It would be interesting to run a simple memory bandwidth benchmark on the f=
ast kernel with differing sizes up to running OOM to see if there is really=
 some memory that is just horribly slow once allocated and used.

--
Thanks,

David / dhildenb
