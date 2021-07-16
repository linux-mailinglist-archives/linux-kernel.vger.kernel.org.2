Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCAE3CB3C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhGPIKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:10:33 -0400
Received: from mail-db8eur05on2053.outbound.protection.outlook.com ([40.107.20.53]:32737
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236794AbhGPIKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUj6V/UaFMYgriXXIHqjn2Kx0k8IslMM6qjPRHPRYu4IaviJgdROZ1hsHggmhDHln6x4UzAgkDN0XnZOnko2K/9lsjIUk0IkRSHA/5n/84JpvQJyyoQOgzw1LtIW3u7fKAqHNNw2piEv6hTt4Zy4uYxK/n9nh8uStOoPA0xYjGJJ0irQ8wXdLw1wpY9msqOyXLK80Dl47Srn6BJ+kVMi8niCk3vSLL51KNC/DdGdgAA/kWU3QOwGNGZ3NlZKpnh60LRVo0Kw9XEvLdDgl23+7n51D7kGs+PIT0Qz6GQZT6ZeGAOcbFeoIuSBljuFUPDRBSTnxIA7Ty/P2SzW3jQi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpqr5BWfMjqGHj6Qish6cXRQX6UbgsKk425CtMY+Fyg=;
 b=anLF2WghGIj0S9NtTnrbVLV+C8ndhvUdUj6lSie98KOxrvdBu7ABYYOSnKv3G2Rsb5INyT2Wk4f+XFxZbMXTQZTxSM+TLXyOQORuE7jxXruHSgTxD4mhTFejF7XEeCXazbeC3eGVBIjs+3it/5uS3fx7opasn21filUjMWVifmN8LvPVgKCiqsF4TZucXB2auDpUtDCXTQVD1nF0idGjFZWbV1YWKoLb7wE+SI4ySCP4vFxcQ15Hyitd2Cl5xpuZ/XX/HPzXcBRsC5dBo86qi+oXAvSYee27auEoFbY1lgCLWPw4uhS9ap9s3wQrrO0AmgsM+odLKYNtGiNml4nbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpqr5BWfMjqGHj6Qish6cXRQX6UbgsKk425CtMY+Fyg=;
 b=j1+NVOUvIO8fe3UpH+3pPLPqHqjVrL4J8//XWq/SCHxin4LT+jgt1Uqc96eprBJufHigMQPHyM07PBKEdCGImzsHguyVm3r8h3vSHp5lIriTyC9daelceNfseeZmjGGeh31rBshZzLRS6agWpKDzW35rG8QFG6EbnU1h2fYuB7U=
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB4360.eurprd04.prod.outlook.com (2603:10a6:209:50::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 08:07:34 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 08:07:34 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] i3c: master: svc: some bug fixes
Thread-Topic: [PATCH 0/4] i3c: master: svc: some bug fixes
Thread-Index: AQHXeVKeqRrtf5X91E+sYpO8u0I0jKtFPDQAgAADP3A=
Date:   Fri, 16 Jul 2021 08:07:34 +0000
Message-ID: <AM6PR04MB562352C18C8D800F78FEF75DF3119@AM6PR04MB5623.eurprd04.prod.outlook.com>
References: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
 <20210716095146.2182acb3@xps13>
In-Reply-To: <20210716095146.2182acb3@xps13>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fbef214-2ad0-4c34-ec2e-08d94830c49c
x-ms-traffictypediagnostic: AM6PR04MB4360:
x-microsoft-antispam-prvs: <AM6PR04MB4360B4E2E1B1846C74224FEAF3119@AM6PR04MB4360.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wuZhxCiSQBKjaLKzxaTIcMQEDhsGGJ9Qvgq2G35evuP3r/ox+Hz8vIr0xvsh/RJB6rb4/JlnLvUeMjeP/Dp7DPJR43QfLAwL91fDW9AroTW2ZO5GfCSlZTcb+LEaF7C2c23zLUu2f9BMk4fzHNI6ad4KMula/8cN8975XONXOP83EDQRv9brEepXbg474KBBMFdrHUNhpD8zoOTmeBkk/aZL7DAt2zadXxxtjqe53ycjilITbNESKHUH447TdzLd0umZcjVhIaYJYGh4Mf0P5rcuwoGCkZGYso7yIwg01uVd77jzJ6i2KhFTnCW1FZQYuNgc5WxhE4Wi4PHUSASqli2eT4NyEwGTfD+GKAda4NVd7Le5Z7XcvLricl+W/p+SOKTmghFfrZLv3LY084LFsyVb6OJObKYT9m2/FIvrrDD2Qm591NeaaPZTHg1wPlLAeL8FVQ9IQjB4/3I7dljzdK1MorgTroOzMnHRj1KkDFwfPUjaVx3YIbkn+W9Q1US/wik/KuAgCALWkfTh8ANtl/1QCe3vBUrolEKfQu9Wmbz8M4OfECQ+Cz/tM8qqcexaBWwHHyR6AxD5I7CUMLB3ZFhokMIkSI4E6VIxe/FHFV8TuAtUANxHhXbD0gbDviUcsPUoJay5ERO9VBdD/4u7GQMDufXCWgeANHsX9Rfwn/QqOLCHSZDcxglX9N2BA3eTuWZcNcj8WOo9c+ZvB/nhoofrG+D0cxcehMo0zcQXTI8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39850400004)(376002)(54906003)(7696005)(66574015)(478600001)(83380400001)(52536014)(6916009)(38100700002)(86362001)(71200400001)(9686003)(2906002)(66946007)(122000001)(316002)(66556008)(8676002)(53546011)(8936002)(5660300002)(99936003)(6506007)(55016002)(66476007)(4326008)(64756008)(66616009)(33656002)(26005)(66446008)(76116006)(186003)(21314003)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVprWHM4L2E1ZTlNYkRMUkNjTVdvaldsVzJmTWFHd3FZNUxGRGxFbkF2VmJt?=
 =?utf-8?B?WkxNUzNHbjdvUkdpdW5EOXlBS1paSDRyZlViM1NqNDB4bmZyeWtZYjk0MGJK?=
 =?utf-8?B?SkpZVUFpZzYzQnJzR2ludGVlYVhFUFFjcTZOSEw5UHVpNmUvRWtEYi9sVWlT?=
 =?utf-8?B?L2o3T09HeGtzT1AzZmpRNFZ0L3B2SEJuSDJ6T3FuSXJWU24ybmxrRTJGS0tt?=
 =?utf-8?B?L3lzeHUvL3VwVjZhd0tMaWtBQWRadzlOeFJaRkduaWtmWHM0cFJSbnRraThH?=
 =?utf-8?B?OWVCNDRrOHNYa3FYWXRNcnRMRlBnbmZsQitaVUx4RXR4NkU4QkpBMWVVVzdx?=
 =?utf-8?B?YUJ3cnFSZWdGK0RtTXNKZjZFYkYzdDJDdHB1NE1zRU42WlFKYzBHLzVTL2d1?=
 =?utf-8?B?cEc5VlRlOVdwN0ZwV3FKVnRLcnl5M2hvZ3hPa2RrTHdQN0kxVkV6bVJMOHAx?=
 =?utf-8?B?MythcTZMblIvQjRrMVJEWGZxVmtUUnQ0TVFDMHA0em0vcFJuZ2NGRGNlYi9a?=
 =?utf-8?B?QTNHT2NjSjlLMWtOY2hNelhKNC94R2JlSHJ1WEFrYStjNDdQVHcxWHhNVWli?=
 =?utf-8?B?ZTlmME9mNkpHRGlVQTFLVGJvQmg0NlZqNkp3ampNaFpCRU5IZWpTcTJCcDFS?=
 =?utf-8?B?bmRBL2pBbzYySGNnUzI4WUJ6VkhvNWFPa1o5cFo5MGpYT1I3V3lIVFVUSFJy?=
 =?utf-8?B?NVV3U2ZKYS85cDJkZytGb08wbzdSZ1BjM094SlRDaTV1N2pvaHU2QmgrNkxD?=
 =?utf-8?B?NHo3Z3FmbTUyY09FaUd5ZkQyQ0tDdDQ3MmVLVkhkUU5RUWNWbEV5R1VFYUlx?=
 =?utf-8?B?bnRLcGJQek4zTUI0UzVjdHV4NjlyYXU0dndWRnVOZDc2TWxOTVp6VTllamVv?=
 =?utf-8?B?bUltNG9sbUE1SVpJbExFUHhMeitWalZnZVFnazlEMGNpdjk5MGM4SzB0bTdB?=
 =?utf-8?B?bVBEbGkvWnY4R21VbDJVV2R1Z3JoNjlISGhsM0lWc0ZVNW5LVUJENzNtRDNI?=
 =?utf-8?B?eE9nQ29Mci95cllmUDZPYzBNaFNkUUcxZ2xmSGlvZXhJZlI4NmgySExoNTRt?=
 =?utf-8?B?YVFMQnlzSjBzeHB2YjI4L1RxaHFBWitSZmNCSXdYMGdFWVptQXBOelB0a0lx?=
 =?utf-8?B?bkRJL3MzWUhNSHhkMFNONG9JMElVemxNZk5GTUs4OHVLQWo5ODNVdHN1T1Iv?=
 =?utf-8?B?emNqREt1S2NSZVJNYTVxd1pxbzkweEhFWWlzcHdKWm9CRkhRaGp5dTF1RlZO?=
 =?utf-8?B?YlZPbEgvVGU5cUg1UDZwRjh3Z0Jzb3JhNnpOckVaTitYRUtRTGdrczJpbFVW?=
 =?utf-8?B?UjZjaXZRc2Z4UEdaWUJTaHFZVzlzQU01U0pNdGxnZUxVRGc1SjBnLzFHM0lB?=
 =?utf-8?B?eTF2OVc5d2pBdVVDbk14RnpGT2FWMEZ0STE2L1ZRUzlpdHFkRU9JTnJ4V09a?=
 =?utf-8?B?Ujk3aGZZTXhranJlc0g1UUNXVDFaQ0kvL3ozdXZEOGNoS3BWL2taZjMvK1Vx?=
 =?utf-8?B?SDRyUE83M0NiVzhvTDdGR0NMMkRBTUVQWkw3Y2wrUDhLdDUwLzY4Z202Wkc0?=
 =?utf-8?B?OURzdklVdWtLRWsvb2pjWFFCVUMrdy9wdzhUZG1PZVdETGF1S2FRdXArK3ls?=
 =?utf-8?B?b0djcWc0d2w3bVBUUmpzemxMcDQyeTUweHVsdTlSOWFwSWh5ZTZKMjhiV3Rh?=
 =?utf-8?B?cDhrK1FONjVJekJzRVc3REpEQ2JGeXBwOVVDRlpLekdzMjBVQnpLU1VESnN3?=
 =?utf-8?Q?E/xh8M5LyIsvx3ThAlTgmyCk8kA7A4W0iUtWdl8?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_0120_01D77A5C.AE176E30"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbef214-2ad0-4c34-ec2e-08d94830c49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 08:07:34.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5WkMGWLtGSqMdsVDzQ7zlGMcbF1oYqh0o0p9CjgOBsWbXS6uYTM1a4IxY5mMUsnNdnR4RkcU9MWwHRrAoHUFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4360
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0120_01D77A5C.AE176E30
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> Sent: Friday, July 16, 2021 15:52
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: conor.culhane@silvaco.com; alexandre.belloni@bootlin.com;
> vitor.soares@synopsys.com; boris.brezillon@bootlin.com; linux-
> i3c@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/4] i3c: master: svc: some bug fixes
>=20
> Hi Clark,
>=20
> Clark Wang <xiaoning.wang@nxp.com> wrote on Thu, 15 Jul 2021 16:24:09
> +0800:
>=20
> > Hi,
> >
> > I am using SVC I3C module recently. I fix some problems and also =
have a
> > question.
> >
> > My question is:
> > Can I3C bus support pure I2C mode in kernel?
> > Or in other words, in mixed mode, must there be at least one I3C =
device on
> > the I3C bus?
> >
> > The pure I3C mode works fine. But when only have one I2C device on =
the
> > I3C bus, the probe in function i3c_master_bus_init() will go error. =
Because
> > there is no one on I3C bus can ACK the I3C message with I3C message
> speed. Then
> > it will return error at function i3c_master_rstdaa_locked() because =
of no
> ACK
> > for 0x7e start byte.
> > When I use the following dtb configuration, the above problem =
occurs.
> > &i3c2 {
> > 	#address-cells =3D <3>;
> > 	#size-cells =3D <0>;
> > 	pinctrl-names =3D "default";
> > 	pinctrl-0 =3D <&pinctrl_i3c2>;
> > 	i2c-scl-hz =3D <400000>;
> > 	status =3D "okay";
> >
> > 	lsm6dso_i2c: imu@6a {
> > 		compatible =3D "st,lsm6dso";
> > 		reg =3D <0x6a 0x0 0x50>;
> > 	};
> > };
> >
> > But I saw a similar configuration example in
> >
> /home/nxf47749/work/kernel/i3c/Documentation/devicetree/bindings/i3c/
> snps,dw-i3c-master.txt.
> > I wonder if that can work normally?
> >
> > I know the definition in the specification is:
> > Mixed xxx Bus: I3C Bus topology with both I2C and I3C Devices =
present
> > on the I3C Bus...
> > But I think it is feasible to use pure I2C mode with I3C module.
> > I am not sure why the use of pure I2C mode is restricted in the =
software.
> >
> > If there are errors in my ideas, please correct me in time. Thank =
you all.
>=20
> As you pointed out, I am not aware of a specific I2C only bus setting
> but if you find a way to workaround the issue raised above by software
> in a rather clean way, then... why not?

Hi Miquel,

Ok. At present, I just commented part of the code for registering i3c =
for pure I2C mode testing. I will try to make a clean revision =
afterwards.
Thank you very much for your suggestion!

Best Regards,
Clark Wang

>=20
> > Here are the fixes.
> >
> > Clark Wang (4):
> >   i3c: master: svc: move module reset behind clk enable
> >   i3c: master: svc: fix atomic issue
> >   i3c: master: svc: add support for slave to stop returning data
> >   i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
> >
> >  drivers/i3c/master/svc-i3c-master.c | 45 =
+++++++++++++++++++----------
> >  1 file changed, 30 insertions(+), 15 deletions(-)
> >
>=20
> Thanks,
> Miqu=C3=A8l

------=_NextPart_000_0120_01D77A5C.AE176E30
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA3MTYwODA3MzBaMC8GCSqGSIb3DQEJBDEi
BCC4i123J3pfk5JVoQ/M6DW6ccEpJUWzR5z2xXcsSdRn/DCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
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
zdosMAwAAAAAWXwwDQYJKoZIhvcNAQEBBQAEggEAW/U84wpOC/h8Ms5tPc8KFeZhoipY/rrUS6Ms
UZD0Pp5M3nKjgHz7MRYsiHDCc+VOeAIa28mw3u5LlSAhIKeJzX17yBZcPO140EAsx2ry8MYLNFcl
bwdSWsqjubr6QtUvjBjkidNkt+/O2T9d/sU+bQ7caxftM03FOdn18tH8dAf5yKDdW0pcCVz2VV/p
h13fuNoiTibsIPRrFQTXRwNEjV5iD/i9yMKZg/A6SrngFBeZ63Ocn3ycQswLKcoF7AaNFsWfaJau
sLUkkofI2he3XIgOMykasNeBaB5DiH28hwSbspoaVAemuBHmhIhHJF36o42JDHTx3XetqFrCzkCR
KwAAAAAAAA==

------=_NextPart_000_0120_01D77A5C.AE176E30--
