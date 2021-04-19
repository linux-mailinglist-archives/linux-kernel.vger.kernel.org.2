Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2F2364DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhDSW4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:56:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:28837 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhDSW4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:56:44 -0400
IronPort-SDR: lEvNaKghUsMrBW4ujeoup/98n7aFYLzWYbof2TxkTrQmrCzrMLGvInlDxNzom84uqCO8qDL6Tg
 FwRHbfxKK0NA==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182542359"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="182542359"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 15:56:14 -0700
IronPort-SDR: SxW7g63o4zlHSbrzZSFK+aqLdvuRHF5nhJVDa57qJro5ZGQTKTYqB/jD5i7sEXEgKmHfqeK9Fv
 uwCHu/GVAhwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="602281616"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2021 15:56:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 15:56:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 19 Apr 2021 15:56:13 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.56) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 19 Apr 2021 15:56:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8P2Jq00/wmKTzepkOelQPNzPruOyw72T/sFcqwU+YPth6CPwrgdwWLwv3RtuCv/cZ/B2R1AVvBjY1m78EsHhICJrla2QkpE1lLkfmaimAezMzY8dFNByRRgCWadGAfNQSCQQ/eo5OtJKvlidQwYgQntKg879QtRd5FO6+ppx4/+tzL2+vAFmKIpcGWPaQ+6gYWZdrc85YHtcvwH9W+hmAO+I2CXuTgY0hN8zu2NmNEIFTczqnsA7/uVet0XaCWQyEie2O3s7eJdFmW7pvMUECkNrcYs6Red1OhM64jSUMpXmrZYg+fYg30H5BlOO1/Rc1iL44UN0gVvVCwvmIsseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcx35zd892OQpBKS8iZcLcyNSm1OCERoxSNEq9mDBEU=;
 b=OaHaYHUtHp35DTNxsZbYwgZ2Po+0ilDf53cFv5iSSWnHB+fIK198+fDpm0RDKCrZ42DLNbGhm1tG2GtCDip9N9Rn9lmoLCLs4DNXZgEiilPpSUirk+24mmUi62dm+uKE22Xh7hv2MPQrczlHqLewPi4taJcFFmn8QZAYu6aALkIZJKEgWELfN11KWuuLh7nOdUnb9nl7UuNNhmQVPqSEFMry53rcyFv2wWNronik6JTFDLNTm2ZbhfFH9MBGA+Ze6/ULyhUa8KEH9xrsEfFUA/snxuaKGv5i09dFa9Axyp3ayUajdJCRSnSvFGD/ILOUzva7SvtFhZcHQnXR+X9KAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcx35zd892OQpBKS8iZcLcyNSm1OCERoxSNEq9mDBEU=;
 b=ymRzLuX48yoVkVbunwkeDG3dI0fx0N1hHcp277p1qX/odsE26IQDmDy/o/diL29pfh93eCfl74xFtDUtYDUxFx7sCWMzQVo8qV07cbVUl9GWrF6ZK/PLFGkq+6e8wWcT+rlcsD8xH9nXl9/SaWZ3CWGXyDkXBuu+MMxLsB052Ak=
Received: from CY4PR11MB1590.namprd11.prod.outlook.com (2603:10b6:910:6::15)
 by CY4PR11MB1925.namprd11.prod.outlook.com (2603:10b6:903:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Mon, 19 Apr
 2021 22:56:11 +0000
Received: from CY4PR11MB1590.namprd11.prod.outlook.com
 ([fe80::899:e23a:1c:94c6]) by CY4PR11MB1590.namprd11.prod.outlook.com
 ([fe80::899:e23a:1c:94c6%8]) with mapi id 15.20.4042.023; Mon, 19 Apr 2021
 22:56:11 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: RE: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Thread-Topic: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Thread-Index: AQHXMvxos6/G1E0Lb0im/q88amHNoKq3m/kAgAAYKgCABMAQMA==
Date:   Mon, 19 Apr 2021 22:56:10 +0000
Message-ID: <CY4PR11MB1590FE3E5B4AC80972BD253AF0499@CY4PR11MB1590.namprd11.prod.outlook.com>
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
 <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
 <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
 <YHn2oiP+2YpkFGXQ@smile.fi.intel.com>
 <CAPcyv4g=XyFfDZYL-brAO7LTVEc90=x7aQWar_WZtfnPx09UVQ@mail.gmail.com>
In-Reply-To: <CAPcyv4g=XyFfDZYL-brAO7LTVEc90=x7aQWar_WZtfnPx09UVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e2a5919-a1f0-4f7e-6d8d-08d90386538c
x-ms-traffictypediagnostic: CY4PR11MB1925:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB19253DF3F6B43BDAE5E802EBF0499@CY4PR11MB1925.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGIjpZRkG4w/3Rn758Gd0OrCTFAx3LW0L5XuMfuB4mvVeh64a0uRa4ygLsBQ5puySysixcCimcBjNbs49PPBYxmLeOSq4hcwNws9zDdp8aJvITAKH79vSeN3rG7VBa4D2VxkDim59dIdM3LrFNKW98gvS61r2rt5712HYl2P+ij2SnTMP10BIp0fjmS/7ULiDnrWfZZ+71gjLQkgq0GZ1oD7Twu6i39Kpl/dhQjcTdc9gHJZ0QClpZe0fOlxyvWcDHNGiEOC935TzKQRzlubuH0j8/UUVwybHUh4AG178v8wBzGtpPA9l5JEve600Jnp/7OrKytY7cAr6n3a8nPK64Nk/gYcTEF8rOBrObzlQrTTWVehT5ukhEnlK8AmVGvNajspJApWFUG903+gDeqG6LGP9BWL7JkFGk0+5WqEqjuP944nNXRyrmBfUp+LGI8walU4EhHxrAGxp0n5tqsCISTKy6fDl4JeDV2sROr95xsKcksMFBEkNXcniot3Ly/1NStSxmZWP8ZLjKpWz/kYBfzHQzyDzNYDWTO+7TwBCA529rlyhVPYuCaD025j/kMn530kHC/8FiDjMy3YgxdlDh2R20pag/uLdzZ6KVqdHkI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(33656002)(86362001)(52536014)(26005)(6636002)(186003)(76116006)(66476007)(66946007)(7696005)(122000001)(71200400001)(66556008)(66446008)(110136005)(54906003)(64756008)(6506007)(316002)(53546011)(38100700002)(55016002)(9686003)(478600001)(4326008)(8936002)(8676002)(5660300002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UFNsajN6Q05LWDB4QnhDSzlET1FtV2NEZFh1K21LZVRMcnJHSnhNWmg0Mkxa?=
 =?utf-8?B?cTlqVEZzK2MrbWF2cFM3MVZMNkxaVStsNEUrK2xjMkdKRS8xRFRveTJlTk84?=
 =?utf-8?B?SXN5M1Z0QkFkMlVYVnI0MS9KdUpqc2xpZUpxV1RzR040MlR3czBvNmFMSHNl?=
 =?utf-8?B?YkkrMTNtVE81bVdaeXhaSXVLa2tRU2ZTQ3pJRmNNZlQveGhWZ3VGOHZaOHVn?=
 =?utf-8?B?bmpPc1JWZnIwbGQ4dVVIYXEzQ29QbDI0RXRXV0dvVWpRMW44a2lRWEp1dExY?=
 =?utf-8?B?OUQ2UG1EOXBVSkVpNXhiT2J1TmxSQW9Ra2ZCQTc4dmNrY0ZjQ0pWeitwZmcx?=
 =?utf-8?B?Q0ZnYkFJZ2xoWFhLRUl0Q0QyUVR6bzdFMUhXQXdRb0UvQjFsb2xaelUyQklE?=
 =?utf-8?B?MUl4T3d4UU9tZ1VrREFFZnBjb003SXhrVzJCNTNBMjJ1ZktHTFFMVndpZHFS?=
 =?utf-8?B?bDd0S3U3bG9VUTQ5bUwrdVN5cVgxTkRSZEFGY3pwVk1LWFhHNzcrbmdLMTFw?=
 =?utf-8?B?ejdYQXpjZXNNSVp6ZkNldFZuWFpaSjg3ZlNhNlhUNmFqamFsUVJXaUFvS29w?=
 =?utf-8?B?dWdxR2JNSjBPRE56TEd1YmJ4MnF3U2NwQjN6dXYyVzZBelVYbWgrMERzcVNV?=
 =?utf-8?B?N3VyZDJGTzdCZklUMzRqVXpXc29PSENOVEJyUHJudnQwS1Y2dlpwYUtObkFK?=
 =?utf-8?B?dmU5VGdJNjJ5eTdLSzFnWmtTeHhLcTYzcko0VkVXdmZuSG5ERC9MbGJSTys5?=
 =?utf-8?B?KzVTTWpTUUl2OC9zWlkzTmNwN1hqUHRhbXJTQVFIMXNFVXZMTnhML3ozYzh2?=
 =?utf-8?B?TWhNWXBTcmVFajljbElWY09TdDg0anVuRHBPUmFvVHoxdnZQOUNUWEFrVGpE?=
 =?utf-8?B?a0lCK2NGRkVJdTY5bHJ6RzN4a0dMVmpCZ2pHSG5WQXRSTTlDTk1yNENTUTBQ?=
 =?utf-8?B?NDdhRWcvaUIwaG9aTVZ0ZXBNWGdhTThkMCs3VXd1UXlYcWx3WFd2SFpSNC8w?=
 =?utf-8?B?R09TeU8yQmd5R0cwNnNSWG1zWnZKS0haVExQN053WldLekxKaHBraHY1dVg3?=
 =?utf-8?B?YXhCU2twT2kybm1ERVZRcW85MHAzMnVmbTVoSGtPNnl5U1ZHTVRpbHU4MkpV?=
 =?utf-8?B?K0NyNTJEYzRjUGhMNWxwWmxNQWNqNnN6dWFuQXVyaFNPRW5qcmJrYXdoVnA1?=
 =?utf-8?B?Qjd6eTUvVkVEQk1WLzdCMEtBSm5iQ3lrR0YxK3V6K25vSWJWRnRkdjBsZno5?=
 =?utf-8?B?SzIvY3dTTkNLb1FaQXJPdVQ1UGo0a1ZQeXNwMk9aRjFtcFdQcTFMN0FkdXBy?=
 =?utf-8?B?aGc3Q3JCTDA1WUlLMXIvc2JBL1ZCU3hUaXR1bmhMcitzcld4Z211T2x4Sktq?=
 =?utf-8?B?YkRZajY3b25NQXhFRXN6RnlhYUVqZDlBVnFaeEFxTVE0cVkyUzJHR283TXdm?=
 =?utf-8?B?TktLUXY0bHlUY1lsanpqbituZ3Z3SnQvTm42dWJ1TmJvYjRzRW40aDEzTmcw?=
 =?utf-8?B?eWxMS1hsODV5bUNBS0Ftb1E4UGQrUTNXZDVzVTIxR3JIeEd3cG9raUlYUk1Y?=
 =?utf-8?B?NHJTc1RHSnF2K1B4NGlLTm1XNFhCaUVXYlUzZXVnMjdONGNsQjRVeWVnVmJV?=
 =?utf-8?B?dkF4TElmMGJ2YUVUWittdFFXS2grcU5Zb3lqd1RKZElDQTczbmlGQ051czFO?=
 =?utf-8?B?anFEdzVycjRmZ0pGMDdOemhMaWQ3N3Q1RC92Z3B6eTV6aExrQjNnQkdkYkdM?=
 =?utf-8?Q?4wKIhvQWI7euv5costCY0uj4T8ead1D5XrFyvOS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2a5919-a1f0-4f7e-6d8d-08d90386538c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 22:56:10.9869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibFDnYfESiR56QTLAO+fuSxjKp3DW2P4fAj+j788a9mELPV+l4PrTMex7RkKjxZawycKtaboIIr8QxwxSEQrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1925
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K0JvYiBhbmQgUmFmYWVsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwg
QXByaWwgMTYsIDIwMjEgMzowOSBQTQ0KPiBUbzogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hl
dmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IENjOiBsaW51eC1udmRpbW0gPGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPjsgVmVybWEsIFZpc2hhbCBMDQo+IDx2aXNoYWwubC52ZXJtYUBp
bnRlbC5jb20+OyBKaWFuZywgRGF2ZSA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+OyBXZWlueSwgSXJh
DQo+IDxpcmEud2VpbnlAaW50ZWwuY29tPjsgS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBsaWJudmRpbW06IERvbid0IHVz
ZSBHVUlEIEFQSXMgYWdhaW5zdCByYXcNCj4gYnVmZmVyDQo+IA0KPiBPbiBGcmksIEFwciAxNiwg
MjAyMSBhdCAxOjQyIFBNIEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVua29AbGlu
dXguaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgQXByIDE2LCAyMDIxIGF0IDAx
OjA4OjA2UE0gLTA3MDAsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gPiA+IFsgYWRkIEVyaWsgXQ0K
PiA+ID4NCj4gPiA+IE9uIEZyaSwgQXByIDE2LCAyMDIxIGF0IDEwOjM2IEFNIEFuZHkgU2hldmNo
ZW5rbw0KPiA+ID4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+
ID4gPiA+DQo+ID4gPiA+IE9uIFRodSwgQXByIDE1LCAyMDIxIGF0IDA1OjM3OjU0UE0gKzAzMDAs
IEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiA+ID4gPiBTdHJpY3RseSBzcGVha2luZyB0aGUg
Y29tcGFyaXNvbiBiZXR3ZWVuIGd1aWRfdCBhbmQgcmF3IGJ1ZmZlcg0KPiA+ID4gPiA+IGlzIG5v
dCBjb3JyZWN0LiBSZXR1cm4gdG8gcGxhaW4gbWVtY21wKCkgc2luY2UgdGhlIGRhdGEgc3RydWN0
dXJlcw0KPiA+ID4gPiA+IGhhdmVuJ3QgY2hhbmdlZCB0byB1c2UgdXVpZF90IC8gZ3VpZF90IHRo
ZSBjdXJyZW50IHN0YXRlIG9mIGFmZmFpcnMNCj4gPiA+ID4gPiBpcyBpbmNvbnNpc3RlbnQuIEVp
dGhlciBpdCBzaG91bGQgYmUgY2hhbmdlZCBhbHRvZ2V0aGVyIG9yIGxlZnQNCj4gPiA+ID4gPiBh
cyBpcy4NCj4gPiA+ID4NCj4gPiA+ID4gRGFuLCBwbGVhc2UgcmV2aWV3IHRoaXMgb25lIGFzIHdl
bGwuIEkgdGhpbmsgaGVyZSB5b3UgbWF5IGFncmVlIHdpdGggbWUuDQo+ID4gPg0KPiA+ID4gWW91
IGtub3csIHRoaXMgaXMgYWxsIGEgcHJvYmxlbSBiZWNhdXNlIEFDUElDQSBpcyB1c2luZyBhIHJh
dyBidWZmZXIuDQo+ID4NCj4gPiBBbmQgdGhpcyBpcyBmaW5lLiBJdCBtaWdodCBiZSBhbnkgb3Ro
ZXIgcmVwcmVzZW50YXRpb24gYXMgd2VsbC4NCj4gPg0KPiA+ID4gRXJpaywgd291bGQgaXQgYmUg
cG9zc2libGUgdG8gdXNlIHRoZSBndWlkX3QgdHlwZSBpbiBBQ1BJQ0E/IFRoYXQNCj4gPiA+IHdv
dWxkIGFsbG93IE5GSVQgdG8gZHJvcCBzb21lIHVnbHkgY2FzdHMuDQo+ID4NCj4gPiBndWlkX3Qg
aXMgaW50ZXJuYWwga2VybmVsIHR5cGUuIElmIHdlIGV2ZXIgZGVjaWRlIHRvIGRldmlhdGUgZnJv
bSB0aGUgY3VycmVudA0KPiA+IHJlcHJlc2VudGF0aW9uIGl0IHdvdWxkbid0IGJlIHBvc3NpYmxl
IGluIGNhc2UgYSAzcmQgcGFydHkgaXMgdXNpbmcgaXQgMToxDQo+ID4gKHZpYSB0eXBlZGVmIG9y
IHNvKS4NCj4gDQpIaSBEYW4sDQoNCj4gSSdtIHRoaW5raW5nIHNvbWV0aGluZyBsaWtlIEFDUElD
QSBkZWZpbmluZyB0aGF0IHNwYWNlIGFzIGEgdW5pb24gd2l0aA0KPiB0aGUgY29ycmVjdCB0eXBp
bmcganVzdCBmb3IgTGludXguDQoNCkknbSBhc3N1bWluZyB0aGF0IHlvdSBtZWFuIHVzaW5nIHNv
bWV0aGluZyBsaWtlIGd1aWRfdCB0eXBlIGZvciBBQ1BJIGRhdGEgdGFibGUgZmllbGRzIGxpa2Ug
TkZJVCByYXRoZXIgdGhhbiBvYmplY3RzIHJldHVybmVkIGJ5IEFDUEkgbmFtZXNwYWNlIG9iamVj
dCBzdWNoIGFzIF9EU0QuDQoNCkZvciBBQ1BJIGRhdGEgdGFibGVzLCB3ZSBjb3VsZCB0byB1c2Ug
bWFjcm9zIHNvIHRoYXQgZGlmZmVyZW50IG9wZXJhdGluZyBzeXN0ZW1zIGNhbiBwcm92aWRlIHRo
ZWlyIG93biBkZWZpbml0aW9ucyBmb3IgYSBndWlkLiBGb3IgQUNQSUNBLCBpdCB3aWxsIGV4cGFu
ZHMgdG8gYSAxNi1ieXRlIGFycmF5LiBMaW51eCBjYW4gaGF2ZSBpdCdzIG93biBkZWZpbml0aW9u
IHRoYXQgY29udGFpbnMgYSB1bmlvbiBvciB0aGVpciBvd24gZ3VpZCB0eXBlIChndWlkX3QpLiBB
cyBsb25nIGFzIHRoZSBPUy1zdXBwbGllZCBkZWZpbml0aW9uIGlzIDE2Ynl0ZXMsIEkgZG9uJ3Qg
dGhpbmsgdGhlcmUgd291bGQgYmUgYW4gaXNzdWUuDQoNCkJvYiwgZG8geW91IGhhdmUgYW55IHRo
b3VnaHRzIG9uIHRoaXM/DQpFcmlrDQo=
