Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8571937F02D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350959AbhELX6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:58:51 -0400
Received: from mail-eopbgr1400042.outbound.protection.outlook.com ([40.107.140.42]:47184
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351878AbhELXwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:52:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHIAod8QaqnYQ1zeqyRSDisLoRdBruvMnaGQxyJTTWS/4OVl4HcjEoU3Idw9XUnd3e10Hb6kJ2O/eHFziyiahMkcVOxF7hi8SqDaqd/tO0Ug04eAjHoCgGS0uQH46cWDk6nzsUBAzg6s9JnFOr/Hd67fIf/p6VKJwVU8Ywme5oV8fCJG/8P6LZlvw6R3cajJu0NaMYpma7FenqAItwfHKa6omL2+2H+aLu5lkSxhcxVhf1tTvCS45GSnr4LP5fnlpfmppmuNmQY25iFl3sjHRwDui1zdP1zq9BVsDL44U/GXsUN9qR7Cjr+scBuq0bb1cUDAET8cIabSCal1HEyF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP/AHWk1WSojwew8rxYgeYptyHQAOepAhdACAarVuuo=;
 b=lCj0fxmhuRGQtW5T+5DQZo+xroFBgVYdUuV0r6zp3KAVtJ62AB/cR+voLLtASeDS4xIV6z9MoLuvdL1w2Haif4uhHRZGe5CXbtttlfAHxbY6GWBpJLELPtRqfB8sFK3PKXvPJJuK8tw6YYEXJnQtjikV4iw7P0Zs3Vf2UAiT3XDXD6MOsUiVYMwvIWa7WEtCcCD3QP0ve3A/+TVj/0W08CmJdklzv/iqfia/+udQ0gTiMUHTwYMLBel01Nge3aPCUEMIbD/DuwEs3RJU0VM0lVoBQe+OsS3PwGBid0n9r8PCIFDfUahgP376SQuRqh4tPgcbXiXo8/4jdVmsutJ0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP/AHWk1WSojwew8rxYgeYptyHQAOepAhdACAarVuuo=;
 b=XEZx2yDJDcbtMk3dHYldFeTT3e6d364iewEcuJMqA6Gk0plywrP60FBUyng7mPLBQu75jy6sjgTuS3FE1tWdNWSfX9AQI/eBkxYeVqL53NspoZKm4UREPbCuzx8vVIdNA8ktM/Jd+TBhUL3u8RJO2hgg/I7jXPDskITGbIKgqQc=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB1933.jpnprd01.prod.outlook.com (2603:1096:404:8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 23:51:30 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 23:51:30 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] mm,hwpoison: fix race with compound page
 allocation
Thread-Topic: [PATCH v3 1/2] mm,hwpoison: fix race with compound page
 allocation
Thread-Index: AQHXRnfMctW6aDSg1UK1GvKY2EfBA6rfxTAAgADBVIA=
Date:   Wed, 12 May 2021 23:51:29 +0000
Message-ID: <20210512235129.GA527307@hori.linux.bs1.fc.nec.co.jp>
References: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
 <20210511151016.2310627-2-nao.horiguchi@gmail.com>
 <YJvH1IBcXIGcxLOY@dhcp22.suse.cz>
In-Reply-To: <YJvH1IBcXIGcxLOY@dhcp22.suse.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 924a1872-a50d-406a-f360-08d915a0dd42
x-ms-traffictypediagnostic: TYAPR01MB1933:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB1933E79D8B63E47511A925BCE7529@TYAPR01MB1933.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yz+nJVqf6QFHDQDZTXuru3gD7ZV/vMs3DAcOiT//nsXEOCfvayMDxQCAHFqHPb87kpzQ+9no52DSuXboLSEdkfb5zqerqXkW47LuUbHaWeuRwb9v06MdMOoXU6nCHIIt6JxJlT2Dao3YgNN3tlF4tgaNSsCOyIrcAP5EWQxbZxbHRuHtHgASjp4Vnl2cnhovGsIUlKdrRRWDwCFryifafzoOxeyJKeHRTs8w7pcfK/uLS6jr4DtS+OHvfFxV905/4ubPRcVy8UtRxFv/NplAy6NWtPQ7xp5kLlU4ZHCvdlgjSuAuvUInYlYxW5+KoDxLOmwQHQlsqj40BgHjrC097IlE02Z46Nq+THbi0j1AD9+7A/iOiJraMFt8ir7CH2Fxq9cUxT2v0/lEkAXswwm/uCIeccTX1YhmVrbZTvYcs9Mqq6UMaQ0wkWLAkuvmNnnFxFSUGHYRuyDLNFvbS3Y5X6vgPSPzzM5YZlY3gryBUjpEyQlPGenEfgpfyfJet+mGVqzzhDSUkghPcslPEgz1X2P7D7NUI6YSfJlTFW0tBrvast/0RxFgboyeObCWZm2UK6kWohMAzP5g4vCbcsNHJx2E8bOeloWjEux9XsQF7ss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(6512007)(1076003)(6916009)(8936002)(54906003)(6506007)(316002)(186003)(6486002)(4326008)(71200400001)(9686003)(8676002)(122000001)(66446008)(66556008)(64756008)(66476007)(66946007)(76116006)(38100700002)(478600001)(55236004)(33656002)(5660300002)(26005)(86362001)(83380400001)(2906002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Q3JXVUtGbE52V1ZISk5hODFEQWUwRjRjT3RiRVdQcjFHci9ubVBsQkFHeVd1?=
 =?utf-8?B?ZXU1eU9vZVVGQU5ERW14Sk14bFIyYWxhNGFhREVpTUhwZnJwZG5wRUYzR3Uy?=
 =?utf-8?B?MlFtWm9aSlQwcXl2TXdxU0hsV2ZTQVZsYzNqREl2d1AxaGt6L0twbVgvSmdV?=
 =?utf-8?B?UUJzNVJ0RndqUEFyMWxVZEV2R2ZoQWxWR2d5SnhjTVZHNXR1SXF4UEpGQ0l3?=
 =?utf-8?B?U1VCKy9YM2ZzdEtvcm9Vd0pjcllqZE5hQVVhNlI4eVlhLzdVcGtlL2FPUnR1?=
 =?utf-8?B?Titmak1UYzQwUmZka3Y0eUcxYzFhWGZtV2lnQUt6K0NNTDkzaysrMHNSREk1?=
 =?utf-8?B?RGZxWnJqc3htd09WSmw3dFBhalNUbHNtNnJsTVRPMVFxRWpQRmxFN0xnS2xi?=
 =?utf-8?B?dmJ5cks2NDlrTldwdDNsZ1c4T2RZd2lBZVZUVUFWSzZlSGt1MFo1eGVPOUVZ?=
 =?utf-8?B?MldqcXZ1VlBJaTJBNm9kRnB1ZFlpR3NjdHkwQXlpdGFBU21tcUdTM2wzYnk2?=
 =?utf-8?B?Y0xoMVpZdllLOTU4cURpUmQwd3U4NXBleTZYZlAyYnhGSG04S1RHZEZEcU1t?=
 =?utf-8?B?QTM2c1dpK1BKQWorV1lIcThyNVJELzRvWWk2T2xvNzVQeG51czlOSTQ1MndQ?=
 =?utf-8?B?V05MbVNnRTY0dnR5L0hUYzR2UklqTXRCTGp6eEoxaEpSRDJsbXdmcHJWVXds?=
 =?utf-8?B?cndLVmlFbVcwSHBrSmduRy9oOFh2TC9JQll2dnEwMnl1K1hrS1JPTGpzbXp2?=
 =?utf-8?B?RmFmS3pRbkZlY01hV21oMjJ4SGNkZ08rbFBQU090Sk0xNGw3S3Q3dENvMnMy?=
 =?utf-8?B?K0dqM1FlZ2hXY0MzTlRxTVFCaVFiM25ycXRXNG43eUhCTXRrbWplRTZ5K2NS?=
 =?utf-8?B?b29NancvT1JWZkZ5SjllUHMwV2lPNjBNbFgyOU9kc2o5eGkzN2ZCN25IcldO?=
 =?utf-8?B?Ujl0eTd1UWhWbm53NWx5Qm84ZFNNRE9mVktuWTlkc0xrTVRSOFRHOEZWM0h0?=
 =?utf-8?B?VEZsdkgrYk8rOFBEVlU0NXhkQnpZY1UxMUVLYlQxa3RSMG5XTXJxamt6bzZ6?=
 =?utf-8?B?NTA2VkF6MU5HUzlsdzhLbG9XWFRTMk9qMVNBNlBRR2NkYUJDNEIza1p3UUYv?=
 =?utf-8?B?YU9NWkRlcUtGcVV0Ly9LWjk1VG5TWnBCb0dJeXlhY2dpN1hMZ3dVeWx3RjZG?=
 =?utf-8?B?ZWFoRlphVnlqZUlTd3NZZENhUTRkM2JxZFVoWm1YaG94b3p3cE5sM2FkRC9r?=
 =?utf-8?B?RlVCQkFPQU5vSGlDYUdpRUpTdk1JVG1jeUFOM0xPN25GVDl4OWhUeVFXMXRl?=
 =?utf-8?B?UkdOUmgwSWNSMkk1cWk3NGhaVHNzdy9JVE15anhQWUkraDV2cm5CZlZ6U3Mv?=
 =?utf-8?B?dkQ5ZVUwcFAzaVpHaXJ2ai9seTJGbm96V0RROCtLMG1SUkhlQi9yOWxOa0dv?=
 =?utf-8?B?U1BQbkNjb2d1dkVYVENaajcvNzNSR05XdFByNlZ4ZUR6QWxjbXh4c3B3SWMx?=
 =?utf-8?B?dVZmNkgzTWNKUHBSRUxlOGRvek9uNFE0V3A1dDAwUmp2SVRDRlV5NXkrYWNN?=
 =?utf-8?B?amFwQ2Z3UWpxSzFqV0VHQktUOGFKbFhuYWdybzdDeFNYUWRlSlRrd1czWWdq?=
 =?utf-8?B?aE1IWU9zeUpCa1lKQ0ZiTlhobEd1LzhjRHZwakJZWGg0Z2MvaDJESEFLU0lq?=
 =?utf-8?B?OVlRY1pxTThKTWJ3TkNFclpQNHByVmg1RGM2K2JOQmVFeXFoRVJHSGp2TWp1?=
 =?utf-8?B?RURQTXJYVDJJR0h6dS90aTMrYXZYeExWbldYeEMxTU5jQTBpY0xpTFVkdTNs?=
 =?utf-8?B?TGdLSHZseFUySDhlQXNhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CDDFBB7F2344D40860F6711AB29CE36@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924a1872-a50d-406a-f360-08d915a0dd42
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 23:51:29.9849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +S9kj6JjBYumBX6Qfg5XSNGeMbSC2HKKG/ORy0P9eIwubZp/rCU/o9gb8lno1xdHVVPWcmFtjad5IVskw5vgpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1933
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTIsIDIwMjEgYXQgMDI6MTk6MzJQTSArMDIwMCwgTWljaGFsIEhvY2tvIHdy
b3RlOg0KPiBPbiBXZWQgMTItMDUtMjEgMDA6MTA6MTUsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToN
Cj4gPiBGcm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+
IA0KPiA+IFdoZW4gaHVnZXRsYiBwYWdlIGZhdWx0ICh1bmRlciBvdmVyY29tbWl0aW5nIHNpdHVh
dGlvbikgYW5kDQo+ID4gbWVtb3J5X2ZhaWx1cmUoKSByYWNlLCBWTV9CVUdfT05fUEFHRSgpIGlz
IHRyaWdnZXJlZCBieSB0aGUgZm9sbG93aW5nIHJhY2U6DQo+ID4gDQo+ID4gICAgIENQVTA6ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQ1BVMToNCj4gPiANCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBnYXRoZXJfc3VycGx1c19wYWdlcygpDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWdlID0gYWxsb2Nfc3VycGx1c19odWdlX3Bh
Z2UoKQ0KPiA+ICAgICBtZW1vcnlfZmFpbHVyZV9odWdldGxiKCkNCj4gPiAgICAgICBnZXRfaHdw
b2lzb25fcGFnZShwYWdlKQ0KPiA+ICAgICAgICAgX19nZXRfaHdwb2lzb25fcGFnZShwYWdlKQ0K
PiA+ICAgICAgICAgICBnZXRfcGFnZV91bmxlc3NfemVybyhwYWdlKQ0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgemVybyA9IHB1dF9wYWdlX3Rlc3R6ZXJvKHBhZ2Up
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWTV9CVUdfT05fUEFH
RSghemVybywgcGFnZSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGVucXVldWVfaHVnZV9wYWdlKGgsIHBhZ2UpDQo+ID4gICAgICAgcHV0X3BhZ2UocGFnZSkNCj4g
PiANCj4gPiBfX2dldF9od3BvaXNvbl9wYWdlKCkgb25seSBjaGVja3MgcGFnZSByZWZjb3VudCBi
ZWZvcmUgdGFraW5nIGFkZGl0aW9uYWwNCj4gPiBvbmUgZm9yIG1lbW9yeSBlcnJvciBoYW5kbGlu
Zywgd2hpY2ggaXMgd3JvbmcgYmVjYXVzZSB0aGVyZSdzIHRpbWUNCj4gPiB3aW5kb3dzIHdoZXJl
IGNvbXBvdW5kIHBhZ2VzIGhhdmUgbm9uLXplcm8gcmVmY291bnQgZHVyaW5nIGluaXRpYWxpemF0
aW9uLg0KPiA+IA0KPiA+IFNvIG1ha2VzIF9fZ2V0X2h3cG9pc29uX3BhZ2UoKSBjaGVjayBwYWdl
IHN0YXR1cyBhIGJpdCBtb3JlIGZvciBhIGZldw0KPiA+IHR5cGVzIG9mIGNvbXBvdW5kIHBhZ2Vz
LiBQYWdlU2xhYigpIGNoZWNrIGlzIGFkZGVkIGJlY2F1c2Ugb3RoZXJ3aXNlDQo+ID4gIm5vbiBh
bm9ueW1vdXMgdGhwIiBwYXRoIGlzIHdyb25nbHkgY2hvc2VuLg0KPiANCj4gVGhpcyBzaG91bGQg
cmVhbGx5IGRlc2NyaWJlIHRoZSBmaXggaW4gbW9yZSBkZXRhaWxzLiBFLmcuDQo+IFsuLi5dDQo+
ID4gQEAgLTEwOTUsMzAgKzEwOTUsNDMgQEAgc3RhdGljIGludCBfX2dldF9od3BvaXNvbl9wYWdl
KHN0cnVjdCBwYWdlICpwYWdlKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcGFnZSAqaGVhZCA9IGNv
bXBvdW5kX2hlYWQocGFnZSk7DQo+ID4gIA0KPiA+IC0JaWYgKCFQYWdlSHVnZShoZWFkKSAmJiBQ
YWdlVHJhbnNIdWdlKGhlYWQpKSB7DQo+ID4gLQkJLyoNCj4gPiAtCQkgKiBOb24gYW5vbnltb3Vz
IHRocCBleGlzdHMgb25seSBpbiBhbGxvY2F0aW9uL2ZyZWUgdGltZS4gV2UNCj4gPiAtCQkgKiBj
YW4ndCBoYW5kbGUgc3VjaCBhIGNhc2UgY29ycmVjdGx5LCBzbyBsZXQncyBnaXZlIGl0IHVwLg0K
PiA+IC0JCSAqIFRoaXMgc2hvdWxkIGJlIGJldHRlciB0aGFuIHRyaWdnZXJpbmcgQlVHX09OIHdo
ZW4ga2VybmVsDQo+ID4gLQkJICogdHJpZXMgdG8gdG91Y2ggdGhlICJwYXJ0aWFsbHkgaGFuZGxl
ZCIgcGFnZS4NCj4gPiAtCQkgKi8NCj4gPiAtCQlpZiAoIVBhZ2VBbm9uKGhlYWQpKSB7DQo+ID4g
LQkJCXByX2VycigiTWVtb3J5IGZhaWx1cmU6ICUjbHg6IG5vbiBhbm9ueW1vdXMgdGhwXG4iLA0K
PiA+IC0JCQkJcGFnZV90b19wZm4ocGFnZSkpOw0KPiA+IC0JCQlyZXR1cm4gMDsNCj4gPiArCWlm
IChQYWdlQ29tcG91bmQocGFnZSkpIHsNCj4gDQo+IFNvIHlvdSBkbyByZWx5IG9uIFBhZ2VDb21w
b3VuZCB0byBiZSB0cnVlLiBXaGljaCBpcyBwcm9uZSB0byByYWNlcyBhcw0KPiB3ZWxsLiBBbGwg
eW91IG5lZWQgaXMgdG8gY2hlY2sgYmVmb3JlIHByZXBfY29tcG91bmRfcGFnZSBhbmQgcnVuIGlu
dG8NCj4gZ2V0X3BhZ2VfdW5sZXNzX3plcm8gKGRvd24gaW4gdGhpcyBmdW5jdGlvbikgYmVmb3Jl
IGh1Z2V0bGIgcmVhY2hlcw0KPiBwdXRfcGFnZV90ZXN0emVyby4gT3IgZG8gSSBtaXNzIHNvbWV0
aGluZyB0aGF0IHdvdWxkIHByZXZlbnQgZnJvbSB0aGF0Pw0KDQpObywgeW91J3JlIHJpZ2h0LCB0
aGUgcmFjZSBjYW4gc3RpbGwgaGFwcGVuIChJIG9ubHkgY29uc2lkZXJlZCB0aGUgY2FzZSB3aGVu
DQphIGNvbXBvdW5kIHBhZ2UgaXMgYWxyZWFkeSBhbGxvY2F0ZWQsIHRoYXQgd2FzIGluc3VmZmlj
aWVudC4uLikuICBBbnkgY2hlY2sNCm91dHNpZGUgbG9ja2luZyBzZWVtcyBoYXJtZnVsLCBzbyBk
b2VzIHRoZSBjaGVja2luZyBsaWtlIGJlbG93IG1ha2UgbW9yZQ0Kc2Vuc2U/DQoNCiAgICBzdGF0
aWMgaW50IF9fZ2V0X2h3cG9pc29uX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQogICAgew0KICAg
ICAgICAgICAgc3RydWN0IHBhZ2UgKmhlYWQgPSBjb21wb3VuZF9oZWFkKHBhZ2UpOw0KICAgICAg
ICAgICAgaW50IHJldCA9IDA7DQoNCiAgICAjaWZkZWYgQ09ORklHX0hVR0VUTEJfUEFHRSAgIC8v
IHRoaXMgI2lmZGVmIGlzIG5lZWRlZCBmb3IgaHVnZXRsYl9sb2NrDQogICAgICAgICAgICBzcGlu
X2xvY2soJmh1Z2V0bGJfbG9jayk7DQogICAgICAgICAgICBpZiAoUGFnZUh1Z2UoaGVhZCkgJiYg
KEhQYWdlRnJlZWQoaGVhZCkgfHwgSFBhZ2VNaWdyYXRhYmxlKGhlYWQpKSkNCiAgICAgICAgICAg
ICAgICAgICAgcmV0ID0gZ2V0X3BhZ2VfdW5sZXNzX3plcm8oaGVhZCk7DQogICAgICAgICAgICBz
cGluX3VubG9jaygmaHVnZXRsYl9sb2NrKTsNCiAgICAgICAgICAgIGlmIChyZXQgPiAwKQ0KICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KICAgICNlbmRpZg0KICAgIA0KICAgICAgICAg
ICAgLy8gb3RoZXIgdHlwZXMgb2YgY29tcG91bmQgcGFnZS4NCiAgICAgICAgICAgIC4uLg0KDQog
ICAgICAgICAgICByZXR1cm4gZ2V0X3BhZ2VfdW5sZXNzX3plcm8ocGFnZSk7DQogICAgfQ0KDQot
IE5hb3lh
