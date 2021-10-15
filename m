Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C6342FDB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbhJOV7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:59:39 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:36330 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJOV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:59:32 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 19FLvF38024372; Sat, 16 Oct 2021 06:57:15 +0900
X-Iguazu-Qid: 2wGrZzhrwA8Scdq2KG
X-Iguazu-QSIG: v=2; s=0; t=1634335035; q=2wGrZzhrwA8Scdq2KG; m=zZPmKnbtmtOMbMNCsQ+fBZoZClocUhv8PfjydbwVyAg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 19FLvE5h000346
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 16 Oct 2021 06:57:14 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 744431000F9;
        Sat, 16 Oct 2021 06:57:14 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 19FLvELD028192;
        Sat, 16 Oct 2021 06:57:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1A9t5wPuBMwj/JmVji6qKPzcIOy1keWyh+qSc8FMUOUd7wnML86wNnpt1g0SeA6hAboJbgpRsfyH1HXEr5GzEz+CykdWZscSdwsAeY18f+ddFVaq1x1TNYMAzxbVPEmo3r4bwbZUtzTVJ6o6ab4W8dADmVV7g4SR5IxKah0Miiy9PHZ5qav+8S6MWK8w+nku3l6VT4RM3FPJZT9Hunh143PrMa8CfaIY1DCbtn+UtZE/ZRt3qu+q3tmXL8rVoncykbtj4x58Lxi8zeqWNznxEoOYIInBL9AGo30mR41Q7WfLZSJdmiQdgCzqrx/wzRVtM92jYGFpNZnqReceewVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhECLiSLTr0R21uoNX5H+gfbUFqT8Ki9LVlZFqkCvoU=;
 b=V6AeKepgpRfZwJXUE5UtUaElIeN6vlQ5Q7hEJTpXk8wvwxDZW0B0gr22ISxOITHEjUDyQNvv7LESbrfJtNKCesuZ9j9Xvk/tVZU2yamfvITMED1zDyyO0+UelBydAR2A7Mec5Cz7PPV8QE6ZrDpX5Cbt4rYSZIePa9ikQUD8yPzRDsk+ZPKKcA5vW7Zo88WQzfE/TO6SVb2PVFP3v6ZEL3W8KPPxtdD0iwoNjtncKMV2OBP8Ak8q4XYYYRapGbRZIwH7+E4jT0nYVCLjBY3TFKwIKPHyIKGBi62kdPa67xk3bXTJ1g1Pb7jkyGcI8xT66ZkxSUKhYQfgB7M0ff6ioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <yuji2.ishikawa@toshiba.co.jp>, <robh+dt@kernel.org>
CC:     <punit1.agrawal@toshiba.co.jp>, <yuji2.ishikawa@toshiba.co.jp>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] arm64: dts: visconti: Add Toshiba Visconti TMPV7708
 VisROBO VRB board support
Thread-Topic: [PATCH 0/3] arm64: dts: visconti: Add Toshiba Visconti TMPV7708
 VisROBO VRB board support
Thread-Index: AQHXwN2vS/kvB/VxzkiSsXbPd59Kd6vUnVBA
Date:   Fri, 15 Oct 2021 21:57:11 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252AAB3AFBC8B0BCD3A9E1692B99@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20211014092703.15251-1-yuji2.ishikawa@toshiba.co.jp>
In-Reply-To: <20211014092703.15251-1-yuji2.ishikawa@toshiba.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: toshiba.co.jp; dkim=none (message not signed)
 header.d=none;toshiba.co.jp; dmarc=none action=none
 header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bd0be70-e6d4-4502-2c65-08d99026bdb4
x-ms-traffictypediagnostic: TYAPR01MB4718:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB47182BB26F83E17017C40BD292B99@TYAPR01MB4718.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m7GyOrc3prPlOdfBRobjRXsyuhi+kkn5RIIMsBkCc9j7DiUvO578AP9DMfGgv5VfsGJu/ZsIMat8bXDEHm2rBzgC3TlgyTw2/yyQN6+/2KN1aqU47bVk2QQpmB8cjEkn+IPmhhTNscMkIhb2x0N3en0jfYBb3yOsy/R5Rs9vXps30fesq18D60FYkXaCcegI1VMGJk5Q4vOhbMdYEqQZEwjAFhOnmmrRRz005A6lGQKsjVi9eAhb2E74McITY58yez20aPDTaheNRcJ/vPLg+ZVS8gG5KNkT/IsfH1TNdayAcMHWzfcrbcDq9CiF0Ot4OzFRrrxe+SE89FNr6fIDokE5BCBI2hXy0cUo8wQ8HeBBFA3uacDih2Bxkz5nlutZ4Wh1R0499EGUcDfNMSg2Mv864HnXrIvRqsrrmc7lLGlXakswgcm4LwugX1+1wXSj3XzGnfim+bsQ7fXszSvUGhu2eguVog28uqBVZc9NAnmCQyxM7yWlA5xE8mz9AnI+iKXUkKkFA50rLXkZEfhxQYUO7pzPvHVs20YR0dKuiZPAUfBZVzPRBJ8Nn+nJ88gFuojMygWygca1Lt4ZiQBQZSG0k9S4LI7/EXdpVCaLbnaBu5NdMZZ+aEdEIuw6ub7e74uZ3rOZD5T55owEAtU/+YxvYbrIQRww8p5lrF3p+LKj6HQH58UwBGq9aFHhS0xmfcgis2eN+jRU+ryvQRJcZWOu9vlRNFfVj9sqeafi1nTKSvRpBY9d+BCcUPkJW7XwlIdj0rpz9pb6TkYy1o++Uav6OpEvAOWpJUrHrRko8u8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(52536014)(33656002)(8936002)(8676002)(55236004)(26005)(66446008)(64756008)(66556008)(66476007)(71200400001)(66946007)(55016002)(53546011)(6506007)(2906002)(76116006)(86362001)(122000001)(4326008)(316002)(5660300002)(83380400001)(966005)(508600001)(110136005)(7696005)(54906003)(38070700005)(38100700002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STVaSVZYNkNmNVJKWUl6Qzlhdm83ZE56am9PZ2JETk9QU2tHMmdpaVAzbkJJ?=
 =?utf-8?B?WURuNXF3eVZZOHI2TE5pQWpGQUxUYVhUZlFQMjY3dDRERE5iWnJXZk5JdDJ0?=
 =?utf-8?B?Uno1Q01SUE15Ymh6QmMyeitWOG4yTWF4b1JDS2h2M1BJVHpyZ0FuTGEwdDEx?=
 =?utf-8?B?NHk4NEVJQkRheWFuMERvSEVBcXpTemIycFRiVlN2WFZOZHhnbkFhVHNUSXN5?=
 =?utf-8?B?a3pJT25Lcm5INURsMTdDZ201WFkyZUpsZngxeFpBaDh3NGdPNWtjSldneDMz?=
 =?utf-8?B?Vm9MVEdQL2RiQm5PNyswUHJNWTdTS0FVdTJnekVRY2VpT2Z2eWlkaXdsdW5I?=
 =?utf-8?B?azJLS25HVmlzM2JiMWxTc3pzT1M3L2VXaU4rNVdKUTVGRWdickk5QVhJdW5H?=
 =?utf-8?B?OGltK0VwVU9aWktYcTJpUk9QMUhGcFl1bWV2R0I5dzVSTUcyaVE1bHB5azhp?=
 =?utf-8?B?cTU3YXhWRldyRjl6TWlxMzhQSkc5NjJFZGYwOWMvenRzWlgwWStyd210NHJw?=
 =?utf-8?B?eERUOTF3MTR6b1dhM3g3Q2xzL24yOWdHc2dJTzFuLzVXRUtsL1hmYlZPaG9p?=
 =?utf-8?B?U2pYRnlPaHBNZFBiTnF2bTdjWFpqTUFTNmJ3VWsyQm9sTTIxaUVXUUpRRms0?=
 =?utf-8?B?SjVlekZMdGpDSm8vd0tNRTR3Q0FlVUYvcDllRVRmNEtYK1FiYzdhUDlEVHZC?=
 =?utf-8?B?cWNOV3BheW9EZW03TDFGaGkvWDY4QlJ3MHNMMzJLaHZuU1Z6Q0RBMXBWd2tL?=
 =?utf-8?B?K2tRanJRUEhVMTY1YnkyTEEyZkh6UE1aNVJzZUhqT2NtWjNMMDh6eTY0MUNL?=
 =?utf-8?B?TExKOEdaYmw2dWxLUEhoRFMwNStQSGtLMUsxOGdOc2FvTlRycXhCN1FQTUlG?=
 =?utf-8?B?Zi84ZmhVTE9TL1k0L1FQNFpRUUkwM2wybUN4eHE0OW05K0orZ2JIYW11MTFD?=
 =?utf-8?B?c0pzNWZFZitrUVY5ZmpFT3ZGZlJLY2pzd3BnQ0h4U0hHaDZiOUYrd3pQVDJM?=
 =?utf-8?B?V3h1SG85VjFFWWhwdnRvWTBna01EelZ4Q0Y2L25ZZVpKZG1DM0dJZDFBV1FO?=
 =?utf-8?B?QnNXZzF2d2dKRzVOb2Q1OXY0dVk2aEJ0ZmE3NTVHUEt5ZW9KcjJMcU9TajlF?=
 =?utf-8?B?WjhDV2JZVjdPQmR3MEo3aTFJVUlKT3doQmZoY2c1bFZtM1pqZmtSSE92eUdG?=
 =?utf-8?B?WjNFNW1LaTlWVGQ5eFJtWXZRc3hjSmw1bVBWMzh0TU1ES0VDdFNJMU53RUgz?=
 =?utf-8?B?WEcxYlhVU3haZm5QMHhYQk5IRWZTLzhONXBDdGNBNGpISTArN1VvRk56ek1m?=
 =?utf-8?B?T1VuTThjWE9DTi9EQmJCVXFxMW1JVHAxcTRnbVhHaFJFQnhxR3NMWG9Ia2Jn?=
 =?utf-8?B?ZTFnbTJldzNIODN5cnVzUEp2enRudHB3OUszOE1JOExrdEgzZ2M2bE1jR0Rm?=
 =?utf-8?B?RlhLZnNieFIrOElEcDRhQ1REcjFqWGZ0QWk5cVg4MnY4SW40Q1JIa1Rwejly?=
 =?utf-8?B?QnJ0cFovRzIybnBJQjNKZ2cwNzZpN0VXdHVNU3JWK3lSdmY4WEx5UExZbGJp?=
 =?utf-8?B?UCsxSWFrYW5iVmZJTE9iazYzaEdFRmYyVGZSNXQ2UTFGZ1V3UXQrWit1eWVO?=
 =?utf-8?B?SVlJbHBld2ZnbjJGS1I2eUxxVGxmVUxleEw1SUpMMjVLZFRDTTVYeFlUL1hI?=
 =?utf-8?B?Wlh1d0U2NU9Tck5SbFl2SG96VGdWa28vUnVHN0k5S0E0SWoxdXphbElTWVlG?=
 =?utf-8?Q?NWl29YPnUsgtrIiMu6JkRkarh7NiU0lF+va9NQu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd0be70-e6d4-4502-2c65-08d99026bdb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 21:57:11.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZm9YzMOEtkw5IyH4O5JPy6CrqizkLOK6QbVA7BvQXBxIXrHIF9hz1og0v9mIAT1uQhd3lWnPk1iyWDITL/aaBiDPhGBkC/bb+euqoyZSAfb/x0ye4HbZS1P//POznZ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4718
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWXVqaSBJc2hpa2F3
YSBbbWFpbHRvOnl1amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanBdDQo+IFNlbnQ6IFRodXJzZGF5
LCBPY3RvYmVyIDE0LCAyMDIxIDY6MjcgUE0NCj4gVG86IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtl
cm5lbC5vcmc+OyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KX
r++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBDYzogYWdy
YXdhbCBwdW5pdCjjgqLjgrDjg6njg6/jg6sg44OX44OL44OIIOKWoe+8s++8t++8o+KXr++8oe+8
o++8tCkgPHB1bml0MS5hZ3Jhd2FsQHRvc2hpYmEuY28uanA+OyBpc2hpa2F3YSB5dWppKOefs+W3
nSDmgqDlj7gg4peL77yy77ykDQo+IO+8o+KWoe+8oe+8qe+8tO+8o+KXi++8pe+8oemWiykgPHl1
amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanA+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCAwLzNdIGFybTY0OiBkdHM6IHZpc2NvbnRp
OiBBZGQgVG9zaGliYSBWaXNjb250aSBUTVBWNzcwOCBWaXNST0JPIFZSQiBib2FyZCBzdXBwb3J0
DQo+IA0KPiBIaSwNCj4gDQo+IFRoaXMgc2VyaWVzIGlzIGEgZGV2aWNlIHRyZWUgZm9yIGEgbmV3
IGJvYXJkDQo+IHdpdGggVG9zaGliYSdzIEFSTSBTb0MsIFZpc2NvbnRpWzBdLg0KPiBUaGUgYm9h
cmQgc3lzdGVtLCBjYWxsZWQgVmlzUk9CTywgY29uc2lzdHMgb2YgdHdvIHBhcnRzOg0KPiBWUkMg
U29NIGFuZCBWUkIgYmFzZSBib2FyZC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gICBZdWppDQo+
IA0KPiBbMF06IGh0dHBzOi8vdG9zaGliYS5zZW1pY29uLXN0b3JhZ2UuY29tL2FwLWVuL3NlbWlj
b25kdWN0b3IvcHJvZHVjdC9pbWFnZS1yZWNvZ25pdGlvbi1wcm9jZXNzb3JzLXZpc2NvbnRpLmh0
bWwNCj4gDQo+IFl1amkgSXNoaWthd2EgKDMpOg0KPiAgIGFybTY0OiBkdHM6IHZpc2NvbnRpOiBB
ZGQgMTUwTUh6IGZpeGVkIGNsb2NrIHRvIFRNUFY3NzA4IFNvQw0KPiAgIGR0LWJpbmRpbmdzOiBh
cm06IHRvc2hpYmE6IEFkZCB0aGUgVE1QVjc3MDggVmlzUk9CTyBWUkIgYm9hcmQNCj4gICBhcm02
NDogZHRzOiB2aXNjb250aTogQWRkIERUUyBmb3IgdGhlIFZpc1JPQk8gYm9hcmQNCj4gDQo+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vdG9zaGliYS55YW1sICAgICAgfCAgMSArDQo+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL3Rvc2hpYmEvTWFrZWZpbGUgICAgICAgICAgfCAgMSArDQo+ICAu
Li4vYm9vdC9kdHMvdG9zaGliYS90bXB2NzcwOC12aXNyb2JvLXZyYi5kdHMgfCA2MSArKysrKysr
KysrKysrKysrKysrDQo+ICAuLi4vZHRzL3Rvc2hpYmEvdG1wdjc3MDgtdmlzcm9iby12cmMuZHRz
aSAgICAgfCA0NCArKysrKysrKysrKysrDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Rvc2hpYmEv
dG1wdjc3MDguZHRzaSAgICAgfCAgNyArKysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTE0IGluc2Vy
dGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL3Rvc2hp
YmEvdG1wdjc3MDgtdmlzcm9iby12cmIuZHRzDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9h
cm02NC9ib290L2R0cy90b3NoaWJhL3RtcHY3NzA4LXZpc3JvYm8tdnJjLmR0c2kNCj4gDQoNCkFw
cGxpZWQsIHRoYW5rcy4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

