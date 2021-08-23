Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9842F3F44C4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 08:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhHWGDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 02:03:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:38885 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhHWGDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:03:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="213910062"
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="213910062"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2021 23:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="463972138"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2021 23:02:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 22 Aug 2021 23:02:17 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 22 Aug 2021 23:02:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 22 Aug 2021 23:02:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 22 Aug 2021 23:02:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lkt4r1FSP3G6Bd+ZiTEnDnqHUY5n5n4a0+0yZxIIvERLBhYg025xphUw99cXo1BvwsvyOuzdyKNHQJmNmIe5Jkh2Fvem20oVqU/E1Aw5ULH9FPZ/sjUrHSSH8t5yhGpoQh+RxCYT1XAGU6I4n9khpl6lgIEGBXjwxONH2O9Bo5ZFzidOH7B/B9+p1/ZCIRaGVETBdLR8puCsXuW1GnK/aZy/l5rEEftNLO5AC9W03T5srMNDTMp0Sojfwiqbbz+KFk6fg1iwBLmfZRAxDOxUvJYdUHRVOnR+qLxb7jgaL1w0IzlUI4eklRDSTJldBmLiNr6p9XjdQ6VPofKKB2QCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqwDGgNF2mMWtTZTxT0XXG6oD35XKMkoFQ6u1h9fROs=;
 b=aKMfCzS4Bi1WzQry0rBh0CM8VILmiJEZmEFzlV7R57DCN9D64bQ4xRVjXhFedFk6Y4XLttjMRdKLygyUJELqSK81C5Gv1/SDs8fu799B8pjIf8e5SJd+zRdBLxipI7LP/FBA7ldzNU3EVw85VPuCkV6T7MpWNShzi5xOPEI3KMbSenYpb4ljidWV3UzFTmyYhJQ5ZwALx+/qK0nOe/GbGUezcO1mGh5WKNbMjYDdl351Nfb0ZMB57k9Oib9sGuh3wOfG1QbwyNeXcLnpcjXvb3K0klm4aUVMPyg/PF4EU7B7R4OVq3VX8GKeYhkPZVeRzRiG9oZZ6ZvoP9dTj8TUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqwDGgNF2mMWtTZTxT0XXG6oD35XKMkoFQ6u1h9fROs=;
 b=nfc0HfK2NOCO658Es6xCEcqbGoq+2W3AF1Kg6ABUQ/8WdxqAaa8FuC+5A7fkriSEAtdDIR1Z7X9IDYxNUo3BOobVSYYBByLwfQ+cmZwYVHR/uf1MucppSiVvNv7sn+2eVSLb9+8AlceMoP3WMZ5FfahixXgmNxB2+ZL2TH3T+Rw=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by BYAPR11MB2983.namprd11.prod.outlook.com (2603:10b6:a03:88::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 06:02:08 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 06:02:08 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Topic: [PATCH v5 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHXhDwnISnVoEGfdkW14/liUG7Tv6tg1zUAgAH+PcCAACl8AIANLFFQgBCTgqA=
Date:   Mon, 23 Aug 2021 06:02:08 +0000
Message-ID: <BYAPR11MB3128DFAC405C1DAC5FD805EEF1C49@BYAPR11MB3128.namprd11.prod.outlook.com>
References: <20210729053937.20281-1-shruthi.sanil@intel.com>
 <20210729053937.20281-2-shruthi.sanil@intel.com>
 <YQh1HMMkJyO8g/RP@robh.at.kernel.org>
 <BYAPR11MB31281638EBA0C2B815DF56F9F1F19@BYAPR11MB3128.namprd11.prod.outlook.com>
 <CAHp75VeAnm-9oy5BinY8DU5tRj0EhU_vVxkvcp0M+wXPSv8Wdw@mail.gmail.com>
 <BYAPR11MB3128F143273F060C33DCA9C8F1F99@BYAPR11MB3128.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3128F143273F060C33DCA9C8F1F99@BYAPR11MB3128.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c113bbfc-2b7e-4cf6-20aa-08d965fb8a5a
x-ms-traffictypediagnostic: BYAPR11MB2983:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2983F94A7EE1EF335A303985F1C49@BYAPR11MB2983.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6u0tMiU7woEsqhTf51saEVNpgGxdV8o26lovGWBsY4xAvjfUCc28EMSTT4rpC/vAgPklXdWt3ZLdC7A8F2MPB+wiWZqKAxS5J6v2QKuAJ87aU5unX29zg3mF4OECHZOlZPy1LTduiS22FgjDDgkDgWbtX0W4Mr2GRnGodBj2pyEEdZmSzYTZ0639lf/FLqNx454YbzoePR78oe3zEAN2FHdJG53lud6vUefAvM4My6a4+11m59xXdsfwXfgxyNtewRQbiLbLFkLhpL60Vea9d8lSzQ7rBgHRMHwduVL8ZGZfUHp7/ez6tJQIOy7uLc/I8qig6Ix1cTN0lH/sRFQ89ZMEQMlFl6npcLPt6oRBtJCOkRHYCqjTZM8lN3dg7jgiuRxMv5P/kQbn0eOZX3iLpcweTJrvk3qf41JYJRKCvj87q3EpkpgsUlQTeEuU5gGjyI4U/DhcO5waKPUXll2hMsEoSatDeyOGkKWQVBFGB3FkCFdjMyfS5wWKJmneErBs1avR0NYHCnbcyTN1N76Ft3OodpGAwJ8B8Xvbkzm1BOpfXXDDmXfiqEjLBvo1JRmtEnGRxvByff1QpCsleyAtdacOYA5vv+lwLKKZtrqmQ9F5DfuPoGU4VR11qPA74sERcGifZdIL1RrOiu6hMxdSXv4b3oca4jhJbpBXevLDc/OGRHooMJ0kKKq4leq/ViH080QSExA0MKHcJw0APwfy9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(4326008)(5660300002)(52536014)(9686003)(76116006)(66556008)(66946007)(26005)(8936002)(55016002)(71200400001)(478600001)(8676002)(110136005)(64756008)(66446008)(316002)(66476007)(83380400001)(122000001)(38070700005)(186003)(2906002)(86362001)(38100700002)(54906003)(7696005)(33656002)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3NmUjZKRnF5SzhQdERhMEM4UUMyVS9hVVNDUnkyT0s4U2VuTlJHaFY5bGov?=
 =?utf-8?B?c1FlN3UxTDBtd1I5aFZ6ZE1TQ1ZqZlExYkdlNGZsMnZmdjBCNE8vZkZOeFBW?=
 =?utf-8?B?eE81R29YMTh2aUJVUGtWUllGSUtmb0M3Y1B1NVFxUUdZNC94UXVYeGR4NnhJ?=
 =?utf-8?B?R25GL3kyd0RVR1R6R1BoaitaTHhCaUFwaE9KTTdCRm5qZzFtcmh6eEt2TU1D?=
 =?utf-8?B?MnlXaFFXSFdhR0Y2YUJaK2lCYkhSUHJ2ZEZNN3J6cDdyMHQ2S1hjNHJBaEJJ?=
 =?utf-8?B?UGpDcVJnSjNBSkhwb0liL2JiMTI4ditQYW5CMWR3MGlsQnc2MjJWSWtCWVA0?=
 =?utf-8?B?WDJzSmFTSStNTFhxS0NiRU1LTTFyZC9GMFd5YjJreVJTVUlCRVBFc0xzNGJv?=
 =?utf-8?B?aTdBLzlhRnZPTm12bjNwQmVUcVVLQnZoWmEybkxDZlBkUnRmbG14QTdPaDBS?=
 =?utf-8?B?SHBsWlM0K1Y1YjU4eEMwallrTmZWK0VIKzVOejI2U1NXd3g2ckx5bXJDZDdD?=
 =?utf-8?B?OFdna2grQVFmUCtGVmlrV2FDWlNvbkJIRXV4anZhaWxlSVdITUJXaEN6QU9W?=
 =?utf-8?B?cWlDcGNaNk5CSG9Mc2tvd3MxcnRELzgwcHF0R3h2Rit4N2JjU2lBWkh1QXFW?=
 =?utf-8?B?Zy9MamY5d1VVODdPVWxjS1FBNG1ZQm41SUdHOE5QZG5sWWI3WWc4c0ljVW81?=
 =?utf-8?B?L1htTDVYQi9HaktUOG14T0MzYm1LOE9UdzJVc0N6emdkTzcxMFk2S1BCNXRR?=
 =?utf-8?B?SkRXN1hybXV4Sk1zN21kZDA0R1RWTUtoNzNhTUdVUlZuVnIvamhOMTBkbitX?=
 =?utf-8?B?RzNUdXYwa3hTeUp5U2t3bVlhYnZ5U1Z0VlVQMUlVenpyb1l3c2xPMDRzM0JV?=
 =?utf-8?B?dDd3ZldrWlpJeGNLeVE0NTNYMUU3SGExK3d3WXU2SEwwVnd4cXNsWlpNdkxp?=
 =?utf-8?B?MUNCMmZyTkd0WXp5TDBuWmFXbGJFZFZEekIvcEcyaTZ5VXI1YVFiTTZjbTRj?=
 =?utf-8?B?bm8rSXRCOUNxMTJOeU9GcFlGbUZUdWg1UUNBK0gvbnJwem9TMXBPS2FUWWFU?=
 =?utf-8?B?eFQ5WXNtTFVnZ2ZST3hib2hWWVhoTXBIYTB3QlBxcllWR3dnUG5nNGRjRmox?=
 =?utf-8?B?cHZhUWdDQlFwaS80Z1FJNjZBdjZCNG04QUNmRmNVQVBiVHovVjBVV3E5Nkg4?=
 =?utf-8?B?VDQ3KzAzY0xlQ2FoRU4zR2pOYkUwWkdxbnQ3WE04L1B0T3kvbUo0UkdtNG1N?=
 =?utf-8?B?emVEbGN0bUs3Y1dsT0hNRC9hWEQ3Ynk3LzBQYzFTZFVxMXBtSGNNWGJCZjBq?=
 =?utf-8?B?dno0V09KQ1lpQldrUGdkOGN4M3FLNlhpbG1DTnBWRlo5V2ozYkplcHhGcHFn?=
 =?utf-8?B?OG83L2h3Y2cyUUFnWVptWXRlUmNRRnpqNDdRcTNUTklCVEFFdG5FVTdNcFda?=
 =?utf-8?B?cXFGMWRSUjB4d3lzZVBoazMxeU53b3U2UFM4OS8vcEhTb3lIK1lqSEYra0lR?=
 =?utf-8?B?YnR2K21OZVJiczRmaFNjN1dNaHNLWTU0N296d0VyQ0orV0c5ZExTRG1xVFlk?=
 =?utf-8?B?ajFKV2RUb0g1MGhLYkhrWjlMdG1WdnY5aDJ5WnVJdWVmT1phQ1d3TVdTRit1?=
 =?utf-8?B?Skk0SjV1enQxRHlkYUlBWU1Bb09ScVByOWhKaVYvLzIrdTgrQ0xRcURlOHRP?=
 =?utf-8?B?R2l3ME8velp5d21iY24zZDRwdzRTTzF3dTVhTklUbmxMeHRVRDdZZ0QrY3Bk?=
 =?utf-8?Q?mqckIz8weXZWk76pjGPuIdioENkjI40sCmumyCb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c113bbfc-2b7e-4cf6-20aa-08d965fb8a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 06:02:08.1115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJwrq84B3+4W9W1dv3lH81/EsUakycGdF8jtWBUbmX91pBtMLVayQWz5qjXVQHRjB/95J588GXqYfFCs0KdJnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2983
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYW5pbCwgU2hydXRoaQ0KPiBT
ZW50OiBUaHVyc2RheSwgQXVndXN0IDEyLCAyMDIxIDEwOjE5IFBNDQo+IFRvOiBBbmR5IFNoZXZj
aGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPjsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsNCj4gdGdseEBsaW51dHJv
bml4LmRlOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOw0KPiBrcmlzLnBh
bkBsaW51eC5pbnRlbC5jb207IG1ncm9zc0BsaW51eC5pbnRlbC5jb207IFRob2thbGEsIFNyaWth
bnRoDQo+IDxTcmlrYW50aC5UaG9rYWxhQGludGVsLmNvbT47IFJhamEgU3VicmFtYW5pYW4sIExh
a3NobWkgQmFpDQo+IDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGludGVsLmNvbT47IFNh
bmdhbm5hdmFyLCBNYWxsaWthcmp1bmFwcGENCj4gPG1hbGxpa2FyanVuYXBwYS5zYW5nYW5uYXZh
ckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjUgMS8yXSBkdC1iaW5kaW5nczog
dGltZXI6IEFkZCBiaW5kaW5ncyBmb3IgSW50ZWwgS2VlbQ0KPiBCYXkgU29DIFRpbWVyDQo+IA0K
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0
IDQsIDIwMjEgMTowOCBQTQ0KPiA+IFRvOiBTYW5pbCwgU2hydXRoaSA8c2hydXRoaS5zYW5pbEBp
bnRlbC5jb20+DQo+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBkYW5pZWwu
bGV6Y2Fub0BsaW5hcm8ub3JnOw0KPiA+IHRnbHhAbGludXRyb25peC5kZTsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgYW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOw0KPiA+IGtyaXMucGFuQGxpbnV4LmludGVsLmNv
bTsgbWdyb3NzQGxpbnV4LmludGVsLmNvbTsgVGhva2FsYSwgU3Jpa2FudGgNCj4gPiA8c3Jpa2Fu
dGgudGhva2FsYUBpbnRlbC5jb20+OyBSYWphIFN1YnJhbWFuaWFuLCBMYWtzaG1pIEJhaQ0KPiA+
IDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGludGVsLmNvbT47IFNhbmdhbm5hdmFyLCBN
YWxsaWthcmp1bmFwcGENCj4gPiA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVsLmNv
bT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvMl0gZHQtYmluZGluZ3M6IHRpbWVyOiBB
ZGQgYmluZGluZ3MgZm9yIEludGVsDQo+ID4gS2VlbSBCYXkgU29DIFRpbWVyDQo+ID4NCj4gPiBP
biBXZWQsIEF1ZyA0LCAyMDIxIGF0IDg6MzUgQU0gU2FuaWwsIFNocnV0aGkNCj4gPiA8c2hydXRo
aS5zYW5pbEBpbnRlbC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gPiA+IEZyb206IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAzLCAyMDIx
IDQ6MTQgQU0NCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4gPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4g
PiA+DQo+ID4gPiA+IFlvdSBuZWVkIGEgJ2NvbXBhdGlibGUnIGhlcmUuIE90aGVyd2lzZSwgaG93
IGRvZXMgb25lIGtub3cgd2hhdA0KPiAncmVnJw0KPiA+ID4gPiBjb250YWlucy4gQWxzbywgd2l0
aG91dCBpdCwgdGhpcyBzY2hlbWEgd2lsbCBuZXZlciBiZSBhcHBsaWVkLg0KPiA+ID4gPg0KPiA+
ID4NCj4gPiA+IFRoaXMgaXMgYSBwYXJlbnQgYmxvY2sgdGhhdCBoYXMgdGhlIGNvbW1vbiBjb25m
aWd1cmF0aW9uIHJlZ2lzdGVyDQo+ID4gPiBhZGRyZXNzDQo+ID4gZGVmaW5lZCB3aGljaCB3ZSB3
b3VsZCBuZWVkIGR1cmluZyB0aGUgaW5pdGlhbGl6YXRpb24gb2YgdGhlIGNoaWxkDQo+ID4gbm9k
ZXMuIFRoaXMgYmxvY2sgaW4gaXRzZWxmIGlzIG5vdCBkb2luZyBhbnl0aGluZy4gV2UgaGF2ZSB0
aGlzDQo+ID4gYmVjYXVzZSwgd2UgaGF2ZSBhIGNvbW1vbiByZWdpc3RlciB0aGF0IGlzIHJlcXVp
cmVkIHRvIGJlIGFjY2Vzc2VkDQo+ID4gZHVyaW5nIGFsbCB0aGUgdGltZXJzIGFuZCBjb3VudGVy
IGluaXRpYWxpemF0aW9uLg0KPiA+ID4gVGhlIGNoaWxkIG5vZGVzIGhhdmUgdGhlIGNvbXBhdGli
bGUgc3RyaW5nLCB3aGljaCBpcyB1c2VkIGluIHRoZQ0KPiA+ID4gZHJpdmVyLiBJDQo+ID4gaGF2
ZSB2YWxpZGF0ZWQgdGhpcyBvbiB0aGUgS2VlbSBCYXkgSFcgYW5kIHNlZSB0aGF0IHRoZSB0aW1l
ciBwcm9iZXMNCj4gPiBhcmUgYmVpbmcgY2FsbGVkIGFuZCB0aGUgdGltZXJzIGFyZSBmdW5jdGlv
bmFsIGFzIGV4cGVjdGVkLg0KPiA+DQo+ID4gSSB0aGluayBJIHVuZGVyc3RhbmQgbm93LiBUaGUg
cHJvYmxlbSBpcyB0aGF0IHRoZSBjdXJyZW50IHN0YXRlIG9mDQo+ID4gYWZmYWlycyB3aXRoIHRo
aXMgYmxvY2sgaXMgaW5jb3JyZWN0IHNvZnR3YXJlIHJlcHJlc2VudGF0aW9uLiBXaGF0IHlvdQ0K
PiA+IG5lZWQgaXMgdG8gY3JlYXRlIGFuIE1GRCBkZXZpY2UgZHJpdmVyIChmb3Igd2hpY2ggdGhl
IGNvbXBhdGlibGUgd2lsbA0KPiA+IGV4YWN0bHkgdGhlIG9uZSBSb2IgaXMgdGVsbGluZw0KPiA+
IGFib3V0KSBhbmQgZnJvbSBpdCB5b3UgcmVnaXN0ZXIgdGhlIHJlc3Qgb2YgeW91ciBkcml2ZXJz
LiBUaGUgZXhpc3RpbmcNCj4gPiBkcml2ZXJzIGZvciB0aGlzIGJsb2NrIHNob3VsZCBiZSBjb252
ZXJ0ZWQgdG8gTUZEIHNjaGVtYS4NCj4gDQo+IFN1cmUgQW5keSwgSSBzaGFsbCBjaGVjayBvbiB0
aGlzIGFuZCBnZXQgYmFjay4NCj4gVGhhbmsgWW91IQ0KPiANCg0KSGkgUm9iLA0KRG8geW91IGFn
cmVlIHdpdGggdGhlIGFib3ZlIHByb3Bvc2FsIG9mIGNyZWF0aW5nIGEgTUZEIGRldmljZSB3aXRo
IGNvbXBhdGlibGUgc3RyaW5nICJzaW1wbGUtbWZkIj8gDQoNCj4gPg0KPiA+IC0tDQo+ID4gV2l0
aCBCZXN0IFJlZ2FyZHMsDQo+ID4gQW5keSBTaGV2Y2hlbmtvDQo=
