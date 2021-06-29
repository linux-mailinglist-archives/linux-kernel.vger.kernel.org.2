Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0BB3B74CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhF2PGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:06:21 -0400
Received: from mail-eopbgr670095.outbound.protection.outlook.com ([40.107.67.95]:37712
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233791AbhF2PGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:06:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlgMSCsxphE+r/CvKH56Hl1SPxJxdMIwdH3msZBRNcHG81ZHQLAuh1Vvg7cxTXSUSyv4UmJ/iKCncMzipFXv+0yiYb5gitDsKwoQivnrswkYszMZViB4o/IoOtJEuOgc41oI6DIGOpF1SaMvbwZrBePpiBaSKGYOcrR3dbVKIqZzeEDPqRAtqasKwe57AQRdU5imy2WT0V934OaFgtPncL2kgd/buEySvn2kUds2Qfq1n0tVI/M2by8R8VFnZUKiRN6+5NlzbwB0nWh0OQozAjNoB2eXeDsdXG91MxEHeSheyd6PuI1UJAmsWJq/4wVvs/x8bcroAK853oElfVFD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0uXC8BrV4k+5jSJlmRn+dHnLW+ttG3GNWxzkRdEEpQ=;
 b=XWPYFTlznTACqqp2k/lO6NvyyFtUsyn31U4VXsPlgvJxxbuGe+B03HxAI8gCor7B7FjDfoEdt7AC2avib7G1MObM/C7Bx3UsjdHh/3rGJB7PBwVSz70BUVikKud2Xs4QpKruCOe4oXPB/iAHw3KOvFRMazjxt+6iHmKiDP28hmqS82zJTrezeOBa674UWi78pd/KDqgp7gzRn1jgFAcH43S5Oc42vZ0hASXaSOIjWVViTpNcRPwkhY4z/+qfbw0lg2LlO1tGef2WWUumviLlVQleh6PIjIzEBCTTVzYJ9bsNTVLzycYdFdOI6IU+FJDaDa6GYPuyB0oVMgWpzd8B2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiphos.com; dmarc=pass action=none header.from=xiphos.com;
 dkim=pass header.d=xiphos.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiphos.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0uXC8BrV4k+5jSJlmRn+dHnLW+ttG3GNWxzkRdEEpQ=;
 b=Cbsz0TdhlFuDlEFQA/R9nEUrntSwUp+zdZmQJVYGbOkrKED2cYUlOtZUTQL/4Vx9mo8Bs1DtGn3EQiwmqYCdAMcqZS+jp/xB1SbVwwLx8LcHvIY7hqSq7by5xO70Ts+Q1GykxQmLWIDzoYSvZ01GeYNXQtraGF3htPvSUnE3SPU=
Received: from YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:d::20)
 by YQXPR01MB5098.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 15:03:50 +0000
Received: from YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::74e7:26e3:2b35:6c2d]) by YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::74e7:26e3:2b35:6c2d%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 15:03:50 +0000
From:   Liam Beguin <lvb@xiphos.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "liambeguin@gmail.com" <liambeguin@gmail.com>
Subject: RE: [PATCH 2/2] clk: lmk04832: Use of match table
Thread-Topic: [PATCH 2/2] clk: lmk04832: Use of match table
Thread-Index: AQHXbK0Z8v/+ynbxgkCidkv74M1Vk6srFmaQ
Date:   Tue, 29 Jun 2021 15:03:49 +0000
Message-ID: <YQBPR0101MB1811DDE8C4D8802A082E77DFD8029@YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM>
References: <20210629060751.3119453-1-sboyd@kernel.org>
 <20210629060751.3119453-2-sboyd@kernel.org>
In-Reply-To: <20210629060751.3119453-2-sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xiphos.com;
x-originating-ip: [198.48.202.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afcaa3d6-2b1a-4dfd-fb67-08d93b0f1a46
x-ms-traffictypediagnostic: YQXPR01MB5098:
x-microsoft-antispam-prvs: <YQXPR01MB5098478EFE0395555B779E9AD8029@YQXPR01MB5098.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QaO4XjI1I3IIfjb3Prou+aqukIQCQDSZuqRFL9gq+jw2TGId+DESUEw51wU+SWBiunRfXpUeIkVJOPxnMDP1mxUCniU0zAe6w2idCnK1CnUp0QsPpsF1hIxWkSRjdftV5nJFnmZZ1pmghN0aBN1VxaKm+7URA90blAJGc5Bb9W+er2MnJ4z1DZr4TkWgHPqZj+rTKcJV4D26A/2ZOwEHpUUAYNobzkZKHlOmXfqwn2odfDmFoEJEM7cYZbHTdyJIS+1jdJf3SjT8auk4DbvN241gcUMMny2iIPi7Y9yfJFS3Q/BZFeMS4IaTGCmmflBM0GiLO4FYGqDQ38PsjDSaAV6vwM0v1AoBYKiN5f/RKBhEeD/3wOQ5ZGcEVFp7md/pGQiEoQ8ig1rQ/zzbKcqegRK9bkemS6uXFZlPPcH5iInQIzNl1JwqidY5AkcRVyfsxNo8MLUyNm4sxJUNRcCBNlCpHxdgy5b77hk519YJX4b1qNSNRByfH+/1YNLmjrQxYMcBBEMWyi/CaoU1d62Kx8KCOHZbe2DG9GM+tbFCzTAHp6mN0bjTLlGlIc2q2sfIMQ426qU6INwaPrcZ/8Q+RyoieUh5596zqBouF2EQSr3lb6/PIVZfFss03ZZKkFDwX4hWKe8Bj+yy4Th+i0T5tlarOqWECvVKfP7I1hO5FN1ox83TFSEMIPnaAhWyKpXNj+KABK/lVxzoPwOeUoEEFmVHeJy2nwil5XBJmeaH9mgtUJPP6aeRhE21bWuF7Em3Q/l91Wfu2SJlky/1NcMSPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(396003)(39830400003)(52536014)(9686003)(71200400001)(53546011)(55016002)(8676002)(5660300002)(2906002)(478600001)(186003)(86362001)(26005)(6506007)(64756008)(38100700002)(316002)(76116006)(66556008)(66946007)(7696005)(966005)(66446008)(54906003)(110136005)(4326008)(33656002)(8936002)(122000001)(83380400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k1PPVkeCGhGIz748yzQQDIJ3bqpZ2CwysTJ5Vl3mPtRUWHvRxfK6Z5GV9UY+?=
 =?us-ascii?Q?RN1fuQkLcsjo4VHfCzOhKNHRckQCefLtZh4GcyLQNdkdO7h7GRKPHgmhll98?=
 =?us-ascii?Q?52KuSftBFAxEY9fHkUZD5rwEd0txMRtXJuSojypsMdBwxTJiX5zAHuhWAnpH?=
 =?us-ascii?Q?EQHEcxpEEdkAXmpM4jyzyxfvD4ETHQ0WTpck6QrILDAa/Xf0h+oJzxQtDOqm?=
 =?us-ascii?Q?qzj9lZc+wcq64dpQQcICQ8TirPIlK6Lni7KO6wyHZOMaN0Qu1Efv8VnapUn/?=
 =?us-ascii?Q?TlBoBqLscg5OqtaegeaLFGBldjjCEiayd/zd+YcQz6hgRjFQWUl3SiRWlkau?=
 =?us-ascii?Q?A1WXfZ56kJu8npiNHR6yTKyf8A5z2uQqAj0DJK29Uk194/J0eqEB93TCvd9d?=
 =?us-ascii?Q?hr8N3KPjND2s6SYJHFualeBB6UpsbAHIvpVI95Oxzdzvnh2nvF0GhMur9IIT?=
 =?us-ascii?Q?ZPofesuC/yLf8tB8tVHNIKkSYIiN21LInxu6VRuWGcWPDSiHC6c/0+xjqt2J?=
 =?us-ascii?Q?+zExEw2wI4usTkZ7SgiHBcsNjjtvSa9S9el4Qc4jQciHCyYd+gzAzeApi/ea?=
 =?us-ascii?Q?k0wD+u8HbAJH5DBMvU486SEBTE89+OlpB9MRakqNRVw75tO3lWbtICSfsmsk?=
 =?us-ascii?Q?TOI6e4XYzZr3KXOuZsmFqqzdE5lcyK3eAH/FiGzCL0tB58scrrUMWjl/76x1?=
 =?us-ascii?Q?BYaOEdmXvYexF+jD97wTpx/QUtFqt/md0mjGc15rCw3wtlio4PKuFVoVwUrt?=
 =?us-ascii?Q?22tvokIodYtcVViL7yfAbMCnZ9gNkNkABB2aP4GNC1Ezv62QgCnqO6SjTPVr?=
 =?us-ascii?Q?Z6nQNFx7hz7FvjVK1/eylZXS99/8twRT8qQYlKeff8u4BHH2K19g77ZhQhhE?=
 =?us-ascii?Q?wPDFLrVsrgr8JiNCLU9/LsXr3xY0/lEDTnDo7ojjYr3/OuCquZgUPuOt61ln?=
 =?us-ascii?Q?hsv8r0nqqaE3VKnKLCQR6LMMZYb9kwyR9ZhkrC7OnKYG0X7tCBn1ff9CXnph?=
 =?us-ascii?Q?oaNl6CUS5CnKdr0fEVZ5JC3L7B5LSVbYXSPY7JqbcpsX0y3HY6PDlk6f92wL?=
 =?us-ascii?Q?1k+/o2e1sdSXsybwnCS7c765NHhvIAlfVG9MHgHaOCmb4v4mqQOIbcol8E5z?=
 =?us-ascii?Q?U5B9uTz53+V2EiYSJblO5PCxHu0F7WJadUJT7krQU4KZsLznHhQ4VFO5hSvA?=
 =?us-ascii?Q?AM9QCaYXDCJW5R9a7s3c12oNr5DuTMKUQmS51HxgPTy70SnwhT8HHrF9krqn?=
 =?us-ascii?Q?AEPEgD2ZxKeNXrcCCJ1+D2/kin45ejBDI8w0jaq/WIXcPn/CWlxFi/NHkcrq?=
 =?us-ascii?Q?LglTZEb3lLBvhUXaL6vfZPsX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xiphos.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: afcaa3d6-2b1a-4dfd-fb67-08d93b0f1a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 15:03:49.9895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 11c32550-fdb1-48d9-8a3d-133e5b75b54f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: up0MGrDJnRy0EKt99WNM0+iFRwjS0zeLwAvi7IE+iqD99EQPt1cKZ1d72UDU4XaW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Boyd <sboyd@kernel.org>
> Sent: June 29, 2021 2:08 AM
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>
> Cc: linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org; kernel test
> robot <lkp@intel.com>; Liam Beguin <lvb@xiphos.com>
> Subject: [PATCH 2/2] clk: lmk04832: Use of match table
>=20
> Presumably we want to use this match table so add a module device table
> and set the driver match pointer appropriately.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Liam Beguin <lvb@xiphos.com>
> Fixes: 3bc61cfd6f4a ("clk: add support for the lmk04832")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Liam Beguin <lvb@xiphos.com>

> ---
>  drivers/clk/clk-lmk04832.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
> index 0cd76e626c3d..c1095e733220 100644
> --- a/drivers/clk/clk-lmk04832.c
> +++ b/drivers/clk/clk-lmk04832.c
> @@ -1573,18 +1573,20 @@ static int lmk04832_remove(struct spi_device
> *spi)
>  }
>  static const struct spi_device_id lmk04832_id[] =3D {
>  	{ "lmk04832", LMK04832 },
> -	{},
> +	{}
>  };
>  MODULE_DEVICE_TABLE(spi, lmk04832_id);
>=20
>  static const struct of_device_id lmk04832_of_id[] =3D {
>  	{ .compatible =3D "ti,lmk04832" },
> -	{},
> +	{}
>  };
> +MODULE_DEVICE_TABLE(of, lmk04832_of_id);
>=20
>  static struct spi_driver lmk04832_driver =3D {
>  	.driver =3D {
>  		.name	=3D "lmk04832",
> +		.of_match_table =3D lmk04832_of_id,
>  	},
>  	.probe		=3D lmk04832_probe,
>  	.remove		=3D lmk04832_remove,
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

