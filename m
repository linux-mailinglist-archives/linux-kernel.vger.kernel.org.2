Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5163FD3A0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbhIAGAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:00:35 -0400
Received: from mail-eopbgr1300135.outbound.protection.outlook.com ([40.107.130.135]:23680
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242128AbhIAGAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:00:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvyBzQgfuooIqUrFMP1/LBAeWjlVzoldaqLNzK6O9SNZXAMduPS4v5DnYob0euE4M8/nfF7rHoKnTCAC/32kLjjZrH8iKtl34nt5y1S9NMDdu5N0WN3kKj1OK1iglUnPzVTyMvXhK7QJtAjAeFTHW26608Yttl4LjjBDDCJKMGeVSe2NgDIQPR6FbWdo9a3TOD+AiLWWZA/rhdhYLlpNj6FDz5NKdR9h+NTwDTCJw7eXfXw7DQgrLDw1PiO/bSYixUoFPwPTQATGAx/3aNX3ZIUAzeuinMmset1PKUsHS7a044N3NYBqJ2+VWA7LLrinOPerB4pX/Ss9aMtt0QNb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gA9STIyP7nCptoxcDPMu9TS5CGFQx+DGgOfvG/X/n7Q=;
 b=ixOYSzxgFvtA2V7t+oOTpgXHrGs/Y+uxECKnrYur7rTG+8HSRXNJKVeQ+wGMCFmGd0fNZBZlAsNIsnySs94V2mql0IHm1mwqAvbiz3ljSX01kr80k4JifVLd7zSIOh1+x/ax1YnT2IEwIfYTn9ubJiMzORd9fNde9VojJ23D7dBGqjdSKKsloA/sLpJijxvppF7bKj9cIvoNsKySgEs4tx7P3pT6eCbkgOvUBsHZRAI+GakUz/fQL8E0Nx4LoAHOvAHoyI1e3zKzr4wudKvyAcVFr5aJRd40vNSD9nVKE17TS4LN+WtcvQaYhq8v6pW1MDSYl3H3oGbusGLCm/OwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA9STIyP7nCptoxcDPMu9TS5CGFQx+DGgOfvG/X/n7Q=;
 b=ek6zC4oh8cQgfbCG3do984dla9XwgmGcW1iqoqv6ykyugt5dF+ipmCzv/I1+pZMuVzrHlSHB1nvhSYKkSV3z+sADDIrcs1tYpVZvGRdNFHJv08Wb6G6SbO/iZr/09CIdMkW6gr0VusF7H4BloGz6IfQdOEHTONx9eaCR2XfxqsgtgcBP8cx8D3nRbxozsFECnXinc6u2BGcICnwJ+lf6P19bM47lN7ZDWje58eOa0o3yViT/0M1LMCZa9RG9CUAN9uiEgc7X+gezsv7LpC2Ry4Zb1APv0+FrxPgquK9bevHoh4BrJuSGmfOTHci0Zh5KOfC3h70REAfEah15Cgr5cA==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB2179.apcprd06.prod.outlook.com (2603:1096:203:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 05:59:31 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::81e4:c1:aa1a:aa75]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::81e4:c1:aa1a:aa75%7]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 05:59:31 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Stephen Boyd <sboyd@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Topic: [PATCH 1/1] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Index: AQHXlAfOpk4IkpKafEKaZAc4PCbzJ6uJ9vYAgATN40A=
Date:   Wed, 1 Sep 2021 05:59:31 +0000
Message-ID: <HK0PR06MB3380C785AB8E35FE3A69BBD7F2CD9@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210818080518.9491-1-ryan_chen@aspeedtech.com>
 <20210818080518.9491-2-ryan_chen@aspeedtech.com>
 <163021182287.2676726.14377450905895813289@swboyd.mtv.corp.google.com>
In-Reply-To: <163021182287.2676726.14377450905895813289@swboyd.mtv.corp.google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e76e09b6-fb00-4603-02a1-08d96d0daada
x-ms-traffictypediagnostic: HK0PR06MB2179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB21791855B6323E932587B46CF2CD9@HK0PR06MB2179.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2AvvZu7Qi9gsQZhheIcoA31jO9ODPNnFtEGb5VppiBrC09z7FOT8PF6tyOFozEWUgyZ/9rnjqkXkkTnXZKi5muGuq61idg3vwyOT9O1z+yR7Pqkajdmbe6rKDoDrGxUMHlALskHQED6aWFjH5Py62bnjmOTyXmj3OhGxFqVNfHn7RxHpyYIp5eLkrpcE4l2IOO7cgdcwu2OoQbcjIk0omNy7kCXE+3kuSQMtvhjBXWD9Jz56h4gR1EF5q0eEHGCyERgLfo8+ZwY0RVHvMng6gogSiHCkYXtLZ6/3B7WiXBsO0GSz5vB0toTxgOybGEg7ISeaTs9tInUB/uOSZJqCBIL35f2cBLjjLkBP1apIC7bB+4dkHF6tpSt/RhyGBL01sDR0eDjBlgsSv2BvBjOkJdYzHd7MyxqN4Rtmdtva4re0xX0iVTZRqa+RhLypod9VNpSh7Nx1kXI/BAY9VaPNTpYy0l+OVAevLHMaXmo9KsR8m+mA8hCS/o5I/IutgagMP39u5YbjEU7X98TwJ9pGg4Xt1SsLXRzl9ky53zCDC+9tH+YY3QWPMuAlO7obUzWBDR9Vie1QtgsHWF88K9Eqa54gKokAkj457lvB1gCzkA6ImgHd5EA6pPC9pAPAZeZybJmFaSDd/g9lAZ0SYcbJr81Z7qjPGUqodcSNekc71FgUuR/PU5qc8Cy7+yXOFG7mYvZnkN8kwftNK2rnoWf82Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(39850400004)(366004)(396003)(38070700005)(316002)(52536014)(8936002)(5660300002)(55016002)(9686003)(8676002)(33656002)(71200400001)(478600001)(110136005)(4744005)(186003)(53546011)(83380400001)(76116006)(66946007)(26005)(64756008)(66476007)(86362001)(66446008)(2906002)(7696005)(6506007)(122000001)(66556008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UThwZFExbXFvTUxNZEhYYVN3c3hRK0dGb3dnd0ZJL1BqY1ZHYzF6NmNjak1B?=
 =?utf-8?B?UWQ2SmNrTUxoclFOVFJJMG14c0dvcGJSNW9hVldyUDZYQVJGdU5oYmtBd01t?=
 =?utf-8?B?SFNqWDdobHJ0WGFJMFNydmx1L3JvQURXdFovRlBmenpwSXdVM1lWRWxyYjVy?=
 =?utf-8?B?Q2Vwd3NoNzlXbHdiTjRaazMwQ1l1V0NETnhIOGlKSFlNMmhYU003d3hDNUJT?=
 =?utf-8?B?VkdYSzVJb0dNeTRpNnlOc21nUEVtdE1zNUFNT3lDZW1xVCtBQmJxZCtnNnBk?=
 =?utf-8?B?Z0tYaHlhaDBnNnhicmVaME9RbERXMzZmL3lEcW55d0orWGxkcUNtbHVsZGF3?=
 =?utf-8?B?RlBOL0xabnJtMHJUUWQ1QmgyZ0ZWa2V3Nm92cnVtTm0zUHE5bm1aMEFsRHc1?=
 =?utf-8?B?amsyZGVpRWROWGIvUG4yMUx5SmRRY0hlUGswc0pQREVHak5hS1BMb1lFRVlz?=
 =?utf-8?B?OWNucWpXcmFYbTQzeXVISHhsR1hOdVNyc0VYY0tFcUJsV0lHYnQ1azJrOHRu?=
 =?utf-8?B?cGc2MDRMSnBIZlg5ZzMwZ2swZjQ4OXk0OFJhamRvTjRyZWlEbkQzK1Z0NnE3?=
 =?utf-8?B?UUxqWEFXNXdWbWcwazhRcFJnVUNRL0syWHRxck96UFRlRUhZSnlQbllDVUxO?=
 =?utf-8?B?MVlEWkZxeVQza2Y3SXNSOFpVMm9xODQ5Z3ZxVEZsRGdnVStmVmdFOEpDaVA2?=
 =?utf-8?B?SFN1OEdqNUtEVER3ZDByc3JxSTB1UEhlRnIydC9EVUI4RDRYeWNVcXM5dG5S?=
 =?utf-8?B?a3doU1JXd2svNnpWWXR1SEh0NGdDc0FSeXZXWGpuR3MyR1pXdFhPcFBQM1BP?=
 =?utf-8?B?Ui82cjFURUt3TXZsQkkwSkxUSTlRaWV5MnE4dlVCV3BZUGdBelpUUjdQVXBz?=
 =?utf-8?B?ZHhKSUF5NXBMNzM3SmNSYjVhbHRVTEVxSnN5V2xKNG1tOXhWaEg2T2JCdDBj?=
 =?utf-8?B?RFpwakc3T0NEUGFZN2hxaURyYnBQbG5uUFpCemN5MTVqYnVEb0QvQlhjbklP?=
 =?utf-8?B?dGxXTUhWZ2dFYkZkVVV6cEo0ajZ1RGh4bXR5TThYVXNuUitUS0JsM1FSZUl1?=
 =?utf-8?B?N0l4bml3amFUbk5lVDhkUVQ4T2pTa010Z1Q0R25IdDhwSktqaVVQTTFuVWZv?=
 =?utf-8?B?NWFOc0w2b2ZXYktHSlN2alBHREhwSTlCTVV1R0h6b3VpK08xRW41V2RoYmR2?=
 =?utf-8?B?RVN3amREME9NOGNoaWo2eUJ0VzdwL3grdHYvY0dDc2pnQ0JPVTEzQnpOdVNX?=
 =?utf-8?B?V2FkM280NlQwaStNZUxESXVwQmFGdzBNUmFPYjRiNDRqV1B0N01uRWs1WWR6?=
 =?utf-8?B?WFEwS0xpODRKclpxRldKUnZUUVJUbmlSbG9iNHdvdG11MjZzSmVFeG9ZeVlZ?=
 =?utf-8?B?UFNMamErVzRDNXlDcTlLOVNuMzhUMUxoMUFsOTEvODk0d1ZMdGpxaks3U3J6?=
 =?utf-8?B?Q1BtZGFtWHFGbVREa2lUemd3VVFjNGtrVkJBTkFWbkF0YmZ2eHFzZ0M1SzFB?=
 =?utf-8?B?aEFwMnoyL0FjYmo1SmZWSWhzUGpDcVdqMGs4RnJzVzFJUFpoU0UvMGNEeEhF?=
 =?utf-8?B?MVlvcTRqUy8yNUUwbXA5YkQxR3Z3VWh2L3h6NGZVZTY3SkpxMlhSRE8wOTNO?=
 =?utf-8?B?Q0J4bEpnZ0JqSmJ5NEJKUG1YaWlMQ29rTFFzZkR5SlpLZ3M1eUozVVpkNktz?=
 =?utf-8?B?Z3V6ZHZYc09icGFFSDJzTEs1cXYyZWVoQXN4aEZLWTBhQnp3R0czc20vNE0v?=
 =?utf-8?Q?eBt4hj0nuGnJTG0ZcL76HPL8HeWB55NUSWFZUby?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76e09b6-fb00-4603-02a1-08d96d0daada
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 05:59:31.6523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWy+L5sm26pNKbzO5T8MV2c079etwX/6xReKE+V/1YqaKstGr6wB6LP2sQNj0AsFVlkWhN0xNRhGyjWrfesIZ3Xu4sp3U/DNAcpoIKhmBn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgPHNib3lk
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgQXVndXN0IDI5LCAyMDIxIDEyOjM3IFBNDQo+
IFRvOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGFqLmlkLmF1PjsgSm9lbCBTdGFubGV5IDxqb2Vs
QGptcy5pZC5hdT47IE1pY2hhZWwNCj4gVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNv
bT47IEJNQy1TVw0KPiA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPjsgbGludXgtY2xrQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUnlhbiBDaGVuIDxyeWFu
X2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBjbGs6YXNw
ZWVkOkZpeCBBU1QyNjAwIGhwbGwgY2FsY3VsYXRlIGZvcm11bGENCj4gDQo+IFF1b3RpbmcgUnlh
biBDaGVuICgyMDIxLTA4LTE4IDAxOjA1OjE4KQ0KPiA+IEFTVDI2MDAgSFBMTCBjYWxjdWxhdGUg
Zm9ybXVsYSBbU0NVMjAwXSBIUExMIE51bWVyYXRvcihNKTogaGF2ZSBmaXhlZA0KPiA+IHZhbHVl
IGRlcGVuZCBvbiBTQ1Ugc3RyYXAuDQo+ID4gTSA9IFNDVTUwMFsxMF0gPyAweDVGIDogU0NVNTAw
WzhdID8gMHhCRiA6IFNDVTIwMFsxMjowXQ0KPiA+DQo+ID4gaWYgU0NVNTAwWzEwXSA9IDEsIE09
MHg1Ri4NCj4gPiBlbHNlIGlmIFNDVTUwMFsxMF09MCAmIFNDVTUwMFs4XT0xLCBNPTB4QkYuDQo+
ID4gb3RoZXJzIChTQ1U1MTBbMTBdPTAgYW5kIFNDVTUxMFs4XT0wKQ0KPiA+IGRlcGVuZCBvbiBT
Q1UyMDBbMTI6MF0gKGRlZmF1bHQgMHg4RikgcmVnaXN0ZXIgc2V0dGluZy4NCj4gPg0KPiA+IEhQ
TEwgRGVudW1lcmF0b3IgKE4pID0gIFNDVTIwMFsxODoxM10gKGRlZmF1bHQgMHgyKQ0KPiA+IEhQ
TEwgRGl2aWRlciAoUCkgICAgICAgICA9ICAgICAgU0NVMjAwWzIyOjE5XSAoZGVmYXVsdCAweDAp
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNo
LmNvbT4NCj4gDQo+IEFueSBGaXhlcyB0YWc/IEpvZWwsIGNhbiB5b3UgcmV2aWV3Pw0KDQpIZWxs
byBKb2VsLA0KDQpTaG91bGQgSSBhcHBseSB0byB0aGlzIHRhZz8gZDNkMDRmNmMzMzBhDQo=
