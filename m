Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DCD3ECD00
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 05:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhHPDMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:12:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:55441 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhHPDMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:12:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="202986544"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="202986544"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 20:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="640372865"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2021 20:11:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 15 Aug 2021 20:11:59 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 15 Aug 2021 20:11:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 15 Aug 2021 20:11:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 15 Aug 2021 20:11:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbtghAkaEVtxRGVgz8qfnd3RsWwTn9pNRixUyuhGRJzqHMAXkhl8iGesuMu43xq22P4VX7sB0autlE0NtgFwF5TeHbxKPqPhwiUTG3/wRtP9EqEs1/8PgyE90UeiYJ6gatK5IYSJch3aSJgezrpr6HQ9sw2d5I1ru3AEHvfPxCcmHyY+Pa+Al3UdY06KWfcZxupWgxdyRp5RU2uRJ2AKTj29vdG+v2tmGQL069ygfBYn3Gie67L/1cGHYTQAdxd+vd9nPifhies35TMFz5/SXNb/zgRYhZeep4DCcUwwzT3n+mM8PMZr351qqKVS7HFF80Bjz8+W+2BZ1YIRxeP1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjcBUfRsn7tuz76eLoExnkWrlRo8z7vxExmCUDN8sbQ=;
 b=XYwYWkUA5wJG0pck0aCqMKkj9pyIL/GKj+pKhiwBEhJLZN1RvZ7ffqhzKcMUocy1ugPCkRwv/yO8ASnKfMv5lf6U+uPcXObR4u/QvBPTAU6Qy4/Zq0OSfP22iWZ4bPpAYT4Hev96qAgiwc/kl8KZtodZD436zBjysRZEtO7BJ/8+PVOKlHindFPQLJyiVGBIGXvfnaXT/9WuK6tOfzlTXgEIlkHOv2irkHDs4wMvtUU9d8lhrHci5WJ/58RL1Q/chpnQ3h1yO3DlPjBNFsRGKJ+6JuDbCSSNoeZGXZ/+b9TorncDgeHjH8RRUhe3ykvCk++JRFrC/VnTyIlPCZn9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjcBUfRsn7tuz76eLoExnkWrlRo8z7vxExmCUDN8sbQ=;
 b=hpU5wkshubkxy9gibetYmJTmVu2852WWaRHUn+MON1M6v9fAQ3CqKjHzdGIP4ADviq+zqNaoP4okAvQOIdWL1bIIJnR8LEKUeyCYpPZwbmxQb8QUjaWjN+0MIlXj6z3hvqeKnud8ak0mxqzLwMp4RxoxcQeDW0NyaBMxnYOclzY=
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Mon, 16 Aug 2021 03:11:56 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::b902:81e5:826d:f731]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::b902:81e5:826d:f731%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 03:11:56 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "djrscally@gmail.com" <djrscally@gmail.com>,
        "Thomas, Sujith" <sujith.thomas@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zha, Qipeng" <qipeng.zha@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "acelan.kao@canonical.com" <acelan.kao@canonical.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>,
        "alex.hung@canonical.com" <alex.hung@canonical.com>,
        "hpa@redhat.com" <hpa@redhat.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Ma, Maurice" <maurice.ma@intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 18/20] Move Intel thermal driver for menlow platform
 driver to intel/ directory to improve readability.
Thread-Topic: [PATCH 18/20] Move Intel thermal driver for menlow platform
 driver to intel/ directory to improve readability.
Thread-Index: AQHXkkx4XSraawBPFk661/fjOY938g==
Date:   Mon, 16 Aug 2021 03:11:56 +0000
Message-ID: <5a80a56e41369204b7729d25f72dfcdd09919033.camel@intel.com>
References: <20210810095832.4234-1-hpa@redhat.com>
         <20210810095832.4234-19-hpa@redhat.com>
         <95801e67-f09e-64f3-abd6-f38a8f1f1d51@linaro.org>
         <2cc45082-692d-1a0e-cb44-7e2393c95152@redhat.com>
In-Reply-To: <2cc45082-692d-1a0e-cb44-7e2393c95152@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.0-1 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e080f2ca-8ffe-4e5e-cbb0-08d960639ae4
x-ms-traffictypediagnostic: DM4PR11MB5567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB5567114A430C6DD869F9D7EEE4FD9@DM4PR11MB5567.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IuWukRdbobhqJ5vTfnRQipaCEkT8tHyC4GdifLOXmLJ4bVFAwy4Khml/mp41sF2B9YIjHfMG3FeW95w8CpfXiVoa1ipJslW/9r2KfudA/rZLCM0dn0eaOafCOZS9nMjDAluKdweD65lEBI7OTvCeqciLfXEiASHzykhIVRek24jdJI2Hhrx1e8oGvchLK+e92Y0W75s613xps+0PNxlFpe/s/dgjLMwwmyvP4JcSmciFOkZ7inszIOycuW6KjLBpa3Nt9C7G71Ag3vRq5Uw4ktWuJdQANme25URh3/dfnje2m5l6cHygbi30Qd1SaE8i9pOb9r7XPDJp3cNw0NdGbqVqful7JyAPIPbTT5J6yUFMO9YjRjVPRfNT5VQ/n+V8WDd3cVy66VopkqYJ83ebv8Ejzfwj76WQFBuvI7Ghs2SpCjgyx+K7bsir8ej5ASiByttn0uHaE39eeWmnUBYOuLE9VWQ3Mwd7FIShx1zTSp3r4eIxrO+DEl5oXoErvpgIkz9RhhoJXRUp2twwlpfwb9zsMxChe/1MlHXk9CujwwKIcqzDb5MI8uR6gidpkeb3DOu7ChObYOQNtXeg3h29d3E+YzAzjQ5Pf/8eFFkPmR/Blg/XaqZOGJH4KchPfrVSttAp4prL2XE3qNhmisIveTQbORghhLPEtRPPRVjC54Nw95h+n8i/BEBjaAYISSb4WGaGcdUIEDYeSW2snoaSzgzwkiQW0R4KNa0yanqs0uc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(186003)(86362001)(6512007)(2906002)(2616005)(921005)(66446008)(66946007)(66476007)(6486002)(8936002)(83380400001)(91956017)(8676002)(66556008)(64756008)(76116006)(26005)(38100700002)(36756003)(316002)(122000001)(110136005)(4326008)(5660300002)(6506007)(478600001)(6636002)(71200400001)(53546011)(38070700005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTJHalFYRTNDV0FDcTVaK1F2RUJ1RUVlbGhzR0JjUGpJQmFoWThnV1RSbjl2?=
 =?utf-8?B?Tmw4UUxPTU5mNzlxcG9HZDgvMWc4dVRncTd4KzN6ZkxDOHAwWE04bG81VmxF?=
 =?utf-8?B?VFZocVhLWVduWDExemkzYVBrQ2FpTmFtdHVqVEZ5eXBFZ3ZzWmUrNFRVSEtY?=
 =?utf-8?B?QVJ2bDNPcWRPYWF1ZjIvSmRiaWF1TUsxNjJuRytJNk9ta3JIcGwzdkpvSDcw?=
 =?utf-8?B?c3FmcG5WaTcxRGZQbWduU1Rwd2lXUHZOcTAvWCtGZ2VSZ05KbGVBL3lCeHhE?=
 =?utf-8?B?d01zM2lZdnBQQW43Q3p2M3llOEFnWnh0MEpOcmpKbUFseEcwVzNKdGxaVnJi?=
 =?utf-8?B?bzZkdHZCV1F2Q1RSTXVzZjA3dzZEMUVvNTdoZ3NGMkIrTTFPVk9GWnhJYnR3?=
 =?utf-8?B?UStMUlZodkVoS3BOSFF3QWJBZ3JpTE95eWJHNEt0S3hNbVh5bU96Kzk5WnEy?=
 =?utf-8?B?K1BDWS92d3p1L1J0eE1lM21TMXlHQUJjVjFYa294SEhWakc3VlRCYnNTZmlR?=
 =?utf-8?B?N0hqSk44cUgrdkQxbW0xRytNNDFlNjduOVROS1JyeGxNZVNBendXVE9JYitI?=
 =?utf-8?B?VlNZdkQzRk5MbE4zVStXeDJTYUh6d3NCNkJzNnBZeHM4RXg0QXgvOTBvckZa?=
 =?utf-8?B?RHNCWmpYVGJ1eVFwQllIRWgzTUxGN2hIbldFWnh4Y0hiWlVLdlV0dVhIUndq?=
 =?utf-8?B?aUdLVWRHY0RkYzg1RWdZUjVtMlRQSWlnbldlMVMyL1RpaFB0ME9SY2hDTVla?=
 =?utf-8?B?Z2tzRmlaUjducTNPZDVWQ29XVVE4MC9KWE1XQVAyTFJRQll0NFpiV0M3cW5U?=
 =?utf-8?B?bEh2dG11OVJQbFpOT3YwdUJJZVdZQ0VVYVhkZHZQMEY4UGVyS1h1VjdLcFRJ?=
 =?utf-8?B?alVGbGF5UkdMeDI1SFVxWkl4SXNoMzJaeUdBR25ocVB3OG5kVXFTeGVMMjVK?=
 =?utf-8?B?NFB2SVNFL1FDcGFCRXA3SmQ0cmdiL09QWHRoeWlOSUJxSm5GbVZnTkNrWkhx?=
 =?utf-8?B?Znl6TjZUb2wvMS8zQ3E3cHdNVkNMU3paeUJJU0dVSlJSYkZRbDVTK3JUSkZV?=
 =?utf-8?B?SHVWTDU0dDZ5M1hieEx3VW9USDR5bmJWREd3bjh6OUQzdWx1VUlIbTdRQURQ?=
 =?utf-8?B?UW5UZFpYNVVVeGZUUWExLzgybkh6LzZwTEZsMVV2VWFxYXc3MVR4UVlaSlIv?=
 =?utf-8?B?U1g4a1d1cXV2ckJhTk0xOGNKZXRXQjN1ZExoaExqNG1nRlJyUi9PM2FZWTJ0?=
 =?utf-8?B?cFp0Ni9rb092VVd3N3JnTDVVaG44Ujc4K04xOGw5bVg3em5Qa0VYdVorYlVC?=
 =?utf-8?B?MjM1ZTgyVzRBMkg1dUVhNUt6Y25yWDcrWTZTaE0rRFdrWE9zMkxNZ1JISThX?=
 =?utf-8?B?NEVWSHpHcHA4Zmh3bC91ZUM0d1BoUGYrQ01kMUE2WTVKZ1hPcldEblhIMGF2?=
 =?utf-8?B?cGRaeVl2QSt6QkxVNEFJUmxtdnRJaWMyRzAyMWFFNjFHSitsQmdmM2pUdHRa?=
 =?utf-8?B?RUdGY0cwZTM4b2hPc2VJY2RwbTFoNHlJamljbC9DVFNnZjA3NjJrTThUZ1Nl?=
 =?utf-8?B?U0ZmY1Q2dlZTMzhLNzJzL29GUU5KYzl6UDBCNjNlc1d3WlVzbDhSY0NSeDZP?=
 =?utf-8?B?ODZrWnRNRlgwUkY2cU1Fd0NQSnBRZS84SXgvbXZlNjJOSWJBMmdjL1RmSlRS?=
 =?utf-8?B?OVRKMUJQb2V2OXRxczJRaHdyc3RjU2V4dVpDSWgvSXlZV1RWNGpja05PZXhL?=
 =?utf-8?Q?4vSLXRLnK+7IDIiAuAqqTpfoyNmRd6Ke2EdUXjV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B57B1F9B95164D4C90D042E4BFA97943@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e080f2ca-8ffe-4e5e-cbb0-08d960639ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 03:11:56.5026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a10AB22dT3o9+xw8dozRUjUITvRs48xtD8eQR5O/+Kywael3ZgGAwHw9ajlXoefGiCZ6olwReuUJEBtMB8Fc3PKtGxTYEzWB6APR5xiki0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIxLTA4LTE1IGF0IDE2OjA4ICswMjAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIDgvMTQvMjEgMTI6MzkgUE0sIERhbmllbCBMZXpjYW5vIHdyb3RlOg0K
PiA+IE9uIDEwLzA4LzIwMjEgMTE6NTgsIEthdGUgSHN1YW4gd3JvdGU6DQo+ID4gDQo+ID4gDQo+
ID4gV2h5IG5vdCBtb3ZlIGl0IGludG8gZHJpdmVycy90aGVybWFsL2ludGVsID8NCj4gDQo+IFRo
aXMgY2xlYW51cCBpcyByZWFsbHkgc29tZXRoaW5nIHdoaWNoIEludGVsIHNob3VsZCBoYXZlIGJl
ZW4gZG9pbmcNCj4gaXRzZWxmLCBidXQgdGhleSBoYXZlIG5vdCBkb25lIHRoYXQsIHNvIG5vdyBL
YXRlIGhhcyBzdGVwcGVkIHVwIHRvDQo+IGRvIHRoaXMuDQo+IA0KPiBGaWd1cmluZyBvdXQgaWYg
dGhlcmUgaXMgYSBiZXR0ZXIgaG9tZSBmb3IgZWFjaCBvZiB0aGVzZSBkcml2ZXJzDQo+IHJlYWxs
eSBmYWxscyBvdXRzaWRlIG9mIHRoZSBzY29wZSBvZiB0aGlzLiBJZiBJbnRlbCBhbmQgc3BlY2lm
aWNhbGx5DQo+IFN1aml0aCBUaG9tYXMsIHRoZSBtYWludGFpbmVyIGZvciB0aGF0IGRyaXZlciB3
aG8gaXMgaW4gdGhlIENjLA0KPiBiZWxpZXZlIHRoYXQgZHJpdmVycy90aGVybWFsL2ludGVsIGlz
IGEgYmV0dGVyIHBsYWNlIHRoZW4gdGhleQ0KPiBjYW4gc3VibWl0IGEgcGF0Y2ggZm9yIHRoaXMg
dGhlbXNlbHZlcy4NCj4gDQo+IElmIEludGVsIGRvZXMgdGhhdCByaWdodCBhd2F5LCB0aGVuIHRo
aXMgcGF0Y2ggY2FuIGJlIGRyb3BwZWQgZnJvbQ0KPiBLYXRlJ3MgcGF0Y2gtc2V0LiBPdGhlcndp
c2UgdGhpcyBjYW4gYmUgbW92ZWQgYSBzZWNvbmQgdGltZSBvbmNlDQo+IHNvbWVvbmUgZnJvbSBJ
bnRlbCBnZXRzIGFyb3VuZCB0byBpdC4NCldlIGNhbiBtb3ZlIHRvIHRoZXJtYWwvaW50ZWwuIEkg
d2lsbCBzdWJtaXQgYSBjaGFuZ2UgdG8gZG8gdGhhdC4NCg0KVGhhbmtzLA0KU3Jpbml2YXMNCg0K
PiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCj4gDQo+IA0KPiANCj4gDQo+ID4gDQo+ID4gDQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBLYXRlIEhzdWFuIDxocGFAcmVkaGF0LmNvbT4NCj4gPiA+IC0t
LQ0KPiA+ID4gwqBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggLS0tLS0tLS0NCj4gPiA+IMKgZHJpdmVy
cy9wbGF0Zm9ybS94ODYvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDIgKy0NCj4gPiA+IMKgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvS2Nv
bmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiA+IMKgZHJp
dmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDIgKysNCj4gPiA+IMKgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvbWVubG93
L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNA0KPiA+ID4gKysrKysrKysrKysrKysNCj4g
PiA+IMKgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvbWVubG93L01ha2VmaWxlwqDCoMKgwqDC
oMKgwqDCoCB8wqAgNiArKysrKysNCj4gPiA+IMKgLi4uL3BsYXRmb3JtL3g4Ni97ID0+IGludGVs
L21lbmxvd30vaW50ZWxfbWVubG93LmMgfMKgIDANCj4gPiA+IMKgNyBmaWxlcyBjaGFuZ2VkLCAy
NCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+ID4gwqBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvbWVubG93L0tjb25maWcNCj4gPiA+IMKgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL21lbmxvdy9NYWtlZmls
ZQ0KPiA+ID4gwqByZW5hbWUgZHJpdmVycy9wbGF0Zm9ybS94ODYveyA9PiBpbnRlbC9tZW5sb3d9
L2ludGVsX21lbmxvdy5jDQo+ID4gPiAoMTAwJSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGxhdGZvcm0veDg2L0tjb25maWcNCj4gPiA+IGIvZHJpdmVycy9wbGF0Zm9ybS94
ODYvS2NvbmZpZw0KPiA+ID4gaW5kZXggYjljMGQyZDk3NzkzLi41MGRlZDIzNmE4NDEgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnDQo+ID4gPiArKysgYi9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnDQo+ID4gPiBAQCAtNjMyLDE1ICs2MzIsNyBAQCBj
b25maWcgVEhJTktQQURfTE1JDQo+ID4gPiDCoA0KPiA+ID4gwqBzb3VyY2UgImRyaXZlcnMvcGxh
dGZvcm0veDg2L2ludGVsL0tjb25maWciDQo+ID4gPiDCoA0KPiA+ID4gLWNvbmZpZyBJTlRFTF9N
RU5MT1cNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoHRyaXN0YXRlICJUaGVybWFsIE1hbmFnZW1lbnQg
ZHJpdmVyIGZvciBJbnRlbCBtZW5sb3cNCj4gPiA+IHBsYXRmb3JtIg0KPiA+ID4gLcKgwqDCoMKg
wqDCoMKgZGVwZW5kcyBvbiBBQ1BJX1RIRVJNQUwNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoHNlbGVj
dCBUSEVSTUFMDQo+ID4gPiAtwqDCoMKgwqDCoMKgwqBoZWxwDQo+ID4gPiAtwqDCoMKgwqDCoMKg
wqDCoCBBQ1BJIHRoZXJtYWwgbWFuYWdlbWVudCBlbmhhbmNlbWVudCBkcml2ZXIgb24NCj4gPiA+
IC3CoMKgwqDCoMKgwqDCoMKgIEludGVsIE1lbmxvdyBwbGF0Zm9ybS4NCj4gPiA+IMKgDQo+ID4g
PiAtwqDCoMKgwqDCoMKgwqDCoCBJZiB1bnN1cmUsIHNheSBOLg0KPiA+ID4gwqANCj4gPiA+IMKg
Y29uZmlnIElOVEVMX09BS1RSQUlMDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgdHJpc3RhdGUgIklu
dGVsIE9ha3RyYWlsIFBsYXRmb3JtIEV4dHJhcyINCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BsYXRmb3JtL3g4Ni9NYWtlZmlsZQ0KPiA+ID4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtl
ZmlsZQ0KPiA+ID4gaW5kZXggZjRjNmNlZDU5ZGExLi5lYTVmNWRkM2Y3OGEgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmlsZQ0KPiA+ID4gKysrIGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvTWFrZWZpbGUNCj4gPiA+IEBAIC02Nyw3ICs2Nyw3IEBAIG9iai0kKENP
TkZJR19USElOS1BBRF9MTUkpwqDCoMKgwqArPSB0aGluay1sbWkubw0KPiA+ID4gwqBvYmotJChD
T05GSUdfWDg2X1BMQVRGT1JNX0RSSVZFUlNfSU5URUwpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgKz0gaW50ZWwvDQo+ID4gPiDCoA0KPiA+ID4gwqANCj4gPiA+IC1vYmotJChDT05GSUdf
SU5URUxfTUVOTE9XKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKz0gaW50ZWxfbWVubG93Lm8N
Cj4gPiA+ICsNCj4gPiA+IMKgb2JqLSQoQ09ORklHX0lOVEVMX09BS1RSQUlMKcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqArPSBpbnRlbF9vYWt0cmFpbC5vDQo+ID4gPiDCoG9iai0kKENPTkZJR19JTlRF
TF9WQlROKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9IGludGVsLXZidG4ubw0KPiA+
ID4gwqANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9LY29u
ZmlnDQo+ID4gPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL0tjb25maWcNCj4gPiA+IGlu
ZGV4IDRlZmI1YWQzZTNlMS4uNTljOWI2MDJjNzg0IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvaW50ZWwvS2NvbmZpZw0KPiA+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9y
bS94ODYvaW50ZWwvS2NvbmZpZw0KPiA+ID4gQEAgLTM2LDYgKzM2LDcgQEAgc291cmNlDQo+ID4g
PiAiZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvaW50ZWxfc3BlZWRfc2VsZWN0X2lmL0tjb25m
aWciDQo+ID4gPiDCoHNvdXJjZSAiZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvdHVyYm9fbWF4
XzMvS2NvbmZpZyINCj4gPiA+IMKgc291cmNlICJkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC91
bmNvcmVfZnJlcS9LY29uZmlnIg0KPiA+ID4gwqBzb3VyY2UgImRyaXZlcnMvcGxhdGZvcm0veDg2
L2ludGVsL2ludDAwMDIvS2NvbmZpZyINCj4gPiA+ICtzb3VyY2UgImRyaXZlcnMvcGxhdGZvcm0v
eDg2L2ludGVsL21lbmxvdy9LY29uZmlnIg0KPiA+ID4gwqANCj4gPiA+IMKgDQo+ID4gPiDCoGVu
ZGlmICMgWDg2X1BMQVRGT1JNX0RSSVZFUlNfSU5URUwNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9NYWtlZmlsZQ0KPiA+ID4gYi9kcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9pbnRlbC9NYWtlZmlsZQ0KPiA+ID4gaW5kZXggZmU1MDU4YzNhZjE4Li5iMjMyNjU1NGJk
ODQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9NYWtlZmls
ZQ0KPiA+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvTWFrZWZpbGUNCj4gPiA+
IEBAIC0xMiw2ICsxMiw3IEBAIG9iai0kKENPTkZJR19JTlRFTF9ISURfRVZFTlQpwqDCoMKgwqDC
oMKgwqDCoMKgKz0gaGlkLw0KPiA+ID4gwqBvYmotJChDT05GSUdfSU5URUxfV01JX1NCTF9GV19V
UERBVEUpwqDCoCs9IHdtaS8NCj4gPiA+IMKgb2JqLSQoQ09ORklHX0lOVEVMX1dNSV9USFVOREVS
Qk9MVCnCoMKgwqDCoCs9IHdtaS8NCj4gPiA+IMKgb2JqLSQoQ09ORklHX0lOVEVMX0lOVDAwMDJf
VkdQSU8pwqDCoMKgwqDCoMKgKz0gaW50MDAwMi8NCj4gPiA+ICtvYmotJChDT05GSUdfSU5URUxf
TUVOTE9XKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKz0gbWVubG93Lw0KPiA+ID4gwqANCj4g
PiA+IMKgDQo+ID4gPiDCoCMgSW50ZWwgUE1JQyAvIFBNQyAvIFAtVW5pdCBkZXZpY2VzDQo+ID4g
PiBAQCAtMzgsMyArMzksNCBAQCBvYmotDQo+ID4gPiAkKENPTkZJR19JTlRFTF9TUEVFRF9TRUxF
Q1RfSU5URVJGQUNFKcKgwqDCoMKgKz0NCj4gPiA+IGludGVsX3NwZWVkX3NlbGVjdF9pZi8NCj4g
PiA+IMKgb2JqLSQoQ09ORklHX0lOVEVMX1RVUkJPX01BWF8zKcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9DQo+ID4gPiB0dXJib19tYXhfMy8NCj4gPiA+
IMKgb2JqLSQoQ09ORklHX0lOVEVMX1VOQ09SRV9GUkVRX0NPTlRST0wpwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqArPQ0KPiA+ID4gdW5jb3JlX2ZyZXEvDQo+ID4gPiDCoA0KPiA+ID4g
Kw0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL21lbmxvdy9L
Y29uZmlnDQo+ID4gPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL21lbmxvdy9LY29uZmln
DQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5i
MjkyMGQyNTlmZjcNCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGxh
dGZvcm0veDg2L2ludGVsL21lbmxvdy9LY29uZmlnDQo+ID4gPiBAQCAtMCwwICsxLDE0IEBADQo+
ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ID4gPiArIw0K
PiA+ID4gKyMgSW50ZWwgeDg2IFBsYXRmb3JtIFNwZWNpZmljIERyaXZlcnMNCj4gPiA+ICsjDQo+
ID4gPiArDQo+ID4gPiArY29uZmlnIElOVEVMX01FTkxPVw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
dHJpc3RhdGUgIlRoZXJtYWwgTWFuYWdlbWVudCBkcml2ZXIgZm9yIEludGVsIG1lbmxvdw0KPiA+
ID4gcGxhdGZvcm0iDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBkZXBlbmRzIG9uIEFDUElfVEhFUk1B
TA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgc2VsZWN0IFRIRVJNQUwNCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoGhlbHANCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgIEFDUEkgdGhlcm1hbCBtYW5hZ2VtZW50
IGVuaGFuY2VtZW50IGRyaXZlciBvbg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqAgSW50ZWwgTWVu
bG93IHBsYXRmb3JtLg0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqAgSWYgdW5zdXJl
LCBzYXkgTi4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9t
ZW5sb3cvTWFrZWZpbGUNCj4gPiA+IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvbWVubG93
L01ha2VmaWxlDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAw
MDAwMDAwLi4wZTlmZGE5YmZmOTgNCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL21lbmxvdy9NYWtlZmlsZQ0KPiA+ID4gQEAgLTAsMCAr
MSw2IEBADQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+
ID4gPiArIw0KPiA+ID4gKyMgSW50ZWwgeDg2IFBsYXRmb3JtIFNwZWNpZmljIERyaXZlcnMNCj4g
PiA+ICsjDQo+ID4gPiArDQo+ID4gPiArb2JqLSQoQ09ORklHX0lOVEVMX01FTkxPVynCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCs9IGludGVsX21lbmxvdy5vDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfbWVubG93LmMNCj4gPiA+IGIvZHJpdmVycy9wbGF0
Zm9ybS94ODYvaW50ZWwvbWVubG93L2ludGVsX21lbmxvdy5jDQo+ID4gPiBzaW1pbGFyaXR5IGlu
ZGV4IDEwMCUNCj4gPiA+IHJlbmFtZSBmcm9tIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX21l
bmxvdy5jDQo+ID4gPiByZW5hbWUgdG8gZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvbWVubG93
L2ludGVsX21lbmxvdy5jDQo+ID4gPiANCj4gPiANCj4gPiANCj4gDQoNCg==
