Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D133CF28
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhCPIBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:01:15 -0400
Received: from mail-eopbgr770041.outbound.protection.outlook.com ([40.107.77.41]:3301
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232733AbhCPIAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWIX0PI2tMXs+76C4RgvPIQKK1tRUevP9tuzu67zyNoFfeLXmF8qlAqEoG/8YUBeXrt2PN1nSf+qIqaclENo9a18mSqLEp0FG/B2w3V05oYCPfOQHP4xNicYZKaLjy5tx65sSkmiHq8FLwnvdOE/OQ0zBl7/7dVQQs60QXxu77yTGfnGxj3kPK9ORU9pvgKzBMZ+MRyAs0AkGC6AldgA4wLFsAcMPtIGwBqgAKht55MPYm2w57ZaTOQBV5XDSjfpiNFkFbKOjMimq96/3t9oQdcRwwBaOZ0eg1uxAZMROU2JZCIxW3A9ziH32vpaGY60eHjozwYp1VyirOZA2BSYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p673QYQMOUAKRurUQLQ1I1csTZBXJMuf8Di91xe67NE=;
 b=IUdf3K4vOY8eDk/oGKdiUUjmW/N0mjP/FS18169Xf/DHsVjK1K7xB+pIpEUCbzrapved+7J4HKlP5ZO/4mx7gDtZs+d7Xd7tVAFabjFzWWSJdrEgWPcm5xAruEbsdI7BSiNSm0imqL2F3HyIU4N86esd7ENWUxkz8LR31UMQe6OyyPs5+qUG60hgz0POtWiA13MNVkrs/n8+Ye62PN9wFHhVm4h05jN8O77cGn47OGDz4et4ZfOnrx204Y3DIrxSHESBuw0J9MFYDpU2dH8ayDvOB7KZO/qYn4KeW6VJCi2CSn7yGmV0Txmxc93+hvW4tYXkAx5KX8BeGbT5Ln+bWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p673QYQMOUAKRurUQLQ1I1csTZBXJMuf8Di91xe67NE=;
 b=Qun23Aof61Hlad4K4/UU0vpKL/Yp5Kud4zIV7Cx59OxKTJYpGoClCnCXBEqaDX0KgCjcss+jI+KJf5jFxCEqbBgz/X8QR2/OWLzMbnx+hD1VDgYa4RHGVhfyrLtkV3azKhO/mMYP4QecS95asGSArGNgU9W2+KRvifIzomkl13U=
Received: from MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22)
 by MWHPR12MB1885.namprd12.prod.outlook.com (2603:10b6:300:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 08:00:48 +0000
Received: from MW3PR12MB4537.namprd12.prod.outlook.com
 ([fe80::89a6:6618:7616:30d3]) by MW3PR12MB4537.namprd12.prod.outlook.com
 ([fe80::89a6:6618:7616:30d3%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 08:00:48 +0000
From:   "Liang, Liang (Leo)" <Liang.Liang@amd.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     David Hildenbrand <david@redhat.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
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
Thread-Index: AdcWgujrowoM8ON/Tmy0Tmhi9senVQABLLQAADBH9CAAADxQgAACUAfQAAIipgAAAPKqgAAXm64wAAqTxoAACeBtgABjC4WAABfyzTAADUrQAAACW6Iw
Date:   Tue, 16 Mar 2021 08:00:48 +0000
Message-ID: <MW3PR12MB453781F0AD49AF3787DE4230F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
 <YEzCm/Uwvw7kKpd7@linux.ibm.com>
 <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
 <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <YFBVNEC7jMZxwleL@linux.ibm.com>
In-Reply-To: <YFBVNEC7jMZxwleL@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-16T08:00:45Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=76faeda7-2a9f-422e-b183-43150b7b4171;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c63c4bdf-61be-4eba-751b-08d8e8519c69
x-ms-traffictypediagnostic: MWHPR12MB1885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1885296135016693584BF592F36B9@MWHPR12MB1885.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RxNCNO82JnXhZRhwb9WRyKXvSpSynQVSTREWU9a7/QxeL+X/l4dVNX3/OY53iPj3qxBVZQfUprxMVPjI2TFAJesapjxlOIaO2M2sHRf5/VvkSVQWLB7JUIWqCpRaO3zBAzgC9hveMOAGc4l+wNsCCEg3TOObYJrJGRbLr5Gctmtt0ru2POwCJM38zAnswN5dfIPhc0KdeWaPAYRkQfz/EoAwDCz12T5/mtK25hJxGEGq9Q287P93XfpjRo3gdhSmP6Kp4z8H502i8nopqaEOYVaoGC0ZITQsBppbmCSBsoFaS92SyeRqg0QTzEpXAAUvWlLCxft9V9WtDpyNfo+lx961FpXnahTUcEsWl6LK1wIsGEbFvlasK22RPJyCtzKYB+RD46uBZkgXmf9xZ8EVEUmWw3VLWGxwEdVk1NOgxpe7sNjT9mzwM2S4NGjDUz/lqv/87vfS2Yva+1gXyYG6vfAh7gGgRICPXVn0VNkrJOIQ2i8HrqRh+bvBl8ZCBHmMEZuMPx9afkEP3CoDZ86Uaa3JGL6DfPQxC7uCZSpybl6dco7WU+fmft9rE7pZbjHoHgPHED+5LHIS9qkPbXoyFRW3RMZrfT/AOmjyUwkgQPEGgWNj7GBzHZuLudZfTR72JWZ+bclhUNguT0z9Wf33oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4537.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8676002)(52536014)(7696005)(5660300002)(66476007)(66946007)(66556008)(54906003)(86362001)(76116006)(66446008)(478600001)(4326008)(53546011)(64756008)(45080400002)(316002)(26005)(6916009)(186003)(71200400001)(33656002)(55016002)(9686003)(8936002)(83380400001)(6506007)(2906002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wE6DvVGzhOXfqzexi8YQ3z35d+JGdMP0tlc3JHZlirq6lD9wDYw8rr61SB4I?=
 =?us-ascii?Q?DAFka3e0BgcG2DiCGPfQHRD2iDnO/xDc5kaNyzjmFl5MOBY6jTCHT3uXHuYt?=
 =?us-ascii?Q?4OZcPmYdLe3YGv928DVArYn5D39prLg/91sWyVj2vI7j4wCdIM3O9WUrsjxJ?=
 =?us-ascii?Q?oQEEvzIadBCi6ihryu40Mq24Cgs8wUvrAyrAL0pka2EKlj8V6J0wgLWsbrEr?=
 =?us-ascii?Q?JLP3Es9Z229KPL51CC0lgVuvo1pZV+GEjM0oJGRXCot/3O7LfpE6l55SHDy6?=
 =?us-ascii?Q?fvfn0Wj4+srKFHaK9dPJ6o2BYvoqCf5x2RxTHOSm8G/CGVVhrRKCpkF/Hh5D?=
 =?us-ascii?Q?kYVl4ld0L3ynLbUG49TRQXDbJKEQ/B3sW2t0ybDq2kdb+fMmbhpybducqrBb?=
 =?us-ascii?Q?mZ6S2dKJt4Bog9bc4+dkMgPevvRw3UKe8Twu2ixc98PpILv7jmUk5KFRLXZ+?=
 =?us-ascii?Q?LQayivT2u9f24NTX5pnK48eTIPVRn30XhF4lCKSMg8EYRLe+7E6kc5euVX70?=
 =?us-ascii?Q?5NxvEpArJJ3WQvN7Doy7VgGx3F+t26Xg7V1yjFyx852rGrIVK/YNFZz2osnB?=
 =?us-ascii?Q?uMiyIXYiNVkN5/KNqI+cMDhxNM6KKFTXTmYUHlONCQ1MOW+DqcXxNwgleGKj?=
 =?us-ascii?Q?26u5zoel4MG9gWxSJ4BOu2u/ahjUjcBqLTHk0+OiJwR4if/j4ObPXnAXwfDh?=
 =?us-ascii?Q?CPZguZ+DVC0tV/p5+6fUL53RxnDg8RRs8i3sXDKiQM3uWQEQQrB+9Z+abYPg?=
 =?us-ascii?Q?aqrZkgA2zfpDyxHWAzS5+reHOSssdAPxpbRk1iCaLmr4AzJu+8vX1wX4oiBQ?=
 =?us-ascii?Q?nTT2mqBmH0zyPj8VW79EE+uvB1y1ACd/9959uEjQN4c8HJ9p/lJaHtegL1U9?=
 =?us-ascii?Q?33553yuB1J33ShDa4y/cWl8UYoxSHp7j+F9WMDnbk8T9m75ajptMauQdVobY?=
 =?us-ascii?Q?eWZ00+X2hO35/WqR8Xj8RvlBXLYF1QUeB2gdE1dUicHIKh46PI9Wd4J/lVR7?=
 =?us-ascii?Q?x8QBrnoFvHlPBMhyUGrJnDFqLtO95hsejxWWlNVWa5CXFT0a42a2o41fNvXk?=
 =?us-ascii?Q?o/hpP0QSgEIh1fHJp107AcfecYQAUQcrl9EGktb7LXLgW+O8BY1NLTIQA4km?=
 =?us-ascii?Q?KS93gqgoFWca3c9xWxjcx9ahtXha0FMjD1JayCAmFnDfyZky9c44CyeZFDZ3?=
 =?us-ascii?Q?csVxm4evIf3/X7VaJojIynZ6M5amE2w1ECwartJlnsePHDx/88ths4rkk0Ve?=
 =?us-ascii?Q?maNZgQ1ubGBeywgYTHIY+C9vwocjnRbRDNI4oa48xCS/1YPKocS3Yz013yxT?=
 =?us-ascii?Q?eajptrMVGza4BK8DutkMcSJy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4537.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63c4bdf-61be-4eba-751b-08d8e8519c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 08:00:48.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gerXc8lZzX2h/o88cv/kXXBTH1pKGyEdAVPKc9KyygOoADtkRsYLHFbZvO4p0Pu71m4QclYNCgSdLFBzT6yi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1885
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

Hi Mike,

Thanks for help. The patch works for me and boot time back to normal. So it=
's a fix, or just WA?

BRs,
Leo
-----Original Message-----
From: Mike Rapoport <rppt@linux.ibm.com>=20
Sent: Tuesday, March 16, 2021 2:50 PM
To: Liang, Liang (Leo) <Liang.Liang@amd.com>
Cc: David Hildenbrand <david@redhat.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; linux-kernel@vger.kernel.org; amd-gfx list <amd-gfx@lists.fr=
eedesktop.org>; Andrew Morton <akpm@linux-foundation.org>; Huang, Ray <Ray.=
Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Rafael J. Wys=
ocki <rafael@kernel.org>; George Kennedy <george.kennedy@oracle.com>
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to ta=
il in __free_pages_core()")

Hi Leo,

On Tue, Mar 16, 2021 at 12:36:29AM +0000, Liang, Liang (Leo) wrote:
>=20
> Hi David,
>=20
> Sorry for late. If revert 7fef431be9c9 (without 7fef431be9c9), the dmesg =
attached. And looks the exception as below:
> [  +0.027833] [0x0000000078000000 - 0x00000000783fffff] 20925 MB/s /=20
> 25405 MB/s [  +1.363596] [0x0000000100000000 - 0x00000001003fffff] 222=20
> MB/s / 222 MB/s [  +1.562192] [0x0000000100400000 -=20
> 0x00000001007fffff] 222 MB/s / 222 MB/s [  +1.881332]=20
> [0x0000000100800000 - 0x0000000100bfffff] 195 MB/s / 159 MB/s [ =20
> +1.383388] [0x0000000100c00000 - 0x0000000100ffffff] 219 MB/s / 221=20
> MB/s [  +0.029342] [0x0000000101000000 - 0x00000001013fffff] 19807=20
> MB/s / 24125 MB/s
>=20
> What is the problem here? Do you want to check the acpi tables?

As it seems the first 16M at 0x0000000100000000 are two orders of magnitude=
 slower than the rest of the memory as if there is a different memory devic=
e there.

This would explain why with 7fef431be9c9 everything gets slower as we alloc=
ate the first (and probably quite critical) data from those 16M.

No idea how this could be related to ACPI and why ACPI initialization cause=
s the huge slowdown on its own.

Can you please try booting with 7fef431be9c9 still applied and with this pa=
tch (not even compile tested):

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c index d88317=
6ef2ce..780f11ca14c9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -778,6 +778,7 @@ void __init setup_arch(char **cmdline_p)
 	 * L1TF its contents can be leaked to user processes.
 	 */
 	memblock_reserve(0, PAGE_SIZE);
+	memblock_reserve(0x0000000100000000, SZ_16M);
=20
 	early_reserve_initrd();
=20
=20
> BRs,
> Leo
> -----Original Message-----
> From: David Hildenbrand <david@redhat.com>
> Sent: Monday, March 15, 2021 9:04 PM
> To: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Liang, Liang (Leo) <Liang.Liang@amd.com>; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; amd-gfx=20
> list <amd-gfx@lists.freedesktop.org>; Andrew Morton=20
> <akpm@linux-foundation.org>; Huang, Ray <Ray.Huang@amd.com>; Koenig,=20
> Christian <Christian.Koenig@amd.com>; Rafael J. Wysocki=20
> <rafael@kernel.org>; George Kennedy <george.kennedy@oracle.com>
> Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages=20
> to tail in __free_pages_core()")
>=20
> On 13.03.21 14:48, Mike Rapoport wrote:
> > Hi,
> >=20
> > On Sat, Mar 13, 2021 at 10:05:23AM +0100, David Hildenbrand wrote:
> >>> Am 13.03.2021 um 05:04 schrieb Liang, Liang (Leo) <Liang.Liang@amd.co=
m>:
> >>>
> >>> Hi David,
> >>>
> >>> Which benchmark tool you prefer? Memtest86+ or else?
> >>
> >> Hi Leo,
> >>
> >> I think you want something that runs under Linux natively.
> >>
> >> I'm planning on coding up a kernel module to walk all 4MB pages in=20
> >> the freelists and perform a stream benchmark individually. Then we=20
> >> might be able to identify the problematic range - if there is a=20
> >> problematic range :)
> >=20
> > My wild guess would be that the pages that are now at the head of=20
> > free lists have wrong caching enabled. Might be worth checking in=20
> > your test module.
>=20
> I hacked something up real quick:
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> ub.com%2Fdavidhildenbrand%2Fkstream&amp;data=3D04%7C01%7CLiang.Liang%40a
> md.com%7Cb569c2890cd14a555dcd08d8e847cea6%7C3dd8961fe4884e608e11a82d99
> 4e183d%7C0%7C0%7C637514742399803857%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd
> ata=3D7Mj%2BBlp%2BDZNg3grEYMnDyx%2FLGkZYu0YPfstiByD6UCk%3D&amp;reserved=
=3D
> 0
>=20
> Only briefly tested inside a VM. The output looks something like
>=20
> [...]
> [ 8396.432225] [0x0000000045800000 - 0x0000000045bfffff] 25322 MB/s /
> 38948 MB/s
> [ 8396.448749] [0x0000000045c00000 - 0x0000000045ffffff] 24481 MB/s /
> 38946 MB/s
> [ 8396.465197] [0x0000000046000000 - 0x00000000463fffff] 24892 MB/s /
> 39170 MB/s
> [ 8396.481552] [0x0000000046400000 - 0x00000000467fffff] 25222 MB/s /
> 39156 MB/s
> [ 8396.498012] [0x0000000046800000 - 0x0000000046bfffff] 24416 MB/s /
> 39159 MB/s
> [ 8396.514397] [0x0000000046c00000 - 0x0000000046ffffff] 25469 MB/s /
> 38940 MB/s
> [ 8396.530849] [0x0000000047000000 - 0x00000000473fffff] 24885 MB/s /
> 38734 MB/s
> [ 8396.547195] [0x0000000047400000 - 0x00000000477fffff] 25458 MB/s /
> 38941 MB/s
> [...]
>=20
> The benchmark allocates one 4 MiB chunk at a time and runs a simplified S=
TREAM benchmark a) without flushing caches b) flushing caches before every =
memory access.
>=20
> It would be great if you could run that with the *old behavior* kernel (I=
OW, without 7fef431be9c9), so we might still be lucky to catch the problema=
tic area in the freelist.
>=20
> Let's see if that will indicate anything.
>=20
> --
> Thanks,
>=20
> David / dhildenb



--
Sincerely yours,
Mike.
