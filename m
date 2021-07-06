Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDED63BD6AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhGFMmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:42:21 -0400
Received: from mail-db8eur05on2066.outbound.protection.outlook.com ([40.107.20.66]:42368
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344948AbhGFMat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqC52UNZrmEjTND7K0Tz1NCszDG5PRemhhYpXD9Cp9xG7OJKXGHZd9PbQ6oEQV1xf64InY2gqPUTI2NTRod3T3QwRYehy3WwsxZlER5kkCpg0lNzPuv+K44J6EhE/IGoeU7/gODFffbqQlSzdpNhvXpqbP2LB/9X9c/LIIv9sY2UxJq+qT4jbPK37R5/lbZqA9jvIH25LHUquDf1dOPhM2howcLZspzR4CMLXJ+HgS3jR2eRHMSCpLyzUn+8et8JgXMxNTj1r4FP2myrLVgCqnNC0X+Axfkr1pTqi2WhmTSMsyzyTWvKliNma3VdYcwiDkvcqUQOScZ8IUu/xh3LmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/5U7CT/en+751ykWit08uYtRBDwHEyEAm+m6tZOBAM=;
 b=B1STf05qvXKDnzdSwU2VryjvMgMEfr+sXUrnSbNaInGy/CrWeoCq4q5AqWDfN1vmV8vKgnGo5nwRQDkoPuJly2abHej3IJZSq5c5MxK7PjxPZaSR3Orlwc72M5ghi74tZ0QmLWk2y7+pTRG4o2IuZuSuO6dILvd3VyPOW3RS8tfnM+zFg2E88svYttNW1tHbnH8oOFRjRMLFV4k51azq4eVdnQ+tVxtPJGS8I+Ty24J+CwYWojJo1fUWtgaqzPWUjeLI8ma2ay8agJY0GsgePowFhdQy62I+sAfDKXEUJzVmyxDzm7GnevQTFe9tNfEdF5+r7AxKe8zIjkJLI0e/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/5U7CT/en+751ykWit08uYtRBDwHEyEAm+m6tZOBAM=;
 b=EXBZkuCkhPTgvkrssiPk5swYh97BOgahXvD0UaecTFMJFYihd0zpQtbWftqcocx4WEGKSjCddMoa9XyO6ZlA6wSmjghbeU/t6/6iUQvQwzn8CdDwVQbhD/74XkMffrCVAy/im1Uf2HGPjlLl2ljAm69H9UAwtG/6MjF4mctB3m4=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB5307.eurprd04.prod.outlook.com (2603:10a6:10:1e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Tue, 6 Jul
 2021 12:28:05 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::f5e8:4886:3923:e92e]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::f5e8:4886:3923:e92e%8]) with mapi id 15.20.4264.035; Tue, 6 Jul 2021
 12:28:05 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M platforms
Thread-Topic: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M
 platforms
Thread-Index: AQHW9JtY/Flb1M5HB066RDaFAFubB6s2l3KAgAAW5jCAAAV5AIAAG+iQ
Date:   Tue, 6 Jul 2021 12:28:05 +0000
Message-ID: <DB8PR04MB67958BF70501FB79BFC6F786E61B9@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
 <a35ea181-4beb-31d0-dd97-6d587b642a6e@huawei.com>
 <DB8PR04MB67958A087F20D46867066B2CE61B9@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <7cd02103-66e8-b544-3483-8c6c2134067c@huawei.com>
In-Reply-To: <7cd02103-66e8-b544-3483-8c6c2134067c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa59145d-4610-447d-2da7-08d940798125
x-ms-traffictypediagnostic: DB7PR04MB5307:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5307DACAF0416B56F4D70660E61B9@DB7PR04MB5307.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jcp6L1nZSjrXfhlDSVzmZEu7F9nAvklN/qo1I2p8swT2edgFjokmZFiG9GZNlRIuxiEG/OMXDpVKYpROx7J2JD8kHLM5ViefEMcgEk/th6othQcg1vILAY9SKoCFcPb9t0xaaZAfk7Ie66Y02yfK522Ov3nPIVdwMI1nSZu7tE4BXcUwrZJ4QAxlECU/xega+SERHXtbNgvNdZaG3Pst5q4bslG1iuY3Rre32uy2FJbcwf+po09/MqGwHd5YoU+zR1AEaN2Fl1kgb8cdxTgvGbv4r2ZvMm78SE5mq1z0O0MQh9D4KvQ+EOIISXvgPcYeJ6fbPSQM7FQP/GyPXNAT5KBIuULahXCKJOyZraj+3zx/zwjBOeViDMryxx7nV0nXqh5P0T2Z24Q/A3Z+5EqHIVcC/7zsKtvRSdokF1aLA9Vq++tL5lHwIIGgA2jUauhWsq8lyAejSsxsSS5XJ43HiCaUumr0DSkGKcqNEereDN/ucprb8wm1srtE6zbFtbwXm+l1Xb7cZ2CerJsLpaV4Kr96MVhVPcK0JawdbVffuLS2uJHfjG4S0jSBQGtMKuxIypTdWFZE+XO42dAE81Yc+wG0jJd+EjK4PfDzQH9NyUbdHwWU2YEjm16/oNmrc0uo6QKI9YeLJ4qP//jpsNLiLfAAESuLZEgdENn2wqo4fGPEibRR6H9oiATElBM10fG0lG1Fm3AhTzMigXfsKGVPX/zjR0caIt4jDSAcZ4B8MaSvNFseo6uL+zIw+VXTFroLupLIwydh44S0vQI/RcArXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(2906002)(478600001)(26005)(8936002)(55016002)(7416002)(45080400002)(9686003)(86362001)(33656002)(186003)(66446008)(76116006)(52536014)(66946007)(5660300002)(921005)(38100700002)(64756008)(66476007)(66556008)(54906003)(110136005)(8676002)(6506007)(122000001)(71200400001)(83380400001)(4326008)(7696005)(316002)(53546011)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OFdsbHJUcjAva090WUwwSGRnbXF5Y0ozbzl5T0czdkQ0NGdONmxpRkhwbVNh?=
 =?gb2312?B?eHJWQ2tyaFZPNWY4R25ZMFRiYjdkbi85OUM3ZTBrNHUvQWhsVjJLU3dpNDZP?=
 =?gb2312?B?aEVMUlVua1hoSk9oZEJUUnF3eHRaMGRUMVRBdXg3V3RGNWg2Y2tOL1V6dXpG?=
 =?gb2312?B?V1V5NTA0UlBXc2tKVkpjQnJ5amdpekI3QUVlcis4bmFpYmtycFEwUHJYN2tz?=
 =?gb2312?B?aTVBQWh3eUhTa3BEMHU5b0E3YTgyL1ZOekN2OGxDTXpQdFhpbEx0SzFwQWNp?=
 =?gb2312?B?UjBMSUo2TG1pektwTyt5V0FqTDZXOWZhVWNrQnhqZTY4Tk56bktjbkVvc0R5?=
 =?gb2312?B?TUxHSFRQbW5ZQy90V2QyaUxpU1lUUHhJRjVOTzJZaW1VcjB6SHFPZ0tyK2U3?=
 =?gb2312?B?eGw3d3N4RU5sTlZTOFFaWDJpQUxkeWdGWEdScE11TVJCOTIvU0xIL3EvSHFX?=
 =?gb2312?B?WFRyb1JJaGhzeG1rSjZtNThRelZiT0VFNEVwR1N4L1RQMXUrRHZPSEc1YmZC?=
 =?gb2312?B?Z09tZ0xCbldCcGg1VGhFUzRwRkRab0IxT0lsbXRjMFpzQWY5NHQ1WHljQ2FJ?=
 =?gb2312?B?MEs0UG9wYzAyVEhGa3dpWTJGbTZRUWp6ZlRsdk5uc3hnM3ByLzZTcU1lckRX?=
 =?gb2312?B?T296M2lIbWN6UCtPM2V6ZnVhaE5vM0grZW1FbDNLdXRycGxjTTBuanI3YUlG?=
 =?gb2312?B?a2F4Y2F0VnNCclJ3WFA5WWNvcGwrNW1BSnVURXRIT3U4MTlVRXBxREJ5bCtt?=
 =?gb2312?B?TG1yTHBaMG1INjlBNFlFR2VYRkJUOExpLzNvdEwreXVrd0U1TXZNM0JsdGY3?=
 =?gb2312?B?Q1J1d1Mwb1p3SEpRby9jVEJBenZHRkpKR2pnajB2SEdpenJlQU8rVmFtTWJr?=
 =?gb2312?B?bmpEbWNEd0tlOU1nb3RHRXpMSVBJajJXdWdnUkdKeWlnMVkvZER6eHdEQzRM?=
 =?gb2312?B?RjZVUURrZ3doSDFyZUZnU1Z2SVV2a1BnRXN1ZldvMlBqVUhqZXNsN21EdDZz?=
 =?gb2312?B?d0tYdU1hYkUwejFiVWk0MkVRcTdieTgvZ2xSaDdpcGpBUXMwOVhjWWFxaWYr?=
 =?gb2312?B?QWFSclhHK0tqRFhNQTU1TVZaVFptZmdNNHhVak5VUEJRL211eXJYNlNYdm1u?=
 =?gb2312?B?MEllV0pmZ1lNRG56VTZqSnRVLzRITWpaWWFUOGMyV1pvV0NDeXUwMTc0Z1R4?=
 =?gb2312?B?aWkyVmk0RUhPcVcvR1BzMlBFdnFOekEyb04wWlFqeGhSSDF4SURSMWpGMmlx?=
 =?gb2312?B?SGRaSThWcVZhL2VYN2hVcld3a1RJS3hxRzd3Snk0NVZ3aVg5S1ViMTNyZkRy?=
 =?gb2312?B?VG91bVc3dEY4Q1V6QjhQMFlvdFdNdUdVdjV6Z2xsVFpBWmVXSFFIVjE3WmNj?=
 =?gb2312?B?SEpwT2xSUE1vckJOK1VpZ1dCSkdtUCtXK01pSEFWdHZjWlhsRTdWTk1vNWJ5?=
 =?gb2312?B?Y2RCL1FYYVhCaFlDaXp4TVY5VlFHdDVoUlR0NXRhdyszYm1mRjFQUGl0Umpl?=
 =?gb2312?B?UWZhR1V5TmUvb3dPYjlFNDdldkNtRWpDMVV5OWV2NHJRdGlWUTJydVpOb3BI?=
 =?gb2312?B?aldFeGFlQ1FMMnNaR0pIZ2tEeS92RUZiQUJqK2hwNStXbXU5V3psTVFxRDUr?=
 =?gb2312?B?QjhmWXZNaXdmdE5aQVhJRlA2Z2pRUzZQZGdReUovOWhQcnhrRUdpaGM4TGhY?=
 =?gb2312?B?REhnL2p2TmVHbEVwMWR0Y1RDNkxpNk44dGxZNnlKdGNTdmRLNitNRHl3UWpT?=
 =?gb2312?Q?H5cRQ3msTMrvrKepuCacYO++t1piWMr0CVNawOq?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa59145d-4610-447d-2da7-08d940798125
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 12:28:05.0388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMH8YHKCfZlIrfJO81PWLr/+ku+ioHh4gG/iLDrymdi10B4qpWfaJ6wj1BTS1M5qzlYa/eQaFdAh89YYu1aJgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5307
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMcTqN9TCNsjVIDE4OjA2DQo+IFRvOiBKb2Fr
aW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgd2lsbEBrZXJuZWwub3JnOw0KPiBt
YXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZzsgbGVvLnlhbkBsaW5hcm8ub3JnOyBwZXRlcnpAaW5m
cmFkZWFkLm9yZzsNCj4gbWluZ29AcmVkaGF0LmNvbTsgYWNtZUBrZXJuZWwub3JnOyBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsNCj4gYWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbTsgam9s
c2FAcmVkaGF0LmNvbTsNCj4gbmFtaHl1bmdAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9y
Zzsgcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBm
ZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBr
amFpbkBsaW51eC5pYm0uY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBW
MyAwLzRdIHRvb2xzOiBwZXJmOiBBZGQgSlNPTiBtZXRyaWNzIGZvciBpLk1YOE0NCj4gcGxhdGZv
cm1zDQo+IA0KPiBPbiAwNi8wNy8yMDIxIDEwOjQ4LCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4+
IEhpIEpvYWtpbSwNCj4gPj4NCj4gPj4gSSBoYXZlIGRvbmUgc29tZSByZXdvcmsgdG8gdGhlIG1l
dHJpY2dyb3VwIHN5cyBldmVudCBzdXBwb3J0Lg0KPiA+Pg0KPiA+PiBJZiB5b3UgaGF2ZSBhIGNo
YW5jZSwgaXQgd291bGQgYmUgYXBwcmVjaWF0ZWQgaWYgeW91IGNvdWxkIHRlc3QgdGhpcw0KPiA+
PiBmb2xsb3dpbmcgc2VyaWVzIGZvciB0aGVzZSBpbXg4IG1ldHJpY3MrZXZlbnRzOg0KPiA+Pg0K
PiA+PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZnaXQNCj4gPj4gaHViLmMNCj4gPj4gb20lMkZoaXNpbGljb24lMkZrZXJu
ZWwtZGV2JTJGY29tbWl0cyUyRnByaXZhdGUtdG9waWMtcGVyZi01LjEzLXN5cy1yDQo+ID4+IGV3
cmkNCj4gPj4NCj4gdGUtMyZhbXA7ZGF0YT0wNCU3QzAxJTdDcWlhbmdxaW5nLnpoYW5nJTQwbnhw
LmNvbSU3Q2JmMzU1MTcxMzNjMw0KPiA+Pg0KPiA0OGViZDU4ZTA4ZDk0MDU4Nzg3NSU3QzY4NmVh
MWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzANCj4gPj4gJTdDNjM3NjExNTcwOTky
NzYyNzk4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0dw0KPiBMakENCj4gPj4N
Cj4gd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdD
MTAwMCZhbXA7cw0KPiA+Pg0KPiBkYXRhPVJ6TmFYWnViVHJoTzBNUmwyc0Q0NXY3VmJzMUtnelJX
Q1J5bVRRSUpMWk0lM0QmYW1wO3Jlc2VyDQo+ID4+IHZlZD0wDQo+ID4gSGkgSm9obiwNCj4gPg0K
PiA+IEkgb25seSBuZWVkIGJ1aWxkIHBlcmYgdG9vbCB3aXRoIGFib3ZlIGNvZGUsIG5vIG5lZWQg
dG8gdXBkYXRlIHRoZSBrZXJuZWwsDQo+IHJpZ2h0Pw0KPiANCj4gUmlnaHQsIGp1c3QgdXNlcnNw
YWNlIHBlcmYgdG9vbCBuZWVkcyByZWJ1aWxkLiBTYW1lIGtlcm5lbCB3aGljaCB5b3UgdXNlZA0K
PiBiZWZvcmUgc2hvdWxkIGJlIG9rLg0KDQpIaSBKb2huLA0KDQpUZXN0IGVudjoNCnBlcmYgdmVy
c2lvbiA1LjEzLnJjNy5nZjlhODcwMWM3MDkxDQo1LjEzLjAtcmMxLW5leHQtMjAyMTA1MTQNCg0K
SSB0ZXN0ZWQgb24gaS5NWDhNUSwgaS5NWDhNTSBhbmQgaS5NWDhNUCwgdGhlcmUgaXMgbm8gZnVu
Y3Rpb24gYnJlYWthZ2UsIGJ1dCBJIGhhdmUgbm90IHZlcmlmaWVkIG1ldHJpYyBpbmNsdWRlcyAi
ZHVyYXRpb25fdGltZSIgZXZlbnQuDQoNCkEgbml0cGljaywgdGhlcmUgaXMgbm8gY29tbWEgYXQg
dGhlIGVuZCBvZiAiVW5pdCIuDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KPiANCj4g
VGhhbmtzIQ0K
