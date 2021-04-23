Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4CA368E42
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbhDWICv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:02:51 -0400
Received: from mail-eopbgr1410040.outbound.protection.outlook.com ([40.107.141.40]:47583
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241196AbhDWICg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:02:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Myney1zAaHfW44LMrASmLcAwzHqRWqwGE7CwqivkT55kXwEjEPuTElM9Yb9dtELek9bbbNoL6nCsNBFlOPk8zs/qDAGPhh7EkaV5MCWm64JL9kcWrt6jTQRDag6pU7FC8z1bV33x4CQMdlEhoAm3QKLzBpuVxVcptGEKnhTBFW7hGKRj7DiO5CshAh5SsUvPFw7/dotHl1vDZTgapllFJ1RnvhctyIv46ZFpFLSj8vf9+6PhBXhWtTjnpEKUBdavFkirFebqbdpLNrWIP20syczw4z4L8e9TNIS4BkGa2ank48YY5P8xsuCd4xSlP6AwwfdxyNnOmePJ+F8tEW0V7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIGgdkDhzq0Tq9SC9oAO6Ok41gkBeLnjg52aPSDAjw0=;
 b=Hyq6o8LaEeS+kt88nzRhixeRopl5ZY6xWcPLrjmlEvG5v1qAV7u8MwxyDZucfIxHag/S+6qgqPrb34dEo2z78/Jeq12YiYCTtuTf8vBEGCBKKd/rZju6BuWFj4bBSiC3ZZB1jROaZ0oqPgzVEAnJ48JyrJpIQ9+/Pi/e0+kWMRy5j57V0x0Jkm2IwdbJJKknflSZ52Y/WbwoWXl8u6M89YGtMvZe0UYAGuZSDZVu69ULOcEZNUheRoEYB0O2hGdw9KDxkRJRUqtBmsDucaKEgLQ/hjMaUu7Qi++BTy3fmVIJ84UimgKvPsqeR6ObrAbHVVOpOu8/tNhy2u2JqK63uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIGgdkDhzq0Tq9SC9oAO6Ok41gkBeLnjg52aPSDAjw0=;
 b=h2svd0/dBxdo5k0TMHO3xOMsYX5h7KIQ4XKPgqn2qZ8wCQB5fskP1sFTt5DpDggQ+y1+xCNUruZWS7itd3cuW2x0fl0nKNlziuk9VhmSK7bxkCi2zVwA9u1cFyG9+syGjELJJhvdisfPT0hZD+yhxzJtxPHp5risuRdHGsqZeVc=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3822.jpnprd01.prod.outlook.com (2603:1096:404:c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 08:01:54 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 08:01:54 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
Thread-Topic: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
Thread-Index: AQHXNoTZ/dsTmwNUxkyFM7XUqHdaa6q+pOiAgACfTACAAPGAAIABixqA
Date:   Fri, 23 Apr 2021 08:01:54 +0000
Message-ID: <20210423080153.GA78658@hori.linux.bs1.fc.nec.co.jp>
References: <20210421060259.67554-1-songmuchun@bytedance.com>
 <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
 <20210421083315.GA7552@hori.linux.bs1.fc.nec.co.jp>
 <57892496-a391-2eb9-eda0-1db9f3b98902@oracle.com>
 <20210422082746.GA33308@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210422082746.GA33308@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dc0c9a0-1161-4595-2e58-08d9062e0f72
x-ms-traffictypediagnostic: TYAPR01MB3822:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3822D511473F3AC83C56E823E7459@TYAPR01MB3822.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AaooYaYUVbMEeV1Nz7v9aQZWoKhik3Fdfx8lHfgp6bldqGWWVlIRc6CwcBQGt33S2pWP/Gau/m0Yljc2JeVLPd6vnyBBelQqJJzfjBhK6TeQBg2kSMkndlLVYK7xMnhQRYtBgWiNb133sPwPOre8ozhw3JsixAkWgHUVdWG7Lhu4ldoJL9p2szxcFiPEEIfLoLJMz9bY7AuyhbA+cT5dFafZ21yHHErywCeW4btzJgXIoUy4HYFJmFGju8o9Qf8F0VnWUeKXN1l80aDAZBkjne0axyCk5ntbU32Pm+T9WyQbExtjPb5ZeO3SNxGwZkd90dQ2dAlQuE/zNY4SkYR4vy+iqzknz77afdwlIB+jkl4hp0fUXDaBux3K7U/4+VXgBR9Kbn7P1fmHb6V7xuKlL3p+0Ua3UDsYxqym+1j3miAwG4mKH6uyExagQV89p7Obs6QZK4LlMCZdsugHazo56ybyEQ4kgvoG5EioJi9bvU88a92xz7vnLwKQ4MNqxjaVhWaEAqphu/lDEqpB3RY//blU6jBqV02f0c/7gpMR+vzzCIFfuUwoNZhhAeQhSkF+n9dJQpVrSAUddsfmYwcqF5ZvKmdr4EU443zOzJ3qEq0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(8676002)(6486002)(8936002)(4326008)(2906002)(33656002)(85182001)(6916009)(86362001)(83380400001)(9686003)(38100700002)(316002)(6512007)(1076003)(26005)(55236004)(6506007)(64756008)(53546011)(54906003)(186003)(66446008)(76116006)(478600001)(5660300002)(71200400001)(122000001)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R1I0aTNxR1ltb0VVbDdNbVhFR25XbnBTeURZNEtIdlRLK3p0VERJWmRDNUFk?=
 =?utf-8?B?ZEdPMStoeWxWbzhrS0hhdTE2UVdWQXFjY014RnBaN1dwQWRYb0dtaFE4d1JL?=
 =?utf-8?B?RHJndzk2WU1kSjB3bytSbUFkZUE3Y0tIUENpQmxIV25kVjZYbGd4RTNTWitK?=
 =?utf-8?B?SnlDVGNIeVpKRy9IQ0NIWElJL3IyMGF1d1BsQTVUVlZRQll0N2lXeFNOYmpB?=
 =?utf-8?B?RUg1a1RuUjBUVHhid3dtSndLSDgrVFZKNWFFcWt1V0ZyRU9XYW1HaEFPUEM4?=
 =?utf-8?B?enlUbjZZVHZFbmczeWU1ejVneHVHZUU1bzcxdzAzdkJrNEpQQjlrcndWcUpQ?=
 =?utf-8?B?aHk0VDBaMVhldFpOeVd6czF4K3hKQm9NMyt2bGtyMVpBbzdtbXprVGxUaVlP?=
 =?utf-8?B?Wk5kdTBnTWRTTkh3dE4vaFg5ak9XdjR2L1ZFeUZETldUUm9pQ3BLSjVsOWYy?=
 =?utf-8?B?eHduMUwrN1VCYVp3MzV1emF6S082T0pSVU5EZitXYmVMTUFCS052bGVIZXJl?=
 =?utf-8?B?U2RmYXYvTy9xU09ZelluL20rZFNTRVpiWEQ3K1BmZXlyN3pLM2h6N1c2MFJq?=
 =?utf-8?B?Y09kdnRiSWxrRGRUdVl5SFNzcXhLMUJpTUI5YjYwVmxmRXhpQnhVWU0zZjBx?=
 =?utf-8?B?MDYrUHBuZU5jem5MNFZjYk5zWkdoZ1ZDL3hUV2grclNhMDYxbjhvd1lTaWZX?=
 =?utf-8?B?Y3kzTTFtanZHd2NSNlFYTE5IQWxBb3R5a0Y1VDMvSktRellaU1ZVT3hHUC9H?=
 =?utf-8?B?YW1KMUZSQm5uSXRHeDJPOWFDdGhUZ3dxRGFhRmxrL0dadE1qeVF5eFpLUi8z?=
 =?utf-8?B?R0w5QVBJYjZ1MGVLYVdXNEZwR2dkUGh1UXdQelVNNnBrSDVVcEY1bkZCY1Bw?=
 =?utf-8?B?MlNXZWtzVTgremk4aDRLRktIdmtQWGFkWHgwYUo4UnREa1pGd0MrMnFWZGxK?=
 =?utf-8?B?ckwxMk1QRmU4eHNpaVhiZzNDbkZrNnVTamxzbGhnSlJiU1NCWVFjNFVWSWlH?=
 =?utf-8?B?T0gvMVZQZXFQMzd3NzN5eU0rb2swN1dSVWEvVXIrOGRNYUZCWG90SlNRVlll?=
 =?utf-8?B?OUZYaFhDbmtzMFVwYlVVYVRJRmhNV3oxK3cxOVBaalZDSm43SE1GTkMrd3JC?=
 =?utf-8?B?MkxFaE1XbWRVamF3Q3BqMzdaMnVQTERyTEN5VTduYWZWVHZCcThxVC9wOXNR?=
 =?utf-8?B?bitxUWREVENCUVVaQWxraTAwRzJ5NFgyRmlRa1dvczJJWjFKclo1MCtCT1V2?=
 =?utf-8?B?NFNtdGlBQ1ZFNHdSZFJaWFlydmZ4UjFaaGl5YlY4UnEzYi9CcDRmTFFsejVx?=
 =?utf-8?B?cDNBb2FBUFhldG51TGR3dE9Qc28xRkNNVTRCb1VrRjlXQUw1VWV4VVpvRmRY?=
 =?utf-8?B?TVVwZmxkdmNhRCtlSTVFQ2xGcU1RZmU0bzlJUkp2RXJYSUJxOTR6cWNqT0x4?=
 =?utf-8?B?Nnh5alNmNi9GRWkzZGNPcU9CZ2s1VDF3Y0JHdFVXaE56Y3JpbHpuaU83bkRt?=
 =?utf-8?B?eUxWaDIvTTY5Q0d5ckl0eE5nUGkwMlNRcDh0S3hDaW12M3kxbDVTTXlCSU9P?=
 =?utf-8?B?b3Nob2dreDVwUEhPdTE5MmxsNkwzMUVUYytpZWZWV0wwUEF4Ums4OWcxSEEy?=
 =?utf-8?B?ZVhuL2Q3NFdwaGFTNU9rUVVCTHpNWkxhVm1GazhCMWFNMllmV2kyYWZqRzkr?=
 =?utf-8?B?V1luTjdZT0Z2K3N4MlFuWE9PMXdNVEpTeTlISzFNMTZpcUdHTzVsb3NtTGZi?=
 =?utf-8?B?MHNiN0Q3MXg2ZDkxeGJWY2ZEbFFEZW9KSmpXeE1LclM2U2VVRmF3RUtnNWM3?=
 =?utf-8?B?dUxsQmVFSmg0TXQyODVBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92F8601BCD388244A3A7A818E2313224@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc0c9a0-1161-4595-2e58-08d9062e0f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 08:01:54.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02cldR7APkXKx9rZ5WUc+VtdzwOIvXzrUeZWEu42PomziRWZFrH+9mn1cpqivbbmHTBSItQbH4cW7a5mjc6e4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3822
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMjIsIDIwMjEgYXQgMDg6Mjc6NDZBTSArMDAwMCwgSE9SSUdVQ0hJIE5BT1lB
KOWggOWPoyDnm7TkuZ8pIHdyb3RlOg0KPiBPbiBXZWQsIEFwciAyMSwgMjAyMSBhdCAxMTowMzoy
NEFNIC0wNzAwLCBNaWtlIEtyYXZldHogd3JvdGU6DQo+ID4gT24gNC8yMS8yMSAxOjMzIEFNLCBI
T1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEFwciAy
MSwgMjAyMSBhdCAxMDowMzozNEFNICswMjAwLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+ID4gPj4g
W0NjIE5hb3lhXQ0KPiA+ID4+DQo+ID4gPj4gT24gV2VkIDIxLTA0LTIxIDE0OjAyOjU5LCBNdWNo
dW4gU29uZyB3cm90ZToNCj4gPiA+Pj4gVGhlIHBvc3NpYmxlIGJhZCBzY2VuYXJpbzoNCj4gPiA+
Pj4NCj4gPiA+Pj4gQ1BVMDogICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxOg0KPiA+ID4+
Pg0KPiA+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdhdGhlcl9zdXJwbHVz
X3BhZ2VzKCkNCj4gPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhZ2Ug
PSBhbGxvY19zdXJwbHVzX2h1Z2VfcGFnZSgpDQo+ID4gPj4+IG1lbW9yeV9mYWlsdXJlX2h1Z2V0
bGIoKQ0KPiA+ID4+PiAgIGdldF9od3BvaXNvbl9wYWdlKHBhZ2UpDQo+ID4gPj4+ICAgICBfX2dl
dF9od3BvaXNvbl9wYWdlKHBhZ2UpDQo+ID4gPj4+ICAgICAgIGdldF9wYWdlX3VubGVzc196ZXJv
KHBhZ2UpDQo+ID4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB6ZXJvID0g
cHV0X3BhZ2VfdGVzdHplcm8ocGFnZSkNCj4gPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFZNX0JVR19PTl9QQUdFKCF6ZXJvLCBwYWdlKQ0KPiA+ID4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW5xdWV1ZV9odWdlX3BhZ2UoaCwgcGFnZSkNCj4gPiA+
Pj4gICBwdXRfcGFnZShwYWdlKQ0KPiA+ID4+Pg0KPiA+ID4+PiBUaGUgcmVmY291bnQgY2FuIHBv
c3NpYmx5IGJlIGluY3JlYXNlZCBieSBtZW1vcnktZmFpbHVyZSBvciBzb2Z0X29mZmxpbmUNCj4g
PiA+Pj4gaGFuZGxlcnMsIHdlIGNhbiB0cmlnZ2VyIFZNX0JVR19PTl9QQUdFIGFuZCB3cm9uZ2x5
IGFkZCB0aGUgcGFnZSB0byB0aGUNCj4gPiA+Pj4gaHVnZXRsYiBwb29sIGxpc3QuDQo+ID4gPj4N
Cj4gPiA+PiBUaGUgaHdwb2lzb24gc2lkZSBvZiB0aGlzIGxvb2tzIHJlYWxseSBzdXNwaWNpb3Vz
IHRvIG1lLiBJdCBzaG91bGRuJ3QNCj4gPiA+PiByZWFsbHkgdG91Y2ggdGhlIHJlZmVyZW5jZSBj
b3VudCBvZiBodWdldGxiIHBhZ2VzIHdpdGhvdXQgYmVpbmcgdmVyeQ0KPiA+ID4+IGNhcmVmdWwg
KGFuZCBoYXZpbmcgaHVnZXRsYl9sb2NrIGhlbGQpLg0KPiA+ID4gDQo+ID4gPiBJIGhhdmUgdGhl
IHNhbWUgZmVlbGluZywgdGhlcmUgaXMgYSB3aW5kb3cgd2hlcmUgYSBodWdlcGFnZSBpcyByZWZj
b3VudGVkDQo+ID4gPiBkdXJpbmcgY29udmVydGluZyBmcm9tIGJ1ZGR5IGZyZWUgcGFnZXMgaW50
byBmcmVlIGh1Z2VwYWdlLCBzbyByZWZjb3VudA0KPiA+ID4gYWxvbmUgaXMgbm90IGVub3VnaCB0
byBwcmV2ZW50IHRoZSByYWNlLiAgaHVnZXRsYl9sb2NrIGlzIHJldGFrZW4gYWZ0ZXINCj4gPiA+
IGFsbG9jX3N1cnBsdXNfaHVnZV9wYWdlIHJldHVybnMsIHNvIHNpbXBseSBob2xkaW5nIGh1Z2V0
bGJfbG9jayBpbg0KPiA+ID4gZ2V0X2h3cG9pc29uX3BhZ2UoKSBzZWVtcyBub3Qgd29yay4gIElz
IHRoZXJlIGFueSBzdGF0dXMgYml0IHRvIHNob3cgdGhhdCBhDQo+ID4gPiBodWdlcGFnZSBpcyBq
dXN0IGJlaW5nIGluaXRpYWxpemVkIChub3QgaW4gZnJlZSBodWdlcGFnZSBwb29sIG9yIGluIHVz
ZSk/DQo+ID4gPiANCj4gPiANCj4gPiBJdCBzZWVtcyB3ZSBjYW4gYWxzbyByYWNlIHdpdGggdGhl
IGNvZGUgdGhhdCBtYWtlcyBhIGNvbXBvdW5kIHBhZ2UgYQ0KPiA+IGh1Z2V0bGIgcGFnZS4gIFRo
ZSBtZW1vcnkgZmFpbHVyZSBjb2RlIGNvdWxkIGJlIGNhbGxlZCBhZnRlciBhbGxvY2F0aW5nDQo+
ID4gcGFnZXMgZnJvbSBidWRkeSBhbmQgYmVmb3JlIHNldHRpbmcgY29tcG91bmQgcGFnZSBEVE9S
LiAgU28sIHRoZSBtZW1vcnkNCj4gPiBoYW5kbGluZyBjb2RlIHdpbGwgcHJvY2VzcyBpdCBhcyBh
IGNvbXBvdW5kIHBhZ2UuDQo+IA0KPiBZZXMsIHNvIGdldF9od3BvaXNvbl9wYWdlKCkgaGFzIHRv
IGNhbGwgZ2V0X3BhZ2VfdW5sZXNzX3plcm8oKQ0KPiBvbmx5IHdoZW4gbWVtb3J5X2ZhaWx1cmUo
KSBjYW4gc3VyZWx5IGhhbmRsZSB0aGUgZXJyb3IuDQo+IA0KPiA+IA0KPiA+IEp1c3QgdGhpbmtp
bmcgdGhhdCB0aGlzIG1heSBub3QgYmUgbGltaXRlZCB0byB0aGUgaHVnZXRsYiBzcGVjaWZpYyBt
ZW1vcnkNCj4gPiBmYWlsdXJlIGhhbmRsaW5nPw0KPiANCj4gQ3VycmVudGx5IGh1Z2V0bGIgcGFn
ZSBpcyB0aGUgb25seSB0eXBlIG9mIGNvbXBvdW5kIHBhZ2Ugc3VwcG9ydGVkIGJ5IG1lbW9yeQ0K
PiBmYWlsdXJlLiAgQnV0IEkgYWdyZWUgd2l0aCB5b3UgdGhhdCBvdGhlciB0eXBlcyBvZiBjb21w
b3VuZCBwYWdlcyBoYXZlIHRoZQ0KPiBzYW1lIHJhY2Ugd2luZG93LCBhbmQganVkZ2luZyBvbmx5
IHdpdGggZ2V0X3BhZ2VfdW5sZXNzX3plcm8oKSBpcyBkYW5nZXJvdXMuDQo+IFNvIEkgdGhpbmsg
dGhhdCBfX2dldF9od3BvaXNvbl9wYWdlKCkgc2hvdWxkIGhhdmUgdGhlIGZvbGxvd2luZyBzdHJ1
Y3R1cmU6DQo+IA0KPiAgIGlmIChQYWdlQ29tcG91bmQpIHsNCj4gICAgICAgaWYgKFBhZ2VIdWdl
KSB7DQo+ICAgICAgICAgICBpZiAoUGFnZUh1Z2VGcmVlZCB8fCBQYWdlSHVnZUFjdGl2ZSkgew0K
PiAgICAgICAgICAgICAgIGlmIChnZXRfcGFnZV91bmxlc3NfemVybykNCj4gICAgICAgICAgICAg
ICAgICAgcmV0dXJuIDA7ICAgLy8gcGF0aCBmb3IgaW4tdXNlIGh1Z2V0bGIgcGFnZQ0KPiAgICAg
ICAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIDE7ICAgLy8gcGF0aCBm
b3IgZnJlZSBodWdldGxiIHBhZ2UNCj4gICAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAg
ICAgcmV0dXJuIC1FQlVTWTsgIC8vIGFueSB0cmFuc2llbnQgaHVnZXRsYiBwYWdlDQo+ICAgICAg
ICAgICB9DQo+ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAuLi4gLy8gYW55IG90aGVyIGNv
bXBvdW5kIHBhZ2UgKGxpa2UgdGhwLCBzbGFiLCAuLi4pDQo+ICAgICAgIH0NCj4gICB9IGVsc2Ug
ew0KPiAgICAgICAuLi4gICAvLyBhbnkgbm9uLWNvbXBvdW5kIHBhZ2UNCj4gICB9DQoNClRoZSBh
Ym92ZSBwc2V1ZG8gY29kZSB3YXMgd3JvbmcsIHNvIGxldCBtZSB1cGRhdGUgbXkgdGhvdWdodC4N
CkknbSBub3cgdHJ5aW5nIHRvIHNvbHZlIHRoZSByZXBvcnRlZCBpc3N1ZSBieSBjaGFuZ2luZyBf
X2dldF9od3BvaXNvbl9wYWdlKCkNCmxpa2UgYmVsb3c6DQoNCiAgc3RhdGljIGludCBfX2dldF9o
d3BvaXNvbl9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KICB7DQogICAgICAgICAgc3RydWN0IHBh
Z2UgKmhlYWQgPSBjb21wb3VuZF9oZWFkKHBhZ2UpOw0KICANCiAgICAgICAgICBpZiAoUGFnZUNv
bXBvdW5kKHBhZ2UpKSB7DQogICAgICAgICAgICAgICAgICBpZiAoUGFnZVNsYWIocGFnZSkpIHsN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGdldF9wYWdlX3VubGVzc196ZXJvKHBh
Z2UpOw0KICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmIChQYWdlSHVnZShoZWFkKSkgew0KICAg
ICAgICAgICAgICAgICAgICAgICAgICBpZiAoSFBhZ2VGcmVlZChoZWFkKSB8fCBIUGFnZU1pZ3Jh
dGFibGUoaGVhZCkpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGdl
dF9wYWdlX3VubGVzc196ZXJvKGhlYWQpOw0KICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmIChQ
YWdlVHJhbnNIdWdlKGhlYWQpKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgIC8qDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAqIE5vbiBhbm9ueW1vdXMgdGhwIGV4aXN0cyBvbmx5IGlu
IGFsbG9jYXRpb24vZnJlZSB0aW1lLiBXZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBj
YW4ndCBoYW5kbGUgc3VjaCBhIGNhc2UgY29ycmVjdGx5LCBzbyBsZXQncyBnaXZlIGl0IHVwLg0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBUaGlzIHNob3VsZCBiZSBiZXR0ZXIgdGhhbiB0
cmlnZ2VyaW5nIEJVR19PTiB3aGVuIGtlcm5lbA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
KiB0cmllcyB0byB0b3VjaCB0aGUgInBhcnRpYWxseSBoYW5kbGVkIiBwYWdlLg0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKi8NCiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFQYWdl
QW5vbihoZWFkKSkgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX2Vycigi
TWVtb3J5IGZhaWx1cmU6ICUjbHg6IG5vbiBhbm9ueW1vdXMgdGhwXG4iLA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWdlX3RvX3BmbihwYWdlKSk7DQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQogICAgICAgICAgICAgICAgICAg
ICAgICAgIH0NCiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGdldF9wYWdlX3VubGVzc196
ZXJvKGhlYWQpKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGhlYWQg
PT0gY29tcG91bmRfaGVhZChwYWdlKSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAxOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBy
X2luZm8oIk1lbW9yeSBmYWlsdXJlOiAlI2x4IGNhbm5vdCBjYXRjaCB0YWlsXG4iLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFnZV90b19wZm4ocGFnZSkpOw0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB1dF9wYWdlKGhlYWQpOw0KICAgICAg
ICAgICAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAg
ICAgICByZXR1cm4gMDsNCiAgICAgICAgICB9DQogIA0KICAgICAgICAgIHJldHVybiBnZXRfcGFn
ZV91bmxlc3NfemVybyhwYWdlKTsNCiAgfQ0KDQpTb21lIG5vdGVzOiANCg0KICAtIGluIGh1Z2V0
bGIgcGF0aCwgbmV3IEhQYWdlKiBjaGVja3Mgc2hvdWxkIGF2b2lkIHRoZSByZXBvcnRlZCByYWNl
LA0KICAgIGJ1dCBJIHN0aWxsIG5lZWQgbW9yZSB0ZXN0aW5nIHRvIGNvbmZpcm0gaXQsDQogIC0g
UGFnZVNsYWIgY2hlY2sgaXMgYWRkZWQgYmVjYXVzZSBvdGhlcndpc2UgSSBmb3VuZCB0aGF0ICJu
b24gYW5vbnltb3VzIHRocCINCiAgICBwYXRoIGlzIGNob3NlbiwgdGhhdCdzIG9idmlvdXNseSB3
cm9uZywNCiAgLSB0aHAncyBicmFuY2ggaGFzIGEga25vd24gaXNzdWUgdW5yZWxhdGVkIHRvIHRo
ZSBjdXJyZW50IGlzc3VlLCB3aGljaA0KICAgIHdpbGwvc2hvdWxkIGJlIGltcHJvdmVkIGxhdGVy
Lg0KDQpJJ2xsIHNlbmQgYSBwYXRjaCBuZXh0IHdlZWsuDQoNClRoYW5rcywNCk5hb3lhIEhvcmln
dWNoaQ==
