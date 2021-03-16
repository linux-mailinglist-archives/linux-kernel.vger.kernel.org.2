Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33BF33D264
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhCPLDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:03:19 -0400
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:41344
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237009AbhCPLCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:02:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLReizCh6AIOsZkghEWlmhDuKlR91cc1kKi73O9wiWRPgl9XFf5OpMziYiuOCZxFpRKt+WHf5NeVYdspCaHbTMma2VVf03+XnbIda0SpV6Q/dW2FzKJBUrX/Zsu80SWJR2N8V4ex//51fSgFtsAuPXbepU53se7MdT5n3ehwqe6q7FMPBuxxU2IVsBCgkgmJ/YwqdXKzbYUQyWJuHEGOqVxiBnnqj66KZ+I65Vad7Gtwa5dwJDK1IcrObDf8amJ+4LgYecUO623xFsRQpSPKU/DCb5pCgSdjxhf1Dh4vIDc2n2zhoMOq67dAeiOZieK2EkzBqtcVgxXMkuFEEbKKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjryUfD/d3X/VWgCD3BVo18wwGFSl0ztGRk0w7j82CM=;
 b=jyGvPkIggZUN/AhwhsFgmkNu6CDR+pG5d8nFtJx/cWGpQGzm8/jjx9zkj5I9teZEP0mMlwKyFELfEADf4FfFF9kqbnTbmQA1XJmKzXHDUgYWsxssTnbpLLEGmr8dag3TikDqbZfVOqiRztTAuHCO50/Hu3jUXn5cq+duea5RupFLKX6mviItt+UDX6i9KsTur9iZPTjXAGDZvG1WamgsIbw3qfalcPDFn8w3e0GgACG/NtD2tcen9zH1BdfY6DA/yIzVrqscqsmaA95j+zmVdkfEOIiK1HjmowyLXUvixzSnGzV0giGky7fuZT7Jxf7aJLum42F4ZE0N0ggen3s+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjryUfD/d3X/VWgCD3BVo18wwGFSl0ztGRk0w7j82CM=;
 b=3KdG/+aKQGqSU4hh5KZid6+F3IFQQj6F/HTtmnzkhBrTbqqOfAZhJWsh6uoZt4SAVe+mB8GED8R/h2V4M2xq20F/S8FZ6YW1CZWDhF3k7SbjLXXlRnVhTuncAoVRLx+udMCPS6iXBulzv6K9Ix5Nm1W4ClUjhNCf2o1cnKieOxA=
Received: from MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22)
 by MWHPR12MB1581.namprd12.prod.outlook.com (2603:10b6:301:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 11:02:50 +0000
Received: from MW3PR12MB4537.namprd12.prod.outlook.com
 ([fe80::89a6:6618:7616:30d3]) by MW3PR12MB4537.namprd12.prod.outlook.com
 ([fe80::89a6:6618:7616:30d3%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 11:02:50 +0000
From:   "Liang, Liang (Leo)" <Liang.Liang@amd.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
Subject: RE: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Topic: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Index: AdcWgujrowoM8ON/Tmy0Tmhi9senVQABLLQAADBH9CAAADxQgAACUAfQAAIipgAAAPKqgAAXm64wAAqTxoAACeBtgABjC4WAABfyzTAADUrQAAACW6IwAAFkAQAAABiCsAAAefiAAAAZaSAAAGOcAAAC26YAAAEAFQA=
Date:   Tue, 16 Mar 2021 11:02:50 +0000
Message-ID: <MW3PR12MB4537C3C6EFD9CA3A4B32084DF36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
References: <YEzCm/Uwvw7kKpd7@linux.ibm.com>
 <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
 <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <YFBVNEC7jMZxwleL@linux.ibm.com>
 <MW3PR12MB453781F0AD49AF3787DE4230F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0cc972a1-5b40-3017-33f8-b2610489ee18@redhat.com>
 <MW3PR12MB453771424C9B2866BBBAE036F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <b9b324e4-4c98-b81d-ddae-52e4feb33064@redhat.com>
 <MW3PR12MB4537B6D5911092E456220818F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <9e869214-7a3b-e86d-4832-7117f7c6090f@redhat.com>
 <YFCIqLmn3u1be1yo@linux.ibm.com>
In-Reply-To: <YFCIqLmn3u1be1yo@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-16T11:02:46Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=878b45ed-7788-45ed-917d-680e32be57ba;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4586f360-16fe-47ef-3b66-08d8e86b0a27
x-ms-traffictypediagnostic: MWHPR12MB1581:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB158123D116676E6972591A85F36B9@MWHPR12MB1581.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5K5tewTuwkMe7kCQTvCIcAX8qqqcDFtZVA69yl9zNQiV20YY6Z86keOtrQuN09szEImJQrDtQKxrzkSpU1j6OUU58csNloTf1gsTdO/iWfTBcEKPVR3BG/kUAkiTnkpCjnv9Yy6M6Ciee+l1US2J1pZEj9h3BChoUbwoMKGZHCDv1KXameWXEIqsf+xkvztYvxBaMZCxqbAQRPt/rsihofb7KkwtNrA84Qcdhk0S07+aLbzs0z0iyqdPzYuks6f2P3a8dr1YvXyV1vGzBEh95xZhMh2Kn6h+CHnxbRyHT/RX0S8lSc/y3jV9VYxU8QJsEjNNNvTFrWOMtJNs93K5o4fBqKXAhBpGvIQp1JkFlxMbwhOdQe3U6EpG3oaps8v0Ed+5qv4qOtF2YRa0gbHjvjo2N6mF1C38SjASr7lrGl+0y5SpiouDXVN3S0Ae5lsDYeifXI1sFpBCpziMoP64cJKg27b+UJWqsd8UvjKX+WURhcyV3awBMx2ImKP/fzN+MbTQe6cnYq469QSVeV+K6/jUkhYg1pQiWD7Xpn1z1RsoPAAGCCUmM2snFBJtihBslME/79JNyp2QeYihPQR+0qBdkS8EXep/KDovE5Wkpdul7i1n6OORjuM/ups6Cwr537F+GL/b6Lj0sNEc2bWUng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4537.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(54906003)(966005)(66946007)(110136005)(76116006)(66446008)(64756008)(8936002)(66476007)(6506007)(5660300002)(66556008)(52536014)(8676002)(71200400001)(33656002)(478600001)(86362001)(9686003)(45080400002)(83380400001)(186003)(316002)(26005)(2906002)(53546011)(7696005)(4326008)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vCcJxdDGWJuSWFkPKUm8bRomg0a5R5Au6MAKKOOxTO3BYTZy2OZdW2Wj7LWm?=
 =?us-ascii?Q?PsMu2YrP6F9t9ocT94OwS4BPReCpAvZBzwFvnCkPnGANZiA9H+Dy9NcD+3GQ?=
 =?us-ascii?Q?aEmBh/QV6LkOExjuWBZ9EHfn5QGN/Xaq0A+KtAj0GezVAH8fmvJTTWr3sXFv?=
 =?us-ascii?Q?6wZ/t/7dJ6r/a3SAWCM6uKNLJFT8+/sW+1S8oIFH5uEYFan0RtSVCGURErlK?=
 =?us-ascii?Q?j9uu5hVSOhjV15Go8wZ9t8ksmjXnUumB70rwEzGgyQu80TqSBRWWQZidI0di?=
 =?us-ascii?Q?Bvx3B8llibbQhC7wUOzObbNpILrix9KrnKBt2hqLOVmteL82RhZUKIf/npSU?=
 =?us-ascii?Q?iZgKC6PpGlX/470ARXYDQAfP4jG4drwao0ypz09oaEH7sxDnY7Oew+aaaPZU?=
 =?us-ascii?Q?QoMZO6poTsBNl71w8ygPAHCQzoqbmPSdD8PiJyyT/ipz5czCJPBjStfEOYC1?=
 =?us-ascii?Q?aozbgD0h7xaKrmcP67yhW+ZOltpWJdp32tQ+JnbYGmRnV/+xUGqo8Iqg3fQ2?=
 =?us-ascii?Q?+uuIGpXTSI9zR5L9X8+PzrycDXS79/bMc56nO3fNJQrRh1mqPT23eTGFTSgH?=
 =?us-ascii?Q?GFqPZtlML/hmJ9aW3wVddUKPlvq1nHxwuNq448Eui4AjxzAGxt/TPGChCyUk?=
 =?us-ascii?Q?9ypEu52p4oo+Hsd3EBRvJ7Kmjo2Ier3ltEKDXu6QKQmR24xdTV/FzfXRF014?=
 =?us-ascii?Q?n8uApIzNd+4Zf1bemqfK6iyyHd3lthNsrUPJ3MTIy716e7mphv3m4y5TLUP3?=
 =?us-ascii?Q?f3Y9ivboIfHOdA7IgIcuOwgrTZPfVM8jGJeu0ASf0dGyn6nuH+GpGhF6CFdQ?=
 =?us-ascii?Q?OzdE6FPFCLb0wnJUejAnXDgspTw2rT2U1pcbY6wP5Ul82ZejSVy92ODogflm?=
 =?us-ascii?Q?5JgvNN8ya8CcaAExwwbbozr0HjcwrryrL/UIHqyr8lVdvmNDVYzBMwULykzv?=
 =?us-ascii?Q?tLkljgSzFuRmm6k+q4YcEWpI1ZlTgQBETCSBT0uBHwjvXhXnIGFLw9230J+Z?=
 =?us-ascii?Q?EmgcwozBnbUbkw3Zyrhgk9AdzYkUPuRNf+zeNEoYgbR4oSSEKjqiY1nIyoYb?=
 =?us-ascii?Q?UpL+KNJFC7WGqr2BVjBd4XfUCm0faPQ/iCR018ZJ67rkKy1PjOIcryyibJDC?=
 =?us-ascii?Q?6AT0a8Q8q4WOREy1pcNLXtE5PaQUsdBrTMmDZzDywFGp4WRiV4jqI4BERMu3?=
 =?us-ascii?Q?fB5hLdFgbSc6g6Ek7q/3BkWP/LWUPEfv64ROM9+ajx7kattb2XH12r7d1ht4?=
 =?us-ascii?Q?ZH8x6MS0ICah5AHSm5lcP2ukoOcVdm3D07ua1MYNuG/woY+jbK52wqOs8Os9?=
 =?us-ascii?Q?kblDDma+T4GpV6ZUPKcm+XdG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4537.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4586f360-16fe-47ef-3b66-08d8e86b0a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 11:02:50.1088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUiVsCUF0hV6QXdQily2fpmV35SEDM6djY6Dbu33DygigJfN7NxrU9E9vDSgU2aVJFC7ZMt9cS+9ij/6DTlymQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1581
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

Hi David and Mike,

It's BIOS buggy. Now fixed by new BIOS. Thanks you so much! Cheers!

[    0.000034] MTRR variable ranges enabled:
[    0.000035]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000037]   1 base 0000FFE00000 mask FFFFFFE00000 write-protect
[    0.000039]   2 base 0000FFDE0000 mask FFFFFFFE0000 write-protect
[    0.000040]   3 base 0000FF000000 mask FFFFFFF80000 write-protect
[    0.000041]   4 disabled
[    0.000042]   5 disabled
[    0.000043]   6 disabled
[    0.000044]   7 disabled
[    0.000045] TOM2: 0000000280000000 aka 10240M

root@scbu-Chachani:/home/scbu# cat /proc/mtrr
reg00: base=3D0x000000000 (    0MB), size=3D 2048MB, count=3D1: write-back
reg01: base=3D0x0ffe00000 ( 4094MB), size=3D    2MB, count=3D1: write-prote=
ct
reg02: base=3D0x0ffde0000 ( 4093MB), size=3D  128KB, count=3D1: write-prote=
ct
reg03: base=3D0x0ff000000 ( 4080MB), size=3D  512KB, count=3D1: write-prote=
ct

BRs,
Leo
-----Original Message-----
From: Mike Rapoport <rppt@linux.ibm.com>=20
Sent: Tuesday, March 16, 2021 6:30 PM
To: David Hildenbrand <david@redhat.com>
Cc: Liang, Liang (Leo) <Liang.Liang@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; linux-kernel@vger.kernel.org; amd-gfx list <amd-gfx@list=
s.freedesktop.org>; Andrew Morton <akpm@linux-foundation.org>; Huang, Ray <=
Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Rafael J.=
 Wysocki <rafael@kernel.org>; George Kennedy <george.kennedy@oracle.com>
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to ta=
il in __free_pages_core()")

On Tue, Mar 16, 2021 at 10:08:10AM +0100, David Hildenbrand wrote:
> On 16.03.21 09:58, Liang, Liang (Leo) wrote:
> > [AMD Public Use]
> >=20
> > Hi David,
> >=20
> > root@scbu-Chachani:~# cat /proc/mtrr
> > reg00: base=3D0x000000000 (    0MB), size=3D 2048MB, count=3D1: write-b=
ack
> > reg01: base=3D0x0ffe00000 ( 4094MB), size=3D    2MB, count=3D1: write-p=
rotect
> > reg02: base=3D0x100000000 ( 4096MB), size=3D   16MB, count=3D1: write-p=
rotect
>=20
> ^ there it is
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwiki
> .osdev.org%2FMTRR&amp;data=3D04%7C01%7CLiang.Liang%40amd.com%7C49c791cc6
> 18745b8c35208d8e86679a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37514874126576401%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D667IK3Bnyx5uP3
> rKN8bOjW7A2MBuM1sLCg98m1LCIGo%3D&amp;reserved=3D0
>=20
> "Reads allocate cache lines on a cache miss. All writes update main memor=
y.
>=20
> Cache lines are not allocated on a write miss. Write hits invalidate=20
> the cache line and update main memory. "
>=20
> AFAIU, writes completely bypass caches and store directly to main=20
> mamory. If there are cache lines from a previous read, they are=20
> invalidated. So I think especially slow will be read(addr),=20
> write(addr), read(addr), ... which is what we have in the kstream benchma=
rk.
>=20
>=20
> The question is:
>=20
> who sets this up without owning the memory?
> Is the memory actually special/slow or is that setting wrong?

I really doubt that 16M at 0x100000000 in a system with 8G RAM would
*physically* differ from the neighbouring memory.

> Buggy firmware/BIOS?
> Buggy device driver?

[    0.000027] MTRR default type: uncachable
[    0.000028] MTRR fixed ranges enabled:
[    0.000030]   00000-9FFFF write-back
[    0.000031]   A0000-BFFFF uncachable
[    0.000032]   C0000-FFFFF write-through
[    0.000033] MTRR variable ranges enabled:
[    0.000034]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000036]   1 base 0000FFE00000 mask FFFFFFE00000 write-protect
[    0.000037]   2 base 000100000000 mask FFFFFF000000 write-protect

As we have the range at 0x100000000 write-protected reported that early in =
boot I'd say it's BIOS.

The question is how to reliably detect that this is a bogus setting...

[    0.000038]   3 base 0000FFDE0000 mask FFFFFFFE0000 write-protect
[    0.000039]   4 base 0000FF000000 mask FFFFFFF80000 write-protect
[    0.000040]   5 disabled
[    0.000041]   6 disabled
[    0.000042]   7 disabled
[    0.000042] TOM2: 0000000280000000 aka 10240M


--
Sincerely yours,
Mike.
