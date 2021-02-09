Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD811314B61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBIJWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:22:04 -0500
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:53890
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230363AbhBIJR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:17:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1kuGs7cuSr6mw1B224MjZ5Tp4gt9u+TIHdUgX/rkf7cOoaZ9fVyy/EoNh/oBxGJuvZ+yunwuU+tbM7DiSXqDa8+QFfLJGql46ODw5ippv0zNRozr8B+1ZZf+LglPt2duEUAG7kOIqMsUAnX6k5xqiHXq7n2Qj1eioWRr07Ta/8jEW7OxQpFSRr/alnDmpRGW+i9y1uI0WYnoc9mxYZ8PAXDpVBleHQHGHtgmwWxR5VT0zXB/W4d57ebKVgM4EWDZrUiWlWy/67yJ7VTQ5VLGXft/q0jhaoUT8Wd95rwl90s6fCZCfoH5zaEc4a/sNExD+NOqHAugF3Uw+wqd8tKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAoCEl+UVCUyy0dArvQRL2PEvu9Q/Zsc1YCF+AuEgvY=;
 b=b/Cbfq5jpGkfvbeHzAH7qSL8swo27kW3DmMQrMhJU6jAZC0onTCLm9IddEBiRm0EdlAGtKjKMDeEZZhZVZWb+bYVI3FRJrf8Ei+BXLM1C1mj+5ko8uK6q15jxI8yhVyjPHR9YL4oQ2WX+oIt+fxqGPsjyDF4BSXPbv8llRhhV6tHh9hHFgoE2jZc2QsBrkbXO+DFGoM7NC7FqneNTK+vfrd4ks1bl63WLKK4Cr1DTt107yX2hFn64dnQfNt/njXcNy6dM1jRen2FQ8vRkMjL2Dh6CLcY2sVAJMEweFOaHeJMeH8jj1Czgx60pzw7NIUZImyv1IcHLpnJnIIXMO2sZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAoCEl+UVCUyy0dArvQRL2PEvu9Q/Zsc1YCF+AuEgvY=;
 b=Q8mf9g4nCkflBky/Tcw+Fj3aMFaifLxwMQhT6WwR0LX2htlNgq2MkOTdSk6xvwlG26BUCTmZ3LhLX2rOuaoond5tMbRqkJrv/aHOLRiCZVt5PvScnDpfZP6GcDdIybKsreTwdVWH/n3QXG1QLe3eKQ2scEtnrSdYO4KNKXfkF84=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR04MB7006.eurprd04.prod.outlook.com
 (2603:10a6:803:137::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 09:17:07 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::b0d0:3a81:c999:e88]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::b0d0:3a81:c999:e88%3]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 09:17:07 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Ioana Ciornei <ciorneiioana@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] bus: fsl-mc: Fix test for end of loop
Thread-Topic: [PATCH 1/3] bus: fsl-mc: Fix test for end of loop
Thread-Index: AQHW/j0+uozycm85P06YEWbvXtn5UqpOnDUAgADv/AA=
Date:   Tue, 9 Feb 2021 09:17:07 +0000
Message-ID: <20210209091706.ug7cjdn5rripnqv7@skbuf>
References: <20210208170949.3070898-1-ciorneiioana@gmail.com>
 <20210208170949.3070898-2-ciorneiioana@gmail.com>
 <20210208185810.GM20820@kadam>
In-Reply-To: <20210208185810.GM20820@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [5.12.227.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 561f0317-41d9-4c38-a0d6-08d8ccdb7936
x-ms-traffictypediagnostic: VI1PR04MB7006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB7006CB69C7352848B255CE46E08E9@VI1PR04MB7006.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z5rWxq5j+yT+FOVqnp3MvTyxcMQajasylLHIg9a8SEKiKpKlBCBNiRlIiIeBVAL+9Kk5QnjfYynEIEtO9aUXCW/5Xsa6D1QWb9z+tDH89cMRQYHrbcSorEWT+rNWTT41GbYlCsPz8soG3xWTP+9ZGq1oh28JYCJqoSs+OfTBbgbrNPd2r7Ue/rXhSDr/T/y/pvZEcMmb70sl8aG3NZaPlFg8+4onh8NvD6FjztZmrRaoYyTXvn01qqFbfc8pNEggp2wVIXyx0vgz16d76R0JTM37UKLARKGmaCBWDYSiUa9P8l/LIa+lp6NVXPgKcoz+LSL9MURuWsRk71AAr8/7VbCreLuWa44Ta0PXTB5PTUoZPTTdITaCCo3nY4JDfPjyvkeJux3zfsF+ZdmcogWt6+IRxiMxXmgI407rd8OLRWng2yESeNWJUzgP9xU7jH7PXccg8l/1r1OCgSfAUbS6Lk9xOwhdytp7Pzu9o6bE+SL3ihHZMIlgkwJ8M2BzL/2nPm/33QMt1l/PcvkygddVYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(396003)(376002)(136003)(346002)(39860400002)(5660300002)(1076003)(478600001)(4326008)(54906003)(26005)(71200400001)(186003)(33716001)(44832011)(8936002)(4744005)(8676002)(9686003)(86362001)(83380400001)(66946007)(64756008)(66446008)(6506007)(316002)(76116006)(6916009)(2906002)(6486002)(6512007)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BqluJD2q4ZOLVm0UtBKvPlVIMyNnqBTZzHAycrHz7uOFgLi/EYurDpqz8hZ0?=
 =?us-ascii?Q?cr6Tg3NUUAMqEdmMgTM1jMoipFX3b5zo/Ql1PeuNd8GTppvQ/jRnXvIzdz+k?=
 =?us-ascii?Q?d2sOq8TXi6A6+0Qy1WB1Ur6InkhZ/fIa8/3XUdtWKngS448TUnUaT6HZomri?=
 =?us-ascii?Q?0gXypGPfraEosuXE8HBAejyKyUZxOwG6Af10kRoH8e3J8x7DZ6YocWj9PO30?=
 =?us-ascii?Q?0qAmC9FUb3Ns19J18Tfa2w0ygPjBSC0m7e93Zj2MmtSZgz0MVP6SAygiol9m?=
 =?us-ascii?Q?CyBfGN4gCMdHYBEWTs2BkOjJHWTy9uIkQZ/pmeQRT+1OiW3sAeqrTh70/LcY?=
 =?us-ascii?Q?fkVh4DA6r8ZsQGflUxjNnHUFiuau65nTkX6Zs69yIjLp2FOtDA9JYbCSyd6a?=
 =?us-ascii?Q?6vtlQWf7oqykac6l4Fd7X/WDz0bzss1fi6ActkekqCY9PGgLIWSV5nTHDWgO?=
 =?us-ascii?Q?gs3bvllK+Xxc129sRsi2CWVsD1wS/MF+77P9/40Do6GFB1l4DPRzaYIvEXy9?=
 =?us-ascii?Q?aLPwqOcSzVop/GHXvRXwdSL3vlpq+wsSXk4UD1aDK2O8tZI+25N2FQaYqpwZ?=
 =?us-ascii?Q?P5tnIzwJcZ70+9tz0bWPqW2LZ6sBc/H0Fv32zESpvODwomNZrtS2RNoHPHgz?=
 =?us-ascii?Q?iFlu3KkORlTkyoyjxJbYSjujIka0vysy42p8UH750CgZRckp++4F1Cbk7jTj?=
 =?us-ascii?Q?9eGhV8iI2RhdXDzTjzSBEnYFjKp7X+KKCbByoIs5cOCHPmSwqMkw2JjiC+sb?=
 =?us-ascii?Q?zSlpueK7XukFgAzA7vzXNnrR8FWP38z/jkQUvooT47cQTX+oYJrGe/cE4F/q?=
 =?us-ascii?Q?G3prK53+zetl5UXXy8n/MNZmmnKabanitU5CBnTAvMU5NL63nF9dBnqfZHaj?=
 =?us-ascii?Q?hdVdbu1F6J63fInMrJNtuB/FUz500Hhx2GBYrvdDsRHKrPxJ2LyEyil0WT5M?=
 =?us-ascii?Q?s4F6IxWQkcX0YYJ87KBAbFlFUxvGtbJ1315jyXY4kETteYqKcsU575jsYKGc?=
 =?us-ascii?Q?/cq7y/kGlgpc76h4IiRgoA9vrepqrMzwicE37vsBSy5LW3cIOa6q/Zxtywbv?=
 =?us-ascii?Q?emQIsSwFNdmbjQtS9hkIJTheFZalAaa6xVs2wLO4L7fd9xWCOjL5OqJ1do8p?=
 =?us-ascii?Q?QtB848irTMQStfhPeKsEcpeDb2lRaYInwILm3UMMnwUqHGGJjJdDnIfvVbRt?=
 =?us-ascii?Q?HWItM8MlTRW4/H6WwjmYjadF4hTz7pmTZeeRaOFrYgwf/8PqMKtvx0oap6KF?=
 =?us-ascii?Q?CO//nCEa3b1SXHT5SVK5GDMHYun84jr6J+9IllVKh2orf4N+mtZ6tv7qSU4u?=
 =?us-ascii?Q?bzoNxp2XWGcuRbssSNosOMY7?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73DEFE167F648A4FBF5D54F3DEE56F9A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561f0317-41d9-4c38-a0d6-08d8ccdb7936
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 09:17:07.5043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upYsM8IJsC/DRy280II/TElJ5tTPWY7G8g9bWzfJtIgFUlq5Oqm0DU5CGsKO30sbsoIbmRkpbRNARy3T90st2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 09:58:10PM +0300, Dan Carpenter wrote:
> On Mon, Feb 08, 2021 at 07:09:47PM +0200, Ioana Ciornei wrote:
> > From: Dan Carpenter <dan.carpenter@oracle.com>
> >=20
> > The "desc" pointer can't possibly be NULL here.  If we can't find the
> > correct "desc" then tt points to the last element of the
> > fsl_mc_accepted_cmds[] array.  Fix this by testing if
> > "i =3D=3D FSL_MC_NUM_ACCEPTED_CMDS" instead.
> >=20
> > Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> Generally the tags are expected to go in chronological order:
>=20
> Fixes: commit
> Signed-off-by: Author
> Acked-by: Whoever
> Signed-off-by: Maintainer
>=20

Thanks! I didn't know that.

Ioana=
