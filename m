Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812EA30BCB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhBBLMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:12:25 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:17363 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229849AbhBBLLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:11:45 -0500
IronPort-SDR: ZMi2i9XlBzaWwgqSXuUJBk6Uz0RiPxHrJRHv7p9C13jcQ92q3kMS8YfrQQQVLHwHYbFkNtaeLM
 0SMCILXD0vgQz3G8WCC51ssSTxgqSZmmaZ38ZIq8nbPv3CrM2awbrxoiUb4qfV3kAXInU7m7ms
 FnfXwbwlVwcX7s3v1WAniw41b78+XX+RurhzTuGaP1OGe5jr7NwJ4vEa9Uab6CR0JTxIZHI5iA
 mDb/PnhcUfSpy/VUirdG8lNXCRIZlcI+Dv7KLfaCqapH4weGivQiiG2D8jiRv4v6rEBC4vNxww
 S18=
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="25369429"
X-IronPort-AV: E=Sophos;i="5.79,394,1602514800"; 
   d="scan'208";a="25369429"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 20:09:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBmwlq9qi7bgtPwXmu8myznbaCqaxAdRzriUTJA5E9VVCpXRfmwneWbYid7kY9hM4M2c05xiqkaO+6qjLrl7DcHU+iTxRerVMCcOB5ipEOLQ4s8mcneHdXzYape1bDRqKbLi8vVrEdI7g1XzB7NAQm1aSaYnT8B6ZlGaMU0L70dt2Pl9od3PkUnmgRK9AKTpVPO6yjdpnJU2Qq1jXBQgBcHyO9kuP5g+cViBdWg02etTsdXT14WeHlKEYA7g2YvJVBMM07xXvVKGeQLXaDi4OPGPj9Pdi53TZ+EveszLoZLk2/E5KiYctgsDIkDE3B4fb2kbA8M63wQ+056mHyO53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfEKznEQhdEwnaqG+TTVmlz6wnkNgVGYgp76u1PnczA=;
 b=nOLtZyqspEaeeYKqVPD8q8XLFDM/m/OJcKo+sFihuRUUz9YJQeNJdBGVILZnebh1ipxdf0N4cnBnsRs1psye2vwBEZP300Fk//bqba+Pvv8xSdIIreBfs+rGg6kkrtoOrek2nJ7m3rspEGEiUkIVBy9MuLM48/qd1D9o3ckyIFRzLhxNTg2opYtfoRTcJc4yF8sVKl31x1Fix8Rn63laUxlJYEivA+aw7ZeTDRPM32dXUhmdwejEiKhNbEi4aaHypALCmwQtbiTtobYAEXgw/G5iCCjnEK0l4mOfQGe1+T1D07uH8Bufvh7cSyqqOz2ZHEg5fajtn5+KNTvS4ZjBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfEKznEQhdEwnaqG+TTVmlz6wnkNgVGYgp76u1PnczA=;
 b=Suj2IbbJPD3izEIYpMxKEN4detXNiRRLn3Kk/x21tfZ44AuRTrhe56qTDelgvBXjr2neSfBFt+0EQ1Y05SnD4oBu6lqTmwQEo7vJkaQrR4HuDEK9nb6PAwb8CyosKtmPPkOcLhlz8gf7BvFMr465w8s4SpCpNI7I1hi4XW8MuVY=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB2962.jpnprd01.prod.outlook.com (2603:1096:603:3d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 11:09:17 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 11:09:17 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 4/4] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
Thread-Topic: [PATCH v4 4/4] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
Thread-Index: AQHW+IwaTDkxjimhBk2agd6bvCyU06pDXBgAgAFGPzCAABLPwA==
Date:   Tue, 2 Feb 2021 11:09:17 +0000
Message-ID: <OSBPR01MB4600160956C3BAEB55C6028EF7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
 <20210201111310.3231469-5-nakamura.shun@jp.fujitsu.com>
 <66d5411e-222a-224f-1099-f476e3dcf6df@huawei.com>
 <OSBPR01MB4600B423DB2D36E93CFF82E0F7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4600B423DB2D36E93CFF82E0F7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 116f16046d0e4c14b63b521d9feed87b
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b435a08-40dd-4116-0c99-08d8c76afb92
x-ms-traffictypediagnostic: OSAPR01MB2962:
x-microsoft-antispam-prvs: <OSAPR01MB2962F4F5EDCECB9F2DBC3879F7B59@OSAPR01MB2962.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iqf+7lIpQeKm6jQ9rqfoW3Err4DfLBVlfccDWhtGQdytEkWMM2kMm5D+2X0Mr7FDxCLiPR+Ow6e6M7akqgAMG8K9Wz47PK8VjkQaL97VmWJIyk1wgvdKcalcvd4Vcv+0BwkBcqbp3q5kzZxwgjpCiCILp0I+z6D5UjeWcz3u2EOng3Ct4TOqAVA6+ivMVe6bIk8Cc+wGpAmO1IvP6cV+/NUNjbOOLime23ZClxiNU842yMRrtJb+JFFuIhOOXEK1ZRTC0Kgto+s3ePvRQveZcmYEIUsFh0jgXYLB8lhlAh7mNJxHHE26PtrCpJIcTc+3P4R3ktXsfV30lJ6haimNaTSoe8iqGLTjooRKIagyMD7EvsrKbtGxSfuo2c9PZky/WMDr/OlVClhGvepgmkS7OxgTt4BRZqP+n56g3YUqJNjtf04eGD16CQwufpxO6CXftj4F39yGoyGbqoQiyAi3F5hquhye+69su5NwXWhkXj5GXDskv6/YiO2sbUu5u43/+C0p8aMs63X0PJsYlRq675T02eXkm1bGpnmEWXn1VsZ9kd2AZjJbrnTJcMTpGikvOoUGB0nAlbkh11PC2z6SWXXKLJO6r0m+y+qnElI7+VTfiyUSJQWLh5BdP2RVhb3kdpLCtuy2qU1QYf15EocQhqTxC3MnuqJ0QqIG2uCQifE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(2940100002)(921005)(2906002)(6506007)(7416002)(86362001)(76116006)(64756008)(66556008)(4326008)(478600001)(85182001)(7696005)(83380400001)(9686003)(316002)(55016002)(8936002)(966005)(5660300002)(33656002)(186003)(52536014)(110136005)(4744005)(66446008)(66946007)(8676002)(54906003)(26005)(66476007)(71200400001)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?dkdwYTF1MmdiMVkrRmZ5WnlUY3RjWHVIeThyemhBVVlxS3d4c0RqM1RL?=
 =?iso-2022-jp?B?MVRuNGNXdXhOeE1WSHJDUXI0WE1PVmZVaDFTY2ZFZFFORXJpT2dGMThH?=
 =?iso-2022-jp?B?emRqbk8zN2xLRVQ0NzhSaCtGaGI1ZlFac3YyeG1OTlI5bW1rU0hGb0Zz?=
 =?iso-2022-jp?B?b290K2VXVDVFWlhsaTgxTnBvbVZEM0RpNGhTYVdoUjNJaWY0UStLbk9o?=
 =?iso-2022-jp?B?dXYzU0lwYjQ4dzBYK1dneEVtM0RYTEQ1eHcxYzU2VENwMmJkQUZjbmM2?=
 =?iso-2022-jp?B?NHROaVRleDBRTU5HUzYySHJyV04rSVlIeDgycVZLMmR0eUZaQVJnSGVs?=
 =?iso-2022-jp?B?ejJBYjRYZDhmb1U2UGNqSi84TEZEVll3THlCdFYydHFsU3VzZ3Y3bkpC?=
 =?iso-2022-jp?B?Z2RjbEpTRkhZbVZwM01sbmVlYVozcEJUc2l5TmJkL2V4VnNzajFMeEp3?=
 =?iso-2022-jp?B?dE1za1Ezdjg0dksxT0lZZWZNNVl2Zkk0YlpnZW96R3NzRmc3cVpZZGM5?=
 =?iso-2022-jp?B?NkNvL3piVXZLMExLRFZ4Qk5kUGpEY1k2YzdBOVh2NGVNcmoybVhDRXRI?=
 =?iso-2022-jp?B?K2doY1dkY0dxMzZyeGlrODFPSU5hZEsySmhrMkExMHlpbW1rdFgyQm1X?=
 =?iso-2022-jp?B?TkpBbllDbjR6aU8wRVMzT2FNSnpQZC90eGNqZlBTd1pkZHZ3MjVIZllq?=
 =?iso-2022-jp?B?UXZFZEl2M091V3h2V25qaFdIRGptbEVaYTE3Smh3RmZhZDkvblAzdW4v?=
 =?iso-2022-jp?B?Wkphb1ZyRHdNKzIwWUV2enVSdEx2bjZVbHV6MGdEcVptZWZzZVo4OEcw?=
 =?iso-2022-jp?B?TDhEa21wSWRLNlJFcE1hT1JsRmdKbWZ2eDBRM0tKTnJTVCtCVTQ0UWtN?=
 =?iso-2022-jp?B?d0J6a1hLUDFKWUc0YjJjR0t1dURFZHFTbHhXUFRONXNya1EwNzRwcEpD?=
 =?iso-2022-jp?B?a1lTSlZmdkRtRWwxTkNESVhJeFNsV1QvQ0g0Q3BnN3ZMWVhTODdkTG9F?=
 =?iso-2022-jp?B?OHJKcy9aZTZJQzFhOFQwQkNOelh0VGsyWXZ2dFV2V0pZSXN2RFdMT1g5?=
 =?iso-2022-jp?B?ckkwMmJSKy9OcG40Vy9JbnRGUGxVcVRMZnUzYVZ5dEFDdGlzYXltQlln?=
 =?iso-2022-jp?B?aHBUYkVvcjZydVJUQVdVaEFUaHpUdzZ2Mld0Y2JtU3J3b3VFWlljd2hQ?=
 =?iso-2022-jp?B?UVFlQjFwcFo0Y1YwalRCdk1PdHdRNzB2SjVQaE0yeFkzYVFacFJVVER3?=
 =?iso-2022-jp?B?R2wwNlhnRlVXTTEyeHRsMHhWMC9ONFNpeEp2V2Mvdzk4THVZU0NxNDVN?=
 =?iso-2022-jp?B?QXRtNlRTOGljV1FXazJzakRaZkZ3YjBocTY0WjRaeFhoZHRBU2NGbHY2?=
 =?iso-2022-jp?B?SnBwNkhmNjVSOXhkUVJDTHFlVmR6SzNPLzdWeU9JbndkVjJlOUdSQ2xP?=
 =?iso-2022-jp?B?LzIwN0dBZjgxcHpha1Z3RzFUSW5EU204VE92MmNvNEs1Sk5VWG9nMU5p?=
 =?iso-2022-jp?B?c3hINEFUZzJJVS9ObGo3Q1pkbFZoTlRCMVJGNGNWdk95aHp1NXA=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b435a08-40dd-4116-0c99-08d8c76afb92
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 11:09:17.3578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXyxR+3vDTDgus+X9YV1/KwGUcUhIfEIQUabkKub043WV8rlQTYrNyWKDMJP6aeZgwe33cPqqe0u/VhytfqMWuFe7/6g+YJgw79Fyg3R4XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2962
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I missed to include the quotation in the text. Will resend. Sorry about th=
at.)

Hi, John

> About the subject, include "arm64", like other commits in same arch path
>=20
> about "V1.2", we use wildcard for matching MIDR, so will these JSONs real=
ly just
> patch V1.2?
V1.2 is version of the specification sheet.
It is not the version of A64FX.
I remove the version from the subject because it will be misunderstood.


> > Add pmu events for A64FX.
> >
> > Documentation source:
> >
> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_PMU_Events_v1.2
> > .pdf
> >
> > Signed-off-by: Shunsuke Nakamura<nakamura.shun@fujitsu.com>
>=20
> nit: generally we put whitespace before "<"
I checked the mail, there was a space before <.
https://lore.kernel.org/linux-arm-kernel/20210201111310.3231469-5-nakamura.=
shun@jp.fujitsu.com/

It might be hidden by your mailer setting.

Best Regards
Shunsuke

