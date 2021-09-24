Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D729416BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 08:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbhIXGns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 02:43:48 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:60297 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244227AbhIXGnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 02:43:47 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 02:43:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1632465733; x=1664001733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rE5GBWUX91A79mHlT9LKWHpAA115wCG0Q7xCzLNoG/4=;
  b=ZCDBgvOTRCVioRi8CzQkCLUhc6a3Go6WrkaN+KISdTaamFwec3HS0WxY
   xqg0w93ScGsPFgBD/wQyK0MtVhMePUxkx0BtghW8x0o/f/O5T6KF00Wmn
   V8oQhNi+ds8d0AQR5dMy9t8W5m5SsqeBU0VCebxeoS3DPfEOKXi35oOTP
   XgT1HqMjQ722xnbauFPm4HFzuKRdA3S23Alsq6tj/ubEtpw51+GxbNOYK
   OBgo9aNYGmUrc4EpV7XTi6gE7Ozb4S5Gv2i0nlvi5SI2whX5eh6CVHZeR
   EZaH73MSyx207uQBzMZkDXdZzSmnu0s3rgsUZmt8d9jrHZdISaaCiyoKZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="39808413"
X-IronPort-AV: E=Sophos;i="5.85,319,1624287600"; 
   d="scan'208";a="39808413"
Received: from mail-ty1jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 15:34:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4Zwa1MVcDFRZPW5lQWbeAZCBKCMhqCqKalQ6YpR+MfjDHh8zE1NZIseIiGp6278tzMBoVPQasja5flSCC8MUPMRrTZ5oavYOQy7bcW3vxoEHIru5qRB3Xkrt/X0sXet0ip8pXwTK0PWdl60peYqxl47Twp4FiiArZc7dfbylbRwGNMYOngSxpJW1S+i+0GiqiphOQZTptbItGr5GOyWJzniM6QJO/QbHbQBU5MPUG8crURaDo7WriD5QZH0PJWWK1xSy7RpuHjpVghzoYJnQwNxfpS4GS3U4ydAPDaxyixeAWe3DtkOPHDyuJXSoDhbdKYbsqsKS2R8ehctT7W+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=awrlTu39vUskxawL3uNsY2ZViEopYEUS+d7kLVThCHA=;
 b=JPhqtR6AdnrsaogvHXqnEd/DC4sqPiIl18HEpLBN4bXAsW5NWyXlyCoy75AYeHBg3pU7CxegedHW0SABlShjpnT/pO5I7+i8EAtWpwz9zUr363nDJFOudO0AfYR1b42n3s5/NJBnJGP70YevQm65+rmq9PLnsl29qI6uIYalPIbxx1EgjCEdj5NJn6OtKNrlkVBnTeVc2UBSzoanG7JGvQaf2eq1bsfrGLBr9aBbt0DvX5kFdDuHaILhZ5qll7xzXk0YcK/fvQsLysQtV09BK1CPCA80ZEQ1mxoQ3bO9zwsA430lOkGu41STxF86ey3KCDxGAhQ8UDDdSJvu/eiyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awrlTu39vUskxawL3uNsY2ZViEopYEUS+d7kLVThCHA=;
 b=JlPqqzlWYEFxaIMAHXd3QpoFOeySmVFvKqCarpC6c10wQc13nnEuqdXjhx+4DS3XP63z1kWsqYTtrA7K84vUrKnEgDS5WLe+w9rFMPelIg2cKhtEIjCOw4XgG/v6HMFNLO7maXTDz+o8G+179gqDAVU0dW3pLX9+D+blE/32f6g=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB6719.jpnprd01.prod.outlook.com (2603:1096:400:9e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 06:34:55 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::c9d3:f528:4d7f:4c83]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::c9d3:f528:4d7f:4c83%9]) with mapi id 15.20.4544.015; Fri, 24 Sep 2021
 06:34:55 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC:     'Fenghua Yu' <fenghua.yu@intel.com>,
        'Reinette Chatre' <reinette.chatre@intel.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'H Peter Anvin' <hpa@zytor.com>,
        'Babu Moger' <Babu.Moger@amd.com>,
        "'shameerali.kolothum.thodi@huawei.com'" 
        <shameerali.kolothum.thodi@huawei.com>,
        'Jamie Iles' <jamie@nuviainc.com>,
        'D Scott Phillips OS' <scott@os.amperecomputing.com>,
        "'lcherian@marvell.com'" <lcherian@marvell.com>,
        "'bobo.shaobowang@huawei.com'" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
Subject: RE: [PATCH v1 13/20] x86/recstrl: Allow per-rmid arch private storage
 to be reset
Thread-Topic: [PATCH v1 13/20] x86/recstrl: Allow per-rmid arch private
 storage to be reset
Thread-Index: AQHXsQan+yJlIoUAO0qG+Q7vC6SdLquyt8fg
Date:   Fri, 24 Sep 2021 06:34:55 +0000
Message-ID: <TYAPR01MB633030707DD9C8AF6A2FEBA08BA49@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20210729223610.29373-14-james.morse@arm.com>
In-Reply-To: <20210729223610.29373-14-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9M2M1Y2VlZjMtZDc2Yi00MzY4LTlhMDctZGZl?=
 =?iso-2022-jp?B?ZGZlNDc4MWM0O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMDktMjRUMDY6MjU6MDVaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08263f9b-a90d-4619-63e0-08d97f256c4c
x-ms-traffictypediagnostic: TYCPR01MB6719:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB6719A8BC744A645A96AA66FB8BA49@TYCPR01MB6719.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lEveBX2gFGkREG4TSwjgjLz/TURfGdxeMq89bIB02d+zSDbQ3u+Rvd8eh92EUO1zLUhKQlUT15abK+d+IMNxsrbVwSkJ/dTpSoVQNyUzysCspH5FGvGdNHTAmHbE5gjjHkFSaIHD4TV9iaA/EaZ7GUgaMRC8QDMUojj2pm6Mzx9xTF/gOFXIufmhh1iPeOJ0gXoFbpP9TPQ1Tf38LSamltvOsuyq2sdpN+41jCkgD5auoevMx1ea799EOLUssTP/VLhWUJBDRYoWd3N2tAlZbHTiQ6lH4xgUgEnTZtNjwSKDzbZbv07sOpkPV60ydYLVsmsfXIcD4r8NF4ccNYP6WCtZ/c928m9HmBZuIdlYFOdH8Z5tg+7nPLICjQqabI7LHpkHzlBC413iSRniufk5ax6t5LmWg8YQz0yJmqnZV4CjpWrby7NVr2naFNsL+xM2aJcqjJHEGvw9aQWsgolG2lAuJhJzj28zKq4MYN0E1s1zCKveN+dNDBeznnPl/xe2IBj2Fww8t1DDzqP1jmvDYsoJHnKMCD/j0Z2IvST+t5W6GzkDKDVRl3111QyKf7Z1LoHiyzrRh1hxr5Cz6g1El9HScreLeM6V+XunKJpy6+dN+OTSZRp0EDbt9RVPPlTD88AJiHuhaXWG+VSowQK/i4qBMWBxSXyvb5jmdPuvAzSl5HWKoS1KKUbRK7L1mMPuAh7paSXkhTj4Gf7ZhxaD6jgZKXwIbpkOhTijrMxvfBw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(8676002)(66476007)(33656002)(76116006)(66556008)(64756008)(122000001)(83380400001)(55016002)(66446008)(66946007)(7416002)(107886003)(2906002)(186003)(38100700002)(4326008)(38070700005)(508600001)(8936002)(316002)(26005)(52536014)(85182001)(9686003)(7696005)(110136005)(54906003)(5660300002)(86362001)(71200400001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RE9aYXQvWHVENTZlVWhwbkdnZU5XYVFtd2NRRnAwMld2ZkJFalVhNUNW?=
 =?iso-2022-jp?B?eng3Qjc4Sm94TmlyRzNUcWlrRlpFOUYycFJIM1MzS0ZIekdyUVordGk3?=
 =?iso-2022-jp?B?ak5CNEk3Rk9wdE9yVE5KaVJMWjRMVTBDb29uMDVnOFlSLzZyZzEwZzY4?=
 =?iso-2022-jp?B?eWkxNllnRmxRdE1sR3RTLzZJNWJMV1VNMjNmdHJJSGNnMUE5WDBKeXQ4?=
 =?iso-2022-jp?B?MjBIYVhodzAwL09PSWJvNlhnckh4VjFBNWc3Qjd5NFgrK1UvNXdXdmJX?=
 =?iso-2022-jp?B?M3dnZFA2dzhXTGNxUU9heDcyNEtCUGV3QXFRT3E3Rlo0RHlOY0tXUGNV?=
 =?iso-2022-jp?B?TjduTi9Samd4clZDODFvbGp6aFluc2VuU0JHc21vc1ZNUG4reS9BSmxt?=
 =?iso-2022-jp?B?ODRNTHVRSTdxdDU0ODVUNDl4R3dlNGhyRmZaZEJXRVZvQ1lvbWxvZVAv?=
 =?iso-2022-jp?B?Mmo4bk56OWpSejhlcXc1SmhpUHg2VGZQVVp4bUhSaStHR3F5Sk5rbElT?=
 =?iso-2022-jp?B?dXFySi95WE5uMkpOQnJ6eFVmNDdCeDBGNWFrT1FLRElKT0VXT3RFVFhj?=
 =?iso-2022-jp?B?L2I3V0l3Y1lITTZveS8xMEdZaDFJRTlkUmN4bktMTitQZzU3ZkhncTN4?=
 =?iso-2022-jp?B?NFN4M0ZtT25sMDdLWm5zcThzOXFmL213OHNWNmpLTFJWR0d4TWFsdDZ6?=
 =?iso-2022-jp?B?NHI3NHh4WnU1eFJpZERDVDFFakN2TCswQmFOWmVCS1RYMnJMOUJVV3VS?=
 =?iso-2022-jp?B?YUQwSmtha3RkeCtyOGtPVHFhK1I0eUlNa1FCekdDZEdHQ1dvaXRINUF1?=
 =?iso-2022-jp?B?UXRrUXZFTVVxbEFyTjRqNy9RZXV6cTFDcGhoTUR5TitlMkN0bnB2UFZF?=
 =?iso-2022-jp?B?M1F2SGdYUDJQVmxNNWNsekpIN0pOUktMSDhPR2d6aVZKMkFxdFFoOGJX?=
 =?iso-2022-jp?B?OVN6R1JXa0hqamtQeU8yaldldVlXemNkR0J0elN1a1VLRG50WnBrcm9G?=
 =?iso-2022-jp?B?OFNITXc3dVJOSDlBcldLZGpyWFV1bys3Vy9tSThtU3ZzZVpESS92dFp6?=
 =?iso-2022-jp?B?ZlJCbitERVBVMTYrRkE2b3FEZnFIWHlNL1RYNzcxQXpyTnhqTTYrVU8z?=
 =?iso-2022-jp?B?QXJJZkpKeDBPdWE2VExPR1o0Nzg5NmpvaGQ1NmVDQ2UrS2FyWHNVQXRs?=
 =?iso-2022-jp?B?WG5pQUxPVm5VU0VjK0hPaDdveHFRTXVpZUpxYkJnY0hkbGFQb0V2anIr?=
 =?iso-2022-jp?B?RDdCRFdvSGpMY0IvQVN1czRKN3RKc2ZCVFg3RC9oTjRSeFd2azY5VzNs?=
 =?iso-2022-jp?B?Qm5qTUFIMyt6K2NXb0JHcGVWU2JQL09XY1BVZW5tam00ZXpEMVlvUGc3?=
 =?iso-2022-jp?B?Q3R5QW5SUUkrVU9zOUxoeTQxWUdnT1k5bXZVU0FEQmNRYjBLTXl2QTMv?=
 =?iso-2022-jp?B?T1hmaUN1azd4d2ZCcU9HcG02b3VoV0dUN3FYcVA3VGo5UWVhMHlORW83?=
 =?iso-2022-jp?B?RVE1M0tNMkUrb2dodVVJMlhPUGMwd0pGaFhMNFR5YTBaeEMybWptd29R?=
 =?iso-2022-jp?B?bTBPYjVLYkZQR2hreStpRDg4WWlzMVRzUzJxU1phdmlSZkIzdmczaWll?=
 =?iso-2022-jp?B?Rm96dDJ2bURLQjBNTjcwd2RGZFJFdTM2MW9jNldWRElCakxwUlMrWmgw?=
 =?iso-2022-jp?B?R1lRV3QrS0ZEY2UvaVJHbWlqRGVuZGttOFlTM2FWMUJ1cGRjWklLTHlN?=
 =?iso-2022-jp?B?WGt4TCtUcWF6bUQ3RVRVNUJ1U0I4YTVQSnl2Mk5XVDlRYU93dFR0MXl0?=
 =?iso-2022-jp?B?d09ObFY4YkxLY2laeGlzM3U2L05RYVpYS0dTZkZjRnphK0JCbFVQdW5C?=
 =?iso-2022-jp?B?ZFppUjFSZUo5ZllrTEZ2T2FIa25VSDdVY2MvRG9Kb1d0YldJOVhKcHFM?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08263f9b-a90d-4619-63e0-08d97f256c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 06:34:55.5993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTqwG3/qwZfby82cEEo2qne2Bv2vEsGUCryFJMTpQAjK1xy+UU1WdPGTn+vzHgrQZMDDkqvtdgmZlXdc9YwzAiJZ42WLd3v7ZxIi00dJGtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6719
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> To abstract the rmid counters into a helper that returns the number of by=
tes
> counted, architecture specific per-rmid state is needed.
>=20
> It needs to be possible to reset this hidden state, as the values may out=
live the
> life of an rmid, or the mount time of the filesystem.
>=20
> mon_event_read() is called with first =3D true when an rmid is first allo=
cated in
> mkdir_mondata_subdir(). Add resctrl_arch_reset_rmid() and call it from
> __mon_event_count()'s rr->first check.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 18 ++++--------
> arch/x86/kernel/cpu/resctrl/monitor.c  | 38
> +++++++++++++++++++++-----
>  include/linux/resctrl.h                | 23 ++++++++++++++++
>  3 files changed, 59 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index aaae900a8ef3..f3f31315a907 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -22,14 +22,6 @@
>=20
>  #define L2_QOS_CDP_ENABLE		0x01ULL
>=20
> -/*
> - * Event IDs are used to program IA32_QM_EVTSEL before reading event
> - * counter from IA32_QM_CTR
> - */
> -#define QOS_L3_OCCUP_EVENT_ID		0x01
> -#define QOS_L3_MBM_TOTAL_EVENT_ID	0x02
> -#define QOS_L3_MBM_LOCAL_EVENT_ID	0x03
> -
>  #define CQM_LIMBOCHECK_INTERVAL	1000
>=20
>  #define MBM_CNTR_WIDTH_BASE		24
> @@ -73,7 +65,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   * @list:		entry in &rdt_resource->evt_list
>   */
>  struct mon_evt {
> -	u32			evtid;
> +	enum resctrl_event_id	evtid;
>  	char			*name;
>  	struct list_head	list;
>  };
> @@ -90,9 +82,9 @@ struct mon_evt {
>  union mon_data_bits {
>  	void *priv;
>  	struct {
> -		unsigned int rid	: 10;
> -		unsigned int evtid	: 8;
> -		unsigned int domid	: 14;
> +		unsigned int rid		: 10;
> +		enum resctrl_event_id evtid	: 8;
> +		unsigned int domid		: 14;
>  	} u;
>  };
>=20
> @@ -100,7 +92,7 @@ struct rmid_read {
>  	struct rdtgroup		*rgrp;
>  	struct rdt_resource	*r;
>  	struct rdt_domain	*d;
> -	int			evtid;
> +	enum resctrl_event_id	evtid;
>  	bool			first;
>  	u64			val;
>  };
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index af60e154f0ed..3b8b29470a5c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -137,7 +137,34 @@ static inline struct rmid_entry *__rmid_entry(u32 rm=
id)
>  	return entry;
>  }
>=20
> -static u64 __rmid_read(u32 rmid, u32 eventid)
> +static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain
> *hw_dom,
> +						 u32 rmid,
> +						 enum resctrl_event_id
> eventid)
> +{
> +	switch (eventid) {
> +	case QOS_L3_OCCUP_EVENT_ID:
> +		return NULL;
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		return &hw_dom->arch_mbm_total[rmid];
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		return &hw_dom->arch_mbm_local[rmid];
> +	}
> +

Since it is unexpected to come here,
it might be better to add WARN_ON.

In addition, I have tested these patches on Intel(R) Xeon(R) Gold 6254 CPU =
with resctrl selftest. It is no problem.

Thanks,

Shaopeng Tan

> +	return NULL;
> +}
> +
> +void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *=
d,
> +			     u32 rmid, enum resctrl_event_id eventid) {
> +	struct rdt_hw_domain *hw_dom =3D resctrl_to_arch_dom(d);
> +	struct arch_mbm_state *m;
> +
> +	m =3D get_arch_mbm_state(hw_dom, rmid, eventid);
> +	if (m)
> +		memset(m, 0, sizeof(*m));
> +}
> +
> +static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
>  {
>  	u64 val;
>=20
> @@ -291,6 +318,9 @@ static int __mon_event_count(u32 rmid, struct
> rmid_read *rr)
>  	struct mbm_state *m;
>  	u64 chunks, tval;
>=20
> +	if (rr->first)
> +		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> +
>  	tval =3D __rmid_read(rmid, rr->evtid);
>  	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
>  		rr->val =3D tval;
> @@ -306,12 +336,6 @@ static int __mon_event_count(u32 rmid, struct
> rmid_read *rr)
>  	case QOS_L3_MBM_LOCAL_EVENT_ID:
>  		m =3D &rr->d->mbm_local[rmid];
>  		break;
> -	default:
> -		/*
> -		 * Code would never reach here because
> -		 * an invalid event id would fail the __rmid_read.
> -		 */
> -		return -EINVAL;
>  	}
>=20
>  	if (rr->first) {
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h index
> 4fe2d5500315..79e83ce3dfbc 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -32,6 +32,16 @@ enum resctrl_conf_type {
>=20
>  #define CDP_NUM_TYPES	(CDP_DATA + 1)
>=20
> +/*
> + * Event IDs, the values match those used to program IA32_QM_EVTSEL
> +before
> + * reading IA32_QM_CTR on RDT systems.
> + */
> +enum resctrl_event_id {
> +	QOS_L3_OCCUP_EVENT_ID		=3D 0x01,
> +	QOS_L3_MBM_TOTAL_EVENT_ID	=3D 0x02,
> +	QOS_L3_MBM_LOCAL_EVENT_ID	=3D 0x03,
> +};
> +
>  /**
>   * struct resctrl_staged_config - parsed configuration to be applied
>   * @new_ctrl:		new ctrl value to be loaded
> @@ -219,4 +229,17 @@ void resctrl_arch_get_config(struct rdt_resource *r,
> struct rdt_domain *d,  int resctrl_online_domain(struct rdt_resource *r, =
struct
> rdt_domain *d);  void resctrl_offline_domain(struct rdt_resource *r, stru=
ct
> rdt_domain *d);
>=20
> +/**
> + * resctrl_arch_reset_rmid() - Reset any private state associated with r=
mid
> + *			       and eventid.
> + * @r:		The domain's resource.
> + * @d:		The rmid's domain.
> + * @rmid:	The rmid whose counter values should be reset.
> + * @eventid:	The eventid whose counter values should be reset.
> + *
> + * This can be called from any CPU.
> + */
> +void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *=
d,
> +			     u32 rmid, enum resctrl_event_id eventid);
> +
>  #endif /* _RESCTRL_H */
> --
> 2.30.2

