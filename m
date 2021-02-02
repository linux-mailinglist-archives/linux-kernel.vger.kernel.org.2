Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADE530BC76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhBBLAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:00:35 -0500
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:28031 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhBBLAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:00:32 -0500
IronPort-SDR: 6BKdXST68v2ktxq1l5NCXYFJRczh6L+u7xaY0eQ81ShKbPBc+rifH4FP7j3caKD3CFYeZ3dc6l
 VGzks4Y+mtGzRN4RSWF+j/SoDVGLWNK3X9jOB2xKvzc+4cJHveVrLyc0suMahpFGRNTnDNEQz6
 gjKle5FQzs7OeK+4+Pcv41YuRMj7aeulpCGNl+KiMinKHDnO1E6qbuQbbdEmiITeUXwXg84dOc
 qptOdWKD/WT5zpxPvyXH0d8YSE3S/XaQFf/bhoPDAABSAV8B4PfyaJo3mhPtTybye45PIGqVMN
 E3Y=
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="33381254"
X-IronPort-AV: E=Sophos;i="5.79,394,1602514800"; 
   d="scan'208";a="33381254"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 19:58:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhQSea1Vw89SNhGF1TdInD9FIhdtgyBUCGb04J66wKbS2KxK/oZE2uiBfawGBdPsMKSiExocL74yOBboz4dx/hAHQR6FnCRnVUr9WEuKgNLsGgWrfyuarE2p3izu8sMfQx9B0NUjxwrRjK+kDQAJI3LKSzND5QihczouQGGbDNFd5QMKYZqS+dx8UGUtdb5+4Ug20BK1Ft4jy1GAlNMBLpZinIlFQdLiUpUdWmkAxkZgtQAG9p/fmVs481iDjLO+s1yujAoadm/df9oTc/he+XAO4Hpi6tCEqKoBMX0Vj90CO/HTXEeZvYSdzoU38IiC7AGx7Ptnk1v57MbmxgqiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otarDFi7nrsoq440lQvM1WtT5nt6aeLKYhiIRMEThAQ=;
 b=jIGp0pl4MnT/GHkeyLe9Ock+lpWyYSv6YnNIQh8W9lT2I8JIQ/BOXiYgLJ0liDJLRGyw4my2Dw/MgH0jjNu2gpLJB7BEZvX0jKkMIBPvPk7f3AbiUOQZW7VFW+bsH47nKxOtzO6vrkZIOpxkwHNAxJqqHozgzFwe93ddxJdHm2nK54tn9oJTFVxLSAlxmZA9SY7KUFI0KGdfxj49F7A9p28WSxSfZpkJHzIE7tLTzbQfBCk2PjkgOUjMhnf3ow8BXJoM8FfeGeSsDDO6yX8DHYCwfyCeY+uSkHJBPjnIrQYI68Rj1iaSNs5pw8Fl+0c+Knh6YL4YUazP+HxlJC5pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otarDFi7nrsoq440lQvM1WtT5nt6aeLKYhiIRMEThAQ=;
 b=lteczmR7klMERrgyEcp3qrn6Ci6eCnc1BBfIOdxeEt1S9U3VBW4UdOwje/Bb1DHl04taPiGRxamP+XBYHRhEFY0gSrxjZnc/IyOiaKJddoxHVH8O1cDNYkAsWBEXIIzKGvIdFo4oqsU3dHIxmfBUXdQluH5G5EDr9p/Z4zQ7ztg=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS0PR01MB5571.jpnprd01.prod.outlook.com (2603:1096:604:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 10:58:04 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 10:58:04 +0000
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
Subject: RE: [PATCH v4 2/4] perf vendor events: Add L2I_TLB, SVE, SIMD, and FP
 events
Thread-Topic: [PATCH v4 2/4] perf vendor events: Add L2I_TLB, SVE, SIMD, and
 FP events
Thread-Index: AQHW+IwaBJwIDV7skU2AoKNC0iztQqpDWkoAgAFFj9CAABKkgA==
Date:   Tue, 2 Feb 2021 10:58:04 +0000
Message-ID: <OSBPR01MB4600F81934D90CAC5922639DF7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
 <20210201111310.3231469-3-nakamura.shun@jp.fujitsu.com>
 <fd65e539-d8cf-e1d0-103b-ad8154a42173@huawei.com>
 <OSBPR01MB4600196B268A2341929BBA39F7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4600196B268A2341929BBA39F7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: f2fa01f6d3844d6a930c4500b2111f78
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [218.44.52.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d4f7624-d179-4703-32d2-08d8c7696a60
x-ms-traffictypediagnostic: OS0PR01MB5571:
x-microsoft-antispam-prvs: <OS0PR01MB5571C5E6A6CCF72C76BA41BBF7B59@OS0PR01MB5571.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJf1G+ED0UWFN6BYZwjkpKJxoKnX7GV9vcVddlVJ0Sn77fFc7WsRCaiXkJSYX2CSTJknv8uDW7VouR+QdDFsP761BCoyCF7TM67GtUymkFrcwr7p9XbEpIr30BorhNx0cFeiUDuEmGIIDxa5Gwip/8GwVH5+W0GBGKNa9Dod5S+yiYn/nuZqS25DzA6mAJhJF91x/PMFZHt4dCsT5EskOp9cs5Xh6ZR9lX18VyMbagreM/ywNqg6AY1FGPTyPeOyK4HykH08rPJxfW0GIpjmiXKEbTa51CNJEscklRDGq3aEukXjc6qCd69bPXwqZTp1eAzDLENjlhcOO8bGtPEiBpNwsfE7rI7JDpd8Uw02U6JZDxDqHmDOCN9daHOLmuKytq8m1rXpAffeSB9mymbcNi19ndCVYK7H7l3f4s6F08cCgr247+tjJ8RWu8VXLHYK7JGmYqezySiaucV9F1hScxo/O4uSbVtQ3JfsuB534Q3qgKAU24wS/fkTotwt9bOxK8L0QcGzmNd8GMTqqL5oE6ldM+PHuanTxmDSlwxOfE0RqDSICjRSZZw9LrINeStUZj9jQqUwLtBiEmKhQifN4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(66556008)(7696005)(64756008)(66946007)(76116006)(66476007)(54906003)(85182001)(2940100002)(33656002)(71200400001)(26005)(186003)(316002)(4326008)(2906002)(66446008)(8936002)(478600001)(110136005)(7416002)(83380400001)(52536014)(8676002)(55016002)(4744005)(9686003)(5660300002)(86362001)(6506007)(921005)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?QXdlRUZtSHZ6K1dLeTlrTGJxd1dlQ2dMZG84Rmtqd3FCYXFtaEQ0MnhE?=
 =?iso-2022-jp?B?ZzNxek1CbUdtTis5TFlFSXBJWk5sc2IrbU9wRks0V3gwUisvUWQzSm5M?=
 =?iso-2022-jp?B?NDQzTUdGZm1ITFpYVFJFQks2MDhiYlB1bTJqS09uN1ovWHNueUVZcG81?=
 =?iso-2022-jp?B?ZGwwZ3B0a01IUE9scVM5VzZuaDNjU01FeXZ0N0U4SndPZElub0pFaDZL?=
 =?iso-2022-jp?B?V0Q0bTVzWTdSaHBWYjlGSzU5MlR2UFlURU1xVHQ0dFRVVkw0ZGRhQ2JH?=
 =?iso-2022-jp?B?RVJlQnpyTzVYRGZJbjgxUkUzYlY5aFBRVnZhQ3ZLTEE5ZitGYWg2ZHJo?=
 =?iso-2022-jp?B?QzBuOEQ0VUdPREVlUjB4U2lCckpWN05CcTIvaFJuTXdBcTNOcGhrK1pI?=
 =?iso-2022-jp?B?bnNqYmkxaXNrbXNweTcwVTVyd0hQKzRYQUlUeWdRd0ZHZE01STErM0to?=
 =?iso-2022-jp?B?Ukt6aVYwcUFkd3RuY2s4aytnbFpaa3craUZvcHRNMWhmck4rKzdIME5F?=
 =?iso-2022-jp?B?bVp5ZWY1aEh5ZUdESWFpeVphUGI5Q2FETkZ2SFlSRDBZSkRDTW9uT3Rs?=
 =?iso-2022-jp?B?QUtyRXhvRkptTUU4L3ZMK1E0VHo3UERlRE8ra1lrOG9aT20vdDlGbEpC?=
 =?iso-2022-jp?B?bXFGUUVpQnpwWHFjUktOYVVWV0pKOGVsZ0lieGQ4Uzl6bzkwcnFHSHFU?=
 =?iso-2022-jp?B?OWJYSDBPSS9FdGNJTVBrNVV2bjFwbjl4bGF1MERmMzNNblpralZaRkpX?=
 =?iso-2022-jp?B?b2xSMG5BbGNhTjFGUmdpV1ZrRFM1MXRmU0NTcTRYYmNZRTBUSWY4aTU2?=
 =?iso-2022-jp?B?U3pjZE9WLzNGZDRqcWZodDRoS01ETmxmbVdXc2x4ZkRRRzcreERFeHUz?=
 =?iso-2022-jp?B?NHkvYVhMSGxSSGpnWGJuZzA2WHdnR3RDOGZoWVpMVExjaTZTWFk0djVq?=
 =?iso-2022-jp?B?bENFWHB0emIzaENWTzl0Tk1nV3JaTlVtSG91bTkreno0TUJ1cVZSTnZO?=
 =?iso-2022-jp?B?VUdaQ2J5TUxPVjhGL1JVRHJrL2o2VjRBSkpRYmVTUi8rMHdxOVZZYVIw?=
 =?iso-2022-jp?B?TVBpRTAzWDBrQlZCWE05VzBjV3ZTaWpTeUo3eDN2dmp0ZU5yaUlmbzNk?=
 =?iso-2022-jp?B?RXdnNEhCa0ZKQWRZUHpqWnhnbnRaak84NjZwQkNRN1Mra2VrUGhVTlZU?=
 =?iso-2022-jp?B?Wit5cHRtVjcxOU5qV3h4enJ5QjhYVkNMN3lKUG5YQmxyWEZHOFhPM3BQ?=
 =?iso-2022-jp?B?OVl1ZlRzQW43TCsvZWJHaXRNeEUwNkEvV0dLSkh5aFZUV3lyUSt2OU43?=
 =?iso-2022-jp?B?TkpERS9ETWxoZC93Y3VXRnNoV0FSYnlkTWNXcGs0R2kyNWdocGlGMlVn?=
 =?iso-2022-jp?B?RVkvbnFHcE1MbDZhNHUxWlpiRmVvMGU1NkU5NzNRd2lUNGJVTHpWbHh0?=
 =?iso-2022-jp?B?R3c5UlFmOHlhcDN4U2tma0RFMmxFbDY2QTlvSEFKZ1NTRUR2bWtpQTdm?=
 =?iso-2022-jp?B?TDB2RExmbG14L1NMcUJ3OWk1Tjg5N3JxOTZtL2x4MFFrMjJkU0U=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4f7624-d179-4703-32d2-08d8c7696a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 10:58:04.2128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0CyMMANomA+yrQIyiVDMrHfi/rWOk3QF7KyydNxHFT3lYBwmgsSYeMqXvVHBC4rjXPrfR8lxthSCw+5o5MblnkXnj1HjJl5KBPncJqFuk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5571
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I missed to include the quotation in the text. Will resend. Sorry about th=
at.)

Hi, John

> I think that you will need to fix the subject, like:
>=20
> perf vendor events arm64: Add more common and uarch events
>=20
> > Add the following events.
>=20
> It would be good to mention your reference document.
Thanks for review.
I will fix it.

Best Regards
Shunsuke
