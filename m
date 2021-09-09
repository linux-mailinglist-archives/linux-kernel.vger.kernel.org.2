Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23DF404591
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352557AbhIIGYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:24:07 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:50656
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352517AbhIIGYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:24:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV7nL+IvbPdgbNB7Xc2M69eXLuvtm600P0cTHhX/p4OVZGmoUwzJABzL6a/IOarCp6ztRGeQqBrzTVL4pEVOxYXKn1Fr8mFZi7wcdZZIjPCWvKPvK9WP2ixyEXOHQsVHUfdflj7234jfU+qCwD2tJmlrbcT1dggKuyGBEhuvGjB33xd8WnBKutlretFypIgwmfWUYlRQkVgMBQbpBVuP5Xz5M149hRqNEaVavT+Oq2LjVNF4VfWiL+3Vb+XxZb1IuViGi8ptRsa6+k3HGckB6BgmB6jqa0x0s3h2Wl0iLgYTFeh+OK8NrrXLto7GFvxiBG84f28J2wkG7VTZ751yhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9Yl1awWxcI0ApoWoWR1WikO0rbu3YO3WhWu5pCeoivg=;
 b=JRY/04+FGdpvtlqeFIIsidq6SeV/Qvf44rw/+KMS2ol3eo0ax/ubAo4Rx5iI4BTRhzXbBV0S6B0bboRxMw5xWEEEPmjh/+KtK6pHCvw5I0nsyyh9k2meX8+a3/TbiVbNc7nLP5mve4Rrs3YF8RSj5n2Whw9S4MWU8dG4WgPm+u5x81VcSdpq40wDWOAjdzMwwW9Qb5xdsvJk6ufNkGpAWmpKjRnePNeFrwUILUrNaOzhZOIyGiTHP/qV3R6swx7W+j2g5Yk+Det64Y4SLSPABCVc/4dIyGvyOYIrZJsRAMUQw3lTreFzD2++k12C/UGB3cYB8z9682+IB8TN4iTxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Yl1awWxcI0ApoWoWR1WikO0rbu3YO3WhWu5pCeoivg=;
 b=zY92TPE6dymSjElCxT+g6Ezt236oXWjnRXIYJlhnXOb/iKol50mmIR8JdMYKAANVM8X2JrcFmPdZMPfkvbbayJK+b55bzRnetuTHVMKw3EnnMMV+2YIqQINYr6FOAf3llb/25HGc7+zQqKXxZMl8Zc7NQVhlqAs7R+T5RAAKKVw=
Received: from MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 by MN2PR12MB3760.namprd12.prod.outlook.com (2603:10b6:208:158::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Thu, 9 Sep
 2021 06:22:55 +0000
Received: from MN2PR12MB4256.namprd12.prod.outlook.com
 ([fe80::1fe:6d68:88d7:32a4]) by MN2PR12MB4256.namprd12.prod.outlook.com
 ([fe80::1fe:6d68:88d7:32a4%6]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 06:22:55 +0000
From:   "Yu, Lang" <Lang.Yu@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Topic: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Index: AQHXpKowoLymFk5Tf0idLKRe5rRrP6ubJ2WAgAAA8aCAAAnRgIAAAG7ggAAGGACAAACA8A==
Date:   Thu, 9 Sep 2021 06:22:54 +0000
Message-ID: <MN2PR12MB42569A67079D3D9734805BD0FBD59@MN2PR12MB4256.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
 <DM6PR12MB425005AE652C12F04E66B5B8FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <685524a360bc910210cbbb7b13a46ead26ed8a22.camel@perches.com>
 <DM6PR12MB4250AE8DF451484884B657C9FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTmksJ0Bq/fEmFQV@kroah.com>
In-Reply-To: <YTmksJ0Bq/fEmFQV@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-09T06:22:51Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b5ae520f-45fb-4727-a531-8df317748626;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4512db2a-f600-42e0-a729-08d9735a428d
x-ms-traffictypediagnostic: MN2PR12MB3760:
x-microsoft-antispam-prvs: <MN2PR12MB37601BD494BBCEF2C05400CEFBD59@MN2PR12MB3760.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZVkj2mht75wZxa04YGZWZWxPRSf4z9tXY2gEx3qfo5TxWxhsFoTEoF3nFK/hkrApBc3QVDqjOrsWx9WAt7kuHLn2ASeatBRZCUVu6PHbovPfTKWfsX05dUL0Ewc2Af2RDlWjxoHvgXh2tmlPyymx+TpMnhyOdug6Pju/7zs0+tVJ9MBLSrdhTVInEoNvCrCq2VIsDIp6TiB6JV5/cLJn9Joqm7G7G8fmHICKQtLqON96h6f+7DfDpD/yN78WJtUYMDUrTUQI41GGztLKgGG+x94l2nD6WMhLi8TnI8/t2UCldf/glXF3ePk83cyvO+XwZrxxfWdxEImUuGbEwvT4OquJSYDkr9yI065+wXm/FksARzUw8aLW/5Ya4W/6NwQLuJSrMW8PCZE/l0zj3QtKYwQ0eRUZ83S3jX6FZd155lqAZv/A9pTcGNjoEuat3wDxL+d0uWCIj1MfXtELyrF2BbcMHVi4Le1MOL6Hl9e3x9EX6L4criNnBP3o+JrzlqdDNPUoRL1j7UiSfcSCdsOhStWTHYY7JHJMwOllQ8l/VkxieUT6PC2mcCL4H9enen5/fUjF+qqpn2GKJ2ovvSrvK1+XvWs8Kpwu3sQCAwGB7RsHt5ljFpCahB69mPKuPffIXXtmuU9iWziNI6s8zxXF7vMAqa7jRtqPMLH5J/S6g0CNlZhJyDscArKJylUNGpLd93SFWnxmIO3YGPQlQqQIrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4256.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6506007)(7696005)(33656002)(54906003)(83380400001)(9686003)(52536014)(66946007)(66446008)(38100700002)(76116006)(66476007)(71200400001)(122000001)(38070700005)(66556008)(6916009)(26005)(186003)(508600001)(2906002)(5660300002)(8936002)(55016002)(8676002)(86362001)(64756008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RSGO2yzK5SPB8fOIEFM3lDBDIddn5gR+jrTk/lFFOyIwgAHKI4cXL22yknSp?=
 =?us-ascii?Q?iD1lLqq05v28aZofm9CjZX+6ejEnLFkyvB93yVJ61camgzer7sGQaZ7PC+ua?=
 =?us-ascii?Q?JO3f3U3Dz6u+jZrQx9VFKfONFvph9W62G2UjlQUisssVUSb8iXusnwdnO/IG?=
 =?us-ascii?Q?ke+2evuJeFRM3VDdD2O7hVP+gEdiOXob1mD5oV37arhYk5CDAteks0oqQfqs?=
 =?us-ascii?Q?j/yCuU/mRvy9Nx36ZMD/PY3jpwmmGjbOvlq7sx9brQsYWUTSs8mgyyxCCCxa?=
 =?us-ascii?Q?GeMGzcUJRMcSRFGg0CkRLQt7+28ZjtZ4q/zjj7rkNTEakbHrTeJNppIwu6QA?=
 =?us-ascii?Q?FFymomqkp6QThG7aYNGbqXdRgjixSKqDaQq6q3f2Bi44MIcn7ytzQls4Lagu?=
 =?us-ascii?Q?qi1yeQFX8WOXKO75F4lvc6vCJXA0bOYUJSMJSAqC8vSyuUdnurlRNf5fmpwQ?=
 =?us-ascii?Q?wbxgn/8NJroyt48GSdCasD8KlfuikUFBx3s1F4unA23mAL1JBm3naFO6bxI1?=
 =?us-ascii?Q?zhurd4sLJ4OhdbYZUCX4RjkWXyYkRMHPeRCOAK18Ktbzhfj+r9Q2wLF1NRTk?=
 =?us-ascii?Q?99+W/vaVKEwQ9RWIJDdvfrsbNbq5RkDeUudVSTDLhY4S4Km8DMmGW+ysbXQA?=
 =?us-ascii?Q?8tWiZzgQQOxdAW4V5Fidy27mSc3b66OudTyJxmMurEvZTh5yT2alZ0FUklHC?=
 =?us-ascii?Q?+A7lzUgbeUHFSfSXZJkIr0FK/201Fix0ggcElqJn6wODmfi8AqmJ25VIKjLM?=
 =?us-ascii?Q?JpLKNXpeAtiLv8DigxEFZOM462UUBWyKs0+2df6J7bFV1CNIPX8Ji6Lon2UV?=
 =?us-ascii?Q?ry1i3ScWorZkMzAgRU3mKhAb3h/P2bWDNj7yOSAi2jYjGgHiflnGmYYQ5lAv?=
 =?us-ascii?Q?zsqgFdRIdjZMhbsekYsMm5HlNpaG6aNAqcwy77FGS/7k0bq7Ncs+8YCutdzM?=
 =?us-ascii?Q?z9w/lFf1KOP9mzWW/njfQudaj9YfYDnVk7AIBOBN8pTBIgxXCNB29ZP+E/0Z?=
 =?us-ascii?Q?0QORG9FK6Ps7wc7CPrixjn7uAIONWRauDTBqxdaK/l2fSyFrscGfETyEV0kF?=
 =?us-ascii?Q?1CTdV4zbwRLqb5wKpjBYKh7tC0exJqK2ij3ZM80dtglTzqmX1IsNOD/xBHBS?=
 =?us-ascii?Q?IICMSZQ4jcn5tUgFo9a9aUQvckDSYI/L7wSgGLgo6YSeBiVgC+90bcFUskHB?=
 =?us-ascii?Q?3L6EA9r25fT6LJNmEk6kymqTz9xnXEjsM8aueGtxQKHQwsB1nqSe+wDyzone?=
 =?us-ascii?Q?id1gn06F69ZFeTy0aZd4df8QIbTA+qWNUKL0S5OVIdW7UNK6u7TenSdj2dEa?=
 =?us-ascii?Q?FElWWmuiLVVX1puTLb1cEfrZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4512db2a-f600-42e0-a729-08d9735a428d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 06:22:54.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8r65INXHPTtVU2s7VG/8b+04uu5e5w6Bc0tIugQtX8XgORi2wJVoZMGnFHSj16+H6Cx9X6rRTjYBqpflN7rXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3760
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



>-----Original Message-----
>From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Sent: Thursday, September 9, 2021 2:08 PM
>To: Yu, Lang <Lang.Yu@amd.com>
>Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs=
_emit
>and sysfs_emit_at
>
>On Thu, Sep 09, 2021 at 05:52:23AM +0000, Yu, Lang wrote:
>> [Public]
>>
>>
>>
>> >-----Original Message-----
>> >From: Joe Perches <joe@perches.com>
>> >Sent: Thursday, September 9, 2021 1:44 PM
>> >To: Yu, Lang <Lang.Yu@amd.com>; Greg Kroah-Hartman
>> ><gregkh@linuxfoundation.org>; Rafael J . Wysocki <rafael@kernel.org>;
>> >linux- kernel@vger.kernel.org
>> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
>> >sysfs_emit and sysfs_emit_at
>> >
>> >On Thu, 2021-09-09 at 05:27 +0000, Yu, Lang wrote:
>> >> [AMD Official Use Only]
>> >
>> >this is a public list and this marker is not appropriate.
>>
>> Sorry for that.
>> >
>> >> > -----Original Message-----
>> >> > From: Joe Perches <joe@perches.com> On Wed, 2021-09-08 at 20:07
>> >> > +0800, Lang Yu wrote:
>> >> > > The key purpose of sysfs_emit and sysfs_emit_at is to ensure
>> >> > > that no overrun is done. Make them more equivalent with scnprintf=
.
>> >> >
>> >> > I can't think of a single reason to do this.
>> >> > sysfs_emit and sysfs_emit_at are specific to sysfs.
>> >> >
>> >> > Use of these functions outside of sysfs is not desired or supported=
.
>> >> >
>> >> Thanks for your reply. But I'm still curious why you put such a limit=
ation.
>> >> As "Documentation/filesystems/sysfs.rst" described, we can just
>> >> use scnprintf(buf, PAGE_SIZE, "%s\n", dev->name) in show functions
>> >> without such a limitation.
>> >
>> >There's nothing particularly wrong with the use of scnprintf as above.
>> >
>> >The only real reason that sysfs_emit exists is to be able to reduce
>> >the kernel treewide quantity of uses of the sprintf family of
>> >functions that need to be analyzed for possible buffer overruns.
>> >
>> >The issue there is that buf is already known to be both a PAGE_SIZE
>> >buffer and PAGE_SIZE aligned for sysfs show functions so there's no
>> >real reason to use scnprintf.
>> >
>> >sysfs_emit is a shorter/smaller function and using it could avoid
>> >some sprintf defects.
>> >
>> >> Some guys just try to replace scnprintf with sysfs_emit() or
>> >> sysfs_emit_at() per
>> >above documents.
>> >
>> >So don't do that.
>> >
>> >> But sprintf and sysfs_emit/sysfs_emit_at are not totally
>> >> equivalent(e.g., page
>> >boundary align).
>> >>
>> >> In my opinion, we add a new api and try to replace an old api. Does
>> >> we need to make it more compatible with old api?
>> >
>> >IMO: no.
>> >
>> But why you said " - show() should only use sysfs_emit() or
>> sysfs_emit_at() when formatting the value to be returned to user space. =
" in
>Documentation/filesystems/sysfs.rst ?
>>
>> Obviously, sysfs_emit() and sysfs_emit_at()  can't cover all the cases i=
n show
>functions.
>
>Why not, what usage model can it not cover?

Of course, we can modify driver code to obey sysfs_emit and sysfs_emit_at r=
ules or just use scnprintf in show functions.
Now that you introduced them, why not make them more flexible like scnprint=
f family functions.
The page boundary align rule makes life hard and I don't like it : ). Many =
thanks for your explanations!

Regards,
Lang

>thanks,
>
>greg k-h
