Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BFB420460
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 00:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhJCWni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 18:43:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:52044 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhJCWnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 18:43:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="206048574"
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="206048574"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 15:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="557880768"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2021 15:41:48 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 3 Oct 2021 15:41:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 3 Oct 2021 15:41:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 3 Oct 2021 15:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCM19ixcBwlxtwIzFP6p6IA+z4a9UrxjwDuZ5+kiwuE6eWqKKiIFzbqy2dl7RQdj2UyJ7dXlfKsjrzIVkJaxSuwQWxeuoLvBIEIDp/1NqlY6d/dv9zDBopyQs5eAVaRuykGGYfEZZQ2E2jlES7GffWbmtqlbJHIY389OAxJf5MDUKBiGa89icNBdunTUVLro3w1lxR+o6HsAPgYtJ0iIheDL7KanF1wzRALA6Ttyw388HlE0ssvIczAe8q/YE9/OZ76iGz5Iymdju1wGOSG+Vk+RfVb9wTCKg3QHP6ZFuIP/JDHs930qLrn3uJ9oxWGwrl1yMNFadkDPWMnjbkmz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxsQeM+VrlTnEOSbE8/O1mZLIWdKf05NRlf4QxqWla0=;
 b=AtD6bWHfb3V/ktFqMZQHTSDQynBzZ0yxwGj4zQedUOha4cy0mVFtZJ186zHGwC5ZfJh0OC4cP2vNWYYq/rmbiWcCJvo9LnC0wHAZDc3hORHzD+Ex4Q4eHnNKw2nES9WK5ReuSx7oLrG+w43MQQXu2fyDfH45RR60skdTyjUoXXpdIXbSJsBrsaxwbgjGrt0ipEsghMv9XPT35f3SbuUb2jNg8EPRlNMj3XGhgDtU+XQdvzayy3M89JYWggTCia2krwXt6mVpxwAQxpPks+ewdBkK2zxINvd6v/8IG3odEJ//15/6bLlXFHduE3tG6aIAaCW44Y1NjFNley0ktOFeBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxsQeM+VrlTnEOSbE8/O1mZLIWdKf05NRlf4QxqWla0=;
 b=wQwie5qTPydvuR7Qcc4cPmAQemIOxzu/XR1EbNYQJKGX5vaE45wb6A3V3LjeIz+6T60LBtOHqnackTlo7/If+nkv/lBnpxSF/DVgdvnS6nbDVgPTRGL5C5KXyAqckTOHdpzZsXrt3JNgdkxS0glq/Lx4yFLVopK1hDMVDzs3c0M=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Sun, 3 Oct
 2021 22:41:46 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Sun, 3 Oct 2021
 22:41:45 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 13/28] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Topic: [PATCH v10 13/28] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Index: AQHXmcpyp/UMng9jvEuWIVdsREnfcKu+dzeAgAOk4YA=
Date:   Sun, 3 Oct 2021 22:41:45 +0000
Message-ID: <47D6E3AB-A3B6-4604-89A4-EBEF1F3AB026@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-14-chang.seok.bae@intel.com> <871r546b52.ffs@tglx>
In-Reply-To: <871r546b52.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb7e6d3c-8035-4982-c449-08d986befad7
x-ms-traffictypediagnostic: PH0PR11MB4774:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4774A79C0AD519EA36F634C8D8AD9@PH0PR11MB4774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: reEHQ7zFA2FyrGhX37JJKFx9Gec+2oBvk2Z74ZAt+0DRsoLZExyzbA6GCZW9rrMFznYpwtZkL0Qe7KMHAED6Na1hGtoQD+VhW9d0byf/qtDx5SdWF7pIyAwe9Twq5cSlSuZPZbj43HCRQXNrFJGfPEYC7H20KFNM7BJw08o/Wc4LGOEjyngMrRazxb0nZp9xb8L9hrb0+hFUaTC8VSuEuY6KHkAcFSGOq9grev85jzmPJGQXbwCk0fiHvUMPEK05+H13kxJNRz3B+JI77612ktta0Iax8pHf6p/4/rcFq709Hb7Idtuf+dijhFlYV9kM+bDxMxzaMEoV/m51ASLJfqmqqXNekYmNcZfm/Towqmb+74equBlrZpnYfsmUnKybFj82/RGddnAx7eMS8wVHcsrrLGcPTgE8pPHDTK7GweYaIC7eUn/itRJXdnYQLgsKMr4R4HsCmyUnWwLTRaUa79EWEIwGexb5kF4Bulqql9qtQuhFg8jdgUmB5vmEXZOxdcW6SBWF7DDeKEclBu/UBkCszxFt7CHOKnXlvQa6fVUQdVpIj0UJImyo5W7YY1X7NkTQ0WKd7DHabNf1/r0dQgl9EjPmv8GNsNWbJEsqkinzvGUMfG/2eucpqI/5i+C2SKuSxK0hirw9Zmr9M2iSHG9bdJJPDvWgxtpICe7T+/WfgJRcycOOFJALPGNYNMP4mz+eQ3DCSa1NGd6NegUnnhzOc6zKZ175XF13c/YQpLtw8Dtz8H2r26UHFA1samP7jkQE3Xq8kg2Z63318RHNL3K9BehA/nwrNlmb0N7thMv+iqY1jAMSE3IDdrlB1eg9UGlobQfdXvIZR4+B4CIe6/Pepv+z1VEaI0XDUuy6gugtaWBjBgNyiNJHEvtxiCSH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(36756003)(66476007)(2906002)(66446008)(8936002)(54906003)(966005)(33656002)(6506007)(53546011)(508600001)(66556008)(6916009)(38100700002)(6486002)(66946007)(76116006)(122000001)(86362001)(8676002)(83380400001)(2616005)(186003)(6512007)(5660300002)(4326008)(64756008)(26005)(316002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW5BOUxIVUowellzYlNJMXo3ZzMwdTAxUUdnbkI3R1J4bGVuTGh3L0RLOEwx?=
 =?utf-8?B?dDVQSmtEMVR6bW85dXhJUks0dWdYOWNRWERNc2ZMMVRqZHVOL0dPdzBpN1lo?=
 =?utf-8?B?Uy8xWEVRQWJUNU8zUDJRd2pGTUk1WGJyRjZ6anVSRUZUWDdpT0tqT0ZwRS95?=
 =?utf-8?B?VUMwVzJ1ZmVVWkE4ZlVQS0FGNll3Q0dRWWNoZE1ZbjBpS2lmZ2hHNDdaOGc5?=
 =?utf-8?B?ek5TMFNTL0tBS0pOVGNORm5Ib3I3d2VLZHV2Z0V5SmtObUVxYXZGSDFYSUlr?=
 =?utf-8?B?UnhTaGNaUWJKNnErZGdSZkpXRkJWQnMzbytndlhMN3JIOVdUM1MyYklrK3dB?=
 =?utf-8?B?RFZ5OHRIeUxrdDVGcWVyaGc3Z3NTWWJnWVl6YWFXVVBZRk4xV2dsdC9OL2k4?=
 =?utf-8?B?eVU2aDF6UTlieGx5cncraTVPUWZhcWMwV3ZYaCtORnEvRXpoMVRGd2VHNXBv?=
 =?utf-8?B?WU9ybmRsUGliRCt4UHoxZUk4Z0VmbFVrWUI5Z1hTMHRYMERWS2NqblB4YmFi?=
 =?utf-8?B?eSswV2Y0QzE0SlNwSldRMU9zOW5XamJSZThCcDQrRGtwTzQxYnRqYW0yQUsy?=
 =?utf-8?B?QU5sMUNkQTV4eHJYajhsZDlyWVRyVGh3dkY3Z0ZXakJadC9xcGlMNjUvcGcz?=
 =?utf-8?B?bWROWENUS0hKTnNHYmNzTDk3TzgyMUd6L3BvMmUxb2ZkaU1IRmdYdnM1WmVh?=
 =?utf-8?B?Y3YwTElXR1JrVTJRTEZoZnN2L3dUQjMzdGR5QkZFcWZtVFNrOFgvQWlBcXdH?=
 =?utf-8?B?QmtnZldTbWtXTnRrUUVYbzhYdUlsWDFvMk5EMEFRVlhCQ1R6SmhmR09JT3FG?=
 =?utf-8?B?ekg2cjlQMi9qZUxrR05xdDgvQitvM3BGV0V0aG9jejhlNHNNek5HQXJKS2ZL?=
 =?utf-8?B?UFNxTURURFVmQlZrb24wMVErRnQ3aDRMdjhyakZnL0JyKzNwL01JYzJ0Q0R1?=
 =?utf-8?B?VTNzVG9CTDVmeVFUUll6amZjVGRYODBKejlYMGMyaFJpTS9Fem9Ba09NeDlh?=
 =?utf-8?B?WnZPb2NpS1BBZVFGOTJWRmJsQ1JlRHBzZW54MzhaU21pdURFa0F0clBkREJv?=
 =?utf-8?B?cmtianNIU1RiQW5XdGd0OWtHOTR3MW9LMitLTGVtbFVyY1hFM2hPK3UwUlBV?=
 =?utf-8?B?ZjgrUE01RTFPWGxlSHFtbXg4RWhuQ3ZYb25wSGowSWJvbHpJNm5iVW9ZMUJL?=
 =?utf-8?B?UmZtNkx5NDd0bzVCbHVYZjJ1bVVsSFVjSktRaWFsc3FvbmszMER0NUxoclVP?=
 =?utf-8?B?ZERZZWEyai91K00yWnZCNWxSdTBQNnNmRE5QVVZRNUdBd2hHSitUT29vVVZW?=
 =?utf-8?B?dXFPVmx2WUFxQ2JTc0dIbHFRVEVRaWZPOVJZdHdQN2VnSWtyM2laQThMWFJ5?=
 =?utf-8?B?eitDem1wLzR1STFvdjZ4UlZmQmhtT0RsUFR3TGkzR2x6emc5WVRTeVpGbG91?=
 =?utf-8?B?NmdoSmljckJHRkxjMVdjTDZJM0FxaldDbTg2RXVnSTBMeVF0RUNFWWd1SWNJ?=
 =?utf-8?B?WllZT1BvVmFiWFgrOHdOcXBuTDBqeDh4S0gwT0ZMWjh5cU1oOWdnWjloZ0pX?=
 =?utf-8?B?MXlueldtVW4wNnNVcTR5Q1QwYzBrTEdrSWI5MVcxVVBZeFJxMGtZWnl5WEdC?=
 =?utf-8?B?Y0RrMzJ2TnpnRGtKNFhzN0ZrY0UyM3R5V09tZk5ic0JVZDhsZmYyNC81TURM?=
 =?utf-8?B?Si9na0VNcGloVm4vT2ZuQ1Zqdll2MytBSGg1ZWIyMm8xbDVtMzAya21oME1k?=
 =?utf-8?Q?rfDjJEJjfKozLAMGLneWm284HZWntmWrU4Iu+eT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD0CF69208F2D94588EF7D1434EEAD76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7e6d3c-8035-4982-c449-08d986befad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2021 22:41:45.8146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RiibrwsgaR/IAQ4Wkd3hVNDFGolhGaQ0CU5KnP9nNEeUTUEqvRWXHgRkw8Opn4MzWXwPpMEAWlsW2Ir2W/6RfAiOJi3kTQL4F6kG//nycE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gT2N0IDEsIDIwMjEsIGF0IDA4OjAyLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDI1IDIwMjEgYXQgMDg6NTMsIENoYW5nIFMuIEJh
ZSB3cm90ZToNCj4+ICsvKioNCj4+ICsgKiB4ZmRfc3dpdGNoIC0gU3dpdGNoZXMgdGhlIE1TUiBJ
QTMyX1hGRCBjb250ZXh0IGlmIG5lZWRlZC4NCj4+ICsgKiBAcHJldjoJVGhlIHByZXZpb3VzIHRh
c2sncyBzdHJ1Y3QgZnB1IHBvaW50ZXINCj4+ICsgKiBAbmV4dDoJVGhlIG5leHQgdGFzaydzIHN0
cnVjdCBmcHUgcG9pbnRlcg0KPj4gKyAqLw0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB4ZmRfc3dp
dGNoKHN0cnVjdCBmcHUgKnByZXYsIHN0cnVjdCBmcHUgKm5leHQpDQo+PiArew0KPj4gKwl1NjQg
cHJldl94ZmRfbWFzaywgbmV4dF94ZmRfbWFzazsNCj4+ICsNCj4+ICsJaWYgKCFjcHVfZmVhdHVy
ZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hGRCkgfHwgIXhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1p
YykNCj4+ICsJCXJldHVybjsNCj4gDQo+IFRoaXMgaXMgY29udGV4dCBzd2l0Y2gsIHNvIHRoaXMg
d2FudHMgdG8gYmUgYSBzdGF0aWMga2V5IHdoaWNoIGlzIHR1cm5lZA0KPiBvbiBkdXJpbmcgaW5p
dCB3aGVuIHRoZSBDUFUgc3VwcG9ydHMgWEZEIGFuZCB1c2VyIGR5bmFtaWMgZmVhdHVyZXMgYXJl
DQo+IGF2YWlsYWJsZS4NCg0KUmVwbGllZCBpbiB0aGUgbGF0ZXIgZW1haWwgWzFdLg0KDQo+PiAr
DQo+PiArCXByZXZfeGZkX21hc2sgPSBwcmV2LT5zdGF0ZV9tYXNrICYgeGZlYXR1cmVzX21hc2tf
dXNlcl9keW5hbWljOw0KPj4gKwluZXh0X3hmZF9tYXNrID0gbmV4dC0+c3RhdGVfbWFzayAmIHhm
ZWF0dXJlc19tYXNrX3VzZXJfZHluYW1pYzsNCj4+ICsNCj4+ICsJaWYgKHVubGlrZWx5KHByZXZf
eGZkX21hc2sgIT0gbmV4dF94ZmRfbWFzaykpDQo+PiArCQl3cm1zcmxfc2FmZShNU1JfSUEzMl9Y
RkQsIHhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1pYyBeIG5leHRfeGZkX21hc2spOw0KPj4gK30N
Cj4+ICsNCj4+IC8qDQo+PiAgKiBEZWxheSBsb2FkaW5nIG9mIHRoZSBjb21wbGV0ZSBGUFUgc3Rh
dGUgdW50aWwgdGhlIHJldHVybiB0byB1c2VybGFuZC4NCj4+ICAqIFBLUlUgaXMgaGFuZGxlZCBz
ZXBhcmF0ZWx5Lg0KPj4gICovDQo+PiAtc3RhdGljIGlubGluZSB2b2lkIHN3aXRjaF9mcHVfZmlu
aXNoKHN0cnVjdCBmcHUgKm5ld19mcHUpDQo+PiArc3RhdGljIGlubGluZSB2b2lkIHN3aXRjaF9m
cHVfZmluaXNoKHN0cnVjdCBmcHUgKm9sZF9mcHUsIHN0cnVjdCBmcHUgKm5ld19mcHUpDQo+PiB7
DQo+PiAtCWlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0ZQVSkpDQo+PiArCWlm
IChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0ZQVSkpIHsNCj4+IAkJc2V0X3RocmVh
ZF9mbGFnKFRJRl9ORUVEX0ZQVV9MT0FEKTsNCj4+ICsJCXhmZF9zd2l0Y2gob2xkX2ZwdSwgbmV3
X2ZwdSk7DQo+IA0KPiBXaHkgaGFzIHRoaXMgdG8gYmUgZG9uZSBvbiBjb250ZXh0IHN3aXRjaD8g
WmVybyBleHBsYW5hdGlvbiBwcm92aWRlZC4NCj4gDQo+IFdoeSBjYW4ndCB0aGlzIGJlIGRvbmUg
aW4gZXhpdF90b191c2VyKCkgd2hlcmUgdGhlIEZQVSBzdGF0ZSByZXN0b3JlIGlzDQo+IGhhbmRs
ZWQ/DQoNClJlcGxpZWQgaW4gdGhlIGxhdGVyIGVtYWlsIFsxXS4NCg0KPj4gCX0NCj4+ICsNCj4+
ICsJaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9YRkQpKQ0KPiANCj4gcy9ib290X2NwdV9o
YXMvY3B1X2ZlYXR1cmVfZW5hYmxlZC9nDQoNCkkgdGhpbmsgdGhpcyBpcyB1bmRlciBmcHVfX2lu
aXRfY3B1X3hzdGF0ZSgpLiBJSVJDLCBoZXJlIGNwdV9mZWF0dXJlX2VuYWJsZWQoKQ0KaGFkIGNh
dXNlZCBhIGJ1aWxkIGVycm9yIGJlZm9yZS4gTm93IGl0IGxvb2tzIG9rYXkuIFdpbGwgdXBkYXRl
Lg0KDQo+PiArCQl3cm1zcmwoTVNSX0lBMzJfWEZELCB4ZmVhdHVyZXNfbWFza191c2VyX2R5bmFt
aWMpOw0KPj4gfQ0KPj4gKw0KPj4gKwlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVS
RV9YRkQpKQ0KPj4gKwkJd3Jtc3JsX3NhZmUoTVNSX0lBMzJfWEZELCAoY3VycmVudC0+dGhyZWFk
LmZwdS5zdGF0ZV9tYXNrICYNCj4+ICsJCQkJCSAgIHhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1p
YykgXg0KPj4gKwkJCQkJICB4ZmVhdHVyZXNfbWFza191c2VyX2R5bmFtaWMpOw0KPiANCj4gTGFj
a3MgY3VybHkgYnJhY2VzIGFzIGl0J3Mgbm90IGEgc2luZ2xlIGxpbmUgb2YgY29kZS4NCg0KU29y
cnksIEkgd2FzIGNvbmZ1c2VkIHdpdGggb3RoZXIgZXhhbXBsZXMgbGlrZSB0aGlzIGluIHRoZSBt
YWlubGluZS4gV2lsbCBmaXguDQoNCj4+IH0NCj4+IA0KPj4gLyoqDQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCj4+
IGluZGV4IDMzZjVkOGQwNzM2Ny4uNmNkNGZiMDk4ZjhmIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94
ODYva2VybmVsL3Byb2Nlc3MuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYw0K
Pj4gQEAgLTk3LDYgKzk3LDE2IEBAIHZvaWQgYXJjaF90aHJlYWRfc3RydWN0X3doaXRlbGlzdCh1
bnNpZ25lZCBsb25nICpvZmZzZXQsIHVuc2lnbmVkIGxvbmcgKnNpemUpDQo+PiAJKnNpemUgPSBm
cHVfYnVmX2NmZy5taW5fc2l6ZTsNCj4+IH0NCj4+IA0KPj4gK3ZvaWQgYXJjaF9yZWxlYXNlX3Rh
c2tfc3RydWN0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaykNCj4+ICt7DQo+PiArCWlmICghY3B1
X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9GUFUpKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKw0K
Pj4gKwkvKiBGcmVlIHVwIG9ubHkgdGhlIGR5bmFtaWNhbGx5LWFsbG9jYXRlZCBtZW1vcnkuICov
DQo+PiArCWlmICh0YXNrLT50aHJlYWQuZnB1LnN0YXRlICE9ICZ0YXNrLT50aHJlYWQuZnB1Ll9f
ZGVmYXVsdF9zdGF0ZSkNCj4gDQo+IFNpZ2guDQoNClllYWgsIEkgd2lsbCBmaXggaXQgdGhpcyB0
aW1lLiBJIGFsc28gcmVzcG9uZGVkIGFib3V0IHRoZSByZWFzb24gZm9yIGRvaW5nDQp0aGlzIGlu
IHRoZSBvdGhlciBtYWlsIFsyXS4NCg0KPj4gKwkJZnJlZV94c3RhdGVfYnVmZmVyKCZ0YXNrLT50
aHJlYWQuZnB1KTsNCj4+IA0KPj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgYm9vbCBoYW5kbGVf
eGZkX2V2ZW50KHN0cnVjdCBmcHUgKmZwdSwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+PiArew0K
Pj4gKwlib29sIGhhbmRsZWQgPSBmYWxzZTsNCj4+ICsJdTY0IHhmZF9lcnI7DQo+PiArDQo+PiAr
CWlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9YRkQpKQ0KPj4gKwkJcmV0dXJu
IGhhbmRsZWQ7DQo+PiArDQo+PiArCXJkbXNybF9zYWZlKE1TUl9JQTMyX1hGRF9FUlIsICZ4ZmRf
ZXJyKTsNCj4+ICsJd3Jtc3JsX3NhZmUoTVNSX0lBMzJfWEZEX0VSUiwgMCk7DQo+PiArDQo+PiAr
CWlmICh4ZmRfZXJyKSB7DQo+IA0KPiBXaGF0J3Mgd3Jvbmcgd2l0aA0KPiANCj4gICAgICAgaWYg
KCF4ZmRfZXJyKQ0KPiAgICAgICAJCXJldHVybiBmYWxzZTsNCj4gDQo+IGFuIHNwYXJlIHRoZSBm
dWxsIGluZGVudGF0aW9uIGxldmVscyBiZWxvdw0KDQpJIHRob3VnaHQgbG9jYWwgdmFyaWFibGVz
IHVuZGVyIHRoaXMuIEJ1dCB5ZXMsIHRoaXMgY2FuIHNhdmUgYW4gaW5kZW50YXRpb24NCmxldmVs
IGhlcmUuDQoNCj4+ICsJCXU2NCB4ZmRfZXZlbnQgPSB4ZmRfZXJyICYgeGZlYXR1cmVzX21hc2tf
dXNlcl9keW5hbWljOw0KPj4gKwkJdTY0IHZhbHVlOw0KPj4gKw0KPj4gKwkJaWYgKFdBUk5fT04o
IXhmZF9ldmVudCkpIHsNCj4+ICsJCQkvKg0KPj4gKwkJCSAqIFVuZXhwZWN0ZWQgZXZlbnQgaXMg
cmFpc2VkLiBCdXQgdXBkYXRlIFhGRCBzdGF0ZSB0bw0KPj4gKwkJCSAqIHVuYmxvY2sgdGhlIHRh
c2suDQo+PiArCQkJICovDQo+PiArCQkJcmRtc3JsX3NhZmUoTVNSX0lBMzJfWEZELCAmdmFsdWUp
Ow0KPj4gKwkJCXdybXNybF9zYWZlKE1TUl9JQTMyX1hGRCwgdmFsdWUgJiB+eGZkX2Vycik7DQo+
IA0KPiBEaXR0by4gQnV0IHJldHVybmluZyBmYWxzZSBoZXJlIHdpbGwgbm90IHVuYmxvY2sgdGhl
IHRhc2sgYXMNCj4gZXhjX2RldmljZV9ub3RfYXZhaWxhYmxlKCkgd2lsbCBzaW1wbHkgcmVhY2gg
ImRpZSgpIi4NCg0KWWVzLCBpdCBpcy4gQnV0IHRoaXMgInVuZXhwZWN0ZWQgI05NIGV4Y2VwdGlv
buKAnSBjb3VsZCBtYWtlIGNvbmZ1c2lvbiBhcyBhbiAjTk0NCmlzIFhGRC1pbmR1Y2VkIGFuZCB0
aGF0IG5lZWRzIHRvIGJlIGRpZmZlcmVudGlhdGVkIGZvciB1c2Vycy4gKExlbiBtYWRlIHRoaXMN
CnBvaW50IHRvIG1lLikNCg0KPj4gKwkJfSBlbHNlIHsNCj4+ICsJCQlzdHJ1Y3QgZnB1ICpmcHUg
PSAmY3VycmVudC0+dGhyZWFkLmZwdTsNCj4gDQo+IFlvdSBuZWVkIHRoaXMgYmVjYXVzZSB0aGUg
ZnB1IGFyZ3VtZW50IGFib3ZlIGlzIGludmFsaWQ/DQoNCkFoLCBzbyBzb3JyeSwgSSBzaG91bGQg
aGF2ZSByZW1vdmVkIHRoaXMgbGluZSB3aGVuIEkgcmVmYWN0b3IgdGhpcyBmdW5jdGlvbi4uDQoN
Cj4+ICsJCQlpbnQgZXJyID0gLTE7DQo+PiArDQo+PiArCQkJLyoNCj4+ICsJCQkgKiBNYWtlIHN1
cmUgbm90IGluIGludGVycnVwdCBjb250ZXh0IGFzIGhhbmRsaW5nIGENCj4+ICsJCQkgKiB0cmFw
IGZyb20gdXNlcnNwYWNlLg0KPj4gKwkJCSAqLw0KPj4gKwkJCWlmICghV0FSTl9PTihpbl9pbnRl
cnJ1cHQoKSkpIHsNCj4gDQo+IFdoeSB3b3VsZCBpbl9pbnRlcnJ1cHQoKSBiZSBuZWNlc3Nhcmls
eSB0cnVlIHdoZW4gdGhlIHRyYXAgY29tZXMgZnJvbQ0KPiBrZXJuZWwgc3BhY2U/IFRoZSBwcm9w
ZXIgY2hlY2sgaXMgdXNlcl9tb2RlKHJlZ3MpIGFzIGRvbmUgYW55d2hlcmUgZWxzZS4NCg0KSSBz
ZWUuIA0KDQo+PiArCQkJCWVyciA9IHJlYWxsb2NfeHN0YXRlX2J1ZmZlcihmcHUsIHhmZF9ldmVu
dCk7DQo+PiArCQkJCWlmICghZXJyKQ0KPj4gKwkJCQkJd3Jtc3JsX3NhZmUoTVNSX0lBMzJfWEZE
LCAoZnB1LT5zdGF0ZV9tYXNrICYNCj4+ICsJCQkJCQkJCSAgIHhmZWF0dXJlc19tYXNrX3VzZXJf
ZHluYW1pYykgXg0KPj4gKwkJCQkJCQkJICB4ZmVhdHVyZXNfbWFza191c2VyX2R5bmFtaWMpOw0K
Pj4gKwkJCX0NCj4+ICsNCj4+ICsJCQkvKiBSYWlzZSBhIHNpZ25hbCB3aGVuIGl0IGZhaWxlZCB0
byBoYW5kbGUuICovDQo+PiArCQkJaWYgKGVycikNCj4+ICsJCQkJZm9yY2Vfc2lnX2ZhdWx0KFNJ
R0lMTCwgSUxMX0lMTE9QQywgZXJyb3JfZ2V0X3RyYXBfYWRkcihyZWdzKSk7DQo+PiArCQl9DQo+
PiArCQloYW5kbGVkID0gdHJ1ZTsNCj4+ICsJfQ0KPj4gKwlyZXR1cm4gaGFuZGxlZDsNCj4+ICt9
DQo+PiArDQo+PiBERUZJTkVfSURURU5UUlkoZXhjX2RldmljZV9ub3RfYXZhaWxhYmxlKQ0KPj4g
ew0KPj4gCXVuc2lnbmVkIGxvbmcgY3IwID0gcmVhZF9jcjAoKTsNCj4gDQo+PiArCWlmIChoYW5k
bGVfeGZkX2V2ZW50KCZjdXJyZW50LT50aHJlYWQuZnB1LCByZWdzKSkNCj4+ICsJCXJldHVybjsN
Cj4gDQo+IEFzIEkgc2FpZCBiZWZvcmUsIHRoaXMgaXMgd3JvbmcgYmVjYXVzZSBhdCB0aGF0IHBv
aW50IGludGVycnVwdHMgYXJlIGRpc2FibGVkLg0KDQpJIHNhdyB5b3Ugc3VnZ2VzdGVkIHRoZSBj
b2RlLiBXaWxsIHRha2UgdGhhdCwgdGhhbmtzLg0KDQpUaGFua3MsDQpDaGFuZw0KDQpbMV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC82NkExOUU4QS0xMUJGLTQ1MzItODc4Ri1BOEQwOTM1
RkRCQzdAaW50ZWwuY29tLw0KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FGOUE5
NTYtNTYyMy00RDI0LUJBM0UtQUYxMzlDMEE3Q0U2QGludGVsLmNvbS8NCg0KDQoNCg==
