Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D49138CE1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhEUT0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:26:48 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:15521
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232789AbhEUT0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBTU3UvYBCJBmhqzVUegonz6xx7hA9YR/OavKBGuTSDBO5KZngEb6yd60hW8wy4EPjA9z6D4FURuFQAGRM2QDFPnbMYRFAVuE4Fl3l8rTuokGi6nLPgyIaATKaeZaWewFWJtCAh9S0h7Pr3KEKtS5mRmAIRi9BTeX4r/xNO+Lq66XcTpcipCQNu9aQU/HLhBNrFcv6Y6+OpEo3vxfiU1R4i105y2JnY//hjb1/pg1s3ZES6+ZPyViaX57hPxNh3bhZMMxEo185k6hCev6P0wU7a6Od+gy35T0y302jeHDr3eP7umOww6vWViQxOBm2DMz/vpda8Z4XIfVyvRi9kdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92baPCqTjYvLA3htatA4n4Y06uxbY8PeS0B3ZjCbfHo=;
 b=hgDDR/rP/m3SeY8nV5TF6Dj2jrT3Tne35gWe9FtbtUfJhxLRehUMvZtehRYGutZUsxh4xRddLv8VZnUVdu4IIKNRll3gmUp7o6iz2lbiISXJyCB9DWyUhuBCcWVu1ckSfFBhyuWnK0kS9erZfYE9MfzvqJXT+sahqIjyRmmUZXVRQNMYQrw1kXQKFv1/8JUo1nwCMWmmAUV3XP6FRjzHEqoIEemDQm+EHHF41pQYcVGZzfrTQnt+CBzLXMgro1t4oJQ5xt17euQHvvoWmBwc9vDw4Fhr9sNW92aJGOZM9UPpQBEeiC0jkxmfLMhlFV7f3hjxn4CFaV8AuyEhXzNCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92baPCqTjYvLA3htatA4n4Y06uxbY8PeS0B3ZjCbfHo=;
 b=lBFXIZJU4aXo2+S3GPT5nM4cTdhTi/qeSsFG2GV2kmWXRdwu3s1FO+O7xI1mR6Tut5xUJoJa8gpqnhVM5rHzWxgAzKRqbA8MIrRjA33zSRO/snEHiJGH/wMicJszabbvoBN1w9l62cDNFPSXqDlz0PAJkq8uDk7Qo+VV6dw95GE=
Received: from MW4PR02MB7345.namprd02.prod.outlook.com (2603:10b6:303:7c::10)
 by MWHPR02MB2589.namprd02.prod.outlook.com (2603:10b6:300:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 21 May
 2021 19:25:18 +0000
Received: from MW4PR02MB7345.namprd02.prod.outlook.com
 ([fe80::3d87:628e:2e18:9700]) by MW4PR02MB7345.namprd02.prod.outlook.com
 ([fe80::3d87:628e:2e18:9700%7]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 19:25:18 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Derek Kiernan <dkiernan@xilinx.com>, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] misc: xilinx-sdfec: Check if file->private_data is
 NULL
Thread-Topic: [RFC PATCH] misc: xilinx-sdfec: Check if file->private_data is
 NULL
Thread-Index: AQHXTZnXa1ftxxWsvEKKXRgpZmUPKqruRjAAgAAMjIA=
Date:   Fri, 21 May 2021 19:25:18 +0000
Message-ID: <MW4PR02MB7345C8B19C53AC9054C988DCCB299@MW4PR02MB7345.namprd02.prod.outlook.com>
References: <20210520170150.1615956-1-linux@roeck-us.net>
 <YKf+fJBXXyvIFrZF@kroah.com>
In-Reply-To: <YKf+fJBXXyvIFrZF@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d0d8c84-970f-4f2f-8ff3-08d91c8e2b66
x-ms-traffictypediagnostic: MWHPR02MB2589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB25896A62A5EAA06DC0BB014CCB299@MWHPR02MB2589.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GF+qHeena3CQttKpPcBTzSaz5T/4OBDN3396Kow1q+G1dpWNj1oblFsgx/xEu8ynJIVhF1DD+jlS23uym6JpGx5ep+x5N79L+UwHw40YmA5CcIeIptE+V//plauiKSgQnWW9IWtn1XF4JSaEjbdHFNpHHaPS/iRMusyQPsrW0rVs5r5X7MlQQ4GxojP5ZfFh3b8QdGnefNoKWxRIWF52X+byhCWRc7NiuImiYlJ2f2QA8PpuayDInRHt/SqSTUo5irT6/a8a93phpVAXOXYsvXn0hshDnusQcsmh3fFNs30R8oZ9QpO/LCNNSROyamPUumbEj46qHBxRlxBmYqCt/im27avi2e2+aGm89mHZxZ9bCMnIm3iJZjAi5sbEZTo+mMcXtSqBfOfmhawbfhgYUj0evzJjgUomjuQt/SxMbujkNdf7T/Fg+jwdvJniRgxaQecVdE7eFlOSIMbqycVIjHTp9ZBb07xNP+gAyeXC3ThMICSYFyctGR7HYHF0uJHcFIV0rqxu4S4QLAnVYIyUzz+tqshB6OtQ6PkfypeD6SG22mzeQI0w7JLUTG43pxcK9xKBZ058HXYYnYjnnUoFQ6ThqcMKk4oG7t3FhYmnqEA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR02MB7345.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(478600001)(86362001)(26005)(83380400001)(52536014)(2906002)(71200400001)(5660300002)(9686003)(55016002)(4326008)(54906003)(122000001)(7696005)(186003)(110136005)(316002)(38100700002)(53546011)(6506007)(66446008)(66556008)(66476007)(64756008)(76116006)(33656002)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AUi5Sds87b9MaCvozBxAtV5RMDDloiWwoxw07EYaYbLLHaq4lcqj8qijw9zI?=
 =?us-ascii?Q?cP8X3yNDIQwvaJIu3yRFLN1uqgU7Hh6cddNYlUqJCLMMnWHT+4WSdoBeR4M1?=
 =?us-ascii?Q?xGpE/giB8WOeco2BG8rsqsPAAxd13N0++4rwbSRKSWVKY6FuJ678pf8vT4pg?=
 =?us-ascii?Q?upIQzXSdpsJyQYCSrzqsbBMrr7CsL4ShPBaFbudyooBMDIH+rT3kjx7TThVi?=
 =?us-ascii?Q?kMMga+6AfsnMzovTEYTbA7N3sqhzVYampd5VqM1Gi5hPhADvadw28wRXZ4x0?=
 =?us-ascii?Q?yHZK5CMz+O9meovfNDWZu1n1b7Reqw6VoGMswgCixMZeZRqPS+CzA7t3H4iS?=
 =?us-ascii?Q?oq2E/A0BwneIiPQ16weoo7iAL6u7xZfa9BUIendjzn1DoNjcFW3JxSWjomKo?=
 =?us-ascii?Q?n26gLGn3kMZRpyE+YAjNzK2eGI5trSkNtTPzXS8DOPRD4Kd+8Gqew/Vy7Ui2?=
 =?us-ascii?Q?RKJlWP1dhpNHWMh6q4Q/Cwu4ebjwxktuXKfhoUXOl12ofH1fkledfnmjhxS8?=
 =?us-ascii?Q?bMkY50dUco8J8swXzWL4r8JId9qIx210cdHvCvgesIIOXG3saeoqk79bMcoo?=
 =?us-ascii?Q?1ai+mQWdVZRZNcQfUiuTHkjH9KKVlOrmnP5Un+Hf9lqZut94mJ4UOLVqG4oq?=
 =?us-ascii?Q?IDYsDh5o/C4CyE8OXKufIDp8KDTtigBRQJwIe3JFqwCLGrpRM4dxfY2uT3P6?=
 =?us-ascii?Q?F7AqozaF6Nl8zaX3+Hz41xQh8Vo+zyFTz7t0WVqd34a5dzumseojMJn3rUfa?=
 =?us-ascii?Q?1sFEOSZ2mgUa0aN+l5G0gOn9cQxNzp6onX1YH1YiBDKh5u5hGeoJPQui9Xw/?=
 =?us-ascii?Q?X7R/Q5HuJQqrFoc2twieNUe511dRDMrIEUfVeQQctLU1oHjHUwBGSCE2+qHa?=
 =?us-ascii?Q?EPV6TkPzc9aqhUJ6Kjiayp/vrfaMd1MQGn26puCm5mNK6OPozTNeyiNNAUE9?=
 =?us-ascii?Q?zaqvpj9/uStrbvw2CI6NJKxwxhFBV8fwdoAu0XeyLGLtxrCxetsSGq0A+uLM?=
 =?us-ascii?Q?MzUnPx/2mf3Ui0GCUhlqTNlkryOYA7py396woT/rHTYFVk4Uww22OGq7ZErz?=
 =?us-ascii?Q?HCxPqElxnPTUMkIFUCfDQylOFd8PHtti9lk/xd+HQbx0LCnfZ8KqDnGQTsI5?=
 =?us-ascii?Q?7O2tJT/AxsEEw+fnmj7F7j5vTxgSIux/7SXzVnOKIXRoBGowKt8Zt4Gb3OEC?=
 =?us-ascii?Q?5+28/jxVunVUIBeOYneQgikwpvTGT5w0kBD0Bhurkhhc1+vT8zE/KBpXUDXz?=
 =?us-ascii?Q?1sm/NhU284AxDolKZb9xjPDSE8PPItnIpm6bsKHMqi24jauTrxfKLHLkZlu/?=
 =?us-ascii?Q?lazFT9Mjw/38LKcqFeWZZOGf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7345.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0d8c84-970f-4f2f-8ff3-08d91c8e2b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 19:25:18.8263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVNtreQwjJe2Qw8UdW6a5nKOwZRCtGquv4hIVE2fiANuArPmOZjyGpod28+JzqoT84Wa1NxMS7Zj3ZeQYL19Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2589
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday 21 May 2021 19:40
> To: Guenter Roeck <linux@roeck-us.net>
> Cc: Derek Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.co=
m>; Arnd Bergmann <arnd@arndb.de>; Michal Simek
> <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-kernel@=
vger.kernel.org
> Subject: Re: [RFC PATCH] misc: xilinx-sdfec: Check if file->private_data =
is NULL
>=20
> On Thu, May 20, 2021 at 10:01:50AM -0700, Guenter Roeck wrote:
> > container_of() only returns NULL if the passed pointer is NULL _and_
> > the embedded element is the first element of the structure. Even if tha=
t
> > is the case, testing against it is misleading and possibly dangerous
> > because the position of the embedded element may change. Explicitly
> > check if the parameter is NULL and bail out if so instead of checking
> > the result of container_of().
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > RFC:
> >
> > The NULL check in the poll function is likely unnecessary. Interestingl=
y,
> > there is no NULL check in the ioctl function, even though there is a
> > similar container_of() in that function. However, I do not feel
> > comfortable enough to change the functionality of this code and drop
> > the check entirely.
> >
> >  drivers/misc/xilinx_sdfec.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> > index 23c8448a9c3b..0a3721d31dea 100644
> > --- a/drivers/misc/xilinx_sdfec.c
> > +++ b/drivers/misc/xilinx_sdfec.c
> > @@ -1011,11 +1011,11 @@ static __poll_t xsdfec_poll(struct file *file, =
poll_table *wait)
> >  	__poll_t mask =3D 0;
> >  	struct xsdfec_dev *xsdfec;
> >
> > -	xsdfec =3D container_of(file->private_data, struct xsdfec_dev, miscde=
v);
> > -
> > -	if (!xsdfec)
> > +	if (!file->private_data)
> >  		return EPOLLNVAL | EPOLLHUP;
> >
> > +	xsdfec =3D container_of(file->private_data, struct xsdfec_dev, miscde=
v);
> > +
> >  	poll_wait(file, &xsdfec->waitq, wait);
> >
> >  	/* XSDFEC ISR detected an error */
> > --
> > 2.25.1
> >
>=20
>=20
> It should be safe not to check this for NULL as the misc device sets the
> pointer in the open, and removes it in release.  poll or ioctl can not
> be called if release has already happened.
>=20
> So feel free to drop the check here, xsdfec_dev_ioctl() looks correct.
>=20
> thanks,
>=20
> greg k-h

Acked-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
