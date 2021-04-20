Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECBC365CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhDTPza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:55:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:40402 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232504AbhDTPz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:55:28 -0400
IronPort-SDR: R16Sfz6sBHqpdZ4XC/Qk3H8bpmOZYpSFqjNZTJTqZe9VrHoUwai4zkpTvr4aSqFy4gBjd5quJ6
 SvbpbPBbc0xw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="280860713"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="280860713"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:54:55 -0700
IronPort-SDR: LTF9RTsSTymexx0QocH/3bZ8vcj1Enz+3XFHTy/TydgcQ0X0C8zvJkUQxckA+8iyKo8eQk9Ukf
 J6exfGVq3Dvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="385376903"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 20 Apr 2021 08:54:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 08:54:55 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 08:54:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 20 Apr 2021 08:54:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 20 Apr 2021 08:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/bGrNuDfJrohDdp8m5JWl0hZyFEgQMRIRlw8h4RifNFtNu+rrevwNPOX8jzk9qwQ3X5yZefj1o4dSPZbxQW/GO2ZoDAGApywmCIPpmxvn1g3447f2MgUDsujx6ci72AYJQ4iiXNc3YDSvGT9OZC1DlPqGVK5XB2ERwDxUSbm7c2zbkY7IIuaufbq3GO0G3XO/bVhywKEnri1tkarUYJYDyh4f9JAEc4pEYn6/ChEY17HZmZqh6oGXVZ9J1wrtA1cHzhWqwHwEQr3XslT3Ek4UH0QnFJXFY5iqt5e3S99EYBVc1xqTlD6/lJUWGowCoGmezEtYAIpRWO+HRHjcClTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe4cCrenEFYIzfeo/GKbHy2z3Ao8hM/3y+LqpO6P5j0=;
 b=IF5D6EOEiVjTrYHQzsaE/q2Wz8SnhxYDW5/6KekKXmmSF4oexSBJObiKAbGUSI9w/GN+WjnXN0qkUX6ZdO9E0TZJh7R36kUTB9gB1wv1JD+2e2V78+X7gc/22ylcLZRYuP1dd54si+tw7QeXFqQa/Ye2/j/Lc4a6KkOFV0f+jv13dlVbE+AA+ju+QVTKA5zgp6ofPFcOAg4bTe+NiOQp8knX7NveVaDncjuMPMQ5FQ5AXMs6k6DOYZziSmmP0Fe5ky8OZQxqJoE5yFKJxpxWVAhYW4ctpX1zeL98dK068+NBT2203jncJuZNpxRTniIuEUojrLSnMBFm/c5nZR9iKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe4cCrenEFYIzfeo/GKbHy2z3Ao8hM/3y+LqpO6P5j0=;
 b=bB6mzj3iN5sZihCseTZ5fKDPubIbwwUS/fCO8Fbk/G8sn5AOGqfbN6eDpoTkXmnTG5TOh1hq+Q5KKkrw1+sG1LbU/oOPYXT+AzjW5i33jVETtkHTKgxPewRJYrvJrnT2jg4rV4a+K6jagXnVYwwOk0TN6FkVg5A7+ml8gNxbO3o=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5134.namprd11.prod.outlook.com (2603:10b6:a03:2de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Tue, 20 Apr
 2021 15:54:49 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::41e6:b61:67ef:2712]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::41e6:b61:67ef:2712%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 15:54:49 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: RE: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Thread-Topic: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Thread-Index: AQHXMvxos6/G1E0Lb0im/q88amHNoKq3m/kAgAAYKgCABMAQMIABIANw
Date:   Tue, 20 Apr 2021 15:54:48 +0000
Message-ID: <BYAPR11MB3256014ACBE12F02D6738F0287489@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
 <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
 <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
 <YHn2oiP+2YpkFGXQ@smile.fi.intel.com>
 <CAPcyv4g=XyFfDZYL-brAO7LTVEc90=x7aQWar_WZtfnPx09UVQ@mail.gmail.com>
 <CY4PR11MB1590FE3E5B4AC80972BD253AF0499@CY4PR11MB1590.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB1590FE3E5B4AC80972BD253AF0499@CY4PR11MB1590.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b2d3087-b362-429c-6230-08d90414a0b0
x-ms-traffictypediagnostic: SJ0PR11MB5134:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB51349478840064430DE7C8BF87489@SJ0PR11MB5134.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zYp4LMQ6jtqqSP0FNNuV57m4zUAZOienxn4e5m+CntO/z9mE60ijbyNwVrgS9lC8gsxwWRWgRNeYIC2RCUJSFS+IgK/csMbIEiIff61Ypb3lH+ok4afLI9x/bY1jQOIurqmyuSRzHM722z9/m7vz1Y75bjb+UJdxlKg78bfIe22bWhnitwmwXXNDlxwzUx6/zHRM3uFydwgsVNFCca3UYQ4rET3guOBEJ0r8Xh9tzJJHLDCpSpiThw30TBLqWEx8MXzwLoZf4/nNnTwcfi7OafxU5gVFUCuFvHlC+yV54gXK095Wss21kc4Mj47grwxheYqPV2uF7VebJRN5KDPHnkR+R+zQlwUKL+6uL3goHi+ghGmzU1os/GyCCcHP14pQzenpVgM82vSfatJ1zf8t2dwihTSyoVl7HGgqHxeBeonN084S3W6NLxb1uHfLi8Ejn4arYx36GLH6rYbZ4DQZ3zy2qqrMK3DcFTfSD2SqlygCGHOS2ZALC2/bFqBNsuMLF/rrAu71bJxYTTtCSpel1wSoTuWl/vKUr/nhkl1WcgJz+psNV1gEd5yKkS7aCR/Du6yhWnTXEZR6RxgpX7jzqHzPWFuy7aS/CxwXjiSit70=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(8936002)(478600001)(53546011)(8676002)(76116006)(38100700002)(7696005)(5660300002)(66476007)(66946007)(6636002)(6506007)(110136005)(54906003)(71200400001)(186003)(122000001)(316002)(26005)(2906002)(86362001)(55016002)(66446008)(83380400001)(66556008)(33656002)(64756008)(4326008)(9686003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N0hFeVMydDBmV0MwVTcwU0tvazQwT0FYcDVOOStxbnpNQ1ZIZWRqYjRNb1J1?=
 =?utf-8?B?bHp6dEJhbWlBREJjUW5tUnRJcEtReVlBNlVJcXhKb2Urd2x6LzhlMWI2K1Bk?=
 =?utf-8?B?ZS9KL2QyTWVYUG82aHlDUXZjSkdSSU1Rd1F0MWVVWlVLT2d0TWNBMHh0N1hB?=
 =?utf-8?B?Z21ZN2V3eDNSNkR5Q1d0M3kwL1RPaWJsVElEcmVlMFJ1RVhQWkh3MTF2WmZn?=
 =?utf-8?B?a09xT0M1ZERWeVoxbWw1b0NhSkR1MGV2ejhyOGczaktlcmtUUGRIYkpJMXZh?=
 =?utf-8?B?d2FQUExUSDROaGQ2WGxjSkl6TVJFUjhFSkpNNG5IdXZ5b1p6RjU1eGlUK0Y2?=
 =?utf-8?B?YkkwcG1qNUFiWDFZbDV2eHo4SGVRRENmd01ja29iTmtRdjlOeEZzSDA4ODE2?=
 =?utf-8?B?TFR4aE12dTNBeUxOSC96YlIvSnA3U3kxM29ySzhiS2hSMy9oZEwwcW14NGlV?=
 =?utf-8?B?NS9tdloxT29uQW1XajRxdVpHRmxNMUsvWGpNT2Y4TGFsdmozQXg1SW12Wndm?=
 =?utf-8?B?QnZlNDJTWXBEUXVSVXVrbElOWnZQTmRJOTU3dWVIb2Jldm8waGowbkcvSlNK?=
 =?utf-8?B?ZlQ1ckRDSUhnNFNSazh4UVQ2RktTanZCRmh0dHhhd2RVcHo1c3FReGkvM1d1?=
 =?utf-8?B?OUdpUlV3SHRvTnQ3dXRZZTRndnorMmp2U1RxMXA0dGhhQWR3cVZoZ1RBd2hY?=
 =?utf-8?B?UGp5YWt6dTA5R2w0Lzl4bXZ2UlhLem5uVGFCMHFsSTFCQ1dlSWo1K2dxR0pw?=
 =?utf-8?B?ZzNoOFRsYU5HMVFEeGZJRnN4N3UxbjdQUzArZncwNGxYa0p2MDhBRm55Uzlp?=
 =?utf-8?B?MTlMN1FBMWpISHhxclNyb2xrcUxPRzJyT2syVWlPSVRzdkpaVGEyM0JzcFdZ?=
 =?utf-8?B?Z25sSXlTNlIwNHhXU1U1NUpMYXRoenZnRXFPQStHcWQ3dDI4WmFQT2RsNGxU?=
 =?utf-8?B?ZXlERmZJaXFYUDZjSTFhTTdHeFlOWGdadnlCZUhDcG9zTXFRR2FLd1pPQjZx?=
 =?utf-8?B?NkpFQ29oS2wzL3FZREwrZWxrNTB0dm1tVHp1cWR3ZXN5bnc1QWdzM3F5ME4x?=
 =?utf-8?B?b1lFY2RWcHJOWUhLKzlQVzAxSmd3bk1BZWF2L2lWcEptcXVQQitiOWZ0Rk4w?=
 =?utf-8?B?Q1g2cDJtUmFmZngzd29wdWxESnYrRVdPeDlBbmFpTTRHbDB2aHdTRExrUzF1?=
 =?utf-8?B?RnhaUUxEcnQrYU5YakF4SUxqVDVXTUJKampXeUJBOWd6ZE90RVpFSytVT3Yr?=
 =?utf-8?B?b3FCRDl3TUIzVzBuWjVrRmx4RWlhaWh2dEpSU2k4VDZ5UHE2N0pKaHZJNXZW?=
 =?utf-8?B?UnNLUVJoQWxtUTZzcU01VGM3c09TMlVxVHdKSlY3MDM3WWMyUzRIZ3lISysw?=
 =?utf-8?B?VlgwVHFwYktZY3FOcWtvbEowMnlmVVEwRGM1NDV1YVJDQzlWODM3YXhoRjRh?=
 =?utf-8?B?cTc2a2pxem5SWFg4U0duV2lXdXlFaUJUSVlYU1FIUGluVVpkWENaZkxoSXVW?=
 =?utf-8?B?ZjhTU2hSOHQwSnhWWGpHcnA2U3hYcUN0MzNMU2dGeERUM0VmR3R0SVE2cDRi?=
 =?utf-8?B?dEZzRXdZQW1ZaVRHQVkrRFhIRUpZZVNma3Q3OHRGdGhuWFM4VENmTEkxQUwr?=
 =?utf-8?B?Z2hsSUl4cW5MdDEveUJoQ0I1RHZzdTVCN3VJVVJLaDFhVEFlMGp6Rm1UNHhE?=
 =?utf-8?B?WUpYd0xPdlZxUk05QitXbGJ2NXhVU2J1UjJ0aWdWWGlDSmtJcml2THZ4bzBt?=
 =?utf-8?Q?V79J0QWutBWhPqRqKOC+MnXyCtn2rZCmihpqORf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2d3087-b362-429c-6230-08d90414a0b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 15:54:48.9448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lk6pY+PhTfHAc1VcbtbA8yWNKH2od5Ec/LhLqHZB9XtEgO2WFYOXuI6GbeTlKlFG0vrD5SjxhmpJVo8fVGauBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5134
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLYW5lZGEsIEVyaWsgPGVyaWsu
a2FuZWRhQGludGVsLmNvbT4gDQpTZW50OiBNb25kYXksIEFwcmlsIDE5LCAyMDIxIDM6NTYgUE0N
ClRvOiBXaWxsaWFtcywgRGFuIEogPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT47IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPjsgTW9vcmUsIFJvYmVy
dCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IFd5c29ja2ksIFJhZmFlbCBKIDxyYWZhZWwuai53
eXNvY2tpQGludGVsLmNvbT4NCkNjOiBsaW51eC1udmRpbW0gPGxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnPjsgVmVybWEsIFZpc2hhbCBMIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+OyBKaWFu
ZywgRGF2ZSA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+OyBXZWlueSwgSXJhIDxpcmEud2VpbnlAaW50
ZWwuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSCB2MSAxLzFdIGxpYm52ZGltbTogRG9uJ3QgdXNl
IEdVSUQgQVBJcyBhZ2FpbnN0IHJhdyBidWZmZXINCg0KK0JvYiBhbmQgUmFmYWVsDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxs
aWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMTYsIDIwMjEgMzowOSBQTQ0K
PiBUbzogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+
DQo+IENjOiBsaW51eC1udmRpbW0gPGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmc+OyBMaW51eCBL
ZXJuZWwgTWFpbGluZyANCj4gTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFZl
cm1hLCBWaXNoYWwgTCANCj4gPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT47IEppYW5nLCBEYXZl
IDxkYXZlLmppYW5nQGludGVsLmNvbT47IFdlaW55LCANCj4gSXJhIDxpcmEud2VpbnlAaW50ZWwu
Y29tPjsgS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjEgMS8xXSBsaWJudmRpbW06IERvbid0IHVzZSBHVUlEIEFQSXMgYWdhaW5zdCBy
YXcgDQo+IGJ1ZmZlcg0KPiANCj4gT24gRnJpLCBBcHIgMTYsIDIwMjEgYXQgMTo0MiBQTSBBbmR5
IFNoZXZjaGVua28gDQo+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gT24gRnJpLCBBcHIgMTYsIDIwMjEgYXQgMDE6MDg6MDZQTSAtMDcwMCwgRGFu
IFdpbGxpYW1zIHdyb3RlOg0KPiA+ID4gWyBhZGQgRXJpayBdDQo+ID4gPg0KPiA+ID4gT24gRnJp
LCBBcHIgMTYsIDIwMjEgYXQgMTA6MzYgQU0gQW5keSBTaGV2Y2hlbmtvIA0KPiA+ID4gPGFuZHJp
eS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IE9u
IFRodSwgQXByIDE1LCAyMDIxIGF0IDA1OjM3OjU0UE0gKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3
cm90ZToNCj4gPiA+ID4gPiBTdHJpY3RseSBzcGVha2luZyB0aGUgY29tcGFyaXNvbiBiZXR3ZWVu
IGd1aWRfdCBhbmQgcmF3IGJ1ZmZlciANCj4gPiA+ID4gPiBpcyBub3QgY29ycmVjdC4gUmV0dXJu
IHRvIHBsYWluIG1lbWNtcCgpIHNpbmNlIHRoZSBkYXRhIA0KPiA+ID4gPiA+IHN0cnVjdHVyZXMg
aGF2ZW4ndCBjaGFuZ2VkIHRvIHVzZSB1dWlkX3QgLyBndWlkX3QgdGhlIGN1cnJlbnQgDQo+ID4g
PiA+ID4gc3RhdGUgb2YgYWZmYWlycyBpcyBpbmNvbnNpc3RlbnQuIEVpdGhlciBpdCBzaG91bGQg
YmUgY2hhbmdlZCANCj4gPiA+ID4gPiBhbHRvZ2V0aGVyIG9yIGxlZnQgYXMgaXMuDQo+ID4gPiA+
DQo+ID4gPiA+IERhbiwgcGxlYXNlIHJldmlldyB0aGlzIG9uZSBhcyB3ZWxsLiBJIHRoaW5rIGhl
cmUgeW91IG1heSBhZ3JlZSB3aXRoIG1lLg0KPiA+ID4NCj4gPiA+IFlvdSBrbm93LCB0aGlzIGlz
IGFsbCBhIHByb2JsZW0gYmVjYXVzZSBBQ1BJQ0EgaXMgdXNpbmcgYSByYXcgYnVmZmVyLg0KPiA+
DQo+ID4gQW5kIHRoaXMgaXMgZmluZS4gSXQgbWlnaHQgYmUgYW55IG90aGVyIHJlcHJlc2VudGF0
aW9uIGFzIHdlbGwuDQo+ID4NCj4gPiA+IEVyaWssIHdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIHVz
ZSB0aGUgZ3VpZF90IHR5cGUgaW4gQUNQSUNBPyBUaGF0IA0KPiA+ID4gd291bGQgYWxsb3cgTkZJ
VCB0byBkcm9wIHNvbWUgdWdseSBjYXN0cy4NCj4gPg0KPiA+IGd1aWRfdCBpcyBpbnRlcm5hbCBr
ZXJuZWwgdHlwZS4gSWYgd2UgZXZlciBkZWNpZGUgdG8gZGV2aWF0ZSBmcm9tIA0KPiA+IHRoZSBj
dXJyZW50IHJlcHJlc2VudGF0aW9uIGl0IHdvdWxkbid0IGJlIHBvc3NpYmxlIGluIGNhc2UgYSAz
cmQgDQo+ID4gcGFydHkgaXMgdXNpbmcgaXQgMToxICh2aWEgdHlwZWRlZiBvciBzbykuDQo+IA0K
SGkgRGFuLA0KDQo+IEknbSB0aGlua2luZyBzb21ldGhpbmcgbGlrZSBBQ1BJQ0EgZGVmaW5pbmcg
dGhhdCBzcGFjZSBhcyBhIHVuaW9uIHdpdGggDQo+IHRoZSBjb3JyZWN0IHR5cGluZyBqdXN0IGZv
ciBMaW51eC4NCg0KSSdtIGFzc3VtaW5nIHRoYXQgeW91IG1lYW4gdXNpbmcgc29tZXRoaW5nIGxp
a2UgZ3VpZF90IHR5cGUgZm9yIEFDUEkgZGF0YSB0YWJsZSBmaWVsZHMgbGlrZSBORklUIHJhdGhl
ciB0aGFuIG9iamVjdHMgcmV0dXJuZWQgYnkgQUNQSSBuYW1lc3BhY2Ugb2JqZWN0IHN1Y2ggYXMg
X0RTRC4NCg0KRm9yIEFDUEkgZGF0YSB0YWJsZXMsIHdlIGNvdWxkIHRvIHVzZSBtYWNyb3Mgc28g
dGhhdCBkaWZmZXJlbnQgb3BlcmF0aW5nIHN5c3RlbXMgY2FuIHByb3ZpZGUgdGhlaXIgb3duIGRl
ZmluaXRpb25zIGZvciBhIGd1aWQuIEZvciBBQ1BJQ0EsIGl0IHdpbGwgZXhwYW5kcyB0byBhIDE2
LWJ5dGUgYXJyYXkuIExpbnV4IGNhbiBoYXZlIGl0J3Mgb3duIGRlZmluaXRpb24gdGhhdCBjb250
YWlucyBhIHVuaW9uIG9yIHRoZWlyIG93biBndWlkIHR5cGUgKGd1aWRfdCkuIEFzIGxvbmcgYXMg
dGhlIE9TLXN1cHBsaWVkIGRlZmluaXRpb24gaXMgMTZieXRlcywgSSBkb24ndCB0aGluayB0aGVy
ZSB3b3VsZCBiZSBhbiBpc3N1ZS4NCg0KRXJpaywNCkkgZG9uJ3QgbGlrZSB0byBhZGQgdGhlc2Ug
a2luZHMgb2YgbWFjcm9zLCBzaW5jZSBpdCBpcyBzaW1wbHkgYW5vdGhlciBpdGVtIHRoYXQgbmVl
ZHMgdG8gYmUgYWRkZWQgdG8gcG9ydCBBQ1BJQ0EgdG8gZGlmZmVyZW50IGhvc3RzLiAoQW5kIG11
c3QgYmUga25vd24gYnkgdGhlIHBvcnRlci4pDQoNCk90aGVyIHRoYW4gdGhhdCwgSSBzdXBwb3Nl
IHdlIGNhbiBhZGQgc3VjaCBhIG1hY3JvLg0KDQpCb2IsIGRvIHlvdSBoYXZlIGFueSB0aG91Z2h0
cyBvbiB0aGlzPw0KRXJpaw0K
