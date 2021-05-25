Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C7B38FC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhEYIKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:10:22 -0400
Received: from mail-eopbgr1400052.outbound.protection.outlook.com ([40.107.140.52]:36510
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232018AbhEYIJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:09:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDQ2Jz8odu64y6sMB/DxWK9wPCIUXsBwjDeUsRJfIyDnq7aSSA/rKcI5w6jiwse7QVK5T0D0ay5CFxlkjkZw8rLh7Gl9ytrDANrnNYGFw/nAweMIysJ1+4ALXLpgIOBepvpBTDkXbPxBlMD9Vkht0AsAH6FpLUvjMyIEkm7NaejVY8WUvwIPLLTWBX8h+anvPqiH/rdHbaoWXcyGYU67wMzZ+Ajbj1diJQtc+gDc5jhwoNGWK8l01Ym4FvI0qJ58af+5W6LBl6ewl6wJc3BD4Z7tX+inc+VEkUqKwcjSJAYNxS7UvIairlF4F0BEFzZ/WSGa0iiqoiGko4QWGJatnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOz1ThfQUPhUp/wt8Uc+x7vS2xLMRAVAXyCkV9IPEys=;
 b=XcTrQmhsjJQHhzANe69/0T8UuxFQPuYc6G5VsabTTS0Fex5RHV59mNBXQ5VJFm/Kp0xsfgIQU+VEtacuLdqhhNbdR4jet1AlgUmQ6BsO0GsGq9Kw4FeoJzmK1fyh+9/ewYjZn2ccOVjPNlirgUvAjn6seX13vI0fxlY1OYyRAbDDvPFc4vVmISXK+oWmA+YgT0kemhfg7akqyj5DliY5OV/ThgGcX/7Ri30edB9ssV0mD9Fu2JOMrPHVqOMMNsAuOlHwBQsEWQw8uESX6AfXQHpb8u7y306bb+7yvNjEsC0CWHlD58HA252j9IY73KddX1BmF86PFG1wgcJfMvfVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOz1ThfQUPhUp/wt8Uc+x7vS2xLMRAVAXyCkV9IPEys=;
 b=KqmxLhELFeeohCLwlVuhAV/0JkNPve4i3RzVGb3WL7NCEjrdNjNA0vL7Qb8wD0ZV2cskbNJ09Kwm1Epsmvnc+e9RozT0iuM0O7F8HWZf0fUgne5sEdY+0ENo6hFgQU1undryA5as9gaUd/ZD/lzj3oW1m+uSzcIx4/usyytUTFU=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYXPR01MB1695.jpnprd01.prod.outlook.com (2603:1096:403:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 08:07:07 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 08:07:07 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] mm,hwpoison: fix race with hugetlb page allocation
Thread-Topic: [PATCH v5 1/2] mm,hwpoison: fix race with hugetlb page
 allocation
Thread-Index: AQHXTDtjI+1UlcXho0eIycDZj0ORBKrrZS6AgACSr4CAB+DpgIAACKuA
Date:   Tue, 25 May 2021 08:07:07 +0000
Message-ID: <20210525080707.GA3325050@hori.linux.bs1.fc.nec.co.jp>
References: <20210518231259.2553203-1-nao.horiguchi@gmail.com>
 <20210518231259.2553203-2-nao.horiguchi@gmail.com>
 <d78f430c-2390-2a5f-564a-e20e0ba6b26a@oracle.com>
 <20210520071717.GA2641190@hori.linux.bs1.fc.nec.co.jp>
 <20210525073559.GA844@linux>
In-Reply-To: <20210525073559.GA844@linux>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f06e7f0b-9259-4217-f7b0-08d91f54174a
x-ms-traffictypediagnostic: TYXPR01MB1695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYXPR01MB16950BE57B5971472A36F6E3E7259@TYXPR01MB1695.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q33tinM4TgtRGdSUafLjqodVD7BZeQAclcXtQExxd6uMwsbJTTlCgGAh3Ikmg7hnUwqGNAdIXfvD/+Nl5dRw63Wl6/Eq7yPk2NJ5rY8WtbPAIBg983VXeGC2LPVUD78zMjy3882VI999ks2m4pxcJzK2I1yvlgjP51ebl9F2s0d3K1t9T7TNnSFTUMYfOw2ksvyPnw4KXHRvRzFzU8PLu9ZlFuKmAay5TOjdCqIciIYz0R20/L0EYijU8yOFUZeYUlEW7hflOmcMcI8qkoCUH22pNSCKaWOkrFI0L9lGCOfBFRkzJVWQY4xw9rSSSUZV81QQ9dwxB8rn5RlWLCerrbr9uXoBS8xvLXKJyLITBAOavjPeVY32BTk682/DHVjV7nIIELR3T4pQJXrH4Q2FZjUbhW9CF9N/Mv8pIqRQEltjoPjMEVIe9rc4kX3I0lf+osPQD3QZlrqj8M8ClwyzIqOMk9Vuk2hIi8gs14+Jvo3wVgKyFXo5e6W1WkIvT17CaWNDjunvIQqybRHbz/9iyslDxhRP4BDsEp61Vl7NuicL9bM+opiJBzH4KADpVZkXR+yNtsWXIPFgGzWZLdFXSx6/xn71RdtiOcY0rWmZ0OI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(66556008)(6512007)(9686003)(64756008)(66476007)(66446008)(4326008)(8676002)(66946007)(76116006)(5660300002)(71200400001)(83380400001)(1076003)(2906002)(6486002)(86362001)(478600001)(186003)(54906003)(26005)(33656002)(8936002)(6916009)(316002)(85182001)(53546011)(38100700002)(6506007)(55236004)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aExhU2wyNHh0T2J5MUZQNjB1djNCNHlLbzVIZitibHplMS9GdEtibmdhNE8r?=
 =?utf-8?B?dlNwdm95UHBFMG1uVWMrc0tYS0tkcGQ4TGlYVlV0aGlqTEcwTWdIUHdGbFNQ?=
 =?utf-8?B?T0pSYVhoKzVOeU9SSGUrejBQb1djRXVzQjVtNnBrMTdrUFpzZVBCM3hkVWtY?=
 =?utf-8?B?WkthRnNhbXZzU2owb3hUMVFVUGZEaW43T3I2VG9SOHRxaytIS3llRklaT0tt?=
 =?utf-8?B?OU1LVTl2d0dkdWdZK2FyM252Sk9WSTdIdGk0YXhncHd2UjVvRVpPa2l2Si9m?=
 =?utf-8?B?QjJEMng1TU9CdGNUK0Zka2JIV25UL3lxWkZtN1YyT2R2UUFJK1dhYXYvNFpV?=
 =?utf-8?B?M2FTK2VjVUpURlNrclNSc2gycjRhRlVZOGpXV052bUtUdTZkQ2hBM2NHVzZw?=
 =?utf-8?B?dThVQm4vM0tGeXdiYjBsYm0rOStCMmN0RTVwYW96Y1laOWQwOStQek5UYmFJ?=
 =?utf-8?B?VmZSUHRGeDBMc3NCeCtRL09iUlRXbHVUbUI4SnhXdFdxSjhsSEl0T1h3Z0Jt?=
 =?utf-8?B?dXJVTjJyWkdKV2EyMFAwZFlwYVdZeUpWbm9nRkRMclVjeldOMU5aMzRzc0FG?=
 =?utf-8?B?bnZ2MmFZWnhoRWR6SHgzMHQrY1gvdURYdkQ0YnpUVkNxUUtzSmFvb2UvcnUx?=
 =?utf-8?B?UDJ5djllT2xVNkNOaDNaaHZXcjEvdGI4RVBJT3hJTzNYVjNlWjIvYUFyZnRV?=
 =?utf-8?B?cmhVWk9Rc1dWdHc1aDM0SDV5Q012c20vdWNCZDlhUUg2dnpkVWR4UnhWRmd6?=
 =?utf-8?B?ZHg4SVJxaEc4dDNVRk5pb2ptL2JmMGdJS2xqRmFnRDhURnBRZWQrbU9BbTE3?=
 =?utf-8?B?RnhVczZlQkgzeDlMODFNdTMrZzRCYlVnSGw0dTQreDhUdDJ2WVJkcFNGWTUw?=
 =?utf-8?B?NGN4dEQ0L01iM1ovVDJkd1B0cy9UWTdza29SQXBmTjhhN2VISlVBN3VRMk1u?=
 =?utf-8?B?OFJvRSswbTJLa3R5OHZCNE0yeW9rdHhyclhVVHFiMzg2MkNqUTUvT2NDd2Yw?=
 =?utf-8?B?RVdYdU9sWHFseDQzdkR6QXQ2WlpkaDdBNGQ4RCt2eGNPNUxRVTBMbHJnSCtw?=
 =?utf-8?B?ZFRHajV3RDh0R1Q1RytjanNORW9FL0VSNXFTYld4NTlDeCtjcXJuWExCbm5K?=
 =?utf-8?B?N1dyanAyeVVQVzR2bFZwMWpHay9MdDIvNFlxK0V2OGR2M2t5MTlRTDQ1QTZy?=
 =?utf-8?B?SmhzMlc5WVBxMGZIZEQvdFBnZG9iSmtwZEZYUjQxWjVGOGZlYVZrM2NhWVRS?=
 =?utf-8?B?SVdaeWJ0SzkrSmlGQjdaa1VxNXU5VXVDb3VPR2lzdmFvQjgrbzRjQng3T1l3?=
 =?utf-8?B?aDA3YWNzSzBTeU9OUzdSU2ZDc2tsYVVuQUVxajE3ZEMrN3hWTFZjK1gwK1hC?=
 =?utf-8?B?ZTZDSDJRaEg2OXRETkxuL2Nhdk5OWm9FUWY3T3FEUDBBWW5YYy9ZWmI1enZD?=
 =?utf-8?B?dzF1ajAwNHFPN2svZzFHNHYreExiYjNKSmJ6eWhKdS9memR4R3lLNWs5Rmpt?=
 =?utf-8?B?MW5iTzk3L3ZjTGZnUmdxZ09RZEJ1NU9vcDNtbi90M0U3RXM5Q0tiL0NEZC9B?=
 =?utf-8?B?cERBelVjajBHWTkzY0txSitrYk93REJqTEV0a0xSUmRSOFRLbnZiNVh4VndG?=
 =?utf-8?B?YWhQNU0rdUR0Z2ZaUDAzUCt1emtqUGVBTjF4N2lxcEFJTkQ2bXZrUlNpYUJ6?=
 =?utf-8?B?Z2lEdWF4MlliSXovcFNmajBNM3ArSGpYZEUxUDcrdkJwWmQ2UkkyYWpSWlRa?=
 =?utf-8?Q?8ox2gppRgpxqLRAbyCHgFOBnqR8zA5xTBnqZ0Vc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7597C5F18BF5A24C89FF79DEDD628833@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06e7f0b-9259-4217-f7b0-08d91f54174a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 08:07:07.7169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETZ20BeFiYtD0eJLHdwJMznv3/vhLefHoAtZY5RY6r8fgsNS90y8K1S/pMFCnCHJeCZiiiOu6t0ywnmb7T6WAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1695
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXkgMjUsIDIwMjEgYXQgMDk6MzY6MDVBTSArMDIwMCwgT3NjYXIgU2FsdmFkb3Ig
d3JvdGU6DQo+IE9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDA3OjE3OjE3QU0gKzAwMDAsIEhPUklH
VUNISSBOQU9ZQSjloIDlj6Mg55u05LmfKSB3cm90ZToNCj4gPiBTbyBJIHRoaW5rIG9mIGluc2Vy
dGluZyB0aGUgY2hlY2sgdG8gY29tcGx5IHdpdGggdGhlIGFzc3VtcHRpb24gb2YNCj4gPiBnZXRf
aHdwb2lzb25faHVnZV9wYWdlKCkgbGlrZSBiZWxvdzoNCj4gPiANCj4gPiAgICAgICAgIHJldCA9
IGdldF9od3BvaXNvbl9odWdlX3BhZ2UoaGVhZCwgJmh1Z2V0bGIpOw0KPiA+ICAgICAgICAgaWYg
KGh1Z2V0bGIpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gDQo+ID4gICAg
ICAgICBpZiAoIVBhZ2VMUlUoaGVhZCkgJiYgIV9fUGFnZU1vdmFibGUoaGVhZCkpDQo+ID4gICAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+IA0KPiA+ICAgICAgICAgaWYgKFBhZ2VUcmFuc0h1
Z2UoaGVhZCkpIHsNCj4gPiAgICAgICAgICAgICAgICAgLi4uDQo+ID4gICAgICAgICB9DQo+ID4g
DQo+ID4gICAgICAgICBpZiAoZ2V0X3BhZ2VfdW5sZXNzX3plcm8oaGVhZCkpIHsNCj4gPiAgICAg
ICAgICAgICAgICAgLi4uDQo+ID4gICAgICAgICB9DQo+ID4gDQo+ID4gICAgICAgICByZXR1cm4g
MDsNCj4gDQo+IEhpIE5hb3lhLA0KPiANCj4gd291bGQgeW91IG1pbmQgcG9zdGluZyBhIGNvbXBs
ZXRlIGRyYWZ0IG9mIHdoYXQgaXQgd291bGQgbG9vayBsaWtlPw0KPiBJIGFtIGhhdmluZyBhIGhh
cmQgdGltZSBwaWN0dXJpbmcgaXQuDQoNCk9LLCBoZXJlJ3MgdGhlIGN1cnJlbnQgZHJhZnQuDQoN
ClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQotLS0NCkZyb206IE5hb3lhIEhvcmlndWNoaSA8
bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQpEYXRlOiBUdWUsIDE4IE1heSAyMDIxIDIzOjQ5OjE4
ICswOTAwDQpTdWJqZWN0OiBbUEFUQ0hdIG1tLGh3cG9pc29uOiBmaXggcmFjZSB3aXRoIGh1Z2V0
bGIgcGFnZSBhbGxvY2F0aW9uDQoNCldoZW4gaHVnZXRsYiBwYWdlIGZhdWx0ICh1bmRlciBvdmVy
Y29tbWl0dGluZyBzaXR1YXRpb24pIGFuZA0KbWVtb3J5X2ZhaWx1cmUoKSByYWNlLCBWTV9CVUdf
T05fUEFHRSgpIGlzIHRyaWdnZXJlZCBieSB0aGUgZm9sbG93aW5nIHJhY2U6DQoNCiAgICBDUFUw
OiAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVTE6DQoNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGdhdGhlcl9zdXJwbHVzX3BhZ2VzKCkNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcGFnZSA9IGFsbG9jX3N1cnBsdXNfaHVnZV9wYWdlKCkNCiAg
ICBtZW1vcnlfZmFpbHVyZV9odWdldGxiKCkNCiAgICAgIGdldF9od3BvaXNvbl9wYWdlKHBhZ2Up
DQogICAgICAgIF9fZ2V0X2h3cG9pc29uX3BhZ2UocGFnZSkNCiAgICAgICAgICBnZXRfcGFnZV91
bmxlc3NfemVybyhwYWdlKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB6
ZXJvID0gcHV0X3BhZ2VfdGVzdHplcm8ocGFnZSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgVk1fQlVHX09OX1BBR0UoIXplcm8sIHBhZ2UpDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVucXVldWVfaHVnZV9wYWdlKGgsIHBhZ2UpDQogICAgICBw
dXRfcGFnZShwYWdlKQ0KDQpfX2dldF9od3BvaXNvbl9wYWdlKCkgb25seSBjaGVja3MgdGhlIHBh
Z2UgcmVmY291bnQgYmVmb3JlIHRha2luZyBhbg0KYWRkaXRpb25hbCBvbmUgZm9yIG1lbW9yeSBl
cnJvciBoYW5kbGluZywgd2hpY2ggaXMgd3JvbmcgYmVjYXVzZSB0aGVyZSdzDQphIHRpbWUgd2lu
ZG93IHdoZXJlIGNvbXBvdW5kIHBhZ2VzIGhhdmUgbm9uLXplcm8gcmVmY291bnQgZHVyaW5nDQpp
bml0aWFsaXphdGlvbi4gIFNvIG1ha2UgX19nZXRfaHdwb2lzb25fcGFnZSgpIGNoZWNrIHBhZ2Ug
c3RhdHVzIGEgYml0DQptb3JlIGZvciBodWdldGxiIHBhZ2VzLg0KDQpGaXhlczogZWFkMDdmNmE4
NjdiICgibW0vbWVtb3J5LWZhaWx1cmU6IGludHJvZHVjZSBnZXRfaHdwb2lzb25fcGFnZSgpIGZv
ciBjb25zaXN0ZW50IHJlZmNvdW50IGhhbmRsaW5nIikNClNpZ25lZC1vZmYtYnk6IE5hb3lhIEhv
cmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQpSZXBvcnRlZC1ieTogTXVjaHVuIFNv
bmcgPHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbT4NCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ICMgNS4xMisNCi0tLQ0KIGluY2x1ZGUvbGludXgvaHVnZXRsYi5oIHwgIDYgKysrKysrDQogbW0v
aHVnZXRsYi5jICAgICAgICAgICAgfCAxNSArKysrKysrKysrKysrKysNCiBtbS9tZW1vcnktZmFp
bHVyZS5jICAgICB8IDExICsrKysrKysrKystDQogMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2h1Z2V0
bGIuaCBiL2luY2x1ZGUvbGludXgvaHVnZXRsYi5oDQppbmRleCBiOTJmMjVjY2VmNTguLjc5MGFl
NjE4NTQ4ZCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvaHVnZXRsYi5oDQorKysgYi9pbmNs
dWRlL2xpbnV4L2h1Z2V0bGIuaA0KQEAgLTE0OSw2ICsxNDksNyBAQCBib29sIGh1Z2V0bGJfcmVz
ZXJ2ZV9wYWdlcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb25nIGZyb20sIGxvbmcgdG8sDQogbG9u
ZyBodWdldGxiX3VucmVzZXJ2ZV9wYWdlcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb25nIHN0YXJ0
LCBsb25nIGVuZCwNCiAJCQkJCQlsb25nIGZyZWVkKTsNCiBib29sIGlzb2xhdGVfaHVnZV9wYWdl
KHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0KTsNCitpbnQgZ2V0X2h3
cG9pc29uX2h1Z2VfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSwgYm9vbCAqaHVnZXRsYik7DQogdm9p
ZCBwdXRiYWNrX2FjdGl2ZV9odWdlcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSk7DQogdm9pZCBtb3Zl
X2h1Z2V0bGJfc3RhdGUoc3RydWN0IHBhZ2UgKm9sZHBhZ2UsIHN0cnVjdCBwYWdlICpuZXdwYWdl
LCBpbnQgcmVhc29uKTsNCiB2b2lkIGZyZWVfaHVnZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKTsN
CkBAIC0zMzksNiArMzQwLDExIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc29sYXRlX2h1Z2VfcGFn
ZShzdHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkNCiAJcmV0dXJuIGZh
bHNlOw0KIH0NCiANCitzdGF0aWMgaW5saW5lIGludCBnZXRfaHdwb2lzb25faHVnZV9wYWdlKHN0
cnVjdCBwYWdlICpwYWdlLCBib29sICpodWdldGxiKQ0KK3sNCisJcmV0dXJuIDA7DQorfQ0KKw0K
IHN0YXRpYyBpbmxpbmUgdm9pZCBwdXRiYWNrX2FjdGl2ZV9odWdlcGFnZShzdHJ1Y3QgcGFnZSAq
cGFnZSkNCiB7DQogfQ0KZGlmZiAtLWdpdCBhL21tL2h1Z2V0bGIuYyBiL21tL2h1Z2V0bGIuYw0K
aW5kZXggOTU5MThmNDEwYzBmLi5mMTM4YmFlM2UzMDIgMTAwNjQ0DQotLS0gYS9tbS9odWdldGxi
LmMNCisrKyBiL21tL2h1Z2V0bGIuYw0KQEAgLTU4NDcsNiArNTg0NywyMSBAQCBib29sIGlzb2xh
dGVfaHVnZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0KQ0K
IAlyZXR1cm4gcmV0Ow0KIH0NCiANCitpbnQgZ2V0X2h3cG9pc29uX2h1Z2VfcGFnZShzdHJ1Y3Qg
cGFnZSAqcGFnZSwgYm9vbCAqaHVnZXRsYikNCit7DQorCWludCByZXQgPSAwOw0KKw0KKwkqaHVn
ZXRsYiA9IGZhbHNlOw0KKwlzcGluX2xvY2tfaXJxKCZodWdldGxiX2xvY2spOw0KKwlpZiAoUGFn
ZUhlYWRIdWdlKHBhZ2UpKSB7DQorCQkqaHVnZXRsYiA9IHRydWU7DQorCQlpZiAoSFBhZ2VGcmVl
ZChwYWdlKSB8fCBIUGFnZU1pZ3JhdGFibGUocGFnZSkpDQorCQkJcmV0ID0gZ2V0X3BhZ2VfdW5s
ZXNzX3plcm8ocGFnZSk7DQorCX0NCisJc3Bpbl91bmxvY2tfaXJxKCZodWdldGxiX2xvY2spOw0K
KwlyZXR1cm4gcmV0Ow0KK30NCisNCiB2b2lkIHB1dGJhY2tfYWN0aXZlX2h1Z2VwYWdlKHN0cnVj
dCBwYWdlICpwYWdlKQ0KIHsNCiAJc3Bpbl9sb2NrX2lycSgmaHVnZXRsYl9sb2NrKTsNCmRpZmYg
LS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KaW5kZXgg
ODVhZDk4YzAwZmQ5Li40YzI2NGM0MDkwZDcgMTAwNjQ0DQotLS0gYS9tbS9tZW1vcnktZmFpbHVy
ZS5jDQorKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQpAQCAtOTU5LDggKzk1OSwxNyBAQCBzdGF0
aWMgaW50IHBhZ2VfYWN0aW9uKHN0cnVjdCBwYWdlX3N0YXRlICpwcywgc3RydWN0IHBhZ2UgKnAs
DQogc3RhdGljIGludCBfX2dldF9od3BvaXNvbl9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KIHsN
CiAJc3RydWN0IHBhZ2UgKmhlYWQgPSBjb21wb3VuZF9oZWFkKHBhZ2UpOw0KKwlpbnQgcmV0ID0g
MDsNCisJYm9vbCBodWdldGxiID0gZmFsc2U7DQorDQorCXJldCA9IGdldF9od3BvaXNvbl9odWdl
X3BhZ2UoaGVhZCwgJmh1Z2V0bGIpOw0KKwlpZiAoaHVnZXRsYikNCisJCXJldHVybiByZXQ7DQor
DQorCWlmICghUGFnZUxSVShoZWFkKSAmJiAhX19QYWdlTW92YWJsZShoZWFkKSkNCisJCXJldHVy
biAwOw0KIA0KLQlpZiAoIVBhZ2VIdWdlKGhlYWQpICYmIFBhZ2VUcmFuc0h1Z2UoaGVhZCkpIHsN
CisJaWYgKFBhZ2VUcmFuc0h1Z2UoaGVhZCkpIHsNCiAJCS8qDQogCQkgKiBOb24gYW5vbnltb3Vz
IHRocCBleGlzdHMgb25seSBpbiBhbGxvY2F0aW9uL2ZyZWUgdGltZS4gV2UNCiAJCSAqIGNhbid0
IGhhbmRsZSBzdWNoIGEgY2FzZSBjb3JyZWN0bHksIHNvIGxldCdzIGdpdmUgaXQgdXAuDQotLSAN
CjIuMjUuMQ0K
