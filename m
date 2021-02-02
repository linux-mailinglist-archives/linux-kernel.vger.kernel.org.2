Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DAF30BE5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhBBMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:38:03 -0500
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:27778
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231357AbhBBMhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:37:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOoHlvNQKEoCwbOfRitBDcJhYLxW7QDQIEc5a9W5Tv7inCIn+3BWeEozmczkoGIYg69BN3+K+Tz0k6eeMxp4ir4PNap0S+Bcsvlq1NvbocYagWuQuQjMZHUn5Kw/ebgDCL+YrQR+ecYCzt3k0nduXEAFOA+hZt0cIxl2r4KEohEuAKndNpILDN83lNz4NFfUDnUN1U3foRiiMzhcjPfoJJCyQE4HmfncnsDI2DCNd/TCQf36XfNdLc8Vn8Ifri9TWWKlHuO3bWemOV8bspqQhOFHg/ucs7p1CWebaMwcJLSE5JACyhyhaUVgXp/847BN3othG1ahtmsIbsnBQZlWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihFCz9VeodHGtXMhMG0YOEBcGn+3z8m52YPNS6L/pn8=;
 b=AiuIGTguSDlrVhnYiQTcFZUEU4vP12H9c1UfK64n4P6Eiq79rGL1E4ciTxL7dBW9PVgUEQrYqWW4pdEqQF6C+JVlw/eL2hPkVXu2VgWzJ3fWUXQAvL4jQ0GrOISBWJ+DRXULdThbuKcq9mk72KXxE4LpTLBuO6Bw5HfLU0qA/TE3yND+E1ZjPSqajNVZQpUXtEBss/lfP1EAkSzUnHpsieeqwrxpFgjwNkNlllEPrVswYLiQp4ijd1IzVE0yU9OaclE180NcdBgt6nGRh65ZsgSnoflUQU5h8YmL92xwEIH6igt677Rr2m+wP2fxnL5FJP2v8EWtWPMXOjlzUqUzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihFCz9VeodHGtXMhMG0YOEBcGn+3z8m52YPNS6L/pn8=;
 b=ambTdKyusJV+7aPG0aZybUfF94Vyi4lfLQbKB9ZLq75easD1PdrGqRKuk2R2xm6ynexgNYnzwo80Y/zXDtN2H6mDgJy54sbXm51vCWoyyqqzwO+2CIypfUjtIfl3S+y4Pg9yI0qLXVw7EYaHJJe9xdcbYO+RAsxhi3aVaNNa5D8=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 12:36:56 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::b0d0:3a81:c999:e88]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::b0d0:3a81:c999:e88%3]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 12:36:56 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] bus: fsl-mc: Fix test for end of loop
Thread-Topic: [PATCH] bus: fsl-mc: Fix test for end of loop
Thread-Index: AQHW+JXWIedFA+IGmEmzK+UDvJ/0YKpEzwAA
Date:   Tue, 2 Feb 2021 12:36:55 +0000
Message-ID: <20210202123654.yf5qx3k6lfkiiqru@skbuf>
References: <YBf0Br9obNGZTcNI@mwanda>
In-Reply-To: <YBf0Br9obNGZTcNI@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [5.12.227.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5eb664c-26cd-4763-585d-08d8c77739fc
x-ms-traffictypediagnostic: VI1PR04MB7102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB7102BE00BBD6BFF3E5306760E0B59@VI1PR04MB7102.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iLzQKtfM5y/kW5Fds53+9eRMul/galDMfJeWfCDQA29T+3nOrSo0KZdap1sCgpnyVkdqpj6zTTBPrE2vBPt31E7VH1jk8A7N1jsUOf4/EYWy7lv1/Aokqc0liYfJuO1CZgqZUSnrs3GDlt98wnKWGuOAr9pP46Y3XedCLyIDNY7gGvxPK63GOZa1mnTpEq+5UdmWdSocqKeiMPcGWnevvZlKL0qNBvQSNhFAgJBAm4+mbTxhj7c18qFwcwQkMvXshMlNbeBZR6zL+v8tMx67u9ta6AM4ovmH37LgZSBVrL7fz3A5NH0KC628ry5pYqb2jF03OwBXXVBFUplVPhpjh5n+mxrlpns91gVVmBVA7vMqEXk/6qE4urxkTSxTyMdHOQmGQv3pA1KvvqVLf5mxn0HlLLWd4l0X1ukthAFeXZSj/rc8PuZVQGpOd/qvyw6WTC1qUnb7HKLDZqAErApuRXXmkK9UzE3dW4X6Wt1o8EPLQxzKZo2qdYqOttO5vT0LyOy2zoXR51BMFJtNbguAJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(366004)(346002)(39860400002)(376002)(136003)(66446008)(66556008)(8676002)(64756008)(76116006)(91956017)(71200400001)(2906002)(66946007)(1076003)(83380400001)(86362001)(66476007)(8936002)(6512007)(4326008)(44832011)(6506007)(316002)(9686003)(26005)(54906003)(478600001)(33716001)(6486002)(5660300002)(6916009)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ET/jp/xh/pIxCAnmnZFlueGYPdtrVCmF8j/xlQbNRbU+CauFyVK00yYTkosG?=
 =?us-ascii?Q?vAeSIuS+U6KmDlsO3H+zpuJ1yFkeOCo2ITD1xTjjMQdTvB90wWQMimF5H98l?=
 =?us-ascii?Q?4RuZBjjaponK1FG4KLaiAbK4LkmfvQaJGcXVCaav4Mln88Nxy9jwM4+doBBg?=
 =?us-ascii?Q?t0MMC9L30pxwIbOv/LvgrMp8JqtkAziPkyt4L0EAuIIyqcH+20kXnI8/PSTa?=
 =?us-ascii?Q?9P2xJbVzqyBK/MKTPMXmFQCWR/KU8bjID2H2oeZZJmcGPv0bzcOliXgIcIWz?=
 =?us-ascii?Q?/QoRt/Ds1uWYDRysYaPa+7hleL50Aa8qf2JxuLYMCqQyrBj5tr60Rb1Js5au?=
 =?us-ascii?Q?GAzj5J6WB4eclnhXxPpEhVUSZ69e6ElrZ9EPzXwcsVp4QPa4M6CVxpBblRSP?=
 =?us-ascii?Q?LLjXW9cN6H6MOwHhZ4EL6iAF7PoXVlrCtPgzzfUUReC2Hv+yMi9ZaeUf5nzS?=
 =?us-ascii?Q?ROXIUF+2UebwoluxLcB5FqtFEgqQ5iCfCIkBhkkHkNUgp9B+V+FnWFUSid/A?=
 =?us-ascii?Q?vPHxk/pLlc1zlPU2w5fKJkUED5FdWgp+2G9ve2yR4/oldwxeqeFqxC6VFkHQ?=
 =?us-ascii?Q?Ry97q9TNdnECJqiMlRpDpX4PQJa8FI8vgK2i5SMelCnsjKwYapWf9OIlsMGS?=
 =?us-ascii?Q?3NNVAFOmq19CJK/ZbpuMuq4LLPEhDQIzdP5eIfiLJdXoSsJaY+FV1VID+STj?=
 =?us-ascii?Q?MCzi5JkvpRFldCF77dbFPEVlJcb5ApkhaMIIH7/uS41BD4szjTKxI4El70LL?=
 =?us-ascii?Q?QGVhdxlx2x5iJs5LJ2HfOifQ4uat2fJtv5N/N3gvqeDHKCn0UwXeTGf2D2TK?=
 =?us-ascii?Q?5lNqe0yBnfh39oafj24Pa9PTH7vD7lG/TiBn+BNr4FJDWutLdnyxz5ZrQRgY?=
 =?us-ascii?Q?IH0Q+7M0AUJGu5zPi5bhYaDM9cnLSXwqdt0ffF6bDVRO1c14HMoMo4DZ+vV5?=
 =?us-ascii?Q?ns7nv4k2S6O0SC8Dm/X1/1H72MXkp0X3aLuq+Uh8gKQuboCBfbPZtntlDCVd?=
 =?us-ascii?Q?+Qbqu8PX/j4B5vkCs3c+j1ksZaYCH0+GAISOySw8r+vrSX/wqtzvBg5N92jv?=
 =?us-ascii?Q?QiH9UDWk?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D310A26D79EDC14382D656B707FA33B6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5eb664c-26cd-4763-585d-08d8c77739fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 12:36:55.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xqiFdwC2EzUPFckn9AOci4Qk5X0nl2TTsELUq71F+32cK7U5Z4Pf3PV2t9TMYlfJWPqvkBdPs/rryjyOdj18A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 03:28:54PM +0300, Dan Carpenter wrote:
> The "desc" pointer can't possibly be NULL here.  If we can't find the
> correct "desc" then tt points to the last element of the
> fsl_mc_accepted_cmds[] array.  Fix this by testing if
> "i =3D=3D FSL_MC_NUM_ACCEPTED_CMDS" instead.
>=20
> Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks!

> ---
>  drivers/bus/fsl-mc/fsl-mc-uapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc=
-uapi.c
> index eeb988c9f4bb..bdcd9d983a78 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-uapi.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
> @@ -338,7 +338,7 @@ static int fsl_mc_command_check(struct fsl_mc_device =
*mc_dev,
>  		if ((cmdid & desc->cmdid_mask) =3D=3D desc->cmdid_value)
>  			break;
>  	}
> -	if (!desc) {
> +	if (i =3D=3D FSL_MC_NUM_ACCEPTED_CMDS) {
>  		dev_err(&mc_dev->dev, "MC command 0x%04x: cmdid not accepted\n", cmdid=
);
>  		return -EACCES;
>  	}
> --=20
> 2.29.2
> =
