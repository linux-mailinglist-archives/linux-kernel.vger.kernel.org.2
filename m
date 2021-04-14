Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CF35F02E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350228AbhDNIvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:51:35 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:12531
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244803AbhDNIva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:51:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VW7e4leQ2fbzjaln2elNQYkB19WrflSg7H28fYvWm99PPQMHsLaMgkjH10O/pEQKVqfcbeBr3l45czEkz+89MV3XC6yY2BYde2g3oojjWj7FRyxqox+5BX3n3H4JYKK71dzOOcNQD22ya0YUmljXOveaRkZFWfFbD24eWGB2MWR8YluniOx4x+G9X3oPw52kGoAWu801AhWrDSewDgQ2QhZMO19OIM25LUJHfISBYbgRa5RhYlbPGUceGs+WWipkKLWr5uxVw40JKdnpyjH5bvuD+22W8AuWI3BjjxUgYmYafd6UZh7rCCW3IjqedXC3HU5qwN9Kz0cfdx6lhfJhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx1QdB2ZN/64wkELiRcmmvwEB1lEeVXIVNcd6m0XY6s=;
 b=h3yVqQNf2HeA999RqcuiLk5fe41yN45v9wlaDAXKO28N+2rch4qNZo55SvFTk9OhU0qw6a0xIxCBMLSsDU2dw0/iTFJg6cogds4uUqeNA7ltRNGDAb6c+BDGe2qU70CGP4HQcjfmrkdaPopBrs3p0Z71F0sKDeoIwqz+0eTl1dWekZQeeOBEe8mJW5N+jk/juJVbDgQiK7iPv9RF64oDgkWYDcBE/pcG41x1qf+L3au1QpLcyxSvQk0tAFobRyFqfm3B3KtCd1MlaZqsmQZLY3ekZa8E8KZK2UG+s0UZZtjpA/iPcwAEhF0PqXrDnT0POfJNnuPNr145eC8ZgQx8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx1QdB2ZN/64wkELiRcmmvwEB1lEeVXIVNcd6m0XY6s=;
 b=TGDvlLtyUgys+3CXQUNidqKJHsbpqn8hTH/tyIC3mnkkX5vX1nMKFrLQVJ7PW4UmEh+H4WGxP6Uza64zBJVRwO5UOS4W1fSCmYccXYivl717sjH+iARZvbq/LXzdFzjDQLPAUUX/f8GT+M2TJ/aMt6xpg+VdrXfx3Mb9uj8u9DM=
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com (2603:10a6:10:1f::15)
 by DBBPR04MB7691.eurprd04.prod.outlook.com (2603:10a6:10:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 08:51:06 +0000
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::942e:77ac:a38c:98d6]) by DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::942e:77ac:a38c:98d6%7]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 08:51:06 +0000
From:   "Sahil Malhotra (OSS)" <sahil.malhotra@oss.nxp.com>
To:     "Sahil Malhotra (OSS)" <sahil.malhotra@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "Sahil Malhotra (OSS)" <sahil.malhotra@oss.nxp.com>,
        Michael Walle <michael@walle.cc>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: ls1028a-rdb: enable optee node
Thread-Topic: [PATCH] arm64: dts: ls1028a-rdb: enable optee node
Thread-Index: AQHXJXQnzbSzAJafl0miFlDq4Bz3Q6qzy6/Q
Date:   Wed, 14 Apr 2021 08:51:05 +0000
Message-ID: <DB7PR04MB53224FF04ABFBD166124664E824E9@DB7PR04MB5322.eurprd04.prod.outlook.com>
References: <20210330145027.16897-1-sahil.malhotra@oss.nxp.com>
In-Reply-To: <20210330145027.16897-1-sahil.malhotra@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.36.225.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27078ea8-922d-49a0-9241-08d8ff2270e9
x-ms-traffictypediagnostic: DBBPR04MB7691:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB7691D67524534A66F772888CC34E9@DBBPR04MB7691.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzbhRI2ZO2cf/57p1d8fPQLUnYiCgbRc8vfE7cRQC/hU8kzqeYWydGwI0HxyZx+ARgqp0mBWO9daAGa7oBtKQTznM7gV3WK5Qe/U8x87XgsgzwSDslePjSbyy4/xAhgancenwDa2QmpcYdS1pFp7U44Z4UeURJfoQNbMNcXQmTrdeI7PLeyTVJQM/LE23aOE3lVdPcijwh+0w47Dbo84+9qNpZyPsqTRQLICUUJY953QuSqPRv111UKDRBpa8rmQ28mCxcjObvkkTV8HJbmRG1C2UVnO4Lbwlync6d8pfAzS2VTNrvKjuzH8+lZBNddHqAqE6a/QP3I0xj4s9UMRbGn8O/IfMPRiyV1XTPsTytifBvlk0aYu/1GZKyQ0oJvMYyP+HpRjhxGqRCqtp9ssB7rGZOQNYoGm05256Rp+yeXTt4mvb9tKWBkh9v5Xr1x6WNPeJjPeJfA0F/fEUTaf04yBkegFiqMynB8yhyqqlSq3JAsZfPI6oNyU9kbqFg3Z2Xe6/jCU2c216HQnoLzboMOEnRQYEYN6e0nXzPFXt/KchHCNkZA2oq9/qzo/dJ+14IjhWXTVT5dGo+OyinrDFl8cvwZ+JQYhrtNj8fUslUM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5322.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39850400004)(38100700002)(5660300002)(122000001)(26005)(186003)(8936002)(8676002)(2906002)(478600001)(52536014)(316002)(86362001)(7696005)(83380400001)(71200400001)(110136005)(4326008)(54906003)(55016002)(6506007)(66446008)(64756008)(9686003)(66946007)(66556008)(66476007)(53546011)(33656002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?isRzBLNkQQRsjZbNm0z52kKchdZB2AdyKKChsCkaIV/LqC06q5oEL74X8Iq5?=
 =?us-ascii?Q?/C2rr0AvwrUaFjZ2eCHozzqC4OKRGVjhJ8y+Vd9Ia4yRtkGusrTIFjhJR/Vc?=
 =?us-ascii?Q?udnY39Auy7qX3E/+uaKq80GqSPstGcRQ3coNqIBC+NQtzRwBZt1fAWsGSjMc?=
 =?us-ascii?Q?mPvFxdtzZJzs8DuR6vI5t1VdWVrJ4SvHVsSzAu/J9gGnhr+q9KuqBMH9/JRV?=
 =?us-ascii?Q?wVntvg7cJB/aXARWHDpHWed0XM/DOSf7VTev6rf8Qv/oywzS/N/prDW9r0Rz?=
 =?us-ascii?Q?SVxt3RQzIbIUfnGvZlpZYGYo+MAFRe73J3psMb8y6fvZ6baoiD1/ltX+Bldo?=
 =?us-ascii?Q?jyLsVNvMVgwXmh/pCCg6ptibxTf5YEGyR70CECq8gpRySa1dXm0eviekIM9g?=
 =?us-ascii?Q?gJquOrp7d7pAfxMIkmjFoWEdQD4OSCZSwDjc034QrnhT7vgfiXDkEBRaeSkj?=
 =?us-ascii?Q?VBMVgyu87fefiKkrQsuMx+AFYbXXVtNvFrY8D+RjALCpETQ5v8LTXrvBZP8v?=
 =?us-ascii?Q?yU95SvdVKaeuS099bkO3BzexSJQfLSTouxZqPeXLWD4BcP1JjiCgv1i/EbZc?=
 =?us-ascii?Q?PIYd3lPCRzWBO9Al2DQi3IFBneZFr/TfS2v3G8o2C/ShlLDGAywg/RasE1km?=
 =?us-ascii?Q?zYOofuFnv0wcEEvV9O5pLOaJaAxpN3axw6vNvJNshO1BTr3pWBQGv+M+377U?=
 =?us-ascii?Q?yTU2OcXEegS9zd0aD9q6bqTyDJ4eQ3Jf6rXLGn1yXgTqUiZY0LWcBIrpjBcA?=
 =?us-ascii?Q?FVbmH5bc830NqXYS9Weelyymu1uy8UkT9Vwvwz4o7+jlgM5YuhIOQKgUgiSx?=
 =?us-ascii?Q?AuH0ZhFBQNXqOIvfSVZVQZD06LLZuZPKXErddneRQeFkbsIMaus/qgJyeq3n?=
 =?us-ascii?Q?WiNPmOZX2E+JHHHIjLo/uJL9Px4ofMC/unzG3AiHvSus+r003bESL62E1JD+?=
 =?us-ascii?Q?8eDSOaujYmu+f243O/ryqeZUQXGn255qGJGrTqLw0gOtbB4O17nH9+iriWab?=
 =?us-ascii?Q?49IrcTm6RmpNjWSyR8LHGZ0dSu2N8Je7MTQ5viF9CsJ2wMzmyIEGqWxnas16?=
 =?us-ascii?Q?4gXAvOkD3oAKx8rr/ak5ofQIUb49ZyzkSOW3UK1bZ8ROnQ4gJT82S8UdZfHZ?=
 =?us-ascii?Q?jduIcMofVIiQSWOEsVWYJPhjCcFE/KJqG5GOr3sUjVuTYmjIS/bj67XTVNea?=
 =?us-ascii?Q?zRFKn1S4iB1MxmpgTdYHCRNDPJse9xQIvUBGXy0qo6Pi0+8npKL9yRguHaf+?=
 =?us-ascii?Q?xbCuzxS7ZANsnF+A/MzfQx6NUl4OBbo91EoZD8WXfjRijBWEKTCKQFn05ObT?=
 =?us-ascii?Q?A/JNRfBlGzIK4te2+7LQTsZx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5322.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27078ea8-922d-49a0-9241-08d8ff2270e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 08:51:05.9922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZg1NF//UP4FriLxQTNFLJ9KqXfs5d+Ue645wTqIvyfiV2duZt7+QFqhFrjc5toE5rNeBmQaYCmQlz1eyzV1hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn, Michael,

Just a friendly reminder to have a look at this patch.

Regards,
Sahil Malhotra

-----Original Message-----
From: Sahil Malhotra <sahil.malhotra@oss.nxp.com>=20
Sent: Tuesday, March 30, 2021 8:20 PM
To: shawnguo@kernel.org
Cc: Sahil Malhotra (OSS) <sahil.malhotra@oss.nxp.com>; Sahil Malhotra <sahi=
l.malhotra@nxp.com>; Michael Walle <michael@walle.cc>; Leo Li <leoyang.li@n=
xp.com>; Rob Herring <robh+dt@kernel.org>; moderated list:ARM/FREESCALE LAY=
ERSCAPE ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:=
OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.or=
g>; open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ls1028a-rdb: enable optee node

From: Sahil Malhotra <sahil.malhotra@nxp.com>

optee node was disabled by default, enabling it for ls1028a-rdb.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 41ae6e7675ba..1bdf0104d492 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -274,6 +274,10 @@
 	status =3D "okay";
 };
=20
+&optee {
+	status =3D "okay";
+};
+
 &sai4 {
 	status =3D "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1028a.dtsi
index 262fbad8f0ec..fb155ac192b1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -92,7 +92,7 @@
 	};
=20
 	firmware {
-		optee {
+		optee: optee  {
 			compatible =3D "linaro,optee-tz";
 			method =3D "smc";
 			status =3D "disabled";
--=20
2.17.1

