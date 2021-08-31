Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B353FC302
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbhHaGvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:51:15 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58502 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236942AbhHaGvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:51:14 -0400
X-UUID: c2f1d08a72804ff0bd8201c1ec47bee9-20210831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zwEgVmDnWp2li4uVZ50JdP3qOYut6H0f6K2r8txlVl0=;
        b=A5DkMCUxiUtjMTtayec1XL3YY4pGji5koDd0cB8Y2Ks3XUNk8PiShXkFOm4DI5uXIzCHALIocwinjgjscEHUebCSBnI+VeFcI3vrG2/2DfwowNz3cXIPiN8ThIuFUmhQVgv8MPtXXijCQIQZ/JODFsA38qYbFJcZ5h8E4Zt6A20=;
X-UUID: c2f1d08a72804ff0bd8201c1ec47bee9-20210831
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 363505598; Tue, 31 Aug 2021 14:50:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Aug 2021 14:50:11 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 31 Aug 2021 14:50:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+dEyxLWYNQ9rxzr3klBA1gElIEFkDgH5oV7E9CDBkc7yHM4MoGhsGeMFuiX8qZbnexY25ULMGw2Z1HkbLYF1DvWOcnOeP8H9zabwULYZGr8+eQIv7Kh25Jn+0vryEbOgereAiDY9FZwa6k4oU+EttNp1Ir2Mjnz+jHTgNURxzEpC9m86BDShWJqzonYg9IzSTTF/Ass/kkIAjSNMhhWPpN9m+WQlLFTsmf8pbnLksTZQ1ZXGqrPwVRCe/bxLTlqJmfpiDqa3VWBREjvBEWTGrX01m+3XPPiTxlpy+vhLkfEPwv8beH9kUHWUG9YPjo/G+goTl+mFP98zxb7tCvYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zwEgVmDnWp2li4uVZ50JdP3qOYut6H0f6K2r8txlVl0=;
 b=mABb5m49YLyGvurY2pLXIDeOqgPzO57+XNICa0EZZqby8mrJdO01OYfFt1Yd3UeqviQm5o3PqdR8jDyG5wz0aWzaKdunc53UQrWeYS/NDDmFZHiTlAil64JEPXAYG52OpsQO7xvI6kGUkfEuP+XAQPJEliXEjKpWAC7Cx22/HEFB9VOKXMs9K71IKu0KuR3NJDTkA/5dOhflw0OaH4teEj+mY9ldjnEtR2jS0ERindUdgG8SIPBShrt0nqabBwfVOWEkCiitvTPn8AFjJHJ86WGl1bctxZ6FHgGkRMb6YvyTkUfRkAKSTBSQ0TX/LBr/cm+BM2YDU7y7wVlEzblEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwEgVmDnWp2li4uVZ50JdP3qOYut6H0f6K2r8txlVl0=;
 b=oHZaZjPbrnFa/CG5KYVrAO9dV3THEmRFz41jCWfEJM0F46vOuWBC692LQBWfxLxYVHchELqZ5nhwdQQLPm3grfLng7xRaR+8PG2SzaVIGp360auLelsN8MSEZauPVN/v6rKhFnrFsF7N7ZLu9LqTdBk8Y9dC1IRzwGWSOGSoS+E=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KU1PR03MB2950.apcprd03.prod.outlook.com (2603:1096:802:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.14; Tue, 31 Aug
 2021 06:50:00 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c%7]) with mapi id 15.20.4457.017; Tue, 31 Aug 2021
 06:50:00 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        =?utf-8?B?WWFxaWkgV3UgKOatpuS6muWlhyk=?= <Yaqii.Wu@mediatek.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH next v2 3/6] usb: xhci-mtk: update fs bus bandwidth by
 bw_budget_table
Thread-Topic: [PATCH next v2 3/6] usb: xhci-mtk: update fs bus bandwidth by
 bw_budget_table
Thread-Index: AQHXmiVZCYpp+DFuZEGdWMiTnTLyNKuFrdcAgAE9OgCAACh2gIAACawAgARSjQCAAcTLAA==
Date:   Tue, 31 Aug 2021 06:50:00 +0000
Message-ID: <cbf7ad7456003309e587ae86f5743aa0fd1cb2cb.camel@mediatek.com>
References: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
         <20210826025144.51992-3-chunfeng.yun@mediatek.com>
         <CAATdQgBD+dTtBie-cNKRJbfxEpc3haqjfUu1k26mTk8pCSOEww@mail.gmail.com>
         <72ee7a203d8a49e6e43a954b45133470ee6d5c16.camel@mediatek.com>
         <CAATdQgA+4VC7J1LMZYOZMV-OTjMGjO=9bJZ7uaCu_MMF-20T1w@mail.gmail.com>
         <18cb18d7d0ea4a3bb46921aca88c53646f1b3764.camel@mediatek.com>
         <CAATdQgDKuO+bM7_tMy59ghhhjrgCp53kHgYbgEciriHNF3uKuA@mail.gmail.com>
In-Reply-To: <CAATdQgDKuO+bM7_tMy59ghhhjrgCp53kHgYbgEciriHNF3uKuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9895239b-e7fb-4c51-b9bc-08d96c4b8dc2
x-ms-traffictypediagnostic: KU1PR03MB2950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1PR03MB2950310055147D39294B275CFDCC9@KU1PR03MB2950.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dz3qRGtGlDaRtWvZSon8WOVdoTNpmpdu7UJc+ZLmzGWAIn6rIZFcAZM8Ft3v3oeL5/I9beAY6l6zEKOU2IJadRo5rS9jD1xLdUIrflE51fwN5APapM7iu+QR2+xl0lJxxfi9zJlNH7+fYEpzJd3JIUa+/s1KQZDnKtxNUdbx+hLYt2NTvC096UnoljUcenPnF39mpgKX3WahXCI4Al/4yMr6gb/VVjQc7FskbxiJ/qKd5gW1fISn6OAY27PNm/VCrSjEQwa5coQs0EbjqhWcTev+Vbyqk5S1XffDAkU6Rux4+zCfBfSG2JkYDwpRJUK94IghwWEAW46rpGMD7RMdf88sg33tZIJCVKVj7g+EHpMfusrxXZ0uxvYg966rDEVFx4Oy+roU0wprzaO9hsJ6Dph9qWXbJPLEuvVqiUGBxMYoy+ngiA8Mvfr+okMgVln+hSi9n1MDvzZUntBrNLagLwRBtf2mAriDrwXOx4LUUCXWg+ULDk8roJ8kpHNVAq8YybAy2RmIQQ/ERC66q6zyUVbWtjWqmPk47CVvlMinajuW+tNbZRu6QOazwidxdwpGcsw0hnh28cCc9t0KUeiMXRY3UPvsnOJRNxCcK4FbxU+fmvzBWfjKcfJ0rbVIJ1+WnKFMmWgM9ldYewFjLRv5pqJplgwb21Dhnd/36NDt4fGov4dzP/ecp4tTL6jztwEZVCHBRGJMKcclG2wun/fXvAmG62sZUExtNyu16DTdlOZAec2/6NIUZ5+KYzWbLor5NzIeQovXiore3ERrJgRtE4ApJmk5TYZtsyIIhuxt4RU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(6916009)(38070700005)(66446008)(66476007)(64756008)(2616005)(66556008)(8936002)(15650500001)(66946007)(122000001)(6486002)(54906003)(8676002)(316002)(83380400001)(6506007)(71200400001)(85182001)(478600001)(5660300002)(26005)(76116006)(86362001)(38100700002)(6512007)(91956017)(53546011)(4326008)(2906002)(36756003)(186003)(99106002)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVQreStHRDBCWEZoRktvRjRmNUo2eVBVV01nRmRUcEJUUlpkTVY5bE9IYWZO?=
 =?utf-8?B?K0E2dk9EdWFXSVNGMGhsYSthSkQvSGpvOWNXMGc2S3VJRDVUZnkyaHFXalZo?=
 =?utf-8?B?TVZocWJCZnBNS1BjNmxjME5sSWcxYVYxMUJNL2sxRnRjYm1pOWVxRUdhWG14?=
 =?utf-8?B?U3Q5NlU2cHFuRGxEWjNUSTJPeFA4ZmczMURSTXFwRDYyU0RLckl6Rmk1VjFK?=
 =?utf-8?B?UENsOEpobnBJM1FhREtwQUgvNEhrSlp5U3loUU9RZWd1Q0JnTWlhWUR0UkMy?=
 =?utf-8?B?WDJHc3RHNHZhZEM4TGlja3pmOGIxQ3N6TEFXUk9neXF1TFBEMkZXMEsrM1Va?=
 =?utf-8?B?OUhQVXZuTUljVkdiS1FjNDEvSjMwS0JnWmx6NnhGeUxnNUFQeGZ3NjhzcURQ?=
 =?utf-8?B?RHJLTXBvRVJoTE5rakZ4dFFGQW9zaTk2anMyTHNWM2I2SnVLU2pXa1hZWTVS?=
 =?utf-8?B?eDRxVWxDRlpUZkYvTHMyZEU2cm50WVZaRnFDNEdNZG1wZFc0Lzc4NldBZHp1?=
 =?utf-8?B?V2YyV1R4ZlBRcVlrVTkzVVdyeHNGYWpBKzBlN1ppTVlIOHhHVFNMaHg4d0hR?=
 =?utf-8?B?Wkl0dDQzWlhHN3RuWFRPWUxuTXU3ZmFsQTdsSUptcnhhRkdPZjZYTDJNcU1D?=
 =?utf-8?B?WktrbGNSY1o3bVQ5eFpUNUlnV3pVaDhJdzRTbGlaL1ZSNGE2Snd2ZVZFZWtI?=
 =?utf-8?B?dGNGRlJMYTV0ZVp6SE84SzlOdytIZjhFVFgxMkd2Wk5qWW5QMkdYa3p3VGhv?=
 =?utf-8?B?WUZKcHk2aE55bnBJUjBtQ3RNdHpaNmZjWnRscTAvcGxKYjV5VTUzWVAzOWRW?=
 =?utf-8?B?ZzJLaENaNmpYZXJwaCtTZThGaWF5QXNDb1pHT1N1OVQzdWh5WldTMVdoSkx5?=
 =?utf-8?B?RncrdmR2aGd5dFNwM2RkQ25QZUNuOEIzTTk4L3o0QXRCOUpnd1hBWDFtUlpt?=
 =?utf-8?B?dnNFMzJ6dnlWbGROMTFsZExNU2hmeHcvTmVIbjkxTW9GdzQ0YzB2QVNDMExL?=
 =?utf-8?B?ckhYQnZaWXJBMVl1Y2hPSlNLN2NkSmdqV3phTmNPQWN4RWZSUjRsVS9oK3Fq?=
 =?utf-8?B?ZTZpNXZWa1RDQi9YUVJMWUF6bWN1aThneGJ6SHlwcmxmZXRqaGFHMDA2WW1L?=
 =?utf-8?B?VFVyN2dtbVI2eXlTUkNLdFRDQmhkWW52ZHhwTjZRajladytRTTNVTUhDZ2Rj?=
 =?utf-8?B?Y2xTNmp5ejVyeEhhaS9uNWtOcHZ1TG1mbzhaOUorRzJvVHZDYkI5MGFha1F3?=
 =?utf-8?B?TVRGY214SnFJV0ZLZHZQMllIZ2p4MU5MSkRTY0l0OTJFc3NveEVoL3hEVHJ0?=
 =?utf-8?B?a2xSc3BFcFZRelBOdDdzY21RcDBqNGFQdzUzV1IxcE5PTFR6N3VZc3RUd0c5?=
 =?utf-8?B?VGY3clMrelljSjA3bjFXbS9iV2NCOTR4VFJyTzlkREhXV1VOY2FZV253T3BG?=
 =?utf-8?B?L2tybHA1KzN5bkMvYVVRN1NEWk92T2JmVzVFVWVWcGxURG1XSGRNZkszVVIy?=
 =?utf-8?B?bFYveCthUGpJK0xuWWxHTHF5SUhoYkQzY3FrR0s0MEgyY3ZpUjRlc2ZxY29y?=
 =?utf-8?B?bU8zendRdDU3aWNOdVhaUmFxMm9QV01TSjFSODZMN2VSZ2dDUno3aFdhQ2NN?=
 =?utf-8?B?bHBrK3Vxblp6UDlPYkZrSUJOekYyZm1aZjREK0g0b2NPdHJUWXUyeUs1alNx?=
 =?utf-8?B?VUNxQjZmL0FHcW0rZ1BPSlgyaE4rZFUvaEdJQmN2dVRiZWtqMThPTmRUZmk4?=
 =?utf-8?Q?nHC+lLvhLEB3pvP3qx2CyCfhoW7Ik58eJAfoSkn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE232A51C5ECED41B4924BBBA1853325@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9895239b-e7fb-4c51-b9bc-08d96c4b8dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 06:50:00.5192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWz8tDeo8rrVG75WRhixx0GK4bZLkgohoQWxT4qHqb6KiMRnUTuiy6eGNaRy199Ncg4TtCkJHP1YBLfrf/fM86hnLSnqwcO2oorDSogF9uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1PR03MB2950
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTMwIGF0IDExOjQ5ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gRnJpLCBBdWcgMjcsIDIwMjEgYXQgNTo0OSBQTSBDaHVuZmVuZyBZdW4gKOS6keaYpeWzsCkN
Cj4gPENodW5mZW5nLll1bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIEZyaSwg
MjAyMS0wOC0yNyBhdCAxNzoxNCArMDgwMCwgSWtqb29uIEphbmcgd3JvdGU6DQo+ID4gPiBPbiBG
cmksIEF1ZyAyNywgMjAyMSBhdCAyOjQ5IFBNIENodW5mZW5nIFl1biAo5LqR5pil5bOwKQ0KPiA+
ID4gPENodW5mZW5nLll1bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4g
T24gVGh1LCAyMDIxLTA4LTI2IGF0IDE5OjU0ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
PiA+ID4gPiBIaSBDaHVuZmVuZywNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBUaHUsIEF1ZyAy
NiwgMjAyMSBhdCAxMDo1MiBBTSBDaHVuZmVuZyBZdW4gPA0KPiA+ID4gPiA+IGNodW5mZW5nLnl1
bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBVc2UgQGJ3
X2J1ZGdldF90YWJsZVtdIHRvIHVwZGF0ZSBmcyBidXMgYmFuZHdpZHRoIGR1ZSB0bw0KPiA+ID4g
PiA+ID4gbm90IGFsbCBtaWNyb2ZyYW1lcyBjb25zdW1lIEBid19jb3N0X3Blcl9taWNyb2ZyYW1l
LCBzZWUNCj4gPiA+ID4gPiA+IHNldHVwX3NjaF9pbmZvKCkuDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gdjI6IG5ldyBwYXRjaCwgbW92ZSBm
cm9tIGFub3RoZXIgc2VyaWVzDQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJz
L3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5jIHwgMTcgKysrKysrKy0tLS0tLS0tLS0NCj4gPiA+ID4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhj
aS1tdGstc2NoLmMNCj4gPiA+ID4gPiA+IGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2gu
Yw0KPiA+ID4gPiA+ID4gaW5kZXggY2ZmY2FmNGRmYTlmLi44M2FiZDI4MjY5Y2EgMTAwNjQ0DQo+
ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5jDQo+ID4gPiA+
ID4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5jDQo+ID4gPiA+ID4gPiBA
QCAtNDU4LDggKzQ1OCw4IEBAIHN0YXRpYyBpbnQgY2hlY2tfZnNfYnVzX2J3KHN0cnVjdA0KPiA+
ID4gPiA+ID4gbXUzaF9zY2hfZXBfaW5mbyAqc2NoX2VwLCBpbnQgb2Zmc2V0KQ0KPiA+ID4gPiA+
ID4gICAgICAgICAgICAgICAgICAqIENvbXBhcmVkIHdpdGggaHMgYnVzLCBubyBtYXR0ZXIgd2hh
dCBlcA0KPiA+ID4gPiA+ID4gdHlwZSwNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgKiB0
aGUgaHViIHdpbGwgYWx3YXlzIGRlbGF5IG9uZSB1ZnJhbWUgdG8NCj4gPiA+ID4gPiA+IHNlbmQN
Cj4gPiA+ID4gPiA+IGRhdGENCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgKi8NCj4gPiA+
ID4gPiA+IC0gICAgICAgICAgICAgICBmb3IgKGogPSAwOyBqIDwgc2NoX2VwLT5jc19jb3VudDsg
aisrKSB7DQo+ID4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICB0bXAgPSB0dC0+ZnNf
YnVzX2J3W2Jhc2UgKyBqXSArDQo+ID4gPiA+ID4gPiBzY2hfZXAtDQo+ID4gPiA+ID4gPiA+IGJ3
X2Nvc3RfcGVyX21pY3JvZnJhbWU7DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICBmb3IgKGogPSAwOyBqIDwgc2NoX2VwLQ0KPiA+ID4gPiA+ID4gPm51bV9idWRnZXRf
bWljcm9mcmFtZXM7DQo+ID4gPiA+ID4gPiBqKyspIHsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHRtcCA9IHR0LT5mc19idXNfYndbYmFzZSArIGpdICsNCj4gPiA+ID4gPiA+
IHNjaF9lcC0NCj4gPiA+ID4gPiA+ID4gYndfYnVkZ2V0X3RhYmxlW2pdOw0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEknbSB3b3JyeWluZyBhYm91dCB0aGlzIGNhc2Ugd2l0aCB0d28gZW5kcG9pbnRz
LA0KPiA+ID4gPiA+ICogRVAxT1VUOiBpc29jaHJvbm91cywgbWF4cGFja2V0PTE5MjogYndfYnVk
Z2V0X3RhYmxlW10gPSB7DQo+ID4gPiA+ID4gMTg4LA0KPiA+ID4gPiA+IDE4OCwNCj4gPiA+ID4g
PiAwLCAuLi4gfQ0KPiA+ID4gPiA+ICogRVAySU46IGludGVycnVwdCwgbWF4cGFja2V0PTY0OiBi
d19idWRnZXRfdGFibGVbXSA9IHsgMCwgMCwNCj4gPiA+ID4gPiA2NCwNCj4gPiA+ID4gPiA2NCwN
Cj4gPiA+ID4gPiAuLi4gfQ0KPiA+ID4gPiA+IChJcyB0aGlzIGNvcnJlY3QgYndfYnVkZ2V0X3Rh
YmxlIGNvbnRlbnRzIGZvciB0aG9zZSBlcHM/KQ0KPiA+ID4gPiANCj4gPiA+ID4gWWVzLCBlcDFv
dXQgaXNvYyB1c2UgdHdvIHVmcmFtZSwgZXAyaW4gaW50ciB1c2UgYSBleHRyYSBjczsNCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBJJ20gbm90IHN1cmUgaWYgaXQncyBva2F5IGZvciB0aG9zZSB0d28g
ZW5kcG9pbnRzIHRvIGJlDQo+ID4gPiA+ID4gYWxsb2NhdGVkDQo+ID4gPiA+ID4gb24gdGhlIHNh
bWUgdS1mcmFtZSBzbG90Lg0KPiA+ID4gPiA+IENhbiB5b3UgcGxlYXNlIGNoZWNrIGlmIHRoaXMg
aXMgb2theSBmb3IgeGhjaS1tdGs/DQo+ID4gPiA+IA0KPiA+ID4gPiBBbHJlYWR5IHRlc3QgaXQg
dGhpcyBhZnRlcm5vb24sIGNhbiB0cmFuc2ZlciBkYXRhIHJpZ2h0bHkgb24NCj4gPiA+ID4gb3Vy
DQo+ID4gPiA+IGR2dA0KPiA+ID4gPiBlbnYuDQo+ID4gPiA+IA0KPiA+ID4gPiA+IChJIGZlZWwg
bGlrZSBJIGFscmVhZHkgYXNrZWQgdGhlIHNhbWUgcXVlc3Rpb25zIG1hbnkgdGltZXMuKQ0KPiA+
ID4gPiANCj4gPiA+ID4gWWVzLCBhcyBzYWlkIGJlZm9yZSwgcHJlZmVyIHRvIHVzZSBid19idWRn
ZXRfdGFibGVbXSwgaWYgdGhlcmUNCj4gPiA+ID4gaXMNCj4gPiA+ID4gaXNzdWUsIHdlIGNhbiBm
aXggaXQgYnkgYnVpbGRpbmcgdGhpcyB0YWJsZS4NCj4gPiA+IA0KPiA+ID4gU28gZG8geW91IG1l
YW4gc3VjaCBhbiBhbGxvY2F0aW9uIHNob3VsZG4ndCBiZSBhIHByb2JsZW0gYnkgSVANCj4gPiA+
IGRlc2lnbj8NCj4gPiANCj4gPiBZZXMsIGF0IGxlYXN0IG9uIG91ciBkdnQgcGxhdGZvcm0NCj4g
DQo+IERpZCB5b3UgY2hlY2sgdGhhdCB5b3VyIHNpZGUgYWxzbyBoYXMgYSBzaW1pbGFyIGFsbG9j
YXRpb24NCj4gKFNTUExJVC1hbGwgc2l0cyBiZXR3ZWVuIFNTUExJVC1zdGFydCB+IC1lbmQgZm9y
IGFub3RoZXIgZXApPw0KPiBNeSBhdWRpbyBoZWFkc2V0IGRvZXNuJ3Qgd29yayBwcm9wZXJseSB3
aXRoIHRoaXMgc2NoZW1lLg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBzdGFy
dHMgdG8gYWxsb3cgc3VjaCBhbiBhbGxvY2F0aW9uIChhZ2FpbikuDQo+ID4gPiBCdXQgaSByZW1l
bWJlciBteSBlYXJsaWVyIHRlc3RzIHNob3dlZCB0aGF0IHdoZW4gdGhvc2UgdHdvIGVwcw0KPiA+
ID4gaW4gdGhlIGFib3ZlIGV4YW1wbGUgYXJlIGFsbG9jYXRlZCBvbiB0aGUgc2FtZSB1LWZyYW1l
IHNsb3QsDQo+ID4gPiB4aGNpLW10ayBwdXRzICJTU1BMSVQgZm9yIEVQMiIgYmV0d2Vlbg0KPiA+
ID4gIlNTUExJVC1zdGFydCBhbmQgU1NQTElULWVuZCBmb3IgRVAxT1VUIHRyYW5zYWN0aW9uIiwN
Cj4gPiA+IHdoaWNoIGlzIGEgc3BlYyB2aW9sYXRpb24uDQo+ID4gDQo+ID4gV2hpY2ggc2VjdGlv
biBpbiB1c2IyLjAgc3BlYz8NCj4gDQo+IEkgdGhpbmsgdGhhdCdzIGp1c3QgYSBiYXNpYyBydWxl
IC0gaWYgc29mdHdhcmUgd2FudHMgdG8gc2VuZCAxOTINCj4gYnl0ZXMNCj4gdGhyb3VnaCBhIGZ1
bGwtc3BlZWQgYnVzLCBIQyBzaG91bGQgc2VuZCBPVVQvREFUQSAxOTIgYnl0ZXMNCj4gY29udGlu
dW91c2x5IHdpdGhvdXQgaW5zZXJ0aW5nIGFueSBvdGhlciBwYWNrZXRzIGR1cmluZyB0aGF0IDE5
Mg0KPiBieXRlcy4NCj4gYW5kIHVzYjIgMTEuMTQuMiBtZW50aW9ucyB0aGF0IFRUIGhhcyBzZXBh
cmF0ZWQNCj4gU3RhcnQtU3BsaXQgYW5kIENvbXBsZXRlLVNwbGl0IGJ1ZmZlcnMNCj4gYnV0IG5v
dCB0cmFja2VkIGVhY2ggdHJhbnNhY3Rpb24gcGVyIGVuZHBvaW50IGJhc2lzLg0KPiANCj4gPiAN
Cj4gPiA+IEh1YiB3aWxsIGdlbmVyYXRlIGJpdCBzdHVmZmluZyBlcnJvcnMgb24gdGhlDQo+ID4g
PiBmdWxsLXNwZWVkIGJ1cy4NCj4gPiANCj4gPiB3aGljaCBwbGF0Zm9ybT8NCj4gDQo+IEkgcmVt
ZW1iZXIgaXQgd2FzIG10ODE3My4NCkRvZXMgaXQgaGFwcGVuIG9uIG10ODE5Mj8NCg0KPiANCj4g
QW5kIGZvciBiaXQgc3R1ZmZpbmcgZXJyb3JzIEkgbWVudGlvbmVkIGluIHRoZSBlYXJsaWVyIG1h
aWwuDQo+IHdoZW4gSSByZWFkIHRoZSBzcGVjIGFnYWluLCAxMS4yMSBtZW50aW9ucyB0aGF0IGJp
dCBzdHVmZmluZyBlcnJvcg0KPiBpcyBnZW5lcmF0ZWQgd2hlbiBfYSBtaWNyb2ZyYW1lXyBzaG91
bGQgYmUgcGFzc2VkIHdpdGhvdXQNCj4gY29ycmVzcG9uZGluZyBTU1BMSVQtbWlkL2VuZC4gU28g
dGhpcyBpcyBub3QgdGhlIGNhc2UgYW5kIGFsc28NCj4gSSdtIG5vdCBzdXJlIHdoYXQgd2lsbCBo
YXBwZW4gb24gdGhlIGZ1bGwtc3BlZWQgYnVzLCBzb3JyeS4NCj4gSW4gbXkgY2FzZSB3aGF0IEkg
Y2FuIGJlIHN1cmUgb2YgaXMgdGhhdCB0aGUgYXVkaW8gb3V0cHV0IHdhcw0KPiBicm9rZW4gd2l0
aCB0aG9zZSBhbGxvdG1lbnRzLg0KPiANCj4gV2hhdCBpcyB0aGUgeGhjaS1tdGsncyBwb2xpY3kg
d2hlbiB0aGVyZSBhcmUgbW9yZSB0aGFuIHR3byBFUHMNCj4gbWFya2VkIGFzIHRoZSBzYW1lIHUt
ZnJhbWUgb2Zmc2V0IGxpa2UgaW4gdGhlIGFib3ZlIGV4YW1wbGU/DQpTZWVtcyBubyB0aGlzIGxp
bWl0YXRpb24sIGFuIEVQIGRvZXNuJ3QgbW9ub3BvbGl6ZSBhbiB1LWZyYW1lDQoNCj4gDQo+ID4g
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodG1wID4g
RlNfUEFZTE9BRF9NQVgpDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRVNDSF9CV19PVkVSRkxPVzsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICB9DQo+ID4gPiA+ID4gPiBAQCAtNTM0LDIxICs1MzQsMTggQEAgc3RhdGljIHZvaWQgdXBkYXRl
X3NjaF90dChzdHJ1Y3QNCj4gPiA+ID4gPiA+IG11M2hfc2NoX2VwX2luZm8gKnNjaF9lcCwgYm9v
bCB1c2VkKQ0KPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+ICAgICAgICAgc3RydWN0IG11M2hf
c2NoX3R0ICp0dCA9IHNjaF9lcC0+c2NoX3R0Ow0KPiA+ID4gPiA+ID4gICAgICAgICB1MzIgYmFz
ZSwgbnVtX2VzaXQ7DQo+ID4gPiA+ID4gPiAtICAgICAgIGludCBid191cGRhdGVkOw0KPiA+ID4g
PiA+ID4gICAgICAgICBpbnQgaSwgajsNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gICAgICAg
ICBudW1fZXNpdCA9IFhIQ0lfTVRLX01BWF9FU0lUIC8gc2NoX2VwLT5lc2l0Ow0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiAtICAgICAgIGlmICh1c2VkKQ0KPiA+ID4gPiA+ID4gLSAgICAgICAg
ICAgICAgIGJ3X3VwZGF0ZWQgPSBzY2hfZXAtDQo+ID4gPiA+ID4gPiA+YndfY29zdF9wZXJfbWlj
cm9mcmFtZTsNCj4gPiA+ID4gPiA+IC0gICAgICAgZWxzZQ0KPiA+ID4gPiA+ID4gLSAgICAgICAg
ICAgICAgIGJ3X3VwZGF0ZWQgPSAtc2NoX2VwLQ0KPiA+ID4gPiA+ID4gPmJ3X2Nvc3RfcGVyX21p
Y3JvZnJhbWU7DQo+ID4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gPiAgICAgICAgIGZvciAoaSA9IDA7
IGkgPCBudW1fZXNpdDsgaSsrKSB7DQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgYmFzZSA9
IHNjaF9lcC0+b2Zmc2V0ICsgaSAqIHNjaF9lcC0+ZXNpdDsNCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gLSAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBzY2hfZXAtPmNzX2NvdW50OyBq
KyspDQo+ID4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICB0dC0+ZnNfYnVzX2J3W2Jh
c2UgKyBqXSArPQ0KPiA+ID4gPiA+ID4gYndfdXBkYXRlZDsNCj4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICBmb3IgKGogPSAwOyBqIDwgc2NoX2VwLQ0KPiA+ID4gPiA+ID4gPm51bV9idWRnZXRf
bWljcm9mcmFtZXM7DQo+ID4gPiA+ID4gPiBqKyspDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBpZiAodXNlZCkNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdHQtPmZzX2J1c19id1tiYXNlICsgal0gKz0NCj4gPiA+ID4gPiA+IHNjaF9lcC0N
Cj4gPiA+ID4gPiA+ID4gYndfYnVkZ2V0X3RhYmxlW2pdOw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ID4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHR0LT5mc19idXNfYndbYmFzZSArIGpdIC09DQo+ID4gPiA+
ID4gPiBzY2hfZXAtDQo+ID4gPiA+ID4gPiA+IGJ3X2J1ZGdldF90YWJsZVtqXTsNCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICAg
ICAgICAgaWYgKHVzZWQpDQo+ID4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+ID4gMi4xOC4wDQo+ID4g
PiA+ID4gPiANCg==
