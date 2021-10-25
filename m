Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CDC439A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhJYPYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:24:38 -0400
Received: from mail-eopbgr1410090.outbound.protection.outlook.com ([40.107.141.90]:27520
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233724AbhJYPYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:24:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu3E4OsPvZMJ0GwZPLpvAX+e6uC8Pszg+lh776oyfSReolnZ7PxzxmDukAxGcdrRZbvRyrJc2WdCoysXDDt06OiN8N9gIeRLM7Z6TBTI4oug7l79kNNxP8808l0KpB8BqlEiAPx0KCcKC/UB9wqN+MbZdYEVUlHly5mse6N6Dmj5FhbJXc/jEHxUdyg4qJtbcSgCoalLvc36MCfco6Ixg43GnaEuNTaOwi4/pMsYfEm+NWS78wyIA/0yJ8URn03qc2gPOvgal7TBrCpmQd+DcjKbKEcj3jKMuPTNZV7useDuHQKdQwRbY2e4azMqBvwCagxEyLGwlLLq96sC2GUiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRrLq1Je6AGq8qesvcmNlnr2/i8eRijVnDGTAuTI/ZY=;
 b=Axmnq2V79vwHVXiAfo4JshpcgFalbzUWV53Wwq1tLOpalrNUp6cQmmqe5+ZU4NlxhB0YU/ZwoJVcNTcczmmGd0GpykrfhYju8Y5C9vqMY4g8lof9LGThgf18RtX+F1r34KiY4RA9caqh34Gs1XdEZFGiPlrFTXnZeN6erYdzWrfH32XoF888iTcrDv0x5eYMYO0A+8hutwi6E+j9yYyGV/rzizLy32VNPuBzDKhJWeesoUmWCBFKqz3ny4C0nEefhKDLtG5YwIL6S2ePKZ3bQlDeo6zjy1/Rh5cVkVMJwKNhTEZP2NaowIA7v9RqX5loFcLVP0nuVM03HUWQx6lPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRrLq1Je6AGq8qesvcmNlnr2/i8eRijVnDGTAuTI/ZY=;
 b=ynp6FJ/3E2NzDffvJTdinzXx2DpQoeQTzYChS+4RQ7b73ebvgabbcS0VmsCHNwC7X8G6+gMVW3yATcq+ul/vOshOI8qrRjPpMddGhV37i3AQl6i+KFl/vEkgD+4u+CtVusPS5vVvrhMWK9+BNyIqtcCM8OfdHByq7xpoaGHIqPY=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB1374.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:da::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Mon, 25 Oct 2021 15:22:11 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 15:22:11 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>
Subject: driver/bug: suspected missing null check in hisi_lpc.c
Thread-Topic: driver/bug: suspected missing null check in hisi_lpc.c
Thread-Index: AdfJtAX2fMFFx03OTqmNb23By5R1KQ==
Date:   Mon, 25 Oct 2021 15:22:11 +0000
Message-ID: <TYCP286MB118803910D5797B4B1B1938D8A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8aa9ebf-aa04-44f5-0227-08d997cb3786
x-ms-traffictypediagnostic: TYYP286MB1374:
x-microsoft-antispam-prvs: <TYYP286MB13745E69957EA7CFD3D279A38A839@TYYP286MB1374.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KAgFikk4ZoW35xD5iIAZ61TJc/eUW1qmXZFvo7H0laQ6r9y5iOwo42w+3BX29Q8FIKK6Bycff9qwyBwCnHDSDFWzIIsAJP4pBvOuf5rUdzB75oKEG01Fe+/W5liYJFu/vNWrjqpc7hH9JjzUbdnhzF+/6EHiaSc4Zp+0aLkElH/S8/VVKm3uM7tMW61ZUtIdhVYciTYvZXsXPAPy7u3wBdEyTyBLQ7W1aR+ik3Y58YWhOp1mtkm+546Hn9xrMZhtYdgD9Bl8NZlG5XCMqghsZXKlDFJafYOCN5Z9dVqbHTmAL7ZrKOlzPxaVu2/VJ2N76xYZIq8qFDNzQ5Mcr5qGFm8CaHe0p/0s8vuFqyruvh7fClMgn1z5QUa/gSwkvPn9vd/hT8R5FFU2tN+g0KdETZ8kzO3sI2OUQkCssaOOkYbF2CsBIqWCjKdpm9XnAph1+zoagSABRrAALFRr/HN24GK0vTWBsHZ4IX39H9i3GL7RUagKodmH9l4xmGTgrpQpGdwHmoFYlpewOm85gBp/ZcxmoaDSqYQM2to1WFlb50aSKa5qj4xzlx9VQAR0Hd4v7YzGLMASwhWdJxKfNkxM8AXR52+nb7yfqY0mGiv4MMbf2UPA7u89/7J8ADm95tDA2UHFMnp/3C/Vn3tIofQFnyn6vMDNh/z2Li0qc4ljfUYS+NrZgNyYJchlBAPHp8JK3Q3OiPhuYHEiNP7Sfb8pOybdpRFpkL3pJFQVd2NeFdRTH3ik+H/N6NZH2ULxBWfq61+Glyqm+thT6uk8BCVqr/c7Ho7AZDCAM/bL0y/sLQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(66446008)(8676002)(8936002)(4744005)(83380400001)(76116006)(5660300002)(122000001)(110136005)(786003)(6506007)(86362001)(508600001)(66946007)(66556008)(66476007)(9686003)(38070700005)(966005)(55016002)(7696005)(33656002)(2906002)(71200400001)(52536014)(186003)(64756008)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vnCiYsdV3M6CLDoHosWIHFpBheXYwrHSm6CivmGXhvdLhR735+M5NlyYotgm?=
 =?us-ascii?Q?dcblshpIKLJ5wieVR8LyUpXmx0dZPbtNd6cwjNl0m/cb+IZQznxD7yDH/YIR?=
 =?us-ascii?Q?RLUHCw0d9fBfB+lSBkHZ5PCL8+yb+DIuu3GtD0IYScXleH85c6BWoMI6LFBf?=
 =?us-ascii?Q?ElyMINFvHWnoBO3c81nKl3LPFXd2v1quEF325u6PNxWF20xV7NKUwtNY+gyw?=
 =?us-ascii?Q?rxlf0GejNSOcd7MjF6/s6uTal3IyigwUcTJA+Tq2vobSwjkTrzQ3hMYfgFrN?=
 =?us-ascii?Q?D//2HXr/am/VgU9178AtRmcBk7S87EosucYP5l6Gs0j+cp8bjh/7+KX/Z5Um?=
 =?us-ascii?Q?oaz8dsUGxifUu7EcZc4VDql4snNG5kqd8therRJr0jAslSFoAlDl9i2G1Zej?=
 =?us-ascii?Q?lw+LxYs998w8KAsKfGAadclXYpSHIWVkZFtz+uw+7Nz2z+0SBbdHfH/lkiqY?=
 =?us-ascii?Q?rRTFEBbxL2qHiDcHQ8GyWNF3HlBgbrsvMw8GCe2pNocnuAQgvq686JyUFeQc?=
 =?us-ascii?Q?VG6RQrx3h/9xaFudRHiMbZ4Cb4Pz/IS5yj1C1+NpE0Wq3py3ePafecuhJuIr?=
 =?us-ascii?Q?mx3RK0eUt53HtjdZlZ9zZgPwppE4/QFR1DVQ/PXFi5fADWrgEfdedUUT9+5V?=
 =?us-ascii?Q?5CFG0ugJwt835q1kV1yhel9BJg1nq5/xoDJGwXXq6Ndjq8+IVcw2zY647lmN?=
 =?us-ascii?Q?bsd/TtmEgz1P8XY/3cftIZIRDeOO/6xH2JzDARh4ypmco0I/zViwFCCehE8E?=
 =?us-ascii?Q?hfbq3lZ56NkW60UgOkzXE9ZsAi768wzAdmqU3rJwRDiU0LrgMpEzoyja4/l/?=
 =?us-ascii?Q?5oAMrDXbPIoduDGKQi8B7d2TAe3SjK/J1Ua1N0m6A08w0pDDH2n4AvxqlKhl?=
 =?us-ascii?Q?OB2WwhdntBkw/GsDaccmU6keRQRIDLa0JuUsByp3YZovVN3Dr7zcXhGKlRdJ?=
 =?us-ascii?Q?iQuesuwq0XXMjdf1LmJKwg0fXalBC0McOGCbDNRleaOu3MDhKGVmcR3Lbtoc?=
 =?us-ascii?Q?gNGg7d65+DZ0Q/lUL41fhHb3BwqCSBALExwfj66jrPSw7wSdn6nh60ss0CeD?=
 =?us-ascii?Q?2E8tM+bGcQM7X8g3CHzKp0Nkz7xR0HG0z1cp0pMJSCYUM7OLi+IOBhJVyd3B?=
 =?us-ascii?Q?9yv9HPd9vkIFQsU6/WwC00gXHwugzhAKwFQ4SPxCsvZtUE8IjMIfkS51AKpT?=
 =?us-ascii?Q?tIph5KXYkjV45Vs0neIgD1IULXlgJnUXmf92/iUX7wThtDaEL1EoYT8dnNEn?=
 =?us-ascii?Q?aLtX/pK4pvWK81DS4J29rmX34W+ksZitCIboa2PcTUVOawNeMDXpTWEqH/LK?=
 =?us-ascii?Q?z8QZBSzksjO8cDdml2020tQPmidFIxf68ddgADen6HuqqMHW2r8eppm5jm88?=
 =?us-ascii?Q?ArfAaHjM58WOmCmvnw6VTP7Cg3ye+hiPYVIg2qyhEL5X9DbfaRJqJVVNyA15?=
 =?us-ascii?Q?0jqZhzMgCsTcxbdBk6/BLP68D51i5hnKwMnymYtMC24feRMK3ufkptcnhVsE?=
 =?us-ascii?Q?NMKvxde44jdkogL3Qf69At3js/qOjFB+qF5tqsWaKnpuGIuwQ5Ow4vOwk6Ng?=
 =?us-ascii?Q?ceQP9nbyGPKI1x7eVJl5+3dV+hD7uocFMV7udkfr321xNlCqB1Xfjq04dVDy?=
 =?us-ascii?Q?dkoid9ZV67NOUf8P/AytplI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8aa9ebf-aa04-44f5-0227-08d997cb3786
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 15:22:11.2801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T60fn9kZVmkiAJVYmAcsA3+TlJoL2t+R4CXRU1X18i287aTEn2VjjXGVKxqAo+L6nDPM7fzYiTw4zIRMyN6Stg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1374
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://github.com/torvalds/linux/blob/master/drivers/bus/hisi_lpc.c#L483

Our experimental static analysis tool detects a null-ptr-reference problem.=
 It could be false positive, we report this to you just in case.

Null check is missing for the return pointer of ACPI_COMPANION at line 483 =
and line 504. It seems that there could be potential null-ptr-dereference p=
roblem at line 488 and line 509. Could you spare some time to have a look a=
t it?

Thanks so much,
Chengfeng
