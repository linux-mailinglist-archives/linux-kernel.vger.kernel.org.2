Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2B3CB4A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhGPIqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:46:10 -0400
Received: from mail-eopbgr10063.outbound.protection.outlook.com ([40.107.1.63]:54659
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237633AbhGPIqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:46:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSEPs0U+dcebj10FuRGYS1XCTInPjwvQJCzS3Rd6uCsKIi3RiyFk3PrWQrfL6H+siy3uEaMTFa5kvivFu6rMpOyhvXOJb0mZATH0YOCuFSes3RFltKQTpqFYo6Nk6xjG/Fvz0lC6Nok+19R/Ic1ok2OoAeK1IcT+VlMVUz2gkrZYyMagESP1OwTEg6rzNyXFylHV92tmTy+ABOP/sQ0fSLiPfsNokQOplpcXAfIpnNhrvi8c59jW566yVWGkdpZc5Q51XhPf0gznsI87M4idrga30Uga15OW7DX7AEt/lXuXAnAyHN9n3hnRRSBfCPrKx8wbqb/eDcjtxSgkELmBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtrZfI8gP1bjQcOkrKG1O8XBsSe0dbS4jul37UDdQX4=;
 b=KODUqvrJbjcfKnaHdoiu7If47YjLd+Ed7jhoTDnwCJIeXSlqoAxWbNUCJswJ9gUQKZ1Vv7+VhLsM6Vc1LZvs+3QxwWZZrol/VRYIfbFkQsEgo7tGugkbZlwCQlnzM69tr2K5yz22M/foZX7qI0DEwgjx/Ory4a1MtbjEsdQUUHotPO02rGDe8OTiNt+lFbyzQ+AOJyws0c14ldz2AXRrZG3YD1obtTv/S7Vat4PPXOU8tH5JRD32F/oozdh0A83kdqgk1MliIvWUVyq27+sk2IPzm32vEsfmS1SNBCjtiMB28zxjUv5sLqztsnSElfPvUkfgQPfNjpkBnshYBEP3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtrZfI8gP1bjQcOkrKG1O8XBsSe0dbS4jul37UDdQX4=;
 b=PHVJqWD+opvViKAi6neF/eJe50JfNO2FhHoSyruk2FUuaGwXtlo6peqljKO62zgH50snYAcqJYLqkeYYsbqavWT5IziLCpgUzRxeM+zUC8Zo3WXenoXj8NQ45lU1FvR5XEqSsIk2p91P0ou09U/jik0uJzHx732KayXjztZScEY=
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR0402MB3765.eurprd04.prod.outlook.com (2603:10a6:209:19::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.24; Fri, 16 Jul
 2021 08:43:09 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 08:43:09 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 5/5] i3c: master: svc: add runtime pm support
Thread-Topic: [PATCH V2 5/5] i3c: master: svc: add runtime pm support
Thread-Index: AQHXehVHZK/sckg9hkGCd9ty27XLc6tFPPkAgAACKMA=
Date:   Fri, 16 Jul 2021 08:43:09 +0000
Message-ID: <AM6PR04MB56232E15368E80791C48C58AF3119@AM6PR04MB5623.eurprd04.prod.outlook.com>
References: <20210716073723.3490180-1-xiaoning.wang@nxp.com>
        <20210716073723.3490180-6-xiaoning.wang@nxp.com>
 <20210716095958.4e27d574@xps13>
In-Reply-To: <20210716095958.4e27d574@xps13>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 240e2340-5683-47c2-abfc-08d94835bd2e
x-ms-traffictypediagnostic: AM6PR0402MB3765:
x-microsoft-antispam-prvs: <AM6PR0402MB376530C0097EA263C8F1A78BF3119@AM6PR0402MB3765.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bogFNGiM1jEPz4m+1mEsZh4dJE5F1y89ZQWWqcHjKODMyV54nH/C2Jg8LYWTqwVaCD4+Bc9cQ3paF4jkBUZDDsEkXRcVaAqAiQaITsPfkvsKM9FyyF+rVOjQJU0BBQpHONuJYtKi6gXwr2jFffYz6q84JaRw6SiHVnH0wxW7zOQQmMMgcRpKECJjW3IsjskWLFB9HZX6eq9RDJ77j4JmAXknVtdixe9+e17uoaklx1pqjz8JMf5hvzS47WTRBsDv0+RofWogrXhX8EagGGjrfnwco3c11gLUOFYT3iuKBuncak4KwEbdWt0dT2S4tFwJ+CIdfN6GmmMDLQvzdczW9vImmFdc44V30bWTz6jYK3k6gucMeTqY+rVzjv0x+suL3YVW+TgpwON5s+JtKWn7Z4FnarY5plx7wDLH5tgbuOyRHx7q6wUCIS/b23Y9BG/a7CTt6svLybtpjZjTfmJdNZane4aVbl/SZlZKs16zpJ/yW+KxVlRWRnyKi6cIbI4H2MfxXpEVEq2H8cg8b6415Y7C9SpfsPsVrTeJDzBxZTZh4H81QMpA/dewXZs+vMXdIYisgNcUJIDMsEndGoCxMv1tg3zDWZdvhQ9Z0ZVJe6bvuivzxl2Qb7RrDrQ3J931/blpsrzcw/TBJEZOiRRbj/yEv8fv1m/7YMzCS/bpA/RzxhAp9KEOg9vlsiJNpH8KSVNoa46IgrNGTpEIWpmlJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(53546011)(4326008)(83380400001)(76116006)(55016002)(6506007)(66574015)(26005)(66556008)(66476007)(66616009)(66946007)(5660300002)(9686003)(66446008)(7696005)(64756008)(33656002)(316002)(122000001)(99936003)(2906002)(54906003)(52536014)(478600001)(38100700002)(186003)(6916009)(8676002)(86362001)(71200400001)(8936002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGg1dkVrU3ZHbHo5S2FnVk9RS3EwL2lzWlVJOU15M2ljUjduTllNT3NKeFhT?=
 =?utf-8?B?blo0azJlZ25pdklnK0FoRTA0aGg4Mm51K2dQRU5pMjRxUjV0TXREWGM0MUZ6?=
 =?utf-8?B?RjNpa1FLZE0xVHNFQ3p3aWxXcjZUZk5PeEwxOU4wSjQ3NmNSNG1YbWU1YXd2?=
 =?utf-8?B?L2ordXVYNVVJNFFJaWFCSHRKS05ObXh0WEtVSHI5TzNoMGRzRGZDRjVLNGh1?=
 =?utf-8?B?U2I5d2NIbk8wQTdyRDFqV0ZQQ1kwamI0N2pxcGdFalMzVjNmT0wyMEVCT2h0?=
 =?utf-8?B?a2NQL0krWS9TeElGV25HTzJVUEVOOUVpYXVQeURwbEp4Mms5TDdJRFlUQjVF?=
 =?utf-8?B?WXRMZ2tWVGV0UEdlVzVORHZySjFINDNZY1RTOHk1Y3pmdUtFSGN3VjJPVzY3?=
 =?utf-8?B?ZnhOZUpNZWliYUtBbFI4NG5Kd2J1VnQ0OS9uR0FMMzFPZDIxVUdHRzdBYURD?=
 =?utf-8?B?S0lNZ0VWemY2TFB2NjJCSWUvdnVjeUUxSm5sTkdMSWJRd0RJNGZLcVlVc3I2?=
 =?utf-8?B?TklnUzFOMjBXb1RSSVFJUFJsTlVYcVhPOCtUdlFrbXgvTGNRZnhlalMwUjFK?=
 =?utf-8?B?TTFsMERCNnZnY2hlTHN6Nlg2TXl1MnJrdmh2d0tkaTZmM3FlNDRmaEoxdlBt?=
 =?utf-8?B?NW9ndzd1Y1g3VndJNlpYT2tENUtaeTBqQzRSU3hYRzFvVU1EcWV3Rm5Nd1Q2?=
 =?utf-8?B?WUdpeWNIZE56ZDdyaU01OVZjcy93WlpCQ29BSWxnY2hkbGpwVVV5V0lBeTE5?=
 =?utf-8?B?MGpaL2NPVG4zRVdpMUxLQ3JEYlYwMU1uOFhVeEpCR0xUSHBSUkJ5UmxySFBN?=
 =?utf-8?B?NUpYNDVTSUphcWZ4R3dKaUgweTdBQ1Bla2M5dlZlR1l2L1ZVSXB1OHpqdXQv?=
 =?utf-8?B?UUZKbGp2UERyQld6cTkvdG1zbFpyMkQ2Mzk2WXZic08zN2RYZnVvME1UNWMx?=
 =?utf-8?B?M2JscGpnMzVqTXlXZkg3VEcwemUxRm8zS2drZ2RVcmRDZUMvN2ZkdEpwZ0E1?=
 =?utf-8?B?bzQ2eTJJZmZEa0VZYUYxazEzUHZuTnYzVUcxUDA5VWdJZDdDb0hIditEMkI0?=
 =?utf-8?B?NGtMcDVrYVV3ZkpoWGI1ZXBCOHduUVNFbmcxSXRZTkdnWkgybzJObHVoOWJD?=
 =?utf-8?B?QXlFMmdSbCtzVnhxY1BEYzZ0T0dSandJTW96Y2xTci9PK3pLejJrVVZWTHU4?=
 =?utf-8?B?cTBzZ25adVRENjhzUG9FbjNqZUtKYnRYMFB1SXBHaGFRQ2gyTUZYaEE4MExa?=
 =?utf-8?B?QXU2SDdKSXE0VlVZYUdrY3JUdFU3Q0RXMVUwSTVPYmtiWnV1dllMSHQ0Ujl2?=
 =?utf-8?B?aXloMDN6Uy95Zzl0OVE4REVsZVRVd2hNK0ZZSVFPRDR3NXVKNlgydWZRbDIv?=
 =?utf-8?B?K0dUeHpQalpPemZQRURUYlJhdEtvSXdTNjNyc1R5MmpQUDdDcXQ4bmFKbHRW?=
 =?utf-8?B?UzFkdFd6OUg3eUNhN0UxR2ZjNmlZWXAzZ0UxR2cxcDkwNmJWenYyUHB0ZGww?=
 =?utf-8?B?RHFoMW8wdUNTT3JEUWlCTStQaGFYNVJZNDBmQkVvSFRVbzhwWUFvWEhRUHNY?=
 =?utf-8?B?Y0U3MENMTFdTcUZPQnhIQWZXQ09hZjVxOCsrMGU5YkRwYlA5aUg4Y0d3QkE5?=
 =?utf-8?B?TERQdlFmRWRuT2dKUm9KT2dVemYwSzZPVWI3d0ZPS2JTQUxCeU5NUjQ1cENI?=
 =?utf-8?B?MC9OVEllTXg4d2hjcDFUaTdqaWkvQnV5YU11YU9kdXlqZFlCU0tIMU9WOVB1?=
 =?utf-8?Q?Kr5zBH+BUYw3N58ETutda3ww4ixX1sFjZunAece?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_0124_01D77A61.A666A480"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240e2340-5683-47c2-abfc-08d94835bd2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 08:43:09.3005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgsEoLzjS6awMnoOaC2pkT3ltwfmZRx+ehT9umf6QQiPb0QqJ7BzAbC3NrpR2WVG4qpmuBZvmegFFPNlm30S0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3765
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0124_01D77A61.A666A480
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> Sent: Friday, July 16, 2021 16:00
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: conor.culhane@silvaco.com; alexandre.belloni@bootlin.com; linux-
> i3c@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V2 5/5] i3c: master: svc: add runtime pm support
>=20
> Hi Clark,
>=20
>=20
> > @@ -1431,7 +1502,7 @@ static int svc_i3c_master_probe(struct
> platform_device *pdev)
> >  					 GFP_KERNEL);
> >  	if (!master->ibi.slots) {
> >  		ret =3D -ENOMEM;
> > -		goto err_disable_sclk;
> > +		goto rpm_disable;
> >  	}
> >
> >  	platform_set_drvdata(pdev, master);
> > @@ -1442,18 +1513,17 @@ static int svc_i3c_master_probe(struct
> platform_device *pdev)
> >  	ret =3D i3c_master_register(&master->base, &pdev->dev,
> >  				  &svc_i3c_master_ops, false);
> >  	if (ret)
> > -		goto err_disable_sclk;
> > +		goto rpm_disable;
> >
> > -	return 0;
> > -
> > -err_disable_sclk:
> > -	clk_disable_unprepare(master->sclk);
> > +	pm_runtime_mark_last_busy(&pdev->dev);
> > +	pm_runtime_put_autosuspend(&pdev->dev);
> >
> > -err_disable_fclk:
> > -	clk_disable_unprepare(master->fclk);
> > +	return 0;
> >
> > -err_disable_pclk:
> > -	clk_disable_unprepare(master->pclk);
>=20
> It's not clear to me why you drop the disable_*clk labels to move them =
back
> in place? I would rather prefer to keep a clean error path.

Hi Miquel,

Yes it is. This change is indeed not very clear.
I have restored the error path.
And I found that it is not necessary to enable runtime pm so early.

Please check V3.

Thanks.

Best Regards,
Clark Wang

>=20
> > +rpm_disable:
> > +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > +	pm_runtime_put_sync(&pdev->dev);
> > +	pm_runtime_disable(&pdev->dev);
> >
> >  	return ret;
> >  }
> > @@ -1467,13 +1537,57 @@ static int svc_i3c_master_remove(struct
> platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > +	pm_runtime_disable(&pdev->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused svc_i3c_runtime_suspend(struct device =
*dev)
> > +{
> > +	struct svc_i3c_master *master =3D dev_get_drvdata(dev);
> > +
> >  	clk_disable_unprepare(master->pclk);
> >  	clk_disable_unprepare(master->fclk);
> >  	clk_disable_unprepare(master->sclk);
> > +	pinctrl_pm_select_sleep_state(dev);
> >
> >  	return 0;
> >  }
> >
> > +static int __maybe_unused svc_i3c_runtime_resume(struct device =
*dev)
> > +{
> > +	struct svc_i3c_master *master =3D dev_get_drvdata(dev);
> > +	int ret =3D 0;
> > +
> > +	pinctrl_pm_select_default_state(dev);
> > +	ret =3D clk_prepare_enable(master->pclk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D clk_prepare_enable(master->fclk);
> > +	if (ret) {
> > +		clk_disable_unprepare(master->pclk);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(master->sclk);
> > +	if (ret) {
> > +		clk_disable_unprepare(master->pclk);
> > +		clk_disable_unprepare(master->fclk);
> > +		return ret;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct dev_pm_ops svc_i3c_pm_ops =3D {
> > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +				      pm_runtime_force_resume)
> > +	SET_RUNTIME_PM_OPS(svc_i3c_runtime_suspend,
> > +			   svc_i3c_runtime_resume, NULL)
> > +};
> > +
> >  static const struct of_device_id svc_i3c_master_of_match_tbl[] =3D =
{
> >  	{ .compatible =3D "silvaco,i3c-master" },
> >  	{ /* sentinel */ },
> > @@ -1485,6 +1599,7 @@ static struct platform_driver svc_i3c_master =
=3D {
> >  	.driver =3D {
> >  		.name =3D "silvaco-i3c-master",
> >  		.of_match_table =3D svc_i3c_master_of_match_tbl,
> > +		.pm =3D &svc_i3c_pm_ops,
> >  	},
> >  };
> >  module_platform_driver(svc_i3c_master);
>=20
> Thanks,
> Miqu=C3=A8l

------=_NextPart_000_0124_01D77A61.A666A480
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA3MTYwODQzMDVaMC8GCSqGSIb3DQEJBDEi
BCAGfmdlF79Ri+eglCM+b5+Q3kZSLewZ4TAYWy8t3Zea7TCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
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
zdosMAwAAAAAWXwwDQYJKoZIhvcNAQEBBQAEggEAUf3/VoVFyQu4yeOnJvVIT1p74r654dgGVvv9
N4v6r9OQoqMtX61xx/i0XBgK84II4YAU7bTaF8L68bhREpJfzXA6gGQJ4kKfhhkURvjl4OhNmQNx
VpcOTzS4RjeTxT49Du8X1y5BSqlV+MeGi666UQdATQn/9pXuDs0epTA6D9Xy6pK41j0qhqsw6lfn
J3GGN0QvT7wR/vtEicDAGe+4wCRyc78rzqS2olaVuZlTx6mE1pORZrqRA9MjDj2E4lhuYRgwqtaU
NLBRfjdFex1Gnp7KIdB0DhiZAxMOOBVE/AcuKfv+cLrSqkFOB3QkSszaJ6YOHiEexgFWF4+WUhsD
MgAAAAAAAA==

------=_NextPart_000_0124_01D77A61.A666A480--
