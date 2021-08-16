Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894C93EDBFB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhHPRE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:04:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:63257 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhHPREW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:04:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="215625610"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="215625610"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 10:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="504999463"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 16 Aug 2021 10:03:47 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 10:03:47 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 10:03:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 16 Aug 2021 10:03:47 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 16 Aug 2021 10:03:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbK7s3J2wI6Eauw51aZfO1GuVWK6DXhf5UdoZ4SFhTlulR9kKt6bPlY+QMnUeXlQQ0kqqcuE/aGcSdzVjURU/2kZ4ot8tAuFIenGOPhaaQFdFIq7ACLSlPVCrdHeLboggyf+c2ocJHSbxSoYf+WmtF+CVXPcKI26qUR2qBcjGn831yk3zK2E2Tjmb/cJioasxhru7Ob/IqmrlD77BH3EFLjL27PrOQRHqJungwI2dWjjJvCfedU+V5RRkdCtW/4eMxY/ti1+y9YYuQl8XcZUdZ6O/jJhALJRE615g0Ywf0l5R8g0NwpWEpIFKiTUNZmIK4GivIFXA3VIcXe8l2kZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWM9uYtu0eUeeNdiKBaBEcaraSIz77/vD4Rwj9gVa0s=;
 b=h0bnumFXfv28/lZVN8QGRFDbuhwJD830olWmNGGTvk8T2RGF8TOw9hStBvFFCSRrTGulRCXP9yanI9CbGyCP/5/HoNd/qJIZuK+dbdCpkvEwv0gqNqfNapKY01vgp+3pM77ojSqc3Lnt6sp/xqWHA94tomEVHjaFyLKjl0OMdHTXacN3YcGRzzJJlwh5Bbd+8V/mN2BgO44tTGLifelMZnnTwlyE1TxLtK4DaeKF3OERlf+w6z2dfE1m4rKQQloGjrCPKx2nD85HHzU2EWuZqtucINiv2oxgjixvZkpdvHZ+Kx0gb5Xg5Z0wQxZYBDFAuHeLWXyzym8keMH7pG7/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWM9uYtu0eUeeNdiKBaBEcaraSIz77/vD4Rwj9gVa0s=;
 b=T5vC60dWBH9X3pXUCgLWIvBEQZ36fkh9ddjvPfpBemu+9b3MKoWFx+T1jXIp5hZvhwN75uN0Mj7154u2w9Xrns5VkCrwxkAOM6TScStG57cFx1I9fBncFPvlysYwRjZt9oBE/wvzQSHLrVvAp9s56kPAncVsoe0SWBV6bxJc92U=
Received: from MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16)
 by MWHPR1101MB2335.namprd11.prod.outlook.com (2603:10b6:300:73::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 17:03:45 +0000
Received: from MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::c5d2:7f65:9e5b:8f96]) by MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::c5d2:7f65:9e5b:8f96%8]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 17:03:45 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "vicamo.yang@canonical.com" <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Qin, Chao" <chao.qin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rajatja@google.com" <rajatja@google.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "mlimonci@amd.com" <mlimonci@amd.com>
Subject: RE: [PATCH v6 0/5] Add Alder Lake PCH-S support to PMC core driver
Thread-Topic: [PATCH v6 0/5] Add Alder Lake PCH-S support to PMC core driver
Thread-Index: AQHXhdLKczsnrIIfoku46xyXUizJUKtht+wAgBS9e5A=
Date:   Mon, 16 Aug 2021 17:03:45 +0000
Message-ID: <MW3PR11MB4523FCC5DAC0F92DD2E8BD4CF2FD9@MW3PR11MB4523.namprd11.prod.outlook.com>
References: <cover.1627710765.git.gayatri.kammela@intel.com>
 <e28d7d75-a7f2-eae2-f884-9a21ff6555d7@redhat.com>
In-Reply-To: <e28d7d75-a7f2-eae2-f884-9a21ff6555d7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.100.41
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 065dce40-487a-4f0c-7ade-08d960d7cecd
x-ms-traffictypediagnostic: MWHPR1101MB2335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB233545ABA5FCF4AC38B5103AF2FD9@MWHPR1101MB2335.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CM0l9XfiImjTBEPN9fESaDH1edmx//a+Y9Z1KdrtNRvT6zrbCroYxeFurLZSkG8FAyt8y6Mv1BNX67Zjl9wAVJiQQ07rO8LzsyZrrIz+jouBxfXt22HkgjBurqjktGkq5J4NlazzcXBmNVgzjTSxaE9qS/lK/NWSAFM803n9ErAmmEx0NUgKGwMnaMX5NYYdsNJacavNjpyxT/sq6bum68Et8nW4kvF3tFeiKCDYit8fw89CGAWQoXQcT8JlezbfpXzBpcKsP3Tn5c7JgCksGHFS7Z38Lz/6OuTWj8hzV9zSl/GYDeJvSMMKzEhYEF/Fo7X5OXT/DHFpTYK/bx2DKaJaEyMje7I4DqFu+MTkK3CTCbTVviV4ANySNfv45RNZc6a/i8KyqMUjQC1EviU6HvEUjyymufegrT/hAeQ+kDYgTrYFeNUvSxluuTB6IHuvOetYq0rwG3bDcr0KkGEPrwCk68PenoWDhvH43kvIZvZwCjLKRrHzP0kEv9wGM9EANX/k0Wbma/1VbEgcsylWUHWdBTuW9THL2utpHCY6mqjBlZMO2W+j038pML0AL6ZUgoACidohxIYl9xPvbFWaD24qJEZv0Iw8LbH5xHw6CxhiXXSfvzrDYbtQVS7qwcOfTa5zIUFBLYxwqDm98Z0p2WloB3m3BPvCCtStEJadjcpyF/3MfLD+S2UpWpDTyMvVnGNvGBslzWrnwIogTC+xpkJ5VL5tFyeoVG/iWUvfxpz3WXnouGIiJTTrr62ObQ1Lq59foN/zLGooHtKmSSc2vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(8676002)(186003)(2906002)(6506007)(316002)(53546011)(38100700002)(26005)(7416002)(66476007)(122000001)(76116006)(54906003)(8936002)(110136005)(33656002)(86362001)(64756008)(66556008)(66946007)(66446008)(4326008)(9686003)(7696005)(71200400001)(5660300002)(55016002)(478600001)(38070700005)(52536014)(83380400001)(88260200001)(226253002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWxnZW5sQVVjMGpDaERnYzJXMUdrU2JtZ0VMdWZOVVFObmpOcmZGWjVzZUxy?=
 =?utf-8?B?Z0RsL0xiYTJNd000V1Q3UXZ1WDhYYzlsdExOUVdYak1qVVN6dzBLK1Q4Qll4?=
 =?utf-8?B?K21UYjNtZTR2M0tyWit1dUZaOWgvdEVhdnNoclZpcWhSZzhNNktCb21SL1JO?=
 =?utf-8?B?S1JQNk9Hbk4wNGhTMk5vN2FuRUFmZHBCNytSMllRUXdSUWNyUy91b0xzaTJM?=
 =?utf-8?B?THRzckZIeDZCZytxR0tWSk1PVkZ2bWtVU2VBenZpZFkrS0NmMkFMNmlXVGxZ?=
 =?utf-8?B?dE9hMDYvRkdhUHRnOUZrbVZvdWMrQTVUVnZOa0V6Q0lhNU5TWUdOc0tZTVZS?=
 =?utf-8?B?RTJEVVh6WUIwaU5DVzNmZnJBUFlvc24yWml5RnkxU0RrMUhZN2lTY3pmcHVo?=
 =?utf-8?B?eHJFWlo2Rk9KM21OODB1YVlJd2h6aDBrU3NHdk1rM1A2YXdPaERCelV4cHdE?=
 =?utf-8?B?YUFaeFI0NzFiNlNqK05FTlJwRGdnNHcyeWxDRWNQWFFvM0paVHYwKzNaeHo0?=
 =?utf-8?B?WFNJbTJkN0VuT0RvRDNFd01HK0N0cGhoRmlBR05nUmhVdDY0dEU0R2RWOFdl?=
 =?utf-8?B?Z1lZc1hTZVlGVmtocTNtSW1GZzBTYVpPRFJweG1QUC9FVTVSOFlMei9zdFI1?=
 =?utf-8?B?VmRDZkwwV25LbE9Yd2hXenl2cHM0enJKZ0ZsNUhXbTlKeFB4MTJzaXhqZCt1?=
 =?utf-8?B?dm1OakFtYWpPeGdsQUNreUNVRkRzK2lCaWFGMzhpNXpSUkRDKzBnME95THNE?=
 =?utf-8?B?VDJwMjNQQXFpc0RZMkFZbUowMDFmbmNCRVd2VWVuUTVnNml5dmloK0NaOXRW?=
 =?utf-8?B?WFZJSUV3ZnhCdGpsMDBFcEQ4a3NiMUxXeXcxeUpvQlRCWStkVUxhWU9hQXBO?=
 =?utf-8?B?dUVPYmNSMmdxYXhkWkNodGZjUXpTQ2Evd2NiVCtkY3NLYkJaeTB3UENCbVRK?=
 =?utf-8?B?WEVKclh6Nmd2Q3FVYTRuME1laEhuUXNkK2FpZFJQZHhLK3hjeGR0RGliaWlX?=
 =?utf-8?B?UkR0bnpKcDluaGs2YkFERFRCZFRFWk13MklqeEoyaWEvVGdvYzlsTzJ0eDM2?=
 =?utf-8?B?VHVhb0QzN09uNklJbmVuMmlISmtJRVBBaDBXUXljYXBXcjVqd3Q3NGZJQ2Fz?=
 =?utf-8?B?MHNsd09XZmtEdzUzSWVFdFRScGVtMWRIYVNCZGVaOGd6TW10NkJ4dXpxdmRr?=
 =?utf-8?B?SGlpdDVZRzNRenZJdVNLUFZ4ckorL2dXZkprMVp4M0g2VkxycXFZOHdFWTU5?=
 =?utf-8?B?Q01Sd0tteDM2ck1Yb3BDQzVnMTRodkpMUlVHamdjZmtPSUFmMkhIWDFpc2VY?=
 =?utf-8?B?dU9kN0NXek1uVDBJaFRFM2VMTXZNeTFHSWU3eDNUQXd6Ty9UaWY0cWxrWHcv?=
 =?utf-8?B?NGRKSmtFR2R4SFRTbWJkMCtRUTBoUElNc0dvVDJzM0FRd3ZzN2djNEx2MDQ2?=
 =?utf-8?B?ZFJpMDFjdlpvYTRUTWcvOGJxc0Y3TzV2SjA4UHRKdlFYUW5KbitGY3JGZEg3?=
 =?utf-8?B?dHJucDlESndrbU5vV1RadmNJUUxNNWhwVVczNWZ2YjhDUFJTWDVBdVQ4QnMz?=
 =?utf-8?B?aVc4aUFwcmE2ZmdUQ3NyYjZHdFkxd2hyWC9HcWtlSXZ4RGtaK1ZhbVU3cjJp?=
 =?utf-8?B?bmFlZHI1dVdva3RPK0gzRTdBb3ZWZXNyN09nbG5XUDR3eDlUeCtHNENnM281?=
 =?utf-8?B?QVp6SWNRbWViU0FXcmxBbWR6RkVjcCtsckZ4Sk9WcDVLZGUvWXE4QlF6Q3lP?=
 =?utf-8?Q?KafC1jnXZ1dGweTpbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065dce40-487a-4f0c-7ade-08d960d7cecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 17:03:45.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEgBBSeIeTwsPuh65c1YjMK6KquRoPMSCdN6EUs/ceOGUUDe0qrVWrMC/9cFGUmrHA9MpUQfHvSkp64r0R+vEsrkMRANWix9VWhfg8TZUYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2335
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVn
b2VkZUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMywgMjAyMSA1OjE5IEFN
DQo+IFRvOiBLYW1tZWxhLCBHYXlhdHJpIDxnYXlhdHJpLmthbW1lbGFAaW50ZWwuY29tPjsgcGxh
dGZvcm0tZHJpdmVyLQ0KPiB4ODZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBtZ3Jvc3NAbGludXgu
aW50ZWwuY29tOyBpcmVuaWMucmFqbmVlc2hAZ21haWwuY29tOw0KPiBhbmRyaXkuc2hldmNoZW5r
b0BsaW51eC5pbnRlbC5jb207IHZpY2Ftby55YW5nQGNhbm9uaWNhbC5jb207DQo+IFBhbmRydXZh
ZGEsIFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT47IEJveCwgRGF2aWQg
RQ0KPiA8ZGF2aWQuZS5ib3hAaW50ZWwuY29tPjsgUWluLCBDaGFvIDxjaGFvLnFpbkBpbnRlbC5j
b20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgTWFzaGlhaCwgVGFtYXIgPHRh
bWFyLm1hc2hpYWhAaW50ZWwuY29tPjsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHJh
amF0amFAZ29vZ2xlLmNvbTsgU2h5YW0tc3VuZGFyLlMtDQo+IGtAYW1kLmNvbTsgQWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbTsgbWxpbW9uY2lAYW1kLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY2IDAvNV0gQWRkIEFsZGVyIExha2UgUENILVMgc3VwcG9ydCB0byBQTUMgY29yZSBkcml2ZXIN
Cj4gDQo+IEhpIEdheWF0cmksDQo+IA0KPiANCj4gT24gNy8zMS8yMSA4OjA3IEFNLCBHYXlhdHJp
IEthbW1lbGEgd3JvdGU6DQo+ID4gSGksDQo+ID4gVGhlIHBhdGNoIHNlcmllcyBtb3ZlIGludGVs
X3BtY19jb3JlKiBmaWxlcyB0byBwbWMgc3ViZm9sZGVyIGFzIHdlbGwNCj4gPiBhcyBhZGQgQWxk
ZXIgTGFrZSBQQ0gtUyBzdXBwb3J0IHRvIFBNQyBjb3JlIGRyaXZlci4NCj4gPg0KPiA+IFBhdGNo
IDE6IE1vdmUgaW50ZWxfcG1jX2NvcmUqIGZpbGVzIHRvIHBtYyBzdWJmb2xkZXIgUGF0Y2ggMjog
QWRkDQo+ID4gQWxkZXJsYWtlIHN1cHBvcnQgdG8gcG1jIGNvcmUgZHJpdmVyIFBhdGNoIDM6IEFk
ZCBMYXRlbmN5IFRvbGVyYW5jZQ0KPiA+IFJlcG9ydGluZyAoTFRSKSBzdXBwb3J0IHRvIEFsZGVy
IExha2UgUGF0Y2ggNDogQWRkIEFsZGVyIExha2UgbG93DQo+ID4gcG93ZXIgbW9kZSBzdXBwb3J0
IGZvciBwbWMgY29yZSBQYXRjaCA1OiBBZGQgR0JFIFBhY2thZ2UgQzEwIGZpeCBmb3INCj4gPiBB
bGRlciBMYWtlDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+IDEpIEFkZCBwYXRjaCAx
IHRvIHYyIGkuZS4sIE1vdmUgaW50ZWxfcG1jX2NvcmUqIGZpbGVzIHRvIHBtYyBzdWJmb2xkZXIu
DQo+ID4gMikgTW9kaWZ5IGNvbW1pdCBtZXNzYWdlIGZvciBwYXRjaCAyLg0KPiA+DQo+ID4gQ2hh
bmdlcyBzaW5jZSB2MjoNCj4gPiAxKSBEcm9wcGVkIGludGVsX3BtY18gcHJlZml4IGZyb20gdGhl
IGZpbGUgbmFtZXMuDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiA+IDEpIEZpeGVkIGFu
IGVycm9yIHJlcG9ydGVkIGJ5IGxrcC4NCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjQ6DQo+ID4g
MSkgVXBkYXRlZCBNQUlOVEFJTkVSUw0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5jZSB2NToNCj4gPiAx
KSBGaXhlZCBhbiBtb2R1bGUgbmFtZSBlcnJvciByZXBvcnRlZCBieSBDaGFvIFFpbg0KPiANCj4g
VGhhbmsgeW91IGZvciBmaXhpbmcgdGhpcy4NCj4gDQo+IEkgZXhwZWN0IHRoYXQgeW91IHdpbGwg
c2VuZCBhIG5ldyB2ZXJzaW9uIGFkZHJlc3NpbmcgQW5keSdzIHJlbWFya3MsIHNvIEknbQ0KPiBn
b2luZyB0byBkcm9wIHRoaXMgdmVyc2lvbiBmcm9tIG15IHF1ZXVlLg0KSGkgSGFucyEgSSBqdXN0
IHNlbnQgYSBuZXcgdmVyc2lvbiBhZGRyZXNzaW5nIEFuZHkncyBjb21tZW50cy4gVGhhbmtzIQ0K
PiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCj4gDQo+IA0KPiA+IERhdmlkIEUuIEJveCAoMSk6
DQo+ID4gICBwbGF0Zm9ybS94ODYvaW50ZWw6IHBtYy9jb3JlOiBBZGQgR0JFIFBhY2thZ2UgQzEw
IGZpeCBmb3IgQWxkZXIgTGFrZQ0KPiA+ICAgICBQQ0gNCj4gPg0KPiA+IEdheWF0cmkgS2FtbWVs
YSAoNCk6DQo+ID4gICBwbGF0Zm9ybS94ODYvaW50ZWw6IGludGVsX3BtY19jb3JlOiBNb3ZlIGlu
dGVsX3BtY19jb3JlKiBmaWxlcyB0byBwbWMNCj4gPiAgICAgc3ViZm9sZGVyDQo+ID4gICBwbGF0
Zm9ybS94ODYvaW50ZWw6IHBtYy9jb3JlOiBBZGQgQWxkZXJsYWtlIHN1cHBvcnQgdG8gcG1jIGNv
cmUgZHJpdmVyDQo+ID4gICBwbGF0Zm9ybS94ODYvaW50ZWw6IHBtYy9jb3JlOiBBZGQgTGF0ZW5j
eSBUb2xlcmFuY2UgUmVwb3J0aW5nIChMVFIpDQo+ID4gICAgIHN1cHBvcnQgdG8gQWxkZXIgTGFr
ZQ0KPiA+ICAgcGxhdGZvcm0veDg2L2ludGVsOiBwbWMvY29yZTogQWRkIEFsZGVyIExha2UgbG93
IHBvd2VyIG1vZGUgc3VwcG9ydA0KPiA+ICAgICBmb3IgcG1jIGNvcmUNCj4gPg0KPiA+ICBNQUlO
VEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAg
ZHJpdmVycy9wbGF0Zm9ybS94ODYvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgIDIxIC0tDQo+
ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSAt
DQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL0tjb25maWcgICAgICAgICAgICB8ICAg
MSArDQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL01ha2VmaWxlICAgICAgICAgICB8
ICAgMSArDQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9LY29uZmlnICAgICAg
ICB8ICAyMiArKw0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvTWFrZWZpbGUg
ICAgICAgfCAgIDYgKw0KPiA+ICAuLi4ve2ludGVsX3BtY19jb3JlLmMgPT4gaW50ZWwvcG1jL2Nv
cmUuY30gICAgfCAzMDkgKysrKysrKysrKysrKysrKystDQo+ID4gIC4uLi97aW50ZWxfcG1jX2Nv
cmUuaCA9PiBpbnRlbC9wbWMvY29yZS5ofSAgICB8ICAxNyArDQo+ID4gIC4uLi9wbWMvcGx0ZHJ2
LmN9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMA0KPiA+ICAxMCBmaWxlcyBjaGFu
Z2VkLCAzNTMgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+
IDEwMDY0NCBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvS2NvbmZpZw0KPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL01ha2VmaWxlDQo+
ID4gIHJlbmFtZSBkcml2ZXJzL3BsYXRmb3JtL3g4Ni97aW50ZWxfcG1jX2NvcmUuYyA9PiBpbnRl
bC9wbWMvY29yZS5jfQ0KPiA+ICg4NSUpICByZW5hbWUgZHJpdmVycy9wbGF0Zm9ybS94ODYve2lu
dGVsX3BtY19jb3JlLmggPT4NCj4gPiBpbnRlbC9wbWMvY29yZS5ofSAoOTUlKSAgcmVuYW1lDQo+
ID4gZHJpdmVycy9wbGF0Zm9ybS94ODYve2ludGVsX3BtY19jb3JlX3BsdGRydi5jID0+IGludGVs
L3BtYy9wbHRkcnYuY30NCj4gPiAoMTAwJSkNCj4gPg0KPiA+IENjOiBTcmluaXZhcyBQYW5kcnV2
YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4NCj4gPiBDYzogQW5keSBTaGV2Y2hl
bmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IERhdmlkIEJv
eCA8ZGF2aWQuZS5ib3hAaW50ZWwuY29tPg0KPiA+IENjOiBZb3UtU2hlbmcgWWFuZyA8dmljYW1v
LnlhbmdAY2Fub25pY2FsLmNvbT4NCj4gPiBDYzogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVk
aGF0LmNvbT4NCj4gPiBDYzogUmFqbmVlc2ggQmhhcmR3YWogPGlyZW5pYy5yYWpuZWVzaEBnbWFp
bC5jb20+DQo+ID4gQ2M6IENoYW8gUWluIDxjaGFvLnFpbkBpbnRlbC5jb20+DQo+ID4NCj4gPiBi
YXNlLWNvbW1pdDogYzdkMTAyMjMyNjQ5MjI2YTY5ZGRkZDU4YTQ5NDJjZjEzY2ZmNGY3Yw0KPiA+
DQoNCg==
