Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640A9423724
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 06:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhJFEi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 00:38:57 -0400
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:58689
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbhJFEi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 00:38:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHcsYgg91Cqpkx8o+Ti9wBOZDu3jxiQ/WQMgFhcZQ63bFgCJOiaLvY9gfgEDxdhtkH0B/b4hbRR5DYW4vYeuKy8ChpImF8JzrEUHOG83WX5gWSyRiZeJyhMRfP0GTBDKeaNYVmRQpMlTQ/pahmaHWZMvcRhnXBQD2W3Z4y5TICjCnvdPzL156RcZLpy2QUspTNXluJYt6u+4ZYARU/e/BfMUAbb2Yq4UmIb6ntH1VbTVULMFAmamLuDyKQ8X0FyDAW7p+MrXcbwdxyZcc6GVIkd4RqHsFR9FTr6RQRfAAmfHWJSt/Z6NDerIcCSqLXEnBqtLWIw6+GCVZKAl3xe2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qco6hdlqcAR3RdbrrBizHkkn5GziKvt4cdZn/CXsTgI=;
 b=c9hAUGqI1Ng2ww9FXQ4KUX2D0NKsDXSBidc66tkmd8ANzMn8HccWZqPEzDHQEC4H0MEWHxWIeyN2Z0zCinBXupLB2OHJjvsZwTrpnTEI7wawg6PUcCq39QfCd1kaodSUQV2CAUd3LZ737vG7zjveV/3foa2vE37tUbu6109Du0zHfXNkK2byNcu/6S2ScuoyHQmHew45M8TlEEIU4sdk8W0HDOASocK9b5W/LHfc6rzD6tqEC7u9ydKOGwiqvmombG3/93tEOSSGvyiMlWWzG3lWRh6bQym7nXSuQUVMLvkbs37FFvp7lrsgUVWzW6tB/gSzMEM8FVX5sRwObMQamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qco6hdlqcAR3RdbrrBizHkkn5GziKvt4cdZn/CXsTgI=;
 b=J9Hb4JqUnZyC/HJhgloRkJOdgcIRUJGDUU9SFKOgCsX0KGyROQki3Es+DD4E7ZWrs1VZBpx4xz4QRCzabH8GnBJzu2x/SQEOITLNNgHa9uUcv2P5Y+mFMBd4R/l5hw2ijxG4DbtXPRsXta3ZMvWdT8zF+Zk5d1oYaw4nbQvNJ/Q=
Received: from SJ0PR02MB8644.namprd02.prod.outlook.com (2603:10b6:a03:3fe::20)
 by SJ0PR02MB8642.namprd02.prod.outlook.com (2603:10b6:a03:3fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 04:36:59 +0000
Received: from SJ0PR02MB8644.namprd02.prod.outlook.com
 ([fe80::b56e:a421:5711:1147]) by SJ0PR02MB8644.namprd02.prod.outlook.com
 ([fe80::b56e:a421:5711:1147%8]) with mapi id 15.20.4566.023; Wed, 6 Oct 2021
 04:36:59 +0000
From:   Piyush Mehta <piyushm@xilinx.com>
To:     Piyush Mehta <piyushm@xilinx.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Srinivas Goud <sgoud@xilinx.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH V2] usb: chipidea: udc: make controller hardware endpoint
 primed
Thread-Topic: [PATCH V2] usb: chipidea: udc: make controller hardware endpoint
 primed
Thread-Index: AQHXqKfGANk7ocKDUUW0VmeorsQa/avFhiAQ
Date:   Wed, 6 Oct 2021 04:36:59 +0000
Message-ID: <SJ0PR02MB864445907305B66580FFE1D8D4B09@SJ0PR02MB8644.namprd02.prod.outlook.com>
References: <20210913140005.955699-1-piyush.mehta@xilinx.com>
In-Reply-To: <20210913140005.955699-1-piyush.mehta@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 486168f4-cda8-44b7-27c6-08d98882ef95
x-ms-traffictypediagnostic: SJ0PR02MB8642:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB8642662236B29A6835E7392ED4B09@SJ0PR02MB8642.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nOtAu+I3nIRAOyhtHY250s7pBQsH2pTRxS+0ac5bT863DYY4fZqhvzlRSjdfaeoQOPb+BiWTDV4/tReU+fTW+xahIhcquXMJEz2zFmVXjfwDc8ieqmiLncXYliUGiF0BWS4VM+kuX+X6oq0LVP3dL4Uwi1ZxtbrV7TUsB374DH7A7tNd6aGTcDQfc6+RuT8/ovhwg3LZqyxDNDCtXWhsgCEyLGA+lh8WGPo2OKK6rqYl6F9Ky9Djfji4JWzoHarDPRacoNbMhMJOwwF9+AqkFy6A+Xhnxy/5nYXh3uwQlnqjTvA9+XS9Z9F8a7/BtzYHiezHXACAby2qhYT8pUTrszRZrRQIMPH5lqgYGGp0i3dWmAxvFoFjx72CNh3GYYLdfvsj0nTXXH9+XQHZXjYqJovz5nVyH3k8zalZCOhqEpUeKLI0k5Moqe1JS0wXG+HxdAWHNH1neMPQIm6qy1duG1E2447PhaSxFA9EoeN62jVXbSdDWMSNAAT4h4WsrzLuaLBLvNN+jLDhCGcteVwVJLX43KXvtYd3XIhQpDkO6sRfkVizH9xpMrhrg799b0IwOP0p+4LU1fUwjrKJGuaGF2GrZ3h6J5B4KVOlbZiQp8+InKoLZMQohpc23atnu3zngIcetszjYZ5OklfWi0q3+V7pXDDL8dhuKFugWM7X2cemNIcUHajkboTa124ZJ6ARN6rif69m0mQ9y5uq0Fuz0vReh/gZG/8peMYWwxZJo2d8RdDQUkTShndso2eWf7kL1WxxgGrLxX1MT4UyHaeGkdO/Ob0wtweRmfgV4dMZEN0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8644.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(110136005)(45080400002)(38070700005)(966005)(508600001)(54906003)(52536014)(55016002)(316002)(4326008)(8676002)(71200400001)(53546011)(38100700002)(6506007)(9686003)(76116006)(66446008)(66476007)(83380400001)(66556008)(186003)(66946007)(64756008)(107886003)(7696005)(33656002)(2906002)(5660300002)(26005)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jQ23V+fAcl2TB9X8TCjjOcDR4eS6HDAhqbF+6AH/L35Dz1w9rkPVpc0iMnRg?=
 =?us-ascii?Q?IvmfzsizsJhTDwIxe/RkJXRcFwXsD4VbCkWH4J+JKIDqfBdLNIgUuR8fTMFI?=
 =?us-ascii?Q?MSzEWrxqMjCBsfDqIOJ8VnR82eR3WYzSWfUqIWNSDm5fN1TGgGvYsBsprHg5?=
 =?us-ascii?Q?S14RyC/pHEF2f+lflnJ5c/kwM5BH6suhrar7uPRadFI+nNuedJPnG0eJFzbN?=
 =?us-ascii?Q?CFedkkRIil6jVm4zqpNmt4Gn9c7Pnx8/Hy+5imnYA8CoU91EdOiJhiehMRdN?=
 =?us-ascii?Q?flR//iExSThO8uLxgQTDz2kgM9kC5EM02eB9TOCyE0pT8SaI2qI6ozntUjmt?=
 =?us-ascii?Q?KWkmjJelWOBg8r6kXvMKinS3GdPmm3QrQJ9pggYepImazgQL9DdBsQpnxdXD?=
 =?us-ascii?Q?PSZ+4CL9IZkN8grI7RsoZE250MMNgVyH/Zx+SY8GVL9YJjM6VmOYFkZLSTrz?=
 =?us-ascii?Q?+ZOdOgeZufp7cajhqM1MNK4qsHUrvzbyxsG2MsQj7ZXt2Xpj0DzlXCSC6BIx?=
 =?us-ascii?Q?p/t2vthTdytGUb7TabtwsV9X4wxoZTfpJ0ikycpq7OUozOkXjlZAEidAHiaI?=
 =?us-ascii?Q?ye3cF5OYYlqsw+MoBV8VpDBK42LlEx4HlAHpdMYAw1hE7hobn5VNgRKK/O5Z?=
 =?us-ascii?Q?CwD/v7QifX8osqriP/tQnWbYCovNgHVrKSb1pjarYffN3akxfiPci/zlD3TA?=
 =?us-ascii?Q?3QTZ1HiGy1XPpemO/lB2hp02z321bOdJOovFWlaQofw6T5L2qsX6PGJPl1FS?=
 =?us-ascii?Q?0zUDf5ZE+lCl5qt21sJARMSluLDd2WTP7yRtOlNNLwGqqAfyTyWtJw/Wp/vI?=
 =?us-ascii?Q?UCqyKLIhKNqArSxCZ83ySHHRDnvpmJuKvjeK5F/Q1BjB4FjJD0uw/A30TGSc?=
 =?us-ascii?Q?OSa3vDmmJbKEOh8nwfI/yqN9BdJ+T+20uyVd69nu164C/3RdGd6VD1GrlN9W?=
 =?us-ascii?Q?UqYTQ98Nmto8vtfPOeL339rKIItMYR+UeGhNdPoXQ8r2vBWJR3TJK6oaV5Ny?=
 =?us-ascii?Q?L1rUTMHUCP/9zAZ0gyAuG4peyw9Zg24QISskfpXQMAw9+yMXjpPlkN4BCU7X?=
 =?us-ascii?Q?wMOSeL+9eyp6smMiGPnxYEBO2RLmtpkVBivowzOR3R+40AsOoXTRCImI4VUp?=
 =?us-ascii?Q?vZeHWtAtOGTmDlyJDJaKJqengU4Z8fPirZxyUVTraXX2CKLT+UKfImwJzP8v?=
 =?us-ascii?Q?obnuXYB4vimjFW70p/FOU53b9pYYoX/r3bhsaQB7Q/VsMY35gPkoZQhC3UQ+?=
 =?us-ascii?Q?KJOW4SLHmWhQAyIWtPRp3mNWxj82HkdmTdtwg9O+r2EN2A5c4+OmnJY5qoVg?=
 =?us-ascii?Q?/TbloLrUXxRzZtCasxC/5HB+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8644.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486168f4-cda8-44b7-27c6-08d98882ef95
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 04:36:59.2757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AGzDbIi5Own7YmIgR9GF7mJU07hwEPqJu2sd2VYV1GWiXUiqftiMsAfcWSrip9Aoaxgh1eIFaFFtGksaY1HRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8642
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping ...

Regards,
Piyush Mehta

-----Original Message-----
From: Piyush Mehta <piyush.mehta@xilinx.com>=20
Sent: Monday, September 13, 2021 7:30 PM
To: peter.chen@kernel.org; gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; git <git@xilin=
x.com>; Srinivas Goud <sgoud@xilinx.com>; Michal Simek <michals@xilinx.com>=
; Piyush Mehta <piyushm@xilinx.com>
Subject: [PATCH V2] usb: chipidea: udc: make controller hardware endpoint p=
rimed

Root-cause:
There is an issue like endpoint is not recognized as primed, when bus have =
more pressure and the add dTD tripwire semaphore (ATDTW bit in USBCMD regis=
ter) that can cause the controller to ignore a dTD that is added to a prime=
d endpoint.
This issue observed with the Windows10 host machine.

Workaround:
The software must implement a periodic cycle, and check for each dTD, if th=
e endpoint is primed. It can do this by reading the corresponding bits in t=
he ENDPTPRIME and ENDPTSTAT registers. If these bits are read at 0, the sof=
tware needs to re-prime the endpoint by writing 1 to the corresponding bit =
in the ENDPTPRIME register.

Added conditional revision check of 2.20[CI_REVISION_22].

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
Changes for V2:
- Addressed Peter review comments - Remove unrelated new-line
- Updated commit message

Link: https://lore.kernel.org/linux-usb/SJ0PR02MB8644CBBA848A0F68323F1AA5D4=
D99@SJ0PR02MB8644.namprd02.prod.outlook.com/
---
 drivers/usb/chipidea/udc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c index =
8834ca6..f9ca501 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -49,6 +49,8 @@ ctrl_endpt_in_desc =3D {
 	.wMaxPacketSize  =3D cpu_to_le16(CTRL_PAYLOAD_MAX),  };
=20
+static int reprime_dtd(struct ci_hdrc *ci, struct ci_hw_ep *hwep,
+		       struct td_node *node);
 /**
  * hw_ep_bit: calculates the bit number
  * @num: endpoint number
@@ -599,6 +601,12 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, st=
ruct ci_hw_req *hwreq)
=20
 		prevlastnode->ptr->next =3D cpu_to_le32(next);
 		wmb();
+
+		if (ci->rev =3D=3D CI_REVISION_22) {
+			if (!hw_read(ci, OP_ENDPTSTAT, BIT(n)))
+				reprime_dtd(ci, hwep, prevlastnode);
+		}
+
 		if (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
 			goto done;
 		do {
--
2.7.4

