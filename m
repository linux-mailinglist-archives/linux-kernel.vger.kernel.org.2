Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A53FD622
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbhIAJEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:04:38 -0400
Received: from mail-eopbgr1310120.outbound.protection.outlook.com ([40.107.131.120]:30659
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241783AbhIAJEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdOWAfk0koRweF/q2V1ZlJL2mCSiUeASfgjAZQC06Ricqeo3nuK7Y/4bRtaCEGXfcIBzje3ZhCwPHTC56iLTpHtHM1wvfyPrVbAfR3ZadYXdJfKL+KEADV3AFj1oIM8YopVUBX1sZoPu0/9Yac2Dyqyew9PYpFpdkMEmpAjwFLMSXbiihhT14hKRWoZT+5uUI42ksncdnXvhHDlSZYlnxhoY5W6mEXk84bU8OXORW8fYfNKFfvq2SJf7EGQ6rBHNqkVa3HjU8N5+R9tfbn3SJTgW9VwWDEHVAASv2HRffFOrJek+mexiPT43v+ZtPI9ohLwCGZ66MBEw/hstUtqIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR2f0rdn3TURpPvgRooU3gTkDi8DhqpeZVedLUE80+U=;
 b=P/0AWQvVHN5pc2p2fZPDWMnzqTsQ2DrgaMWe2vb4WONaDJb2JotWGHT2TXVQ4Ru/E+oD3Uf4LMVwysPMXNk0HC0GBvsrNlQ56+tYACDiW15TNdhQSJ9rPoham/z+jJ1K3GBcnyNGCKCMqjMVpMk33DjfcRkh1reQZmID+K8cSO9JpablscNj/0PyxI0Gpd0uq/BLRun5zxgC1Wq/KyqBU6P8mL4uasVqOzahkQIAFaq5fXRSkEKYPja71TRheoc0187njwDtZ1iEA2vU2ftoDMTObWtIvKj3lVpzaDZc/WX5N5hhJeKvNp+6cm3i0rwPpPTzBXbutRL0aQ/bpMdCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR2f0rdn3TURpPvgRooU3gTkDi8DhqpeZVedLUE80+U=;
 b=Vhcqqqt339lzQmhMyHfTOoFff9MqGfoRNDUkJZH4eyCBkVzeX8a5IiHcpI+x5KZ0W20ZPuuDm/stEmK3Zzo5mHNI4iGs98yHEhpakp+O5PD91ES6oPp/KH/vQvgmUBqxVvrU89zIjG30gqFKOSEfEVAMHQdIwBTpSJYYe/PzJrYo8mHrnIzj9dk8pqhnR0PFN/iyCn+Kh0r/f0hsB2OTP6kcRIr+Jf0s7nECKqr89KvDDtOS27pMJnGYtoGe7vqnNZKQcGe8n0pK5GVXuEZ6OAP/jqNoSpvEIdIWssAcmB4jCiwFpbOvcEScIMernAkfwK35emY1btoPcCAMzc13dw==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB3683.apcprd06.prod.outlook.com (2603:1096:203:ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 09:03:35 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::81e4:c1:aa1a:aa75]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::81e4:c1:aa1a:aa75%7]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 09:03:35 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     BMC-SW <BMC-SW@aspeedtech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Topic: [PATCH 1/1] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Index: AQHXlAfOpk4IkpKafEKaZAc4PCbzJ6uO0vIAgAAkjtA=
Date:   Wed, 1 Sep 2021 09:03:35 +0000
Message-ID: <HK0PR06MB3380B6BF97DE000002CECA15F2CD9@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210818080518.9491-1-ryan_chen@aspeedtech.com>
 <20210818080518.9491-2-ryan_chen@aspeedtech.com>
 <CACPK8XfrR-m6HOx5VOQ1-AVf0r9-0BKsr019D7T6y9Qd4qL9gA@mail.gmail.com>
In-Reply-To: <CACPK8XfrR-m6HOx5VOQ1-AVf0r9-0BKsr019D7T6y9Qd4qL9gA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: jms.id.au; dkim=none (message not signed)
 header.d=none;jms.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4d00e88-bf7e-484d-72ec-08d96d276164
x-ms-traffictypediagnostic: HK0PR06MB3683:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB368390FCFF385CAD9A5406FDF2CD9@HK0PR06MB3683.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zoLYpuUf3+pjfX1yY0Z2Tv0yQZICUPmJC+KcS3MTv3Kt/sWnzx0lvOTt7uCoqkX6I65TT7yRwBJx6hlOFgNO0f7dR2QFjELsJ36bhIjFPW15l5EhqCEandQn42tjl0Wj9dZHcgWJFWflfrWpZWVr3cg/gIFMQo7LE6RtZ8HtTIYvumFxQxexrc1RXucYjpZvRNtmhlOfHqvi2dbbwTE8L+ODYXsJICPNUWltNEsDB276ke7up57DWlrDHRdQ1w5hX1M6WyaZr0yui+TNXOj+53QGT9U7qgHlLxR94vgNWBFTID4Xu15ta8YFvnrN25c+/Oo7FrRlcSxVntsWLH1WHSSRQj19CJgQ13QaTRjq/jCm8+v22bpPkJFGI3Q9MO0NsZ8CbyU/lMudhScTWkjBRDHRecqL1jLefm+rBlQKwCpB2uVvNBUfflNu72KOI1OiLs8QMPKLaGP0qUPnUgmMZkbo++BdINmpPUr09Jd4MJNLN/EG0HV2NPx2s2Ub7Al3SRM0HFykOvpLK38Rigq4Q/gn7uktzi8lhdm/igX3zfZ5ZYfdEPxhq7TjFDlV8pdfIWjCUwPVdBuhWkdhCNOQsrZP7+WM6KZPtnGMwuKhNFZfiR12tdsoqS6JDoYndB3a7pWeSXLT8BQYNzNHOlUqLxsfbymmn5BWI2Iv7VxQbGK+FGSIavgZ+MUIb4LlbJ78/hHzjMkmdpf4tP4OVzebTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(39840400004)(366004)(5660300002)(316002)(76116006)(2906002)(478600001)(6916009)(71200400001)(8676002)(52536014)(38100700002)(122000001)(38070700005)(86362001)(54906003)(83380400001)(7696005)(4326008)(6506007)(53546011)(8936002)(186003)(33656002)(66446008)(55016002)(64756008)(66946007)(66476007)(9686003)(66556008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWdURTNpQ0hib3VYbjk5dVUrUkxxdTdQRUZwRnJWb3p2WDUxYzZNM3luNFhm?=
 =?utf-8?B?cXhaSmt3S1hqSmg1T2ZjazdHSlErYmFYdlBoemZWOHNGN3BkVE1rN2FHT2x2?=
 =?utf-8?B?dUV3TzluVjZlc3Uwd1lYeXA4STArYUY3VlpkdTI5Z0ZuSm02LzJENTgyY2hn?=
 =?utf-8?B?V3hyTHFZU09lM0dkTGRmRmVrQW1RdUs1S245Um56Q3BMc2VDN0lkcWswNVBJ?=
 =?utf-8?B?S3RyWGNydU1Uczg4WG0yd3IvYmtxemRxSW00cTgrU3YwYlEveHRzQU8veVBt?=
 =?utf-8?B?b2YyT1lMSDUvMGJPaEJGbFAvenpERWNpNFRSZ0RQajBDOVhZc0JKVHdTazNG?=
 =?utf-8?B?aFFHUDF5KzlBNElhVlJtRGh6U0FabWJvUFlLeitiaGl0UTZtblZpNTJTVUtI?=
 =?utf-8?B?Nm1za3EvQU96cmlMRjhIVU9HQVJyUEt2YkRJOTdHNUpQNWxLTmRCZ3phRkpj?=
 =?utf-8?B?YWRVUXZYVy9zQnNsdCtpN3FVa2diVndyandqU1l6aGRUQjhhQ0loQ2Zadk02?=
 =?utf-8?B?MnB6blNiRDEvN21PeDZrc0c5cE1xWFVRSHdEYlIvbXY0SkhKOVZ4WkFjeEli?=
 =?utf-8?B?bHNMT1NneVM2MFZ2NXptMGFxRVRKWlJIV0dYRW5TSFZ4N1B4alYxU0pHTyti?=
 =?utf-8?B?NVQzejBkRUhwdHRuTGtrSFNHTTNWQ3FuWjlKTDQwKzBGcmQ4VEU4Rk1KNFBt?=
 =?utf-8?B?eUY1SndIU040aXRPY1RTNVMwR0YvdFBnZklrcnBrcHd4QzE4SjN6YW5FMytu?=
 =?utf-8?B?NXNZSmZ3VysyclQ0MnNSWXM3M0d6RGdORWQ2MVNUakJiVDEvRVdZNTVaa01r?=
 =?utf-8?B?MDhOWUpJb2Njd29UV2J1aGp5ZWtnbWFEMU9nWktnZ1JoRmdMRWZ0cllQcXBp?=
 =?utf-8?B?cGlhNTViVXd1M3N1dDN2U1NiaU1rYTJTZkNrNXZBUk9Qd053YVQ1Q1JQRTZ1?=
 =?utf-8?B?aFBMWHlnWWlnVHBad0lLUUFWQjJEM0hxUHZSWFd2WVA5ekZOU2p1WG1tY0xn?=
 =?utf-8?B?akxSRFVtQ2VmV2xaWDdhSys0QmlRMHd5enVGU1JkSjlaOGthM1FmVWQ2K2I0?=
 =?utf-8?B?Z3Fodk16OWo3cjlYT0JIalJCSk1kTjNVZGxCUFBHSlRTeHpuNmErdWhjUHBu?=
 =?utf-8?B?aEpwYThFZXdFRFNFOW9UdWVBY29INE1YS3V2Qis0QWVhOFVWeDJCQ0tPZWor?=
 =?utf-8?B?aHF2R1ZrMW80S29DZHJoMS82R2FvT2QrdERaZXdTSWpTM2UxUURzMlVYa0hY?=
 =?utf-8?B?YjJYYnV6alJQRlY5K0xheGNCK2VlaW50NWhtQkd3TU4yQjZZSlpmVVk2SSs0?=
 =?utf-8?B?SW44VnlQNGJPTVZHOHlqSmVSeGNVazlpc1VnZE5VZ0FLck1Zei96M2ljOVdT?=
 =?utf-8?B?K0tzd0c1Z005ZkFybHp6TE5kcGRpMVA3d0MzYlY5TmVQbnUyTXB2WHRsaGlG?=
 =?utf-8?B?Tk13eVU1aGJWKzJpNU5xc2V1ODJ3c0xidWQ5cklJWDIyYzFPTFBKQjNqTU1V?=
 =?utf-8?B?MkZ6OWJ3d1dKa3dQR3hTK0dnc3pBUGdiTmdIUVpiZlVWczFsbmJGVmZaY1Fh?=
 =?utf-8?B?NXFRVTdXalNkQmpDTk5zK3RUWlNwcEdsaUxGQjEzWkRScVhaS3hOYXFlNUZJ?=
 =?utf-8?B?QmpQbTQzMlltd1ozUjhzNjdvcUMrVHBCanBqcFNLOFJtV0xHa3lhM0hGbkpH?=
 =?utf-8?B?K3pJbXRvRUlZWFNYaGVzMkZ5Wlo0ZXplelJTNkpUQnRGRnpTM2tRQ09EVkpw?=
 =?utf-8?Q?kGmjm9mAAIBZbWDI89ndXypeWthJ2/Q8ZORwH86?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d00e88-bf7e-484d-72ec-08d96d276164
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 09:03:35.3521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3FR0A2GeVyGoknsVLnF33QSYEQPNNMSWRqF0a0OUG6ngLsP6iSomFMX5+EWEkbvBjwSl9v+XODF8Imj17ZrsjN3C1RgZh6tAdr89CkfSik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3683
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxA
am1zLmlkLmF1Pg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAxLCAyMDIxIDI6NDkgUE0N
Cj4gVG86IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiBDYzogQk1DLVNX
IDxCTUMtU1dAYXNwZWVkdGVjaC5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0ZQ0KPiA8bXR1cnF1ZXR0
ZUBiYXlsaWJyZS5jb20+OyBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+OyBBbmRyZXcN
Cj4gSmVmZmVyeSA8YW5kcmV3QGFqLmlkLmF1PjsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsg
TGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGNsazphc3BlZWQ6Rml4IEFTVDI2MDAgaHBs
bCBjYWxjdWxhdGUgZm9ybXVsYQ0KPiANCj4gSGVsbG8gUnlhbiwNCj4gDQo+IFRoYW5rcyBmb3Ig
dGhlIHBhdGNoLiBJIGhhdmUgc29tZSBxdWVzdGlvbnMgYWJvdXQgaXQgYmVsb3cuDQo+IA0KPiBP
biBXZWQsIDE4IEF1ZyAyMDIxIGF0IDA4OjA1LCBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBBU1QyNjAwIEhQTEwgY2FsY3VsYXRlIGZvcm11
bGEgW1NDVTIwMF0gSFBMTCBOdW1lcmF0b3IoTSk6IGhhdmUgZml4ZWQNCj4gPiB2YWx1ZSBkZXBl
bmQgb24gU0NVIHN0cmFwLg0KPiA+IE0gPSBTQ1U1MDBbMTBdID8gMHg1RiA6IFNDVTUwMFs4XSA/
IDB4QkYgOiBTQ1UyMDBbMTI6MF0NCj4gDQo+IEkgc2VlIGZyb20gdGhlIGRhdGFzaGVldDoNCj4g
DQo+IENQVSBmcmVxdWVuY3kgc2VsZWN0aW9uDQo+IDAwMCAxLjJHSHoNCj4gMDAxIDEuNkdIeg0K
PiAwMTAgMS4yR0h6DQo+IDAxMSAxLjZHSHoNCj4gMTAwIDgwME1Ieg0KPiAxMDEgODAwTUh6DQo+
IDExMCA4MDBNSHoNCj4gMTExIDgwME1Ieg0KPiANCj4gU28gd2hlbiB0aGUgc3lzdGVtIGlzIHJ1
bm5pbmcgYXQgODAwTUh6IG9yIDEuNkdIeiwgdGhlIHZhbHVlIGZvciB0aGUNCj4gbnVtZXJhdG9y
IChtKSBpbiBTQ1UyMDQgaXMgaW5jb3JyZWN0LCBhbmQgbXVzdCBiZSBvdmVycmlkZGVuPw0KPiAN
Ck0gaXMgaW4gU0NVMjAwIG5vdCBTQ1UyMDQuDQpUaGUgcGF0Y2ggY29kZSBpcyBwb2ludCBvdXQg
dGhlIGlzc3VlLCB0aGF0IG5vdCBvbmx5IGNoZWNrIHRoZSBTQ1UyMDAgdG8gY2FsY3VsYXRlIHRo
ZSBocGxsLCANCmJ1dCBhbHNvIG5lZWQgY2hlY2sgdGhlIFNDVTUwMFsxMF0gYW5kIFNDVTUxMFs4
XSwgaXQgd2lsbCBlZmZlY3QgdGhlIE0gdmFsdWUuDQoNCj4gPiBpZiBTQ1U1MDBbMTBdID0gMSwg
TT0weDVGLg0KPiA+IGVsc2UgaWYgU0NVNTAwWzEwXT0wICYgU0NVNTAwWzhdPTEsIE09MHhCRi4N
Cj4gPiBvdGhlcnMgKFNDVTUxMFsxMF09MCBhbmQgU0NVNTEwWzhdPTApDQo+ID4gZGVwZW5kIG9u
IFNDVTIwMFsxMjowXSAoZGVmYXVsdCAweDhGKSByZWdpc3RlciBzZXR0aW5nLg0KPiA+DQo+ID4g
SFBMTCBEZW51bWVyYXRvciAoTikgPSAgU0NVMjAwWzE4OjEzXSAoZGVmYXVsdCAweDIpDQo+ID4g
SFBMTCBEaXZpZGVyIChQKSAgICAgICAgID0gICAgICBTQ1UyMDBbMjI6MTldIChkZWZhdWx0IDB4
MCkNCj4gDQo+IElzIHRoaXMgdGhlIGNhc2UgZm9yIGFsbCByZXZpc2lvbnMgb2YgdGhlIHNvYywg
ZnJvbSBBMCB0aHJvdWdoIHRvIEEzPw0KWWVzLiBpdCBpcy4NCj4gDQo+IERvIHlvdSBoYXZlIGEg
ZGF0YXNoZWV0IHVwZGF0ZSB0aGF0IGNhcHR1cmVzIHRoaXMgaW5mb3JtYXRpb24/DQpOby4NCj4g
DQo+IFdoZW4geW91IHJlc2VuZCwgcGxlYXNlIGFkZCBhIGZpeGVzIGxpbmUgYXMgZm9sbG93cywg
YXMgdGhpcyBjb2RlIGhhcyBiZWVuDQo+IHByZXNlbnQgc2luY2Ugd2UgaW50cm9kdWNlZCB0aGUg
ZHJpdmVyOg0KVGhhbmtzIGEgbG90Lg0KPiANCj4gRml4ZXM6IGQzZDA0ZjZjMzMwYSAoImNsazog
QWRkIHN1cHBvcnQgZm9yIEFTVDI2MDAgU29DIikNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9jbGsvY2xrLWFzdDI2MDAuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLWFzdDI2MDAuYyBiL2RyaXZlcnMv
Y2xrL2Nsay1hc3QyNjAwLmMNCj4gPiBpbmRleCAwODVkMGExOGIyYjYuLjVkOGM0NmJjZjIzNyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9jbGstYXN0MjYwMC5jDQo+ID4gKysrIGIvZHJp
dmVycy9jbGsvY2xrLWFzdDI2MDAuYw0KPiA+IEBAIC0xNjksNiArMTY5LDMzIEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgY2xrX2Rpdl90YWJsZQ0KPiA+IGFzdDI2MDBfZGl2X3RhYmxlW10gPSB7ICB9
Ow0KPiA+DQo+ID4gIC8qIEZvciBocGxsL2RwbGwvZXBsbC9tcGxsICovDQo+IA0KPiBUaGlzIGNv
bW1lbnQgbmVlZHMgdG8gc3RheSB3aXRoIGFzdDI2MDBfY2FsY19wbGwsIGFuZCBqdXN0IGRyb3Ag
aHBsbCBmcm9tIHRoZQ0KPiBsaXN0Lg0KPiANCj4gPiArc3RhdGljIHN0cnVjdCBjbGtfaHcgKmFz
dDI2MDBfY2FsY19ocGxsKGNvbnN0IGNoYXIgKm5hbWUsIHUzMiB2YWwpIHsNCj4gPiArICAgICAg
IHVuc2lnbmVkIGludCBtdWx0LCBkaXY7DQo+ID4gKyAgICAgICB1MzIgaHdzdHJhcCA9IHJlYWRs
KHNjdV9nNl9iYXNlICsgQVNQRUVEX0c2X1NUUkFQMSk7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYg
KHZhbCAmIEJJVCgyNCkpIHsNCj4gPiArICAgICAgICAgICAgICAgLyogUGFzcyB0aHJvdWdoIG1v
ZGUgKi8NCj4gPiArICAgICAgICAgICAgICAgbXVsdCA9IGRpdiA9IDE7DQo+ID4gKyAgICAgICB9
IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICAvKiBGID0gMjVNaHogKiBbKE0gKyAyKSAvIChu
ICsgMSldIC8gKHAgKyAxKSAqLw0KPiA+ICsgICAgICAgICAgICAgICB1MzIgbSA9IHZhbCAgJiAw
eDFmZmY7DQo+ID4gKyAgICAgICAgICAgICAgIHUzMiBuID0gKHZhbCA+PiAxMykgJiAweDNmOw0K
PiA+ICsgICAgICAgICAgICAgICB1MzIgcCA9ICh2YWwgPj4gMTkpICYgMHhmOw0KPiA+ICsNCj4g
PiArICAgICAgICAgICAgICAgaWYgKGh3c3RyYXAgJiBCSVQoMTApKQ0KPiANCj4gU28gdGhpcyBp
cyB0ZXN0aW5nIGlmIHRoZSBDUFUgaXMgcnVubmluZyBhdCA4MDBNaHouDQo+IA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIG0gPSAweDVGOw0KPiA+ICsgICAgICAgICAgICAgICBlbHNlIHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoaHdzdHJhcCAmIEJJVCg4KSkNCj4gDQo+
IEFuZCB0aGlzIGlzIHRlc3RpbmcgaWYgdGhlIENQVSBpcyBydW5uaW5nIGF0IDEuNkdIei4NCj4g
DQo+IEkgd291bGQgd3JpdGUgaXQgbGlrZSB0aGlzOg0KPiANCj4gdTMyIG07DQo+IA0KPiBpZiAo
aHdzdHJhcCAmIEJJVCgxMCkpIHsNCj4gICAgIC8qIENQVSBydW5uaW5nIGF0IDgwME1IeiAqLw0K
PiAgICBtID0gOTU7DQo+IH0gZWxzZSBpZiAoaHdzdHJhcCAmIEJJVCgxMCkpIHsNCj4gICAgIC8q
IENQVSBydW5uaW5nIGF0IDEuNkdIeiAqLw0KPiAgIG0gID0gMTkxOw0KPiB9IGVsc2Ugew0KPiAg
ICAvKiBDUFUgcnVubmluZyBhdCAxLjJHaHogKi8NCj4gICBtID0gdmFsICAmIDB4MWZmZjsNCj4g
fQ0KPiANCj4gQ2hlZXJzLA0KPiANCj4gSm9lbA0K
