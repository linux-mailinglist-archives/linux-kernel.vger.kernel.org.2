Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273D739DEC2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFGObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:31:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:45139 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230255AbhFGObV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:31:21 -0400
IronPort-SDR: Uw11XymvTBo8H+wxGzD56u3XR3dUQBzXehZQ02/pjELKxT2/QtnomEQws2FmiX24aFvj/NgpN4
 CJYg6bDEgJbA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="191740666"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="191740666"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 07:29:29 -0700
IronPort-SDR: 4iJvu9y84FuHTNBQqCaNPbm1rXJ9w/ai+HxnS6UIA0A++8D5hNeRXW1a00MG4yB6L+/JRmWK7Z
 Hg9GYriSo6KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="484792750"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2021 07:29:28 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:29:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 7 Jun 2021 07:29:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 7 Jun 2021 07:29:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt/qmUALe1tavQzMou9mONYs+qBVkjQ1i5qDRszc7ZaGvgx+glW9LGmkw00vQDiIFhKiy3KIXhCuzvGgUlm7IlHiI9MizrOLT636TtZvGXOSpFPtDZleJui/YCrEUpC12GMHaoFM5H/JrKMj4va+vTLzMHkGu17gYCL/nNZKBd/Je4fSzmgiNC5RNy9InJ+IewBR+FZciHksnxiVXm5y7WVjFjHPI0yVU66HU2k7Bes3h/b5N/FfG/7aVHSj01XDAXkAcRdlaEUjCztZ2Blgp7E68p1diYpFhn13CL600Crq9rAQ1yvGW2Ctrq9ODgshJm8xvfG1UOckiCJRk6t3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXDd+F0dM1T68WH17k1s5v6dpxTQTLj3aMT7ynj18uM=;
 b=VXWogOICoUFWaUWg1qL2ApqSeqVUo2hePKPCjnZhhQpAkUj0ZKPsFQU+9E/fmW5Afga1rMguQ3gu56eDA6On8NHgkV5mmScLMGVJt5rHALUBM+WS5OpTUL4XzrlVOSgdJnr8+D6OD/bVhvCHLYjLUwRXPnGF38ewmIVfJcvUujlg2ZkNc0u4pNwZaaNQfKrPKCHaDYQ+9jCgkDVRZtrjvhoQfHQ9zrOT0+Gqe94ckFK3K5jPgv6dY6GIkPe/fp5OrFQLLeNCE0qbEBnKVhDdCK18xHpUvgvFYHAnLzjebrtlMq1uU7PoXtoepK4NVDJAcnY0Ow79cxeH/w4Qk28Ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXDd+F0dM1T68WH17k1s5v6dpxTQTLj3aMT7ynj18uM=;
 b=qHPjFM/DXe0qobkIk+htQcbQieOKwlmkihe3u0EcbEQqpSHqu2s3CNeCdgj+3TEUkHVwQi01A383JheC7OkOp1n8bkq+eroigftE1h7C5+FLTGOysQOlgFP0ePtxqv2j+2k07oRqzdtfVlpRi2JQcSX0y17wg1kynVEl8wPtQpE=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM5PR11MB1323.namprd11.prod.outlook.com (2603:10b6:3:14::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22; Mon, 7 Jun 2021 14:29:12 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f890:381e:1e24:a6d9]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f890:381e:1e24:a6d9%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 14:29:12 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        "Guennadi Liakhovetski" <guennadi.liakhovetski@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ranjani Sridharan" <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "M, Naveen" <naveen.m@intel.com>, "Zhi, Yong" <yong.zhi@intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: RE: [PATCH 3/4] ASoC: intel: sof_cs42l42: add support for
 jsl_cs4242_mx98360a
Thread-Topic: [PATCH 3/4] ASoC: intel: sof_cs42l42: add support for
 jsl_cs4242_mx98360a
Thread-Index: AQHXWm+BSRbfqtjemkyMcQgR/Pdi8asIkI4AgAAMh9A=
Date:   Mon, 7 Jun 2021 14:29:11 +0000
Message-ID: <DM6PR11MB36421AD935E4A2B8EBD0FE6197389@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <20210606004102.26190-1-brent.lu@intel.com>
 <20210606004102.26190-4-brent.lu@intel.com>
 <505c7e46-316c-9fa1-feaa-115f4561ed19@linux.intel.com>
In-Reply-To: <505c7e46-316c-9fa1-feaa-115f4561ed19@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [36.230.1.79]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 499e4fa7-32da-4c78-2ba5-08d929c09ea2
x-ms-traffictypediagnostic: DM5PR11MB1323:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB132384B1A6E6FBFC1BC16BE297389@DM5PR11MB1323.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MdbghhgmU+RrmgBWVckdwTDfOteXuT2a3PTDqccN1+JopjRLAkK1g5m1WRckaStautJAb9kqOoXuhjDy0eBRwbP25UwuwdXGt21omXgIN/Cy2SvRJGbWuvdIQrfKlL12QVPl/0c7QW9+OKt600R8i4O6vd+Ym/8NVnJhrAevg0RcOgpkbrkRilI+3Jr5otsAXtYY14HQWJWSTtUNLZRTAX72c19IFbmPYQvVdBZ7L/9b4thBfi2tRwZM39pD5nh0LXbgOENpvKGI9+h2V74zW7K6qOVg9/yKaouRTCW9wHPsLW4iwqZWJKsE5vewJeecBrijj+pD1SFxbYp/A22/StX9ucrhKl4z8pj3suq+/WrLNR+m9kn8MIyOVTm8fk7HyQ35NLfbU893HDsuVOq9DLAG2sid4oSboJwBgLJS2EMn1KT/jzVrvgkGREn4hThmlzSv0GE+LY1p9cGkFU0NsPYKk/rAdyE39Ioje2ChUHu415gopgAAd+ljqwlrO4Fvk3ozr+aaLnKMSxNMrtcExWqd+8KUymYQSyBvjOE3RWQ/+h/GNPjN+d9uRPAue0BOqTEzirM5Pb/E+HdA/M6ZtgLY2cIUwp1JHLwhSRRbXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(55016002)(110136005)(86362001)(316002)(54906003)(52536014)(5660300002)(7696005)(53546011)(33656002)(6506007)(4744005)(186003)(38100700002)(8676002)(2906002)(66556008)(66946007)(76116006)(64756008)(66476007)(9686003)(66446008)(8936002)(71200400001)(122000001)(478600001)(4326008)(7416002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ejBuRlRiZnByS3dYL1pNdktLQ2JIZDdqTGVBVVl1Z0NmcjVuNTVRZjZnemRr?=
 =?utf-8?B?b1N5L0RyNlVSb0xTczhEYzNvU2tYSmhvcnRNaE9tZmpJbko1ajNUempXM1dW?=
 =?utf-8?B?RHg0Y1VNL3pLSllOUjRlN0l1OHYvRnVPYnllY0tHWnh3Vi9UTkNlVjRxdE5w?=
 =?utf-8?B?S2dLL284MlFFVGMwbWhlRGlpUXdockpzMXUxalFXRS9GVWREVURKVlBpb3B6?=
 =?utf-8?B?NUlaSXdOd3NHYVp3WjZZMFc1RGFtMkVmWXZBNklsaUc1TCtwWEhZSklTZUY2?=
 =?utf-8?B?eUljcUtPUXZleEQxdVMwczF6algrdGVveVZ1VDdMSjUzQm4zSkxzRjRoNU5l?=
 =?utf-8?B?MGRPejFMT2Zuckd2VWxUaTByQTRaclNKK3lPU1ZHbFF5V2xmUkpGTGFIVzJZ?=
 =?utf-8?B?RXlnMmNpRHRPZ2lxSzRFSkhHT21jdTQ4RTAzUllHd093QTZKcVd1VHNRSDR5?=
 =?utf-8?B?SlFBSWJST0RwZENKSGFmVHQzeDJhWHJXMTBVazVGUXZ5YnVTd09Oc3BhU0hW?=
 =?utf-8?B?eWNMblVlMnZJeG1CZnVZSXVDWnlBcEtFNng5VmVBRHpjcWs2R01uSGp1a3lI?=
 =?utf-8?B?N1NjRVEwbjJ4ZEE3bElKZDdGeVJsOWYxM1o2YmRnaTVmdVNzUlRtVmxhVG03?=
 =?utf-8?B?UWs3d0p5bksxdE9va25CdVR3Q2JreUxWWE1COFF0U2hxaWYwYzlBeGRhMTE3?=
 =?utf-8?B?T0RlMkVlcGViMjFHRHZ2SlVVY1M2c0FteStLNlNmQ3YrTEd5T0dWYkxqaUZL?=
 =?utf-8?B?WVYvQXBLanB2aVQ0Z3o1bHlxWlVkVVNVLzhjRi9QcTZRbHNBRTlzUXlJM21T?=
 =?utf-8?B?RGdVVk5oS3Jya1lHcENteFpHK2p2SHVEd29KMjdBWXNMR24vT2dlbVVucmpR?=
 =?utf-8?B?MTRWa1YxTU1HUmRPajYvTUZSTUlSVEc1R1ArbGt0bUNNTUU5TzZyYzQ2aHZW?=
 =?utf-8?B?WUlHMFZOaDBtdGxTRFg0QTBkM3IxUEkzZzZhS1AvQktzSlRrRGtTb1BtTkNT?=
 =?utf-8?B?VGFQYTgrWExnbFA0YVkyR0xUUVc3QkY1c3ZrZlVnVi9BUFYrbmRKZmFEOWIv?=
 =?utf-8?B?Vk5ua0tHVzJyNzRRUlprbUhLcXd6dVhRY0F1Mk5BaVdrWXFKZ2VZSkxTc25V?=
 =?utf-8?B?d2I4QSsrU05kUXl6UWtlV0NaRll6UzN5ZERWeWxaM3hMczlGRGVzWXQ1WDkx?=
 =?utf-8?B?VHNJbU5tMHIxdjNmUUR1dnRYVFY2OFYwVjByQzRkQ2NvNk1wZWhGbldDVlRS?=
 =?utf-8?B?dVA4SElUbTZ3Z2xwQnRqM3RsRzd4YjRpL05uelZXN2E3RHlXNlZGRWlod25P?=
 =?utf-8?B?Wk9NUG01MjNUNUNXQWk4YVFyWFU2UkVhODhSQnNqTkNJK3djMEpSaXg5bmxq?=
 =?utf-8?B?TVJrR1cwZlNQdTMydkhKUlRQdW1yeTgwTVV5MDcvcjNzKzJQZHdsMCtMQTg0?=
 =?utf-8?B?TzFCMXB5ZnFCTEZlUnV1WWJXakY1MWxuR1F0T29jVW5uWkdqbmttVTFESi9Z?=
 =?utf-8?B?ZGNVaXFWT2hxV2xaOTJyNDJjWENVZCtZeDNMVWtvdEp1UkJpYjR3Q0tuMmdl?=
 =?utf-8?B?Rk9qNDRwQTZOS3ZUZUJrRzNpeURTYStoQUZUMFVkRDl1YjJzRkpPT2dwbnBC?=
 =?utf-8?B?bm9IOGhUSTR5NW1TdVIxdmpQdUVDRkJiU3kxNHZjc01RUzQvZm8rcElKMHNa?=
 =?utf-8?B?NjlOa2RmN3VrWnpydXhmK29FWjFSQldVL0JEaG9xUUZHSlhCVlFhWGtCdUF5?=
 =?utf-8?Q?x8qo6knk4RJRZcb8X8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499e4fa7-32da-4c78-2ba5-08d929c09ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 14:29:11.6386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7ZAwtG1B0yP9QZwRZP1kFJkgYJ/X59lsnh3AhywVHBHwpdej6YcdSfdNM5Bsd0IA48+TGb3xngdDuiWrphUDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1323
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA2LzUvMjEgNzo0MSBQTSwgQnJlbnQgTHUgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRz
IGRyaXZlciBkYXRhIGZvciBqc2xfY3M0MjQyX214OTgzNjBhIHdoaWNoIHN1cHBvcnRzIHR3bw0K
PiA+IG1heDk4MzYwYSBzcGVha2VyIGFtcGxpZmllcnMgb24gU1NQMSBhbmQgY3M0Mmw0MiBoZWFk
cGhvbmUgY29kZWMgb24NCj4gPiBTU1AwIHJ1bm5pbmcgb24gSlNMIHBsYXRmb3JtLiBEQUkgZm9y
bWF0IGlzIGxldmVyYWdlZCBmcm9tIHNvZl9ydDU2ODINCj4gPiBtYWNoaW5lIGRyaXZlciB0byBy
ZXVzZSB0aGUgdG9wb2xvZ3kuDQo+IA0KPiBUaGlzIGFsc28gbG9va3MgbGlrZSB3ZSBoYXZlIHR3
byB0b3BvbG9naWVzIGNvbmZpZ3VyaW5nIHRoZSBzYW1lIERBSXMNCj4gZGlmZmVyZW50bHkgb24g
ZGlmZmVyZW50IHBsYXRmb3Jtcy4NCj4gDQo+IFdoeSBjYW4ndCB3ZSBwaWNrIG9uZSBjb25maWd1
cmF0aW9uIHRoYXQgd291bGQgd29yayBpbiBhbGwgY2FzZXM/DQo+IA0KDQpUaGUgY29tbWVudCBq
dXN0IHNheSB3ZSBhcmUgcmV1c2luZyBydDU2ODUncyBzb2YtanNsLXJ0NTY4Mi1teDk4MzYwYS50
cGxnLg0KVGhpcyBwYXRjaCBkb2VzIG5vdCBjYXJlIGFib3V0IHRoZSBkYWkgc2VxdWVuY2UuIE1h
eWJlIEkgc2hvdWxkIHJld29yZCB0aGUNCmNvbW1pdCBsb2cuDQoNCg0KUmVnYXJkcywNCkJyZW50
DQoNCj4gPiBBbHNvIHVzZSBtb2R1bGUgZGV2aWNlIHRhYmxlIHRvIHJlcGxhY2UgbW9kdWxlIGFs
aWFzLg0KPiANCj4gSHVtbSwgdGhpcyBsb29rcyBsaWtlIGEgbWlzc2luZyBkZXBlbmRlbmN5LCBJ
IG1vZGlmaWVkIHRoaXMgYSB3aGlsZSBhZ28uDQo+IA0KDQoNCg==
