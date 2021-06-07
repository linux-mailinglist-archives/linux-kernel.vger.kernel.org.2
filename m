Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3339E430
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhFGQdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:33:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:36380 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233384AbhFGQat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:30:49 -0400
IronPort-SDR: 9b11Fb0Yx4ib/1kWWkhUDhctUbSSg2AHwT8ySjynylG7sCrPN0FI7Kyjk/rO90bGpQ6uCSJqpf
 fZ9r3cgTjDKQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="201635206"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="201635206"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:28:25 -0700
IronPort-SDR: Fi28L2OytswBWV8JPTgQQe3WktArmcPgX9sPyVU1iZHsJvsBe1cgweQAWtctiPQg1r+n4w+v8I
 bdnzGHQ9vYhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="418576994"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2021 09:28:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 09:28:24 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 09:28:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 7 Jun 2021 09:28:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 7 Jun 2021 09:28:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HknNchCmhN4nCPM5uKbBtPsNnwEGhapgpIQgY3Hbwqgv2TuLfR7DN6LuTd5cQMNoXpFxVvGSbmQLGYwExsv+o2QHwhv8I0fT+Z/SNHUaHVjQq+brYw5XN/cMdGI21ZTPfcwcKgJiu9k2uT2Ci8W84JK5PhENBPLng2a0xrrKcdC7GaKqOtA039rU7pFt5JcQmppBFqGErDoqJTv2czflU9uoHCP8SZ4gSS4oz9M/HwAPNCMmscB7T8cXP8iK7An97etvLtCyLsxuXobAQ8tl4tgibpxyDgoznemf895FmwJvYj1ugclUhtPbx0GISBKtPV6Z2rkkwEhNrla7el7uXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmpgXGCFi2xxsZLkr+Ch5V+JwPjgLsoMSRsNkXgtcT4=;
 b=Be1UWykFui7D4q18n7X7KlWNYpRfLKM31KljO66DksI/mjbMcTPB3kfThAKSbJ5h7pqe4SIJTxz1AIHcJtqksveTEX22BPyQDE5JhulpU879UlAapiofnMDdAzUtlzgO+cHOkv+nMFP0Q/Yce02TLkX3XaItPvYx/bOWNbXZ01m6DcSM5RRorzrflLUCabttHQCa1TJFIGM2LTSqCHx0i1B34N4hj8kSuNO2Lv1gLQaWDB3Gjpi63dRtMIhtYqfSpTgG7vMrmTF1ePzr6Dd+mQcMUJIZbqWjIXg0BeKN4NzAne4N9ippU8Gxch9yu/wEk22MnKj2aFZyvpPUQaDKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmpgXGCFi2xxsZLkr+Ch5V+JwPjgLsoMSRsNkXgtcT4=;
 b=cX3trCWD4SNZha2DRJUNKCWtLhZmU5oRuU02TaQmV3UmIPMP4/qFKa3ZJ58hbKw+Gpn4/EqQwPSubs5gRmSiDJYWLS7NH9GApN3SiA007EMmagNbM0UmlcZD3ttqLeRtjBBFTlStK48vACKhBdnYdl4EsFWMxwDYea3mcgs9kEw=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM5PR1101MB2298.namprd11.prod.outlook.com (2603:10b6:4:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 16:28:20 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f890:381e:1e24:a6d9]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f890:381e:1e24:a6d9%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 16:28:20 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "M, Naveen" <naveen.m@intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>
Subject: RE: [PATCH 3/4] ASoC: intel: sof_cs42l42: add support for
 jsl_cs4242_mx98360a
Thread-Topic: [PATCH 3/4] ASoC: intel: sof_cs42l42: add support for
 jsl_cs4242_mx98360a
Thread-Index: AQHXWm+BSRbfqtjemkyMcQgR/Pdi8asIkI4AgAAMh9CAAAThAIAABbjA
Date:   Mon, 7 Jun 2021 16:28:20 +0000
Message-ID: <DM6PR11MB364231AEC2208EAF5F898B7A97389@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <20210606004102.26190-1-brent.lu@intel.com>
 <20210606004102.26190-4-brent.lu@intel.com>
 <505c7e46-316c-9fa1-feaa-115f4561ed19@linux.intel.com>
 <DM6PR11MB36421AD935E4A2B8EBD0FE6197389@DM6PR11MB3642.namprd11.prod.outlook.com>
 <cb76f83c-e9d1-9726-ff8d-8d48a4de8e26@linux.intel.com>
In-Reply-To: <cb76f83c-e9d1-9726-ff8d-8d48a4de8e26@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: db7bdebd-f623-4084-0e66-08d929d1437d
x-ms-traffictypediagnostic: DM5PR1101MB2298:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB22989CBC73D67C8F44465AC397389@DM5PR1101MB2298.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34Woug30reUxyHDjEDwSd1NhSjw2/SqtL2dPJPgSjpTkKj9Jn2p4uyLNorDaTix3S0lq36cXAcYF11TWBIrg4e1+cyWBHfRQlr9lDH3SuBe78I87BuDIrqPuuJ5xqfcDx5kYSE6uny8yyzs+7pVSr+E+hkyWQ2kJT7ijDNzjROvqfHwULEBhxdnyUW77buPNrhzxxTACUkyityI7AMKD2cJ12utSw4OSdFrnyuFu4y5Vvz2rM/YZ9fz20IrGCM5XWJ+QGi2xlKIr29u2rGYl2bEVRxEDn34Y9dMYyxYK+65nkdvnCmZnsxwXshILl82ZZgQAU7xTMMIXMejBVwAHVwjeg6gRiVdcnVS3VxrvacHhDvS/gOiSAyC7na4mBJBaFoplrftOdQMy8JJWNq8NF9Nc2ipXoH49mHtxkGO7foh5uqmLL5zmwe9M7AxbAj33e9ssyzZG031p9hUSLgsLTdufzR0xjzgxZI+VA/eGQTTUNj2Ybt+k8weMAym9lvHJQB9DTUhN1xn1RoEhUeEvMQ8AeTNrVmmMVB/qNkGDHhLXU9ZYyUWGWzWpWofWw+gV+0v834vo+zLkMM9mP/XGj0S7BfGamJCzdZIbOuse+54=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(122000001)(8676002)(9686003)(38100700002)(55016002)(498600001)(110136005)(5660300002)(86362001)(2906002)(8936002)(4326008)(54906003)(66556008)(66946007)(66446008)(71200400001)(76116006)(7696005)(64756008)(66476007)(52536014)(26005)(6506007)(186003)(33656002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZW1JWXBUdHBjdk9OUC9iVVZzMHQ5Y1FOTlN4d3pIRVV1SWFJaksyWSt2RGI2?=
 =?utf-8?B?VzgvYkJwMWk0TEM5cHhwdElRM1d3YUR1SUwwYllyTGlpVnMrM0pZVUpFVlRZ?=
 =?utf-8?B?eU9jMi9RY2xkUzc5cVpXQjNXNytBUm9LdkhnV25aeXBKSEJKemZiTW9uQmVo?=
 =?utf-8?B?ZnVRR3JvRFEvTWdENkFXa0I0OUJucGhEWk9aUW9GUXk1alYxanBJZktKM1p6?=
 =?utf-8?B?b01hMG5xUEZXZXhERWcrR0VQbVRYUkg3NnloS0ZLOWNyUjg2eDRmTVh2bFJF?=
 =?utf-8?B?LzVVZUwxMnNBMGIrcUFUWUZkR1pjNGJlQWFpS05NRXpDeXRyNFFRemh0NzU0?=
 =?utf-8?B?Ryt3cUkzek9FV3RJOURtNlkvSU1yaG5ZcGNSaWxoNjJuQkNwNHlDcDlPZ3pk?=
 =?utf-8?B?dGJQTkJlZk1CV2lSeE44N3pGM0JGdGhCMTR5RkN6eFY2Yk1nK3hmaVB6Wmhw?=
 =?utf-8?B?QnBQb1RTNFJhS3ZNeWxKeVJkR2xoQjJVU3dWYTFWM3hxdmxoSUc0bEJmTU16?=
 =?utf-8?B?eDJqM2NYU0FoVXBlaElNL0RvV0llMzM4VCtvL1pnVXZPaEVzeUt1eXBQZzZI?=
 =?utf-8?B?eUIxQTFNNzJiOHlqZ3ZiU2tKMGdvNWVDeFRoMmJuL01Ec2tKWWovdzhsNEdJ?=
 =?utf-8?B?RXB2YmpoMW9Ua205NXdXbTNXUGVBUWJ4RGlSYVIyQ0ZhZkJ1dmVib1V3Mnhr?=
 =?utf-8?B?NDBRQnFPQUxZa2xlY2w4bFlRWTVGZnRLbEYzMFY1aXVDRGdWdEIyOGJ0VWRr?=
 =?utf-8?B?ZkJTdWRyclh2cngrRVVGYzVHSWU5QkI1L3NHVjN3cXFDdDJLenJnR21qNS80?=
 =?utf-8?B?SEx0K2hVcy9XU3JTS3ZoRHhheXUyaHFYZVg2WnFJVWRTZmlodUNxMjgza0x6?=
 =?utf-8?B?R0lpVTMyeC92ZXJ6cFBRM21NUmdzRTNXQk5Sa25leG1mVkdJRHYzbGxKTmRP?=
 =?utf-8?B?Y3EvNk4vNGY2bk1YZXJGOThpcHhUeUl3R1dJQnhPQjJPQmorM1lyNkxOdUps?=
 =?utf-8?B?a3hWVytad1czd3B1bkpiZ0U4cEVTMjJYZEdVM1pPS2UvcXJSS2ZPNkdWdTFy?=
 =?utf-8?B?V0xVeXJlVzNiQWN3dENqajlnS1huRTg5TC9DN2JmRWhvUWdwYnMyL2NBd083?=
 =?utf-8?B?ZVNQZ21TZE1oZk5WbzRmOVR6MzNndGtxVEZVVzk3SGZKRXdEY0lZWVhsNWFh?=
 =?utf-8?B?bk9KUnhIeldRSFdIaE9hekEwTmpFNWM2aXNWY1NpekpsbXVhcnhxWWJxNllj?=
 =?utf-8?B?OG9KTXdPdnNvK3ErQURmbElTVkdWem16RnlKMmVWWno0TGdXbGVhZUhsY1hu?=
 =?utf-8?B?YkJHamM4RHJMbzh1NjVtaG1uNU14cDlFRVA2WWhkdTY5Q0JYZC9OdHBWVXps?=
 =?utf-8?B?QjBSQTJmQVptTDlaRi9JUU5UanVQMTMwTzZCaldKMmQybGgwMVdwY1lpVC8w?=
 =?utf-8?B?bHV6U0VaeEZHWHVpNndqZ1U3OHI3ZTJNUmZ1alhIMzJ1Ujc3bGIyTFVXTEky?=
 =?utf-8?B?c0szbTBMTmJlSjhOQW01RHJnMEJDa2FRd0NzTXMwTC9VKzRFcXJaMlg2S015?=
 =?utf-8?B?TkZ2eVpFM0JBcFc2aHhmb3JaRSt5WFNERVViM2FmLzBONk9QZUhLVVFOZVlX?=
 =?utf-8?B?Yjc2allrS2tFcTVKUzFrdXJISkUvMUsvZ2V1bGl6SU8zRVBVQnhrdWQ3Vzgw?=
 =?utf-8?B?eDNtTnEzRVBvc0JxbGZTQ0t5TnhSMWtjWWxVVzlUV0hGZDljSHFnY2xueWpT?=
 =?utf-8?Q?p1NjOYyDHTcfYUNnbw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7bdebd-f623-4084-0e66-08d929d1437d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 16:28:20.4470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBbexYdFGOPTw/nwRt/+dfw5BdyDDLCpSFjbIASOOPusn54x1bsgiWQlkNoLE9jiW72Ha9u5u52mKLDhQTc/CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2298
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pg0KPiA+PiBUaGlzIGFsc28gbG9va3MgbGlrZSB3ZSBoYXZlIHR3byB0b3BvbG9naWVzIGNv
bmZpZ3VyaW5nIHRoZSBzYW1lIERBSXMNCj4gPj4gZGlmZmVyZW50bHkgb24gZGlmZmVyZW50IHBs
YXRmb3Jtcy4NCj4gPj4NCj4gPj4gV2h5IGNhbid0IHdlIHBpY2sgb25lIGNvbmZpZ3VyYXRpb24g
dGhhdCB3b3VsZCB3b3JrIGluIGFsbCBjYXNlcz8NCj4gPj4NCj4gPg0KPiA+IFRoZSBjb21tZW50
IGp1c3Qgc2F5IHdlIGFyZSByZXVzaW5nIHJ0NTY4NSdzIHNvZi1qc2wtcnQ1NjgyLW14OTgzNjBh
LnRwbGcuDQo+ID4gVGhpcyBwYXRjaCBkb2VzIG5vdCBjYXJlIGFib3V0IHRoZSBkYWkgc2VxdWVu
Y2UuIE1heWJlIEkgc2hvdWxkIHJld29yZA0KPiA+IHRoZSBjb21taXQgbG9nLg0KPiANCj4gSSB3
YXMgcmVmZXJyaW5nIHRvIHRoZSBiY2xrIGZyZXF1ZW5jeSwgb25lIGNhc2UgdXNlcyAyLjQgYW5k
IHRoZSBvdGhlcg0KPiAzLjA3Mk1Iei4NCg0KVGhlIDIuNE1IeiBzZXR0aW5nIGlzbid0IHJlYWR5
IHdoZW4gd2UgZW5hYmxlZCB0aGlzIGNvZGVjIHNvIHdlIHNlbGVjdGVkDQozLjA3Mk1Iei4gU2lu
Y2Ugd2UgYXJlIHVwZGF0aW5nIHRvcG9sb2d5IGZvciBQTEwgaXNzdWUgc29vbiwgd2UgY2FuIGNo
YW5nZQ0KYmNsayBmcmVxdWVuY3kgdG8gMi40TUh6IGFzIHdlbGwuIEhvdyBkbyB5b3UgdGhpbms/
DQoNClJlZ2FyZHMsDQpCcmVudA0K
