Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53937F039
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhEMAFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:05:48 -0400
Received: from mail-eopbgr1400045.outbound.protection.outlook.com ([40.107.140.45]:38533
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352824AbhEMACK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:02:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI4KbzxnqaRy7AjpRBRDFwiZxTnBJTnCSeOPcsqvwovCUASjzdZP3pxwR/L1TqIsPqTcT6KeN0/EGdZOZvI8b2SBLnMnr4i1noIIlCmw/DTRfJbxVc4hH4uPhuHhysDzQ2yxwYAJ8qAE3opSFIOZJHg1NTuq6QkUmeMQLmx0F5sNi3SPdj2koycgbGwYVgDBT3kjVDSPfecyYEk0Sbr7iU/v7v3SPj09Ez2/4r61SCVIaJ2tz/TSVRbNCttCgdCjGmmJtUPW906uVwKvlKuPRDWSClRyAn38eiGDqMbWYedHgyCWXZ7ZpcVtsQUcAfbU8OC5E4tD9KmAM/u5N+BrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF/Lmdl4iJAIXmfJoKb/+vQGfozl0c6ostYSXTTIoks=;
 b=YwD0oUfoWvXxVoqN1sCV4LBZALMjOGjoWEiwCUtbpBTqnEZMzPrY08eBUp8xxtP3PJD1lh+Iy5ggB4ih4G9Uuzgc3P00AAuT1BxM+ih/3N1zNKHe/Ba/62KiJHwZKJJclC2w1biKo+RcfNnAZNKk2auRSIy4kn37t+ZjXw2znh2wEW5pBWkmTtcuZc3mTihSqEXVOrmJxcvtvWoPNGxLXA8EufXkL/jGhLJHQjVbb0+0XJ1SHSeLFY+ECKJfyxs7bI1+Z4GPcUR6EPFR+JZMfdFhO92vfr7vLU8gMhDTjCJs2R6lSvzLF/cHBbFnt4wyFeyH36Gn1zLjvBGhbsBAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF/Lmdl4iJAIXmfJoKb/+vQGfozl0c6ostYSXTTIoks=;
 b=jaoHLNed6MdIryav23yI12hhARMEDKscRWWPWhyYt2eCRpd8jOGHBeNA5LUzss1yJe9i0BBsOR9V2HjK7sIfmCDbG0MlzBDtrSYRZ3HNk4n9I2QN/hqWSiHYc6vBS5hTVuTebj/nusmhigmaFsHiHgJTrzOQpbRRWDbj9DOp+XA=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB5932.jpnprd01.prod.outlook.com (2603:1096:404:8057::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 00:00:59 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 00:00:57 +0000
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
Subject: Re: [PATCH v3 1/2] mm,hwpoison: fix race with compound page
 allocation
Thread-Topic: [PATCH v3 1/2] mm,hwpoison: fix race with compound page
 allocation
Thread-Index: AQHXRnfMctW6aDSg1UK1GvKY2EfBA6rfhgIAgAEDJgA=
Date:   Thu, 13 May 2021 00:00:57 +0000
Message-ID: <20210513000056.GA563308@hori.linux.bs1.fc.nec.co.jp>
References: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
 <20210511151016.2310627-2-nao.horiguchi@gmail.com>
 <20210512083319.GA14726@linux>
In-Reply-To: <20210512083319.GA14726@linux>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82547189-ebab-43a3-26b3-08d915a22f85
x-ms-traffictypediagnostic: TYAPR01MB5932:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB59322056707E5E35D12BF321E7519@TYAPR01MB5932.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z7venhJb3ZKTZfanBXMqMpy5X6KeoCI0AGV03FDcB5+Uc4k3cl96x+PxH1Wv/D1zVoUbqX0qFMLVd2RUcUJDO/Sx0QcPLnidVaHDLDGMxOVu0sW3HENUz+3JYf8i9czjO5M7jKZvu60pUeF0GuZmOVlp8/HO1UcbfYGCd1fAx6LvPJpRB35iRRibD0WK+Ky0sZS+TOPxB6fwCkPJ1djfQAaWloRjQlLPxq60ETYNlkcbQpyYHVRjfqHre00j8gUlGfuljjPZqIllMSE9PTL+6wW7+7Fole3JAID00EZUPe7DoCYkiHAMR8MwpRIH+3IHcT9F25jNEPwUEW48kdSxddNjjxVDtreEyumDjRLoH1f4YggEw1INalfboLtda1/nfoYniAY1Qa82FC9Esxwqm58jPyjc+OwmKG9DQiojE9VBsCdWEB8IBGVLT6DIjlxxMc84TPmS6TDcLOxxxVTxyU6bnb1AohBphsKPNxkUgxqwSxDm0PZUsBK3YoT8/hSND1YdtxURvdd+dh7JMMOQ7ygw7HtscDeZfc2nSY61HsG8Hy2Kpf6p3lreGhaNloW7O22bzgrrAPO+eu11dZGE2GSw53VY0RwxFRJtmgCWuh0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(55236004)(1076003)(9686003)(478600001)(8676002)(6512007)(8936002)(4326008)(6506007)(83380400001)(186003)(6486002)(85182001)(54906003)(6916009)(5660300002)(316002)(38100700002)(122000001)(26005)(2906002)(66446008)(86362001)(66476007)(66556008)(33656002)(76116006)(71200400001)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bUhEalhacHJEWEw5ZlAySS9GdGFQNmJWWnRwUDRVRTgxTzZpSUtQVjVSbUU3?=
 =?utf-8?B?UUNPZ1BoMkNUZDFkL01FYmdJRlI4MWVIaittNEZuYVZsZUN0WmRsL2MwNzBE?=
 =?utf-8?B?TjN3bUw3Yk5Bb1JkUHd3WEVDdlFOVmxUNXpmN2RiTTVIMVVIUVoxTTlmWFli?=
 =?utf-8?B?YTdic1pMYWJVczVVOHkrMTNiczFCM1VvMWp1eEV0VTNCME1VK2NHOEd5UHRX?=
 =?utf-8?B?bGF0YVZXMEhwMkIrOGpXVkM5dGdqSU91ZmRmQkpQTE5UbEFOcno3T1JyUE5J?=
 =?utf-8?B?QnBrTmc0WEhDYTUvWkEzdFdsaThaeWFUYTlodURTVndrTnNtUlVUR201VGZF?=
 =?utf-8?B?ZGdCQ29lOWV1Q2h1ZEJTMTlBdkJqS0lFcHgxNGV5cm9NL3lLRFVZMFcrYWZD?=
 =?utf-8?B?b3BpQVp1bWZGU2Y5MVJrd2hGdUpEZG5hMFV2K3ViZTR5S2FhUkVwQmpqeDRW?=
 =?utf-8?B?V1RuMEs0RnM3KzVTMzVJdUpXMW1TUER1NEVrWXcyT0xPLzBORiszVmZBbUNW?=
 =?utf-8?B?ME1yZXhrbWZBbmNnK01YclNlRnpQeExZRmtNNHVDZnp2RitSdEdJZTZwVTBE?=
 =?utf-8?B?S3VnYVY4RkEzVHRSeGVqWkVwd3pWbmYwRVlFcVBKSlM1Z1BFUG41bEc1ZS9l?=
 =?utf-8?B?YUtrdG9tZ1A0dkFYOWFvS2tJazNMcDlyZGk3Z0Z4WWVaMCtDdUlvNGFVZ1ZP?=
 =?utf-8?B?SmxkWFhaY3BaWkEvQlNRN3pqK0s4VGpEbUxYY0d1NC9ObzZPNklNaytvZjNO?=
 =?utf-8?B?NXNMdTFhbG1yR1F4aXlhYTRvS0l5a2pkTFZNZTBSR3J4d0dDdXhZL0liTS9W?=
 =?utf-8?B?YXhCdTNzZUF6OU56TW9uMXZkR09rcnB0U0pYaXZZWXc1SmpDRzJNT09HVkU5?=
 =?utf-8?B?VU9RL1FZdmlzM3RYTzhTbjdYR1Nsc2x6UWNJTEY0N1NmTTcyd2kxRWtYbmcv?=
 =?utf-8?B?TEhsU0s1R1IwR2hSVldBUUdrL2hyZ3liUjg5SllUUGxwaXN4K3pvNmlhdERE?=
 =?utf-8?B?YzBaMmphSGtGSTU0bStjdkJBN1NkaFU3QmlaWGFRd0hDcTQ0cFZidGRXOHVs?=
 =?utf-8?B?V29TbU45OHYvd2doRldPRENpUHVpblZQVnlObjRkMm9GQitNNmt2Rjhjb21z?=
 =?utf-8?B?dHEvdnlCaUt2ZnQzSGk5QlQzSC9IbjZjWDUzMjZPZWhkOVFXeDVIWFBHUVk4?=
 =?utf-8?B?dnp0M01TYWIwazY1WjM4NGQ2ZFh3VzRXN0xCT2RESFpyeGo3ZGRJMFo0SmN0?=
 =?utf-8?B?WUJKLzZqK3N4SW0zdjA0RkJ3Ly91RFRiL2I4ZVFJc1h1WHZMM0dvVi9OWUlP?=
 =?utf-8?B?cjd1YTBJVHdYWUg0RGVEc2ZvU1pzcFl4VnVESDRuZXdvTHlCVUMxS1V2WGRW?=
 =?utf-8?B?azF3QVNjdmxTenUzd1prVVNqT2xaSkJSa0RXeUhhZ09NMldiNkdtUlI3UmJy?=
 =?utf-8?B?QklwcFlFbUNXK3ZkRERCMzArV2Y0Wnk2ai8rTW9wNUJsdjdnSm5QRlFmeTlN?=
 =?utf-8?B?MWJyQU50VmdXbHpQYVh2ODlhcFpoZDBDNDJmZHZHVDU0K0lqUWNPaXVvbith?=
 =?utf-8?B?MlhyVXNWN2VYWWMrYS9Gc3BGWTF0bVFOaEZ6YWVLaVZmdVhXMzl0WWdMMEhs?=
 =?utf-8?B?WGdQQmdUQVAxa3RnVXpPWndEbFd6eWpkOFdSV1puTDRzMXNwTHZFNUpHK0FV?=
 =?utf-8?B?V1hVc0J0ZDZFb25FQ1ZjOVI3VE5jQmI2eWFya3A5QzVVbzd6YXlJZ0dOdHFK?=
 =?utf-8?Q?ywMzrhfddzgx/+Pesiwu1F9Di+oYew+GU9o67Vj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E78A615A3D840D4D97D0FBB97F1B52FE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82547189-ebab-43a3-26b3-08d915a22f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 00:00:57.5096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zk1QJ3rUgni9OKxYk3Su9OAUVRgkBUskv4zVVyn2xSnqCIthP1PKvawSjYZhejn6/gDKV4Hg3a+MilnWddNQ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5932
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTIsIDIwMjEgYXQgMTA6MzM6MjRBTSArMDIwMCwgT3NjYXIgU2FsdmFkb3Ig
d3JvdGU6DQo+IE9uIFdlZCwgTWF5IDEyLCAyMDIxIGF0IDEyOjEwOjE1QU0gKzA5MDAsIE5hb3lh
IEhvcmlndWNoaSB3cm90ZToNCj4gPiBAQCAtMTA5NSwzMCArMTA5NSw0MyBAQCBzdGF0aWMgaW50
IF9fZ2V0X2h3cG9pc29uX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ID4gIHsNCj4gPiAgCXN0
cnVjdCBwYWdlICpoZWFkID0gY29tcG91bmRfaGVhZChwYWdlKTsNCj4gPiAgDQo+ID4gLQlpZiAo
IVBhZ2VIdWdlKGhlYWQpICYmIFBhZ2VUcmFuc0h1Z2UoaGVhZCkpIHsNCj4gPiAtCQkvKg0KPiA+
IC0JCSAqIE5vbiBhbm9ueW1vdXMgdGhwIGV4aXN0cyBvbmx5IGluIGFsbG9jYXRpb24vZnJlZSB0
aW1lLiBXZQ0KPiA+IC0JCSAqIGNhbid0IGhhbmRsZSBzdWNoIGEgY2FzZSBjb3JyZWN0bHksIHNv
IGxldCdzIGdpdmUgaXQgdXAuDQo+ID4gLQkJICogVGhpcyBzaG91bGQgYmUgYmV0dGVyIHRoYW4g
dHJpZ2dlcmluZyBCVUdfT04gd2hlbiBrZXJuZWwNCj4gPiAtCQkgKiB0cmllcyB0byB0b3VjaCB0
aGUgInBhcnRpYWxseSBoYW5kbGVkIiBwYWdlLg0KPiA+IC0JCSAqLw0KPiA+IC0JCWlmICghUGFn
ZUFub24oaGVhZCkpIHsNCj4gPiAtCQkJcHJfZXJyKCJNZW1vcnkgZmFpbHVyZTogJSNseDogbm9u
IGFub255bW91cyB0aHBcbiIsDQo+ID4gLQkJCQlwYWdlX3RvX3BmbihwYWdlKSk7DQo+ID4gLQkJ
CXJldHVybiAwOw0KPiA+ICsJaWYgKFBhZ2VDb21wb3VuZChwYWdlKSkgew0KPiA+ICsJCWlmIChQ
YWdlU2xhYihwYWdlKSkgew0KPiA+ICsJCQlyZXR1cm4gZ2V0X3BhZ2VfdW5sZXNzX3plcm8ocGFn
ZSk7DQo+ID4gKwkJfSBlbHNlIGlmIChQYWdlSHVnZShoZWFkKSkgew0KPiA+ICsJCQlpbnQgcmV0
ID0gMDsNCj4gPiArDQo+ID4gKwkJCXNwaW5fbG9jaygmaHVnZXRsYl9sb2NrKTsNCj4gPiArCQkJ
aWYgKCFQYWdlSHVnZShoZWFkKSkNCj4gPiArCQkJCXJldCA9IC1FQlVTWTsNCj4gPiArCQkJZWxz
ZSBpZiAoSFBhZ2VGcmVlZChoZWFkKSB8fCBIUGFnZU1pZ3JhdGFibGUoaGVhZCkpDQo+ID4gKwkJ
CQlyZXQgPSBnZXRfcGFnZV91bmxlc3NfemVybyhoZWFkKTsNCj4gPiArCQkJc3Bpbl91bmxvY2so
Jmh1Z2V0bGJfbG9jayk7DQo+ID4gKwkJCXJldHVybiByZXQ7DQo+IA0KPiBVaG0sIEkgYW0gaGF2
aW5nIGEgaGFyZCB0aW1lIHdpdGggdGhhdCAtRUJVU1kuDQo+IEF0IHRoaXMgc3RhZ2UsIHdlIGV4
cGVjdCBfX2dldF9od3BvaXNvbl9wYWdlKCkgdG8gZWl0aGVyIHJldHVybiB0cnVlIG9yIGZhbHNl
LA0KPiBkZXBlbmRpbmcgb24gd2hldGhlciBpdCBjb3VsZCBncmFiIGEgcGFnZSdzIHJlZmNvdW50
IG9yIG5vdC4gUmV0dXJuaW5nIC1FQlVTWQ0KPiBoZXJlIHNlZW1zIHdyb25nIChwbHVzIGl0IGlz
IGluY29uc2lzdGVudCB3aXRoIHRoZSBjb21tZW50IGFib3ZlIHRoZSBmdW5jdGlvbikuDQo+IEl0
IG1pZ2h0IGJlIHVzZWZ1bCBmb3IgdGhlIGxhdHRlciBwYXRjaCwgSSBkbyBub3Qga25vdyBhcyBJ
IHlldCBoYXZlIHRvIGNoZWNrDQo+IHRoYXQgb25lLCBidXQgaWYgYW55dGhpbmcsIGxldCB1cyBz
dGF5IGNvbnNpc3RlbnQgaGVyZSBpbiB0aGlzIG9uZS4NCj4gU28sIGlmIGh1Z2V0bGIgdmFuaXNo
ZWQgdW5kZXIgdXMsIGxldCB1cyByZXR1cm4gIndlIGNvdWxkIG5vdCBncmFiIHRoZQ0KPiByZWZj
b3VudCIuIERvZXMgaXQgbWFrZSBzZW5zZT8NCg0KWWVzLCB5b3UgYXJlIHRvdGFsbHkgcmlnaHQu
ICBJIGZhaWxlZCB0byBwcm9wZXJseSBzcGxpdCB0aGUgcGF0Y2guDQotRUJVU1kgaXMgbm9uLXpl
cm8sIHNvIGl0J3MgY29uc2lkZXJlcmQgYXMgInN1Y2Nlc3NmdWxseSBwaW5uZWQiLCB3aGljaCBp
cw0Kbm90IHRydWUuICBJIHNob3VsZCd2ZSBzZXQgcmV0IHRvIDAuDQoNCi0gTmFveWE=
