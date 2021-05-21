Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08738CB48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhEUQwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:52:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:30932 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhEUQwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:52:19 -0400
IronPort-SDR: ZGEaqEYhzMdyh8hb52LnXjv+gTD0JtgQmTRvoRnbXkrNfhednjSztkS5wMOM54l42RlIG2YCVj
 EEE1pSZ1wvig==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="287064553"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287064553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 09:50:24 -0700
IronPort-SDR: wZCqZGCoJAfVumVN16x8HnjuVgsEyNwC5RrJq9NkBspkyHMsaVCtHoI9BTKITFBrfM81NGOaw+
 Bc9Wadp460ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="544148649"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2021 09:50:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 21 May 2021 09:50:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 21 May 2021 09:50:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 21 May 2021 09:50:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 21 May 2021 09:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK/dtWtztztG6fBYQQWTqqtsJizpg1/BwqD7VI7X3I2haPOlf9rT6/jjZgZbQFbjbW+dowVbQ3MusWpzgK9DFN/0oqHeSirDGb6Vvd9C+GxevSsatlbeUFNf81awHAm7r+Qxj06KDGf7pTgZ7V+aT26igqmrydxaE1jw6MU0ZW2ao7RUrEXvo7tzQE19Xh/3m50Rvr3nX8T01TfsFqpwAkrSJ8GCkjQ70HTFEc0ybCcAuKk8kOc1Y6KSBqDRJqZEqvDMG9/mKnp/TCvLEe7v2sAtuMb57ul8UQ+IRWELp6QvCID3+Yml589N+ktnq99ZvZ/gNrqEaIka30SyJnpy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MrWl71YiLtuMgElvSka9WZSYGImx+wTTDdoNpmGfno=;
 b=cckjJmufcYlpUw8TUx7gNHHL6lq5mQAu2Qj5XcJNmR3nlOEy2cwtFZ4Aocg2ztPyjUfDigCdcq/yH2orPN+tRM6FSWMlSfjUOLke7tYj2Tn8Lu5bRlquVKSwZy5xbZuClOq+G9wq9xGhQCrhfpz5qL9OH7R177v77LaUzNKdlb3Kzg1Ts3/6D6bLJUm1ahehQwUcbYNsqvkvDBRwe5D4y33Bk+bLFKn/zQV2+yXRSMIoEHjR8SAwLiicPQOuVrMeIHNmY1wgfNpXv9ZWYo0fosJ9cGLIfxtVJqtaxWul0yn8FDLIqvsvy3BJQLracD6a8e0u78Sa+vhKR/Hq9xVcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MrWl71YiLtuMgElvSka9WZSYGImx+wTTDdoNpmGfno=;
 b=bjb7mnqZqB+LYkG3M60HBv06kFW3xGL8wT50aV6GAog98CGTrG8Gy6tNy1o03kUGuxu64CJFhZBkznK69pKF2ZiEldKlRu8la6BZdytoQkG6sM+kVkGuHQIUGQUttWgKZQ2HdTbDl+FUcbhtMsDsxQETYooqa4ztkEQfyu1JtCs=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 16:50:15 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc%5]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 16:50:15 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>
Subject: Re: [BISECTED] nvme probe failure with v5.13-rc1
Thread-Topic: [BISECTED] nvme probe failure with v5.13-rc1
Thread-Index: AQHXTf44RymihtVr+UGY7aRawigtfKruBySAgAAfnQA=
Date:   Fri, 21 May 2021 16:50:15 +0000
Message-ID: <e8ad9de961f3bfcb748733b59c189aa577ffa1fd.camel@intel.com>
References: <40071b11108987556d0473f9d968fe7dcd3f304a.camel@intel.com>
         <20210521145705.GA29013@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210521145705.GA29013@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 (3.40.1-1.fc34) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d2c4a89-9b1e-454b-4288-08d91c78825b
x-ms-traffictypediagnostic: SJ0PR11MB4896:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4896A52D5C5DE358159FDAFFC7299@SJ0PR11MB4896.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFXK5keNHV10ikoysq6FabQlBml1uYEx6gIUIsSzYQjESAnjplB4TV15Bk86oslgXNFBBacwGghxq+bafvmzAKll5D/EQn0QPTjD/H3mH12Tn5c/awExHcB6w9bu4I1OBakAUwEGgjvIfIarY5wyQAUiGHkBrl0UR1kJYuchU7NzfVcvuSo2clvTagwKHtiIyFkOBJ1ALlC5pXKCKkpcEflyi8QoMtx9xxQXNEhMpp/Boz7m0SRg41zO7ChwB/3XbkI78YcjK801mx4kyMQB3dfnnQ+dwFXbsBXISU9o2C1VBweiwwBN3zodBBNFgpO/jkJ/DR/dI4BBq8jyHmUdD8KR8NYruVss1wSSHRWGeReykDrxdayq2fePPVEPq1n5sUFuYpLNkwF8ygOOWWIN4RT+qtkWx196uIdSwiM/jgswmzj7zmcH+CzIsIj9SGptwmchOf4O/tMbW4P5B0zSiGmNehbOLi/6CwLjcDj86tB9i8KN7rA1nDhEHj3AWO6QMc8AJiPBwRgC9aRL0sNXMX9kQC1vXWXOx3h3ef7MdyyHaIQSze8UBRv+4/1H7VGk+Jt/Io1/ngWNQ3sNx1PmJ4ABGilEe7xRNPrjkjIeof4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(136003)(366004)(316002)(4326008)(6916009)(38100700002)(2906002)(86362001)(71200400001)(2616005)(6486002)(66556008)(6506007)(26005)(64756008)(66476007)(66446008)(6512007)(5660300002)(8676002)(66946007)(478600001)(36756003)(91956017)(8936002)(83380400001)(76116006)(54906003)(122000001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YlRaY1VhSmttbjJyakRjRXRnYjRrNVBrN0MrMS9kT1A0S3NWelVndHNxK0Vz?=
 =?utf-8?B?aWxWZGw5WS91V2VmU3QrRTQ0OWpLTldzV3I1V3p6UDYzdnRWbVF4RCtiUmJL?=
 =?utf-8?B?OTNtaHdKMjdRQlArOVB1eVJTN3lpa1pnRFpjc0xzd01FSjFTTTBjNmNWbElO?=
 =?utf-8?B?ckxBTExRK24zcERzS1dJTEJtK0RMSitIWExiT1VnZjJMZjl4eEFrRjVybS8w?=
 =?utf-8?B?SHBtNWFvRnU2cENHekdUZTJCb1hXbllFcU1ob0ZRSS9zUUxnMndZUzhFNE9s?=
 =?utf-8?B?T0hoUFo1VTZaTUlrN1lycW9ZK2U2ZFFkZnUrNk52ZU5BOGdqamNNaUcvUDFk?=
 =?utf-8?B?RnBoeGl0VmtkM2l2VzJqWExoOFVTQTVYbXVzOXlUdGQzbUFaM1RYKzZkL2dt?=
 =?utf-8?B?ZXZyUVcrb01adGNhMlIwUEJDdzVucGNyQ0hmSlQ2elpCbkFQd3c4aXJ1Q1cv?=
 =?utf-8?B?OG96NG0vUTRzd3RSOE1NYnhtN3lzVVc1RC9UdXZLclI5QXh4V2doSG1wSjJY?=
 =?utf-8?B?amlBTE5NYWFJcm1CeWdCVW5DU2wrbFRaL2hVajFDbENIK1Bka2VjMzRmcWs3?=
 =?utf-8?B?NnB6bytWWGYvR3llTnRNRzVaU2dvYmV3SGNDcjJlMTRmRGZQWUxmYUlGYjMy?=
 =?utf-8?B?RUpYYlk4b001QkxRaE1pY1BFUDFPazVGNEFiYUprbEhNaFV1ZVFNN3hwVUdm?=
 =?utf-8?B?RnR3QW1YRUN2M0ZwdU5LQmlGU1M4VG1YUXN3MVYyaTFIYnptUTVpUHZGK0hO?=
 =?utf-8?B?QythNzFvQVpxVnM5dlVmcHkvbGpqZDZiWHhxT1ZhUmpuZUpYZm5pb25hWlF0?=
 =?utf-8?B?aUM4Y2V5alF2eWlRS2hoV3BkUk9ZYkdsUjYzUUhveGdjdUJ3dFAwMFJVQytG?=
 =?utf-8?B?NW9MNDk2U3ZOZGxMSWNmdy85UVdQMlpuUENNZHpWV0J6MHBoc2h2eUhVVEFI?=
 =?utf-8?B?ZEk3TmlhdWsrb09xYjNGeXIyeldFVEhqOVJxVW16Um1YeStJZ1RBbStIU2N1?=
 =?utf-8?B?R1VRT05DSklvTEgveEdzQkV3YVZlSlg0UWxxS3o2WjduUTM0SUxJSmFHU1lK?=
 =?utf-8?B?am9FRklyN1E0VWp3aWowbmpZYWNMOHk3VEdHb2FJUVFuRUh6c2JMM0hFRjE3?=
 =?utf-8?B?SWFIS3FuQzVGTCtmZERENUZ2YU9BeWhhUDVFK2ZzNUh5eW16TS9xdm5DVGdq?=
 =?utf-8?B?NTZ4cnk2N0hNY25XampzSnFKV20xcGEzUUs2SzM3SUFzWEFqVUtieElmK2k0?=
 =?utf-8?B?K0Ruby9WaG5zNkR3NDA3RVk3V2lsVU1UeW1qcTRlZzIzUWNESktHWkxXelZO?=
 =?utf-8?B?MENPOVBQa2NpbEhXejBkNyt3dmp5bkdCR1BFTlJiNHVnZWdxNC9LSjNwSmF4?=
 =?utf-8?B?dGlFRUx1dTE4aVdMMHR6a2RRZGRXNnRiR2FDRkk2N0FSRk1qaTVlQ3M2QzFh?=
 =?utf-8?B?VWJzd3lWKzJqSFBkRENEMDI5endkRTFXTVhzWXlObHhSV2R2aUN3cUQrUDRX?=
 =?utf-8?B?L2I4TllnZStyY3VrM2hjc0pOb3ZnenpXVFNHMGI0b2h1YmhWbUFvdEpPSHN6?=
 =?utf-8?B?SHo5cEIwUUV5UEM1Vk5OcTRPVDRkRjRNY3RKUmZKRTlMeUliK21lZkV1SnlU?=
 =?utf-8?B?ajBzNlRycDFLVjBLM2VrNEdsTXRpL1pMRXZwdVE0ZENZZEk2NUpnOTM0SkMw?=
 =?utf-8?B?bW90eDZ1N2VIUEFJOTVaTG9tQjUvL2RDbWx5c0Nkd3dvU1gweDEzbTNvbjhM?=
 =?utf-8?B?N1hUNWlYNEVIVk9maDQ4ZUJxSmFxQ01vd2RjTHBPWWZGaHo4RU9mVFI3cERV?=
 =?utf-8?B?RmluNys4eUdJNTl5NDQxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E958432B6E3298479C30455B2738F858@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2c4a89-9b1e-454b-4288-08d91c78825b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 16:50:15.6129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDl84dvL9RH+mAsa3sEJ4xkTKV+F7gGm/1Tw3dXRlGCPnoyY0a9uUfWUpOd4TcSPajpu8bwQXZJEIvfuVJkfz4l5BddpZlhVL0Js7wmQ+EY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA1LTIxIGF0IDIzOjU3ICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gRnJpLCBNYXkgMjEsIDIwMjEgYXQgMDU6MDA6MjlBTSArMDAwMCwgVmVybWEsIFZpc2hhbCBM
IHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IEkgcmFuIGludG8gdGhpcyBmYWlsdXJlIHRvIHBy
b2JlIGFuIG52bWUgZGV2aWNlIGluIGFuIGVtdWxhdG9yDQo+ID4gKHNpbWljcykuIEl0IGxvb2tz
IGxpa2UgdGhlcmUgaXMgYSB+NjAgc2Vjb25kIHdhaXQgZm9sbG93ZWQgYnkgYQ0KPiA+IHRpbWVv
dXQgYW5kIGEgZmFpbHVyZSB0byBib290ICh0aGUgcm9vdCBkZXZpY2UgaXMgYW4gbnZtZSBkaXNr
KSB3aXRoDQo+ID4gdGhlc2UgbWVzc2FnZXMgaW4gdGhlIGxvZzoNCj4gPiANCj4gPiAgICBbICAg
NjcuMTc0MDEwXSBudm1lIG52bWUwOiBJL08gNSBRSUQgMCB0aW1lb3V0LCBkaXNhYmxlIGNvbnRy
b2xsZXINCj4gPiAgICBbICAgNjcuMTc1NzkzXSBudm1lIG52bWUwOiBSZW1vdmluZyBhZnRlciBw
cm9iZSBmYWlsdXJlIHN0YXR1czogLTQNCj4gPiANCj4gPiBJIGJpc2VjdGVkIHRoaXMgdG86DQo+
ID4gICAgNWJlZmM3YzI2ZTVhICgibnZtZTogaW1wbGVtZW50IG5vbi1tZHRzIGNvbW1hbmQgbGlt
aXRzIikgDQo+ID4gDQo+ID4gSXQncyBub3QgaW1tZWRpYXRlbHkgb2J2aW91cyB0byBtZSB3aGF0
J3MgY2F1c2luZyB0aGUgcHJvYmxlbS4NCj4gPiBSZXZlcnRpbmcgdGhlIGFib3ZlIGNvbW1pdCBm
aXhlcyBpdC4gSXQgaXMgZWFzaWx5IHJlcHJvZHVjaWJsZSAtIEknZCBiZQ0KPiA+IGhhcHB5IHRv
IHByb3ZpZGUgbW9yZSBpbmZvIGFib3V0IHRoZSBlbXVsYXRlZCBkZXZpY2Ugb3IgdGVzdCBvdXQN
Cj4gPiBwYXRjaGVzIG9yIHRoZW9yaWVzLg0KPiA+IA0KPiA+IEl0IGlzIG9mIGNvdXJzZSBwb3Nz
aWJsZSB0aGF0IHRoZSBlbXVsYXRlZCBkZXZpY2UgaXMgYmVoYXZpbmcgaW4gc29tZQ0KPiA+IG5v
biBzcGVjLWNvbXBsaWFudCB3YXksIGluIHdoaWNoIGNhc2UgSSdkIGFwcHJlY2lhdGUgYW55IGhl
bHAgZmlndXJpbmcNCj4gPiBvdXQgd2hhdCB0aGF0IGlzLg0KPiANCj4gSGkgVmlzaGFsLA0KPiAN
Cj4gVGhlIHBhdGNoIHlvdSBiaXNlY3RlZCB0byBzZW5kcyBvbmx5IGEgc2luZ2xlIElkZW50aWZ5
IGNvbW1hbmQsIHNvIGl0DQo+IHNvdW5kcyBsaWtlIHRoYXQgbXVzdCBiZSB0aGUgY29tbWFuZCB0
aGF0IHRpbWVzIG91dC4gVGhlIGNvbnRyb2xsZXIgaXMNCj4gbm90IHJlcXVpcmVkIHRvIHN1cHBv
cnQgdGhpcyBzcGVjaWZpYyBpZGVudGlmeSAoQ05TIDB4NiksIGJ1dCBpdCBpcw0KPiByZXF1aXJl
ZCB0byBwcm9kdWNlIGEgcmVzcG9uc2UuIElmIHRoZSBpZGVudGlmeSBpcyB1bnN1cHBvcnRlZCwg
dGhlDQo+IGNvbnRyb2xsZXIgc2hvdWxkIHJlc3BvbmQgd2l0aCBhbiBhcHByb3ByaWF0ZSBlcnJv
ciAoSW52YWxpZCBGaWVsZCBJbg0KPiBDb21tYW5kKSwgYnV0IGl0IGxvb2tzIGxpa2UgdGhlIGNv
bnRyb2xsZXIgZGlkbid0IHJlc3BvbmQgYXQgYWxsLg0KPiANCj4gU28gYmFzZWQgb24geW91ciBv
YnNlcnZhdGlvbiwgaXQgc291bmRzIGxpa2UgdGhlIHNpbWljcyBpbXBsZW1lbnRhdGlvbg0KPiBo
YXMgYW4gaWRlbnRpZnkgYnVnLiBUaGUgc3BlYyBkb2Vzbid0IHByb3ZpZGUgYSB3YXkgZm9yIHRo
ZSBkcml2ZXIgdG8NCj4ga25vdyBhaGVhZCBvZiB0aW1lIHdoZXRoZXIgb3Igbm90IHRoaXMgaWRl
bnRpZmljYXRpb24gaXMgc3VwcG9ydGVkLCBzbw0KPiB0aGUgZHJpdmVyIGp1c3QgaGFzIHRvIHRy
eSBpdCBhbmQgcmVhY3QgdG8gdGhlIHN0YXR1cyBjb2RlLiBJZiB0aGUNCj4gaW1wbG1lbmV0YXRp
b24gY2FuJ3QgYmUgZml4ZWQsIHRoZW4gd2UnbGwgbmVlZCB0byBxdWlyayB5b3VyIGRldmljZS4N
Cj4gDQo+IElmIHlvdSB3YW50IHRvIGNvbmZpcm0gZm9yIGNlcnRhaW4gdGhhdCB0aGUgbmV3IGlk
ZW50aWZ5IGlzIHRoZSBzb3VyY2UNCj4gb2YgeW91ciB0aW1lb3V0LCB5b3UgY291bGQgdHJ5IHRo
ZSBmb2xsb3dpbmcgcGF0Y2ggYW5kIHRoZSB0aW1lb3V0DQo+IHNob3VsZCBnbyBhd2F5Og0KPiAN
Cj4gLS0tDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMNCj4gaW5kZXggMWE3M2VlZDYxZWVlLi5iMTZkMzFkODI2MDYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMNCj4gQEAgLTI3MTEsNyArMjcxMSw3IEBAIHN0YXRpYyBpbnQgbnZtZV9p
bml0X25vbl9tZHRzX2xpbWl0cyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQ0KPiAgCWVsc2UNCj4g
IAkJY3RybC0+bWF4X3plcm9lc19zZWN0b3JzID0gMDsNCj4gDQo+IC0JaWYgKG52bWVfY3RybF9s
aW1pdGVkX2NucyhjdHJsKSkNCj4gKwlpZiAodHJ1ZSB8fCBudm1lX2N0cmxfbGltaXRlZF9jbnMo
Y3RybCkpDQo+ICAJCXJldHVybiAwOw0KPiANCj4gIAlpZCA9IGt6YWxsb2Moc2l6ZW9mKCppZCks
IEdGUF9LRVJORUwpOw0KPiAtLQ0KDQpIaSBLZWl0aCwNCg0KVGhhbmtzIGZvciBsb29raW5nIGlu
dG8gaXQgLSB5ZXMgd2l0aCB0aGF0IHRoZSBwcm9ibGVtIGdvZXMgYXdheS4NCkxldCBtZSBjaGF0
IHdpdGggdGhlIHNpbWljcyBmb2xrcyBhbmQgc2VlIGlmIEkgY2FuIGdldCB0aGVtIHRvIGZpeCBp
dC4NCg0K
