Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FBD436E59
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhJUXdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:33:17 -0400
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:32326
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232164AbhJUXdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:33:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmuyNy5gDGDCIb7Ua343P5Pqmvbkxmd0r31EC5AxWqrnWmLRYnrm5Eu2Do8Ws8prMmf1CXdlHk2Q8I1hX88qscAZWc2mB2PWxmRzwEflxaP852Ryko4mszPA559zuABtNCMwuJNHRq2zDSI2u0wcE/ObXzhRbbjQjG9zcpvW2PA/bl0sXQDiJYIOTChdR7ZkA+nlC/2WUGwu8aeYpYhvq2Q4AlGeCa0ruFdwrm87J7yBb8JsyKepBpTad5a6pLBNeGy/CII5nB7Yt681wuvgIW57u3JCsONSR4Orv636PtcFs/niA4eXv7kMKRLpt7esaUrGIPdMoqQ3UiOk4q8DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP00uDyPtS/mDvZro5jO+DzuEoYRyBflsC5wjLr1qJo=;
 b=NestTda76oLx8s5ebHUZyI4EU29MALmjtyR9JyGdA6Krg4g35766NvPkgApNXfx8/Eh0NBflY589yj0FZ75E2RoTOKdAwT7+S93uWCOwJhOzu2KTE+YYC/b1suVrHoeB0LNTw0pnwazhLqC7MkqVY9jBNcCE9wUGbgZjKv+1khcgXP9tOCwPF+ASK8xy3fx3h+QCN10Hc5UdqqUoIFOTGFdcfb9a6mU7XuqT/pAKBuDOq5vJ2IV4oPBU1M3iKlU1D/Z+APGdj60+fuRaY9FLY2Vl32yQaUjLbNst4vhm9XEu2PKxuWwZOhTRTtehtrOgdY4sTK5OPZlYFdgrBwAE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP00uDyPtS/mDvZro5jO+DzuEoYRyBflsC5wjLr1qJo=;
 b=Sy4J1FXGzEajpxBj5CrsyYifJtT4+sAQkwpiqLyazuRoyvxa8eXvvwGUiC6GmCWS5FbopNp4LTu3G+4XUaLna68bgLyjIrZ0ZaEo5fmit3OTfJ9luATGTeur5+Yht7YIRsINV1Ck5v5fI1EZWpFRxX30g0wUnUUoTc9FtgAqvNU=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB8515.eurprd04.prod.outlook.com (2603:10a6:20b:342::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 23:30:55 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%6]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 23:30:55 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
CC:     Youri Querry <youri.querry_1@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] soc: fsl: various fixes
Thread-Topic: [PATCH 0/5] soc: fsl: various fixes
Thread-Index: AQHXxDJZGuwTGEhj5kiTHzHz+X2UdKveHjqg
Date:   Thu, 21 Oct 2021 23:30:55 +0000
Message-ID: <AS8PR04MB8946762ADF9497251A7490A38FBF9@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211018151034.137918-1-ioana.ciornei@nxp.com>
In-Reply-To: <20211018151034.137918-1-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5edcc1f6-a712-4418-5b76-08d994ead45a
x-ms-traffictypediagnostic: AS8PR04MB8515:
x-microsoft-antispam-prvs: <AS8PR04MB85150DA6427C0D803ADEC09B8FBF9@AS8PR04MB8515.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3SVb6H8wXomZuGIA1STXHpI1XR9dNhvVm16bWnXjSiHFo5thMNVUjyqJMpFI0Vn34zSiRS03MXBJTimnhf6++pSwpLeRJurkd/3x8c+IqmfieQ7mQACcPBV3c/6uHPRw2N0GbDsE7CcKOFe2US5FUjqw1u2I0/xEKLEXNLr6dpHayZeLlPA0AwxbNuc7Mojo1qcg3PN9/fZZaxEVRkTL+MOnvVDeDwtLLoAYGuYxMloNrWmlgDG9FHNwMoV7U/IGoTnC2/kOMRFSeBrd78tOem+JZr3cNidmuhGoFIF1W1vAJ2dt+hwABgMudmT4+PHa3XHoohKb5DiQfmaugnE6PPep5nmEZbBWJ23E8W2amkPgWJDKnOev5ii1CXjY06Mua2zfdMheWkiNTxPX4z1uybyZWOaaZcGrKllJhnclyVJutuypDrSaEtZIVGz+PInvI3x7vUx5UoqthQ3WbwKKQvi46S76Q1LPFt/TGkPPmEG8TnSgKxlNeLq8abYmeV8VemFmBQ9WMnYfRLsns+6ORugG/huTGMMrhruJSnnRsP6dTNQd7R5v2AbeRTpa8wlc4DYT0MAgSzutBtcGN03EtUjCa++wRL6fNYP8NVWrCt3JeN11fnq0lwmPq/a0YOJVGst1SLZWfaGBi7JSrnI0HNRX9RetOVwEf64lccCpoP8waPs3kSfbnEyvhQY5NioN1Hano36sBMKaF6H75Yu8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(86362001)(54906003)(66946007)(316002)(66446008)(33656002)(64756008)(66556008)(55016002)(71200400001)(26005)(9686003)(186003)(8676002)(76116006)(38070700005)(6506007)(4326008)(6636002)(83380400001)(52536014)(2906002)(6862004)(38100700002)(508600001)(8936002)(122000001)(53546011)(7696005)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TRva4kOEBOmSGWk+pXQ5yi+vcjWS74FfHg/50GOU7dgf6YgLQd5MBAJF2fmi?=
 =?us-ascii?Q?1azffeH9SZbtK6DlUDEB7WeIECGnWNt//b5aPzMKT/ExgZXwJJ3hIA7Q940N?=
 =?us-ascii?Q?NFQvBAvdvUPQTPdn3rg1vesEv7JBvNP7vSl6sDMF5QJT5Bp1eDvObiSuth4F?=
 =?us-ascii?Q?e8xGN+Y7TxmCFVkWBs01vAyA4Gz4ipXMO59ySmbPBTfWfg1zya8DJHeVIIlX?=
 =?us-ascii?Q?s1NDekrvEUtXR3ddc0lyqqhyWQkLkMGFK2v2apXeuQ9idBC4a3xBstL4qV97?=
 =?us-ascii?Q?760F0XEmAFCQikprxLQkq0Kvy3TiJMjph2siLGpdTmSJR4G0M1LnptvvkbUA?=
 =?us-ascii?Q?VKa4ItsxPuzmmJz0+UFL3aXhWsl29dK+nnfBtzXVl14N2D9gixXR0UbahNAt?=
 =?us-ascii?Q?1EJgeaHACqScAGGOKIpWf08vJzZ0XXDRuygI6I7Cmb0N618AaNx2oTjdVax5?=
 =?us-ascii?Q?3TlOSaW/igZMn5Z/4kyhw/ZEwdZHwZhLjh4kmK3Lv54PaISf83YMoFH9aLO/?=
 =?us-ascii?Q?GEcFOmqmKMPFSZuBWjQIzUqZWdqGs7YuD7TC01iUNLfGNFW2BTDsGgTUbutk?=
 =?us-ascii?Q?a2peRA72HX4YM5N1CbPSTUAt4dTCnaxureo/vUyuPVXA+e+1c4CXx3CjASmY?=
 =?us-ascii?Q?N3soUNh20llRzJEiQf5/Br9uOwgSWisX0PVBJTUjDwgk4uSDLdhASR+nyoaF?=
 =?us-ascii?Q?SNzeaRV0csALYIu5Fu0MqbhOzXd71rALTJ+Py4Q4KHTxXPmuA0zZBsHQD7Ag?=
 =?us-ascii?Q?0NHl5OzT3JO7gIN9PGzawqZVRKNdM2LXtvhBQRU4l6CR2r64DT4zpHxwufqe?=
 =?us-ascii?Q?zMrM/ySfJPXxfUxPZPqrltcl3wo/fC/A/l/Tjsc7sssxRLOt4Lae1+U84rh6?=
 =?us-ascii?Q?gp10FB1c4iX7TRZEbsPM0Gai7tvAF4j9E1zK5hvQLPapbo1pp7NNqoIvpHsN?=
 =?us-ascii?Q?LFSaiNFvMDFPOCMldYNWmA7LZ4Ho3Rbb933mWD2MSVQhNq0QKAdqh7WtS/w+?=
 =?us-ascii?Q?EjcopTaWrLclbUUY+GvmzRGWG0gmLoDXJ+AHTdaknTEmGq+MqtJEs2xQAZvV?=
 =?us-ascii?Q?Wf+RJVvfyeDOEqQ8MaAdAHHemH9kX5HLrTbjvLXZx5NTdmufAvh4xm9+gz7L?=
 =?us-ascii?Q?z7+kW/4IqpGjjCh0+xbfajIiOOb2sUo5ofm3tFr1bpC4SFPSdmTZuvOT3711?=
 =?us-ascii?Q?VmDRP5JNLX41YCl+2qbHuqhnZ7sdIxzm+E7gDDc7BiG5CTFU1tfM2bmVOjsC?=
 =?us-ascii?Q?1W87Bbk5l3U2bYFzGqlKhZtBbR58xt5PmWY4KxabQ3PRSj/Q1RkysMBTaEA3?=
 =?us-ascii?Q?VcmDjkd0RuMTPVnkbFv74lI+X+L/me6N5f9aL5hbnPy0/JxijFF4iR3oo2s4?=
 =?us-ascii?Q?hqmS1IxA5AGE83btJWDKSAxqv15rnDLcNBojcUCIq/xwxTpM7Hl4v2nKhSUB?=
 =?us-ascii?Q?yapydDVWjT8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edcc1f6-a712-4418-5b76-08d994ead45a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 23:30:55.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leoyang.li@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ioana Ciornei <ioana.ciornei@nxp.com>
> Sent: Monday, October 18, 2021 10:10 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Youri Querry <youri.querry_1@nxp.com>; linux-kernel@vger.kernel.org;
> Ioana Ciornei <ioana.ciornei@nxp.com>
> Subject: [PATCH 0/5] soc: fsl: various fixes
>=20
> This patch set has various unrelated fixes in the dpio driver and the
> dpaa2-console one.
> Patches were applied on latest linux-next and formatted from there.
>=20
> Diana Craciun (1):
>   soc: fsl: dpio: fix qbman alignment error in the virtualization
>     context
>=20
> Ioana Ciornei (2):
>   soc: fsl: dpio: use an explicit NULL instead of 0
>   soc: fsl: dpio: fix kernel-doc warnings
>=20
> Robert-Ionut Alexa (1):
>   soc: fsl: dpaa2-console: free buffer before returning from
>     dpaa2_console_read
>=20
> Youri Querry (1):
>   soc: fsl: dpio: rename the enqueue descriptor variable

Patch 4-5 are applied for fix.

Patch 1-2 are applied for next.  Patch 3 cannot be applied cleanly, we prob=
ably can apply it after the changes in Linux-next get into the mainline.

Thanks.
>=20
>  drivers/soc/fsl/dpaa2-console.c     |  1 +
>  drivers/soc/fsl/dpio/dpio-service.c | 42 ++++++++--------
>  drivers/soc/fsl/dpio/qbman-portal.c | 76 ++++++++++++++---------------
>  drivers/soc/fsl/dpio/qbman-portal.h | 39 +++++++++------
>  4 files changed, 85 insertions(+), 73 deletions(-)
>=20
> --
> 2.33.1

