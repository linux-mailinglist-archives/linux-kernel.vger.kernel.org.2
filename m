Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A463B6DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 07:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhF2F3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 01:29:25 -0400
Received: from mail-eopbgr1320103.outbound.protection.outlook.com ([40.107.132.103]:59744
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229969AbhF2F3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 01:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX5lO+KCOjE8OEbtH5oUcacliXhqUicHM/qbSSmtIobvyEpDUTPRHG7+ZeMDBUjjY8PJPovyvSB2RFFXMQlT3KceSJfvOAxC0/RRb7n1zt8yUzEeEk1Uq0lWourCcBketliMuNK45pwzGnKNMbYsLiUWzc+DYY27FW73zBJu+cd/vERlRvKypsIN4/wv66AlI0RJ2vim+YQ775RTcndnrvVRIqH9bZNArBxSTVK9RERaGdylqVlf0SLHFM+HQPyn577b++ruZjwfz2bcqTI44fvZFLNiHgk7EHJJBwPIWdD4ijgPoGS07mJLX+Ly1vb31DEZlTH/kS2t1B9OZ/fFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlegVBv88wEs1ugvOgPB77xnyvlL7r2hhLZaEgu5uyo=;
 b=d3KIBv297SVuccDvyC9IN6BCoqE7OjFsKc5hsz7XPZLks7riPIliiQk3lw5HOZ9cg7e/oMgnKqNbc7wfG4S6L2gnZcNp79gImYe98VYqPy/5S8RdXaTRsfu+jTCaY92uSaB9Dv2sEFjEVm1262iTCVtEMmlAIXZIkGcQjrPVz0hEyz7OyalNdDWGLHI6JEu20YpIF/3lEMc7lCWBKSReD/DkVnK6J+BUcKDIj9Y90a9ymYHwk97hQjEthRDoW3nR+x/weHKl+z7v2LL8blMHgo87E20xyVIYAk6nnwtD2X2k5jkkqPEentbSWSJL6fi/ZbH0VivgSnFtA54R1t4tQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlegVBv88wEs1ugvOgPB77xnyvlL7r2hhLZaEgu5uyo=;
 b=SwvR+W0akUT7z+F5CmaQsDKy/r5r57JtfUrMuM4VFqDSIbqa3/fbDMTminmeN/nhAzaQEUZcPtkTY8fMDcGo4eWgsj455BNrKBL0F6xfiRpH4Co4rlMqoy+eHAntE+Q6huHYyRcT37eZlXWD4g+Ro70klU9JFwkPUf5epeall+hw7tCwEYVrGa+mvcnwBYfvIP7DlUEmkipOXiIK1kCmfZLTRZ3yrQojBMB/6Cs5jr3CcYeqvDKKHcKkxT+guVnEokVK/Hpa0rFZW2hKtf3ihbW6b5uxp4XN4T5k6/qdbl68K0jODWHYQ/GbvQj6MeznG6D649h11XFO9fVO6qUJYA==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2867.apcprd06.prod.outlook.com (2603:1096:203:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 05:26:50 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::486f:6790:7b4c:3ec1]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::486f:6790:7b4c:3ec1%3]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 05:26:50 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
Thread-Topic: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
Thread-Index: AQHXaK0GIwSWBAdj6kWpxS7NyKwlrKsjG/0AgAF/H4CABN5MgIABihKA
Date:   Tue, 29 Jun 2021 05:26:50 +0000
Message-ID: <9CFDB695-1F7C-4B80-8AF9-A591C4D38813@aspeedtech.com>
References: <20210624035821.25375-1-billy_tsai@aspeedtech.com>
 <20210624124428.GB1670703@roeck-us.net>
 <51093C5F-61E2-4155-9C9A-035E330AEA1E@aspeedtech.com>
 <43b0c30c-949a-8a6f-268f-c2a550fca30d@roeck-us.net>
In-Reply-To: <43b0c30c-949a-8a6f-268f-c2a550fca30d@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e40d266-b62d-4546-2fff-08d93abe7f83
x-ms-traffictypediagnostic: HK0PR06MB2867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2867BF1555BA5A4B5C90EFD98B029@HK0PR06MB2867.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vtE/TDWLpDbvwhd4IlGGHutP/0daveNzhmZxHTz3ES5BpC1jX9AhOQX9BdCCXotepWSPr6Xwvycc6kpWmqo0k4iWT73GURXV29kvj0vO0Sxigo8tZ0YCvDm07FaOjNOxrlIQErbDZnc64SCWL34whR6esbT1C0RTwbhgwQFQ2VVTO82pCVT2YfMdP34v33Oxsm7KHJLvXOE64tLOQP6oh89f9XKnvEy6OC4bYe0kJkjogQuH9VU30TVxHXepWpY4BqDWzyeOZOgIsIk0sVrahSFN3c8VzYPjaYRWTfdBGOEv+gYCcQSrlvKtaAfNdPuDZsYxs86eyLWrB4rG66nEEhVgmGIyBqIv2XxxwnltgBTco6WHrNqc18g+ci45OObIRbyqa05fy/f7xPnyK7LK3vXQ0W3oQxUz2g74wqDt3UjmjfdfwneRYVjE3MZj77rwCVqvoCCI5YneoCxYIF96rIaJD4fUKk0E3tTrjaxqF9TaILRu4NSEwd+QV85A1SXQTXMhfJ/6mKVI6UL513z1QrIMjM4T3FROCWOQdfs1rZ1yg1b01424MoHKtwwpE7nfdhCptf8lLUF8Itf7gA+aOYrI65clHmwjsh+ulGh6sBKvSC0keNh4vdNrLkHzibLBELgXBxMP5i9nP2jhW4ODG8iBruLXaxhE1c/Qv18MylE1fo4kJio8qbrjaD/XNFucyh9VafMfq2gzrPPHoyfZqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(136003)(376002)(396003)(366004)(54906003)(33656002)(6506007)(53546011)(55236004)(6486002)(316002)(5660300002)(6916009)(26005)(186003)(83380400001)(86362001)(122000001)(2616005)(66446008)(66946007)(71200400001)(64756008)(66556008)(107886003)(66476007)(2906002)(6512007)(4326008)(478600001)(8676002)(8936002)(76116006)(38100700002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dERkRFVFUWlwcGpOMnQrcE1Qa0xFdndzejFCaHZndk5vUm80ZG9GVkJyTzQ5?=
 =?utf-8?B?YkdSUENDeGN1dWhqV2gxOGxiUHYrbWRCWVpYMTBnUDMrY3NIWU9Hc1hyVDNB?=
 =?utf-8?B?S1JnNnk1enEvUFZ1cG5uVitYWUdYdDZ1NUtmdlJ2aUk5T1ZhRmNHWmRGbG03?=
 =?utf-8?B?TXVvZEtUamp0NEJ0OGV6N0NnTDFwMklHamdaM3dmWEdmNnVCY2F6ZmRWY3hC?=
 =?utf-8?B?VkZaV1I2Smt5V2Y5Y2lKTFNWTmNnbzJhaFpkMG1Lb2VQVEZkd2RKblk2U01J?=
 =?utf-8?B?bDZNWldndXZhbXppZDkzaXNEN3NUR1VoaHp6K0lVeDViUFF5VlZXNTRrQWxZ?=
 =?utf-8?B?SmRvdHFvZVJpcDFicW5EMHdGdUkvK0JlY1R5d3hBLzhVZi9LanFEdTNoVWNL?=
 =?utf-8?B?RGpubXlFWVNmcU1BSmxMUXV5VFV0TnZlQXg1M2tCNjRQTlJGc0YyTEU3YVpY?=
 =?utf-8?B?eWhxajJNenh3RmRocFJhNy83RmlZWSswbWg3SmZHMTk2YVNjc1M0SVd0ZkVV?=
 =?utf-8?B?VXhXUVF6QmpMRjk0QVNzdmZMOHBQcVpHN3pHMGV4K1NUSGdKbWRGZ0tDQ2hW?=
 =?utf-8?B?Qmd6eDdqVUVEaHlFWklsRVRNK3l4K0ExdlQwQXFSZkk5TDZPd0FVYXBBREdN?=
 =?utf-8?B?SzlVTU81SUdiYVNGV2tQbkxXTHRCSFBTNXBBTnByaWtnVC9wdUJRUjR3K1R2?=
 =?utf-8?B?NTFUcXFJRlNGYmh5VzkxYm9tZGVxSHBsV3N1ZHJLM2V6ZC8ySVQrbFZKYlhJ?=
 =?utf-8?B?RHRoYVgrVktJTU5MSFNaeFk5K3FwZU9GNS85MVhhc0VCVkxSNTAxRklOWDlO?=
 =?utf-8?B?NlVUZnB1OEx0aDh6UmRCaU5SN0xxbVZUSVB5czA1N3pIWXhscVZoaE9RZ1Yy?=
 =?utf-8?B?K3NuNk9IcC9zQkVQWmVTWFRLZUVSMG05ZHNzcURYQlVoWU8wdzBnc0xOeXVt?=
 =?utf-8?B?Nzdrc0l5K21Nb0RnV3U4NGZNcjVtcXE1cmpCeVc0ZGhiZzBwNWpUUVdyWENv?=
 =?utf-8?B?eDVaQU1TRXlpaXg3WnVxQi9xazR6aHNxQjhXQlB0Nmo2OE51M05uNml5cHF5?=
 =?utf-8?B?NDB2V2JTMEJ2VmwvUHB3dDRmbFJKMlc5dWk3L2xZN0ZHYTI4MisxdjhEdlQ3?=
 =?utf-8?B?L1NZcHBUbEZ4Y3l3WU1SYnJMV2JNNTdPK0dJVFlRaWd4ck4xa0NwWEh3NitR?=
 =?utf-8?B?L1hUOURiTkJWaTJJVFMzWnBKcTlTZmNLWXl6N0Z2eXhtQTE4V1ZmbTNaOG04?=
 =?utf-8?B?ZHVPMCtTcUtDVmxxbkNFOUxSajlWbVV3WHFvVWdUTzg4R2QrSm5MbkZqRTBH?=
 =?utf-8?B?cmJqbWFsZ1BOOC9GOGcyaGNNNGpMQWlVQksySFozQXpNbzNSLytMc3dwRkU5?=
 =?utf-8?B?V2tlUnp5cUpMTUsrMVBnSHBweEttaWJORnBwTXZaWmhzTk9ZZCtZdzFrZlpD?=
 =?utf-8?B?YUJlUDl2MjlwSGtGdEtRTkZJS0gwOWN6R2pvVHlEREdOKzFjNElRd3BCMGFN?=
 =?utf-8?B?V2U4VlE1YlVDTnRzVWpUQit3cFM4VmdZQVhhK3BxMm9ZYUVKeVh1YmRxSUZR?=
 =?utf-8?B?MzMveTlibTdaK2tLd2R1OTNQbnF0L3BPaXhxdjB1Z3dyZUIvYkt3K1JJRGs2?=
 =?utf-8?B?WW5Qa3YrL1FTOW1TTXhsRTYwZW1QMXhEOXFpUmJ5cjRUeUMydmQ1VVNrUkpl?=
 =?utf-8?B?aDdnLzdJREZXaENDY3AwUTB3REtXdFdET2VSZG1jV1lacXB6TklkN0UvbEVK?=
 =?utf-8?Q?WvT1Jx3P18c9l4i5TO3h+nXFRmmCfcbaGXYWw3h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <572EB470499D0641BAC2F26A78A3E337@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e40d266-b62d-4546-2fff-08d93abe7f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 05:26:50.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvFTO2xmf2WqoMD9/i6N4k2OIsZn6M1SCDBV8defice0OyydurugQzIm5NdaAy71hosUyLDqrMXIPy/8B6i59RImIA23WSNJa8D/QVbtYbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2867
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMS82LzI4LCA5OjU2IFBNLCAiR3VlbnRlciBSb2VjayIgPGdyb2VjazdAZ21haWwuY29t
IG9uIGJlaGFsZiBvZiBsaW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOg0KDQogICAgT24gNi8yNC8y
MSA4OjM1IFBNLCBCaWxseSBUc2FpIHdyb3RlOg0KICAgID4gICA+IE9uIDIwMjEvNi8yNCwgODo0
NCBQTSwgIkd1ZW50ZXIgUm9lY2siIDxncm9lY2s3QGdtYWlsLmNvbSBvbiBiZWhhbGYgb2YgbGlu
dXhAcm9lY2stdXMubmV0PiB3cm90ZToNCiAgICA+ICAgPiANCiAgICA+ICAgPiAgICAgIE9uIFRo
dSwgSnVuIDI0LCAyMDIxIGF0IDExOjU4OjIxQU0gKzA4MDAsIEJpbGx5IFRzYWkgd3JvdGU6DQog
ICAgPiAgID4gICAgICA+PiBUaGUgdGFjaCBzaG91bGRuJ3QgdXNlIGJvdGggZWRnZXMgdG8gbWVh
c3VyZS4gV2hlbiB0aGUgdGFjaCBpbnB1dA0KICAgID4gICA+ICAgICAgPj4gZHV0eSBjeWNsZSBp
c24ndCA1MCUgdGhlIHJldHVybiB2YWx1ZSB3aWxsIGluYWNjdXJhdGUuDQogICAgPiAgID4gICAg
ICA+Pg0KICAgID4gICA+ICAgICAgPiBBIHRhY2hvbWV0ZXIgZG9lc24ndCBoYXZlIGEgZHV0eSBj
eWNsZS4gQSBwd20gaGFzIGEgZHV0eSBjeWNsZSwgYnV0IHRoYXQNCiAgICA+ICAgPiAgICAgID4g
aXMgY29tcGxldGVseSBpbmRlcGVuZGVudCBvZiB0aGUgcHdtIGR1dHkgY3ljbGUgdXNlZCB0byBz
ZXQgdGhlIGZhbiBzcGVlZC4NCiAgICA+ICAgPiAgICAgID4gU28gdGhpcyBwYXRjaCBkb2VzIG5v
dCByZWFsbHkgbWFrZSBzZW5zZSB3aXRoIHRoZSBhYm92ZSBleHBsYW5hdGlvbi4NCiAgICA+ICAg
PiANCiAgICA+ICAgPiBUaGUgZHV0eSBjeWNsZSBtZWFucyB0aGUgd2F2ZWZvcm0gdGhhdCByZXBv
cnRlZCBmcm9tIHRoZSBmYW4gdGFjaCBwaW4gbm90IHB3bSBzaWduYWwuDQogICAgPiAgID4gDQog
ICAgPiAgID4gICAgICA+IFRoZSBpbXBhY3Qgb2YgdGhpcyBwYXRjaCBpcyBsaWtlbHkgdGhhdCB0
aGUgcmVwb3J0ZWQgZmFuIHNwZWVkIGlzIHJlZHVjZWQNCiAgICA+ICAgPiAgICAgID4gYnkgNTAl
LiBJdCBtYXkgd2VsbCBiZSB0aGF0IHRoZSBkcml2ZXIgY3VycmVudGx5IHJlcG9ydHMgdHdpY2Ug
dGhlIHJlYWwgZmFuDQogICAgPiAgID4gICAgICA+IHNwZWVkLiBJIGhhdmUgbm8gaWRlYSBpZiB0
aGF0IGlzIHRoZSBjYXNlLCBidXQgaWYgaXQgaXMgaXQgc2hvdWxkIG5vdCBiZQ0KICAgID4gICA+
ICAgICAgPiBjb25kaXRpb25hbC4gVGhlIGRlc2NyaXB0aW9uIGFib3ZlIHN0YXRlcyAid2hlbiB0
aGUgdGFjaCBpbnB1dCBjeWNsZSBpc24ndA0KICAgID4gICA+ICAgICAgPiA1MCUiLCBzdWdnZXN0
aW5nIHRoYXQgdGhpcyBpcyBjb25kaXRpb25hbCBvbiBzb21lIG90aGVyIGNvbmZpZ3VyYXRpb24u
DQogICAgPiAgID4gICAgICA+IEkgZG9uJ3Qga25vdyB3aGF0IHRoYXQgbWlnaHQgYmUgZWl0aGVy
Lg0KICAgID4gICA+IA0KICAgID4gICA+IEFjY29yZGluZyB0byB0aGUgdGFjaCBtb2RlLCBvdXIg
dGFjaCBjb250cm9sbGVyIHdpbGwgc2FtcGxlIHRoZSB0aW1lIG9mIG9uY2UgY29uZGl0aW9uYWwg
bWVldCBhbmQgdHJhbnNsYXRlIGl0IHRvIHRhY2ggdmFsdWUuDQogICAgPiAgID4gV2hlbiB0aGUg
dGFjaCBzaWduYWwgZHV0eSBjeWNsZSBpc24ndCA1MCUsIHVzaW5nIGJvdGggZWRnZXMgbW9kZSB3
aWxsIGdldCB0aGUgdGFjaCB2YWx1ZSB3aXRoIGVycm9yIHJhdGUuDQogICAgPiAgID4gSW4gYWRk
aXRpb24sIHRoZSBjdXJyZW50IHJlcG9ydCB2YWx1ZSBvZiBib3RoIGVkZ2VzIHdpbGwgdHdpY2Ug
dGhlIHJlc3VsdCB3aGljaCB3aWxsIGVubGFyZ2UgdGhlIGVycm9yIHJhdGUuDQogICAgPiAgID4g
QWN0dWFsbHksIHRoZSB0YWNoIHNpZ25hbCB3b24ndCBiZSBhIGNvbXBsZXRlIDUwJSBkdXR5IGN5
Y2xlLCBzbyBib3RoIGVkZ2VzIG1vZGUgaXNuJ3QgcmVjb21tYW5kZWQgZm9yIHRoZSBmYW4gdXNh
Z2UuDQogICAgPiAgID4gV2l0aCByaXNpbmctdG8tcmlzaW5nIG1vZGUgdGhlIHNrZXcgdGltZSBv
ZiB0YWNoIHNpZ25hbCB3aWxsIGFsc28gZWZmZWN0IHRoZSBhY2N1cmFjeS4NCiAgICA+ICAgPiBU
aHVzLCB1c2luZyB0aGUgZmFsbGluZy10by1mYWxsaW5nIG1vZGUgaXMgdGhlIGJldHRlciB3YXkg
Zm9yIGEgZmFuIHRhY2ggbW9uaXRvci4NCiAgICA+ICAgPiBCdXQgZm9yIGZsZXhpYmlsaXR5LCBJ
IHRoaW5rIHVzaW5nIGR0cyBwcm9wZXJ0eSB0byBjb250cm9sIHRoZSB0YWNoIG1vZGUgaXMgYmV0
dGVyIHRoZSB1c2VyIGNhbiBjaGFuZ2UgdGhlIG1vZGUgdG8gYWRhcHRlciB0aGUgbW9uaXRvciBk
ZXZpY2UuDQogICAgPiAgID4gDQoNCiAgICA+ICAgVHJ5aW5nIGFnYWluLCB1c2luZyBteSBvd24g
d29yZHMuDQoNCiAgICA+ICAgQSBmYW4gbm9ybWFsbHkgcHJvdmlkZXMgdHdvIHNob3J0IHB1bHNl
cyBwZXIgcmV2b2x1dGlvbi4gVGhvc2UgYXJlIHNob3J0DQogICAgPiAgIHB1bGVzZXMsIGFuZCBv
bmUgZG9lcyBub3QgdHlwaWNhbGx5IHRhbGsgYWJvdXQgImR1dHkgY3ljbGUiIG9yICJ3YXZlZm9y
bSINCiAgICA+ICAgaW4gdGhpcyBjb250ZXh0LiBUaGUgZHJpdmVyIGN1cnJlbnRseSBjb3VudHMg
Ym90aCBlZGdlcyBvZiB0aG9zZSBwdWxzZXMuDQoNCk91ciB0YWNoIGNvbnRyb2xsZXIgd2lsbCBj
b3VudCBob3cgbWFueSB0YWNoIGNsb2NrcyBpbiB0aG9zZSBzaG90IHB1bHNlcy4NCkluIGJvdGgg
ZWRnZSBtb2RlIHRoZSBjb3VudGluZyBwZXJpb2Qgb25seSBoYWxmIG9mIHRoZSBwdWxzZS4gVGh1
cywgaXQgaXMgbW9yZSBzZW5zaXRpdmUNCnRvIHRoZSBzaWduYWwgcXVhbGl0eSBvZiB0aGUgc2hv
dCBwdWxzZSB3aGVuIHVzaW5nIGJvdGggZWRnZXMgbW9kZS4NCg0KICAgID4gICBBc3N1bWluZyB0
aGF0IGEgZmFuIHJlcG9ydHMsIHNheSwgMSwwMDAgcHVsc2VzIHBlciBtaW51dGUsIHRoZSBoYXJk
d2FyZQ0KICAgID4gICB3b3VsZCByZXBvcnQgYSBlZGxlIGNvdW50IG9mIDIsMDAwLiBUaGlzIHNo
b3VsZCB0cmFuc2xhdGUgaW50byA1MDAgUlBNLg0KICAgID4gICBJIGRvbid0IGtub3cgaWYgdGhp
cyBpcyBjdXJyZW50bHkgdGhlIGNhc2UgaW4gdGhlIGRyaXZlcjsgaWYgbm90LCBpdCB3b3VsZA0K
ICAgID4gICBiZSBhIGJ1Zy4gRWl0aGVyIGNhc2UsIHRoZSBzdWdnZXN0ZWQgY2hhbmdlIHdvdWxk
IHJlZHVjZSB0aGUgcHVsc2UgY291bnQNCiAgICA+ICAgcmVwb3J0ZWQgYnkgdGhlIGhhcmR3YXJl
IHRvIDEsMDAwLiBJZiB3ZSBhc3N1bWUgdGhhdCB0aGUgZHJpdmVyIGN1cnJlbnRseQ0KICAgID4g
ICB0cmFuc2xhdGVzIHRoaXMgY29ycmVjdGx5IHRvIDUwMCBSUE0sIHRoZSBzdWdnZXN0ZWQgY2hh
bmdlIHdvdWxkIHJlc3VsdA0KICAgID4gICBpbiB0aGUgZHJpdmVyIHJlcG9ydGluZyAyNTAgUlBN
LCB3aGljaCB3b3VsZCBiZSB3cm9uZy4NCg0KICAgID4gICBTbyB0aGVyZSBhcmUgdHdvIHBvc3Np
YmlsaXRpZXM6DQogICAgPiAgIDEpIFRoZSBkcml2ZXIgY3VycmVudGx5IHJlcG9ydHMgMSwwMDAg
UlBNIGluIHRoaXMgc2l0dWF0aW9uLiBUaGlzIHdvdWxkIGJlIGEgYnVnDQogICAgPiAgICAgICB3
aGljaCBuZWVkcyB0byBnZXQgZml4ZWQuDQogICAgPiAgIDIpIFRoZSBkcml2ZXIgY3VycmVudGx5
IGNvcnJlY3RseSByZXBvcnRzIDUwMCBSUE0uIEluIHRoaXMgY2FzZSwgdGhlIHN1Z2dlc3RlZA0K
ICAgID4gICAgICAgcGF0Y2ggd291bGQgaW50cm9kdWNlIGEgYnVnIGJlY2F1c2UgdGhlIGNvZGUg
aXMgbm90IGFkanVzdGVkIGZvciB0aGUgcmVkdWNlZA0KICAgID4gICAgICAgcHVsc2UgY291bnQu
DQoNCiAgICA+ICAgVGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgcGF0Y2ggZG9lcyBub3QgYWRkcmVz
cyBlaXRoZXIgb2YgdGhlIHNpdHVhdGlvbnMgYWJvdmUuDQogICAgPiAgIEluIGNhc2UgMSksIGl0
IHNob3VsZCBzdGF0ZSB0aGF0IHRoZSBjb2RlIGN1cnJlbnRseSByZXBvcnRzIHR3aWNlIHRoZSBy
ZWFsDQogICAgPiAgIGZhbiBzcGVlZCwgYW5kIHRoYXQgdGhlIHBhdGNoIGZpeGVzIHRoYXQgcHJv
YmxlbS4gSW4gY2FzZSAyKSwgdGhlIHBhdGNoIHNob3VsZA0KICAgID4gICBhbHNvIGZpeCB0aGUg
YXJpdGhtZXRpYyB1c2VkIHRvIGNhbGN1bGF0ZSBSUE0gZnJvbSB0aGUgcHVsc2UgY291bnQuDQog
ICAgPiAgIEVpdGhlciBjYXNlLCBJIGRpc2FncmVlIHRoYXQgdGhpcyBzaG91bGQgYmUgaGFuZGxl
ZCBpbiBkZXZpY2V0cmVlLiBJdCBoYXMNCiAgICA+ICAgbm90aGluZyB0byBkbyB3aXRoIGhhcmR3
YXJlIGRlc2NyaXB0aW9uIG9yIGNvbmZpZ3VyYXRpb24gYnV0IGlzIGluIHRoZQ0KICAgID4gICBk
aXNjcmV0aW9uIG9mIHRoZSBkcml2ZXIgYXV0aG9yL2ltcGxlbWVudGVyLg0KDQpUaGUgZHJpdmVy
IGRvZXNuJ3QgaGF2ZSB0aGUgdHdvIHNpdHVhdGlvbnMgeW91IGRlc2NyaWJlLCBpdCBhbHJlYWR5
IGNvbnNpZGVycyB0aGUgZGlmZmVyZW50DQpzYW1wbGluZyBtb2RlcyBhdCB0aGUgYXJpdGhtZXRp
Yy4gVGhlIHBhdGNoIGlzIHVzZWQgdG8gbWFrZSB1c2VycyBoYXZlIHRoZSBvcHRpb24gdG8gc2Vs
ZWN0DQp0aGUgbW9kZSBub3QganVzdCBmaXggaXQgdG8gdGhlIGJvdGggZWRnZXMgbW9kZS4NCg0K
ICAgID4gICBHdWVudGVyDQoNCg==
