Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA52D3EE73C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbhHQH3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:29:44 -0400
Received: from mail-eopbgr1410084.outbound.protection.outlook.com ([40.107.141.84]:54480
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238684AbhHQH3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:29:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbIuD70j1jG8Dqds13ERaWjM1zxMiHFTAcRpbOEuzMhc9LP45RabubLe7irS29IIQkx352dBhKJhoPTDyX/2Q+N0ngG98Ixp4/bLSGTqPMVnTckpncSKg+KDgcroE3J+TxlR8q9inGf7raRbMUmTDtsBosD1e7elqsWfnVObOkKXPikjvGs0TfIt0KaaJM3FW7760cWA05pPfMFbv8sjlh+D2rRy86R2hcC+bkEfU3MhEwKe0C3eUoJcn27ZYp5Ql9oWQi80vOSu451ZZUWBjfGztLa5jaYQmabXUtaIp6+kkJT4ZUep5AEI6SFT1CZ9bes89QnYPjhu5oAjJ036kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/rM6hvNoXFMj4y93fei9mk3phpJ+yUyiEdg7acVNek=;
 b=kO5t7Y8C0mxjbSSfuP97XnLJ4S8nhGzQrwrcQR3eJHPkUbzcc8fClt3/RSd+5u9vyulRf9QMGJ9NokK2EuxHHSy48qEhq6sVSpWz7Of0h4gOOl949nrrYhAHX4oDbmcOpo6r51N5fSpqahEAY9B2WqKVW1f1sriwdGCKes/YcJvTe2TuqiLKfiBDIrr7a43ZPr1uK5P5awkwN1CMjswNUscS/A4ZCsQ6wH2IC/zk2UIIiiGQ7pbtf0Tc3F5hRkqXXi9/57Q6uIR07JPgXtW3vVB/SXO/dQwtMKvLWnCeAT9+Wfst9NKfGr+Ub4Vooan/MZBMAFzQfAsbo9UEI6/7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/rM6hvNoXFMj4y93fei9mk3phpJ+yUyiEdg7acVNek=;
 b=N8b5FFn+QhunMDUwEInuyTYKjJeFB/QkYXiTbFsFI5Rg6QTTQ0ZRYyie6pH0cggC6gZtrSO0oi15AJ836nJDLQH43YL9/tx5tF45KQERt1zyAH5zVd6dNsdUb7bBpMT9DgKnk+9JI5vMbcJRJTE9v+akvRpW/fuGmrwhniChYhs=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3965.jpnprd01.prod.outlook.com (2603:1096:404:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 07:29:01 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 07:29:01 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] mm/hwpoison: fix potential pte_unmap_unlock pte error
Thread-Topic: [PATCH 2/4] mm/hwpoison: fix potential pte_unmap_unlock pte
 error
Thread-Index: AQHXkPpfFGXqAXhUhE+s+6RCLjYWAqt3USMA
Date:   Tue, 17 Aug 2021 07:29:00 +0000
Message-ID: <20210817072900.GA452155@hori.linux.bs1.fc.nec.co.jp>
References: <20210814105131.48814-1-linmiaohe@huawei.com>
 <20210814105131.48814-3-linmiaohe@huawei.com>
In-Reply-To: <20210814105131.48814-3-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d823601-830d-4190-1b97-08d96150aef8
x-ms-traffictypediagnostic: TYAPR01MB3965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3965CAF65AFE567C31425E50E7FE9@TYAPR01MB3965.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 22jfCUqcSKKRkfLC0m11WNbxDd/1d7iBFZs1nNk0o4YmdbcQT0ydDv8+ZemqBJjPYOl22OzjIRrrA4V8jy8a/4bdDW9QjGVs+gOnJL4jLeKVcMZ6ml4MnhOaxoCzIZJTD51hBM/YErdb49YhnI27sJL+zbmq+Uh3CJrhIKEFvsoQiznGG70f/JF9SdhHwapkoa37U5XFI9Ofss1Sal+78zsbW8ABKSR60WZsLFLyUSKeeI+7H1Pj1Kphxs5zC8xocjZaqZPjsYhj+H+hfgT/Oy4bJtw/XyiHoWLbIu0+ukK+DU2+Td+LUzL1SonlDoo14pEP9shkW4g3DmCkz556c8pe/niaxIdpRMf+87fsJjc2izIabkW7eZRp2x8DVQAMkW9GCqTet/4TvF3w+b3Ccwc6I/BBDSht65W2jRnj6UYYi3TOdq6nenPM+9VVi+t6SHfuKMYib+Dbnma18w89uoK1X7BXlgNSpuGG5QPVHCYw4JFO8C41FceodcK/uRvgNRzUVCjO/zpW9/JfN9AjjcK+xP5HZO4yMq8TWsJCo/ht7K1SQt4aQOydToz+GfPKnx0bdEFaukYU9li8zHeqVgLE/rSLMW4MzlU1KmWqvMofqBdIiZHjY0/sKViWQBS3ulGrCA5TfRfA8OvUPHjmgQDueQjJpyJHNnenIaPaI4IqY8DyEnJdiU+LAZ8f17GtNv51zaqQwqIHeS2IGCZ5Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(8936002)(5660300002)(85182001)(1076003)(122000001)(38100700002)(478600001)(33656002)(4744005)(316002)(54906003)(6916009)(2906002)(66946007)(55236004)(86362001)(83380400001)(8676002)(66476007)(64756008)(26005)(66556008)(66446008)(6512007)(9686003)(6506007)(4326008)(186003)(76116006)(71200400001)(6486002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0RiMEFyRytZZFZ3bEQwclZlNXRxS05NUVVvME9tdTBrbUl0Q0JhUGg3YnBT?=
 =?utf-8?B?clVJTjRiYUtocWlSRU5pYmRZRFdSSUhoc1lyVkNubVJDb3BYQnpIL2V1NFpm?=
 =?utf-8?B?OFVwTURwZlUrb0NDVUk4cjQvbmZlZW1reGxuZHcvZEFJZnNoNllJVzdZRmlL?=
 =?utf-8?B?QzdZZUg3V1YwWGVLZnNpMmVoMzVWVFA2SzF4NldwanpWa0YwKzJaRnlDbTBv?=
 =?utf-8?B?UVJuN29TY1ZPREEyYjlWU3lTUlpYNjZQSUQyTk15Z1V2dmg3VHdtcmtHRERz?=
 =?utf-8?B?ckFWVFU0czZqWVpkMEltWFJkMmYra2lrQzQrQy9aQ3VWL2pmYTB3aDVSYjNZ?=
 =?utf-8?B?dDlCSHdyK0NWbGdkeFBpUkZNZjBnUlRkOUxVdmEzcjBJTnRWNkhQMlBzZUI0?=
 =?utf-8?B?RDBvK005Q1ora2xLQUtHblB6TmFLOGkwRTZSdXowdjlIY280VGRXVWFnU3BH?=
 =?utf-8?B?bXV0R255VnpSbHdacTNPM0NTbE1ETytSYjBRYkQ0SmE0T3V0N3ZEMzQweldO?=
 =?utf-8?B?dG8xaEZ0MmpuLzQ5OWJGOHdxQWl1dWtTQzJJV0NRZnplTlJJZ0ppYzl4RUJW?=
 =?utf-8?B?WUh5WkppdkdjaFdRQ2U2Zm1odlJQSWRJVmwvVXk0Q1BQUHR0WVJwMjJEem81?=
 =?utf-8?B?WmFwaDJJclJNcTUwV20yc3hsQ2dJakJXcVAwUnFsWEZDU3JlTXZYbUlhdnR1?=
 =?utf-8?B?ZnNjcC90S0ptS0tTT3F4WEN3STNTbW5ueWVUeGRiZnpDZ3RXenE0RVM3Rjhy?=
 =?utf-8?B?OXY4TSsza0tZVjdEQUhSZkY2ZDNoT2phNlh1cUVyUERsNk1lUHB1MjBOU2ti?=
 =?utf-8?B?cmJCSEdjRG9qWFNwOGQ3RzRjSTdkZEFiLzVRMVpLMWRGenBSS1p1empwMTRj?=
 =?utf-8?B?U0pQbzRuQXhKc0phRlVUOEtSRU0vSVZnak84ZXplNExySXNyMW1TWmFhRFNx?=
 =?utf-8?B?TDhLZzBxUXZQWEZXVFlVZU9SWk9aQ1B2RVhXRHZYYlFUYnh3NUh2KytOS3Zm?=
 =?utf-8?B?VFZtK24rK3JWTHhsalJzUE5yTHFZNHRtQ3E2blpvQW85MTA5S1ZCUldrVlQr?=
 =?utf-8?B?Ui9UMEo5djNqU2dZb0E3N3ZxTEJocE1vcU5EbHpld1h0NVNuaDdvajIzb29K?=
 =?utf-8?B?Z2tReXpKTjVGSXBUdkxicDh5RUdZdE1STEVPK2hNMXFtMVpqU2djbTFTWG1v?=
 =?utf-8?B?ZzczNVJKMElYd1JxOVZiYUFmTmVrbE5GKzZQQzk0Rk5wRVk5cW5udldIWUlw?=
 =?utf-8?B?aTZaNWttM1l1Yk1PQVgxdFgvQ0RDbElCOGFtMlVreWdsS3hhb2N2NVdkKzhi?=
 =?utf-8?B?anNJeTNMQWxBd0c2UnFYcnhOM1VJNHQzQmVOMk90NXQvOCt5SmRqeUhwTVRn?=
 =?utf-8?B?MFFMbWNDcnlKLzFGQm9CaUFDVnpzRFFvWmpIcFArVEhBaGt4NnhtcldIb01N?=
 =?utf-8?B?TTlCdmNZbk9HY3JSSHlTZXFBY3dVQ21iUGdyWFR2YkhvT29mWGo5MFlnajVG?=
 =?utf-8?B?bEtLenVsMGxXQlpDKzRQZTFrS0h3VTZ4bzdmYXdUWSswMVZLSStoUEU1amFv?=
 =?utf-8?B?WUkwVWR5MzhRRkJRRzc0K0ZWSE1FcDRIYllqZ21KSXBDOVJWQUQzV0xoV04w?=
 =?utf-8?B?RUNSVWp0SEQ5TzFnaGJpOXlDczhPZVRPOFlnL25ZMGZCK09OZzhxOUgzVTlH?=
 =?utf-8?B?d28yd2x1Q0pVSXRIeWtiRmpJeUE2VXFHeCtzWGlCUFNoTENLRmZXbDYxcHRZ?=
 =?utf-8?Q?xVVFzkk3liGwmj2GKD0tzHrflHN1BfqaVsJ/kT9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C7637CF7DF4664EA31CE4FF61A88687@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d823601-830d-4190-1b97-08d96150aef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 07:29:00.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gGxXuHVsvSOwMSF2NfXBI5aVEj4nkkdgna7yb24ZnRD3fNw4BVJhASwxFWUnfDTOoZM0uXANo2GjI/zMg5O5gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBBdWcgMTQsIDIwMjEgYXQgMDY6NTE6MjlQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gSWYgdGhlIGZpcnN0IHB0ZSBpcyBlcXVhbCB0byBwb2lzb25lZF9wZm4sIGkuZS4gY2hl
Y2tfaHdwb2lzb25lZF9lbnRyeSgpDQo+IHJldHVybiAxLCB0aGUgd3JvbmcgcHRlcCAtIDEgd291
bGQgYmUgcGFzc2VkIHRvIHB0ZV91bm1hcF91bmxvY2soKS4NCj4gDQo+IEZpeGVzOiBhZDljNTlj
MjQwOTUgKCJtbSxod3BvaXNvbjogc2VuZCBTSUdCVVMgd2l0aCBlcnJvciB2aXJ1dGFsIGFkZHJl
c3MiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4N
Cg0KSSBhZ3JlZSB3aXRoIHRoZSBjaGFuZ2UgaXRzZWxmLCBzbw0KDQpBY2tlZC1ieTogTmFveWEg
SG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCg0KT25lIHF1ZXN0aW9uIGlzIHRo
YXQgYWNjb3JkaW5nIHRvICJncmVwIC1yIHB0ZV91bm1hcF91bmxvY2sgLiIgY29tbWFuZCBvdmVy
DQp3aG9sZSBrZXJuZWwgc291cmNlIGNvZGUsIHB0ZV91bm1hcF91bmxvY2soKSBpcyBjYWxsZWQg
d2l0aCAicHRlcCAtIDEiIGluIHNvbWUgcGxhY2VzLg0KSSB0aGluayB0aGF0IG5vbmUgb2YgdGhl
bSBzZWVtcyB0byBoYXZlICJicmVhayBpbiBmb3IgbG9vcCIgaW4gbG9ja2VkIHBlcmlvZCwNCnNv
IHRoZSBzYW1lIHByb2JsZW0gZG9lcyBub3Qgb2NjdXIgdGhlcmUuICBCdXQgSSdtIHN0aWxsIG5v
dCBzdXJlIHdoeSBzb21lIHBsYWNlDQpjYWxsIHdpdGggInB0ZXAgLSAxIiBhbmQgdGhlIG90aGVy
cyBjYWxsIHdpdGggcHRlIHJldHVybmVkIGJ5IHB0ZV9vZmZzZXRfbWFwX2xvY2soKS4=
