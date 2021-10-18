Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90294430D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 02:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344883AbhJRA5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 20:57:00 -0400
Received: from mail-eopbgr1300119.outbound.protection.outlook.com ([40.107.130.119]:10492
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242878AbhJRA45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 20:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPncjuRLsjAQ5cKORLKCgx3qgIqXuVbZpVmmYLvzVjfcPKkOwSD/sRIg/hltMDdMdiCMc5Hip0gAvS0v1LLGMWcEPSMqEZYEBaYBthezPoCsAK52XO8AIPKcopL43AXTwduJ+DfbaB4FlbznVqf7QVToVN1u46IclTcVKufmSFZVr8UBT4VmDsKaJVIq0zS/LT9XDsZgN+s0bxUVhrmIvcYxQ4YnHE0NXXmiWeq8lftU3G/FUqjyzCGOs0UuaTJ5+BTtyi7+o7uoHigEy0kJeYuwnkR9LXrXbtUZI3jbpTMlxNnwdv//httUt5ORQ3LXIc4S2O9xALh1L6yz9j049w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuAH2OQSya9fJHBgug3CwEG+K3kDl4XxOC5dvdGjYR0=;
 b=Mza1aagMkPNmGs5g0J6mfRQ8zKIJoJDlMGmiKIuGxhxmugTphMcZq0ktx6mHEDN1uEEkEUU5PzA/bOoxLCGL4PDw/En4iDSraF/NNh6lxCer+H4F6dUb4YKhxXoFKGnqK8pvbif8ARo8e/RYE+6ciRhC27RQHb8WcHBM+Im3786l9antG0pcjrT5GGvenRd2BeJFz8PDfkAsjQhXZWEebWUCPOiH5EEudtlTMjixfSPhn9enFuAcuNoc3S5+FRn0gTJzev3Yu9CZge9pBfXVhYu+oNlxxBfWEaHDJg6PNnKEaOnpUnxahXpLO37UBD6y0AgLVvqcTjsHaAgR0ZRHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuAH2OQSya9fJHBgug3CwEG+K3kDl4XxOC5dvdGjYR0=;
 b=jri9yqDVQAtKx0+Hn8GMvCzFCrZdtCQhc5EkHwdW/JqjBqMSJlImy4vXh6CKK0ltCQpKqQ9ZvJzis2BP3SYE8sf5vP80b5QECGkzGi9UWVZMRMxKcM7ZYiDA44U7p2sZaRbCDGbZhMV/+S//jhurYzRXxrMHhUJfdvis9r+Luz5csSf13CfdJyze0Ly4z9X9brwkkpVs1eELH4Rn+/imIcVA5Gr06gbBDuJwjlgb/1MQjhjyn0b5ANyQ+9tui8S6iD3Su1HWecFIR+JWJCc2gVJQEG+NoHFH6dYXEbKVdzRjr14ziZJk4zdwkzGBYucHFliurfZ7rbjMCKXWMXICSQ==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK2PR06MB3572.apcprd06.prod.outlook.com (2603:1096:202:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 00:54:43 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::cc12:f6f8:7dc5:8c18]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::cc12:f6f8:7dc5:8c18%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 00:54:43 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Stephen Boyd <sboyd@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk:aspeed:Fix reset driver probe from builtin_platform
 to core_initcal
Thread-Topic: [PATCH] clk:aspeed:Fix reset driver probe from builtin_platform
 to core_initcal
Thread-Index: AQHXubSPvR0AkHOyAUiNxiUKBKrwgqvWfeGAgAGB4JA=
Date:   Mon, 18 Oct 2021 00:54:42 +0000
Message-ID: <HK0PR06MB33804909AFB349EEECAF9D4BF2BC9@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20211005064513.27655-1-ryan_chen@aspeedtech.com>
 <163443512161.1557475.9840437799108931135@swboyd.mtv.corp.google.com>
In-Reply-To: <163443512161.1557475.9840437799108931135@swboyd.mtv.corp.google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b7d01a2-8cb7-4f66-2c68-08d991d1df57
x-ms-traffictypediagnostic: HK2PR06MB3572:
x-microsoft-antispam-prvs: <HK2PR06MB3572A256C1B0E420E24431F9F2BC9@HK2PR06MB3572.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDa4UyM+Wv4BSkTDHBWRdlTi92F0xOnbxgEcDDfX3zb7XMNqZSXPFqvWeU4W7PjKKp8n3/Sqrx1sG32Obj6WN0/oP8fQXESdPIo4P/FgDk+3OuUkRv3/x5pGr5RDU8a2Nsyn4qH3zwplCPM955K/B4E4OzdBbHSVB8VMZXOY0tgtirx6Gtb6/S8F5QIXZfXHMY9sV4VK0HYPpGsEYhV5Ati7KNgYGuW7ybFauwIeQY0yqKUOWAqYwx7e9h22lWGMQveUKkEaA6cHFsye4s5+DQRoWzKraYuqY4+D2kOAw7PJ93t3aRzUUefyAv5URe0jXpbm+9cg1BSEcAbOs973U/dp4fxL4PH7Y5Gl9ZCVxs7sU0uSnOGzDUVYXHWBShwefpDHKjb74j4+eF8d/GuuabCCj8Bo7vUNIuYJzmbCpzc9+q1FXvzEKkzGpAq9DcrWf4ifFYiqjnChpIDP5TSl0xdVcsTG8Wizrq0NEjnk9YNFgZPOuvtYrM7Hzn9JMYgW9nK/PeulLt6vdE/3aoCQrExEqyk50lscUPNNEEWVy2WdR6akA4lUvxMSn+eZZKMf8LERgnLaPoPMIXFp9jaK0JeAp8M9muujsZnvdJB1pmGlQQrVwokhVojjEs2ZYpzQDW8NDKEr/b3lx0e31ffQ+NvudVN2xg7xfRTOxHiDP2tJfV6gUYsf19G/ceGEZ5R5mGUchs6ZCL9yJlYYwv2ftw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(376002)(366004)(346002)(396003)(9686003)(8676002)(316002)(66556008)(66446008)(2906002)(6506007)(508600001)(38100700002)(66476007)(122000001)(64756008)(71200400001)(7696005)(86362001)(38070700005)(5660300002)(110136005)(66946007)(76116006)(186003)(83380400001)(33656002)(8936002)(26005)(53546011)(52536014)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWt2WEpmZ2xrN21NMVVmYWpzdjBCMUo5emQrVS9BWTh1ODgxMUE4MnNPeFFQ?=
 =?utf-8?B?VXVBNk95YUY3VWY5ZUZuWTArSWthN043YTNKeGZTeFM0N2MyZjhyTHI0NFo3?=
 =?utf-8?B?OVQ4V0t6UFQ3OExaeURKMEkwMHlTbGN4dmJKUkpOYSttS2kzSEg4ZS9PbmQy?=
 =?utf-8?B?ZWxhTWhqM3NjdWJuOVdJY1ZFdkYwQ01GOGZrZEpOcmhTWXVIMGZkdzBJREpS?=
 =?utf-8?B?UjdCR0k0MlJyU3pKTmZRTnlKckoyWUlBYWxBSzlQcStKT3JxM1pVUjlLRkZw?=
 =?utf-8?B?STFNWGlMenZUUk1uYmpmbStGdUNOUUhuYnJWYVhlOXF6OFhqQWFLMjZlckJY?=
 =?utf-8?B?dUxkZVB0ZGNNZVpHTFVhNjlUNm03ZHBDSlMrRUxTTElWUmJKRTllakVIR2ph?=
 =?utf-8?B?SzB4V3BueVlSS1k1Rk5LM2dSUWlzaVNSS0s3TmxLRS9wcUVwWElZVGxoUmhU?=
 =?utf-8?B?TVhGcXdiakNpM3NxcFc4alJpOTdZeEpKWW4yQ1N2OW5nSC93ZDJxYUVaR3F1?=
 =?utf-8?B?cTBFQys5ODJrZ1RtU3NFcUk2dlA3eXY5N1dpdkMrNGhuWUdOWGpoRGVoSGQx?=
 =?utf-8?B?V0Q1U0xXbndNYmM4V3F6MU1MYXRwRTRKa3ZGeFRoWFQyMzFSczZoVngxYm1Z?=
 =?utf-8?B?d2h2eHRZSGJYWlFKc2VZeWh0N0NpRVNTb3hvZVRaN1hPNE16WjhRQnAvNVpD?=
 =?utf-8?B?SWMySDZFcUpiYmlxV29CL2xMTjExSlFWNjZnYWZ6QUVKOTZUcVV2QzQ1amNG?=
 =?utf-8?B?K01IbEc0dHdtd0VGZDdYOE04RmFDT0tJQVYydmxQeVB2WG4zekFQRTlKeGtJ?=
 =?utf-8?B?YkplN2RYK2xhSktxUlZ5N3Z6WnkwRFk3RFp0MUVRZ0VXTnNNcHBic2o5VVdx?=
 =?utf-8?B?OEdiLzYrZDV4ZmQvK3VrN29FU0xxQkNDRSswY29kSk5ZVGNqVVgrUWZEaENy?=
 =?utf-8?B?OTdoU3lDWVNweFJLY0ZkY2JESkkxU3R5SDZtUXhNYklTQzJrNDJ2eG5MSnRC?=
 =?utf-8?B?ckdoNE4zTnVjbjJxcWhOMnBoalFVNU9OaDA0R09LcjNraVZjTkhNdkVJR2tP?=
 =?utf-8?B?ZThFSnA4enJ6SFZnTkVRZzdsQzIyemFjVGZjakhOUy9mYTM5OXZTZEp3NGxL?=
 =?utf-8?B?M21PYnRIUElTK1lVWXdvQUlYaFpHcnp1YnBNRkpPY2NJVytXZG1GUEFiU3RM?=
 =?utf-8?B?TldXKzEzaFR2OVFNSlhHL005UE9GR3B5MDZkWkNHRDM4aVQxbGJtZnJJK0Zl?=
 =?utf-8?B?TWNQWUR3amc3cFNIZGlCekUySFFBc3JOTUtkcDB6eU05YlVDRVlablZsWnpj?=
 =?utf-8?B?M3J3QVBtZVovN3drL3IxZXQ1MWhsUlF1MkxxUXEyTzk2dDMwN0ZsTG82TC9U?=
 =?utf-8?B?MzF1aWoyYm0rKytEdkxpSERPaDV5aTUzUjdFbUxyQXBVR0JSdFFoZDJQWnN3?=
 =?utf-8?B?NlNaWmJOTnY4K0JLN2dFaDNDcHVUQjI5TTBkT0NXdzl2UGt0bWU4QjZjL2VV?=
 =?utf-8?B?YjNKUHl3V3Bsb1hLeEVqZCtIZ0xOVUxmRzN0TnRDcEdXejlVRytjd0dHWEM3?=
 =?utf-8?B?U3laK3djd09sTzRPMG5jZ1o3UFozUExOM0hYRElnS2NTUUZxZDAzQXRLVW9M?=
 =?utf-8?B?TWtKL2FXN0FkR3ZHYW0rOFIxWHNjK1VzbVpWa0JjWGwyOCtOVHNVeUc4RmlR?=
 =?utf-8?B?K0JjQXRQL0I1d3k5OC8wb3FSUVpubHQvZmlQRjdwei9KdnJQOXp5bWNucW8v?=
 =?utf-8?Q?tQfQ0v8tnnAqRUBlPoMWM/ePf/n70i3ZL2uHuDg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7d01a2-8cb7-4f66-2c68-08d991d1df57
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 00:54:42.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHxNtSNlp9jA+k77SXvfMwJsfdA8B9lgFiBDAE8T6odD44yueG/ijNrV+XlzBzlCCA7LX88SRvlt5SxqeZj8WhM2r/ykQsguBG6Bs7n3WEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3572
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gQm95
ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBPY3RvYmVyIDE3LCAyMDIxIDk6
NDUgQU0NCj4gVG86IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+OyBKb2VsIFN0YW5s
ZXkgPGpvZWxAam1zLmlkLmF1PjsgTWljaGFlbA0KPiBUdXJxdWV0dGUgPG10dXJxdWV0dGVAYmF5
bGlicmUuY29tPjsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGNsazphc3BlZWQ6Rml4IHJlc2V0IGRyaXZlciBwcm9iZSBmcm9t
IGJ1aWx0aW5fcGxhdGZvcm0gdG8NCj4gY29yZV9pbml0Y2FsDQo+IA0KPiBRdW90aW5nIFJ5YW4g
Q2hlbiAoMjAyMS0xMC0wNCAyMzo0NToxMykNCj4gPiBDaGFuZ2UgdGhlIHJlc2V0IHByb2JlIHNl
cXVlbmNlIGZyb20gYnVpbHRpbl9wbGF0Zm9ybSB0byBjb3JlX2luaXRjYWwuDQo+ID4gRm9yIGF2
b2lkIHNvbWUgZHJpdmVyIGlzIHByb2JlIGJ1dCBmYWlsZWQgZHVlIHRvIHJlc2V0IGRyaXZlciBu
b3QgcHJvYmUuDQo+IA0KPiBJIGRvbid0IGdldCBpdC4gRG9lcyBzb21ldGhpbmcgbmV2ZXIgdHJ5
IHByb2JlIGFnYWluIGJlY2F1c2UgaXQgY2FuJ3QgZ2V0IHRoZQ0KPiByZXNldCBpdCB3YW50cz8g
SSB1bmRlcnN0YW5kIHRoYXQgYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIoKSBtb3ZlcyB0aGUgaW5p
dGNhbGwNCj4gbGV2ZWwgbGF0ZXIgdGhhbiBjb3JlX2luaXRjYWxsKCkgc28gdGhpcyBpcyBhIHdv
cmthcm91bmQgZm9yIHNvbWUgZHJpdmVyIHByb2JlDQo+IG9yZGVyaW5nIHByb2JsZW0/DQpUaGUg
bW9zdCBvZiBkcml2ZXIgaGF2ZSByZXNldCBmdW5jdGlvbiBpbiBwcm9iZS4gaWYgZHJpdmVyIHBy
b2JlIG5lZWQgZG8gdGhlIHJlc2V0IA0KKGV4OiBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X3NoYXJl
ZCkgYnV0IHJlc2V0IGRyaXZlciBub3QgcmVhZHkgKGRldm1fcmVzZXRfY29udHJvbGxlcl9yZWdp
c3RlciksDQp0aGF0IGRyaXZlciBwcm9iZSB3aWxsIGNhdXNlIHRoZSBmYWlsLCB0aGFuIGFmdGVy
IHJlc2V0IGRyaXZlciBwcm9iZSwgdGhlcmUgd2lsbCBoYXZlIHNlY29uZCBwcm9iZSBJbiBkcml2
ZXIuIA0KVGhhdCB0aGUgcmVhc29uIEkgcHV0IHJlc2V0IHByb2JlIGluIGNvcmVfaW5pdGNhbGwu
DQpBbmQgYWxzbyB5b3UgY2FuIHNlZSB0aGF0IHRoZSByZWFzb24gbW9zdCBzb2MgY2hpcCBkbyB0
aGUgZGV2bV9yZXNldF9jb250cm9sbGVyX3JlZ2lzdGVyIGluIGNvcmVfaW5pdGNhbGwuDQoNCj4g
DQo+ID4NCj4gPiBGaXhlczogZDNkMDRmNmMzMzBhICgiY2xrOiBBZGQgc3VwcG9ydCBmb3IgQVNU
MjYwMCBTb0MiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVl
ZHRlY2guY29tPg0K
