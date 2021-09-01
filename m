Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD23FD947
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243965AbhIAMND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:13:03 -0400
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:62278
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243873AbhIAMNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:13:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+WBTeoZRPwlgU+29cagPU7vc2MhJOU7PY2v1udGO72DhdFvcjqj7B0vMoJ/YTayrpXk+qWCWJWmrDGfiafE3IvBlUAoM3102GbQa9ES+SNXSim0UgaJ5oa+VJAOm5RKZi6QsCZUpeTANsdY9AysoW6vLdWcf+cFyhtgcwUhWEZvPKKyIQV2iPM30EU/xK6PyJ5MMIo3AmaU/9JFM0eEb87nPb5evWuFLRWf4oMiUANnQhrqI1bOj/7FTFeWT98X6vAnT9H7aPDzE2V8GoH4Ep9ji7mJa+mIhr8ICzKWSaD6UMv2JhDIeyauhwsXnZEoSi8qQZPYP8AnwP6dWDYc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UNmR9fxwbTnMKO+xgOgRWCB4QnWSh8gPTHJEzNlRaXU=;
 b=hs9C/JbRHcH0FRCA0ezeW/5J+ofPgwYxsZRhmQTQDY8v8xog9dP1URtX4T1eS0QTb1yMELlKdALQlWFgwns95K3PutVshv+T9wiHjs098dGGpVlogY/di/QYyQcLEYkJp+Ln6Q42URaagekInKlkGVXq5a59HhRE3KBAYqX5uvsjTQKAtWRGgarkMlhhdofodFC6cre8bPq2hPmVa3IMQ9zofmq7xM568s3tsOghwQ20W+/oDYRuQ4/Xb1kNtpbKaZbU0kNNvP+fD3h6D6V5j4/TJLanYJrTZy8fbeuUyuI4WXqy1iMTFWQnjSXtnxqPHqu9VSlLvAQS04KZvH2Acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNmR9fxwbTnMKO+xgOgRWCB4QnWSh8gPTHJEzNlRaXU=;
 b=Mlaz8MdZ2uCwswIitUXg98EAH51Ky5e/zqOqcAc+8rsjr94GDHkVFg8Yj0ALTOjSJdeLudX5Cx7Y2J9n913XI6z9X8y9qheTwiXqti4MoYHGQJVWsnyIc3IKn9V0cfztEgCYT+s7mjSDEsEfLVRefMdH7AJhA7eEiEtnYUBrUAM=
Received: from AM0PR0402MB3380.eurprd04.prod.outlook.com
 (2603:10a6:208:19::32) by AM0PR04MB5396.eurprd04.prod.outlook.com
 (2603:10a6:208:116::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 12:12:03 +0000
Received: from AM0PR0402MB3380.eurprd04.prod.outlook.com
 ([fe80::9df:9c22:f158:ba61]) by AM0PR0402MB3380.eurprd04.prod.outlook.com
 ([fe80::9df:9c22:f158:ba61%7]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 12:12:03 +0000
From:   Zhipeng Wang <zhipeng.wang_1@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] clk: add sys node to disable unused clk
Thread-Topic: [EXT] Re: [PATCH] clk: add sys node to disable unused clk
Thread-Index: AQHXj+QBlquo8AJbWUmGhsvErjIupKuKC3UAgAULcNA=
Date:   Wed, 1 Sep 2021 12:12:03 +0000
Message-ID: <AM0PR0402MB338000DB87B13B85DEBBAF5CEBCD9@AM0PR0402MB3380.eurprd04.prod.outlook.com>
References: <20210813091118.17571-1-zhipeng.wang_1@nxp.com>
 <163021444683.2676726.5708766744722496303@swboyd.mtv.corp.google.com>
In-Reply-To: <163021444683.2676726.5708766744722496303@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0166e066-1bd0-4746-194f-08d96d41b580
x-ms-traffictypediagnostic: AM0PR04MB5396:
x-microsoft-antispam-prvs: <AM0PR04MB53967AB40A70B98D7AE85464EBCD9@AM0PR04MB5396.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:153;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMqc+9EqiNP93TdDhx7X+xbRCwPf9N3io332gziJmIWIYcc3XWNGJy8FiN8lp5TzzALifW7VDNE8lM8qrVITMH/sZl4SBemGPyx0StDcaXIiMk708qbrV42Gb2RJY9MZzbySrDSOnQ2MxkW2/1z0jTS3ULRAVmR5QH3snmD94RXCoVTYc4YAJYSOnj2hkCAE2LITnA4dRVSTb/2frFK6ivKy3VSm8chMOpA+8YIL0lS4XXnzEk7cpSdnf0/i4dEVgqrA97ze/3P5paGbTUEPuC0KNYm0w3dyGhQIxhRIuSV6slXOe4g4N4E5lZtrioNfrRu3KalbcrSJetO7mlMCEdvRDXQtO2xwX9zb4i6KDF9p63w4t8JPK+hDjYLIaKSpyEC+FY8mPoq+RaCrkvCbM1BGDEPHFtkMUI1EoTNedZYg8OnAtg9lCTDgQbzgrkVV+H4dmtbX5Kd/JQ651Yua0ayNB1PxJnWcROmtjAfQyMZDQ5x0aftJQXNswe2zDspF4fvdH0SWWXS04X0O5AQkPkTM3JNZmStpmTa5zFn71dRd761PiMWtjDEaAuKIWedWl+X/tCJlhh+QFyy18OOxuYoR/gdKylYz5YuPZqzeNn19r4mOASViMnvK82XrDsf9WRtZQ/sIzMMfKVkhSJcyTC5Nxj2XjfTiIk2ukWctcqSQhB5scbctvXg35aYu8kTWgDzOufRdK9D2ZF0SgpWhPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(53546011)(6506007)(86362001)(316002)(110136005)(8936002)(186003)(71200400001)(122000001)(38100700002)(8676002)(38070700005)(76116006)(9686003)(5660300002)(2906002)(83380400001)(7696005)(33656002)(66946007)(52536014)(66446008)(64756008)(66556008)(66476007)(55016002)(26005)(508600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2xHTyt6OUJRakNsaFJHck5Cb1J1MklYQzlKODdBeVp3S1FTT1NVOC91alA4?=
 =?utf-8?B?bC9WR3dRaENwVDZhYWMvandFaHJpa09uTEdDVGdlSkRSN1RZYXFqQ2RxMDMx?=
 =?utf-8?B?Y09Wa014cStpNFhGb0UyMVdOQlZreWxuZzBPazNjMDdmQVV6VnF1Q2MxT3lp?=
 =?utf-8?B?aFUrWjJVZlN3OFg3alR3cEM5TitMcnljbnFzSThDcE1EdUYzQTNJOVVzSXBk?=
 =?utf-8?B?bUtKVHJvMFdpb2R5NlRPYWoxRXBSbW9KdGxlMTM5Y29tOTJER1BwVGNuS2x1?=
 =?utf-8?B?d0JqUnZXeEFQRnB4Tm1nOENGWENhbDViK3NTMmhrb3Qzc0hyQnZpTnMrWktQ?=
 =?utf-8?B?anNpbURRa1RNclF5K2FRZkYreDdGZmFIa2tjZXhJQTVlbWwxSm4yOVJod2Jh?=
 =?utf-8?B?bklJY3FONzRRYjVYcXhRbXgwUzgreFFUamttRUJTaWhrWkpnd1BReWhXLzQz?=
 =?utf-8?B?SGRkWjB6MWJwclhmOFc3UitHTzNwdUZBMzZQZ0NNZ2w5VWd3TVFqV3FoQ0Rk?=
 =?utf-8?B?Sy9JdVcrN1dIYVEzNXZFeHRyeDh3OG12aml6bndlZjFtMFFvQXhZd3I1bGdZ?=
 =?utf-8?B?RVo1SHhsRmdhdjZzbUVtT09PNmh3RGtXYktBVExlOVpDTEczVzZsbzRraDlP?=
 =?utf-8?B?WG9jRHg5M0FUSkJyamtET3B0VHgxd1RBQ21yU1Fady9rcDFHaVRiK3YyVVNR?=
 =?utf-8?B?MDEwazVBL1VZMVdMRjZjZEJ0cmMxRGRjaUpNcS9CT2oxc2FZWHhrRklRdWpP?=
 =?utf-8?B?ZlRyb1Y2VFV3M0hoWSsvVk5GOWlFT2lTRTNPUFpLTDdzbWU4MDRkaVZFaVdX?=
 =?utf-8?B?S0tSYzV6WStEMEJwWU5NWjNOVy9FU2ZvTWEvWXA3VFhBbm9HaHhOcEoyR1Qy?=
 =?utf-8?B?amltZGVybndzTFBXczNnbkxCVHYvdlZGS1Nwc1RrOVN1WU9wVVFOdXhKa2Na?=
 =?utf-8?B?SVg0Szc5WnFEak1BQzRSTVk2NFpFRTRjWkd6dHdFSDh5WkhDKzVwS3o0YmJF?=
 =?utf-8?B?OXhaYW84NEdDVWl4SEZ2d3VLVTVIMEVZaUx6ZGFHVmgxVitjZWpGMVJuSDFS?=
 =?utf-8?B?UzdlcXI2TUZhM2xuZVB4bHl6UDlyYlBFOGUwTUpnMGZlQ3RPMjNvS1JYSHJk?=
 =?utf-8?B?ejQrVFRtSmY2aElRc1Q1aDhkV3BJYStrT0IvNndaamZTUDgrUm8yZFZhRGdU?=
 =?utf-8?B?YS85VktKQ3dxU0YxRlRUVm5qb2orTkpLRzFUc1NXVDZwbW92dERKS1FNbDdB?=
 =?utf-8?B?KzBibHIvcit5eHU3NVJlQ0wwNDBncGovNEpHclBkZlJLQzBEdFhQajBrZ1c3?=
 =?utf-8?B?aWNDbEo0VzhtNVdtRG8rVTlrbXhpelY2UlAvUTFuUzl1K3RQb3VYOG4xVmFt?=
 =?utf-8?B?K3pPdmg3akllejdlcEdvY2FKNTZlWVlQS0lBalV5c1h4ZEZIdlRwTEpwZXVl?=
 =?utf-8?B?M1pBdGNMZkVzSktzYmdyeDNvZW5pUjd0Rk5ILyttQ0NobzJpOU5NWCsveGRD?=
 =?utf-8?B?VE5ncE13WnZLOUdwKzhRS3dnNGN0OFpONitrS2c0dnRvZW1yS1pyWHVJQnRK?=
 =?utf-8?B?aUNlSS9LeVdlVDdGRDdpMERxQUFjMlBhMHFrTnNhSjgralNGVVh2ZjNxNXdU?=
 =?utf-8?B?YVZURUhubGdHQlBoQnBYM2pSbEhFVTI0VFRXVjZEZDNXRnlUN1dtSWt6QURZ?=
 =?utf-8?B?V05RbFpNYzc1N1pnbjF0ZHBpY3ZLZ013TmhOTGN3R2JldjJBNXRjL3l4WHVs?=
 =?utf-8?Q?YHAD02eFFlzSzuk3o6LKEzt/gTbT39JU45G9fYk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0166e066-1bd0-4746-194f-08d96d41b580
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 12:12:03.4599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPRx77hXnMhQ9uJ3rcdxyOcGGxv52SqnkG5DYqNE8zsMOtt6hgvs9e+oo5jqkNFEFIJzURCkDJP8gY35bqqTRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5396
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KRmlyc3Qgb2YgYWxsIHRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIg
cmVwbHkuIA0KDQpPdXIgY2xrIHByb3ZpZGVycyBkbyBub3QganVzdCBvcGVuIHRoZSBjbGsgdXNl
ZCBhcyB5b3Ugc2FpZCwgYnV0IHJlbHkgb24gbGF0ZV9pbml0Y2FsbF9zeW5jKGNsa19kaXNhYmxl
X3VudXNlZCk7IGNsb3NlIHRoZSBjbGtzIHRoYXQgYXJlIG5vdCB1c2VkLiBCdXQgaW4gb3JkZXIg
dG8gc3VwcG9ydCBBbmRyb2lkIGdraSwgSSBtb2R1bGFyaXplZCBjbGsgcHJvdmlkZXJzIGFuZCBz
b21lIGNsayBjb25zdW1lcnMuIFRoaXMgY2hhbmdlIG1ha2VzIGxhdGVfaW5pdGNhbGxfc3luYyhj
bGtfZGlzYWJsZV91bnVzZWQpOyB1bmFibGUgdG8gYWNoaWV2ZSBvdXIgZXhwZWN0ZWQgZnVuY3Rp
b24uIEkgYW0gc29ycnkgZm9yIHdoYXQgbWF5IG5vdCBiZSBleHByZXNzZWQgaW4gdGhlIGNvbW1p
dC4NCg0KSSBhbHNvIGhvcGUgeW91IGNhbiByaXAgb3V0IHRoZSBsYXRlIGluaXRjYWxsIHRvIGRp
c2FibGUgdW51c2VkIGNsa3MsIGJlY2F1c2UgdGhpcyBjYW4gcHJvbW90ZSBjbGsgcHJvdmlkZXJz
IHRvIGJlIG1vcmUgcmVhc29uYWJsZS4gTXkgbWFpbiBqb2IgaXMgQW5kcm9pZCwgc28gSSBuZWVk
IHRvIG1ha2Ugc3VnZ2VzdGlvbnMgdG8gb3VyIGxpbnV4IEJTUCB0ZWFtIHRvIGltcHJvdmUgY2xr
IHByb3ZpZGVycy4gQmVjYXVzZSBvZiBsYXRlX2luaXRjYWxsX3N5bmMoY2xrX2Rpc2FibGVfdW51
c2VkKTssIG15IHN1Z2dlc3Rpb24gc2VlbXMgdG8gYmUgY3VzdG9taXplZC4NCg0KQmVjYXVzZSBJ
IGNhbGwgY2xrX2Rpc2FibGVfdW51c2VkIGluIHRoZSB1c2VyIHNwYWNlIGFuZCBtZWV0IG15IGV4
cGVjdGF0aW9ucyAsIGl0IGNsb3NlIHRoZSBjbGtzIHRoYXQgYXJlIG5vdCB1c2VkLiBUaGF0J3Mg
d2h5IEkgdXBsb2FkZWQgdGhpcyBwYXRjaCB0byB5b3UuDQoNCkkgaG9wZSB5b3UgY2FuIG1ha2Ug
YSBkZWNpc2lvbiB3aGV0aGVyIHRvIHJpcCBvdXQgdGhlIGxhdGUgaW5pdGNhbGwgdG8gZGlzYWJs
ZSB1bnVzZWQgY2xrcyBhZnRlciBjYXJlZnVsIGNvbnNpZGVyYXRpb24uIFRoYW5rIHlvdSB2ZXJ5
IG11Y2guIA0KDQoNCkJScw0KWmhpcGVuZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gDQpTZW50OiAyMDIx5bm0OOaciDI5
5pelIDEzOjIxDQpUbzogWmhpcGVuZyBXYW5nIDx6aGlwZW5nLndhbmdfMUBueHAuY29tPjsgbXR1
cnF1ZXR0ZUBiYXlsaWJyZS5jb20NCkNjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBjbGs6
IGFkZCBzeXMgbm9kZSB0byBkaXNhYmxlIHVudXNlZCBjbGsNCg0KQ2F1dGlvbjogRVhUIEVtYWls
DQoNClF1b3RpbmcgWmhpcGVuZyBXYW5nICgyMDIxLTA4LTEzIDAyOjExOjE4KQ0KPiBUaGUgbm9y
bWFsIHNlcXVlbmNlIGlzIHRoYXQgdGhlIGNsb2NrIHByb3ZpZGVyIHJlZ2lzdGVycyBjbGsgdG8g
dGhlIA0KPiBjbG9jayBmcmFtZXdvcmssIGFuZCB0aGUgY2xvY2sgZnJhbWV3b3JrIG1hbmFnZXMg
dGhlIGNsb2NrIHJlc291cmNlcyANCj4gb2YgdGhlIHN5c3RlbS4gQ2xrIGNvbnN1bWVycyBvYnRh
aW4gY2xrIHRocm91Z2ggdGhlIGNsb2NrIGZyYW1ld29yayANCj4gQVBJLCBlbmFibGUgYW5kIGRp
c2FibGUgY2xrLg0KPg0KPiBOb3QgYWxsIGNsayByZWdpc3RlcmVkIHRocm91Z2ggdGhlIGNsb2Nr
IHByb3ZpZGVyIHdpbGwgYmUgdXNlZCBieSB0aGUgDQo+IGNsb2NrIGNvbnN1bWVyLCBzbyB0aGUg
Y2xvY2sgZnJhbWV3b3JrIGhhcyBhIGZ1bmN0aW9uIA0KPiBsYXRlX2luaXRjYWxsX3N5bmMoY2xr
X2Rpc2FibGVfdW51c2VkKTsgZGlzYWJsZXMgdGhlIHVudXNlZCBjbGsuDQo+DQo+IE5vdyB3ZSBt
b2R1bGFyaXplIHRoZSBjbG9jayBwcm92aWRlciBhbmQgc29tZSBjb25zdW1lcnMsIHdoaWNoIHdp
bGwgDQo+IGNhdXNlIGxhdGVfaW5pdGNhbGxfc3luYyhjbGtfZGlzYWJsZV91bnVzZWQpOyBjYW5u
b3Qgd29yayBwcm9wZXJseSwgc28gDQo+IGluY3JlYXNlIHRoZSBzeXMgbm9kZS4NCg0KU29ycnks
IEkgaG9uZXN0bHkgZG9uJ3Qga25vdyB3aGF0J3MgZ29pbmcgb24gaGVyZS4gVGhlIGNvbW1pdCB0
ZXh0IGlzIGRlc2NyaWJpbmcgdGhlIGNsayBkaXNhYmxlIHVudXNlZCBsb2dpYywgYW5kIHRoZW4g
d2UncmUgYWRkaW5nIGEgc3lzZnMgYXR0cmlidXRlIHdpdGhvdXQgZG9jdW1lbnRpbmcgaXQgaW4g
RG9jdW1lbnRhdGlvbi9BQkk/IEFuZCB0aGVyZSdzIG9uZSBzZW50ZW5jZSBhYm91dCBtb2R1bGFy
IGNsa3Mgbm90IHdvcmtpbmcgcHJvcGVybHksIGJ1dCBJIGRvbid0IGtub3cgd2hhdCBpcyB3cm9u
ZyBhYm91dCBpdCBiZXNpZGVzIGl0IGlzICJ3cm9uZyIuDQoNCkkndmUgYmVlbiBjb25zaWRlcmlu
ZyByaXBwaW5nIG91dCB0aGUgbGF0ZSBpbml0Y2FsbCB0byBkaXNhYmxlIHVudXNlZCBjbGtzLiBJ
dCBwcmV0dHkgbXVjaCBvbmx5IGxlYWRzIHRvIHByb2JsZW1zLiBJZiB3ZSB3YW50IHRvIHNhdmUg
cG93ZXIsIHRoZW4gbWF5YmUgd2Ugc2hvdWxkIGhhdmUgY2xrIHByb3ZpZGVycyB0ZWxsIHVzIHdo
YXQgY2xrcyBhcmVuJ3QgZXZlciBnb2luZyB0byBiZSB1c2VkIHVubGVzcyB0aGV5J3JlIHJlZmVy
ZW5jZWQgaW4gRFQgb3IgdmlhIHNvbWUgY2xrZGV2IGxvb2t1cCBhbmQgb25seSB0dXJuIHRoZSBv
bmVzIG9mZiB0aGF0IGFyZSBpbiB0aGF0IGxpc3QgaWYgdGhleSdyZSBvbi4NCg==
