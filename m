Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2933442133B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhJDQAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:00:52 -0400
Received: from mail-bo1ind01olkn0185.outbound.protection.outlook.com ([104.47.101.185]:45404
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234175AbhJDQAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:00:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNBo5s8Z6Xv0fhc8HJhhu3H5egP1kEBdLRt3iItxDytDPgiJ/Xmj4NIsOMHNN9J5QZuhWJ8Nq/D+gijJ66/YLCOoYmxVD2lorRRQaTGK8jVQWmytzjRNDf9YDqnWoETmyTMOd3CHwWuq3fyxqhXhgJKdB+uMEKRTbz+2PZpZv3halm/E3KYgL/6xSKTNKrVgpnSIxJzEevxA9uqaAbERr01Z4J7zxe8eJMPHNsDQklTEL9ndRt0GUQSzIffOXtykDekwHyFPi4QCDjdZe887WqO/+6GKVSaVyvp7bVD3Cpnuj5ufEXnW3asBymyKYPgk2vVyoW4kSx3QN6BWrHC/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnGoVK+3U8o+kPaBCRFs38W2gmGKFrUqxWea82gKpxM=;
 b=i9cpUFYM3SAcQOCHVx5pT+HzJbyWC0Ik0Hlc0MBvSN65J9C4uorjP3U7v/4hU+n/EOI7ZR1+18fU/1oJPI2xaGUsaNai899I49np45uQOyK8PtuQvvON50M/fdCICxfUEWg21/CpIq8/sxRheC3B3eLzgVOXytwPjK/2NO1l4gpctTFmaMKop3m/3DJrFyDOYVX8WHpV3uqPcF1AhQuDdB2A90qobajiysCIlr9j/pQpWdvCq83LvEkk4t79zPbdzpVsqgm9d4Hx7WbQvC1fcmEWMsWePXBJL+Wt0JsyenISBAR3tnoGOVBucBYZAryqsh4HHOkFwncLka0ppLiLdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnGoVK+3U8o+kPaBCRFs38W2gmGKFrUqxWea82gKpxM=;
 b=cKLeEHJ0uB6UK1WFg0zu4OHFNg6lpL2gTMS9E8myFJrL7GB/iFSanHinIwvuWG9GEIJ42gFibk8wcP/yAp1472x3FRQDlcmI2KQnWJu60++aBQ1GKv0AFZ5nNLWBYt/ApHg0Jrh+d+RGTIGSodFJYcHup6N4v9NQNAYvpUO/5BnHz5yaNIfRn0wkmbe2uf70N1sOioClRoOHz02ZPa8MJj2/bTLearmKDumkHMkUWhQhYfN7foBV4WIlQFyZ+o1wn1JuCk29uyDnBKb7q9ZA8ppxpb0DNkc1yoze/TeRv409nxNf34b0F4ACat9Ppkqbmcp5XQpslVhgYcfSM+Y6vw==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB5168.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:5f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 15:58:58 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea%3]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 15:58:57 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4] mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N
 UART
Thread-Topic: [PATCHv4] mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N
 UART
Thread-Index: AQHXuTi9P1M5ZCkxm06CusGUtdqzQw==
Date:   Mon, 4 Oct 2021 15:58:57 +0000
Message-ID: <F169C53D-C688-4F1C-B361-86885FD11F21@live.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
 <20211002111449.12674-1-redecorating@protonmail.com>
 <YVqqllKyNF4A424K@google.com>
In-Reply-To: <YVqqllKyNF4A424K@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [fstproMzsf0vMoUNbyBH+jAqUVo/mhzo1QnPo/O/n9TRNMM2/pXp9QqE6lBcU/QT]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 811e5efe-e1bb-4909-6125-08d9874fdffb
x-ms-traffictypediagnostic: PNZPR01MB5168:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2f85XyX7wKYYEKDWujx4g6KTI9PD6ySFkNaj7OPVGuYhzg+74eI4X0yYnvDamIk6K2BtUbOehKOXzd/2P+A/2ixq2cKnZ232WjPv++tgHUdHZqqicn2dQdmE6qO4Gr6tPbODOYo/0AcTSE3MfDKgo5ouckKVNtt2cXkqGBhtBWX6c4sdOulhwvH7o8S2+snHPhQZT6Kp3fo7ltNPSyI0kfEgln/2nh8QHjnP43xbTvsChAzpWp/pVohGUJZo1tnbx+9h5N3fi4MQOfOlI982NWtbsNMf9ZJPNRWQMZLlE0EvHhPaJbVa1VrC8OppDMzIyipIVaIRcx+1LEflxhGvorrn/BI+gE+1ZCrXR97uN5DUTft6sDh8qqf/l/K8Rh4QGiP/PyPnP8AL3y3256+6uFTQvW1YfvTiYCmGGzvv5BF9Ys2Czs75Rj32AbW9v8x
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: yulRkswMF+10NJHoGdGepZq90d3xxa5KyBcg8wxryqzGYuYzOQObvB2jcy8jmuXsZkZZAWVWfFpqd3avswrMvpwY9ZqxIc/gHwocMAc+7F3uuVw2jU2zVkqf2T3dmnglnFV4ndJ7ZqI1PT+okKX0fN6WlH4Z18fJiKWMQjfRNsGGoatMzRTs42oX2Q2tvj+4eDD6DhrguQcekhjVgwNcfw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2357C2E387F2EE4397BDB6AAE9AF2A89@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 811e5efe-e1bb-4909-6125-08d9874fdffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 15:58:57.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB5168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlDQoNCkkgcmVxdWVzdCB5b3UgdG8gQmFja3BvcnQgdGhpcyB0byA1LjEwIGFzIHdlbGwN
Cg0KUmVnYXJkcw0KQWRpdHlhDQoNCj4gT24gMDQtT2N0LTIwMjEsIGF0IDEyOjQ3IFBNLCBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgMDIgT2N0
IDIwMjEsIE9ybGFuZG8gQ2hhbWJlcmxhaW4gd3JvdGU6DQo+IA0KPj4gQWRkZWQgODA4NjozOGE4
IHRvIHRoZSBpbnRlbF9scHNzX3BjaSBkcml2ZXIuIEl0IGlzIGFuIEludGVsIEljZSBMYWtlDQo+
PiBQQ0gtTiBVQVJUIGNvbnRyb2xlciBwcmVzZW50IG9uIHRoZSBNYWNCb29rUHJvMTYsMi4NCj4+
IA0KPj4gU2lnbmVkLW9mZi1ieTogT3JsYW5kbyBDaGFtYmVybGFpbiA8cmVkZWNvcmF0aW5nQHBy
b3Rvbm1haWwuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNo
ZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPj4gLS0tDQo+PiB2My0+djQ6IHJldmlld2VkLWJ5
IGxpbmUNCj4+IGRyaXZlcnMvbWZkL2ludGVsLWxwc3MtcGNpLmMgfCAyICsrDQo+PiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBBcHBsaWVkLCB0aGFua3MuDQo+IA0KPiAt
LSANCj4gTGVlIEpvbmVzIFvmnY7nkLzmlq9dDQo+IFNlbmlvciBUZWNobmljYWwgTGVhZCAtIERl
dmVsb3BlciBTZXJ2aWNlcw0KPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBm
b3IgQXJtIFNvQ3MNCj4gRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZw0K
PiANCg0K
