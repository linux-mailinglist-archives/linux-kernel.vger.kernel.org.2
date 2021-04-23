Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC895368AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 04:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhDWCTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 22:19:14 -0400
Received: from mail-eopbgr1410075.outbound.protection.outlook.com ([40.107.141.75]:9488
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230367AbhDWCTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 22:19:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9zO6rzgi4RwVyrkq6G6ma/ZZjRIRRx3TiluzYRbR9f1GR0Wrg1GTG15gTzV9wpYdsnHI7wVodbpyzzZz1/7rSSOzZLqkJ2O/TqMV6uTyS2b1SDz1xUL9A+9WkM1Nrwu/c21QZPIInS+/Wt7IyEyN+u4bHXqEmS91Crq6fpk0pt2qaDcjbF+tfjQLmuRpcTyWQU56wqTn8bWAyIDuj/TZiOK1lOFlHzX7ASz+TCK8uZqukd9faZfUS3xWqvMCQ9we2rf1433d6WUlgWA+HXs5sL51DbEjAyXkkHfA+9crVd/GrHd0LKzwzRuUXhMxgRZb99vQAeRfB+jx5DGXrWnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/wIJeWMNlqpIJxLXagN42SUtzZWIPdyx5aJcmcLew8=;
 b=lSfi31sUiDDmw4xucZ/bVRzjC8u9iRnOwiNNpJ24jHxGHhQNkSc/FAb37eoVLBLP7+5WIkYMkIOQ4onPTnC9jkBsXEAmoAwBp5gNIHgjpUxEYnfWPJcd9TDJmzRGy4ZoH1hzoDCo7tSw1LEgAtPlxcbCUufQSNkeiL6EqJJk417tQeY0Hb/jFfgBM5CNHxSzi/ybtlxu9RMdoaks2WoxtcDeR42EKpetkvCkzMsoJZeyBeu/Vaj82MkEqf/p3D0h8rqlcVX/SlVQkCb5I7lRq5cdXzpa/ud4xNvnyqWi+vj0wbJydZnxVEoit/xqGNezMpumSOjqhptGFQ9DbuQHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/wIJeWMNlqpIJxLXagN42SUtzZWIPdyx5aJcmcLew8=;
 b=MOywqUn2lzyVkoEpZeWxpXKNPr7sIHqXtQNZxu11O7cnAuZvPfB5KB5RROMlqWeKd2erKouk3MrU0V0HhEND7PIXy6LzHXtGuEeGPLu2jQepAfTifWQlpsio9x/52/w3VkRoPhSYAvLWNzwNpPvSbOKUyrGpfOUs2gTb+NzhsKs=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3501.jpnprd01.prod.outlook.com (2603:1096:404:be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 02:18:34 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 02:18:34 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Thread-Topic: [PATCH v3 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Thread-Index: AQHXNklgr5oQqPpfCk+wWIRkBSmi9arAxeiAgACbcIA=
Date:   Fri, 23 Apr 2021 02:18:34 +0000
Message-ID: <20210423021833.GB68967@hori.linux.bs1.fc.nec.co.jp>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
 <20210421005728.1994268-4-nao.horiguchi@gmail.com>
 <20210422170213.GE7021@zn.tnic>
In-Reply-To: <20210422170213.GE7021@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef6730f5-3ae7-4d39-307f-08d905fe18b1
x-ms-traffictypediagnostic: TYAPR01MB3501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3501D617903DDFEBD1ADE64AE7459@TYAPR01MB3501.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7oEXSDhtu10ZzpyDQMrnsgI9LjiOhiy5gXzffQHxQzO75xjwLAnl9XJwTa+vsCqFzYcZrP5/hAjEIQnmnyFPTD9Pj5gibknE3VXaWBExiFVkHMMXUqFcpPVoCKzr284P2d8ak0SuXMBJI0ak/oh5s8oZTHIGhFeFb+dFs0VVa25eWciuZ2DnUZgBpj1CL9TgYzS2mWm4rjxBK/lnqMbAROuIjxo93sIeTWxhGljsyB422vrOykD6v35U/EVk08QMvWtPVwqzsUN5wSPDlEygIhJshKj2RsCdftmzvByx6Q/xqm7GOv9pDGHw7mgNMia02vAwAKLJebx2N2p09N+atLmzuRDx67/rMZnoUnIDyMChPBznYD9jXwtI0GxUi5vnO2btOpEjqYb+clkOQjbGc37LYjqQjPkVog04qDQpz5tO6ncK4K6XrstCA4z1Llh5ZPhdSi6GLkVqYOeVACDBfbHsRfSAsuSbKuo2tJ6t/A3VEvLYs8l4IkfYKhwomaQAOi1FbSjrEM9IVXCoY019UjWIkKOcqPFeQ42dldV7waDS8oaaJLE4GvLdt3JMYiQKBgAcV+BW9XONLXZVkTiutj81njIN+5w2xvTCmWWnBzCKkS/mEZ4nJL6gdUUHUzIL7q0XbHt4IfK8P7YDdhEXWDe4qvckRK/Fb+7StqcuoZfeyOWUmW87yYeBDv5AKRkTrr+S5BY9EMV/ski71wGFmADaAjQ6fKcEKIl/w4SGug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(55236004)(8936002)(8676002)(478600001)(71200400001)(54906003)(6486002)(316002)(86362001)(6506007)(122000001)(966005)(7416002)(186003)(38100700002)(6916009)(2906002)(66946007)(76116006)(66446008)(26005)(4326008)(83380400001)(6512007)(33656002)(66556008)(9686003)(64756008)(66476007)(85182001)(1076003)(5660300002)(37363001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K3Q5clJ2c1Y0M0lvNHIrT3I2aU01VHJmNm4xTWNWbFFIYklkZ1pLVnRjYjNX?=
 =?utf-8?B?cXc5V2N0eWFzS3lwbGVtbE9hNXpCYnlDdTIyeWFmYTQ5N1YwNUZkajQ0L2ov?=
 =?utf-8?B?RlpmbU9mVktXbk8vMFRkbVlQTTVmcjNIRm9DL2RRTDBIS2p1a3hFczNKd0NY?=
 =?utf-8?B?eVlaelhXU2NaMkEwVnFJS0lzSEN3YWtqL20vckhaU0Y1aWRCSnFpRnR5STVW?=
 =?utf-8?B?UjdiU2xJU0FIdWk3MXNjN1IrUW5EMkcvL0xSdWRLeHd4T3BXcnRGYUVDTzk2?=
 =?utf-8?B?TzBndlZHbjVpd3pjSWJRWWZMcURJS0dkcUdsMTVvWDRZc0xVZ0k1OEorT0pY?=
 =?utf-8?B?M2sxQ1ZhZW8rV3JURW1kMXJOZGR6bHp3U3FiUGpGSFFDamJ4dlhZOU9obEh3?=
 =?utf-8?B?MThqcDVCV0l3VXY4RnJkdUZEQk9MNFJ2K2R1V0F1M0hiejVmYlVOOGVhVDhw?=
 =?utf-8?B?dTM0WjZyNGpGNGdMWEpXL2hEaGFRVDIxeVhDM2FEbmFKdTNEckJQa29ZNTJ1?=
 =?utf-8?B?MTc3OUtkYjdyaTJ3TWdTWVkya3M3RjE5d09GVG45M1FNcTd5Q2RJaXBsL1hS?=
 =?utf-8?B?NG1qVHBkNjcrSjhZYTZPdFlyaC9CTFJTd2ZRVnhUd0FqanpaK2g3SWVMYjBN?=
 =?utf-8?B?c3kxNWxoM3RyWk05eUc5bWVpMUhmRUVsN0JiOHBzTnQ1V2pnbkM3QU01YW10?=
 =?utf-8?B?VG1RUWMxSDNzY2VCd0hlRUwrRk0zbmFONm8xT3ZZbXJmT0l3Z25za1R5UzdU?=
 =?utf-8?B?dTEvZ0dCK0tjR1ZrSkhra0hHNUh2OWR0S1V1YXJmbzVBZmR0bFJ1TStpNzAw?=
 =?utf-8?B?TkIvMGxUYjRHYWpuZ2l4T0ZmZUxPZytYWXkvTHYyQWNVOElrd1h4dFZRZmp1?=
 =?utf-8?B?bzlUK3ZOdzk5Q1BGcTFYeGl4ejRBejBWT1FvbDIwQWtreVlwVnVIUkRMbFY3?=
 =?utf-8?B?dGZwMGkrWFlwaTltNDlMN2M4UmFDSjlpamhlbW1UNzNNNWU1bzZZWkF5U2NE?=
 =?utf-8?B?SVdkZ0owYW5VU04vTWE0VXF5VnVIbDFmUTlEWjNkZnBXMEFmVkxwWmR1Wm9Q?=
 =?utf-8?B?V20zekRGWFBaWXNPdDJQdkdrSmVBQk9RZ1J3ckxWQm93YzU1N2dZajZ1WXJR?=
 =?utf-8?B?Tjd4SFBxbjN2TjBydHA0YkowNzZQdDZocksrUy95UDZnU3N3bmhTdFVZelhO?=
 =?utf-8?B?RDIxU2xxS25mamdUQ1FUUFpIak55dFNSTlliWWV1ZFo5T0NRd1YrQnMyNWV3?=
 =?utf-8?B?dDlaTEgvelRCa05rL2gxbDZ3WkUvNEl3eVpLWW91UXJONDhqNTlBMFI0TWVJ?=
 =?utf-8?B?dkVwWTZ0dUJxc0RqYjRQVEdmVDdQdFhodXVLZkFGL3U5L05ua1hOeVl2azFY?=
 =?utf-8?B?TFdRMllFMXFvaW5IRVZZR0ZpQUxBUVR0QSszU2w1Q081a3h0ckJRMFBKR0kr?=
 =?utf-8?B?N2R0RlZvSTRydWVHWmZaUTRxOElQUlVGbTNLNzJabExwTlZ6QWxEVk93Z3FM?=
 =?utf-8?B?YXdDM0R0Q1RWN1ZZNGlPQ0kzY2VJamUwVnZDb2hncVVhejBKdTIxRHR5MkEv?=
 =?utf-8?B?V0haRnVkQnBZVFNwVFUrMXFTdXRYLzBtN3YwaHJmUXlIQUNaZWd3Ym44UXB2?=
 =?utf-8?B?UUdzYzBKdE95eUdLZTRQVEQvTTg3R1lOciswdWpkb21ZeENrWEt5dmh3SzhF?=
 =?utf-8?B?TVlJdTZvNW5aZnJWVUpKd3RrK1B2WFJiOWNoSmZoV0E1YnJDenFuNFdIdXBy?=
 =?utf-8?Q?R6feFJr6SZ5r3j8nRRs2A7fi5teAmAlYipdlOdT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B39C9AC6FA55BF49BDB5D2387A623B8A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6730f5-3ae7-4d39-307f-08d905fe18b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 02:18:34.3263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZsyPrUiz9XpvXFHmM3Z+EOAAWhfZHaYjFOwu8InITXE2Yz3x604oBbo8JW8LwNWqu6JTFoa2bzSv0acX1kIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3501
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMjIsIDIwMjEgYXQgMDc6MDI6MTNQTSArMDIwMCwgQm9yaXNsYXYgUGV0a292
IHdyb3RlOg0KPiBPbiBXZWQsIEFwciAyMSwgMjAyMSBhdCAwOTo1NzoyOEFNICswOTAwLCBOYW95
YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJvbTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3Jp
Z3VjaGlAbmVjLmNvbT4NCj4gPiANCj4gPiBUaGUgcHJldmlvdXMgcGF0Y2ggc29sdmVzIHRoZSBp
bmZpbml0ZSBNQ0UgbG9vcCBpc3N1ZSB3aGVuIG11bHRpcGxlDQo+IA0KPiAicHJldmlvdXMgcGF0
Y2giIGhhcyBubyBtZWFuaW5nIHdoZW4gaXQgaXMgaW4gZ2l0Lg0KPiANCj4gPiBNQ0UgZXZlbnRz
IHJhY2VzLiAgVGhlIHJlbWFpbmluZyBpc3N1ZSBpcyB0byBtYWtlIHN1cmUgdGhhdCBhbGwgdGhy
ZWFkcw0KPiANCj4gCSAgICAicmFjZS4iDQo+IA0KPiA+IHByb2Nlc3NpbmcgQWN0aW9uIFJlcXVp
cmVkIE1DRXMgc2VuZCB0byB0aGUgY3VycmVudCBwcm9jZXNzZXMgdGhlDQo+IA0KPiBzL3RoZSAv
Lw0KDQpJJ2xsIGZpeCB0aGVzZSBncmFtbWFyIGVycm9ycy4NCg0KPiANCj4gPiBTSUdCVVMgd2l0
aCB0aGUgcHJvcGVyIHZpcnR1YWwgYWRkcmVzcyBhbmQgdGhlIGVycm9yIHNpemUuDQo+ID4gDQo+
ID4gVGhpcyBwYXRjaCBzdWdnZXN0cyB0byBkbyBwYWdlIHRhYmxlIHdhbGsgdG8gZmluZCB0aGUg
ZXJyb3IgdmlydHVhbA0KPiANCj4gQXZvaWQgaGF2aW5nICJUaGlzIHBhdGNoIiBvciAiVGhpcyBj
b21taXQiIGluIHRoZSBjb21taXQgbWVzc2FnZS4gSXQgaXMNCj4gdGF1dG9sb2dpY2FsbHkgdXNl
bGVzcy4NCj4gDQo+IEFsc28sIGRvDQo+IA0KPiAkIGdpdCBncmVwICdUaGlzIHBhdGNoJyBEb2N1
bWVudGF0aW9uL3Byb2Nlc3MNCj4gDQo+IGZvciBtb3JlIGRldGFpbHMuDQoNCkkgZGlkbid0IGtu
b3cgdGhlIGZvbGxvd2luZyBydWxlOg0KDQogICAgRGVzY3JpYmUgeW91ciBjaGFuZ2VzIGluIGlt
cGVyYXRpdmUgbW9vZCwgZS5nLiAibWFrZSB4eXp6eSBkbyBmcm90eiINCiAgICBpbnN0ZWFkIG9m
ICJbVGhpcyBwYXRjaF0gbWFrZXMgeHl6enkgZG8gZnJvdHoiIG9yICJbSV0gY2hhbmdlZCB4eXp6
eQ0KICAgIHRvIGRvIGZyb3R6IiwgYXMgaWYgeW91IGFyZSBnaXZpbmcgb3JkZXJzIHRvIHRoZSBj
b2RlYmFzZSB0byBjaGFuZ2UNCiAgICBpdHMgYmVoYXZpb3VyLg0KDQpJJ2xsIGZvbGxvdyB0aGlz
IGluIG15IGZ1dHVyZSBwb3N0Lg0KDQo+IA0KPiA+IGFkZHJlc3MuICBJZiB3ZSBmaW5kIG11bHRp
cGxlIHZpcnR1YWwgYWRkcmVzc2VzIGluIHdhbGtpbmcsIHdlIG5vdyBjYW4ndA0KPiANCj4gV2hv
J3MgIndlIj8JCQkJZHVyaW5nIHRoZSBwYWdldGFibGUgd2Fsaw0KDQpJIHdyb25nbHkgYWJ1c2Vk
IHJoZXRvcmljYWwgIndlIi4gSSdsbCBjaGFuZ2UgdGhpcyBzZW50ZW5jZSBpbiBwYXNzaXZlIGZv
cm0uDQoNCj4gDQo+ID4gZGV0ZXJtaW5lIHdoaWNoIG9uZSBpcyBjb3JyZWN0LCBzbyB3ZSBmYWxs
IGJhY2sgdG8gc2VuZGluZyBTSUdCVVMgaW4NCj4gPiBraWxsX21lX21heWJlKCkgd2l0aG91dCBl
cnJvciBpbmZvIGFzIHdlIGRvIG5vdy4gIFRoaXMgY29ybmVyIGNhc2UgbmVlZHMNCj4gPiB0byBi
ZSBzb2x2ZWQgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IFNvbHZlZCBob3c/DQoNCkkgZG9uJ3Qga25v
dyBleGFjdGx5LiAgTUNFIHN1YnN5c3RlbSBzZWVtcyB0byBoYXZlIGNvZGUgZXh0cmFjdGluZyBs
aW5lYXINCmFkZHJlc3MsIHNvIEkgd29uZGVyIHRoYXQgdGhhdCBjb3VsZCBiZSB1c2VkIGFzIGEg
aGludCB0byBtZW1vcnlfZmFpbHVyZSgpDQp0byBmaW5kIHRoZSBwcm9wZXIgdmlydHVhbCBhZGRy
ZXNzLg0KDQo+IElmIHlvdSBjYW4ndCBtYXAgd2hpY2ggZXJyb3IgY29tZXMgZnJvbSB3aGljaCBw
cm9jZXNzLCB5b3UNCj4gY2FuJ3QgZG8gYW55dGhpbmcgaGVyZS4gWW91IGNvdWxkIHNlbmQgU0lH
QlVTIHRvIGFsbCBidXQgeW91IG1pZ2h0DQo+IGluanVyZSBzb21lIGlubm9jZW50IGJ5c3RhbmRl
cnMgdGhpcyB3YXkuDQoNClRoZSBzaXR1YXRpb24gaW4gcXVlc3Rpb24gaXMgY2F1c2VkIGJ5IGFj
dGlvbiByZXF1aXJlZCBNQ0UsIHNvDQp3ZSBrbm93IHdoaWNoIHByb2Nlc3Mgd2Ugc2hvdWxkIHNl
bmQgU0lHQlVTIHRvLiBTbyBpZiB3ZSBjaG9vc2UNCnRvIHNlbmQgU0lHQlVTIHRvIGFsbCwgbm8g
aW5ub2NlbnQgYnlzdGFuZGVycyB3b3VsZCBiZSBhZmZlY3RlZC4NCkJ1dCB3aGVuIHRoZSBwcm9j
ZXNzIGhhdmUgbXVsdGlwbGUgdmlydHVhbCBhZGRyZXNzZXMgYXNzb2NpYXRlZA0Kd2l0aCB0aGUg
ZXJyb3IgcGh5c2ljYWwgYWRkcmVzcywgdGhlIHByb2Nlc3MgcmVjZWl2ZXMgbXVsdGlwbGUNClNJ
R0JVU3MgYW5kIGFsbCBidXQgb25lIGhhdmUgd3JvbmcgdmFsdWUgaW4gc2lfYWRkciBpbiBzaWdp
bmZvX3QsDQpzbyB0aGF0J3MgY29uZnVzaW5nLg0KDQo+IA0KPiBKdXN0IGNvZGUgc3RydWN0dXJp
bmcgc3VnZ2VzdGlvbnMgYmVsb3cgLSBtbSBzdHVmZiBpcyBmb3Igc29tZW9uZSBlbHNlDQo+IHRv
IHJldmlldyBwcm9wZXJseS4NCg0KVGhhbmsgeW91LCBJJ2xsIHVwZGF0ZSB3aXRoIHRoZW0uDQoN
Ci0gTmFveWEgSG9yaWd1Y2hpDQoNCj4gDQo+ID4gK3N0YXRpYyBpbnQgaHdwb2lzb25fcHRlX3Jh
bmdlKHBtZF90ICpwbWRwLCB1bnNpZ25lZCBsb25nIGFkZHIsDQo+ID4gKwkJCSAgICAgIHVuc2ln
bmVkIGxvbmcgZW5kLCBzdHJ1Y3QgbW1fd2FsayAqd2FsaykNCj4gPiArew0KPiA+ICsJc3RydWN0
IGh3cF93YWxrICpod3AgPSAoc3RydWN0IGh3cF93YWxrICopd2Fsay0+cHJpdmF0ZTsNCj4gPiAr
CWludCByZXQgPSAwOw0KPiA+ICsJcHRlX3QgKnB0ZXA7DQo+ID4gKwlzcGlubG9ja190ICpwdGw7
DQo+ID4gKw0KPiA+ICsJcHRsID0gcG1kX3RyYW5zX2h1Z2VfbG9jayhwbWRwLCB3YWxrLT52bWEp
Ow0KPiA+ICsJaWYgKHB0bCkgew0KPiANCj4gU2F2ZSB5b3Vyc2VsZiBhbiBpbmRlbnRhdGlvbiBs
ZXZlbDoNCj4gDQo+IAlpZiAoIXB0bCkNCj4gCQlnb3RvIHVubG9jazsNCj4gDQo+ID4gKwkJcG1k
X3QgcG1kID0gKnBtZHA7DQo+ID4gKw0KPiA+ICsJCWlmIChwbWRfcHJlc2VudChwbWQpKSB7DQo+
IA0KPiAuLi4gZGl0dG8uLi4NCj4gDQo+ID4gKwkJCXVuc2lnbmVkIGxvbmcgcGZuID0gcG1kX3Bm
bihwbWQpOw0KPiA+ICsNCj4gPiArCQkJaWYgKHBmbiA8PSBod3AtPnBmbiAmJiBod3AtPnBmbiA8
IHBmbiArIEhQQUdFX1BNRF9OUikgew0KPiA+ICsJCQkJdW5zaWduZWQgbG9uZyBod3BvaXNvbl92
YWRkciA9IGFkZHIgKw0KPiA+ICsJCQkJCSgoaHdwLT5wZm4gLSBwZm4pIDw8IFBBR0VfU0hJRlQp
Ow0KPiANCj4gLi4uIHdoaWNoIHdpbGwgYWxsb3cgeW91IHRvIG5vdCBicmVhayB0aG9zZS4NCj4g
DQo+ID4gKw0KPiA+ICsJCQkJcmV0ID0gc2V0X3RvX2tpbGwoJmh3cC0+dGssIGh3cG9pc29uX3Zh
ZGRyLA0KPiA+ICsJCQkJCQkgIFBBR0VfU0hJRlQpOw0KPiA+ICsJCQl9DQo+ID4gKwkJfQ0KPiA+
ICsJCXNwaW5fdW5sb2NrKHB0bCk7DQo+ID4gKwkJZ290byBvdXQ7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJaWYgKHBtZF90cmFuc191bnN0YWJsZShwbWRwKSkNCj4gPiArCQlnb3RvIG91dDsNCj4g
PiArDQo+ID4gKwlwdGVwID0gcHRlX29mZnNldF9tYXBfbG9jayh3YWxrLT52bWEtPnZtX21tLCBw
bWRwLCBhZGRyLCAmcHRsKTsNCj4gPiArCWZvciAoOyBhZGRyICE9IGVuZDsgcHRlcCsrLCBhZGRy
ICs9IFBBR0VfU0laRSkgew0KPiA+ICsJCXJldCA9IGNoZWNrX2h3cG9pc29uZWRfZW50cnkoKnB0
ZXAsIGFkZHIsIFBBR0VfU0hJRlQsDQo+ID4gKwkJCQkJICAgICBod3AtPnBmbiwgJmh3cC0+dGsp
Ow0KPiA+ICsJCWlmIChyZXQgPT0gMSkNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwl9DQo+ID4gKwlw
dGVfdW5tYXBfdW5sb2NrKHB0ZXAgLSAxLCBwdGwpOw0KPiA+ICtvdXQ6DQo+ID4gKwljb25kX3Jl
c2NoZWQoKTsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gDQo+IA0KPiAtLSANCj4gUmVn
YXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0KPiANCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9y
Zy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCj4g
