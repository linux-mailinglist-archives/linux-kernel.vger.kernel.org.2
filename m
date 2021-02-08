Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1313E313D69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhBHSZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:25:43 -0500
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:44337
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234153AbhBHPuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:50:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FU2Vam//HeSyBRL9g2Td9t4v6GmrO9pX9w098+wy0n84Fe8/TI9G3oX+dqABd7H3mLwXbpx8hfIHW1PQE3dGUol1qqRYzeTi8pRgZ1TQOnNTvZ+V2m90l+ygL257sv5eS9tmFIdNDwA0jwwMOF/hrjY0Xd2C6lg1T+KV5H3t53WZCbKvCE7vwvJ4QcoqSwSmgjlXXJ/Va015wEuqRjFJ/ayEMY5PjnKVtk4UkCI/7KJqSkQ4uZZvvJrigcKM5VaN54e7+f6/Y6d5Qx3V3smUc/hgpZRi6qiuq9NZhNgrINRMF5q9IqYP2s1951MnxxmeJqGv9ZccsZfYLgrEVHGwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MCCtH0QRY+SSHef1HN9h2oOk3jN8mjhcYmwBylRUfI=;
 b=Sn+r90Mzlcrfnk+lSGzrbvie/kcNxCPpAK5jApvyONUd4aa48uEnxRn7J0OxQsd2r9WwPwbzn8whltHaIwSAhCP0nwOMQ4Oh7djMaIO3rezmGJJwTIreZqmC6/i+1tb4b/jeU9JBgHcfxUsq1T/B0oL+LT8Y64NERnay1LhViQXhW4xiE7AI1EkeUEFMiOaxPysIlA8osKzpYP4noHOrDRhezdj4ESVOlwDPYegb7G/UdP9Ya0H2CgBP9R1Cg31rMS8QsElhWPHe0cZPwHa6mDv/2KhQLE/glPI+ZJqLy0B1+4iTIVcfu/M2tkYY9XIvwaHpm+DNNeeRkaOARPxHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MCCtH0QRY+SSHef1HN9h2oOk3jN8mjhcYmwBylRUfI=;
 b=b3HYnwWRvRiZFmh3ltN5tn0/rkvgIc3OWRDOVO6xO4777I4m8VX421gnfQ4fI8FmOvOQwXQg4cLB+A75Kc0JdbH+DC1qbOHpdVZdTBANdnkoVd1a/UJL94nekTo3hRrMHoXbeSZ+7jOdIouFSBbO+FpTXrL5QKGVEcpwhy3EWVY=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR04MB7197.eurprd04.prod.outlook.com
 (2603:10a6:800:129::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Mon, 8 Feb
 2021 15:49:16 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::b0d0:3a81:c999:e88]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::b0d0:3a81:c999:e88%3]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 15:49:16 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] bus: fsl-mc: Fix test for end of loop
Thread-Topic: [PATCH] bus: fsl-mc: Fix test for end of loop
Thread-Index: AQHW+JXWIedFA+IGmEmzK+UDvJ/0YKpOWUCAgAAO7oCAAAqMAA==
Date:   Mon, 8 Feb 2021 15:49:16 +0000
Message-ID: <20210208154914.h6lunbjxwmdb2bvu@skbuf>
References: <YBf0Br9obNGZTcNI@mwanda> <20210208141803.bqbnbgvprtlo3vs6@skbuf>
 <20210208151129.GJ2696@kadam>
In-Reply-To: <20210208151129.GJ2696@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [5.12.227.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff2b8a46-de5a-4c85-3b50-08d8cc491738
x-ms-traffictypediagnostic: VI1PR04MB7197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB7197A9C7A222315DEFF25F96E08F9@VI1PR04MB7197.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whR+LWyBJBhgbvg0W5mMjhr5sL2bC32uUByfiwMzChO+s2xPAuffiN6+IzEnYvTzjwAHpacKZ7LPtSZKmgwTb8fauexkAW685DjmY/FiOFx1/69X+3akyUEHZCkMUD0qNyEpzKm57MAInXWc262U3/bKzHPEFTmcktTvXCzqrfhNtbExR2q/8/HQhHH4cUsC0Ung7gOiKGZ3L/ewEYEF14Z1Hhx2CGNSvU6KwuSfsAp4vwfrs3imqybX9ZnJrny7O3Rg8+Aq4Vnvh7SG524xcG6e+Uu01AVxO0whJ7VACKXBwZFu5F60DZ9s5tnilRG6uGxZtXFicXinGOoQSoQo3qWbCRob0r52SAUcgwjuGbMn/gFrRMvL4BPoI4A6ao2//hMolLhvmFLOvygH6OkedMOl5JW2IRc3l0Z6r8s+FEUCpnXLT6A7zfwoz2WNSAAGa4qQ/7y8EDtA3pOIHjtAl5HsO3f+QUyd9E9CHKfc3AW5QIn+LnW6n09Hf7m6Aun5AulAGZOrts5mo/IW8F2T3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(6506007)(8936002)(86362001)(2906002)(9686003)(6512007)(26005)(8676002)(4326008)(186003)(478600001)(1076003)(71200400001)(33716001)(91956017)(316002)(66556008)(5660300002)(64756008)(66476007)(44832011)(54906003)(83380400001)(6486002)(6916009)(66946007)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cze4gtGY4cOteMHg8z5LgXuuPxSBk3B7LGswpjAo4H9KwMiSTrhZ7IyQC89K?=
 =?us-ascii?Q?BkB+gTK9WYmDoRZ/vWk05bqbYJVi6DQCCNpIx/hjCiZcQ5Hqg7okkryos5gr?=
 =?us-ascii?Q?XwsRdB9s1Beb4ettIsPwE5g/z9fcf+JJlRasLfrzwGNjrjc0WVs/xb4C3yqY?=
 =?us-ascii?Q?KWFbSeDNGpHJSS55M3jaqoYKOhnslgUHx/Bu9nLsNSlXb5kHXtFsn+Red809?=
 =?us-ascii?Q?Qex1YLc4QFZogUtw/KLnHPQPugo+Y8UfklBN/9c6QXdWRgnXGwTCDnV4Y9gS?=
 =?us-ascii?Q?wqWLXvSAWrXDOVLc34eU9EXA/R/sJOBL88//cef60d58IHzusJH851jtUI8d?=
 =?us-ascii?Q?3gz45p2A3dANh/xMCGjYmYX6pQAHMOLxM6BrOC3M9r4MiCNGXhVUsawvnMKp?=
 =?us-ascii?Q?yxEaSSIZ9fgJNzw5oRFig1Wld6L1iqkP0acA0+LDX1YIbTvhnic9mbkzjh9J?=
 =?us-ascii?Q?5DJON1hg7KZmWVeL6SpfaorFg7WJ+Q4o/6/qHb6B9HnxE/Le67iCE5iRVVfS?=
 =?us-ascii?Q?moMDeqhgsSCmJPN3AHyWXxfA/OhE0jKvQ11TK37CumdcueZ7L5ObIGyQnWL3?=
 =?us-ascii?Q?cFrufhoZP6QasI3ewdAEkqI7jJIVmJvKaPrNKd0eNW5+nDgxXob+EvgCRTI0?=
 =?us-ascii?Q?dUNQyvOubDpRBGa/z5u0+j/bMHS9CIGkdYUsnoSWrJGqntgH4JvmSybHo3Ok?=
 =?us-ascii?Q?/sxk8WwwIsnR9kYF9Q6vQ+CADwjumEhRxQ5cMOsR9M5EGynn2zr454K7gM0t?=
 =?us-ascii?Q?frFr5bKLhqETETMK2X7Dq1CPdPyIsOyl467H2qJUf/1KwyZIm/SkLSEy/05r?=
 =?us-ascii?Q?k1OhEEfP+6cLjDndkFrs92TK2/uTpoGV+a9NKCbf95T04MmuoZL7CdGDprmN?=
 =?us-ascii?Q?SJ1ohEPel2ikFC4JswpzC2OXoSx/m4TAoY4+rJSSF6gpBv6b8+AplEw+fSTh?=
 =?us-ascii?Q?RR6U7qGuOlp1tVTWqxaMBHr6kIEi8I87KKsSDiuYZnsiWKspStCu/r4BVa0I?=
 =?us-ascii?Q?NKyPMS8Qt3zpjwpVB/JSR1B+IfJY/s4DkSKOR7BaN/svtRN0RGMI5+H6c8Uq?=
 =?us-ascii?Q?AlsONR0WvqYlyFgk6qEmYN/pvBSNgvoaNrhATaKuhCPJoaxSzDOJn2v3Jpzz?=
 =?us-ascii?Q?aqsHfvFriotbMRkKK+wFgMwcZKzbWT6dz1+mZiDfABQE1BPv2luan0ZjgdNW?=
 =?us-ascii?Q?kGNK8Oshtgrh3TpDhC1+h0v4T50Orku4jLcYBtBn9mUzhd9F2MO7nC4xWORU?=
 =?us-ascii?Q?o2R/zJ+1T8VCJADrDe/Q7z7vh5IfldU6fZGU3J8l8VaXPXYo5K/n4njO4SsN?=
 =?us-ascii?Q?TDOe6yfdGxvleDuxGgBI3r3w?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0E693604B0E2E46840A4B36D95F002B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2b8a46-de5a-4c85-3b50-08d8cc491738
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 15:49:16.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOyYHWpTHflQbspJ5XJUJn64TLHvlZpuNSqnd5vg6D1XLrtTWetmYN3xDU3Me3h1xOv9J8LvxjpOcoNUiwfwQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 06:11:29PM +0300, Dan Carpenter wrote:
> On Mon, Feb 08, 2021 at 02:18:04PM +0000, Ioana Ciornei wrote:
> > On Mon, Feb 01, 2021 at 03:28:54PM +0300, Dan Carpenter wrote:
> > > The "desc" pointer can't possibly be NULL here.  If we can't find the
> > > correct "desc" then tt points to the last element of the
> > > fsl_mc_accepted_cmds[] array.  Fix this by testing if
> > > "i =3D=3D FSL_MC_NUM_ACCEPTED_CMDS" instead.
> > >=20
> > > Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >=20
> > Hi,
> >=20
> > I just noticed that Greg wasn't copied on the initial email.
> >=20
> > If you don't mind I will re-submit your patch along with other updates
> > to the fsl-mc bus so that you don't have to bother.
> >=20
>=20
> Thanks for doing that!
>=20
> Was Greg supposed to have been copied, though?  He's not listed in the
> ./scripts/get_maintainer.pl output.
>=20

Huh, he's not listed indeed. I didn't check this before since the fsl-mc
bus changes have always been pushed through Greg's char-misc tree.=
