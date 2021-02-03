Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B29830DEB1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhBCPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:51:17 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:54956 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234581AbhBCPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:50:07 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113FOm6m003208;
        Wed, 3 Feb 2021 07:49:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=KxdUxsWfCaVr23Z9nZcLfst7Ey4QFjLnwho37Esird4=;
 b=U1turQ0/Us4PSzhz2levz0TwNszCUscCp1bkuG1AChK6SmSmgWkka1x52trJsSZv3aUp
 xdbZjFv8uWEtsenNXIiZBwgITydQmykeBvBbCUD6NIaDOfXga5ji6XzyMingQPaMWQt9
 am0nhuc6Ea6oHmZ4DDgEkIfWlSR3qa8onyFcNz0q6rCjZh4KJtPdx3IsXqNfc8CNvJ7B
 sNcrznilTwweLJIEhDs/eVMFP1c4t+OoXIi2Mz3GkgDzfFQkTfTSidFuR0ssAsEaGc01
 eG3jbzCJPurmKLAu5I+I9SjwlectxBZfTz9qgjfChbR1rEXtk1HaRQEfkUmajiC5lYSl 6w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5pt3r1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 07:49:10 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 07:49:08 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 07:49:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 07:49:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNNEi6OmSNr9fr5Dp6ca28JkDr33XXDBsRFAFGr79jUvmlbb/qZqrDhZYld7D4wHbMBkD6sURcJ90QbSCACG8r66KyfKX/+cA2Jebdu/z8+Lt+23NXHB42JogrIuS/wdvdOR0DpkvxWeyN+xYdUj+pNSASRhnyYFzFDzB5DQt+zQdTCOHhebhUyfmVguRx3L+eeKKDDuJLBWtp5Xwzdzl0NjhhKP2fpoGEWIdl73SPkKv74xRexEy499XXFu0CeEF+MIXFgclnJJUBhqTskxg4CoifiqhLKrbE7+AhAwMIJ/Zz+Z6n0rt5wn1PC2hmk/WID6xXYq1aRY6K9MXfcGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxdUxsWfCaVr23Z9nZcLfst7Ey4QFjLnwho37Esird4=;
 b=CBO6axT7DURWSRM9tWQd17v3wf3A7ZPwA/VFL4SGQgKMITvtllmqWaL3qNJWYdFLMwgXUsvXR6OkxPGDYLVOofLU7DewiEYjZohQSG0ubvA55f09vaWumlPYHu0M/pICM/0iLn8sfVpKehdPjjZSGags2gY5fOhaJvSIMFpyP4T8pzINH/rJbl36dkJnY5qvQWLUj1Hn1Y5uEQUW+eAYpZshGYLkHXf9BAh0C0p4khrKKlMrl/MNgVRhr0G51hcP6gxiNrEGIJLPQoGsYFaXAePNuGnc9pmPVNcaIHDR4RchOjRVKDtkxvflIcZXfAnZ9qaFay/kxM9J6tblHDth0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxdUxsWfCaVr23Z9nZcLfst7Ey4QFjLnwho37Esird4=;
 b=cn6nz6UC+BnZA+htnETQqw3Ary4TXqAK+tBHZrkDYw9iZsO4IpuBmaWYz7m68R9597Ty4NgNgGLxcLOZwgSZjTS2fKLOxI9s9OnvzjNuLChR+dgmd+1ORanrmnWY/XDecydr1mK/eLNUcEdRpXFS7n9yKBgWWqB1kJhybspmI30=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM5PR18MB1196.namprd18.prod.outlook.com (2603:10b6:3:b9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Wed, 3 Feb 2021 15:49:06 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 15:49:06 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Ben Peled <bpeled@marvell.com>
Subject: RE: [EXT] Re: [PATCH 03/11] dts: mvebu: Add pin control definitions
 for SDIO interafce
Thread-Topic: [EXT] Re: [PATCH 03/11] dts: mvebu: Add pin control definitions
 for SDIO interafce
Thread-Index: AQHW+jEKQCswtMtvs0m9H80l6I30SKpGfTAAgAADanCAABD4gIAAAg9w
Date:   Wed, 3 Feb 2021 15:49:05 +0000
Message-ID: <DM5PR18MB1452C48E962EFF6D3A47978ECAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-4-kostap@marvell.com>
 <20210203142806.GQ1463@shell.armlinux.org.uk>
 <DM5PR18MB145298C7C6CB673A6B4B5038CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
 <YBrED9hix11heWv0@lunn.ch>
In-Reply-To: <YBrED9hix11heWv0@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lunn.ch; dkim=none (message not signed)
 header.d=none;lunn.ch; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [77.137.153.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 078a55cb-9198-4fb8-b502-08d8c85b3cec
x-ms-traffictypediagnostic: DM5PR18MB1196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR18MB119608148F1E27516DBC1975CAB49@DM5PR18MB1196.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmO9AEFF+HYpbJyDlLZqBbV4B6ysnhy5JBv/j6g3+ZngLtsnagDxnf42iBIPl6LZg2mKlkgYeJZo1H2Ogj1vBP0hzDDpcjdOhkWrBgw04iIWjHPhviSo0b4O+ZbB5COoSSLNmDbSVFotbL8U1GOGmPMOZYIxvvhYJ0ilKcLOWyxRsf2w/kNcLbLRfSYZ+KQ9mSLC0ev1f8zuecmAGtoDA4NqsBizs22quC8nG4Sl9qG3p/BdKT2a32XSUmkCIOb21f7Mo0G6pMWaEtBUoDODPHhiCL3UMh278J/6Fs5CQxnTqHqQIoCato1etEwxPDgutJzNi+gWTwwLbvbQjYdnlpjTjfzXqUvpV3I2m4shGJtzCl3QuklBkeHZ5gaJSNir9BDpKe+8nacgX736v23LA7xZUj7QvLXSRChzpgc83m1fkQqvYMWpKWAKDGMh9Y57j2TDnqYFR+x//swUv9+Pm+SCM1qy//AQeY461/tCjqWrcuJbYAAfhFXT+obakpLdkmN2bR0u4sFQMoo2HKBEWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(86362001)(66946007)(71200400001)(4326008)(8676002)(186003)(558084003)(7416002)(76116006)(64756008)(66476007)(55016002)(5660300002)(26005)(6916009)(316002)(6506007)(9686003)(478600001)(8936002)(66446008)(33656002)(54906003)(107886003)(66556008)(52536014)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+OkQfXE4W7u+ylKjYVKP/x9Qt2EPWjc30Ey1v/APo+84Yfhvyji8zIHpuAlG?=
 =?us-ascii?Q?C4+0d+jSsmmOimtKEDZyjx05TAPwHOgDmdLqU9zMrwu1StPMzM89t6LDF1As?=
 =?us-ascii?Q?blAh7TFZST6h0jMomdmGGWWfN4rv2VN+PoqKlZ7vXfjJvfeS69tfz+NeZgoQ?=
 =?us-ascii?Q?vr4hUxcSBeGfYrEKxWPIDaHsidJ/sXyTCUhDQXEW1Uz5Pfao0j2okOYuJbNa?=
 =?us-ascii?Q?M0R5u8zSRoPYAq+AMSdFp4ohVoBJhaSkkIl+4wajqsGdOnnfnlyZUYE2FZ62?=
 =?us-ascii?Q?o8dryyQ6sLEJmol4fgBrey39nidLKvbOPw1iCoar5uswaAvcfWSguRoPouqU?=
 =?us-ascii?Q?5S0wKtdbHpELe9VgBM9sMn/peBr93bdbUnxuW1cPh1P9V8/g4/H9YYBZAGny?=
 =?us-ascii?Q?5sU6jMtghfFMpKKedYRmdcbXQSN2Z2PvvS9ttf3WaHqI6cdLJTX7f3QOcZN+?=
 =?us-ascii?Q?WlZxO431fiTOciup4tVyjib1rtMoQE/6Bi/2Y2jNh5kZWYAMGg6irhVJBaF5?=
 =?us-ascii?Q?7jlBXGkHojb1ipl9QkzXu8lsOiJUQ5JxkLUGG8OYf80oakgyw2W+O29Q7Rro?=
 =?us-ascii?Q?4mop+KJ2/iZBGLrwzYt4D5Z2rFqvOZCTpqLekAGOnPk57NPqaBbQm3bWc+UO?=
 =?us-ascii?Q?1aYL4ZJ5xD/BJa9rJ5gUiL3NLeLjPYw57wpzpWsgjmLWBlhfhAuWqR7P4QQi?=
 =?us-ascii?Q?3T6ZwV7+41G63TuI+TlK8abiTKUGt95KnC2ZrDE+VRVDbjNbJynzKowfQEuh?=
 =?us-ascii?Q?fPSw94zLKyA55IgZhN5DRFno/wxltgresaefkSHzJ3VH4JYufN4QUgSEsTrT?=
 =?us-ascii?Q?YqQWlUwhxqefOzGifRuUf7N8xWWl5viXwp5fDZ0J/PsYl7B2AWUDFo/eh0im?=
 =?us-ascii?Q?s/96MggYp+IGXXKTOIkNk3OvHKb06K669ZmwnE1A1fefXfplrjV7e66IzeJ5?=
 =?us-ascii?Q?+JuTJjjYOoJ2F1v7YOJBTwcVrdOYFAcvdboNz6oV3PAo2Jc5SFQzDt6aGnzG?=
 =?us-ascii?Q?kL6DPgoB96NHRaDL0bbSFRgiPXM+yps93b7Mmh4xiX7Ya8m3AH5RAF72+/mH?=
 =?us-ascii?Q?P4tbhDti?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078a55cb-9198-4fb8-b502-08d8c85b3cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 15:49:05.4943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hAR0ZVtCkvnGpO++nYmZc9enAmnTxNuYJmXPrEzxKK7Da62i9DDHAx3rQOVVvUjsSoQiqHQh+86m/L6z6n9+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1196
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_06:2021-02-03,2021-02-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> > > > +		sdhci_pins: sdhi-pins {
> > >
> > > sdhi-pins ?
> > >
> > [KP] You mean to replace the underline with dash?
>=20
> I think he would like a c added in the correct place.
>=20
[KP] Ahh, now I see it. Thank you, Andrew!
Kosta

>   Andrew
