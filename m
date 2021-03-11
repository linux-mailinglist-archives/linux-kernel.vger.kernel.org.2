Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFA4337C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhCKSOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:14:47 -0500
Received: from mail-mw2nam10on2094.outbound.protection.outlook.com ([40.107.94.94]:33857
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229688AbhCKSOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:14:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciDETvtAxYBRaXxdZHzfzad/BQwpn+yWFVzkH3xoagrcFVRtk21tXAPhHpCUAuXuP2J5Ne/f8BnZbW14Bu963FtNycASpdj7wm52P/UdclUwzipAPlRAomewuk+9vhaciO1oGJgNLEqXZ12Tmu9eyWatIKwInEYKwzS+sj6TyHbsm7MobGZK0bK66AeDL3eOhJ5LP2HTjdq2BzyWllvNZYoj8O7E0q8HiMuL37uUGxT/Xb25rHN39pG99JRFGK1+srYfpvxFJMc3e+XTglk7dxSDotmWAoAvehdI0GZKS8v/UTalz2y8KBHw9mxpK8rX2q7KVzm3Xg5CLAp/j0qTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNK7T888QM2bV5yf5k7gQOuawvH+29JvyoyWdZ+Ssjk=;
 b=aoIk67iLWIfT2hyhQDVgNmjog5evLsKOplr9tZ0NCei3kdtu7pZUJSWqPzBk9r1xw0g3Oge2f0O5GVugq9995DEmYt11DWQ16YNehXMr6YBDlrkiJ8KFBPyfOz/T9D6xARyI7feUE7t4qp+NsdqoWdxd0fHCsIEsusqNPOJPofLgIAhkv1Z7FZEuOYsWAsTyxw8H9AbSpTOrpG97dxD9KDXg169ichSJkwQocx4JMCZtXjF14J6tVNbUS8/onqVWmj5QHasxnvqtrAEVtvwjga40ER8o9VTXQPCPHEWez/qV9+qfrrP0p8urlmVgm+WPuVyhM1G6WxWqcsWNHpMKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNK7T888QM2bV5yf5k7gQOuawvH+29JvyoyWdZ+Ssjk=;
 b=H5Ab/eg+RvQF8Bbjc8AUKEHdmfns5MJguuuIlE9JZi7ll8sMWfNWKjeLvbp2Vsju7yZ9bUlzsZd5pkewo/MTgQ3VE2dipripyQ0uLEJonQdokgSbYWm4rCfrskajMkjCNF+WKkVDuVKnsOGhQKALU6ZTpZ1LNmdzS8dfjKuoz9o=
Received: from MWHPR21MB0478.namprd21.prod.outlook.com (2603:10b6:300:ec::17)
 by MW2PR2101MB1769.namprd21.prod.outlook.com (2603:10b6:302:2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10; Thu, 11 Mar
 2021 18:14:19 +0000
Received: from MWHPR21MB0478.namprd21.prod.outlook.com
 ([fe80::4d11:1d08:4631:a910]) by MWHPR21MB0478.namprd21.prod.outlook.com
 ([fe80::4d11:1d08:4631:a910%7]) with mapi id 15.20.3955.011; Thu, 11 Mar 2021
 18:14:19 +0000
From:   Joe LeVeque <jolevequ@microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
CC:     Eric Biederman <ebiederm@xmission.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guohan Lu <lguohan@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH] kexec: Add kexec reboot string
Thread-Topic: [EXTERNAL] Re: [PATCH] kexec: Add kexec reboot string
Thread-Index: AQHXFjgInIBa7j1r9UeU4QbI95Yf2ap/F72g
Date:   Thu, 11 Mar 2021 18:14:19 +0000
Message-ID: <MWHPR21MB047848DAF9A5D35FEC1EC6D5DA909@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
 <20210310213258.da50fe5f81086ab0147f6167@linux-foundation.org>
In-Reply-To: <20210310213258.da50fe5f81086ab0147f6167@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=098e4961-e5ef-4fca-9eb1-71159d10b513;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-11T18:12:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:8880:811f:a577:49be:2ded:715a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f9eac8d-9737-4d93-2f4e-08d8e4b97d22
x-ms-traffictypediagnostic: MW2PR2101MB1769:
x-microsoft-antispam-prvs: <MW2PR2101MB1769AC13B7571E032F8F23AADA909@MW2PR2101MB1769.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OT6aPZ45gCVzIfzrayqYTdOSuz2qwsW9MaQpnTjFY+QB1efT/Iy7k52nC+5aD5JDBpu/S3F2qP07+UCIQ+y2Pzfowwg/UXg21sVefPc8vLiIv7FXdNK6CW/P64qZT5gHNCzq/Jvvq8JHqqynUnYvlFB6w3Hg3LhVLjd70DCloBOiAKxbPoHvyEZND//KK5jxXb3lDX+YlnY66dwZfvcaSeImgZfalAQ38yxn6VsNf023AkRjKpag7iCVQuOYq0lJRHeDATXQOdsrIZUKX3NwMLFHqZgVQIPjlFopxr3ko0/CtrzTEsnBqYmsG02wnl9LuyR+Va+iGCtvY+aOmlhY9N/RIS7FtV9A+/01YeWcp80f+jE1QMDB0q0d7vy5fpnNM/3Qkpg9buIHfBQFvpAVcgMKD0hynBUzhPWPEbJNp4DI24+obX4FXexUSJyEUIcN8r1JYzR7tuAgsolgHZN0i+wiXEzigS8IuZvo4SsYQCENz5YUOFAvYnfZvdi6wy4vrLoMiK6JbmjGyjQMZ0to3ZijN2OPdx31rTrPReUSskYA1qE6Ef3wBNgeXzFScz0O5eFlnIz6Pc05V/K/Ph5jbBdgRBDF9zoQegoyMv2LIExtrG+KNq75iq0FeIv5PTs8okt0XbM+V8MB0npB8hZp9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0478.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(71200400001)(82960400001)(316002)(66476007)(64756008)(66556008)(5660300002)(82950400001)(83380400001)(8990500004)(2906002)(10290500003)(53546011)(52536014)(478600001)(6506007)(9686003)(33656002)(55016002)(966005)(86362001)(7696005)(76116006)(4326008)(186003)(54906003)(8936002)(110136005)(66946007)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FgnFsI2rGP8HCZjpfsBqDNWMOz8/fw136pYVS7bE7OhYWOHMnj7kkX5W/aj9?=
 =?us-ascii?Q?sj+g9lek5NVMsECmzJ/esc0CXIIs8x/046PfWLGHugRciOJcntoX6cI9AwHQ?=
 =?us-ascii?Q?3005sn3utFHn4KVOXky0Fmspje+PKhLh3AJ74oDG9j6yUcttOVQLzKunS6Tr?=
 =?us-ascii?Q?6YXjKYbmCmH695xvc9zhEeG56iDd6i+42ou1fVjzeTdS4evB91SP9cXlcXy3?=
 =?us-ascii?Q?QQuE5PejHnRWLQy2brT/14Fup9MXVcDfoonBVTOLWNp0bU+VCMfc2q4J1h0T?=
 =?us-ascii?Q?5+gThUaXGt8W4EmHGYPJ/S9+HCROVYsP1Bpyrg5VnfcpCmLRxNEhmatSiZJt?=
 =?us-ascii?Q?JOJySty9Zl651HZQAg657bEbwfovtiiCGabKJBK9iPQ4r8ieI6T3Hc4NaSPK?=
 =?us-ascii?Q?M3sEoEt7Qgo3Pq8tfqZ9XCu5WWNmYry3Ybd+dtinw5do92LYEpFyYeq7xFq6?=
 =?us-ascii?Q?nXXWun0/tUZBqC+jbgxy4LJr2/v06/7g/F3WZqCwqbjjmWsbg7Udjfgb5rlz?=
 =?us-ascii?Q?Wi/UvQCUAH9web5DnP34Woi2HLCEWX1zUxdrPAVpSN1L07JtYW0nixqj4Fvs?=
 =?us-ascii?Q?miG8ZJ3TMT45GnCchg7SH56xTdkV1Kw7Ab8r0AFG2atX0pRVD2xPLbg46AwS?=
 =?us-ascii?Q?eA12wjWdVP3ma8UGSguSBe3pS04ZecOc/gMpMSIVPKARcatkjwF18+MnfF0f?=
 =?us-ascii?Q?p4FveDZjCytNteiweiqErfKJ5rcro/K5AKEncNP3VaKJs3rphCPT804lPyeG?=
 =?us-ascii?Q?3dPK5dsjJeszWlZpL/arE6oiCshujFpakdeRFgshFCGeAp1FFMT3AUmBk1W8?=
 =?us-ascii?Q?PibRKuAYXYQrgfARyeoLogXItGaVwieX1B4XE3czKqaf9hRJaMhjYB+N0LFi?=
 =?us-ascii?Q?vn8tBnQ7EYEgltBISrePq8C7VLui2n6/pEIpy+E71FsyGl3IRpf3K4zmIQA6?=
 =?us-ascii?Q?KPnjqGqL0r/5FDxnP6oChTijgipi2TuRga/MAwR69jmE0vryL+HUACyQ5+MF?=
 =?us-ascii?Q?OkD9RfdYEbF0PCIc7QknIeUuHVqaa0pvb+LThmFiVTlmDeRpWXbWvbJJKWa8?=
 =?us-ascii?Q?9zcnMPgCSwsDaHOSUtAM7HBhxDlfff8c/MRQ43q+cXUmxlN0qKyTN6yG/WzC?=
 =?us-ascii?Q?Bh6F3Z+N8IDNYbp99fDNJ7k7mEseXlGiJpO33la5OKLkvTuZ4igm0jL+vbXG?=
 =?us-ascii?Q?3V/TqbAZaaael+CaLLZ5weBjP5XzoDq0BhuYADmWbFZNq6BcAJ0+1HS1spEL?=
 =?us-ascii?Q?AJvTf7c9DBGopfIAERnz4l7v8aJLiPMobLJuMr7gWBAdKQRTb1u9Dt4LKWOt?=
 =?us-ascii?Q?1urq7kl7GZCmAEbAWBmdUKqqV6C3RiVatvY/sjEFuNY3JjFiXjK93nSm/4Rv?=
 =?us-ascii?Q?+1my4WE+6yChaHUDmI40l6LzDtf7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0478.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9eac8d-9737-4d93-2f4e-08d8e4b97d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 18:14:19.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLLi+B1C8HVWSmuWxn1wz5vd/i2DpUjOXNyduyCBznYW+EPHx5w+o7dwbfJxFNOJRW9QHl1GmvR4YyAuzb5viw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1769
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Is this all your looking for? If not, please let me know.

> Signed-off-by: Joe LeVeque <jolevequ@microsoft.com>

Thanks,
Joe

-----Original Message-----
From: Andrew Morton <akpm@linux-foundation.org>=20
Sent: Wednesday, March 10, 2021 9:33 PM
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Eric Biederman <ebiederm@xmission.com>; kexec@lists.infradead.org; linu=
x-kernel@vger.kernel.org; Guohan Lu <lguohan@gmail.com>; Joe LeVeque <jolev=
equ@microsoft.com>
Subject: [EXTERNAL] Re: [PATCH] kexec: Add kexec reboot string

On Thu,  4 Mar 2021 13:46:26 +0100 Paul Menzel <pmenzel@molgen.mpg.de> wrot=
e:

> From: Joe LeVeque <jolevequ@microsoft.com>
>=20
> The purpose is to notify the kernel module for fast reboot.
>=20
> Upstream a patch from the SONiC network operating system [1].
>=20
> [1]:=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> ub.com%2FAzure%2Fsonic-linux-kernel%2Fpull%2F46&amp;data=3D04%7C01%7Cjol
> evequ%40microsoft.com%7Cddd7ea68d7d14ecdbd6608d8e44f225b%7C72f988bf86f
> 141af91ab2d7cd011db47%7C1%7C0%7C637510375952624615%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=3D0lxaoVz%2BYyu5C4HvzSGMf0NpJJUWZFWdp7m3hLlL9MM%3D&am
> p;reserved=3D0
>=20
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

We should have Joe's signed-off-by: for this.  Joe, can you please send it?

