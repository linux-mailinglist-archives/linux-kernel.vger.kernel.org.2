Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEA43CB09B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhGPCBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:01:44 -0400
Received: from mail-db8eur05on2080.outbound.protection.outlook.com ([40.107.20.80]:59425
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230297AbhGPCBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:01:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdia+yKUcXd/oajgswK2lMHUpa/CHnyTKfu/jUFh3GZcjpqOCp8T4Zmn63MuD15rVAJ8+3cI8bUVn75DYZ83t/+/g2/ZXw3lObFPdpFtuWjQzSM9AEEv3oFtngzxrW84MvHYgutzkFw+Q+U6Jxfnnm2PKg5u3yW0cjJt+SmHs1hyJFaUIMkzqqExuIFDpC4yRSPCZBq09ND6U74eskpsKnuENhb4++ix5KUXMjbWFeW0IyqiV9qrLnpyytzZWgwczyMAjalN6IEuL9ihv6j2wY0KggJagsjgFUhWC2WOme/h0NL5kBWips7LCYahBKKcsfhEG4ewg3ltlq6gCIgb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2AdBgT9yvlgVz/CUFtDzQU0StoxoIxWPcfpKDPpRx0=;
 b=gQbYkU6MhqtcdHGlpGSWOjDPqkOOLv4gZOQ5v+0kZak9StZzdfPzz74/MC9WgKGCpFdlVvt3IdqLmverclQS2M33v1trCRUtvB9sluVL16ICZ9olS5xS7OxRNgATN8DfwII5+wkNFS6MycqzJvAuBwdlU/g1u3bc/oj6w4ERNsqyWhDhkblBqx6XXBfXnWKe1xT9+wCm3Ibz01B1wIaqNzefgDMceXMcPr35exWg7fFAfbjG0URQ6xL4bjqotqNkUanB5bkt6fsnca6It9im0vH92Zl7Fwtij98KV2wayWn+EE1B3CBr+PmCiTDfXjAzyTP7hyZIGIqLs+hcSzu2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2AdBgT9yvlgVz/CUFtDzQU0StoxoIxWPcfpKDPpRx0=;
 b=YGcsy1HgxJ14M73+NijccWawjjLJSikx0igNULcX3nG3jXxCvemHAUqiiotnBfQaYhfRDo5q+2Em/J2uthiXKG3bOjtIjRNEzbyuhL8R0USlnNCH/9MXQXpsuafsmoR6yAfwoBprXT0wDbtyD6ENRJsZ/4UbDkAD09E9KnDZ8R4=
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM5PR04MB3025.eurprd04.prod.outlook.com (2603:10a6:206:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 01:58:42 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 01:58:42 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] i3c: master: svc: fix atomic issue
Thread-Topic: [PATCH 2/4] i3c: master: svc: fix atomic issue
Thread-Index: AQHXeVKjnIlTyM+S0UqId3ag2mAQjqtEpWuAgAAzisA=
Date:   Fri, 16 Jul 2021 01:58:42 +0000
Message-ID: <AM6PR04MB5623FF3C9F40A7BB07AA44A9F3119@AM6PR04MB5623.eurprd04.prod.outlook.com>
References: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
        <20210715082413.3042149-3-xiaoning.wang@nxp.com>
 <20210716005205.5e218d47@xps13>
In-Reply-To: <20210716005205.5e218d47@xps13>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bf26ee3-5a6d-4bb6-2ad0-08d947fd3cdc
x-ms-traffictypediagnostic: AM5PR04MB3025:
x-microsoft-antispam-prvs: <AM5PR04MB302522654F5BAF758821A8B0F3119@AM5PR04MB3025.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8HJiz4CsdLAsRXzVd81yrY1leVFK3A7G+g7qsR3qWxRLlsbtSNpmLeOUIz/qrZnTwwqBiybQ7WM4Tj/PuOHrXdGde4N+Z34sTTzE0eNUzqCx9v+L7RKULpUz7fvx4is+O7Al5oDGBga3rqodscPg2OhmXqnJCnEfpn4l5rOFxrToL5ao7Va2lEdoRtwgjqTP1JX8YtsLsXKJNFBzulME0OGSKeO5NUsX7Wb+N6krgfPidukb4G5j5NNXJEFCqTy0Qv9aoW53uYwuiHa5BI4krs8v3lvT+sDCCCPeUHizTvv2xkHquZnbFqj+RT4xe6BV3LHBaZV2NakxEPw9OlGVLcXa++QJ8XuIC1ZvwTY7IQNj8OeVlFWc1gOSPp4C022aJ9ILx3JFSKd69kzQYn/aBDvFPo76nf4YlA7ukFhadyOelPPRG97ddfz8M5K6tCbw044ix1ZaamN0Ix8ug9txtO09m90isBGTfCxHZ1pvlsTGnIFSWx5yWz/YXqMKlSL5XBpQbpUaTpF6pROWHwJvNIM1mhtgXK4pwms0XKA0Al3P8qUpfLLujNokkBctRhPEJNWoxjmbRjZCNUg14aO3plapvo1wB3LT7WsP0+Zx9OzZT8Cj0cHUTkPYb6pQ2diTzdgHJFUPHW54h7Ay5O40SIe/bvhEGK0vtU+GUa+YCyAARrommvRLwIW1Uqi4RCW6ojH/r7H9T5xvBMSPUk1Ipg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(136003)(346002)(376002)(66616009)(52536014)(66946007)(83380400001)(99936003)(54906003)(64756008)(66446008)(66556008)(76116006)(66476007)(186003)(33656002)(8676002)(86362001)(6916009)(66574015)(4326008)(38100700002)(122000001)(5660300002)(7696005)(2906002)(55016002)(53546011)(9686003)(478600001)(71200400001)(26005)(316002)(8936002)(6506007)(84040400003)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3Y4cnUvbmNPNEM4N2lKNS9PRGcrMDlCZXlrZ21temJyNjNNTWZmWUhMOHd5?=
 =?utf-8?B?UkIzY3N5RFFYNStNekhuc3Fwc3MxMGZEdHRUaG9VWWozeXl4cFdVOVVkZy96?=
 =?utf-8?B?NExPMEhUMUUwcktnbTltaDd6bVBObXg3dW43YnZsbVpyNmxmRXdQR25KQ0xo?=
 =?utf-8?B?SHgwNVpqWW9HanF4d0pSbVBtTnovaDZLNjdQUEhlN3VYOFlkVVYzRTBublNK?=
 =?utf-8?B?SFpHaUlReGJQSFdNbmJmVUZleFRUb01wL1JaamZrY0s1MmpiRytGTitNNnhu?=
 =?utf-8?B?WHhKbHlvbmVJWVVCb0tuelZxS0NLcmhBQjhwL0JTWjNqRWFNK1BIemN2R2N3?=
 =?utf-8?B?QWFkUWc4V0h5UnFHQVhaYUEzTm45ZjNUTUFhQUo3dllvZXMwaFdzL096aElR?=
 =?utf-8?B?Uit6WGZrMkhtODZBMU5obWp3bWJTUFFyYlNEbWVCaGxNNFczL05kZCtrNDU1?=
 =?utf-8?B?ZHlaUGF1aEdzc29oMSs0N2tiaG1IbEh6c0FZZGNEZkJjTFovalg0NWE3WXZ1?=
 =?utf-8?B?bGZCVWlUWDRpZDNGbmZKZnR1cmhraWh4OU5zTXBNV2dkSWVWdStjY2RteTY3?=
 =?utf-8?B?dktQZVRJb3JOZS9uOHlGbXMzQVgyM2lubTZDM1ErR2JlZUV1V011UU9SazdF?=
 =?utf-8?B?TDJUd2FKaCtaN1NEanBMaWVITEY4a0NZWUNWSThENE51cWRjVzY5NzkydTFn?=
 =?utf-8?B?RklFTjhyRW1oNFRGSjllVXpvb1UyTktVanZUeFFRRlBqV09vRnpQQ2FHZ3Jt?=
 =?utf-8?B?NE9ZVVRxcnF1Zkk5OTUycDFobytpS0d2U2FZbXhiK2dDbkZ3Y3E2emVLVS8z?=
 =?utf-8?B?TUVjNHBxRHlyTlQvZCtHNTJNSWtTa3BXNVpIVi9kTEJoN3lTa1A2MDM0SU1Q?=
 =?utf-8?B?MWZBeWFoUmpsald4N3JEQjNzUVlXWTBrRE5zVlBDNWowM1JsN2d2QnI3d2RV?=
 =?utf-8?B?N2NvVnN5S3hkNVpqN3pTR1FlT0pyb09XY0hod29QRlhYZDBKcXMzQjJ0UFZR?=
 =?utf-8?B?U0s5Vy9ONW5qV3BYVkRIRzNjSEtOdXVXZ1IxOUpmUlEvM0J5NHlsSDNOYnMz?=
 =?utf-8?B?M1Y4RGE0dXA5bS9SSHV5UERHUTVzTjJYdkptaGVUWnN1bkNlSDdHMXpnaFZ3?=
 =?utf-8?B?QjVoVmlwMVRFUU1XOEtaYzBsK254Vmszb0hVTklNN2JXRDNneU54cklnRE92?=
 =?utf-8?B?czJnRllmMmNkMDN0d2VqbFp1UHhUdVZZZnY2VFRCb2lPVGJxYjU5ZDBkelJp?=
 =?utf-8?B?cktheEgzZ1NBUi82OTlJZU1VV1ZmZGhpenVSYkZkWEYvV2tOVXBvckJUSjcr?=
 =?utf-8?B?NDV3R1hReDNkSXN2cXFwOGNtcG5GYWVjN2xvTEhxb2JIZ1lXcCtuc3YvZEdI?=
 =?utf-8?B?MlA3YnpQMXdacHRjQSs1Q0lFTHRnMjQvbGZ6Mk5aS3Zjd1o5amNNNlBkRnA0?=
 =?utf-8?B?eUE5dm9mZjRzblhiL016Q1Z5V1pObEU1dE11NXJnb3lFSUVPRXlhL0NHZnFT?=
 =?utf-8?B?Zml2U3RyYWRwaGNFeXprVmROWml2QUd0OFFHd0xodDFUYjBqS3hzN1BVNkI4?=
 =?utf-8?B?ZXdyMGlLK3lKaGNCWXJVSkhneXBzamFMN2ZvTmtwY2NXZVZ5Rnl4RW1JbXVn?=
 =?utf-8?B?ZG51UFB0VUxjdGd4bXV6SWJoZnl4SXBnRkN1S1o0R1Rjc2FIazQwMXBQNGQr?=
 =?utf-8?B?cjExdlRPd0o2TzUyK2I1R3R6NDdKaE4xYkt5V3Z4Mmp0UHpqVHI4NHdaT0Rh?=
 =?utf-8?Q?M6CDse2nJd11r+uNsBJ3ofrm+vI6ThIHr5d42Y4?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_010F_01D77A29.26D43C10"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf26ee3-5a6d-4bb6-2ad0-08d947fd3cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 01:58:42.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcOkR3N1GFG8UbUBgAuyH5PfO1xp3ZDc6rVaQny4mxfqISmGYNsh5QMCZigq3Z4TMrH78BjaXFJzcmD6o+54TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_010F_01D77A29.26D43C10
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> Sent: Friday, July 16, 2021 6:52
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: conor.culhane@silvaco.com; alexandre.belloni@bootlin.com;
> vitor.soares@synopsys.com; boris.brezillon@bootlin.com; linux-
> i3c@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/4] i3c: master: svc: fix atomic issue
>=20
> Hi Clark,
>=20
> Clark Wang <xiaoning.wang@nxp.com> wrote on Thu, 15 Jul 2021 16:24:11
> +0800:
>=20
> > do_daa_locked() function is in a spin lock environment, use
> > readl_poll_timeout_atomic() to replace the origin
> > readl_poll_timeout().
> >
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > b/drivers/i3c/master/svc-i3c-master.c
> > index c25a372f6820..9d80435638ea 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -656,7 +656,7 @@ static int svc_i3c_master_readb(struct
> svc_i3c_master *master, u8 *dst,
> >  	u32 reg;
> >
> >  	for (i =3D 0; i < len; i++) {
> > -		ret =3D readl_poll_timeout(master->regs + SVC_I3C_MSTATUS,
> reg,
> > +		ret =3D readl_poll_timeout_atomic(master->regs +
> SVC_I3C_MSTATUS,
> > +reg,
> >  					 SVC_I3C_MSTATUS_RXPEND(reg), 0,
> 1000);
>=20
> You forgot to align the parameters of the function here and below.

Oh, sorry about this. I will send V2 to correct this.

By the way, can you help to check the question I mentioned in the cover =
letter?

Thank you very much!

Best Regards,
Clark Wang

>=20
> Otherwise,
>=20
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>=20
> >  		if (ret)
> >  			return ret;
> > @@ -687,7 +687,7 @@ static int svc_i3c_master_do_daa_locked(struct
> svc_i3c_master *master,
> >  		 * Either one slave will send its ID, or the assignment process
> >  		 * is done.
> >  		 */
> > -		ret =3D readl_poll_timeout(master->regs + SVC_I3C_MSTATUS,
> reg,
> > +		ret =3D readl_poll_timeout_atomic(master->regs +
> SVC_I3C_MSTATUS,
> > +reg,
> >  					 SVC_I3C_MSTATUS_RXPEND(reg) |
> >
> SVC_I3C_MSTATUS_MCTRLDONE(reg),
> >  					 1, 1000);
> > @@ -744,7 +744,7 @@ static int svc_i3c_master_do_daa_locked(struct
> svc_i3c_master *master,
> >  		}
> >
> >  		/* Wait for the slave to be ready to receive its address */
> > -		ret =3D readl_poll_timeout(master->regs + SVC_I3C_MSTATUS,
> reg,
> > +		ret =3D readl_poll_timeout_atomic(master->regs +
> SVC_I3C_MSTATUS,
> > +reg,
> >
> SVC_I3C_MSTATUS_MCTRLDONE(reg) &&
> >  					 SVC_I3C_MSTATUS_STATE_DAA(reg)
> &&
> >  					 SVC_I3C_MSTATUS_BETWEEN(reg),
>=20
>=20
>=20
>=20
> Thanks,
> Miqu=C3=A8l

------=_NextPart_000_010F_01D77A29.26D43C10
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNv
bT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0
aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Js
hi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsG
AQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2Ul
MjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29i
amVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cu
cGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDBHBgNVHREEQDA+oCUGCisG
AQQBgjcUAgOgFwwVeGlhb25pbmcud2FuZ0BueHAuY29tgRV4aWFvbmluZy53YW5nQG54cC5jb20w
DQYJKoZIhvcNAQELBQADggEBAK4JPoIkTbfuhwLtQ9Fm320K9JnOD+UvIk7UY5A58pq540ABcjCz
LggHvY+pE9m6IdsLfPL0lj4rrK660DRFM7k6XQEoJXjOBlZ+FGi7oTGL+VVi4+TYQzwPUMr8Ukg1
EBMzKb84Kh3oA96THluC3OFR3DbU/3NJsMYI6hIpvL4G+MQS0NZiEOf0CW73kreekaWUzCcnDbjr
9c8a1dI966lFSHr+2MAjj1iiNou1MXi3YA0jTy2qW78wdbtk/UbWkFIp11SyqA6Va6i96c7WgohG
zzxofRhw1yf5mb0SSjrbcFvLWRyx5iVZIhapdbztkYGYJiroxzI+ndpbztisjkYwggfxMIIG2aAD
AgECAhMtAABZfNGGA83aLDAMAAAAAFl8MA0GCSqGSIb3DQEBCwUAMIG2MRwwGgYDVQQDDBNOWFAg
RW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcM
CUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTET
MBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwwHhcN
MTkxMDI5MTM1MDU4WhcNMjExMDI4MTM1MDU4WjCBmjETMBEGCgmSJomT8ixkARkWA2NvbTETMBEG
CgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA3diaTEMMAoGA1UECxMDTlhQMQswCQYD
VQQLEwJDTjEWMBQGA1UECxMNTWFuYWdlZCBVc2VyczETMBEGA1UECxMKRGV2ZWxvcGVyczERMA8G
A1UEAxMIbnhmNDc3NDkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCZY70u6L2tkQw7
9PyXIwnCQZGWP+8gSezFvuegmg10bDVMZux1jQKY48+p9oQeUBOfM9652qP5o4VTqDCR4MBxbtB7
CXxyjzKOdVxraRqx+xibX12lcs4LmCtz3JeEduJkKJ7W+QJtTbqtF6okCUCQRT/vF/BqUyfNyVs6
Mexrp1Lj4Yv841rbsVKC6k3jdt1pqi/0YZscxs7rqP5VsvFcK1der8zrQ/98AbMMjoagsu+nq64x
xPly7BcBfjUMTlw2PsL5viDocyLeVtW22VInObVN2bvFKdtkQEliZtoBKVwevOx1UMYis/yAbqhE
x+7g2Z/59jqDaZSy7SOxigvhAgMBAAGjggQQMIIEDDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3
FQiFgsB+gY70VYbthTiC65lLmpJWP4Xmim6EteF+AgFkAgE6MBMGA1UdJQQMMAoGCCsGAQUFBwME
MA4GA1UdDwEB/wQEAwIFIDAMBgNVHRMBAf8EAjAAMBsGCSsGAQQBgjcVCgQOMAwwCgYIKwYBBQUH
AwQwgZQGCSqGSIb3DQEJDwSBhjCBgzALBglghkgBZQMEASowCwYJYIZIAWUDBAEtMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEARkwCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBTAKBggqhkiG9w0DBzAH
BgUrDgMCBzAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgIAMB0GA1UdDgQWBBSZJY1p6Y56
X4YAWIozHW4aGPBzZDAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDBHBgNVHREEQDA+oCUGCisGAQQBgjcUAgOgFwwVeGlh
b25pbmcud2FuZ0BueHAuY29tgRV4aWFvbmluZy53YW5nQG54cC5jb20wDQYJKoZIhvcNAQELBQAD
ggEBAEH+a5BarGYCUuH4P4sFJkrA7Y1U1aWb2nxNOPDARJLTwdEyMP6pPY0Bm7AyypW60HlI3Z4I
eP6NiMibW55/xz5EEcHxOrbYFmPyLY9twXLluCHnpZYT3NrDCD9dbOhUeZbDB1FXG93zfMJ8zzL4
9njRn5J6mcLiHkUpVRacp9susO1zN3uzp8TXCHy/y483CE6g1qUijUyiTPlAT9gz7xvyxAhTmrhH
8Fue00PWfK0B7zzjd1b0Da2nWFZXk4IsYJeyt+RTWC07VscWFiJ3avbgN0kaCswkvB1f6DVOqDRx
r5hHoNADBEcsMNdQNRVu2ospazEVq8wtXPTB7Ihf564xggTDMIIEvwIBATCBzjCBtjEcMBoGA1UE
AwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIw
EAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZ
FgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYT
Ak5MAhMtAABZfUBCujlfjY1jAAAAAFl9MA0GCWCGSAFlAwQCAQUAoIICxTAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA3MTYwMTU4MzlaMC8GCSqGSIb3DQEJBDEi
BCBR43btEHjk7lBfLIfUqAt7PZ29x0t383P+kppsiJ4HNzCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDALBglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsGCWCGSAFl
AwQCAjAHBgUrDgMCGjCB3wYJKwYBBAGCNxAEMYHRMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJw
cmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRo
b3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmS
JomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AAFl80YYD
zdosMAwAAAAAWXwwgeEGCyqGSIb3DQEJEAILMYHRoIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJw
cmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRo
b3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmS
JomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AAFl80YYD
zdosMAwAAAAAWXwwDQYJKoZIhvcNAQEBBQAEggEAE0Nauzrg3J54Gu3Ns1hmvsuT7Mi3DwPQRb8v
J+cNfqEeheMXaLmEg3GMEhNDOh+hsPUwjhrMk64oqeKLpBSyFwB8UpNyDnPMIMhSA+pYnYTdE2Lr
b9dlCC3G9TbydwB/32TOf0sVXNaAbpgCSxkbdQQ0UUefaPa3rBuC3y7xnoXVfAvQ3Wiix4uUJ6l3
PZTKAuRbucKL2f0/a6Cb8k1/wxtHBhLTxSFvhzz+KNVgb3MkNIokevdz13CZOkInjZBDnuM5DD6w
VJ819Dj/tvLGNJEjZAIqC/+SKIzsW6GqpHhoB+VSBqn0jOZEqULf2Qnx898ASqbaO4fIqMkPHeKG
YgAAAAAAAA==

------=_NextPart_000_010F_01D77A29.26D43C10--
