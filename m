Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B2B30D25E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 05:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhBCEL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 23:11:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:23459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232292AbhBCELR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:11:17 -0500
IronPort-SDR: zM0SBD2n/LwdIv9Zja2gWasbChdMMGt5PB7N9V3PDPMjuDuX3a5UhBF8C8VzbOJ5dqSj1R+5Br
 zKOhpWhJMBfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="199927853"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="199927853"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 20:10:32 -0800
IronPort-SDR: aoT1uii5O9QrAOIsrPyolAWNLlMVRfy4JwhRratveDYPOW/7OWvAUDcDRiPXw9I/IZXvd4/GRR
 GkpeM/rh5Hxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="371089626"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2021 20:10:31 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 20:10:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 2 Feb 2021 20:10:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 2 Feb 2021 20:10:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+YCK1opnG7ssfMxiaXbe0V8/ur6KfPx1tqrV2QVft3QhJ6xpkF/fkWZsCdkoYXNxEEVxigvxbGNbTkM8ZIvUo54D+iz+Gn8cthO6rYV7WBDGWMTPNRHutPYCLjav39RwgJGCORV9BewSixLSWfPNMb9JBw83w68Sg/4qSfJtRHHVAfartnnhY0uWNI/lnPhTzDt+yrGXzE8kNCSdSOSwqLz6lZphxRcTm9LRnJwv/ANOURFfvKJm43Sl0fMM3Bk8/PF46SBRg8dTWxnjKTmFjpSu3Do7wabUDkwiKbkvoy0wgFt59zoIctZyy6uBQRGH1pN8AiTn9xNtrnlgFC//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSp1c4LCgRWpyBt60daeRofjAFT8vn+aY1tebc+HvPY=;
 b=DpdqZce3jUryHijswAbIXzuAs7Zh7cIAZSV5QbBwm6ePlGICTXEzvGfdvR9k0nnAAt12XRq0KGVzrLNFvYX2VGvx9pEBfW4fRNSl4/4Yu77Yir6x4jC5qWcN3DwXAlh5HJ5NewPDEq1WwjtEXOB0m5s0E3BZ7ic8GUAYGnnvqeemIlkJRbeviUpZgepL+0wL+gbghAv5bdwOb5RybMNblwNrz+2KorXcrfELz0nwLKEI6PEaOgBgO/OWWC4Z2FrdFfJlAt8qfGiVq+gGCdpoi6/OV6o9fURuufipOaR55rfA4XlXcawZZgP7DC60Y8H47a9FeejEzClLbJBZLv8RuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSp1c4LCgRWpyBt60daeRofjAFT8vn+aY1tebc+HvPY=;
 b=kDIdNWgomO8YLtCW4rVOkOMhowRrtg18OZgxQSo2oke1yfZ8V1kuNiSqO0FVv8O1Tj6n0MpTH1Mjj62mquTXMjSfGZgLHovw3ds3yTjklwXB9jlEzx/gbATd8xLjBI2oLAbGGQnwx2LDOJM4Xpi7H5B9qO1dywrGF5PhXl/Hjls=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4935.namprd11.prod.outlook.com (2603:10b6:510:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 04:10:25 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 04:10:25 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/21] x86/fpu/xstate: Introduce helpers to manage
 dynamic xstate buffers
Thread-Topic: [PATCH v3 07/21] x86/fpu/xstate: Introduce helpers to manage
 dynamic xstate buffers
Thread-Index: AQHW2UTwl1+KjUFcn0aaCEDTiBI9I6o6jhQAgABViwCAAJuwAIAKkyQA
Date:   Wed, 3 Feb 2021 04:10:24 +0000
Message-ID: <9A4E3B85-BE0C-40C6-B261-E634CFCD9819@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-8-chang.seok.bae@intel.com>
 <20210126201746.GB9662@zn.tnic>
 <80003059-987E-4FFA-8F9D-6A480192BE5D@intel.com>
 <20210127104110.GB8115@zn.tnic>
In-Reply-To: <20210127104110.GB8115@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3458987-0386-4106-8ff4-08d8c7f9a1ef
x-ms-traffictypediagnostic: PH0PR11MB4935:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB49351D4AD48C97CD88BED5D7D8B49@PH0PR11MB4935.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XLI58v6mXDzZnstskJ15E8Z20fCE3BzUgV+ujplEFGBi59kJgRHFugyBG/lfby5zE5P93TQnNKAQaruvv/KqqIPdIher03Ofj78sVqLOQi6eJDHIHuNgOUlGTjMDGsECzX4cJ9TYH43rxRLRUENog0JAxwrwWqhhKNBbcZc6WGOxtcEbDLYQb9T020/mw61MvAL19jhnTPkU89mLSl+zPWgqmt36IfuqNIviuwLCzeXfikR/K5lflsUNWJD+cNOW6UrSarY3arIM+/3cA3jBwLBr5Eohk+hUWKFoFmnCL6xGc4NxiVLS0pG0pntq1XmelHckVbjC/z0b/4OZjcIxIVQbnHEm5Xxrmf+7DjWd98jbvCmGnjSfCBDXveZNGXDY+C0+cWf92OzEbJl1xdPETl/cN4AgyqrWpB5slPSyOWRZCFpcUSneM+2FORt2c9AWW2YYZg4RXEEADHL4ewIzENP8IroMbUtp6NoVly8s8uvu/6B+TVG4A+9RvkzIAf4h4PBRCJbov4R903snRxWql5E7pN0/Qv5x0cFYVgSbgKTnt1sBa3saEDSnO5FmRkKV4tUF5QMVP9f7a5xrnkO2tidgLSk+xo2IwWMmXn0Chggj4GwmcyV442amDoyDpjjE9FrnBOZnf94jVhWNbJSfm3xwQOrqJ9bjg+yA+koZTd0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(66446008)(2616005)(66946007)(8676002)(83380400001)(966005)(53546011)(6506007)(66556008)(4326008)(478600001)(36756003)(186003)(6486002)(64756008)(2906002)(66476007)(86362001)(26005)(8936002)(33656002)(6512007)(6916009)(316002)(5660300002)(71200400001)(76116006)(54906003)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NHZzTUJISFBTcGxuNVA2SUx3Y3V6dEYxQWdOZVVsayt4SXNJencxaEFDMTBP?=
 =?utf-8?B?UjVxbzYzK21WU2g0WVBoSklOc3lEZmNCc3FlWGFHd21jQW41SEMvaDhIWUVw?=
 =?utf-8?B?blowMDZjRE9QVlF4bTF4aHduYzlXTUJDMmlnYTJQN1h5czZLbmZvelpaY1BF?=
 =?utf-8?B?T25RSlFPWjFBMFZuU2RtTnhqM1F5QjdZMjczUTdIaWJZckdodlhIcVp4czhG?=
 =?utf-8?B?bkw3S2lRNVpVWmJ5blBlVFFYaG4zUFpReWxVdTV6ZUJzelhoeTV4YTFzRTN4?=
 =?utf-8?B?L0lmemR2cnFndHRFSDg2YlFnTWd6c3FhaUxkcVFXTGRIT0V4RlJpUmtManNy?=
 =?utf-8?B?b3FQS1c3ZFVxSWpqY29iOGJHOXBkRzR1NVNSa21YQnVhcnpRTjZkV25STmNK?=
 =?utf-8?B?SGlsRUxXMHJUck1NVFpHUTlYZTRtU3JlVE9vSFFNMkhjcFkzd3FhQUUyUmQw?=
 =?utf-8?B?MTJaSSt2alRuME4zengyMHdpeUNwbGZTSjkyVnRWQ1gzcUp6eG1seEp1M3pG?=
 =?utf-8?B?NFVNVEFYS21rSzl1ZUVmZTBYRHgvUjRtbk4zenhUcm1ISEhsWEllWWNRUXR1?=
 =?utf-8?B?OGlkM3F5NnMvcktrbytoQ0YrMWo5VmhhMG1WTDAyVkQ2SkQwK1lINGdWQjNj?=
 =?utf-8?B?Q0o1TGhJcTIxVjJGRTNiMmUwTDhaUFJZU3p3eW1XSGlxbi9EQkpYbi9ucWtr?=
 =?utf-8?B?Zm1iTkJ3cEJaRzdZUTZEcnIrRFloR1loZ2FRMW52Y2g0Z2pMZ1dMU2dkTkJh?=
 =?utf-8?B?YytsSWFWQTNETFlDamVWd0I4OEg3VkpTek5tOE5FcURiMEJna3hJVG1WUlRY?=
 =?utf-8?B?bWR5TW54YjVPRXRScFFodnJzUFhING40YVNpaVRkRFNqbGtCSVRlZ3Z5bnJQ?=
 =?utf-8?B?MmhtbG4yak1uNE1KNE5TZGF0N2YwMmFnYTFvbnJjSnVYL1dUeVB6ZlJwNDVQ?=
 =?utf-8?B?R0FTcUF1aVZQL3dTK2t3VXllRFZhYWU1NWRFZmJCNVhpN3Rocmxpa0tNNWVk?=
 =?utf-8?B?aFdOVWpSazdZZmlrbTE1SmVZanlwVHZNVmgzK09wSXlqQ0hiVldxVW9FZGtj?=
 =?utf-8?B?Uncrd0R4VVFMbGVvVFpkTkg4QUU3dDRTT3lmVWNaaGVsVW50WXhCU1RsSy9s?=
 =?utf-8?B?UStvQkZWN2hXeThnbVU3eStxcEcyTUJTMnhhbG5BaHhTdis1N2lCbVB0L0pP?=
 =?utf-8?B?QVpWdUFZbDVJRDlsS3hPTGpTN1BtUUU2bm5qa0NqbTMwWG9DY3dhRDhrb1V5?=
 =?utf-8?B?dE8wRXZxdEJKbTdUb3kxMGFuSXhrRjFodElhVll4RDZxT1JOTWl0ZzgxZXli?=
 =?utf-8?B?RVc5b21YUjhualF3T1huUUp1Rk15ZXVYVVM1NHlHUXpEZTJ4QjVybjhzaTRW?=
 =?utf-8?B?S3ZoYWwzalF5bE5Ua2UySmM0OWZiU3lySXdZSGdaU09BMm1kVGlzNGZwQkVw?=
 =?utf-8?B?bjhpcmxJcTJGYk9WbG1rSkxFTTIwZWVBWG9jLzhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A03BAD6462FD4F4C9563F6A66DF60965@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3458987-0386-4106-8ff4-08d8c7f9a1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 04:10:24.9117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkdzhuNGQgIXFFo/uGsCr72Ty7jR55g29yr/EO0tCa9sBGZW5IiZrJ3c+7Et+SN2Tk74bZPR/zrLyv5BsCADM/msw1rC4tBXgpJxqzoz6u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4935
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSmFuIDI3LCAyMDIxLCBhdCAwMjo0MSwgQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPiB3
cm90ZToNCj4gT24gV2VkLCBKYW4gMjcsIDIwMjEgYXQgMDE6MjM6NTdBTSArMDAwMCwgQmFlLCBD
aGFuZyBTZW9rIHdyb3RlOg0KPj4gVGhlIHhzdGF0ZSBidWZmZXIgbWF5IGV4cGFuZCBvbiB0aGUg
Zmx5LiBUaGUgc2l6ZSBoYXMgdG8gYmUgY29ycmVjdGx5DQo+PiBjYWxjdWxhdGVkIGlmIG5lZWRl
ZC4gQ1BVSUQgcHJvdmlkZXMgZXNzZW50aWFsIGluZm9ybWF0aW9uIGZvciB0aGUNCj4+IGNhbGN1
bGF0aW9uLiBJbnN0ZWFkIG9mIHJlYWRpbmcgQ1BVSUQgcmVwZWF0ZWRseSwgc3RvcmUgdGhlbSAt
LSB0aGUgb2Zmc2V0IGFuZA0KPj4gc2l6ZSBhcmUgYWxyZWFkeSBzdG9yZWQgaGVyZS4gVGhlIDY0
QiBhbGlnbm1lbnQgbG9va3MgdG8gYmUgbWlzc2luZywgc28gYWRkZWQNCj4+IGhlcmUuDQo+IA0K
PiAvbWUgZ29lcyBhbmQgZGlncyBpbnRvIHRoZSBTRE0uDQo+IA0KPiBEbyB5b3UgbWVhbiB0aGlz
Og0KPiANCj4gIkJpdCAwMSBpcyBzZXQgaWYsIHdoZW4gdGhlIGNvbXBhY3RlZCBmb3JtYXQgb2Yg
YW4gWFNBVkUgYXJlYSBpcyB1c2VkLA0KPiB0aGlzIGV4dGVuZGVkIHN0YXRlIGNvbXBvbmVudCBs
b2NhdGVkIG9uIHRoZSBuZXh0IDY0LWJ5dGUgYm91bmRhcnkNCj4gZm9sbG93aW5nIHRoZSBwcmVj
ZWRpbmcgc3RhdGUgY29tcG9uZW50IChvdGhlcndpc2UsIGl0IGlzIGxvY2F0ZWQNCj4gaW1tZWRp
YXRlbHkgZm9sbG93aW5nIHRoZSBwcmVjZWRpbmcgc3RhdGUgY29tcG9uZW50KS4iDQo+IA0KPiBT
byBqdWRnaW5nIGJ5IHlvdXIgdmFyaWFibGUgbmFtaW5nLCB5b3Ugd2FubmEgcmVjb3JkIGhlcmUg
d2hldGhlciB0aGUNCj4gYnVmZmVyIGFsaWducyBvbiA2NCBieXRlcy4NCj4gDQo+IFllcywgbm8/
DQoNClllcywgeW914oCZcmUgcmlnaHQuDQoNCj4gSG93IGFib3V0IGEgY29tbWVudCBvdmVyIHRo
YXQgdmFyaWFibGUgc28gdGhhdCBwZW9wbGUgcmVhZGluZyB0aGUgY29kZSwNCj4ga25vdyB3aGF0
IGl0IHJlY29yZHMgYW5kIGRvIG5vdCBoYXZlIHRvIG9wZW4gdGhlIFNETSBlYWNoIHRpbWUuDQoN
Ck9rYXksIGhvdyBhYm91dDoNCuKAnA0KVGhpcyBhbGlnbm1lbnQgYml0IGlzIHNldCBpZiB0aGUg
c3RhdGUgaXMgc2F2ZWQgb24gYSA2NEItYWxpZ25lZCBhZGRyZXNzIGluDQp0aGUgY29tcGFjdGVk
IGZvcm1hdCBidWZmZXIuDQoiDQoNCj4+IE1heWJlOg0KPj4gICAgIldoZW4gdGhlIGJ1ZmZlciBp
cyBtb3JlIHRoYW4gdGhpcyBzaXplLCB0aGUgY3VycmVudCBtZWNoYW5pc20gaXMNCj4+ICAgICBw
b3RlbnRpYWxseSBtYXJnaW5hbCB0byBzdXBwb3J0IHRoZSBhbGxvY2F0aW9ucy4iDQo+IA0KPiBX
aGVyZSBkbyB5b3UgZ2V0IHRob3NlIGZvcm11bGF0aW9ucz8hDQo+IA0KPiBBcmUgeW91IHNpbXBs
eSB0cnlpbmcgdG8gc2F5IHRoYXQgZm9yIGJ1ZmZlcnMgbGFyZ2VyIHRoYW4gNjRLLCB0aGUNCj4g
a2VybmVsIG5lZWRzICJhIG1vcmUgc29waGlzdGljYXRlZCBhbGxvY2F0aW9uIHNjaGVtZSI/DQo+
IA0KPiBJJ2Qgc3VnZ2VzdCB5b3UgdHJ5IHNpbXBsZSBmb3JtdWxhdGlvbnMgZmlyc3QuDQo+IA0K
PiBBbmQgd2h5IGRvZXMgaXQgbmVlZCBhIG1vcmUgc29waGlzdGljYXRlZCBhbGxvY2F0aW9uIHNj
aGVtZT8gSXMgNjRLDQo+IG1hZ2ljYWw/DQo+IA0KPiBBbHNvLCBJJ20gYXNzdW1pbmcgaGVyZSAt
IHNpbmNlIHlvdSdyZSB1c2luZyB2bWFsbG9jIC0gdGhhdCBYU0FWRSogY2FuDQo+IGhhbmRsZSB2
aXJ0dWFsbHkgY29udGlndW91cyBtZW1vcnkuIFNETSBzYXlzIGl0IHNhdmVzIHRvICJtZW0iIGFu
ZA0KPiBkb2Vzbid0IHNwZWNpZnkgc28gaXQgc291bmRzIGxpa2UgaXQgZG9lcyBidXQgbGV0J3Mg
aGF2ZSBhIGNvbmZpcm1hdGlvbg0KPiBoZXJlIHBscy4NCg0KWWVzLCBjb3JyZWN0Lg0KDQo+Pj4+
ICsjZGVmaW5lIFhTVEFURV9CVUZGRVJfTUFYX0JZVEVTCQkoNjQgKiAxMDI0KQ0KPj4+IA0KPj4+
IFdoYXQncyB0aGF0IHRoaW5nIGZvciB3aGVuIHdlIGhhdmUgZnB1X2tlcm5lbF94c3RhdGVfbWF4
X3NpemUgdG9vPw0KPj4gDQo+PiBUaGUgdGhyZXNob2xkIHNpemUgaXMgd2hhdCB0aGUgY3VycmVu
dCBtZWNoYW5pc20gY2FuIGNvbWZvcnRhYmx5IGFsbG9jYXRlDQo+PiAobWF5YmUgYXQgbW9zdCku
IFRoZSB3YXJuaW5nIGlzIGxlZnQgd2hlbiB0aGUgYnVmZmVyIHNpemUgZ29lcyBiZXlvbmQgdGhl
IA0KPj4gdGhyZXNob2xkLiBUaGVuLCB3ZSBtYXkgbmVlZCB0byBjb25zaWRlciBhIGJldHRlciBh
bGxvY2F0aW9uIG1lY2hhbmlzbS4NCj4gDQo+IEFzIGFib3ZlLCB3aHk/DQo+IA0KPj4gQWx0aG91
Z2ggYSB3YXJuaW5nIGlzIGdpdmVuLCB2bWFsbG9jKCkgbWF5IG1hbmFnZSB0byBhbGxvY2F0ZSB0
aGlzIHNpemUuIFNvLA0KPj4gaXQgd2FzIG5vdCBjb25zaWRlcmVkIGEgaGFyZCBoaXQgeWV0LiB2
bWFsbG9jKCkgZmFpbHVyZSB3aWxsIHJldHVybiBhbiBlcnJvcg0KPj4gbGF0ZXIuDQo+IA0KPiBB
bmQgdGhhdCB3YXJuaW5nIGlzIGRlc3RpbmVkIGZvciB3aG9tLCBleGFjdGx5Pw0KPiANCj4gV2hl
biBjYW4gdGhhdCBzdGF0ZSBiZWNvbWUgbW9yZSB0aGFuIDY0Sz8NCj4gDQo+IFdoYXQgaXMgdGhh
dCBhcnRpZmljaWFsIGxpbWl0IGZvcj8NCj4gDQo+IEEgd2hvbGUgbG90IG9mIHF1ZXN0aW9uc+KA
pg0KDQpPa2F5LCBsZXQgbWUgdHJ5IHRvIGV4cGxhaW4uLg0KDQpUaGUgdGhyZXNob2xkIGhlcmUg
Y291bGQgYmUgbW9yZSB0aGFuIHRoYXQuIEJ1dCB0aGUgaW50ZW50aW9uIGlzIGEgaGVhZHMtdXAg
dG8NCihyZS0pY29uc2lkZXIgKGEpIGEgbmV3IGFsbG9jYXRpb24gbWVjaGFuaXNtIGFuZCAoYikg
dG8gc2hyaW5rIHRoZSBtZW1vcnkNCmFsbG9jYXRpb24uDQoNCkFsc28sIHRoZSBBTVggc3RhdGUg
c2l6ZSBpcyBsaW1pdGVkIHRvIChhIGJpdCBsZXNzIHRoYW4pIDY0S0IgYW5kIGl0IHdhcw0KZGlz
Y3Vzc2VkIHRoYXQgdm1hbGxvYygpIHdpbGwgYmUgb2theSB3aXRoIEFNWCBbMl0uDQoNCkRhdmVI
LCBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZy4NCg0KPj4+PiArCXN0YXRlX3B0ciA9IHZtYWxsb2Mo
bmV3c3opOw0KPj4+PiArCWlmICghc3RhdGVfcHRyKSB7DQo+Pj4+ICsJCXRyYWNlX3g4Nl9mcHVf
eHN0YXRlX2FsbG9jX2ZhaWxlZChmcHUpOw0KPj4+IA0KPj4+IFdUSCBpcyB0aGF0IHRyYWNlcG9p
bnQgaGVyZSBmb3I/DQo+PiANCj4+IFdoaWxlIGl0IHJldHVybnMgYW4gZXJyb3IsIHRoaXMgZnVu
Y3Rpb24gY2FuIGJlIG9uIHRoZSBwYXRoIG9mIE5NSSBoYW5kbGluZy4NCj4gDQo+IEhvdz8NCj4g
DQo+IFlvdSdyZSBhbGxvY2F0aW5nIGFuIHhzdGF0ZSBidWZmZXIgaW4gTk1JIGNvbnRleHQ/IQ0K
DQpPaCwgc29ycnkuIFRoZSB0eXBvIGNvdWxkIG1ha2UgaXQgY29uZnVzaW5nIGhlcmUgLS0gcy9O
TUkvI05NLy4NCg0KPj4gVGhlbiwgbGlrZWx5IG9ubHkgd2l0aCB0aGUg4oCcdW5leHBlY3RlZCAj
Tk0gZXhjZXB0aW9u4oCdIG1lc3NhZ2UuIFNvLCBsb2dnaW5nIGENCj4+IHRyYWNlcG9pbnQgY2Fu
IHByb3ZpZGUgZXZpZGVuY2Ugb2YgdGhlIGFsbG9jYXRpb24gZmFpbHVyZSBpbiB0aGF0IGNhc2Uu
DQo+IA0KPiBXaG8ncyBnb2luZyB0byBzZWUgdGhhdCB0cmFjZXBvaW50LCBwZW9wbGUgd2hvIGFy
ZSB0cmFjaW5nIHRoZSBzeXN0ZW0NCj4gYnV0IG5vdCBub3JtYWwgdXNlcnMuDQoNCk1heWJlIGl0
IGlzIHBvc3NpYmxlIHRvIGJhY2t0cmFjayB0aGlzIGFsbG9jYXRpb24gZmFpbHVyZSBvdXQgb2Yg
I05NIGhhbmRsaW5nLg0KQnV0IHRoZSB0cmFjZXBvaW50IGNhbiBwcm92aWRlIGEgY2xlYXIgY29u
dGV4dCwgYWx0aG91Z2ggbGltaXRlZCB0byB0aG9zZQ0KdXNpbmcgaXQuDQoNCj4+IFBBVENIOSBp
bnRyb2R1Y2VzIGEgd3JhcHBlciB0aGF0IGRldGVybWluZXMgd2hpY2ggdG8gdGFrZS4gSXQgc2lt
cGx5IHJldHVybnMNCj4+IHN0YXRlX3B0ciB3aGVuIG5vdCBhIG51bGwgcG9pbnRlci4gU28sIHRo
ZSBsb2dpYyBpcyB0byB1c2UgdGhlIGR5bmFtaWMgYnVmZmVyDQo+PiB3aGVuIGF2YWlsYWJsZS4N
Cj4gDQo+IFdoeSBub3QgYWxsb2NhdGUgdGhlIHhzdGF0ZSBidWZmZXIgYnkgZGVmYXVsdCBpbnN0
ZWFkIG9mIGJlaW5nIGVtYmVkZGVkDQo+IGluIHN0cnVjdCBmcHU/DQoNCkluZGVlZCwgdGhpcyBp
cyB0aGUgbW9zdCBwcmVmZXJyZWQgd2F5IG9uIG9uZSBoYW5kLiBCdXQgdGhlcmUgd2FzIGEgY2hh
bmdlIHRvDQp0aGUgY3VycmVudCBhbGxvY2F0aW9uIGFwcHJvYWNoIGJ5IEluZ28gYWJvdXQgNiB5
ZWFycyBhZ28gWzNdLg0KDQpTbywgSeKAmW0gd29uZGVyaW5nIGhpcyBjdXJyZW50IHRob3VnaHQg
b24gdGhpcyBzdWdnZXN0aW9uLg0KDQo+IFlvdSdyZSBhbHJlYWR5IGRldGVybWluaW5nIGl0cyBt
YXhfc2l6ZSBhbmQgeW91IGNhbiB1c2UgdGhhdCB0byBkbyB0aGUNCj4gYWxsb2NhdGlvbi4gVHdv
IGJ1ZmZlcnMgaXMgY2FsbGluZyBmb3IgdHJvdWJsZS4NCg0KQnV0IGlmIHNvLCBldmVyeSB0YXNr
IHdpbGwgY29uc3VtZSA4S0IgKG9yIHVwIHRvIDY0S0IpIHdpdGggQU1YLiBCYWQgaXMgdGhlDQp3
YXN0ZSBvZiBtZW1vcnkgZm9yIHRob3NlIG5vdCB1c2luZyB0aGUgc3RhdGUgYXQgYWxsLg0KDQo+
PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC82OTcyMTEyNS00ZTFjLWNhOWMtZmY1
OS04ZTEzMzE5MzNlNmNAaW50ZWwuY29tLyN0DQo+IA0KPiBPaywgSSByZWFkIHRoYXQgc3VidGhy
ZWFkLg0KPiANCj4gVGhlIHJlYXNvbmluZyAqd2h5KiB3ZSdyZSB1c2luZyB2bWFsbG9jKCkgbmVl
ZHMgdG8gYmUgZXhwbGFpbmVkIGluIGENCj4gY29tbWVudCBvdmVyIGFsbG9jX3hzdGF0ZV9idWZm
ZXIoKSBvdGhlcndpc2Ugd2Ugd2lsbCBmb3JnZXQgYW5kIHRoYXQgaXMNCj4gaW1wb3J0YW50Lg0K
DQpNYXliZToNCuKAnA0KSWYgdGhlIHRhc2sgd2l0aCB2bWFsbG9jKCktYWxsb2NhdGVkIGJ1ZmZl
ciB0ZW5kcyB0byB0ZXJtaW5hdGUgcXVpY2tseSwNCnZmcmVlKCktaW5kdWNlZCBJUElzIG1heSBi
ZSBhIGNvbmNlcm4uIEltcGxlbWVudCBjYWNoZSBtYXkgYmUgaGVscGZ1bCBvbiB0aGlzLg0KQnV0
IHRoZSB0YXNrIHdpdGggbGFyZ2Ugc3RhdGUgaXMgbGlrZWx5IHRvIGxpdmUgbG9uZ2VyLiBTbywg
dXNlIHZtYWxsb2MoKQ0Kc2ltcGx5Lg0KIg0KTGV0IG1lIGtub3cgaWYgdGhpcyBpcyBub3QgZW5v
dWdoLg0KDQpUaGFua3MsDQpDaGFuZw0KDQpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC9DQUxDRVRyVzh1NXJVc1p2b281dDRZdEMrNGJvQlZjS19fLXNydEExKy1ZWDA2UVlEMXdAbWFp
bC5nbWFpbC5jb20vDQpbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8xNDMwODQ4MzAw
LTI3ODc3LTU2LWdpdC1zZW5kLWVtYWlsLW1pbmdvQGtlcm5lbC5vcmcvDQoNCg==
