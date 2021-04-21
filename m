Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE3366AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbhDUM3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:29:05 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:38726
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239755AbhDUM3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJojhh6cMyE4XbTx1AuDwHHpRB2whlqAgtkLZtqkexU90TCTKEGqM7/MuOK4C36+LlE6/goT2W7sHDrdUidBV6wSaSckusEsJspxURApQMLpCr/VLTUwcRgTkwqivQdqi+62/fJXiHtNA1ahNaQvj7bXgP6ibe+4Ax3IjCPXybVaf22gKf/TmI1+yd1VFibIUh8pEFQKVN8VGeE1ocHTNZ2x62d0Sfy8uGr1hbQkRtU1pVmN8jwveLWlvrZWo+eK8+ISKlWAYLA7K3cYCXG8Do97mkcL+GCgjeUmt6uYaNtLMrZraiZAK/8JRY8NOF1SEvI2MWn/clYmYpTRIpId8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRXNDFe/BpccFuYl7aEJ38Flrs6lN+ERe6SVpalpj3w=;
 b=FzcajeGXZRr6BM4fgIIi/O5J92W+WT3OuUvVfqNtDGgbjqx60zGQeoKm5XT6WqS9Hn+3rTTV0yVVPZdaTkFe45Wy6lWrZvEgcwi8AmA6awwC/JOoayKAVQ6lJhCMsGd0b2wG2Ap3I+Z0VdP2GZPNznPiLEmyDJr4XBjeh6wyywE67u8UpA0yhjLkWn0HNgaKtjRte7ZH8oJvJBzXGoEF2xlFFdJKXg/0nzEWeBRJnWghurLf1BdmxLWrdJUOCmSCeFZmfVF9dZGVlHrzEadmdLI7HCGhQNpYbu0ApZ4N7vTLyItKYGj+8t2DpDo24Ty0wIPz/LlJh+hPoIFJg5YY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRXNDFe/BpccFuYl7aEJ38Flrs6lN+ERe6SVpalpj3w=;
 b=OOzXhkMYXt/jIOYsp4+9WqYkexhHxb7yMoKQUQs4/0Oub1a/xjfHreBebuAB6aEtHz45b833NpRBqz4DOpj2Gc1OZdZIQHkiJuvzeWQihQSCIHt7EYbTHG6No9O18xNbc9m2GX3BIQwO65FNZTxOT1Yotm7PLJ49BfrWLXcsPp0=
Received: from VI1PR1001MB0974.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:65::17) by VI1PR1001MB1310.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:e2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 21 Apr
 2021 12:28:05 +0000
Received: from VI1PR1001MB0974.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59a7:1b77:eaad:247d]) by VI1PR1001MB0974.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59a7:1b77:eaad:247d%11]) with mapi id 15.20.4042.024; Wed, 21 Apr
 2021 12:28:05 +0000
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
To:     Mark Brown <broonie@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH V2] regulator: da9121: automotive variants identity fix
Thread-Topic: [PATCH V2] regulator: da9121: automotive variants identity fix
Thread-Index: AQHXNqTIQeuE4c6CxkS8M3yftaGjXKq+3uaAgAAA+7A=
Date:   Wed, 21 Apr 2021 12:28:05 +0000
Message-ID: <VI1PR1001MB09749D2585D4648242BBE1E5EC479@VI1PR1001MB0974.EURPRD10.PROD.OUTLOOK.COM>
References: <20210421115216.9C1BC80007F@slsrvapps-01.diasemi.com>
 <20210421120143.GB4617@sirena.org.uk>
In-Reply-To: <20210421120143.GB4617@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [147.161.166.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fea3009e-e004-43f0-4f36-08d904c0e9d2
x-ms-traffictypediagnostic: VI1PR1001MB1310:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR1001MB1310C5B62C693BF334FE1241CB479@VI1PR1001MB1310.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zmcc1iaQ9Ephg6UJNxXFvYU9hLimKlqg/E7uilgzekugDT4PgRXziMMt8pk0/9EAOQeoHTCSRsuzYGZJcSiZnEZ6DXLBlmZgXGG9FWGtmdVogLZl0Y1YJ8vTPiLBbXpTYCSj/luERKPIuQzCKQ/Bg5COl193gBS48wqIn7EBDeiAwmeS3bms3bGIvvI5hzfaJwsswmoSEeG2zDidFcuGThwgD4j7H303LFdKkJSwmSlpA5sZFrlh1+cG1JdTcgVAyPyuhXzs0L9dyNe1fY8nmiJrZiC/7Z2wXMs4A12MLYo8Y27cbvJAPdYTuu3Kb+P3NjdN/Zu1bs+llL8qfDQyHa2H9tCnDGLR2wJ9bdRyerpHO0TzPwVeZjxOADsF/eyy86/k83moWw72XYNw6w5f/CM0WhQsF8RHXt8vhk9UviSdFMhZVWbYqk7qxhHKgh+5xgN22tW1w/O3JH7b1DhcWoMcQ7+iiaVBgo2u7NMU5+39PlRb1MIeQwRnoXZXCDhG7PEOOIAMHqHQhYUI1REb5MYu9klQBHe7bn0eEJy4iDQEgCN/YaM328ihqU8mcEBRmF02gLQjmpgFwas3pw/U3jYO09UrEPYLfgj6lSiCh7w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB0974.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(136003)(376002)(366004)(55016002)(54906003)(6506007)(2906002)(33656002)(5660300002)(122000001)(4744005)(4326008)(76116006)(66446008)(9686003)(64756008)(7696005)(110136005)(107886003)(86362001)(8676002)(52536014)(8936002)(478600001)(38100700002)(66476007)(66556008)(66946007)(316002)(71200400001)(26005)(53546011)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fKy36RxpVDXVY6ONArkzAmygw/1MIhzuW/YSWluddUV7xzAmHQj6B0tx4Lgw?=
 =?us-ascii?Q?OgMGv97ve3B6alDeg+TrBIEjNgRLmnbaqfydPxjOXBcitDQLuiUYuoCQkYbp?=
 =?us-ascii?Q?Xxt+dJp+rlcusLS5Jc2BOc96o9gZFzRfjGRTpgC54eEgJrRfody/G5bC1CaQ?=
 =?us-ascii?Q?EqdHBQA4+XYk3rfaW307LQlwgmxbTmUaVFtEVVz6965qtE9g69p3o82hBwSj?=
 =?us-ascii?Q?qOudA+uD8Y81JbhigpIOt/Jga8vOA5uPHgEFH/k1Ceb4Pn8cCQFxvidEyDNj?=
 =?us-ascii?Q?tOS9H3TVGHOgA+q/Im6L5MZ0YeiI6057q2AXTHWAWKyXxheQEfu9pKEsZ0f4?=
 =?us-ascii?Q?8TK6ORDMjokk5GxqQm/T3g1Covs1tMmbsg5s6ZTEJh12PxHy4BUt8lC2+FSR?=
 =?us-ascii?Q?/0rqmSY56bB9BljUN3o/D2MzEX0xfe/0jYjQMISQygjBj2XIvW4qxkIrBBP4?=
 =?us-ascii?Q?hp2Wn26/d5uKl/Wji7op6lVMFuv7sWw2lmPMBcKn9DeLu227u8j/O4tWlh0l?=
 =?us-ascii?Q?l7zak7SHTx/IEB6Hn0G3STUlpH/fy39OuM/7+7jpZTCyownKPHNC3VBF3JPK?=
 =?us-ascii?Q?lgQQ4tBgo2am8LVcA47anfx8W20ozxLOUW2Iv6mFzuuNpi2ut/Bn+JBPJTR4?=
 =?us-ascii?Q?CN5aMJEHP7bThF4I/CQqiKPRUuxdfkdsEjIwV+qH5hSKw+S3FzPc6ur4I2wW?=
 =?us-ascii?Q?4r8curwfk9BzT95/tiW5sjHUlIYD6XEJ/wzO82vHDXrIVUmom1zFoqBDEbWs?=
 =?us-ascii?Q?yMdFk2mA+jmmFYCTTRmdbMJc2ZMd08ctIo/SZxs0qEeRx1eoGB6yT92k8Dh/?=
 =?us-ascii?Q?yaq4613iIUbc7aKdhXHhKwv9ipO7kGz67+mnP4lrbND+RT1TvrQIBsJr1ez6?=
 =?us-ascii?Q?w/E/XAFdTNpEh2ND/hRxbJBGlJIXkx1JRkY/1wdEXQLeWNIkdUH6KwGrtjGd?=
 =?us-ascii?Q?MxD+ZBM3va/zbCjEKgbxwWC884GsP3Cye/pnE8a6Dnktro0/rAsB6cjz+lRg?=
 =?us-ascii?Q?8mMYMICbhS6sQ441kqAfrvWJWNm5iYi8aONlDjO+puQcKE8/TppA/6v5vPmM?=
 =?us-ascii?Q?T1/IZlVNBb7DCfEMrRRruQ5EQvZ5/SXqJkpgiP0bjcadQcEMlI7+fmZo9mK4?=
 =?us-ascii?Q?OUfM+JrQUj64Xo0zlMwi2YsmB0/JF6R8IADre8ZnNCwJHAlKRhQfl/dAAzMG?=
 =?us-ascii?Q?vRNxc3h5TFQNzBcQHNLgQLFHMjhL1/2xbMlzKhI4HWfrHJdJLIb+nf6VZYWH?=
 =?us-ascii?Q?iLFccoc40UW2Mc9RPInGuvRCdb4tvXq5JYKAlZdk9eMcBLEeJLUFAsvSvnQF?=
 =?us-ascii?Q?ecgycGTfkCjfAo3/kPGap9j8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR1001MB0974.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fea3009e-e004-43f0-4f36-08d904c0e9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 12:28:05.1672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQpUprNny6B/4BGHQAepvXz/FHez+BN7ZgrJITtxt1S04C68NRVAjRinv4Vbwt+JjkHXqNwhl+sFx+f7tV78aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1310
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 21 April 2021 13:02
> To: Adam Ward <Adam.Ward.opensource@diasemi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; linux-kernel@vger.kernel.org;
> Support Opensource <Support.Opensource@diasemi.com>
> Subject: Re: [PATCH V2] regulator: da9121: automotive variants identity f=
ix
>=20
> On Wed, Apr 21, 2021 at 11:52:16AM +0000, Adam Ward wrote:
> > be exclusively using automotive or consumer grade parts.
> >
> > V2: Fix for TYPE/SUBTYPE error I forgot to commit before generating pat=
ch
> >     (Thanks to Raviteja Narayanam for originally spotting this)
> >
> > Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
> > ---
>=20
> As covered in submitting-patches.rst inter version changelogs should go
> after the ---.

Apologies for firing off V3 too quickly...=20

