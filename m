Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5012E4146F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhIVKsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:48:19 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:20102
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234834AbhIVKsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:48:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3UFi1AKQ+LfU2ShwtKqIDWMHMQXDIkU4q5PhWUa8e4wM9GY+Kjp5MMXZZbS6YsdTtetdTrT7+SUH2cP7eILeniSOr5X8QH7ywS+vdvdyFYFCsKFXQZLTdZEfw1HcmgqkWh8iHUPf/VxqicIDcVGDXwRFJqgAgOXlBEhgQrW3jaZfY5jf7gJnAvRtOEI0kAQoQGvN8h4HV3qiUpORwAQdQAoN+ZevvHnN/+RqpibwNvWiKjhVcPA91d/3lAEDju3G4ncYXqjQhLCu6RxPGv9ZAxu7bBCozJCA4GHPYnVlic+iFQyiCZ8RwR4UuZ54QEz9xkmzX2GRDew3TQIVSPjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=B+hquwjSJnGOqtyUksZCd8dYPQH3OBTovq8lTpxbkG0=;
 b=oQbX+mYZzZ1lo8kUJVQQpwm+SiOxJPPFKODHzlIUf+qEKWU0mCNJiobSNgyYJIc6VnY3l1hRdo02jFLymX/etnxi+bFciICzxpKBVR534OAuL9AFO6Hfg/lXgB08dJDYnYNOaYv/VFgi0lhNkMMUqbq1S+TyW/1hVyjtfvXkjpkRtYrPxqID9Os1OBxBQBkznfU5dOijoRwB9rTD4SP6kiEBD3s4WybjRSNYTKiLi2n6FMl9lXWLMkSsYIN5MH71OIKuheVZcamX1HaRxrJQ+x9xC4wKpXw3kuG9LhpE4CTCZRCtE+sdPuLRcn4/f0XZKd4tFCY/sq0+k46kUKZr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+hquwjSJnGOqtyUksZCd8dYPQH3OBTovq8lTpxbkG0=;
 b=rJWOBvJv0ngvWIeWeeHhwnu2TXRCR7fyLwzG9vtXZjKs8f0cn9hkgZITNQKx9yDzvx9Aec8ZIWITG8x5EkzKc2qdmTiPkNs6T8tSlmjRynE1DbCSbx2NimqRe11e/l8liBtyalP2j0ma4AOG+nGlosHS4hmsMXwT9n3tXE16V5U=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4522.eurprd04.prod.outlook.com (2603:10a6:5:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Wed, 22 Sep
 2021 10:46:44 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 10:46:44 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/6] nvmem: add "cell-type" property to support
 mac-address
Thread-Topic: [PATCH 0/6] nvmem: add "cell-type" property to support
 mac-address
Thread-Index: AQHXpJi4p4XjXxeDlk2j3n5bFlAulquv9NqA
Date:   Wed, 22 Sep 2021 10:46:44 +0000
Message-ID: <DB8PR04MB6795102EA4F614E530DF8B4DE6A29@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 782623ea-ffc2-4782-66ca-08d97db64500
x-ms-traffictypediagnostic: DB7PR04MB4522:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB452254A5298FCAE6202FB7A6E6A29@DB7PR04MB4522.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c5EiUvvm3ttrVppbKVgg7SSfZdba/CN7dRefW6iDwFJ2Ua/JbC0OR4TpX1zElkITkG5EBCjBhhZIFqd6WYrb8TSyFqpGw2OOZTC3c8l1YxYoSk1d1F4v4qElQ/wSTSsjOYhTLvpe8HB06sg83um/xvDXqSeI9K6tmh2bbz6dqgiRRcerFeFlvf3dKemA0yo6unf8Ottr/4V1QtiYUbiQp96Qfs0Qyes1BNiJ9n1N2fbu71hKKErbblaoqqTvxrKQrza8grsvDZHz3IN4o6r+2TqfBtXPN57RIjDzcvktE1VDyKwEA7rXhvq24yO4ij5BenfPk4yZgQFPAuDK6DVpwNQW8qy6iH8CX7URlk/EOdkBCoARjEJjFpFTGCobLO1E+0+mVTAkc91vtFJzqxosjWiqfw097uW+Ep3br/tW0vhu26sTTdt/Ao2dZcaugTSpsHchelkr7ith6f9NiF5fIRJ0FiBns1pdN0vE4ZNN2z3hN8O4SNm38oll5Sn5FIB6kTcICdr483IJLVPgYThFQt4XiTmMhprjS8ftsC0a6Mz0xvrIji5g0GPzD9tgoMJXMDONzbcAroPoaOB6SiVZ/vZquo50W9GSlFKPY9CawQYjVMbJLnDHHx8uCYx9v66aDGNabx2xVuFGMQiBZeYGB7uX6x8NQasIR0goXJQqrJZGeqsTtNQMMJHeseJbp1KkWy6JXBwuyTPf/6twJCKlpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(76116006)(8936002)(316002)(2906002)(26005)(110136005)(8676002)(122000001)(38070700005)(64756008)(66946007)(38100700002)(66556008)(83380400001)(9686003)(7696005)(86362001)(4326008)(6506007)(53546011)(66446008)(71200400001)(33656002)(66476007)(54906003)(55016002)(508600001)(186003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?N09QcjVES3QzaU1wbzlkZ1J3dm4rRnhZL3hPUGpTZEU4VXFpZmZDbzBYclRF?=
 =?gb2312?B?Yy9jb3RURkV4bytTL1JTeGhjWWVpSkVOTGVBTUJ4YVRvUWNsaGhwQ3dKcUZW?=
 =?gb2312?B?eGRmd2szYm9Xc245UkFUL3NBNlhmT0YxYXZTM1UyV1RPMjh1TmdBc2Z1Yjkv?=
 =?gb2312?B?QzJ5dHJHUWcwemw0dHl1TGRyVlkzUGhkT3ZDbjJZcWc1WlQxUzVGOFkxbW56?=
 =?gb2312?B?REplQm9CN3BiaE14ZWg5WS82dms4WGg1akhCMkVOelVFdTEreEVVekhrU2Ja?=
 =?gb2312?B?bzZKZjNJdnBjbEFnU1dWeFFCaGxDT3p3Sy92Z1YyQ0ZLaFFNcUhIdE5LOGZp?=
 =?gb2312?B?eVZaVWlJU1Q1dW85RC83bWMweitGUUdnblhrZmpJSWVuS0RZQUQ5QUpBMDRB?=
 =?gb2312?B?bm9WWnp3R2o5N3l1MG8zYXZ1WHIrUHVBS1YxNTdHNTZXQ3FDd25Ub2hNVFVt?=
 =?gb2312?B?OG9hRWlhUThhK01RNUVvaWhVUjRVRTVWY3ZGQjNoUkpzNUVIRk0wT1N4Znlt?=
 =?gb2312?B?VEdFV3UzOFZ0QTV2V0V0emhBWFg3S2E4cFJZTTAxTXEwUFplT0JKb0lITDMz?=
 =?gb2312?B?SHFnREtDZzlkVDY2QzNlSW9nbGYwOERkaWhDOWVKL3IrWmhXQ3M0dEl6Vkpk?=
 =?gb2312?B?dVM0bXk0NEN2Y0tFZU5wdzJkYjg5WUtFN1k2c0ZWdUV6QTN1MVB0aXRaV0JD?=
 =?gb2312?B?VU1UTkVkWWdqbGxEK1RPRm1NN3d1a1djR24rb3ZpWFowcVl0eExkOTcyV3dL?=
 =?gb2312?B?TUtSWEpEVDkwK1hsN2pUbXpFbG10NHVEMzN3TmNnTkdOL2xmQkw5MTRqUDBt?=
 =?gb2312?B?UUtRc1k4K2lZVzZOeXhQekNtVjFaN1AyanBtOHRTcGJKbm5qbEhFekJYZC9L?=
 =?gb2312?B?cU1iOTB3cWlZTjBvTXVXdC9sSkthTmJpYllxUnpjZkJndkMvUnQvMHhjUlhX?=
 =?gb2312?B?Nk5uelBiN2FFYUdYQ1UranRJRmRCU1I5T0tzUDVlNE1CeWZVZXVJbkRWNXZT?=
 =?gb2312?B?cnBWRGRXYnlJYUM5aHU1UjRIL05mSjRMUVBXL0JtaEI4aFZGTkpQSUdEdHI4?=
 =?gb2312?B?dTRReG9BamtYR1ZjTUlSL1h1RFpjVXlKaGdydmdwVVdtbGhNSVQ0UVNtbFlC?=
 =?gb2312?B?NDh2bnh3SGlmZW9oMG1tdHB1RGRuWkhRbldQTlRqeGk0QkpzWEpWRVZTMjhM?=
 =?gb2312?B?OTU2Y0dES2RzTmxIK21ob2VndlB6YUxmd3ZkaUFuNms1MzlrYmlmd09SbDVm?=
 =?gb2312?B?bEVzaUloT3FMeDluc0lXcWo0eHlLNjNuaHZYZ3FVVmhVcHRqNFpBemRKeEUy?=
 =?gb2312?B?QnBjV2JFdXlXNmlPeGRyM2ljTmtkUXBPcmxaYThXN2MrMEhMRm1YY1oxU2Vq?=
 =?gb2312?B?ODJqTmdZd2ZpekUxeHlrRCsxUVJFVDRBWU9DU04rNkVoT0h2Rm9hTXB2czJz?=
 =?gb2312?B?b2tFbWFucjI0MDQwQXJXR1BsVTFuUnlyWXVGbjFFV3hXL3RCZGJTclJmSjNn?=
 =?gb2312?B?aUh3ZXpnU0VOa3hyT05YQWNEYVhWUElhdzFqaE05TnY2MWJOS1BVMEZxMXlq?=
 =?gb2312?B?Ui9xRTZsKy9jTWtvanJ3eFhTcjB0STIrSjFLdGxMSWZZTVJJUXRxS3Y0M3R3?=
 =?gb2312?B?b1pmTE1LRi9hMTFON2FOMjFxTjRkNXZ5VkMvV3FvaFFxS1dHRk1vaXpjSUw2?=
 =?gb2312?B?dS9ucTg1MXk4WmdSN1I0MndGV295S3p4WEo0WDgvd3crUFlmWWEydFNTM00z?=
 =?gb2312?Q?4fIcXlGRtMxhW3734vMnCOVXJyDsHS0++DoLfq0?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782623ea-ffc2-4782-66ca-08d97db64500
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 10:46:44.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lpna/xJAbFvjOiZ1lmpFP+9aJy8viWX5Mo9HzU74SQqHNMijiHGKjxSRleqtEoZw2ou2KyDbySwN5DngcZV+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4522
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpHZW50bGUgUGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56
aGFuZ0BueHAuY29tPg0KPiBTZW50OiAyMDIxxOo51MI4yNUgMTg6MDMNCj4gVG86IHNyaW5pdmFz
LmthbmRhZ2F0bGFAbGluYXJvLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0Br
ZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsga2VybmVs
QHBlbmd1dHJvbml4LmRlOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggMC82XSBudm1lbTogYWRkICJj
ZWxsLXR5cGUiIHByb3BlcnR5IHRvIHN1cHBvcnQgbWFjLWFkZHJlc3MNCj4gDQo+IFRoaXMgcGF0
Y2ggc2V0IGFkZHMgImNlbGwtdHlwZSIgcHJvcGVydHkgdG8gcGFyc2UgbWFjIGFkZHJlc3MsIHRh
a2UgaS5NWCBhcyBhbg0KPiBleGFtcGxlLCB3aGljaCBuZWVkIHJldmVyc2UgYnl0ZSBmb3IgbWFj
IGFkZHJlc3MuDQo+IA0KPiBKb2FraW0gWmhhbmcgKDIpOg0KPiAgIGFybTY0OiBkdHM6IGlteDht
bTogYWRkICJjZWxsLXR5cGUiIHByb3BlcnR5IGZvciBtYWMtYWRkcmVzcw0KPiAgIGFybTY0OiBk
dHM6IGlteDhtOiByZW1vdmUgdW51c2VkICJudm1lbV9tYWNhZGRyX3N3YXAiIHByb3BlcnR5IGZv
cg0KPiBGRUMNCj4gDQo+IFNyaW5pdmFzIEthbmRhZ2F0bGEgKDQpOg0KPiAgIGR0LWJpbmRpbmdz
OiBudm1lbTogYWRkIGNlbGwtdHlwZSB0byBudm1lbSBjZWxscw0KPiAgIG52bWVtOiBjb3JlOiBw
YXJzZSBudm1lbSBjZWxsLXR5cGUgZnJvbSBkZXZpY2UgdHJlZQ0KPiAgIG52bWVtOiBjb3JlOiBh
ZGQgbnZtZW0gY2VsbCBwb3N0IHByb2Nlc3NpbmcgY2FsbGJhY2sNCj4gICBudm1lbTogaW14LW9j
b3RwOiBhZGQgc3VwcG9ydCBmb3IgcG9zdCBwb3JjZXNzaW5nLg0KPiANCj4gIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL252bWVtL252bWVtLnlhbWwgICAgICB8IDExICsrKysrKysNCj4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpICAgICB8ICAzICstDQo+ICBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaSAgICAgfCAgMyArLQ0KPiAgYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kgICAgIHwgMTAgKysrKysrLQ0K
PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgICAgIHwgIDMgKy0N
Cj4gIGRyaXZlcnMvbnZtZW0vY29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEyICsr
KysrKysrDQo+ICBkcml2ZXJzL252bWVtL2lteC1vY290cC5jICAgICAgICAgICAgICAgICAgICAg
fCAzMA0KPiArKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL252bWVt
L252bWVtLmggICAgICAgICAgICAgfCAgOCArKysrKw0KPiAgaW5jbHVkZS9saW51eC9udm1lbS1w
cm92aWRlci5oICAgICAgICAgICAgICAgIHwgIDUgKysrKw0KPiAgOSBmaWxlcyBjaGFuZ2VkLCA4
MSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IGlu
Y2x1ZGUvZHQtYmluZGluZ3MvbnZtZW0vbnZtZW0uaA0KPiANCj4gLS0NCj4gMi4xNy4xDQoNCg==
