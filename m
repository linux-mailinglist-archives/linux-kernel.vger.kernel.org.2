Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36439F1DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFHJPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:15:50 -0400
Received: from mail-eopbgr1400049.outbound.protection.outlook.com ([40.107.140.49]:63312
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231239AbhFHJPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:15:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu6GVRYoV1GKDExUHao3Fr9VIrL+dheCbhvDBrsv9Ydzf3npjVyL9cSkoWHJgBvby/XqvhJcrgUirAhWP8CQKq0ah7NES4Sm+JAzetxQ6HYCj7GAnP93L/lAsOMxoGuOnHGIyjtd4Z0Huz08irhXjqJ+SoB/GLwFEpDb23Y+nW2tMTzRFgxT9Z11but2rw6shJlospM2KxDQAoxLk23fK9tcWj8Ewuw8DKZ6ymb9eo1ckSH3OLoLvonMHZ0UQD1wgoiydaeqfFTpNZ0+Jf1/0ePv4HoF7xhnTKu2WqsHcKvfk/0iO/TnU1+PQlhQrN4PyX2PObYZrC8taess0jAk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogDvmBpaMgyO4q3Vb3+x88yb20R2KpI7G/lp52bUHew=;
 b=aAc6Hh8756cUaFluvy152Tc8OIZAkIKB9kghPMjW6/VRUpQCdu3cMAaNzcxIg+6Rj9S7mWm/7xYJQIDD4Ye84WTH9TM8LGq4J/8M80LGbAoMjKcHOUdVZWIkqRqwKrwXFtD2p/ZzpeKdEfcfR/F7yWBnCI+kxYCkb24j/XzEwzcqOa9lAzyk6fK1kK6htu1c9bUMyYPvMgAWLfz7c+mSv3J1Ov4TI2vR8Md/gja1ms5tRqxV5h1H2Yy/baaxLmZ8Z8fhzJhJpOvI6yqHYXqrCXrV/grLbCm8c5520Rtv0JEllkfCNPSLg9S0g3yRTWPviuEaHFzXtZff5WeqLv33eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogDvmBpaMgyO4q3Vb3+x88yb20R2KpI7G/lp52bUHew=;
 b=dWaIGelqooNetkZdtx0ZJtBAWBImzN+to5RFoOqs0F9sfNHQSi67FF4WWGLYgFWOLvoR2lGEXXWVlf04CqoNBSzyxEk5+v7rj4LK1uqdH5XI+wQfKWNEGSI1SyE0i4cEoxcXYQifL+lM5c9sbCmS2trF16vPjUoELioNrZKukt0=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB5929.jpnprd01.prod.outlook.com (2603:1096:404:8054::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 09:13:52 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 09:13:52 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     wangbin <wangbin224@huawei.com>
CC:     "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "wuxu.wu@huawei.com" <wuxu.wu@huawei.com>
Subject: Re: Re: [PATCH] mm: hugetlbfs: add hwcrp_hugepages to record memory
 failure on hugetlbfs
Thread-Topic: Re: [PATCH] mm: hugetlbfs: add hwcrp_hugepages to record memory
 failure on hugetlbfs
Thread-Index: AQHXXEaZ5B4OXXAV8U2+2LEwnPpSoQ==
Date:   Tue, 8 Jun 2021 09:13:52 +0000
Message-ID: <20210608091352.GA943097@hori.linux.bs1.fc.nec.co.jp>
References: <b4a6c7ee-5b0c-2390-35c5-3a5255d77f5d@oracle.com>
 <20210608022450.2044-1-wangbin224@huawei.com>
In-Reply-To: <20210608022450.2044-1-wangbin224@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ecf864d-a1d9-47c8-e548-08d92a5dbc28
x-ms-traffictypediagnostic: TYAPR01MB5929:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB592920B9FBB2BEF7CF19585FE7379@TYAPR01MB5929.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UibkTF6TqZybjRoMRBY2rMJ/Z0homq77w5ainZc8JURIYKotGVH/vupYUfCTY7ScSatkG/o/NLjZucKX5/mt7CIAFFAe6WMk4wdkRpgrLxZ13RDL9DiRNZXuZ3bJTzbvKu7HNRLe/FVau39SEfVTxzgjGyeahQHmzAAPicovSYGEPRpa6VbHdRW0N/cTAl/RuPkq07hD6UclDK/Geh3PkGga7+dM1G8MIPLZ0cnmQJtFewB+avhxH5EUO0KpsgahyK+pr5zbIIaDZrcCsnAB4MePhZOgDfxdSbgYgLeGJinQ2xIlRnRyLAmn+HMuqNg7RQ/2n2zhtqE1NZdyQtbx76HtS+9CaW5QOymLLKHhVh5npR5KYaFAyvAXGlq+FNJomaycYouPwQDwvtD5CFHon7xvx462DT4l77kbJjMWl+NAPlNy8/B+4A3m4TS68e7rhoD2Pe1TNxL2BlGD6yXhZeIVKTrvlZ+JviD0J1LKhwdlaes3E+zBgmt3dm/ZV6UCIAidrxgw5aGJd+V34IX0qGY5yVbW7AFsmeUeXu0JRThe4jDjl0FHgrXYjjnM731s/igHNiPTRUfuydeNUK60RixNKN8fCSvl8a0rFik4QXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(6486002)(122000001)(6512007)(9686003)(6916009)(5660300002)(33656002)(66476007)(71200400001)(1076003)(26005)(66556008)(8676002)(4326008)(8936002)(83380400001)(38100700002)(6506007)(76116006)(186003)(66946007)(478600001)(2906002)(86362001)(54906003)(55236004)(64756008)(316002)(85182001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MHRNcDA5dGl3OWxlTm5SWUFteXVxR0FSMVoyNVRMNEpHYmZ5amVzaU4rWGo3?=
 =?utf-8?B?c1loZlN5MjUvYjhScjhFeEtIMElNMTFFNGNxWE04bWdXWWl0TitOdzllSzMz?=
 =?utf-8?B?dmhEdnRzYXVFQkI1KzFtRGkyMFdOcW5oM2oycUNKNVFBbEtDR21pRXlSUkFk?=
 =?utf-8?B?SG1IMEJqdi9JU3h4Slc1ekhUdGlaN2pqTmNYN2YyRnFORWJ4eTFNY1J3cW5I?=
 =?utf-8?B?MnNic2UwR3pXWFV3bW5KdXRaZmp4R0JxbzEzQUhsVWMxei81dFV0Y0VGeVQ5?=
 =?utf-8?B?NEN0WXZ2TTJka3RMVjBzYkZRb3ZselNVc2w2VC9DdmZHbFJJK3BJNjFsbzBa?=
 =?utf-8?B?MTVMRmxoWFRlUXFFVnRUTzZpcm9vZTQrTXkySkdQWWNrc082eHh5NWtDdUJE?=
 =?utf-8?B?eDN4UnhOMzJPajJyUVk3bmxVZXkrQTFQN1R3c1R5ZXBtc0hJM1NKWmFzOS8z?=
 =?utf-8?B?NDk3eVB1SUlFcjFtTkNDcElsMHlXYi9NRXVKOGhoQ0hqYVB2TlgyWWJyNzcz?=
 =?utf-8?B?aEFOWms0RGtxUXBUWUVMVy80aXkrS3Rua00wbkpMZE1RWWxyUjhtd0kvVkV1?=
 =?utf-8?B?cFFXcXJpVk5LZ3dqbGNlZExiYm9nRnFJbkpxQVJFWFVYQUQwa1RoWHN3Z3FX?=
 =?utf-8?B?aEg3N01QK0xnajg0aUJ6L3cvSmFuNWlwVVhsSFpPaHdWcm45SXNvVWlFNm5B?=
 =?utf-8?B?ckM1bytGczFOOW16MzJ0NEZiejZuWGtJRXRqSlpqUVh4V2VyNTNMbVpuNExV?=
 =?utf-8?B?RnNVeVl0ZjJTamxBTnJtdC9HZUN6Ny9ReXZjWDRPdEsyeThkNkRPNWh2TFhx?=
 =?utf-8?B?VnhiNExxZTRocmtVeUtFbGk2TmNRcGprZVdKT0kzYVVmOFhRaFRQUnBDU1NP?=
 =?utf-8?B?MnoyZ3JhVnhOS2xEV0NNL3lMaElLL3N5Ui8vT0wrVG1WNVZ1REx1UnR6bzhF?=
 =?utf-8?B?YWw2ZkVKS2tYaDhPaU9odTQvTTVyQXFucU1Qd21qY2N4Q1lqSFBFOGc0V3hT?=
 =?utf-8?B?aGgyZi8yVlZYRnNMTWxDTnlLWndwa2RDLzlYR0pVRTBYR3ZBRzNZdDgxc1JK?=
 =?utf-8?B?d240ZmZ1M2VxeURaR0pndW5zL2NkL2xZWVpWRWRDR1plSXowd0ZpTVJCY3RX?=
 =?utf-8?B?Sk5mVk1PaGVGY3VKQ2Y4QUlWc2wxUXlNaCtoc1pMRWFNSWVFWE81QStpZWVO?=
 =?utf-8?B?Qm4vbzJwaU82VC95L01hNnIzSlZlam5STjdyUHV6V1Q4cWdzYTNtVWg2Tk1D?=
 =?utf-8?B?Q2RvbGVsdVhOWmpSNTRkYVVsWU9hYXJmb0liQkVvdUZtRjZabFZqTzRWMjVF?=
 =?utf-8?B?dVdiWTdQdGFLLzVXRXZwR3o5T1hCQTUydC8xUERBaUE2enpZTFh3cDhUeXdx?=
 =?utf-8?B?NkwzblZwYmFQTzZzQ2RiZnBkbGxlZVFGVEdaRXlHY3Q2bFZIQW81bkI0SEtG?=
 =?utf-8?B?STRqaUk2V2RKNDRjSGVrNGV2YXNRZ0IwRDRBYjJnM05MQU14UkJVV0hTK3NP?=
 =?utf-8?B?OWZMMGZUN29FNnVyRU5KRmlTV0FudEE0bXUxNTdFbFF4M2xmN3NISGMvZ21J?=
 =?utf-8?B?bDI0L0MySWpacUNVaHovOHNVYUYyZW9BakZQUUZzc3JuY3lJd3hyR3p4UCsv?=
 =?utf-8?B?bi9GdGZmY2x2dHhtUTRrenNrUmxrRS9XVUxOU1ZVT29USytWaDVtTGV4WldI?=
 =?utf-8?B?bnVhUjlYNkIzNHNwczhSdml2dG1vN2pPTGloNk5hZUQ5eWliRjN0R3U4MTU3?=
 =?utf-8?Q?ERgLdAL8/IqASCTt8mkz4/unc6QGC8RqaonPuXQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3A7B5593415014FAD539E21E633ACE1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecf864d-a1d9-47c8-e548-08d92a5dbc28
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 09:13:52.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAyg7gQSpo6gREICkKdqL1Zn3mrHrbwmsq2rlsgs8y5S39Tq9IuzHOdjEFF+G8RdeyuLzRJF2S4GCBYYf7Uogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5929
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMDgsIDIwMjEgYXQgMTA6MjQ6NTBBTSArMDgwMCwgd2FuZ2JpbiB3cm90ZToN
Cj4gPiBXaGF0IHNwZWNpZmljIHByb2JsZW0gYXJlIHlvdSB0cnlpbmcgdG8gc29sdmU/ICBBcmUg
dHJ5aW5nIHRvIHNlZSBob3cNCj4gPiBtYW55IGh1Z2UgcGFnZXMgd2VyZSBoaXQgYnkgbWVtb3J5
IGVycm9ycz8NCj4gDQo+IFllcywgSSdkIGxpa2UgdG8ga25vdyBob3cgbWFueSBodWdlIHBhZ2Vz
IGFyZSBub3QgYXZhaWxhYmxlIGJlY2F1c2Ugb2YNCj4gdGhlIG1lbW9yeSBlcnJvcnMuIEp1c3Qg
bGlrZSBIYXJkd2FyZUNvcnJ1cHRlZCBpbiB0aGUgL3Byb2MvbWVtaW5mby4NCj4gQnV0IHRoZSBI
YXJkd2FyZUNvcnJ1cHRlZCBvbmx5IGFkZHMgb25lIHBhZ2Ugc2l6ZSB3aGVuIGEgaHVnZSBwYWdl
IGlzDQo+IGhpdCBieSBtZW1vcnkgZXJyb3JzLCBhbmQgbWl4ZXMgd2l0aCBub3JtYWwgcGFnZXMu
IFNvIEkgdGhpbmsgd2Ugc2hvdWxkDQo+IGFkZCBhIG5ldyBjb3VudHMgdG8gdHJhY2sgdGhlIG1l
bW9yeSBlcnJvcnMgb24gaHVnZXRsYmZzLiANCg0KSWYgeW91IGNhbiB1c2Ugcm9vdCBwcml2aWxl
Z2UgaW4geW91ciB1c2UtY2FzZSwgYW4gZWFzeSB3YXkgdG8gZ2V0IHRoZQ0KbnVtYmVyIG9mIGNv
cnJ1cHRlZCBodWdlcGFnZXMgaXMgdG8gdXNlIHBhZ2UtdHlwZXMuYyAod2hpY2ggcmVhZHMNCi9w
cm9jL2twYWdlZmxhZ3MpIGxpa2UgYmVsb3c6DQoNCiAgICAkIHBhZ2UtdHlwZXMgLWIgaHVnZSxo
d3BvaXNvbj1odWdlLGh3cG9pc29uDQogICAgICAgICAgICAgICAgIGZsYWdzICAgICAgcGFnZS1j
b3VudCAgICAgICBNQiAgc3ltYm9saWMtZmxhZ3MgICAgICAgICAgICAgICAgICAgICBsb25nLXN5
bWJvbGljLWZsYWdzDQogICAgMHgwMDAwMDAwMDAwMGE4MDAwICAgICAgICAgICAgICAgMSAgICAg
ICAgMCAgX19fX19fX19fX19fX19fSF9HX1hfX19fX19fX19fX19fX19fX19fX19fXyAgICAgICAg
Y29tcG91bmRfaGVhZCxodWdlLGh3cG9pc29uDQogICAgICAgICAgICAgICAgIHRvdGFsICAgICAg
ICAgICAgICAgMSAgICAgICAgMA0KDQoNCkJ1dCBJIGd1ZXNzIHRoYXQgbWFueSB1c2VjYXNlcyBk
byBub3QgcGVybWl0IGFjY2VzcyB0byB0aGlzIGludGVyZmFjZSwNCndoZXJlIHNvbWUgbmV3IGFj
Y291bnRpbmcgaW50ZXJmYWNlIGZvciBjb3JydXB0ZWQgaHVnZXBhZ2VzIGNvdWxkIGJlDQpoZWxw
ZnVsIGFzIHlvdSBzdWdnZXN0Lg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
