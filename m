Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B998537F03F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhEMAGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:06:46 -0400
Received: from mail-eopbgr1410059.outbound.protection.outlook.com ([40.107.141.59]:40864
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236850AbhEMAES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:04:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIFMD91d9veIv0fNMffaRj0Mmk3W/dJ07wUSKJALxgjHztQWCYeyN6wwdxsnV2kfMoZoWjCFSPDRNr//rp3PAYguynKsffRRIYO7NC0AomgLHu+wrBwf7iK4J0FlDY/+Vyxpvh56eHHqnQwEPm5SMKeughKJMZa3uCyFzDad+s86d4ia+DpqG/SA1TXgYxv1A9JBPp6AoZzw5sDx79xTTQKxxCh1h4EG7Xmm4cyT7PIrjTR/EIJohHkprvFAq03/6bx0zFJenQAY65zIMc+d+eEJNL35QcDQ4P+lxRAEIc+/J2QKfgWrJaKDAtBaQ3tj+fCPGgrU46V3Vs/PRwLi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PexqcUkKNNC2y/YgY3fQq9B78NEnpz6KgKuIpMQnno4=;
 b=Ic/9yHyZNCQ0uKwwEtade69MQLsdeGmKOjUZRvsoudEkfjx54yPeX1XJYOBKTndBWzNgalCSoUhjQqlrOHxKbZ2IQuyvoYuWX4vXZV5jHIFL9b+4CNRuqivq3B/Y3PYkPKuRybsGN1Bu/9H9N0WpRHILZMefYvTKvp9g2XRAhYmuA/hHCteIdDqlEzMQYornOLdW57HuFE5kVolkOqPB6mdoyNEsHvuLvj1Y5eXHlAeCRvOv815rM7kW1DzSdEwFWVrrMvV8F476efQFv7384X+Xt45RwUvi0FWiXFIsscogfgZKNkSVOdSdI5V4/9224uuRySxSwIEmFTkyIjcqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PexqcUkKNNC2y/YgY3fQq9B78NEnpz6KgKuIpMQnno4=;
 b=XhDVXJMqmzNoSENWXXYAoVHmfsW182GxZPZhF8LbA51unRSPMf25VDBM7MRq87LkuxpQc325485NnHSGSn6zg/rYVemr5XpLPIY+fmRlNei5FJmS+LIgpGjJ9fmZ+0/bdZk94/JPSFk+wfSRKaEgScTXefWpI20Lvzi5VCNEVeU=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB6527.jpnprd01.prod.outlook.com (2603:1096:400:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 00:03:05 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 00:03:05 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm,hwpoison: make get_hwpoison_page call
 get_any_page()
Thread-Topic: [PATCH v3 2/2] mm,hwpoison: make get_hwpoison_page call
 get_any_page()
Thread-Index: AQHXRnfP8JAXERxuK0yneFsw5KWWQKrfjCUAgAD9m4A=
Date:   Thu, 13 May 2021 00:03:04 +0000
Message-ID: <20210513000303.GB563308@hori.linux.bs1.fc.nec.co.jp>
References: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
 <20210511151016.2310627-3-nao.horiguchi@gmail.com>
 <20210512085522.GB14726@linux>
In-Reply-To: <20210512085522.GB14726@linux>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad1660ac-8c9f-45b9-50dd-08d915a27b8d
x-ms-traffictypediagnostic: TYCPR01MB6527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB6527B3AA728F0B0E7F9F66E3E7519@TYCPR01MB6527.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vXOs+75VDGr3VoT8qcvAub/i39h0MbHIR98oj6OZhtUJ2JiCkyg7HdhKHRlByrDUY6vLk71BjkZUBNa7wuM6QmBAtnM8Q9NZZl2EwvPzifV4yJMAoVez08fDwgSwD9LO/TSwjnsIdSBQG2eCwcVywYdhW/ViV9CeLC8hSS4A4GM4HwjTcdFYeteg1WbRwxZnFmjFnmKPwiWIhd5Qvn9Bcos4sN+fYtfI3gQShWsyelp8znWHzM00TSI80zJSUSMrFSDTH7VQXi02BiXU1oqUsbLss2Ni1J2Utb6XzhK1D62uydB6II2xzqIGjKxf48iJ2h9PFz1rqjBlh5jWvTNWDDLsZhS+Xp8o9TcTfHmZdq48A+TyZAIuYuJ3AUCd6lgxMgpUB1wjBmNk8wcc8RgDzXuV2tOq3DhfLbnqB76aZhoxucaeKOEW3vMOM9AuM2+THDUDw1wJ3ef3RTT3/k4LAYbc0E9KYoduh/qfw8284Pgxd5++wQBYNqh8sgYr8AUB7WI3Z3n0ExRFbsJkk+i9rpuVXBEhOkw1sjhdEvjIiNBc6dSdX+WWq92QabVwanyceEeeR0DhewwkIpLkd0IjdrKJsGXKy1oXvp5CCtZsTRM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(122000001)(83380400001)(2906002)(9686003)(55236004)(6512007)(38100700002)(6506007)(6486002)(1076003)(26005)(186003)(33656002)(76116006)(4326008)(478600001)(86362001)(5660300002)(54906003)(66446008)(8936002)(64756008)(6916009)(8676002)(66476007)(66556008)(66946007)(71200400001)(85182001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cU9LaEZpRkNzMGN4ZktUOEhHbFpiQ1VqY21sUThjZE85UUZUR2tKc3k0cis5?=
 =?utf-8?B?bmhMOFNPb2I5cDF2SFhiKzBIWUtWdkt4Ryt0N3pXUVFXUG5kSHg0Rm9QSWNL?=
 =?utf-8?B?UDJhTmI5c0JRWUlxRm1LRHp0c2ZyMVpGVWQvY3JZU1JUc0lKYWM4V3FnRzIr?=
 =?utf-8?B?UDlhNTVoN1JEVWZISi9McmRlNDRiQTNiSFJIYmtJalhSS01hRjlKYlN5OGFh?=
 =?utf-8?B?cnRqcDdPMUtuV1dIb2xYQk5zWWpKcWhjNkpqQmZkT3NLalBqaE5ndDlMYVh3?=
 =?utf-8?B?Z2tFQXdONmt0djF0TTJLczdTVnJuZVY2RVYyUnIvYnFWMzBLbzR0RWpRRlJV?=
 =?utf-8?B?NHhPMDdKZ3VEVTUxRVhoMllpMVZWZC9IT3dXaEZteDRkeldLYW82Nkp0bU9L?=
 =?utf-8?B?WWlPVHUyU3owN2Z1akZYTm1FcFgyYTJDOUE3UGMzQUtHSlVNTFNkTmlUMGlP?=
 =?utf-8?B?cmxTUC9HaG5PNGJNQkNoUnJ5NVo4VC90MzMyWEJweXhtNTljNVB4ZS9GYU4r?=
 =?utf-8?B?SHhJSmUrVDRWWThiNUZIUFJtaktXTVJJYzlOeHdhVUpYenorQjVLTjAxYjRW?=
 =?utf-8?B?RVBQTlV5WGJhTXAvanhUbU0rNVkxUTBzTHFBaGcrdkRKZTJZd3FYbTlwZmkr?=
 =?utf-8?B?OFhXQkpUS0hiK1RpeGhkN1BRVTNmTmlpWEtkMkhJcE1vb3ZLR0pRR2xyM01r?=
 =?utf-8?B?ZTltMm8wQ3JCendhZkZlYXI1NnZRUWZYOFZyNHFWWWFqUmpQNm9WWS9qazR3?=
 =?utf-8?B?NXN2T2x0S0hZQzZETlhsS3ArNHNpYmk5cExRaklrdGZrTXBJN0IveDZib3hO?=
 =?utf-8?B?ODNFSFFmMlVGQmhEQXFpakJFNGdHMi9INnV1a1dZTFVLdURFYWo2NTNka3d6?=
 =?utf-8?B?TkxwcTU5NUppMGtHd3ZEbXI2TGJnV2VVRGtYS2t5NW45T2JRSzNTUHYxS3NU?=
 =?utf-8?B?cW9KMlV6cWhlQU9EV0oxVGpmNEFmeXJUVzVIajdIcnpzcENnWDFYZGwxc3VN?=
 =?utf-8?B?TFEzdjVlSUdYZzZ4Qzl6VVJ6YUZlUVZPRm40TUxRTzBWVTRXZmtEZ0xJZGxi?=
 =?utf-8?B?OGM0RFB0Zm1TVmI2QjJIWUNwTUdGNEJKM0R6UWtDcGM3dXJSZytsbmd2b2VH?=
 =?utf-8?B?ais2WUgwOUE3eGc1Q3AyRWcyU1pITHBDcWhWSzFobVkrUlRBa21iT1Eyb2F1?=
 =?utf-8?B?ZmJjbUpudlJ3Snd0UWJLaGVsb3FvdFdQK2ZNZVNZTFhxemFDWEVXNlRuR3A1?=
 =?utf-8?B?cUVKeEl6bklDNFgrRUI4UGpNNnJYOWxSR25BTEpMaVV4WHhoOGpvaXcwMHpK?=
 =?utf-8?B?eGNuKzJvdy9mNVVNTGdhaXFCbmVjU2Q1MVI3elAyRHgvVWpKZVROTWppTDd2?=
 =?utf-8?B?NU1SOW1RV1BKV1JWajBxbS8xRTlsYS9kUklQaXZtWnNDWDQ4Z2JxMloyUm40?=
 =?utf-8?B?WHR1YjFPdlhocHN4amhBdVhBSENBazhqRmZ2MzcxditGUUNFTHZPd29zL0t1?=
 =?utf-8?B?cjJEZkpLbDJxMlhXOXczMHlWOFdKenNnMFpDNDNHWEJUVThCSS9wTUxQVEU3?=
 =?utf-8?B?WWI2WmlFc2dSVUpTUGxoTGl1YkFya050Y1I0WnBGOEdIZmJ0Mk8zYUFUZGJp?=
 =?utf-8?B?RHVjUndmUDBwd3dUSlcwbkIvUFlxcVZERDAybmh3L09uMm05ViszcmhEcFdv?=
 =?utf-8?B?VlF4bmlMMDlOOExJTjEva1RnSnhXdWR5WGM0N3ZKMTkvQ1VFOHJ4eUpIQTdo?=
 =?utf-8?Q?YlPV7s83pg9m1yEhhfkf4kx2hhTNlE6BB7rGDJE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79712EF81987FF4B81B7D330A021C8EB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1660ac-8c9f-45b9-50dd-08d915a27b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 00:03:05.0490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAxvWeV0VaLT1uJbTETxfNL+gzZ/zekj9SqRLOhcfu0atCE0piXW+wUy1OICHBBLxZichFUXoJHKHNSuNfqEPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6527
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTIsIDIwMjEgYXQgMTA6NTU6MjJBTSArMDIwMCwgT3NjYXIgU2FsdmFkb3Ig
d3JvdGU6DQo+IE9uIFdlZCwgTWF5IDEyLCAyMDIxIGF0IDEyOjEwOjE2QU0gKzA5MDAsIE5hb3lh
IEhvcmlndWNoaSB3cm90ZToNCj4gPiBGcm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmln
dWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+IE5vdyBfX2dldF9od3BvaXNvbl9wYWdlKCkgY291bGQg
cmV0dXJuIC1FQlVTWSBpbiBhIHJhY2UgY29uZGl0aW9uLA0KPiA+IHNvIGl0J3MgaGVscGZ1bCB0
byBoYW5kbGUgaXQgYnkgcmV0cnlpbmcuICBXZSBhbHJlYWR5IGhhdmUgcmV0cnkNCj4gPiBsb2dp
Yywgc28gbWFrZSBnZXRfaHdwb2lzb25fcGFnZSgpIGNhbGwgZ2V0X2FueV9wYWdlKCkgd2hlbiBj
YWxsZWQNCj4gPiBmcm9tIG1lbW9yeV9mYWlsdXJlKCkuDQo+IA0KPiBBcyBJIHN0YXRlZCBpbiB5
b3VyIHByZXZpb3VzIHBhdGNoLCBJIHRoaW5rIHlvdSBzaG91bGQgc3RhcnQgcmV0dXJuaW5nIC1F
QlVTWQ0KPiBmcm9tIHRoaXMgcGF0Y2ggb253YXJkcy4NCj4gDQo+ID4gIHN0YXRpYyBpbnQgZ2V0
X2FueV9wYWdlKHN0cnVjdCBwYWdlICpwLCB1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPiA+ICB7DQo+
ID4gIAlpbnQgcmV0ID0gMCwgcGFzcyA9IDA7DQo+ID4gQEAgLTExNTIsNTAgKzExMzYsNzYgQEAg
c3RhdGljIGludCBnZXRfYW55X3BhZ2Uoc3RydWN0IHBhZ2UgKnAsIHVuc2lnbmVkIGxvbmcgZmxh
Z3MpDQo+ID4gIAkJY291bnRfaW5jcmVhc2VkID0gdHJ1ZTsNCj4gPiAgDQo+ID4gIHRyeV9hZ2Fp
bjoNCj4gPiAtCWlmICghY291bnRfaW5jcmVhc2VkICYmICFfX2dldF9od3BvaXNvbl9wYWdlKHAp
KSB7DQo+ID4gLQkJaWYgKHBhZ2VfY291bnQocCkpIHsNCj4gPiAtCQkJLyogV2UgcmFjZWQgd2l0
aCBhbiBhbGxvY2F0aW9uLCByZXRyeS4gKi8NCj4gPiAtCQkJaWYgKHBhc3MrKyA8IDMpDQo+ID4g
LQkJCQlnb3RvIHRyeV9hZ2FpbjsNCj4gPiAtCQkJcmV0ID0gLUVCVVNZOw0KPiA+IC0JCX0gZWxz
ZSBpZiAoIVBhZ2VIdWdlKHApICYmICFpc19mcmVlX2J1ZGR5X3BhZ2UocCkpIHsNCj4gPiAtCQkJ
LyogV2UgcmFjZWQgd2l0aCBwdXRfcGFnZSwgcmV0cnkuICovDQo+ID4gLQkJCWlmIChwYXNzKysg
PCAzKQ0KPiA+IC0JCQkJZ290byB0cnlfYWdhaW47DQo+ID4gLQkJCXJldCA9IC1FSU87DQo+ID4g
KwlpZiAoIWNvdW50X2luY3JlYXNlZCkgew0KPiA+ICsJCXJldCA9IF9fZ2V0X2h3cG9pc29uX3Bh
Z2UocCk7DQo+ID4gKwkJaWYgKCFyZXQpIHsNCj4gPiArCQkJaWYgKHBhZ2VfY291bnQocCkpIHsN
Cj4gPiArCQkJCS8qIFdlIHJhY2VkIHdpdGggYW4gYWxsb2NhdGlvbiwgcmV0cnkuICovDQo+ID4g
KwkJCQlpZiAocGFzcysrIDwgMykNCj4gPiArCQkJCQlnb3RvIHRyeV9hZ2FpbjsNCj4gPiArCQkJ
CXJldCA9IC1FQlVTWTsNCj4gPiArCQkJfSBlbHNlIGlmICghUGFnZUh1Z2UocCkgJiYgIWlzX2Zy
ZWVfYnVkZHlfcGFnZShwKSkgew0KPiA+ICsJCQkJLyogV2UgcmFjZWQgd2l0aCBwdXRfcGFnZSwg
cmV0cnkuICovDQo+ID4gKwkJCQlpZiAocGFzcysrIDwgMykNCj4gPiArCQkJCQlnb3RvIHRyeV9h
Z2FpbjsNCj4gPiArCQkJCXJldCA9IC1FSU87DQo+ID4gKwkJCX0NCj4gPiArCQkJZ290byBvdXQ7
DQo+ID4gIAkJfQ0KPiA+ICsJfQ0KPiANCj4gSSB0aGluayB0aGlzIGNhbiBiZSBpbXByb3ZlZC4N
Cj4gDQo+IFdlIGNhbm5vdCBoYXZlIC1FQlVTWSB1bmxlc3Mgd2UgY29tZSBmcm9tIF9fZ2V0X2h3
cG9pc29uX3BhZ2UoKSAoIWNvdW50X2luY3JlYXNlZCksDQo+IHNvIEkgdGhpbmsgYSBtdWNoIG1v
cmUgbmF0dXJhbCBhcHByb2FjaCB3b3VsZCBiZSB0byBzdHVmZiB0aGUgaHVuayBiZWxvdyBpbiB0
aGVyZSwNCj4gYW5kIHRoZW4gcGxhY2UgdGhlIG90aGVyIHN0dWZmIGluIGFuIGVsc2UsIHNvIHNv
bWV0aGluZyBsaWtlOg0KPiANCj4gICAgICAgICBpZiAoIWNvdW50X2luY3JlYXNlZCkgew0KPiAg
ICAgICAgICAgICAgICAgcmV0ID0gX19nZXRfaHdwb2lzb25fcGFnZShwKTsNCj4gICAgICAgICAg
ICAgICAgIGlmICghcmV0KSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChwYWdlX2Nv
dW50KHApKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogV2UgcmFjZWQg
d2l0aCBhbiBhbGxvY2F0aW9uLCByZXRyeS4gKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpZiAocGFzcysrIDwgMykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gdHJ5X2FnYWluOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldCA9IC1FQlVTWTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmICgh
UGFnZUh1Z2UocCkgJiYgIWlzX2ZyZWVfYnVkZHlfcGFnZShwKSkgew0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC8qIFdlIHJhY2VkIHdpdGggcHV0X3BhZ2UsIHJldHJ5LiAqLw0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChwYXNzKysgPCAzKQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byB0cnlfYWdhaW47DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTzsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gICAg
ICAgICAgICAgICAgIH0gZWxzZSBpZiAocmV0ID09IC1FQlVTWSkgew0KPiAJCQkvKiBXZSByYWNl
ZCB3aXRoIGZyZWVpbmcgaHVnZSBwYWdlIHRvIGJ1ZGR5LCByZXRyeS4gKi8NCj4gCQkJaWYgKHBh
c3MrKyA8IDMpDQo+IAkJCQlnb3RvIHRyeV9hZ2FpbjsNCj4gCQl9DQoNCk1vdmluZyAiaWYgKHJl
dCA9PSAtRUJVU1kpIiBibG9jayB0byBoZXJlIG1ha2VzIHNlbnNlIHRvIG1lLiBUaGFuayB5b3Uu
DQoNCj4gICAgICAgICB9IGVsc2Ugew0KDQpJbiB0aGUgb3JpZ2luYWwgbG9naWMsIGlmIF9fZ2V0
X2h3cG9pc29uX3BhZ2UoKSByZXR1cm5zIDEsIHdlIGZhbGwgaW50byB0aGUNCiJpZiAoUGFnZUh1
Z2UocCkgfHwgUGFnZUxSVShwKSB8fCBfX1BhZ2VNb3ZhYmxlKHApIiBjaGVjay4gIEkgZ3Vlc3Mg
dGhhdCB0aGlzDQoiZWxzZSIgc2VlbXMgbm90IG5lY2Vzc2FyeT8NCg0KPiAJCS8qIFdlIGRvIGFs
cmVhZHkgaGF2ZSBhIHJlZmNvdW50IGZvciB0aGlzIHBhZ2UsIHNlZSBpZiB3ZSBjYW4NCj4gCQkg
KiBoYW5kbGUgaXQuDQo+IAkJICovDQo+IAkJaWYgKFBhZ2VIdWdlKHApIHx8IFBhZ2VMUlUocCkg
fHwgX19QYWdlTW92YWJsZShwKSkgew0KPiAJCQlyZXQgPSAxOw0KPiAJCX0gZWxzZSB7DQo+IAkJ
CS8qIEEgcGFnZSB3ZSBjYW5ub3QgaGFuZGxlLiBDaGVjay4uLg0KPiAJCX0NCj4gCX0NCg0KVGhh
bmtzLA0KTmFveWEgSG9yaWd1Y2hp
