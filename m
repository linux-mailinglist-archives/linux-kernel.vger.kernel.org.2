Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73694404688
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhIIHtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:49:51 -0400
Received: from mail-dm6nam08on2045.outbound.protection.outlook.com ([40.107.102.45]:10849
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229492AbhIIHtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:49:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+XFUoFmx+xwzk0uP6SEFj0BZzzTppdmxVYo7ByWIQ1TjNY6bEt7stCjLU+aYVX3cutZKCVs4dMAVET4oIqFXBQ8lwMUyUSfPXvc6SKLLPlVno5fEDfHXa28239BI1dmL52tsbQOTiOUiTvG5gs7OhiQI26Q/aD13Zj1YMaCmubKNC2vrG2DUzaFNjCyu9DuX1sxNAQw7+59QQmYT6p13gaoOGVcyrN86CHkpoI0+YRC800eTPUr5yRAuCMFtLpR7DikB+a/cU7jrUQAp/VdUkSH/kbOsxYIGZASQYQGYoG62V7a+GvEfVmQjkSWs9w1Dz88ZBm3dUQ+t59l8+z0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=U5YrriK27m13+G6bCsqep5M0UMkDI3HS21e8Tpd2b+8=;
 b=XgQpaQ+lELGY9e/MbMrwVc153qk4DJM9CUfnSiOAItYJUvok6mFUMBwlToNjrv7CfF389Rgs9IbyRNbmHn6Eodg7r/3xJ6V1GRVfbmBdhGaUH4hBXlu3oB/8+AItfTPQVXoYzY+5H8iCcwHSpILgr1mqeKcmnU4Pw4Hh7ym3FleHzQPUTDZYfDM3wG2KM+wA0uxnQ+wIsViZnKCXwcQre0TG/5MW6HjfLmVux5QI+hdGNlAQ1kQRLZqXZDf1p2jSxMe4b0NHFUp+PEQzvG9SS9dixAvAxGJBOYeCBMpVK58j4iclS3RTBDGEZD+3udF+O7Tf2qw+Zv/1HcVx1Iq/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5YrriK27m13+G6bCsqep5M0UMkDI3HS21e8Tpd2b+8=;
 b=XiIBjbiNms4HhPM2CPEcXoi7gDY8RsvqZTD6QPTUKDjNDt6g1/eknJYRQVF/MgAw9cKA1yo0xYEchsywDiXkrurH6DeTBdXCkvAlIkjWUlRlkP+xbgHv/6R71gp+rPySEuQJz+aOvzCBQh+tXLNoS94z/TRRWeeGlpQrgQR1M+A=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Thu, 9 Sep 2021 07:48:38 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 07:48:38 +0000
From:   "Yu, Lang" <Lang.Yu@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Topic: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Index: AQHXpKowoLymFk5Tf0idLKRe5rRrP6ubJ2WAgAAA8aCAAAnRgIAAAG7ggAAGGACAAACA8IAAB0iAgAATF4A=
Date:   Thu, 9 Sep 2021 07:48:38 +0000
Message-ID: <DM6PR12MB4250645F728F92C9BF2CECE7FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
 <DM6PR12MB425005AE652C12F04E66B5B8FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <685524a360bc910210cbbb7b13a46ead26ed8a22.camel@perches.com>
 <DM6PR12MB4250AE8DF451484884B657C9FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTmksJ0Bq/fEmFQV@kroah.com>
 <MN2PR12MB42569A67079D3D9734805BD0FBD59@MN2PR12MB4256.namprd12.prod.outlook.com>
 <YTmrN2nuhlVBaAKN@kroah.com>
In-Reply-To: <YTmrN2nuhlVBaAKN@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-09T07:48:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1b399ae1-4dfe-48a7-9fa9-f3df7a2d5276;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbcb83c5-1405-45a5-28b2-08d973663c7c
x-ms-traffictypediagnostic: DM5PR12MB1148:
x-microsoft-antispam-prvs: <DM5PR12MB1148808E4AF0BC716C99328DFBD59@DM5PR12MB1148.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +t5LJ615kTTZOlj7IHbkd72pUnPuFKyxK+Okn3RFPyeq3P+f627fD1YpMsjpjxafoi7L2djOYfp/8+rO2g9KgFN1hiD4H8Xv4QPouy9HbL54wSxVGPK4N3fFSCl+QubEn7V6T5OJDJGjU1DmTVTD5t5rPaPpe0LGP8nvDgsiMe37SxoiFErnuANeUNNAJmWf3uu0MhMzZkY9PezFvh1WJ3IXO1ixcETHfR58fNekOQwIyzP81HPLcJiwIfnJJ/AiZ1dpUwDZCoNQQB/7DBz3M34+Ry4i+NCUjWqnHeTXg7ZcIoslTqZQPmwpz9c4ggdiV749tCcub9M/6bSDJHPt0EzVcKdSqsOKUxS12ibyyjMbMSquGTiwmsKkhsK1Z8hZ4hehNGEYbPLoRSbnRad6jdlP0dFvT8suAq0s+p82fK7hLCtDkSvy9W2jg6g59LGVUWSb5A1aDLHpyDXLoTqT+n25m++Pd/mggECGPxJRsILrs6q0I3Wg4jCcuwja9SyQcO3XNt3M7DkiiHGDLDDd79f9msqLWebp1tzMSczJ2jxn6akGgo4//3CGfWFC0Qs3Z0o7YrKeR/mqdrWCGZ1wJScbeHdlOfA15jBFR6wyU+dtpsfsRynVCnRf7UYmtZzTPtQnj1tnLK3b6d2M79v1moD6t7isogx5/vd6BGtjUAA+HElFkk+KjzyTuKPQMgI4BhUnCuLC1FIBj07U7bEfBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(5660300002)(8676002)(508600001)(33656002)(2906002)(26005)(52536014)(66476007)(9686003)(7696005)(76116006)(55016002)(66946007)(8936002)(38070700005)(86362001)(186003)(66556008)(6916009)(71200400001)(54906003)(64756008)(4326008)(316002)(38100700002)(83380400001)(66446008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XWM5WGrsZTIw1Q3ZWVnFy9E951c1fAlWIT15M57775sK3B6VPzCYRYECMrKp?=
 =?us-ascii?Q?dmW2331mbBlLnMfHTbR+2PhcA0tC9cigImYjusJnFRQWqDfBL6etVZ/dIF5s?=
 =?us-ascii?Q?N+IXRRnClurLrftmPBlWmg7J9sX2xUOVunETAVehY9KZTFHeqa8cGebF4ZKy?=
 =?us-ascii?Q?sw1zd5x/Uig/EASPV+DL1MJd4MknA7DoaqZHqoX9BM+oQEuxqApNJPB8HZDO?=
 =?us-ascii?Q?wSqgdd3bt4ue7wu+UbNRhilSJ/pJ2lGq3Xf7J2TyNM5L7Ew06IrXYJB7Bwrz?=
 =?us-ascii?Q?FLFtqgXnp/XSwOmqjqbJ5eLS7I5jmzU1BqGt8HD3g5ZGbktZhNUhCEI05lG1?=
 =?us-ascii?Q?P7q5caxdTQkKjq7cj7SpDRkISKJQGMMBpoFO8C1ZA7+rOwV9RmmCx1b/8TOm?=
 =?us-ascii?Q?xA1Efq4B+twcGZ92y6ndlSW333FGjOr65W9Qbs/vtyOKGTWqdAmE/sxEWW8h?=
 =?us-ascii?Q?vWj29kQbpD6coIn26eRsOqNtnNyau2jRcs4jWZPiFu/4s1JkUUoXlh2DdePd?=
 =?us-ascii?Q?MT8mWyoto2AlVWIvcraJGkRDezgUSLvnMznIIPiAbGukDv6V/MNe81RpbslE?=
 =?us-ascii?Q?WRkAIekarH17VF8t2pORuq6FW7aYRSVRb95aLkiCKeQRzf61/LHRU3AlyhU8?=
 =?us-ascii?Q?IvUAc3o8s9tFQJq6vRQr93w8QI0jNrDj1tLAZL1RE2yc8cQ8FGcKTpVTH8K/?=
 =?us-ascii?Q?5KOSFSHPaXcX1ezsGS7irLuXr7XbhRBwjIJGgRk5ocHzaIj4dDXhS/ca1aKt?=
 =?us-ascii?Q?+jpzFoc+ExjrrXccAyQMBgQRR3J6PizONWZsH1/+jkDU09TL3nzuiHMJW/RV?=
 =?us-ascii?Q?BGDqmhDgAMZrlSH7Qp363P1OS8PQAE0DdfoUsURJEIHsMj+H6xxreCqhNroV?=
 =?us-ascii?Q?wjztypnCXzSIErj/UiXcQCE5Xmb6FQ7mkzAcIBMRGYiIonht0jLnn3c6lXGc?=
 =?us-ascii?Q?/Qg4AFAhou6yJZZcwFxq2nh7sQsqA0dOdS2w0BV9dHODE21myDCZQ5nvVXSl?=
 =?us-ascii?Q?K6A2Yy0PE6NOsUO8R1JHGK00sXZ9Jet9eiz590SsdqlBZ0Yyo0dNJwGEZIv/?=
 =?us-ascii?Q?FfK1qR30QNg7LpSNk8ImUlJMDEswlN+8awxUbxq5DkIf6g4NGCykZ31QXgxn?=
 =?us-ascii?Q?coZvdQd+XdhvWm3RKN0MhHaQNqlLzzoeRlU/DxhrgfRoV0DSmmBMA+3+yD3D?=
 =?us-ascii?Q?ooRZy3nA4PPHzm+twbXJ3UsL3KBrdDBcf+NVRufkKVZiFK4+7Y9hC7m0xNHT?=
 =?us-ascii?Q?XFphkyej6niZD7Fi5SBe4APnLGPUF0Brlz+Z3p8e8zSCFBEb1Z4Lkds145Pq?=
 =?us-ascii?Q?+lKnhIWOLvqs45aaBlAho0PO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcb83c5-1405-45a5-28b2-08d973663c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 07:48:38.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8UBOTCy9/3RysUuaNaFS+tdDzVc2DzRAAgW7CuV2CWIvTZZHKKW2LP3x76Bhvm2Zl6EtKE0QjkfmWyfWsH6kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



>-----Original Message-----
>From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Sent: Thursday, September 9, 2021 2:36 PM
>To: Yu, Lang <Lang.Yu@amd.com>
>Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs=
_emit
>and sysfs_emit_at
>
>On Thu, Sep 09, 2021 at 06:22:54AM +0000, Yu, Lang wrote:
>> [Public]
>>
>>
>>
>> >-----Original Message-----
>> >From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >Sent: Thursday, September 9, 2021 2:08 PM
>> >To: Yu, Lang <Lang.Yu@amd.com>
>> >Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki
>> ><rafael@kernel.org>; linux-kernel@vger.kernel.org
>> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
>> >sysfs_emit and sysfs_emit_at
>> >
>> >On Thu, Sep 09, 2021 at 05:52:23AM +0000, Yu, Lang wrote:
>> >> [Public]
>> >>
>> >>
>> >>
>> >> >-----Original Message-----
>> >> >From: Joe Perches <joe@perches.com>
>> >> >Sent: Thursday, September 9, 2021 1:44 PM
>> >> >To: Yu, Lang <Lang.Yu@amd.com>; Greg Kroah-Hartman
>> >> ><gregkh@linuxfoundation.org>; Rafael J . Wysocki
>> >> ><rafael@kernel.org>;
>> >> >linux- kernel@vger.kernel.org
>> >> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation
>> >> >on sysfs_emit and sysfs_emit_at
>> >> >
>> >> >On Thu, 2021-09-09 at 05:27 +0000, Yu, Lang wrote:
>> >> >> [AMD Official Use Only]
>> >> >
>> >> >this is a public list and this marker is not appropriate.
>> >>
>> >> Sorry for that.
>> >> >
>> >> >> > -----Original Message-----
>> >> >> > From: Joe Perches <joe@perches.com> On Wed, 2021-09-08 at
>> >> >> > 20:07
>> >> >> > +0800, Lang Yu wrote:
>> >> >> > > The key purpose of sysfs_emit and sysfs_emit_at is to ensure
>> >> >> > > that no overrun is done. Make them more equivalent with scnpri=
ntf.
>> >> >> >
>> >> >> > I can't think of a single reason to do this.
>> >> >> > sysfs_emit and sysfs_emit_at are specific to sysfs.
>> >> >> >
>> >> >> > Use of these functions outside of sysfs is not desired or suppor=
ted.
>> >> >> >
>> >> >> Thanks for your reply. But I'm still curious why you put such a li=
mitation.
>> >> >> As "Documentation/filesystems/sysfs.rst" described, we can just
>> >> >> use scnprintf(buf, PAGE_SIZE, "%s\n", dev->name) in show
>> >> >> functions without such a limitation.
>> >> >
>> >> >There's nothing particularly wrong with the use of scnprintf as abov=
e.
>> >> >
>> >> >The only real reason that sysfs_emit exists is to be able to
>> >> >reduce the kernel treewide quantity of uses of the sprintf family
>> >> >of functions that need to be analyzed for possible buffer overruns.
>> >> >
>> >> >The issue there is that buf is already known to be both a
>> >> >PAGE_SIZE buffer and PAGE_SIZE aligned for sysfs show functions so
>> >> >there's no real reason to use scnprintf.
>> >> >
>> >> >sysfs_emit is a shorter/smaller function and using it could avoid
>> >> >some sprintf defects.
>> >> >
>> >> >> Some guys just try to replace scnprintf with sysfs_emit() or
>> >> >> sysfs_emit_at() per
>> >> >above documents.
>> >> >
>> >> >So don't do that.
>> >> >
>> >> >> But sprintf and sysfs_emit/sysfs_emit_at are not totally
>> >> >> equivalent(e.g., page
>> >> >boundary align).
>> >> >>
>> >> >> In my opinion, we add a new api and try to replace an old api.
>> >> >> Does we need to make it more compatible with old api?
>> >> >
>> >> >IMO: no.
>> >> >
>> >> But why you said " - show() should only use sysfs_emit() or
>> >> sysfs_emit_at() when formatting the value to be returned to user
>> >> space. " in
>> >Documentation/filesystems/sysfs.rst ?
>> >>
>> >> Obviously, sysfs_emit() and sysfs_emit_at()  can't cover all the
>> >> cases in show
>> >functions.
>> >
>> >Why not, what usage model can it not cover?
>>
>> Of course, we can modify driver code to obey sysfs_emit and sysfs_emit_a=
t
>rules or just use scnprintf in show functions.
>
>Great, please do.
>
>> Now that you introduced them, why not make them more flexible like scnpr=
intf
>family functions.
>
>Because that is not what they are for.
>
>> The page boundary align rule makes life hard and I don't like it : ). Ma=
ny thanks
>for your explanations!
>
>Then fix your sysfs files to not violate the sysfs rules.
>
>Again, which files are having problems and need to be fixed?  I will be gl=
ad to do
>this for you.

Thanks. I can do it by myself instead of wasting your time... Many thanks!

Regards,
Lang

>thanks,
>
>greg k-h
