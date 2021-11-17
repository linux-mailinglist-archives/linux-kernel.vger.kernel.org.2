Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DDB453F14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 04:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhKQDqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 22:46:38 -0500
Received: from mail-eopbgr130070.outbound.protection.outlook.com ([40.107.13.70]:2446
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229614AbhKQDqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 22:46:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7ggnSAokUmvvVkFS3/8UrOXdCN36XVpCi3mmCI08vacSh9YjEvATy702OUbiTMzOiukof5Fy87dmHT8xjk5onOj9+WWPWgvCsZnTdKdcY1F5bFsBzaiPo6UIUJU7ud3snpHugC83dzDwi1PDazyoHselnbjUxuc+sDyrU+5lDLPVss+EzCu26slhEq+okn7sec1ZxMleAIIvyLxNZtULTs0vgOygBmc5O/URf7z/I6Kh3IvnDy7VsUstdb1ChV70cj/EJ6qPqz9MCu579ak0jWxTobIBexfUa+papjfBUXDvie0klydpEotVC4GKwni0WwHtxykvKywwjgVueFxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4liGXdmOQXVsqp2+6rbiVk4asccPcn6ERFMoEPPeT9g=;
 b=na2IBakaZ9bQkG2Acy2U8T1bpaxcoGQUZS7MuDK6HN2Nv16RdhaXW2q1O872P4u9bzLM3nPEFbq4klqAcNC8FwOHw5hbPnCkhWq+9sMkxw027UH+PB6jc3POvH+5qw1lTI5fodVzCpMt9tPcf3O2mIAEe9J/Vk9/5fjdkvd9tMABA/EGBxlYaYYmbX9hmwhVKKSXP/QfJ9qFjhL9e4HeBxV9PMK/XCWt2wClY/w6jLHRAGfLvsqCcN0Jiws9QeA66nRQf3qQvuvZL83QBNDzKjmRNZElyY8Z0OUN04KDkhQuzge+OSmzm9EoCKVomyQ62fXS/fm5HreD5WeY4JxTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4liGXdmOQXVsqp2+6rbiVk4asccPcn6ERFMoEPPeT9g=;
 b=NrY6ppjatcE3wa3eGbioEgjj/9WHk/q4kT++feIq2sDKgv7s81ZH9Q+0daWkdRdOBRPJcdztkii9zC9bYHHi7IscGnrg8AQRL+VuZNZnIEaZf1RkYGhiDQcFNaEaaa8DcTWkuFjoLVZ+AATr7BfjXSyVntXEQdJpNIUjOjBXzg8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 03:43:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Wed, 17 Nov 2021
 03:43:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] add i.MX8ULP scmi power domain
Thread-Topic: [PATCH 0/3] add i.MX8ULP scmi power domain
Thread-Index: AQHX22MxQv+CnsINSU+DFjWqBcyxvqwHE8wQ
Date:   Wed, 17 Nov 2021 03:43:32 +0000
Message-ID: <DU0PR04MB94179C596E6144B928D17D1D889A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
In-Reply-To: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5901318-6e1b-4ba2-eb35-08d9a97c6d84
x-ms-traffictypediagnostic: DU0PR04MB9251:
x-microsoft-antispam-prvs: <DU0PR04MB92516607C02149016E70F060889A9@DU0PR04MB9251.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjMWxpUo3WOH01JP/piRW9V/4vPCRh98HIS891Ft+lwHVWquKLBYQ4zs2JysMj10mr97nI/p+x4K2n2FDwtdz1qU72KrxFWwxhVv62ju6CgiXHk11ckOHECJHhXF2BhDVytrx5r91UJb3nvweV++FMh5hQfs6EnhKxvYrHapG4vqSKuumxnMn3yNp8BVa3sCLaWQwZlrKcpmqtVX5hxMpC7O/4MmnTyI9g/lQSDvgj7JtnvFw29Ep2Y4Sh6NoZrKQy03tNgh+svlut7ShjJpsb83SR0qsst78kLZc45Pz5HTgA2IgVbEKNrsU3LxxBfDvLCw7101EHUzxZ5tQJuWkn+bf4ZTSXOiFsly8GaLTW6TPYkdUUIyGjjbA7tVUvo7gd0ot27GWKVOv5tmykB+I8YKR2M4OEvG+ww5t/4eD26tc1pc3Ih9o2IJrITD4CkxDDHX9VMWVtXVXshPcFTt74TbL4PTAozOmGbt3iGM8mt4JQ7HVELkHA808O392tQcANmyD7o7YHJHaroOJ4eBMGbSyKXguUSLJd1Wj/TjXDYEt+JjTHtPUFZ+jUbay1hFr2xC1Y1k3NxpWEiqb5YnWMUMS7eKcTYqLDtXc+1fGBUYnagxwYeNELjxKOJ3Yt2qyldlfE8vSY9WDw52V7ygFeVUKeWwcgs7TzIpp9bVlmFg3EyN3y4156SoXG4uM6atDwWAU3/UfBy0iIabPuP4WM61fewWueKJWeAPniAsc04xboY0C/RCGSL6Fqgi2Mgs6g4eiWz8PPgeuBR1ltTIaSyk3Rg4mAglus91MjfP5ms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(8936002)(186003)(52536014)(76116006)(66446008)(64756008)(6506007)(9686003)(26005)(86362001)(316002)(5660300002)(38070700005)(71200400001)(110136005)(66946007)(508600001)(122000001)(966005)(54906003)(7696005)(55016002)(4326008)(33656002)(4744005)(44832011)(8676002)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5n3/oB/eEpWFT3MbAROWoUzKtEco1OsaXJPWEvBO6B3mmIp7mpBdbPTAr7q9?=
 =?us-ascii?Q?yMH+yItK5+PFFIDpj1pq9mcBAjeimG+lw+B37JkJ8Ug0VSPgRn0fBq4rxpvk?=
 =?us-ascii?Q?XHf4dXyiCwO4wQBbf2MxfsiqkXiNudqZPHEOmU96hfnG+TIwNqSuO2Azz705?=
 =?us-ascii?Q?WlPq0/tSmfk2inTlzHyGDbEmcrlHsUODVBeO5G4Hv5DPqEdRbKE3NolZeduT?=
 =?us-ascii?Q?+q2Zc8p18UPqsNXJ5eMm2O+SSxntTLlTmU9YcHI+AHBS1HZfvrdkUieZRiaQ?=
 =?us-ascii?Q?7wLGY9zGbesDygnNuWiO0vUTp/6rSC+r28ZsnyapnzSTOEzpXFQxrD2dt64G?=
 =?us-ascii?Q?usQliMH1cGpaFNimTOo0j7yTCvLvQfOXfMuxRTHOaWjpeucSf6lxCgY161Nz?=
 =?us-ascii?Q?o5JzPgvbyGPuKoJ0WJhkkTQwroCCAhwbeBEcJLVyxJFcksSBHtK69NjHdgUt?=
 =?us-ascii?Q?tpaTCPtGa++FEJRHMyfloIK1jZrHdStJaCpxc49mntswA61jcBBLKO0OGxyY?=
 =?us-ascii?Q?XJ5wxTsePsDTm9nL/6Pu+nbSQg5R/yQZbqc9dWV9W2IqF8YOFLaqMb+E3MjX?=
 =?us-ascii?Q?EqJhfXgYZ/kG59hAWgm6nriKPgRSHCklX7CfcMJ7+c+BYLlv7pUjHyIdByt6?=
 =?us-ascii?Q?PwSgG/1b3ZQlKGrp+FHQbPRxbXWn7doZB6rl/8Yvi+opUXEktd9qpHhPEKzq?=
 =?us-ascii?Q?8dnu5Uge7Nd11gHMJbDmeL3ugWbdfWUIX6CNB6K+WtFKyHwMA8BQuDF1c7z7?=
 =?us-ascii?Q?Fr6bNObMPXRNOaBd42weDlBE+UuUmkr6YBNOI4HZLldv6S7KSbaXj9PkD75+?=
 =?us-ascii?Q?GZqMx9EYU+1xGbQgzpIf/Eu8tgH/0suTMNptsm2ePwbqMqfbzHWwmiE4M3Go?=
 =?us-ascii?Q?2TLCAQIhNlEfCw+wUJpWb6chVEwlFGVNEBY1MnY4TT0NSF2PRHSlP6SvFn8R?=
 =?us-ascii?Q?xhqBtOvxS9KDggBIifmb6dZ++Nyc9jP2YdgkRhniNMsIFFT3pRRAvlmDVu0d?=
 =?us-ascii?Q?ASa308ttPJ0jPAnRvqCLQrGZ/g98MJHguQe9hmKVmLe/StgBgosiVPSMzh5a?=
 =?us-ascii?Q?MHGkOPAJQz1ZmcbLMQMZmTAIbv2YyTSpOvtG2aRtobMA9td0O4kXM7a2qy4f?=
 =?us-ascii?Q?PSLKVoIclo3cArd/yKICh7WwpY0iRlm/zk8yy81yd0sLH2XjA+3E5yOS8Pyp?=
 =?us-ascii?Q?kWtV0Oi5suHW3xacHsoTFe4cTJz2eqe4WlQJMum2osfnH6Q10enrcFK04Bj2?=
 =?us-ascii?Q?6PF4NjOHbYHixkRKa7b3+Ja0hOLlNLel1u7cHj6dGSogbtytBs9jrIux4vLw?=
 =?us-ascii?Q?oZZFxWw6nm8zTqdjM8YK+fT214ILuvaTf+8Ky13qNDJSrQaHk3H+5nI+Ifrg?=
 =?us-ascii?Q?op6Z3MmGwLpmKfrzKCeYeU6dtCseGK1ztHFntLwzI544q8P/vAoV3k4OcNFw?=
 =?us-ascii?Q?MqUsgE88DF82qRg69Y4+I0ePRtHwnoSl7kB65u8S0sG9Hr4y11NGCUPQG27F?=
 =?us-ascii?Q?crVeH+HWmcDAPVw5C7pIS7hzwISNcpyuYv2GEfznJkTSVBJm4/MvETH7i0hE?=
 =?us-ascii?Q?9vycN+iW3sH5FQo3HPODkM429ErxeH0ZOVip82EltczcQGnR95Db94ax4a44?=
 =?us-ascii?Q?cuITpP2kDLeYhv9zcDP/kPU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5901318-6e1b-4ba2-eb35-08d9a97c6d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 03:43:32.6678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOqJczHVJaJg35kNDtApWHD+mbyHNV0NogrpZqfIg3mBCrg5jjgxLSucVi+9+ygEcw3eDUJQZWjiZ9wDgboqUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9251
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 0/3] add i.MX8ULP scmi power domain

Forget to mention, this patchset based on:
https://lkml.org/lkml/2021/11/12/74

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> This patchset is to add device tree support for i.MX8ULP SCMI firmware, a=
nd
> enable it for USDHC node
>=20
> Peng Fan (3):
>   dt-bindings: power: imx8ulp: add power domain header file
>   arm64: dts: imx8ulp: add scmi firmware node
>   arm64: dts: imx8ulp: add power domain entry for usdhc
>=20
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 38
> ++++++++++++++++++++++  include/dt-bindings/power/imx8ulp-power.h
> | 26 +++++++++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 include/dt-bindings/power/imx8ulp-power.h
>=20
> --
> 2.25.1

