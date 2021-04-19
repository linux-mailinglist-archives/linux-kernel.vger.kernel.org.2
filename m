Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05250364D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbhDSVys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:54:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:21185 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232685AbhDSVyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:54:46 -0400
IronPort-SDR: GDwKS7LTnD4BmQ2T5gP3Jv/KgjIAMLFEQTVrIIrX6tScs3a0Cuy+KRDJ1BJUHjl8drf0GZomdd
 JvVMB7hKPIdA==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182897694"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="182897694"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 14:54:16 -0700
IronPort-SDR: cYQFOiKACPJaWuxpQQSKqPmmBgH55vO9ATvK77UtlUz3mp9wnnk+i1a2xL6AX4TFfejCp5K3du
 QtBoV/o4R2tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="454487298"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 19 Apr 2021 14:54:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 14:54:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 19 Apr 2021 14:54:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 19 Apr 2021 14:54:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMsXIYAcJ/+ihHQGCpsaNdQ6HWJr1wcIIYK1VAiNNYE3SAR2lBSHPq3KpZJSdo9BpjfNXhUuMKMjqTN64FOAkS9d9feezeyFKiRumZMTZg78IfarqI/H1RdH/anhuYXTbfDrzoGgsPyJR0gMOYlo+CFHdDpqIBmzrEsQUCTqNhUJdYQE6Z2ltLxcG4CGuVSs8VTzBjanAHhXZP94MYRoyCCi9QORK7hdSqeU9MAJKeBPF/dG0izvhlgm2a2Omm/V2OeBcoJ338+vZJx4fSr/suLhxefmogqEeEDNGCs6T9e/SvyxQqMzBItGHNhzXcwn7ivxPCxPeOUUnsVHHACDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZvG2LuHWsNoLxL2k5nH6vXl0KjGVfm/oGliErHFXDQ=;
 b=AURMwJM9Ka4mX9X8hwMCCDWAjxUJfUFgEqGbWrrh/aTDcLaET+WyV5G3YEYNo6KYiLSRqeeYZuf1QRTbkWX6nSq2Sw7AQJKrdnNJoDvIkG+lA6Xl4/cyx+kSXR+85/TZhVpWNoNifG8NpW1Ev6JPXe2uRpfxGur33jB8fd7X5C8sBf76K55TKZyzeVdLcbSiTGmvor1X2qSB7MjZb2J1G6aI+4w3pyNMCHNdlpe2KJvA8PglHVa1aDB0tKyEqv5rGDA3vJZ/g2Dr4mFje80bxYLfQb9QfML0/LQzuv/STzq2KsxF3nQdlQJuhaXt6ysQJV0HVimImWyS2vDJkqEfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZvG2LuHWsNoLxL2k5nH6vXl0KjGVfm/oGliErHFXDQ=;
 b=GXhA+AxSkLG6zwzBzd0cwi9ZUDDqbG3PrA2yubERjh60V2i/aE/PR/11rdIt6z6Fc1oBOdRGqdGJ/4YjaFtB8Lr70dUhfL/2JCZurndKhwH4uxI07gX++UKNBpuXqucyWMmsUcCF8Gvchxj+LSqvZcceweteJXny4nFuFthgluc=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by SJ0PR11MB4926.namprd11.prod.outlook.com (2603:10b6:a03:2d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 21:54:14 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::153d:3860:6b4a:d839]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::153d:3860:6b4a:d839%4]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 21:54:14 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
Thread-Topic: [PATCH][RFC] tracing: Enable tracepoints via module parameters
Thread-Index: AQHXNWaJJ2TvKc1z40WhFVGC+cYlQw==
Date:   Mon, 19 Apr 2021 21:54:13 +0000
Message-ID: <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com>
References: <1299622684.20306.77.camel@gandalf.stny.rr.com>
         <877hc64klm.fsf@rustcorp.com.au>
         <20130813111442.632f3421@gandalf.local.home>
         <87siybk8yl.fsf@rustcorp.com.au>
         <20130814233228.778f25d0@gandalf.local.home>
In-Reply-To: <20130814233228.778f25d0@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25d41db8-727e-47a8-c1ef-08d9037dabfa
x-ms-traffictypediagnostic: SJ0PR11MB4926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4926C4C0D407AA05A45B81E2C6499@SJ0PR11MB4926.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZvGbLuSy9qp6b8yV36p4KFeEyJ01P8glTpF2Oobzf6BHLJ+KuAtn6B824gsWNvXRk0M3bCHcApaHBnusPG5F3uDdWXaEpPVxgj6jfNzgFtcRqL0Rcrx8HRCP3/BCy2k/Bxzh7bzbRj5mL1Lj6PTHT789rG0pzQgsgtTKqzVqdJyHXxvFgSKAMULwSgci7g1u9GXVTd+Yd7j3xoE/zKKfuMRh7k/uMzmMxHkzuv4bSQAd1kUwlUjnOqKEzGQgZKO694N456hFpma0yvz9GTLW36R7v3fE1qaANdG77hVBSlMd7iWVf0vgZ8M4HJRh3UpIZJ/eY9340780TIacRjBaVV3NKnrN6CivHTP5AIjxp5cs/aoEmQ4TlFZRpE1DcZa340t6bfsutr+x++lPQ8Iucj5qZBEgSS/ltswKZhu+HP3nsNVXa8VaVvwf6PZ1m784lD2fNGJTcUX9k2IJHa+PAxjnyLabqIIgCrqVZkF0/sCIlo/uYHGAi22GvPmF3uVp9Ff3AetSLuIsPBQdVtwlCC+rtB10/OLr13cB3lIw8PrjtpnS0mOnYz6Q5tz4hLfekRbiiLI0kOq6ODH3n32+w+X7txanPw83BuDdsxnl+SDzkhcDAWGXTd1Hg6fX0jS7OwvFRNGoN+xzTc51QVR9khsPtAeOdFzso/bs8Fb5mfdCAj0+omRMByQ2y9RaM8My
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(346002)(376002)(396003)(54906003)(36756003)(5660300002)(122000001)(316002)(478600001)(186003)(38100700002)(66446008)(966005)(4326008)(83380400001)(2906002)(76116006)(6512007)(66556008)(26005)(66946007)(8676002)(6916009)(6486002)(6506007)(64756008)(71200400001)(2616005)(8936002)(66476007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S3dvcXpyZ0NxSm9BOHpETDdTS0JienhhZVdyZHNSV3Fhb2pZaE9TNEJHTndn?=
 =?utf-8?B?RTdSSzVYVHJYNEVlTTYxdk5DU1l3WkhDeTNIOTg0MHA3TlY2REl5MWRMaGJN?=
 =?utf-8?B?QjYwU0k5dWhPL3ZTRmx4K1V5Z0RQbWprZnh5clczWVdneDd0VUtSZFM2cU5J?=
 =?utf-8?B?UVdYVk9aSkZKUjVoUjJIcks2NTI5K1RaeHM3RDN3YktPRHRRRlFPMUhjOWlH?=
 =?utf-8?B?dE5ZZUNOUWNkZU9vN3huN1FRM3k5SnkyTVRsUmFScmMraUZZZFVaUkxSWS9H?=
 =?utf-8?B?ZHNQbW05SFg2aXkyNHdyOXF6dzM0a3BLNVZERmcxbkNham1UY3NweVBBZ1l2?=
 =?utf-8?B?RUVBWS9Lc21qWGlGNnRtNXpKTVplSGVRaUFjRW12d0FYTTRGVEVBekJURWda?=
 =?utf-8?B?UGlJd1dHcDNiUmY4SUlJSlhVMzVVbVlhdVV3OCs3WmtGcm9XY2pDQWpoS0lI?=
 =?utf-8?B?NndQZmJRQlZ0TU9IYlQ1RC9FQmhKSS95MFlCaUM2dVpHSmVLSXBKVlBFTW1p?=
 =?utf-8?B?MGdaRU84YTd5cHhPc1MrekhBSklSZkRlRXFTNURVeUdtOXdwaEl6UFBNaUcv?=
 =?utf-8?B?OE9EajViKzZKRW5SLzAvZmJqaEx1RkhSTXlDaUNUcjJQNm16Y3lmbG5SN2dh?=
 =?utf-8?B?SUJjdTZXRk5HeS9GbnJhK0JRbzFiMkVVa0NWcG5kaEsxYjRVTHdWKys3aEda?=
 =?utf-8?B?YXFjdzk3ZzRSaXdtYk84WnFMTlY2Q01zOFBHYlhPV3NJS3UycXRRNWxtQi9B?=
 =?utf-8?B?UmZHbkRLcUc5bE1RalpQYmU5NnpEeGZDMUdXamJ4WlEyZlJ1QUxOWCs1Mnd4?=
 =?utf-8?B?dXVTNlJ2Qmo3blJ5SDJYT2lhWGZyZ3E4QUZ0SVFrM3hpTXNGdGpRaTdCOEVF?=
 =?utf-8?B?b1JOSXFLS0VsTEVMVWF3dVord2xBbEIveDJEZGdzcVNxajl2Tk9XaTM5aE85?=
 =?utf-8?B?R2NvbFg2UHJCclFMZ3VYbUpqeFR6R3JtSkdNQmt6Zytra2haRUNXVnJ0UnJ4?=
 =?utf-8?B?V3NmZE13MVdiankrby90dlV1WWFjN3dOMGE3OXNrLzh1bTFBWEpndGpqTDJs?=
 =?utf-8?B?L3dsdjNTRXdwVURheUZWMUcwc0o4MW9Wb3FXRVdzRlI4WFppaEdtVDYxTWc4?=
 =?utf-8?B?UE1MV3pGOHlheEFCWEo3bFE5VVFqVTJick9uR2dVZ2FwTm8xRmZCc1JvM2RP?=
 =?utf-8?B?LzREU1VDRlBqZFZ2QkxKTXZVSzRlUEZMbk1PUmd0WDcyRHlHNjg5R0k5Ri9w?=
 =?utf-8?B?aGRjVEczUlVFUlpTUGVWUEdDa2YvTEQxbFRlRUVhY1FFY1VpSFo3NmpXOXEw?=
 =?utf-8?B?ZXlSOWRhMXdXY0hybzlPSWVNalNPR3h3WXFjOXVnaEJqaUxCYlE4L3dhNFA2?=
 =?utf-8?B?TmJBanlsTHgrbE1WUEI4UXVwSGliR0NwWXJwQnZtbUQ3R1hMOFQzdjhuKzZx?=
 =?utf-8?B?eVJUcVJETkN6TkxxTDFaTFlhU3pRY1pMaGVxN0kvd0M2QTlUbUd4NmhKaWc5?=
 =?utf-8?B?aUVGbmw5OWxWRS9oY1BWTW01cXNrY3ZJeVdQRFdoWWxiU3JjZUlFNEJOY2Y0?=
 =?utf-8?B?QUNNdDJsZUhQLy9zUDNKMk5mb0E1OTJEaGtaZ1JBYWZZOEUrZzNGM0NMektX?=
 =?utf-8?B?UHNZZHlhZkV0TjNtVEJuZzcvWllGQlBhN1doQXZHU04ydGkvY1RVcWNQeTZu?=
 =?utf-8?B?ZDE5b3VlQXZWM21QMGZCZEdGYVBTSEE0cGZBNXZYNW9rVmw3NXd5UXBWZndO?=
 =?utf-8?B?UkJ0TUhYYnBCN2xwR1E3Yi8xQmFDZUdCdngycWNUM1o3d3ZYTG5rT0FnV2dW?=
 =?utf-8?B?S2pKMHlaNzFuMkc0WmxmZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A87EFCA6F60BE4468B4E5441528A14E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d41db8-727e-47a8-c1ef-08d9037dabfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 21:54:13.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtGlYJb9vERNpseW+1xJBuRJu0gAtgFQRDY/7ykoHdXRPe/TfQ6GuI6ki1DMKmhxxbk0RcGOAPzimPryKUFaICb0gK4MIes3ihqPHlENVEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4926
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WyBkcm9wIFJ1c3R5LCBhZGQgSmVzc2ljYSBhbmQgRW1tYW51ZWwgXQ0KDQpPbiBXZWQsIDIwMTMt
MDgtMTQgYXQgMjM6MzIgLTA0MDAsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOg0KPiBPbiBUaHUsIDE1
IEF1ZyAyMDEzIDExOjMyOjEwICswOTMwDQo+IFJ1c3R5IFJ1c3NlbGwgPHJ1c3R5QHJ1c3Rjb3Jw
LmNvbS5hdT4gd3JvdGU6DQo+IA0KPiA+IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMu
b3JnPiB3cml0ZXM6DQo+ID4gPiBCdXQgdGhlIHRoaW5nIGFib3V0IHRoaXMgdGhhdCBib3RoZXJz
IG1lIGlzIHRoYXQgdGhlcmUncyBubyB3YXkNCj4gPiA+IHRvIHNheSwNCj4gPiA+ICJFbmFibGUg
YWxsIHRyYWNlcG9pbnRzIGluIHRoaXMgbW9kdWxlIG9uIGxvYWQiLiBJIHdvdWxkIGxpa2UgYQ0K
PiA+ID4gd2F5IHRvDQo+ID4gPiBkbyB0aGF0LCBidXQgSSBkb24ndCBrbm93IG9mIGEgd2F5IHRv
IGRvIHRoYXQgd2l0aG91dCBtb2RpZnlpbmcNCj4gPiA+IHRoZQ0KPiA+ID4gbW9kdWxlIGNvZGUu
IEhhdmUgYW55IGlkZWFzPyBCYXNpY2FsbHksIEkgd291bGQgbG92ZSB0byBoYXZlOg0KPiA+ID4g
DQo+ID4gPiBpbnNtb2QgZm9vIHRyYWNlcG9pbnRzPWFsbA0KPiA+ID4gDQo+ID4gPiBvciBzb21l
dGhpbmcgYW5kIGhhdmUgYWxsIHRyYWNlcG9pbnRzIGVuYWJsZWQuDQo+ID4gDQo+ID4gIndpdGhv
dXQgbW9kaWZ5aW5nIHRoZSBtb2R1bGUgY29kZSI/ICBXaHk/ICBUaGUgY29kZSBpc24ndCB0aGF0
DQo+ID4gc2NhcnksDQo+ID4gYW5kIHRoaXMgc2VlbXMgdXNlZnVsLg0KPiANCj4gSSdtIG5vdCBh
ZnJhaWQgb2YgdGhlIGNvZGUsIEknbSBhZnJhaWQgb2YgeW91IDstKSBJIGhlYXIgeW91IGhhdmUN
Cj4ga2lsbGVyIHB1cHBpZXMuDQo+IA0KPiANCj4gT0ssIHRoZW4gd2hlbiBJIGdldCBzb21lIHRp
bWUsIEkgbWF5IGNvb2sgc29tZXRoaW5nIHVwLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gLS0gU3Rl
dmUNCg0KUmV2aXZlIGFuIG9sZCB0aHJlYWQuLi4NCg0KU3RldmVuLCBkaWQgeW91IGV2ZXIgZW5k
IHVwIHdpdGggYSBzb2x1dGlvbiB0byB0aGUgImVuYWJsZSB0cmFjaW5nIGF0DQptb2R1bGUgbG9h
ZCIgcHJvYmxlbT8NCg0KSSBzZWUgc29tZSBwZW9wbGUgZ2V0dGluZyBhZG1vbmlzaGVkIHRvIHVz
ZSBmdHJhY2Ugb3ZlciBkZXZfZGJnKCkgWzFdLA0KYnV0IG9uZSBvZiB0aGUgZmVhdHVyZXMgdGhh
dCBrZWVwcyBkZXZfZGJnKCkgcHJvbGlmZXJhdGluZyBpcyBpdHMNCmdlbmVyaWMgIiRtb2RfbmFt
ZS5keW5kYmc9IiBtb2R1bGUgcGFyYW1ldGVyIHN1cHBvcnQgZm9yIHNlbGVjdGl2ZQ0KZGVidWcg
ZW5hYmxpbmcgYXQgYm9vdCAvIG1vZHVsZS1sb2FkLg0KDQpJdCB3b3VsZCBiZSB1c2VmdWwgdG8g
YmUgYWJsZSB0byBkbw0KL3N5cy9rZXJuZWwvZGVidWcvZHluYW1pY19kZWJ1Zy9jb250cm9sIGVu
YWJsaW5nIGZvciB0cmFjZXBvaW50cywgYnV0DQphbHNvIG1vZHVsZTo6ZnVuY3Rpb25fbmFtZSBw
YXR0ZXJucyBmb3IgImdvdCBoZXJlIiBzdHlsZSBkZWJ1Z2dpbmcuIEknZA0KYmUgaGFwcHkgdG8g
aGVscCB3aXRoIHRoaXMsIGJ1dCB3YW50ZWQgdG8gdW5kZXJzdGFuZCB3aGVyZSB5b3UgbGVmdA0K
dGhpbmdzLg0KDQpbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzL1lI
UkZ5M2FxJTJGZ0I3VmRlNkBrcm9haC5jb20vDQo=
