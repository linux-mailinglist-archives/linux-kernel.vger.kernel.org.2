Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EC83EDECB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhHPUvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:51:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:41018 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhHPUvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:51:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="215938347"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="215938347"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 13:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="448818954"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2021 13:51:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 16 Aug 2021 13:51:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 13:51:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 16 Aug 2021 13:51:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 16 Aug 2021 13:51:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Idk7MBFC3tyf/2pO7voDiT+bB4CYqDuE+yoFzMadfcjbxszas1SY3PhUm518NcVJCLJMZ07Kcw1DMkiM8ahnjpXY5JSXPVyyNZww2GWaWm5SE6cnfyguc7098vUyEAuJZalkuqbgqeL9CEEAGlyt+FFyONt3+y+UMnoIe1xWYHKzFdO0ejATps939a0a8vxTTIB3VWffs4gSPa/x8PoI5SePlbPqYiJq4U2H3oe0IyZqSPhw7ownn2EU7VGy7f17Fhhfx94bPneLcBA8U6830nNmIQqREmOnXvH50/Q7mMqt2nVM3OarLVZ13j1ikqduMeFXTnAFfAzTue+CCRVngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HADgDTtyChRMoTvjQ0GAQ0EySXRTDQdX+nXqUhVI/U=;
 b=JlMaJi4S5/LOIgVAv5Of8CXIh1C+edrtaq8kAN8S3KcEfZec9lMWIbn6mCYv6wqRI6h0sPrC2HWeJ3SRG5nftGTemMSjNHa6fOG3e1BM44EUHLM4z312PiVVqlsXdWyR4UAXRdhfFRbD0gvTvHRpUYx5G7V2DwIjwjr2VZoB0/oOlHxw4B5OjqQJMIwW7WF0meZUnqP2+91ZiV8YzEDrgNunLRjVkFIBpAToyJfEKkFOr/a5Qc6p1WwjD/rgpkYlCkVsN95v6AL6pWcQB8Kqhk+OPdH4YTkvaaMNBOFj/bPvp2oAtwdPjlGFO1+M7oVf6K1aZSCEWQfQhx1J6YNLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HADgDTtyChRMoTvjQ0GAQ0EySXRTDQdX+nXqUhVI/U=;
 b=n2hMeHWvNpk68t0W2om1F2Ti7ffIwVENnrPK5hvQl31Bc8XBSgglJYZHjI2WrVTfM0vekSuFAoZm3+WIL+zsbEsYcnqvngwY/ajRcV+pr0arBDt/q1gLilYoffATjdWvHwx0uYoCaSdCrL9utUpb1L4ZvIJVSpzga4PKwEPXFBA=
Received: from MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16)
 by MWHPR11MB1967.namprd11.prod.outlook.com (2603:10b6:300:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Mon, 16 Aug
 2021 20:51:14 +0000
Received: from MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::c5d2:7f65:9e5b:8f96]) by MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::c5d2:7f65:9e5b:8f96%8]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 20:51:14 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rajneesh Bhardwaj" <irenic.rajneesh@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Qin, Chao" <chao.qin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "Alex Deucher" <Alexander.Deucher@amd.com>,
        "mlimonci@amd.com" <mlimonci@amd.com>
Subject: RE: [PATCH v7 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
Thread-Topic: [PATCH v7 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
Thread-Index: AQHXksCEeOYy2Rlf7kO8G/jc8wYLmKt2hSCAgAAWL0A=
Date:   Mon, 16 Aug 2021 20:51:13 +0000
Message-ID: <MW3PR11MB45239757C4BA080700537DEEF2FD9@MW3PR11MB4523.namprd11.prod.outlook.com>
References: <cover.1629091915.git.gayatri.kammela@intel.com>
 <81b6292e50af54fb7eeabfefde6f4a3d283b0b96.1629091915.git.gayatri.kammela@intel.com>
 <CAHp75VegAcEeWQXPfufcDC1cHLbC3JRsChm2zKATGWnYWfGEfg@mail.gmail.com>
In-Reply-To: <CAHp75VegAcEeWQXPfufcDC1cHLbC3JRsChm2zKATGWnYWfGEfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.100.41
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f88e4f2f-b30c-4eea-6fc2-08d960f79611
x-ms-traffictypediagnostic: MWHPR11MB1967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1967E4A57C17102108076F1FF2FD9@MWHPR11MB1967.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFvV+I6XBr6LTmtbSiQxAnSHD74SwzEY1FsNX9KYGhglktdCh8qR6Mws02urwaB9i4ct2ZtIuv75glHUirD6GqFruEI0mtmhGcxYs3lQoGvA0EHRbTOc1BLcYpi6aQm2psfEVeyX9/evGyPsd0YlBgGRt1O+SiR4RSdpDj1Q7gDC1p2jS3qvx7HX2H5mhuLVZTzxkT5pD5NDkEuaIY0a6whW4+gvsAVpQW0h0W2t7W8t4Js+a89uwGGWXa0zJRSqiEDblwIq3aw5Hplc4rvotOOcjrbJw9I/81QlVLBrWLotCdma8g2QKJM9TJc3lGlbokNmSKt3m16sj9D1ECDSvJCdc99Zz4VrmzNPG1Yi82O3wLV1eeJdyol4Fx4H87e1p1MiyjOulXSQ4l/lQ7xZjdY+lHMz/V0U4JsZEDjoiH1rw0ADlKQvKSfuMqZIlQNI4WK8YK0tQK2OiCF2OwVVNv88KLrAguQMLBzU4HxmULtDsP+qhMQY6TbVJEV0YAjwl1IiCBNPXktTZvu1wVGDisy18k/h+fvGoufUvkoUItkaoh2U2l9ZUeszOEUcGLdHtC/1olGmsdPtEeLp4GHsAmxRFaNRV52U4K6rBj7cMHfL6Wl5a1HvtL8ZNfkPF35DSa2Mf/sBcZous0RiwypH3G2nSPmAMZXwPy0SESWmV+tJNqC6pdKrrd2I9lbAYShBqPlqtlZ9cSPRmCmj9G/GSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(66446008)(9686003)(7696005)(4326008)(71200400001)(54906003)(64756008)(38070700005)(76116006)(83380400001)(8676002)(316002)(52536014)(66556008)(8936002)(6916009)(6506007)(122000001)(2906002)(66946007)(38100700002)(33656002)(478600001)(26005)(66476007)(7416002)(86362001)(53546011)(4744005)(5660300002)(55016002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZndkUnFoaisvNlhFRGZWK1R3Ykt3SGpKMExnbTBhTXh2RStpc3VGa0NWanYx?=
 =?utf-8?B?ajBMbTRGOGtlZUg5bUlvc3hLOFZXeGptb09QNzAvME4yYy9DZSsrYUQxV09S?=
 =?utf-8?B?a1VBWWJGNEhITktUZ0dEbTJjSjZNL1BONlQzSGd3U1NYVGVGeWgxWWNUT2No?=
 =?utf-8?B?Yy9yUVVYcUI4bmd4SW5pNHgvbGx6b1hma3FhRzRIL1BZVkg4dEhZZldNYXMy?=
 =?utf-8?B?L29PTkJ0MnJlS01Tc0hxWlFVczJ6NWd2ZUhmTnQ1UUVpYXIyL2ZuSkY3RHEy?=
 =?utf-8?B?ZTVsc0ExQncxMlVUQmFjWlVIeUZlM3liWEw4cC9sY0pBOENXYmg5WXNreVpU?=
 =?utf-8?B?WitRWE5XaGkyelhaTTAwZzZBRkQ4ajJsQ0hiQXFYdE42NDQyR0NuZ0l2UHJF?=
 =?utf-8?B?R2pLL2VVbTZMaEpYL2VSL1JZenljbmZYdVprb1dnZEVmT2dUbW5iZDlXbWVi?=
 =?utf-8?B?UEpNNm85MFJ6WllQKzNxVkdHRHFEeWFxTkZQT3l5elNJNHZEeDNYaktIZFcr?=
 =?utf-8?B?VGlVOWZteU1ub1h5eEZQUzMwWXZLYmV1cXFXZ0hkM2U1bXhKNUdzTzFFUzlD?=
 =?utf-8?B?RWN5d3hjMXV4M1lYVHdGOERJNWVUZWFET0VHZFVuMnVIMjd2TkszOElQN1h5?=
 =?utf-8?B?UGo3ZHZTTWFEbnFHb1ZPOWp3RCtqMEhlUzE3dDlaeWVERTB3SDdlWE1tUC9s?=
 =?utf-8?B?NGVkZ1EyelZaTnNHaUpIdFcrYkRzeGo2VCtGbUI5UVNLblBMSERSeDhnOS94?=
 =?utf-8?B?OGo0MmZYbjRlN21zTWMzWWp2bThIUldPSGZGc3BxN09IZm5pNnlUOGV5bnRz?=
 =?utf-8?B?WFNTVkZPSk82RUdublFia1FPLzlSYkVnTUdDYWVVaU91UDUxenNuc2NvTi8r?=
 =?utf-8?B?cGhvVUtqdGhxZ1BKL1dqaVRnemlSUzVuR3BiOFl3ZysxaTU3bnBVNU9VcENH?=
 =?utf-8?B?NzdBeUFwbDN3WjlIdUduZld2ejFPOFFJT1BVNDI5bDZOOFZHL2kyRk94RUx4?=
 =?utf-8?B?bytsLzRndXRjRzNVZ2haVFhCNWVtd2JhM09kaFc2Sjh2UEVUendFU2oxRXMw?=
 =?utf-8?B?UVRkSFgwSjhmVWhyVHRnUklMcDI5VGJOY1FXQVIrcjRxbVJGTWZMNFc3TGFE?=
 =?utf-8?B?b2dqRmpONnBGaUZoSWVmYnFKTmhXOU4wazRyRDFUV0dmK3ZTeFJXc0x6YVI5?=
 =?utf-8?B?RFVjbFZPMWY3TkRzbi9pTTNVY0MxTE5CVVVTZ0VWTHdUV3RQS2pLcC90empV?=
 =?utf-8?B?NFVKYm1ISGFxQXQ5Zm5FemJQdm1Xa080TGxIeUgvamNEZHVCdzhlbzhlem5i?=
 =?utf-8?B?ejFXbjU3MjdnY0dVb0kwMVBFNW81NUJJM0VVMHVnU2tGQnl1a3hhUXVvZHUw?=
 =?utf-8?B?UWdScWRVT0lvTWpoMG9yYitXNm0rMW5VTTFGN213eDJpNUt3WExMZGRPVkpw?=
 =?utf-8?B?alJiVXUvVzBETnFBUnZaVzlnd2NYeWMrRmMvVXdKQVFZdjZVYnNQUkh4aWFr?=
 =?utf-8?B?Rm5TQzh6UEpYQmg0T0xMTEphOElHYkVjZTQvNGVpR0oxbkhFL0VSVUlTUnFr?=
 =?utf-8?B?eURRczNLVlZXNjBSbjQ3QllTeXM0QXgzeGV4QXpxWDBTMkowT0RNaUZjMWxs?=
 =?utf-8?B?UTNrSTJ3S01qRGQ4enlxbzRnNndWdTh6MlFURytlWDVBZUdnWnJpbjBRbVZI?=
 =?utf-8?B?RVA1cFNodlIzSXIyZ0o1REV3UnRFMnFYSEdVZlF3L0xNd0RLVG1xVWNCSjlw?=
 =?utf-8?Q?NvPYUPeBq+Mx+5W8iU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88e4f2f-b30c-4eea-6fc2-08d960f79611
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 20:51:13.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmF7g4l9htAzdUzQ2Qe5jLN3WwO6QEnbNQItj+0ykkw4Gi53DzuhfqEsS95emvd7Wo+zjlLMpFeThk0M6Ew/zA88/IN9yLniZFIUXQPGoOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1967
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDE2LCAyMDIx
IDEyOjMyIFBNDQo+IFRvOiBLYW1tZWxhLCBHYXlhdHJpIDxnYXlhdHJpLmthbW1lbGFAaW50ZWwu
Y29tPg0KPiBDYzogUGxhdGZvcm0gRHJpdmVyIDxwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2Vy
bmVsLm9yZz47IE1hcmsgR3Jvc3MNCj4gPG1ncm9zc0BsaW51eC5pbnRlbC5jb20+OyBIYW5zIGRl
IEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsNCj4gUmFqbmVlc2ggQmhhcmR3YWogPGlyZW5p
Yy5yYWpuZWVzaEBnbWFpbC5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hl
bmtvQGxpbnV4LmludGVsLmNvbT47IFlvdS1TaGVuZyBZYW5nDQo+IDx2aWNhbW8ueWFuZ0BjYW5v
bmljYWwuY29tPjsgUGFuZHJ1dmFkYSwgU3Jpbml2YXMNCj4gPHNyaW5pdmFzLnBhbmRydXZhZGFA
aW50ZWwuY29tPjsgQm94LCBEYXZpZCBFIDxkYXZpZC5lLmJveEBpbnRlbC5jb20+Ow0KPiBRaW4s
IENoYW8gPGNoYW8ucWluQGludGVsLmNvbT47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTWFzaGlhaCwgVGFtYXIgPHRhbWFyLm1h
c2hpYWhAaW50ZWwuY29tPjsNCj4gR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz47IFJhamF0IEphaW4NCj4gPHJhamF0amFAZ29vZ2xlLmNvbT47IFNoeWFtIFN1
bmRhciBTIEsgPFNoeWFtLXN1bmRhci5TLWtAYW1kLmNvbT47DQo+IEFsZXggRGV1Y2hlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IG1saW1vbmNpQGFtZC5jb20NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NyAxLzVdIHBsYXRmb3JtL3g4Ni9pbnRlbDogaW50ZWxfcG1jX2NvcmU6IE1vdmUN
Cj4gaW50ZWxfcG1jX2NvcmUqIGZpbGVzIHRvIHBtYyBzdWJmb2xkZXINCj4gDQo+IE9uIE1vbiwg
QXVnIDE2LCAyMDIxIGF0IDg6MDIgUE0gR2F5YXRyaSBLYW1tZWxhDQo+IDxnYXlhdHJpLmthbW1l
bGFAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFzIHBhcnQgb2YgY29sbGVjdGluZyBJbnRl
bCB4ODYgc3BlY2lmaWMgZHJpdmVycyBpbiB0aGVpciBvd24gZm9sZGVyLA0KPiA+IG1vdmUgaW50
ZWxfcG1jX2NvcmUqIGZpbGVzIHRvIGl0cyBvd24gc3ViZm9sZGVyIHRoZXJlLg0KPiANCj4gPiAg
Li4uL3BtYy9jb3JlX3BsYXRmb3JtLmN9ICAgICAgICAgICAgICAgICAgICAgIHwgIDANCj4gDQo+
IHBsYXRmb3JtLmMgaXMgZW5vdWdoLg0KU3VyZSwgdGhhbmtzIEFuZHkhDQo+IA0KPiAtLQ0KPiBX
aXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
