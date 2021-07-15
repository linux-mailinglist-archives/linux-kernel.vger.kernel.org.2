Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF63C94C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 02:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhGOALo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 20:11:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17882 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233279AbhGOALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 20:11:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16F05IlX014679;
        Thu, 15 Jul 2021 00:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xwtb+cnlYtkyPYOkF/qbw9l6rYSlyQyAX6y4Cbblq4U=;
 b=0we78f+JZGXdZjTd46Fe9q6o7w4ZX6PbqoSBXJjLHa6j95lj7PGIRm/svNkzUwZ+dXzZ
 1d7dC6/4X+Ln5VcNfUuo5bigjbKERJML0A/owYAPh0YV+qsEAD24fF+ix+mjFyOyaJOq
 qW+t8rRjYZs7JhGiDISouasyCj72wk64lGuxBbj6E5wLNcktbBEIit3NCwwHs313PBbA
 afiGILXoLViWSAHEw0dgTChXdaKEfiMy0DgtbKiWS89IlLMbigRLNgx6fzRHuE1urdvf
 O+kVEoG6gm5PuBzB1qRtZBDSwBn/ziXM0Zqo8iliQEkMji/YOYjSqFXSKXhgrmu8+fQb cg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xwtb+cnlYtkyPYOkF/qbw9l6rYSlyQyAX6y4Cbblq4U=;
 b=bMt3UdPbDIthLZzhKihAzmgZyqcAp2iomhUG53oKEHDQiSU07/6LBfzkrzQ9NHyRIiht
 W2QEFlAfIUc+w+gxj+EehXdGiaSirdtcVPGA5gl2Wp0Ir5sJcwF7KAYaL3B9WYeBPWS7
 G1Q2gGeGRh62t7IokCm/QAS2AY10b760CM1ZlEFwFbGgMYfZKVYwMkrW8hzY10Hrv9qG
 hIQjZq162EzHgxwVa87+kzQFi/pRPaqx6yzGI+QJ6wPyypab7G5lWbtrDXNQW7CI1075
 FzVelWrrVAgYNButfE9IOeParJYLzDbirDo8v6u3benUMsDiRzhB2F4PXEBN0XcxXDUe RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39t2fcgwkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 00:08:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16F04wDW173495;
        Thu, 15 Jul 2021 00:08:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 39qyd1r4hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 00:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=casBKAqmcs21tf43ROr2hs3ATrnEJcpKt5aBMdUM/7ZTa8gx781tEfzyH6nHoWwgBH4qSGogmmMdmGGDW7LLdHr+IBp8SVnBhz+2UVJ9oZ+MvpvRMkAp2F5dNL7z4Rzzm3FDx3O8xK0f68ntSZ+XTzvkz9LYZUJ34539QbhnErAxRD0M9A67C2bpufkNlvAQVWWw7MEYcSOq/lI/dXOLsLopTjma4m/304gzcj9Igmzgs4zHQgMfoWcccmSGVQxij/MXyfasDcJrrWaQXySwl1ksGVKvFQgXmEiWohbsmofZwEZI3bwmyITjGFaXVHuj1A7TAfXosNMURXSx58ck7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwtb+cnlYtkyPYOkF/qbw9l6rYSlyQyAX6y4Cbblq4U=;
 b=MhIzW1oZGpgN60QE+xT9YngUv+xgvULGdlCmfZ+Io5LP+e/BUF4eHFzAWjfSpNUbAqwiEpS+Ri8mE9r/UGRUX3zGfehUeYrs7kxe5OcTxf8dKquPLJ2FLQTybnnJ9wH1FjtW2bLzNCuEhKheDBju+crMcr23+V53S5tmpQdERpQcnt3QuGBJdENZVKZS8uVHIgBxW0LQcVumamOe5lVcC649Xx8s89vfvxVY1Xp8Ctt8MYzv4bPrnqSrjBe6RTZ4Ra+o0UhWZMGMQTi3QZqby/ueEbl3MZf4xa2KV8mujwlyoL1fB3F3Q5qhMdyVvvqtN0HWgg6hazyJXIyMWSqPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwtb+cnlYtkyPYOkF/qbw9l6rYSlyQyAX6y4Cbblq4U=;
 b=Woexyx3REUAWp6f/llGbEAjWZpydhdg2DRNZdylWSYXsZbVHZlv53C2fj5Vl8r/DtfbPHSJ/GoPhlcHBkWkkaI2xNLDgEdkP8KGXWdf1jV4TZ6UW4b7Y4vWairKdTJ0iELai1Lu5lJHCw6kHHpFmfss7f8N4UPpHKE1qiKum6Dc=
Received: from MN2PR10MB3949.namprd10.prod.outlook.com (2603:10b6:208:186::11)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Thu, 15 Jul
 2021 00:08:28 +0000
Received: from MN2PR10MB3949.namprd10.prod.outlook.com
 ([fe80::cdfd:7130:67a7:ae3c]) by MN2PR10MB3949.namprd10.prod.outlook.com
 ([fe80::cdfd:7130:67a7:ae3c%5]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 00:08:27 +0000
From:   Henry Willard <henry.willard@oracle.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tabba@google.com" <tabba@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "joe@perches.com" <joe@perches.com>,
        "nixiaoming@huawei.com" <nixiaoming@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: kexec: add support for kexec with spin-table
Thread-Topic: [PATCH] arm64: kexec: add support for kexec with spin-table
Thread-Index: AQHXeNdy4Egx+MsUV0yL1h4goesGLqtCz7qAgABZpwA=
Date:   Thu, 15 Jul 2021 00:08:27 +0000
Message-ID: <A5B4FB88-ECDA-43D6-9369-93F2096D7EAE@oracle.com>
References: <1626284473-1168-1-git-send-email-henry.willard@oracle.com>
 <20210714184733.GB28555@C02TD0UTHF1T.local>
In-Reply-To: <20210714184733.GB28555@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7bd052c-4133-4b70-6fdc-08d94724abef
x-ms-traffictypediagnostic: MN2PR10MB4288:
x-microsoft-antispam-prvs: <MN2PR10MB428818A3E1FEE1FF57B8F3A18C129@MN2PR10MB4288.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlObCKllM+D1WSMm2DtYwiJU50VbftjzTCqWo8a4pgeDpTUvqOLuMUnIZJAbFgf6bNBWWAAk//Mye0WRZONMFQ8SVTs1ISeIbxN0SJChm0z29aOeJPg6aWfxl313lTuQgmzY7PKYOSq+Er2nMFOpu+TuL6iyenIruad5ugXhv/pfvxLJMEz/+kysTEEhUcGXF/Rxhtn9SBIGhm/PyVPDwuDPWTFV9T65Ynokt85wIYKTJ64GsamCSV8Di2NJ0WXciP3+bUYyIuq+HjiLbSq58ziiNimZVQ4nS+6+lqeqG/04JyXdTW/rQVvOa1iUUPFjOireTwBy95yUDp4yvbvetV5SfR/0hduSA+u8BRhtGIseOg+HnY+gKF4mT4v+obe/9mDuLpZTNatrQLX4RHaGVsAJVCE6910MrVwCh78WBfhntoecld8XH5Pl8AzMhySY+EXzAswRk5DpKzbcxP733KJYcEDH3fV7Gm8FRA2libkQ+KsiHlssE9Ht6a8kOa8jLcd0SmZgiUTK/ZUV9IvOxRcel99CuMmv37rIjdAu5RjURSfxW/wkKXrRLd+8gmCwlq3LYUqBIyav/T97+fgPZFjbWGMUBcMJRhteJ9FPdUIN2Gf0i7nOy1c4ry5aAVnSqWAYNvttZb6Cq7vX0zPzVqVel9b7pRpDn4nY4xEDB+6jzQah4D9UOuqTLMBnyv9DWIznbFuGnjR1RSNnVnZ2es9PB8mj+bFu5+/3AEdScdWr/xzC7H41yq1+R8T5YKlb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3949.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(376002)(396003)(366004)(5660300002)(8936002)(44832011)(66946007)(86362001)(66446008)(66556008)(66476007)(64756008)(91956017)(2906002)(76116006)(6512007)(6916009)(83380400001)(186003)(36756003)(71200400001)(6506007)(7416002)(2616005)(316002)(53546011)(122000001)(8676002)(4326008)(478600001)(33656002)(6486002)(38100700002)(54906003)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bVAH9KaYDmBpUUwgXwXRO1UPYcPlicXjvmx5kPEEt5AYST+YHucQrtOQSgaF?=
 =?us-ascii?Q?wd7PExycfMSMVtRLz9rvG65F5rLyDuKFQL5H0B8ybWSecgjiUdmc/9J9PXW4?=
 =?us-ascii?Q?xlrGZKeUqLttTLRZGZ7tl53blZ3FEs53txWuF2d2I4xUv97smxeQEXpGkk+l?=
 =?us-ascii?Q?T23VhqeNHjCvW9GorcsjiuVZkPjCyZ6YJjXzM9vU9BdS36v6eF+dTcCIB50b?=
 =?us-ascii?Q?Ii3+HFjjdxPYHo76e5GRkwgjIZ3CZj01TWMOPwU4/+epeQNOf42iCFmyzgtB?=
 =?us-ascii?Q?JqEQ0EjSQisHvwA6L4c1UV5bXjgnPMWIHYgGkau1W2rSMiz6TJxgV0Wl7rVp?=
 =?us-ascii?Q?rZcYWClJY724ZMg0TS7f31rp2X2ljJaAvZ0+UQKrlp30get5U9AeGW1rTmre?=
 =?us-ascii?Q?mqy19W23Qh3j9k7qUUrGkgCZssNu4FKHU+mke5agf4Nksj7RdGIg+kHNKhCd?=
 =?us-ascii?Q?5T3axW5ntwkRA5jrmdF+mSubR7LUu+6BF0zvU5tj0Vtm48ecoIDPv1wRM44b?=
 =?us-ascii?Q?c97EpeHAwV0FmzFJMkK3WmaySeahDWnCm59HWQj9q4t3PPDichBG+dvBGsg0?=
 =?us-ascii?Q?SbUd7+jPBq3hF5s/6OCIeHs+b5nMdp41uyObYHzeeF8miKFnokxXPipE983q?=
 =?us-ascii?Q?WSGO7tLQtUPWjPkF4NtyDNnPaoQE0I5fxgRtbsFp2di+GrwWvn5olEupUR4h?=
 =?us-ascii?Q?8Zhv52Y8UkKnudMS/hDnS2CmatIwjAZngoPAiH8SUYE9UDdZwbpsIEJmmBfO?=
 =?us-ascii?Q?lhesy35orz0xqFoij6f4K0wn+VfjSOlQeOaRqAh69/aDkK7+R8AdtvzlDvBX?=
 =?us-ascii?Q?8rJ5q1mpStW3FqsghkLm8VP2dT2+Q+iBM/NTvymm97Eja5gf5k/zr2HRdsCV?=
 =?us-ascii?Q?ZWoy+ItGv/LpgBJQe+R+aQ0LABqYJUrgO9VDUKUzLYDfwggM9I1KMVbcQfXr?=
 =?us-ascii?Q?7KkW2fCJa0PzrHC3EE2sv1wZ5j2DKcYRYXFpCqUYIqGJ7SdoNQfrUVYgFAsz?=
 =?us-ascii?Q?Toe1kZxaXFAYw/qJytZLyCrDzaKD4u/1h8cgst1eWXRMIRft9VgYvrUCFQ69?=
 =?us-ascii?Q?+0o0ACqQku1YVSC7AcyB8cRF6HtO5ewc+eq8r1XqVj57HU4HgiuvEvWnOMoW?=
 =?us-ascii?Q?eHV5OfuJxL4apQNJOcMIMGLGq3qABOJ6hSWX9cX0d61LUczTmw8D7cSz/jgV?=
 =?us-ascii?Q?67kEKggr1CKLwYDBCx8BhxwRcQt4Uggg5kXX1hzLRkGSBh1s04xveJAhKXUf?=
 =?us-ascii?Q?BVfrJpIQ8Jr6pBDKdfewVnfdbOHsm3LbQUc60dmCO7I86qcXwzUrykmG0Hdi?=
 =?us-ascii?Q?/Jc5+aKhAtq3sCbQjSw2CGngMoNjlWUL2y7pPEdgSkQ7P3nSrUp6hI/y6iee?=
 =?us-ascii?Q?SN4TOuQY01hKniwSExyTcetgEwsI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B304CF1349C734449869897F052BCA9B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3949.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bd052c-4133-4b70-6fdc-08d94724abef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 00:08:27.6997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBeGu590nFXMsWC8DENdyCPXaCIDNUBB1F88OjMfTuDiyqzRs+IArtxjYOGxEbFIs8I0xk+bncluz4X6A91N6dbDt0f7R5IxXDi+/06clWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140149
X-Proofpoint-GUID: qgrtlcrjK1chKUD2oo05A-cMXC4To114
X-Proofpoint-ORIG-GUID: qgrtlcrjK1chKUD2oo05A-cMXC4To114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark,
Thanks for reviewing this. I am not in a position to go into too much detai=
l about the particular device, but the u-boot we are using is the u-boot we=
 have to use, at least for now. We would have preferred to have PSCI, but t=
hat option is not available. Modifying u-boot is not an option.

It is possible to do this without relying on the spin-table loop. I impleme=
nted such a version using the kexec code control page before I got my hands=
 on the device actually using spin-table. That implementaiton needed change=
s in a lot of places, because the secondary CPUs had to leave the code cont=
rol page before the boot CPU enters the new kernel. Reusing the spin-table =
loop simplified things quite a bit.=20

This has been useful to us, so we thought we would pass it along to see if =
it is useful to anyone else in the same situation.

> On Jul 14, 2021, at 11:47 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>=20
> Hi Henry,
>=20
> On Wed, Jul 14, 2021 at 10:41:13AM -0700, Henry Willard wrote:
>> With one special exception kexec is not supported on systems
>> that use spin-table as the cpu enablement method instead of PSCI.
>> The spin-table implementation lacks cpu_die() and several other
>> methods needed by the hotplug framework used by kexec on Arm64.
>>=20
>> Some embedded systems may not have a need for the Arm Trusted
>> Firmware, or they may lack it during early bring-up. Some of
>> these may have a more primitive version of u-boot that uses a
>> special device from which to load the kernel. Kexec can be
>> especially useful for testing new kernels in such an environment.
>>=20
>> What is needed to support kexec is some place for cpu_die to park
>> the secondary CPUs outside the kernel while the primary copies
>> the new kernel into place and starts it. One possibility is to
>> use the control-code-page where arm64_relocate_new_kernel_size()
>> executes, but that requires a complicated and racy dance to get
>> the secondary CPUs from the control-code-page to the new
>> kernel after it has been copied.
>>=20
>> The spin-table mechanism is setup before the Linux kernel
>> is entered with details provided in the device tree. The
>> "release-address" DT variable provides the address of a word the
>> secondary CPUs are polling. The boot CPU will store the real address
>> of secondary_holding_pen() at that address, and the secondary CPUs
>> will branch to that address. secondary_holding_pen() is another
>> loop where the secondary CPUs wait to be called up by the boot CPU.
>>=20
>> This patch uses that mechanism to implement cpu_die(). In modern
>> versions of u-boot that implement spin-table, the address of the
>> loop in protected memory can be derived from the "release-address"
>> value. The patch validates the existence of the loop before
>> proceeding. smp_spin_table_cpu_die() uses cpu_soft_restart() to
>> branch to the loop with the MMU and caching turned off where the
>> CPU waits until released by the new kernel. After that kexec
>> reboot proceeds normally.
>=20
> This isn't true for all spin-table implementations; for example this is
> not safe with the boot-wrapper.
>=20
> While, I'm not necessarily opposed to providing a mechanism to return a
> CPU back to the spin-table, the presence of that mechanism needs to be
> explicitly defined in the device tree (e.g. with a "cpu-return-addr"
> property or similar), and we need to thoroughly document the contract
> (e.g. what state the CPU is in when it is returned). We've generally
> steered clear of this since it is much more complicated than it may
> initially seem, and there is immense scope for error.
>=20
> If we do choose to extend spin-table in this way, we'll also need to
> enforce that each cpu has a unique cpu-release-address, or this is
> unsound to begin with (since e.g. the kernel can't return CPUs that it
> doesn't know are stuck in the holding pen). We will also need a
> mechanism to reliably identify when the CPU has been successfully
> returned.
>=20
> I would very much like to avoid this if possible. U-Boot does have a
> PSCI implementation that some platforms use; is it not possible to use
> this?

Unfortunately, no. If we had that we would never have bothered with this.

>=20
> If this is for early bringup, and you're using the first kernel as a
> bootloader, I'd suggest that you boot that with "nosmp", such that the
> first kernel doesn't touch the secondary CPUs at all.

The particular case that spawned this is past that. There are a number of r=
easons why we need to be able to kexec a new kernel. Being able to bypass t=
he kernel installation process, which is a little more complicated than nor=
mal, to test a new kernels is an added benefit.

>=20
>> The special exception is the kdump capture kernel, which gets
>> started even if the secondaries can't be stopped.
>>=20
>> Signed-off-by: Henry Willard <henry.willard@oracle.com>
>> ---
>> arch/arm64/kernel/smp_spin_table.c | 111 +++++++++++++++++++++++++++++++=
++++++
>> 1 file changed, 111 insertions(+)
>>=20
>> diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_=
spin_table.c
>> index 7e1624ecab3c..35c7fa764476 100644
>> --- a/arch/arm64/kernel/smp_spin_table.c
>> +++ b/arch/arm64/kernel/smp_spin_table.c
>> @@ -13,16 +13,27 @@
>> #include <linux/mm.h>
>>=20
>> #include <asm/cacheflush.h>
>> +#include <asm/daifflags.h>
>> #include <asm/cpu_ops.h>
>> #include <asm/cputype.h>
>> #include <asm/io.h>
>> #include <asm/smp_plat.h>
>> +#include <asm/mmu_context.h>
>> +#include <asm/kexec.h>
>> +
>> +#include "cpu-reset.h"
>>=20
>> extern void secondary_holding_pen(void);
>> volatile unsigned long __section(".mmuoff.data.read")
>> secondary_holding_pen_release =3D INVALID_HWID;
>>=20
>> static phys_addr_t cpu_release_addr[NR_CPUS];
>> +static unsigned int spin_table_loop[4] =3D {
>> +	0xd503205f,        /* wfe */
>> +	0x58000060,        /* ldr  x0, spin_table_cpu_release_addr */
>> +	0xb4ffffc0,        /* cbnz x0, 0b */
>> +	0xd61f0000         /* br   x0 */
>> +};
>>=20
>> /*
>>  * Write secondary_holding_pen_release in a way that is guaranteed to be
>> @@ -119,9 +130,109 @@ static int smp_spin_table_cpu_boot(unsigned int cp=
u)
>> 	return 0;
>> }
>>=20
>> +
>> +/*
>> + * There is a four instruction loop set aside in protected
>> + * memory by u-boot where secondary CPUs wait for the kernel to
>> + * start.
>> + *
>> + * 0:       wfe
>> + *          ldr    x0, spin_table_cpu_release_addr
>> + *          cbz    x0, 0b
>> + *          br     x0
>> + * spin_table_cpu_release_addr:
>> + *          .quad  0
>> + *
>> + * The address of spin_table_cpu_release_addr is passed in the
>> + * "release-address" property in the device table.
>> + * smp_spin_table_cpu_prepare() stores the real address of
>> + * secondary_holding_pen() where the secondary CPUs loop
>> + * until they are released one at a time by smp_spin_table_cpu_boot().
>> + * We reuse the spin-table loop by clearing spin_table_cpu_release_addr=
,
>> + * and branching to the beginning of the loop via cpu_soft_restart(),
>> + * which turns off the MMU and caching.
>> + */
>> +static void smp_spin_table_cpu_die(unsigned int cpu)
>> +{
>> +	__le64 __iomem *release_addr;
>> +	unsigned int *spin_table_inst;
>> +	unsigned long spin_table_start;
>> +
>> +	if (!cpu_release_addr[cpu])
>> +		goto spin;
>> +
>> +	spin_table_start =3D (cpu_release_addr[cpu] - sizeof(spin_table_loop))=
;
>> +
>> +	/*
>> +	 * The cpu-release-addr may or may not be inside the linear mapping.
>> +	 * As ioremap_cache will either give us a new mapping or reuse the
>> +	 * existing linear mapping, we can use it to cover both cases. In
>> +	 * either case the memory will be MT_NORMAL.
>> +	 */
>> +	release_addr =3D ioremap_cache(spin_table_start,
>> +				sizeof(*release_addr) +
>> +				sizeof(spin_table_loop));
>> +
>> +	if (!release_addr)
>> +		goto spin;
>> +
>> +	spin_table_inst =3D (unsigned int *)release_addr;
>> +	if (spin_table_inst[0] !=3D spin_table_loop[0] ||
>> +		spin_table_inst[1] !=3D spin_table_loop[1] ||
>> +		spin_table_inst[2] !=3D spin_table_loop[2] ||
>> +		spin_table_inst[3] !=3D spin_table_loop[3])
>> +		goto spin;
>=20
> Please don't hard-code a specific sequence for this; if we *really* need
> this, we should be given a cpu-return-addr explicitly, and we should
> simply trust it.

That would require changes to u-boot. The purpose is to detect if we get a =
new version of u-boot with a different loop. Seems remote since this partic=
ular loop has been this way for quite some time, and it works well.

>=20
>> +
>> +	/*
>> +	 * Clear the release address, so that we can use it again
>> +	 */
>> +	writeq_relaxed(0, release_addr + 2);
>> +	dcache_clean_inval_poc((__force unsigned long)(release_addr + 2),
>> +			(__force unsigned long)(release_addr + 2) +
>> +				    sizeof(*release_addr));
>=20
> What is the `+ 2` for?

Yeah, I could have been clearer. The spin_table_cpu_release_addr variable s=
its at +0x10 past the spin-table loop.=20

>=20
>> +
>> +	iounmap(release_addr);
>> +
>> +	local_daif_mask();
>> +	cpu_soft_restart(spin_table_start, 0, 0, 0);
>> +
>> +	BUG();  /* Should never get here */
>> +
>> +spin:
>> +	cpu_park_loop();
>> +
>> +}
>> +
>> +static int smp_spin_table_cpu_kill(unsigned int cpu)
>> +{
>> +	unsigned long start, end;
>> +
>> +	start =3D jiffies;
>> +	end =3D start + msecs_to_jiffies(100);
>> +
>> +	do {
>> +		if (!cpu_online(cpu)) {
>> +			pr_info("CPU%d killed\n", cpu);
>> +			return 0;
>> +		}
>> +	} while (time_before(jiffies, end));
>> +	pr_warn("CPU%d may not have shut down cleanly\n", cpu);
>> +	return -ETIMEDOUT;
>> +
>> +}
>=20
> If we're going to extend this, we must add a mechanism to reliably
> identify when the CPU has been returned successfully. We can't rely on
> cpu_online(), becuase there's a window between the CPU marking itself as
> offline and actually exiting the kernel.
>=20
>> +
>> +/* Nothing to do here */
>> +static int smp_spin_table_cpu_disable(unsigned int cpu)
>> +{
>> +	return 0;
>> +}
>=20
> For implementations where we cannot return the CPU, cpu_disable() *must*
> fail.
>=20
> Thanks,
> Mark.

Thanks for taking the time to review this.

Henry

