Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5097640473A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhIIItT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:49:19 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:41472
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231436AbhIIItN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:49:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fByQwohyGnYr/NaqyjbD2jsLKdwyQo3jABGnozR05EUCXv+bojlfe8C/TwmdbKQYeUeE3Pb8DddHGUUqvxQxE8s6A+Ld/cOnbdj/zD1mcb9kBks+1C/cKkJ9G73XdoXaxTWohZclv7V9LSTlbfLq8rT2nrRUToh4zwUCaJ+nq+BSJmLTyspMiBiiRyRZtNS5Kocz/Wg2M4qUwIIy9bXViHgI0DzeHifq515y3Eunxl9IIFqlL04i6zQRX/p0sLW1Dk0G7EpqWwnYZTNPIRWDDBWcW5oUJTBG3/SJm91qVP/2TAsWUbotLSgi88ldfCY7kb5zxQoTrNvFV/mlmR9HpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tIcSBuKTNO5bXH5N7nRO6x2cVH9gWFTWq1MdDjiJd+o=;
 b=AxnJRHv5bj51L5jpQLJSarnTwoMH2Ca+M7/l4Suew3MlCPd7V0/7CeNJfHrNBGcllM17l4RKcDnaW21IHeq9kVsWRleIWFB2VQa55Oba4j1OZKmDTf9W2T2GsMv4ODk6i5x12qAEygRCamLf8ScHapK/SStRjgmu7yEauTlYowbQLrxAJ58FkQQ5q630P7JjdDmCo3If92WP1dPSa1pd/Y8Hihi7/t+sz5kKswUYalLU1YD+vcarzYkxQNbeoJS2AgQDrkvOxeph6f7eWPGQ5HNUfoUuHgSXkdxiKuZIWw3wxUsEeKWSb8zabQGrfTkpLD27tc167GlKG1866WDdfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIcSBuKTNO5bXH5N7nRO6x2cVH9gWFTWq1MdDjiJd+o=;
 b=0xa7GmFZkDSvsnHYfWwrCk2xry+AISMmMuGvVqFXGnRV8UF77W9NU9Xddho7PsMUjdTUiJMDv8rrDjSAOO/JR+DRUDVe3oO/55MFyD4g028a7V1y/T0VIcDjTS34usOsMWNXKgRBi5XJY0fn6EuUkGbt7Ig38Oa2bQ+36EvD/a0=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Thu, 9 Sep 2021 08:48:02 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 08:48:02 +0000
From:   "Yu, Lang" <Lang.Yu@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Topic: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Index: AQHXpKowoLymFk5Tf0idLKRe5rRrP6ubJ2WAgAAA8aCAAAnRgIAAAG7ggAAGGACAAACA8IAAB0iAgAATF4CAAAR9AIAADJRA
Date:   Thu, 9 Sep 2021 08:48:02 +0000
Message-ID: <DM6PR12MB4250697A7C2A7FC4C79B7DABFBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
 <DM6PR12MB425005AE652C12F04E66B5B8FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <685524a360bc910210cbbb7b13a46ead26ed8a22.camel@perches.com>
 <DM6PR12MB4250AE8DF451484884B657C9FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTmksJ0Bq/fEmFQV@kroah.com>
 <MN2PR12MB42569A67079D3D9734805BD0FBD59@MN2PR12MB4256.namprd12.prod.outlook.com>
 <YTmrN2nuhlVBaAKN@kroah.com>
 <DM6PR12MB4250645F728F92C9BF2CECE7FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTm+/hPWXMeqcDte@kroah.com>
In-Reply-To: <YTm+/hPWXMeqcDte@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-09T08:47:59Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5b602c56-743d-4fa1-b6c9-d74d1d2503da;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9922d390-4e46-4924-dbe9-08d9736e88de
x-ms-traffictypediagnostic: DM6PR12MB4578:
x-microsoft-antispam-prvs: <DM6PR12MB45786278D40D138169587322FBD59@DM6PR12MB4578.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /c+TxRGEWcB2iwQsFiPqcSN5aoDY78CYllT4ZmEbf43/OVIYoTyzLx2lZutd2KWMSZpt6SbEti4iS/pa/YluIJ6zY//Cky9PSIaOkewLbYbUCzI/fFVTJofL2pb20+cTgF2KWbMzgUj5XZJczmL5FI8ov8Cgf2ZIV1M3ApflYdWMZio+gjyL8LnL0iislNJAmRjS1EeqtFqDGwB19wlsu895APHv4uy8qq8JdkTqW/ECxiapV1XpvuQJ7HxaoLRRwIpNaiRtjaThUi+v7LJQAUEzP9XlO/t+XH42TjpDuECyjyqYxEvwQXwJcR7smzZG3mszbsoqypn2RBcgALGcRnBNdsCAZJ4hnx0d2Fy8xxa1u423RDN6W+NOMFNE1qdAB6OS+NWXzSbN+HL4JPKhWGMlAdM3zcZk0io2r3Z9wfxdpUWKg1DTVE9cf5kVI6umtsM6YX0RnqxMYFe19fNNiqcRwrD8M856Fc5VsmuHWYZjGGaYGK5k0CFpKP24rZsPmvcEdrlDoTVuIddy9cl+lr352qTRhWE68TURSCYH+XVQqykZzoyWkb32rMlN1SQAPJ3PQ7WyS+Kc5drp1RgLjIdVjUl3avJ/Wge2l52CEcesTX08nXbgYQIZ+tcOyLJ+ceeNk/Vcz+VoIxeRnfs9RHpXAXcjffM6jvn3/Hxa4gVEBLA+MvCm4v0One3uG8jvbq1++9WiqX8pYNzlk2gKbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(66476007)(4326008)(316002)(2906002)(6506007)(55016002)(66556008)(54906003)(9686003)(6916009)(66946007)(76116006)(52536014)(8936002)(8676002)(33656002)(83380400001)(71200400001)(7696005)(5660300002)(38100700002)(86362001)(38070700005)(122000001)(478600001)(186003)(26005)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rp6ZqxNRg+xngl5XK3rkUVA+UW1lte+16/Hfxsf23xaaN9/w6NQuf1K77hbG?=
 =?us-ascii?Q?Sll+fntbvWGj4L5FdlQU+5cenktJGa2KtiCl2mmHuz5jr1VMMX8Xn/cinwan?=
 =?us-ascii?Q?xmisDfMj4wASbs/j4nw91Li8fklW3Czkaj8eySf4yBZVk5aaDuDWl1yVAj2V?=
 =?us-ascii?Q?010OxU3Ia0qH6774FYUrBQZDRtz5XlIuKolZ2uJrtkETLhoehQ30sRbZYWWv?=
 =?us-ascii?Q?3DaqtAXa1oKyqG8nTNetEiJdhBj/rmxrUrNjhFJjWXbaVeVhgBMVpDZxKfUO?=
 =?us-ascii?Q?7onESJEQ3fyvb1onD7t3LxwTTOwyoUe1SqLZ0YORP3IAyMWwrTJ9SFbVQUT7?=
 =?us-ascii?Q?LqBOQf5m14apBmJr0hM7zGagiD2Cp2risHtqSMB/6IGL3nENa6SdriCdbpkp?=
 =?us-ascii?Q?te9oIkuAzZeDtsdxgecVGUf9+4rtvE2wmUr7N6KcunYvkzX3osJQ+ACc4maX?=
 =?us-ascii?Q?u1IHlC/ii0rQhUb9AkawqV6nquz0Grn5l7Q1dh33pWV7pNC0SIr//wldZIOP?=
 =?us-ascii?Q?83xfBWx+WO9JVuq8FeT9pLYe23eVEgd71ktn4c/j+9pj2NJBE1CrsYvB5cjG?=
 =?us-ascii?Q?3deQ5GFlY1ezCJWK3JhB4bWSLZth9WrwlLnEbhfYX+203u92YNGwMuY5zwFQ?=
 =?us-ascii?Q?4vmv5Vi8ElyXx1M5IpUsj5lJ126xHWAFtcuzNxnLf5N7m1jg9h8b06MFA780?=
 =?us-ascii?Q?3+LeZeJW5h0xPoVhyOorsme5MkqRqPiZzxJDPR7qfB+5ok5gOUVYVxh8XcSJ?=
 =?us-ascii?Q?yB+1YvScPIZdTKzk7vyFvM1kELIfuLzTjw+JAke+oj7YibpXm3UckK84Og2W?=
 =?us-ascii?Q?qF85SkVTCaqymb7mNSMHvp1tSYyAXZC1giW62coqc1YOKxtR+yqwoyyX/Kcz?=
 =?us-ascii?Q?+BHMNq/ggQ19KxfbpAH4BCc/ku+GC0Vld5iVyi0a+PVoACotWuMBh6/U6/5J?=
 =?us-ascii?Q?0xVvz4iH46IKITCSqXwkGz/tm+xOb0eordoiwaNVludZh1Eyu4hXVyuQPzjT?=
 =?us-ascii?Q?EQfkFd2o+xSaRnWQ0I3teDcx+cKSe2/p2OYzfdIcwt4PCA2j9Fn/P+B8f26i?=
 =?us-ascii?Q?FK0YIakriHWwVnNsSZtmUILpwXtbWbJD+O8Fh1rr/nfO+Myo3UaLq2wjAN42?=
 =?us-ascii?Q?TUL8kYrznkcmEgk7IfucBCuMCqIVg9NJLXZs1mVMWBMzjdZ+VFEcy6wLAxgO?=
 =?us-ascii?Q?NMEJ1Z4iVZ88UsRKKoMRcMvb8uAvHdyzHVu/bSuyMx6UwqlDeJPkpcgoeyun?=
 =?us-ascii?Q?rtBVLCR3NHfOhWpG4A69NvkR2uK9cEoX+b8vsTtl1LTD9dfrxYE1kZiknQBl?=
 =?us-ascii?Q?6kJGepD0Nwn6beWMoLyx70YW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9922d390-4e46-4924-dbe9-08d9736e88de
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 08:48:02.8249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drk0WpH9uI8R7W9YAbJEEH3baGxSeECDxBAFIc9gBey8iab/deYRuXaXBwOX4VDVpixUqp9wVF9OCor3MXD42Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



>-----Original Message-----
>From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Sent: Thursday, September 9, 2021 4:00 PM
>To: Yu, Lang <Lang.Yu@amd.com>
>Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs=
_emit
>and sysfs_emit_at
>
>On Thu, Sep 09, 2021 at 07:48:38AM +0000, Yu, Lang wrote:
>> [Public]
>>
>>
>>
>> >-----Original Message-----
>> >From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >Sent: Thursday, September 9, 2021 2:36 PM
>> >To: Yu, Lang <Lang.Yu@amd.com>
>> >Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki
>> ><rafael@kernel.org>; linux-kernel@vger.kernel.org
>> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
>> >sysfs_emit and sysfs_emit_at
>> >
>> >On Thu, Sep 09, 2021 at 06:22:54AM +0000, Yu, Lang wrote:
>> >> [Public]
>> >>
>> >>
>> >>
>> >> >-----Original Message-----
>> >> >From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >> >Sent: Thursday, September 9, 2021 2:08 PM
>> >> >To: Yu, Lang <Lang.Yu@amd.com>
>> >> >Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki
>> >> ><rafael@kernel.org>; linux-kernel@vger.kernel.org
>> >> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation
>> >> >on sysfs_emit and sysfs_emit_at
>> >> >
>> >> >On Thu, Sep 09, 2021 at 05:52:23AM +0000, Yu, Lang wrote:
>> >> >> [Public]
>> >> >>
>> >> >>
>> >> >>
>> >> >> >-----Original Message-----
>> >> >> >From: Joe Perches <joe@perches.com>
>> >> >> >Sent: Thursday, September 9, 2021 1:44 PM
>> >> >> >To: Yu, Lang <Lang.Yu@amd.com>; Greg Kroah-Hartman
>> >> >> ><gregkh@linuxfoundation.org>; Rafael J . Wysocki
>> >> >> ><rafael@kernel.org>;
>> >> >> >linux- kernel@vger.kernel.org
>> >> >> >Subject: Re: [PATCH] sysfs: Remove page boundary align
>> >> >> >limitation on sysfs_emit and sysfs_emit_at
>> >> >> >
>> >> >> >On Thu, 2021-09-09 at 05:27 +0000, Yu, Lang wrote:
>> >> >> >> [AMD Official Use Only]
>> >> >> >
>> >> >> >this is a public list and this marker is not appropriate.
>> >> >>
>> >> >> Sorry for that.
>> >> >> >
>> >> >> >> > -----Original Message-----
>> >> >> >> > From: Joe Perches <joe@perches.com> On Wed, 2021-09-08 at
>> >> >> >> > 20:07
>> >> >> >> > +0800, Lang Yu wrote:
>> >> >> >> > > The key purpose of sysfs_emit and sysfs_emit_at is to
>> >> >> >> > > ensure that no overrun is done. Make them more equivalent w=
ith
>scnprintf.
>> >> >> >> >
>> >> >> >> > I can't think of a single reason to do this.
>> >> >> >> > sysfs_emit and sysfs_emit_at are specific to sysfs.
>> >> >> >> >
>> >> >> >> > Use of these functions outside of sysfs is not desired or sup=
ported.
>> >> >> >> >
>> >> >> >> Thanks for your reply. But I'm still curious why you put such a
>limitation.
>> >> >> >> As "Documentation/filesystems/sysfs.rst" described, we can
>> >> >> >> just use scnprintf(buf, PAGE_SIZE, "%s\n", dev->name) in show
>> >> >> >> functions without such a limitation.
>> >> >> >
>> >> >> >There's nothing particularly wrong with the use of scnprintf as a=
bove.
>> >> >> >
>> >> >> >The only real reason that sysfs_emit exists is to be able to
>> >> >> >reduce the kernel treewide quantity of uses of the sprintf
>> >> >> >family of functions that need to be analyzed for possible buffer =
overruns.
>> >> >> >
>> >> >> >The issue there is that buf is already known to be both a
>> >> >> >PAGE_SIZE buffer and PAGE_SIZE aligned for sysfs show functions
>> >> >> >so there's no real reason to use scnprintf.
>> >> >> >
>> >> >> >sysfs_emit is a shorter/smaller function and using it could
>> >> >> >avoid some sprintf defects.
>> >> >> >
>> >> >> >> Some guys just try to replace scnprintf with sysfs_emit() or
>> >> >> >> sysfs_emit_at() per
>> >> >> >above documents.
>> >> >> >
>> >> >> >So don't do that.
>> >> >> >
>> >> >> >> But sprintf and sysfs_emit/sysfs_emit_at are not totally
>> >> >> >> equivalent(e.g., page
>> >> >> >boundary align).
>> >> >> >>
>> >> >> >> In my opinion, we add a new api and try to replace an old api.
>> >> >> >> Does we need to make it more compatible with old api?
>> >> >> >
>> >> >> >IMO: no.
>> >> >> >
>> >> >> But why you said " - show() should only use sysfs_emit() or
>> >> >> sysfs_emit_at() when formatting the value to be returned to user
>> >> >> space. " in
>> >> >Documentation/filesystems/sysfs.rst ?
>> >> >>
>> >> >> Obviously, sysfs_emit() and sysfs_emit_at()  can't cover all the
>> >> >> cases in show
>> >> >functions.
>> >> >
>> >> >Why not, what usage model can it not cover?
>> >>
>> >> Of course, we can modify driver code to obey sysfs_emit and
>> >> sysfs_emit_at
>> >rules or just use scnprintf in show functions.
>> >
>> >Great, please do.
>> >
>> >> Now that you introduced them, why not make them more flexible like
>> >> scnprintf
>> >family functions.
>> >
>> >Because that is not what they are for.
>> >
>> >> The page boundary align rule makes life hard and I don't like it :
>> >> ). Many thanks
>> >for your explanations!
>> >
>> >Then fix your sysfs files to not violate the sysfs rules.
>> >
>> >Again, which files are having problems and need to be fixed?  I will
>> >be glad to do this for you.
>>
>> Thanks. I can do it by myself instead of wasting your time... Many thank=
s!
>
>When doing so, please switch to using DEVICE_ATTR_RO() instead of the "ope=
n
>coded" DEVICE_ATTR() usage in the driver.  That way we all "know"
>that these are read-only attributes.

Many thanks for you reminders! Have a nice day!

Regards,
Lang
>
>thanks,
>
>greg k-h
