Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF57346234
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhCWPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:01:57 -0400
Received: from mail-eopbgr1400092.outbound.protection.outlook.com ([40.107.140.92]:30098
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232478AbhCWPBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:01:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvULL4oxIY5lbbDQ6xX70fFuJ2jyzWDfbXBqm3gWJMkdhVPOlSw2VbnmZQ0XRJ25MalTT7n5hO7mo5axH5MjJoi3TrZk+s+ZcqYX9Ta3Ky8i+ag0FgRD6GMsqrBVR3S0wcooJrPl0CvdvGybkSY4p9CNvwwPQogUe+WAfuFbhMD7aQJJCCDHZme4tEm0UxuvdlVzdWIljvLhdY+6MHcm/MfWtWmzxpLdYrg5dlEaBJPb+mYJ48hr9OYG9GlG6SveYqW1sTyj8en08T+Kvf3pIM9SsBKQEoxYFFM3RKr1mScX9lqe0PfQhOp68dXMMmu040KMB0EV577Ap2DPMPSojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amhFduQQuDz7Gc+wdTOWBbl+for7vJ1R0HvincxQyXA=;
 b=BDYzVk9L+ymBNxTeb0HI+yRvduYRLqJ2iIiitiULOgHt9LpTNdG7AygW3LuBbLsp9Ar+s6ZI1/uUgZJbY72/PjiJepAjrjKZXsw56tTGImfhHeBeMH/YNezEm16deKO1SCXQOtCyXqXf1Q8/1Wg37pBmdlPuwTC61nLDH070isx/+KrlqRN+wUWOUDcyCILzrNtz73ps4lSJIRSYcLU3ryC/8j9ZfGOSeI2WlUYEPBFNMtC1qIn/7jhEruoTKVzTtAery8sou1xDr5pa4OKMGgNecIEZMzGOwToK7dQD3ROHZpm0QASp62jIVdUsX5FbxkAwWC0+nF2j3Ebs3FVWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amhFduQQuDz7Gc+wdTOWBbl+for7vJ1R0HvincxQyXA=;
 b=OHlm+w82y1FzzpYIzFa3a+5JwSoUuIcEVnILM4WZObWmeBZPCgYoRSxCupQwQOcB0J99Z7vK/cFKqZAit423SoEGq04+nCv+hqnTudDNaofBEps20CQCyWq6/CCO7OCgG8ZR3zdtmh6/DowHpKulK3XsEyLfOcKxT0uRdXWskQ0=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB3554.jpnprd01.prod.outlook.com (2603:1096:604:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 15:01:19 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3977.024; Tue, 23 Mar 2021
 15:01:18 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXHaHa74VwN/FjdkmaampQXlqTRKqQHbmAgAADg8CAASTagIAAaHmQ
Date:   Tue, 23 Mar 2021 15:01:17 +0000
Message-ID: <OSBPR01MB477380C80BF54FC993479C96BA649@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1616254985-28920-1-git-send-email-min.li.xe@renesas.com>
 <20210322150319.GZ2916463@dell>
 <OSBPR01MB4773618A38B6797EDDE2E5B9BA659@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <20210323084403.GG2916463@dell>
In-Reply-To: <20210323084403.GG2916463@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [173.195.53.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79bc3775-0c05-4473-85fe-08d8ee0c8366
x-ms-traffictypediagnostic: OSAPR01MB3554:
x-microsoft-antispam-prvs: <OSAPR01MB35543C70E3D2186D9B933A5BBA649@OSAPR01MB3554.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5Eccb/qHbFRrsC5n7FGaHkq0vA7hPHo4OfLyUOSHNCd/bgDiyDd6AyoeA6U5tlmBgtM9j1Hd+22NtQJbH2HBLCdy5H9GSmwRaorpeUX5VMWSCABzB/jG/KCDRA1zt9HqMgeN3wf+GzckKeA9dGTibfQC5YXTfLdj49DJ/843qsjm1+mM48Y6BYucRAzVbr959yfk5lkhF7GK76ubraL17vczvW3RRukeRR7qqzcwgGOfY8xhsKtIHq1uWzf9y1g0hsh6LkmtUOGeBHeDL1YtowcFUNNfJTiQjz5zNg+OLu4sk9zm4espgSO0d5mKnmCrgzIKxE2eRwX2aNKCUzEzxEKAW09ZmTkOlPRf+ucSUpf0vkGFGoFJzaJrv99UfqP0pQyzXVyrRk82tXZIDt/MPRYcgTXFN7GOUAFDjkc0bhgfcfhGWXlMkXgaGnmWGSeLEoPws2J+CGXLqTor9SxzDHz+T6AZ73EJS8k5GUJ2luPMb406+7mVP3T3pEwJCiGa9I/AjjHIslosoRKsL0xeYH4ADY+qal+/0mpqO24k87jPztQ5w2wOc1pVJk2TsR7owYr0TZwyOWUj6xGSej2XMIV8wtlCGVunIBem7EqJZw0GKfV8nPWaCKVotKWlZPHBEvhnr8gMrtSCa8qBtrAEaGsPe2S3BKAwSv4F7+clqk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(2906002)(55016002)(86362001)(6506007)(9686003)(66476007)(64756008)(66556008)(66946007)(7696005)(76116006)(186003)(66446008)(316002)(71200400001)(478600001)(8676002)(26005)(8936002)(54906003)(4744005)(4326008)(5660300002)(52536014)(38100700001)(6916009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?d8Jtv/TLg2DQ0xHkkmWw9mas6bDKnlrvEykyUJb5/PAajQm+qUJ8YVmYmJCE?=
 =?us-ascii?Q?pNBb4dl8TMfcqXsXdcmwYcXN54XkoWa3hhGEEezbBF50XcxoexpssB6DwwQG?=
 =?us-ascii?Q?y2ucOTV/DPRaods3oONd9Souss3qd6neQvMSN58mbammeEKlu86dBGh13no6?=
 =?us-ascii?Q?KT2v+J4KjKDQ4CZX59quPpAoVWyBOFnmsJwhukEYZi8FG3/L0yajpr9aJx5p?=
 =?us-ascii?Q?uJmD2tlzxZMqXOIaPllX22g9/AttHcfRScYzLHDRe8IRz5j/eZ6KyqanoPGq?=
 =?us-ascii?Q?RglGm6gtkXD5EqUmziilmrsIFxUe2+i/5BA15t6lAsOZwN5idjHaNvWnzeR/?=
 =?us-ascii?Q?OgPpZBEIpMZRSqJn6Mm/REcsEcIcrxXC4OmLYUBRQn0iUPNJrJ1Wf7TA1Sic?=
 =?us-ascii?Q?xGm89jjaM+oloheIjdDq0XDH8hNQI/NmqL7Yf2Xj0Awc5PhYNP/0UTctIaih?=
 =?us-ascii?Q?3Rvn3cAbohTDL6hw+c/rQiOeGk900hGwBu5BzzYvLgU9lQaWry9KXYd6qrFP?=
 =?us-ascii?Q?0ehQzMF3Uo+IRgKvaNHpwFd2oYcF/EBAytMqu2QBQxL6PN3D5XCt2BLEcQBm?=
 =?us-ascii?Q?iKHNzGhICQrEVhw/aaRimQclkel94bPjS+C5LAVMTTJ5YO8oeeA+nYZoTNAY?=
 =?us-ascii?Q?oZQ/0muWzue1hu4rzODFX+v4UxbLEvxpnn5nTfQ72v5QZMCx6sezHKp0BD91?=
 =?us-ascii?Q?vfftbkDsovjvyiiFewI4ERHrMVZ8im3LM8S9ggjx2TDC3ipsFk4umm9vEdgh?=
 =?us-ascii?Q?LisLvqXskXuEpmcT02maTQ1G7w+U+ruyvhBR4jERQQwTi7INJSuHiAlbyORC?=
 =?us-ascii?Q?WWgFyHBpRgh2QUhOOJDQ5V/8+7WKCJJk+3S0e8zVNNchwYnMjn72LQA3IIYN?=
 =?us-ascii?Q?enEU8cIn1va7EbZNdRs7ekcBsDzMoBKtsYW/LehwWqH3TNQUQbZ/LMcsaHUd?=
 =?us-ascii?Q?G/bMhhHkXZhPfd30IR17sLh55bvQu9ljPy7tReMMOE62ZEoO/Og6zTyPG8Av?=
 =?us-ascii?Q?CnHy2/D7sqWepYWS2vH7f5Gt9j01rzrDYxk8RChVE6FVHn4D0dXrJ2tSixJz?=
 =?us-ascii?Q?AqWFEolAQRFVLEWy6cAV+FoPGkNWKPu6GqyULz+E4T/gZEy7LeoztGf+v9If?=
 =?us-ascii?Q?84PLy0ThAuPEwQ3z6llCLwLSgEQ8EMMWBLjXturdp+2pFraHYWUxL3vSPb0D?=
 =?us-ascii?Q?CN/hxH3UO9r03lIfdSThgV9piQRTILgRta++FoLT84MMoW6ixuXpGiYhu5oz?=
 =?us-ascii?Q?orwZAva33FmM68vcJA6CnXKR6heMfh2YQNxB9Fz69Is8As8IhjnDDEslYrJd?=
 =?us-ascii?Q?fF7yPGX16S/CCXsK65kL5L8o?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bc3775-0c05-4473-85fe-08d8ee0c8366
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 15:01:17.9710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/NoshB6WqeqmmrDJGQD+IaEm6T3vnG97+I3Gm0zEMEFfuxLgJDBoav8iFLkR4Psx0GxHOer2qw1QaSSDLItlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3554
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > I am wondering if this is the correct tree to submit the patch for MFD?
> >
> > So to sum it up, the latest patch is my first version to this tree.
>=20
> Either MFD or -next is fine for MFD-only patches.
>=20
> Has the code changed at all in any of the patches?
>=20
> If so, please provide a change-log, so we can keep up.
>=20
> --

I kind of want to discard the previous patch and start a brand new review b=
ased on next, can I do that?
