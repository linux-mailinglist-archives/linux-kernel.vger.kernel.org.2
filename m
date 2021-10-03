Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F8A420452
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 00:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhJCWgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 18:36:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:37149 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhJCWgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 18:36:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="222691485"
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="222691485"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 15:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="566661510"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2021 15:35:04 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 3 Oct 2021 15:35:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 3 Oct 2021 15:35:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 3 Oct 2021 15:35:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 3 Oct 2021 15:35:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWnq0VTw+IpdwjoGkxoNANYk0jmHeAt+OS5q6wyexk3boZo3EVJZklH6oU6p8zYBA3LtkVKvwxBJL+xF5nlT1riBJY2ek2i9f7E1UAoX9dD8gx7amSwxxrOqxZDhjkOeA3yeMVzZGAiw0VvQottevRCD14NxKjolAtt7vki8AWDRl01ekkDdYJU4wRKrv3uE5adDb5PK1ju0QCJzcHu86Cz3AaCK5xYPa/tiumqDX1146OdsXAkF34EXanDYr0Os53frtfCM6zMw8DJ7t/w1CoN+uB/3S2qi/UEnjxYoa+tgygu1Od/PO2bw29KWwYO7E203PJJ7SsRo7uMq/0gGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ror9Wc2IUd13d8B+dRmuqN9Pj+8Mi0XlGRH2LHvNC5w=;
 b=gRpAEILCZCPfif0rllMaaHgre2CFknMDYYyYlSn2QwQB7mgAnIaW2IZZaKOncSWluCroFMDktJ68TLpqEcLG7qXaybr+cFhgVuLsgKiHkgFyF6hPBKW1Wa15g3USFyIgS6RdLgVtwwL8W+MzNDZ4F9dMG3OFn0MEvv7HFwoEidx07n0D4FmGomqooXHq8zpdoK/rXBqxXZFPK74yDz66ybpp2CvLBizh9eYUARXBQ/CdmQfERd86hjndRvMJ5kb9cvl9fWHjFQDKzHPj5CrO1UNCcFpx3/gMGOaIqt0/bVYu3OdrBvesJ9RbIbKVE2o4/h5iX9Gn6jq8OPge6VJNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ror9Wc2IUd13d8B+dRmuqN9Pj+8Mi0XlGRH2LHvNC5w=;
 b=AIStU6iGHFa9zDW2x+1r/CdByEbwXARAtGhs4rAc1p+lpIo5vEGSdmPpFptnhNhzX4Itae0+NUzhxv6WtpzFrzbTWbwjKPlSJ2FOEP4EAozrPMJlz2I4wAhwkLP+NAi+4jO+yLBvQFarj8eyavCbByBvwEprtV1ZFU1g2hrvlpc=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Sun, 3 Oct
 2021 22:34:58 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Sun, 3 Oct 2021
 22:34:58 +0000
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
Subject: Re: [PATCH v10 01/28] x86/fpu/xstate: Fix the state copy function to
 the XSTATE buffer
Thread-Topic: [PATCH v10 01/28] x86/fpu/xstate: Fix the state copy function to
 the XSTATE buffer
Thread-Index: AQHXmcpdCgo2zkXTuUePGAND1pAzTKu+UKSAgAPJjwA=
Date:   Sun, 3 Oct 2021 22:34:58 +0000
Message-ID: <114DDE57-4509-4167-9E77-D6F74C793941@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-2-chang.seok.bae@intel.com> <87lf3c6hj6.ffs@tglx>
In-Reply-To: <87lf3c6hj6.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70be9e3b-eb5a-4ab8-fed3-08d986be07f0
x-ms-traffictypediagnostic: PH0PR11MB5159:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB515929D5DA53792EB6D25AC7D8AD9@PH0PR11MB5159.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYnaYj+AikTJ8njyOvjlddnssxe0vpn7ScLxvjpHTICsqlmX34OkLNRH/5h0Gkmttuk7cx1FP0Qs8wkgBa6fbPj1V9ANvIVIQ/t2hcZg73ML4MAFa2yD4I3N0gZ5NakDEuN1OI9WzzsL10grZkJX1Z2rbe4pluotfe9w/glsM4ktnOfE45aU0GYZcBS6fd6mSORo3Ft/Rgpour6HupXaVhExy8dlunki/Sq5JcVJT/IBZAB0QPgA6PL73lgWK9fmmxGSulPBXO7lzLSCyLFDKYrZi94k5mn5RI9xp1fk0oSa95kCwngtkN+dncYAROGjafYtkfBaf+cgKRGz4DsXu/LAR6e4FLf3TN5LBCnBsZ3ahCeIK+1lkDKuBnFPz6aHAd9vRbuoJg7UvqYgv6v8fmNQhGREx9esF9r3/CkOV7LBriTTOO5fXXKsjVBJbX9dbA9iGnmhtbKzYwTcbqm4ZU7q2CuB3dEekrS8sCBWt75JogZClc41RnQpEQVb1e72sarEiOxai0qTutpMEbU6oW0141b8IhccBWinEMK1frlCgpxqge0QHZS3hbaCfg4SLQMylFdD+Zk2TTEKOlDCbGBnf1h28UIiMcOjhOCsxFKckeblNVHGIJlB8mEDp2swfRuOb4n3DB/GjfTElcxyDrUVcX4E9YUJyn2dUQc+M8L+Jv6T2jQ5jtoBWxW1G3yGpx8qwxJYSDo3KXXoQXyku+92xnN4W9nNTAkzJraGoUXN8ApgQ119RMXjgZJyTau7C7FIXP8UIlbKGEhvHBKLEEDG8qqsprfiYj2LUKorHERhHJy9848C/lpYc0VIvz8TSO9FlxahoU57YcnxO7hziA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(186003)(76116006)(86362001)(4326008)(6916009)(71200400001)(26005)(6486002)(2616005)(38070700005)(2906002)(508600001)(966005)(5660300002)(6512007)(316002)(8936002)(66476007)(66556008)(64756008)(54906003)(38100700002)(8676002)(36756003)(66946007)(53546011)(6506007)(122000001)(33656002)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3BsUjlTOHlqODVxNUdLRjFpcEo0eTlHc1lDRG44SFJMWVd3SzdIKzJKeWU4?=
 =?utf-8?B?bmtINkhqUzg4TGdLdkVJbWhSdFpOVjJUTTZWMWdJb3d3OUZxTm1aWGZGNFFk?=
 =?utf-8?B?SDlpQndRUDhHVGcrN1hlTFlVYzRmbXNveDJVb2k0VlNNRHZaWXpBQUdzRnVa?=
 =?utf-8?B?WkhnQW1zZVlkNnk3MUNwcXFxUTJkaW5CMmljMW9kMmhITkhYRFI3eUtIWXhl?=
 =?utf-8?B?d0l4WDF1czdOc2JqRkhCaUlKN0xTbmVHVlFZQVExNktZSUZ1NFVTSWYwWHIz?=
 =?utf-8?B?T1lxY3RHendNZElzV2R6QzBaR05GUXM2R2tMYzFmbklleEgyZWNUeFpSb0Z5?=
 =?utf-8?B?T3hoZ2ZkNUZGUEdYczVMUUhQQmdFZktNSGpxS0t4WFZoenkzWmxtNFlUa0Jm?=
 =?utf-8?B?MUZYYllFekRObyt1dWxaRDVmMUczT2xsb0huQXI4SzNxWHQ0L0M5aUl5Yy9D?=
 =?utf-8?B?T3ZxVkZMblF0MzNPcGRCdHhvd1RIVkticzBVYll0aWxac2lHeFR6bUVjcmN0?=
 =?utf-8?B?bXBmd2w1UnZpRlRnSjRNRFcrNEd3MjJUeDFSRWpRMnRvYyt4NHdRa20veHVB?=
 =?utf-8?B?M01lNVdvZ1pPM3Y2U01Obno4a2w5d1FsWnhJMFlUZitPZ3Z1UE5ZSHVyNkZ1?=
 =?utf-8?B?ZGxZSWR4ZHdjMUxTZW5CdzB5MmtIZ1U1K3d0MThwNm0vNDh3U2pWYmVvZDlo?=
 =?utf-8?B?ZnNkSkFKUWE3cHhQVjBlTU8xdHdSN24yR3liV2tNdlpTekZlK3NrZTNrMERs?=
 =?utf-8?B?bWdyKzR2RGxEWjY3NXkzcW5oR05lcjZMeURzSGYzTVJaeGVrbVNWT2xqdjFt?=
 =?utf-8?B?OHZiTWdhS3hWdDFvSE9Tdk1YT1NiNXQ2RDNoR0tMQ01QeElPMDZydWFoc2NT?=
 =?utf-8?B?TjlITXpQRjBjTzFuQXJBNS8xWGhObjZlS2ozV2FybDA4YTl6dnllckl6VUNF?=
 =?utf-8?B?b0RXOGNFOUNNbHBlZnNpMlBkdnRIM25BR1BaU2c0WTk2eUZZZkozRnZuQ2li?=
 =?utf-8?B?bDdXNDk0NC81c1hWcXhGdTlqWFNsdSthaitnVDh1bDI3OVk0enA2S2pRSHh4?=
 =?utf-8?B?bzZDU3lIeTg2UFR6UnVaV2lhMUErNitwdmlEZ0g0ZVpDMzlEaHNiRlVBNEha?=
 =?utf-8?B?TVhsd2lheW40TjQrUnUzQUt1NnJMZGE2b1BMS21wZGRjMDJGZzRiN21YMk92?=
 =?utf-8?B?WEp4WEFDbGFwb2s2bXdUU0dGUmtvOXRwN1lWcDY0Qlh4NWo3SCtQdkh2N2NQ?=
 =?utf-8?B?blhOZ2NBRGZBcXVjU0lXaDJXS0R6eXhTc3VBdkRIbTRrYmpya2U3YS9NT2xM?=
 =?utf-8?B?b08xOWRiS0hmVDVBTWVYZ1EraEgzU29INFZuNmpMM1VrNDNJMmhoSWF6OERr?=
 =?utf-8?B?YmN6aUE2RlBvR3dJRnRoaTRLQjNEN0czYjJsTTNuUm9ZZzZSYUVwMUlwMDBP?=
 =?utf-8?B?RTc2YXRlMmVtb1FJbUt6c3c0TW1xK3JwUjVlTjBxRHptd0FzQ3FZSVJPRXdJ?=
 =?utf-8?B?Lzd1YUoxeVU4czVkS0pDSk02bUh2ZGI1ZVFzMjZIT3RBNDhPVmNKSTlpMjFt?=
 =?utf-8?B?ZHpyYnFCTjZPL25FOUpZcUE1bFFtemZtY1JVT2V3Wnk5VXhNMTNJTUc2endF?=
 =?utf-8?B?TjY3dkdQRFBheDFKSnhSbmVoTkt4M1RyZ1dUSkZZWHFNdEZWR3hqdUU5K3Aw?=
 =?utf-8?B?dTFNMUNRSi9rK0JacGQyRzJOUnp5cFNTaXBlMVl2aU5MdnpyUWw3cWNaWFhp?=
 =?utf-8?Q?MW5sdH0Hxtgf3c/h/Y8dgH8PtG2MPV4COY/XqQ6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE47820A25B7184CB8195CE10D970144@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70be9e3b-eb5a-4ab8-fed3-08d986be07f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2021 22:34:58.3414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKdmyO+0C0QEBcs4Et21yCM3/strblJmFQ3s532c/AIdfs79FCbaKMrS7H8W7aC1mJ8vSkesboww0NkbMxa6M0Ml0RNQUC0/SdRzF4yOXrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gT2N0IDEsIDIwMjEsIGF0IDA1OjQ0LCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDI1IDIwMjEgYXQgMDg6NTMsIENoYW5nIFMuIEJh
ZSB3cm90ZToNCj4+IEhhcmRlbiBjb3B5X3VhYmlfdG9feHN0YXRlKCkgc28gdGhhdCBpdCBjYW4g
aGFuZGxlIHRoZSBjYXNlIHdoZXJlDQo+PiBfX3Jhd194c2F2ZSgpIHJldHVybnMgTlVMTC4NCj4g
DQo+IFRoYXQncyBhbiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwsIGJ1dCBkb2VzIG5vdCBleHBsYWlu
IHdoeSB0aGlzIGNhbg0KPiBoYXBwZW4gYW5kIHdoYXQgdGhpcyBwYXRjaCBpcyBhYm91dC4NCj4g
DQo+PiBUaGlzIGRvZXMgbm90IGhhcHBlbiBpbiBwcmFjdGljZSB0b2RheSwgYnV0IHRoZW9yZXRp
Y2FsbHkgY291bGQgaGFwcGVuDQo+PiBpbiB0aGUgZnV0dXJlLg0KPiANCj4gU28gd2hhdCBkb2Vz
IHRoZSBwYXRjaCAiZml4Ij8gV2hlbiB0aGUgc3ViamVjdCBzYXlzICJGaXguLi4iIHRoZW4gSSdt
DQo+IGV4cGVjdGluZyBhIGJ1ZyBpbiB0aGUgY29kZSB0byBiZSBmaXhlZC4NCj4gDQo+IFRoZXJl
IGlzIG5vbmUgYmVjYXVzZSB0aGUgdXNlIGNhc2Ugd2hpY2ggY2FuIHRyaXAgb3ZlciB0aGlzIGRv
ZXMgbm90DQo+IGV4aXN0IHRvZGF5LiBZb3UgYXJlIGFkZGluZyBpdCBsYXRlci4NCj4gDQo+IFN1
YmplY3Q6IC4uLi4uOiBQcmVwYXJlIGNvcHlfdWFiaV90b194c3RhdGUoKSB0byBoYW5kbGUgZHlu
YW1pYyBmZWF0dXJlcw0KPiANCj4gb3Igc29tZXRoaW5nIGxpa2UgdGhhdCBhbG9uZyB3aXRoIGEg
cmVhc29uYWJsZSBleHBsYW5hdGlvbi4NCj4gDQo+IEJ1dCBpbiBhIGxhdGVyIHBhdGNoIHlvdSBh
ZGQgaW4gdGhlIHZlcnkgc2FtZSBmdW5jdGlvbjoNCj4gDQo+PiArICAgIGhkci54ZmVhdHVyZXMg
Jj0gZnB1LT5zdGF0ZV9tYXNrOw0KPiANCj4gd2hpY2ggcHJldmVudHMgdGhhdCBhbHJlYWR5IGJl
Y2F1c2UgX19yYXdfeHNhdmVfYWRkcigpIGlzIG5vdCBpbnZva2VkDQo+IGZvciB0aGUgemVyb2Vk
IGJpdHMgaW4gaGRyLnhmZWF0dXJlczoNCj4gDQo+PiAJCWlmIChoZHIueGZlYXR1cmVzICYgbWFz
aykgew0KPj4gCQkJdm9pZCAqZHN0ID0gX19yYXdfeHNhdmVfYWRkcih4c2F2ZSwgaSk7DQo+IA0K
PiBDb25mdXNlZC4NCj4gDQo+IEknbSBub3QgYWdhaW5zdCB0aGUgY2hhbmdlIHBlciBzZSwgYnV0
IEknbSBub3QgYWNjZXB0aW5nIGNoYW5nZWxvZ3MNCj4gd2hpY2ggbWFrZSBubyBzZW5zZSBhdCBh
bGwuIE5ld3MgYXQgMTEuDQoNClRoZXNlIHR3byBoYWQgYmVlbiBpbiB0aGUgc2FtZSBwYXRjaCB0
aGF0IHVwZGF0ZXMgc3RhdGUgY29weSBmdW5jdGlvbnMgZm9yDQpkeW5hbWljIGZlYXR1cmVzLiBJ
dCB3YXMgc3VnZ2VzdGVkIHRvIG1vdmUgdGhpcyB0byB0aGUgcGF0Y2gsIHdoZXJlDQotPnN0YXRl
X21hc2sgaXMgYWRkZWQ6DQoNCiAgICBJIGRvbid0IGtub3cgd2hlcmUgdGhpcyBodW5rIGJlbG9u
Z3MgdG8uLi4NCg0KICAgIE1heWJlIGFzIGEgY29tcGxldGVseSBzZXBhcmF0ZSBwYXRjaCB3aGlj
aCBmaXhlcyB0aGUgY2FzZSB3aGVyZQ0KICAgIF9fcmF3X3hzYXZlX2FkZHIoKSBjYW4gaW4gdGhl
IHZlcnkgdW5saWtlbHkgZXZlbnQgcmV0dXJuIE5VTEwuLi4NCg0KSSBub3cgY29uc2lkZXIgaGVy
ZSB0aGUgTlVMTCBwb2ludGVyIGNoZWNrIGlzIG5vdCB0aGF0IG5lZWRlZCBpbiB0aGlzIHNlcmll
cy4NCknigJltIGdvaW5nIHRvIGRyb3AgdGhpcy4gQnV0IG1heWJlIEkgY2FuIGRvIHRoaXMgc2Vw
YXJhdGVseSBsYXRlciBpZiBuZWVkZWQuDQoNClRoYW5rcywNCkNoYW5nDQoNClsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sL1lSejNFV1FsN3BIRWFoZEZAem4udG5pYy8g
