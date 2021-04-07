Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AAA35755C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355827AbhDGUAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:00:52 -0400
Received: from mail-eopbgr1410121.outbound.protection.outlook.com ([40.107.141.121]:31508
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348996AbhDGUAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZZgTUN94WTG3HCH1VoS9jF8ExVEhNVWwq70lamymajXMh5rw2vCTIwJ4jHu4Lr7D002rznBylJp+BG29/hW+1S4e2bQrMIvS2+L1bpaEcdHyDqPGLrgX37PFTbHhResbnepiL1xIhvA1jgL+UxAT7tgZn1ovIKlBoUAxFc+k3Fr/8fUCF4goDppJy8Et+TbTuCO2KPOLAdXB3vAVh8wO5iTTB6J5n6ujBk+qy1p0a0mFful+s+dSwAmP+rOSkcmTq9itGMs0TodQ/2MCPppD9FTGdXaKw9sAGzfWIdeiPV6i8CK51IbQSPROurAJ9kfdJdWca9pWfaTOnd6H0kIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNrztfMz5wVkSiezCD+XuZJy4DmeYm/lh6NxcpX0dq0=;
 b=duDTSyiT3WbALPJrG8FZ3t02lVe8taXArEUtMmggOOK9CtUiTQwu7GKbrsigbGGdr5ZmTibtPcUEn9KgaJLpOFYzXNYwl9lg82iXHsLROUk996LhGgRF67Lis4cE30nDzah3NmRxVPFTDvDRuNfFBdg8oX1BaVITt3ZWvD2HHTGn1pFLOuW/wx4TeWQsqv+8LI1HtkhJW8yKneTRRZQxNjBVnLq370EO9PTQjURGuGUozZZnXpfDwnpPgCyg2PclJY4SQeHiEKT62phfcmyCHqUHBSUSIKrdEZwd2OONCz61OxbqnJpXNIy7tHYpyFMCDRWxKO6ydz+c86nIBr1BOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNrztfMz5wVkSiezCD+XuZJy4DmeYm/lh6NxcpX0dq0=;
 b=hZpJnLQ2DDoPcRmj0+M5ES2vLZyUTEgdxoeI1RLuWPE1quy4opr6Z0k5MT17pMErycYpmpbdjhyn8TWNVtLDMmxPyibmuhM2oIXFdx+oc947kxCEQ1jBwGldSajZx8iJqAKQGrfC/T7E3m3zN611U17hRrggk3BLgDY5sEfftfs=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB5058.jpnprd01.prod.outlook.com (2603:1096:604:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 20:00:39 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 20:00:39 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Topic: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Index: AQHXK9TmRDzfnJqVl0Sq9GK4xidseaqpVJQAgAAj8wA=
Date:   Wed, 7 Apr 2021 20:00:38 +0000
Message-ID: <OSBPR01MB4773A83DF7D1CDA4DBFD9E84BA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
 <YG3wRJnootNdV0cc@kroah.com>
In-Reply-To: <YG3wRJnootNdV0cc@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8927843-2415-49aa-c2c8-08d8f9ffd0ed
x-ms-traffictypediagnostic: OSAPR01MB5058:
x-microsoft-antispam-prvs: <OSAPR01MB50581BD7CF4CB08076E40486BA759@OSAPR01MB5058.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qV+cqXyWC40CEqxAPcr5EwJMAvvOwnPytgBKA+gfFplYfoTWd8yIMalbiZDcSMQtPfkZTHbRaVTwWFEO6rp3GQJCQ/5CnU9fR0u02iStljfF4QqZmcDJXae466BlCGHusyAP5D3RTumo3koHkaEYy0OY7HzD9uqAQOazcqkGD3A3W4OTlHhETK4K/EjZYs8ENUdI44g0Hp1UnEDAo+DKRZVp/xSmSH/oBC00AAZV5WKgb41RywhpiYVyysk2m5hBYk9UmPSm5fqQjh+h+bO1KCO/Dq2/MRf923kWpmRbb5neEBjL44X+XgJuWcBpolemMKOwKk4gmzRxZxtkYLT0bsM+r7hbQZnnx/9+u1m1DDJet0T5+MZ20221iAka9DzDxgU11a/StFFzJpn6BppTfE0VxL+xQB9Kf/ctCIBo42N7CXZ3J4LPWe7e6yJXjB9WW0unrvSVmQQ8k7rPbnGJ/gWnkjewL73W4xPZjH+x8j/TordOgCt3IK37srbEEgYvF+8AJ/d4975n2nMc1Hw7zYZFepQ1M7jtnCwtzqXF9UENDmcqQP1z4ptWaZqnfaMs1Rka2mjfoZx0rsjOt8eE6tTRXYUzPm6Wdkm9uAs71y5vWW9bvCae6L5IgikIRb05EOJZojeQhqbt6QMYYTC3Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(64756008)(66446008)(66556008)(83380400001)(66476007)(55016002)(5660300002)(9686003)(2906002)(54906003)(186003)(316002)(86362001)(4744005)(76116006)(38100700001)(33656002)(7696005)(6916009)(478600001)(8936002)(8676002)(6506007)(66946007)(71200400001)(52536014)(26005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CQMdBo7TQLfoiH3pL+W+mn9NyxeGV2+aq6fDOTKh2AzbFafpJ46QrjAKlFbU?=
 =?us-ascii?Q?12WyfZRr9mBvYQDUpYcE0h4j7URaPbrnlDhbmrqMOcH4kmixQJzy0ddfBF09?=
 =?us-ascii?Q?00uGkjiOB7fJ4r8BU0B9m3o7L99tiJGaUZsaAN8j4RzodWdmzENYs+UxsWEb?=
 =?us-ascii?Q?zzIXBiFbwhK4kmpc6fqXeqXsKWezJuRTWZOWZlJXwg/AI5ntQjbo6oaoZmiJ?=
 =?us-ascii?Q?qwmkMl7JPPoIaez6wf0jvrqRGSS6fyGVbfWSKpr16Z02b6VKbNnedkof18Ou?=
 =?us-ascii?Q?MY6y8g+DzQlZWfdYGhJd/9LQWKARNJ8h/YfrW5JQU5WXqlwWAd/OCTzcgiw+?=
 =?us-ascii?Q?1NOkfX0Dl2acFuuLwM0NGnXl1TG6vgAxofetJbMT0JLT1JDJBw3peSC8PpvC?=
 =?us-ascii?Q?vAbu2KUA/YKUXYeUfIEQaj17yI0YI0jVSADW/9LW5k3aTRCbjghv6sWUPljG?=
 =?us-ascii?Q?zm1/Q/Bmp7KTWz9Lr+lLwc6fRy72UQOLZkC7bRhKUCeMw1SPWYmmLYPc/Ymz?=
 =?us-ascii?Q?pe6o4HIJtontg4UHojpSgJGnAJGcFnFlDL3ANCo9ZDu3WQdLgeqUHd1Y/pus?=
 =?us-ascii?Q?olgwnTbF/cEsQ13VO0POOBiBbggYrNhAIXG2FN0ndghqI6GLBBjIq9A5Ogy5?=
 =?us-ascii?Q?2DZTuCgPMFFGz+XxR4NdyhU9R9+7f/lAyKLCzX3MH1bpTJnoaOl6bMNqGyc5?=
 =?us-ascii?Q?gp7D0tFvhgzDIobc/1ZWSm1pdualVgYQXdJncLA83A0tKO8FWMeLsEiDfPDG?=
 =?us-ascii?Q?mD8B5MrQgSovzS4R7jXPLPg/TjnAa9EmkSyCYldsD76tv7Ckh1w026SwwaGr?=
 =?us-ascii?Q?/KayzpCOeGtd/4xiAeH9GKyB2X+Kdx0SkNAPSeM6cx4fMDbYFPfTJCiGjjj7?=
 =?us-ascii?Q?3vCzWG/mxcJLbNHy0GxcCY4n4OCtoAuZgGtD1CLSJNZswGqL88PuPv7yXehY?=
 =?us-ascii?Q?q4PHlK4A4YqHB8TkR4tB2BYMiIdtP/0P3N+s17QWxm393L4OVDcwcsgYu/eo?=
 =?us-ascii?Q?6A2AKJaRW2C4S3NicTDLwOFX9LehNpgJJJQv4A6V3UgY7mCj6VG3VeXPtZL1?=
 =?us-ascii?Q?K92P4jvHA/1fO2t7ugZbeY6LGbU9V8HQQTwa/ExFTFYtPksceofwenobIHef?=
 =?us-ascii?Q?vM97ReDVb1DPLLG00k89fSGrniTxTcDKlhgzRbIu14bpgcfbncritjGXaR4c?=
 =?us-ascii?Q?ifSMCEkavKw3Fy51McpQAn7DJ2EKt4aXZOjsIZz83iqtB+VGP5N8Ani5F9t4?=
 =?us-ascii?Q?xLME4jBYZzpPmWl3yfTtoWTBq34v4FoP0n0kOg/ruKNPbS/IfqMgs1AvWcxU?=
 =?us-ascii?Q?BRqNwiRwyCK9xes/dRlCOFTp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8927843-2415-49aa-c2c8-08d8f9ffd0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 20:00:38.8965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQn23dKzZf0Ppn/f0DX65on7x02DV1jQU81V6HCWogg3JpKuJW2pUlpPSgFxqNixR89HglAS0nZT07j+STpnxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Do you really meen "+" here?  (sorry, have to ask.)
>=20

I don't know. All of our Linux kernel code has GPL-2.0+ and I just blindly =
inherit it.

> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20
> You should not need this as it's a driver, so you should only use the
> dev_dbg() family of print message functions, no need for pr_*() calls.
>=20
I have one call to pr_err in rsmu_init

pr_err("Unabled to register %s platform driver", DRIVER_NAME);=20

