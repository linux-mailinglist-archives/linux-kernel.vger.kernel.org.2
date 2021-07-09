Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED93C2B8A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 01:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhGIXEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 19:04:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:8713 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhGIXEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 19:04:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="295433057"
X-IronPort-AV: E=Sophos;i="5.84,228,1620716400"; 
   d="scan'208";a="295433057"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 16:01:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,228,1620716400"; 
   d="scan'208";a="411904399"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 09 Jul 2021 16:01:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 9 Jul 2021 16:01:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 9 Jul 2021 16:01:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 9 Jul 2021 16:01:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THIfWaaPCDKEnxk9tE42jCffheqMOExeWHHLx43IdyhJzVYge9LSNYZuKlGhDG4x6b87YAcaKMzjWIzxYuN4G8l7eV+/aeXwSlHNe/oLGmU8wgFqi4oIKZr0Fd5w5XTgc/FW+MUYizMs8I3WOrddUXQ1rX6Qk9Act3u40LNlJzCYnRULz8S56gWwTKuhpioDohhhSIRJDEqu6ubUf4tCtZ/nXAL8wFyGAPqWd/HW7v66co2ogJVQZOuYny+2cmw2XhlTBwMNv6/wM5FswjUmEXoy+B0rr+ELtSZjOHzRk2CsT2z7v/Wf0oPuhU47RKsuRhqrz89yZA8CXfMnFMG1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSznHA+cCl1+KwwsSzkOiWFfzjNTtXSu6TKQt1ov0XM=;
 b=cOvNBUP5YdK5TJbTtlaquZ78nnfukzAPKfJpNx+3H3K2/uVAmBKLz1j3UVN6NjVIH1Nlk7SBszUb/nkQD1GT3jYxDInAPKplWSdQlGy/Ba2a0+tTSyVNWBSuJE2hgdsYtBVZ8Q4TrJFXcmCLx2if+dhGGxESAuTUP7WcMnp+/MOZ9Z5AmCBu6LyIS1UvhadityqKRxbgblCn949EWMSRFO7r3vRBaeqZEvGiahEtJim6fHJSJkWECz2zM3uCDtCseXvrd1iRaTUg80dc/sVvnpe42GxEFGHyKRkufW3HcWlDPR+nYwM6dKIMIg3TRwgS2jPPccNoJmd8GVUB5HRM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSznHA+cCl1+KwwsSzkOiWFfzjNTtXSu6TKQt1ov0XM=;
 b=o0P3p3VmRMJwHfqVKVpYfpInOPdHahMo6GhOqN1NCEBDGl6x4oIYYn3A0tXujl3CjVG8iEPwmOqeocamA1cdjZtbK7hsTcY+p56vKOJ9+pLygq1VYkfWxQ2hyYqb9gTNCP1+YRZXpL/VMixmQu0EHoiAG6+N71w96P7WQ3VjNKY=
Received: from DM6PR11MB4514.namprd11.prod.outlook.com (2603:10b6:5:2a3::17)
 by DM6PR11MB3468.namprd11.prod.outlook.com (2603:10b6:5:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 9 Jul
 2021 23:01:40 +0000
Received: from DM6PR11MB4514.namprd11.prod.outlook.com
 ([fe80::d874:77c5:a722:8067]) by DM6PR11MB4514.namprd11.prod.outlook.com
 ([fe80::d874:77c5:a722:8067%9]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 23:01:40 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "vicamo.yang@canonical.com" <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rajatja@google.com" <rajatja@google.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "mlimonci@amd.com" <mlimonci@amd.com>
Subject: RE: [PATCH v2 0/5] Add Alder Lake PCH-S support to PMC core driver
Thread-Topic: [PATCH v2 0/5] Add Alder Lake PCH-S support to PMC core driver
Thread-Index: AQHXc55r2hq0Skd3g0W+4r05nIJPbas5V1CAgAGUS+CAAA5HAIAAL6Wg
Date:   Fri, 9 Jul 2021 23:01:40 +0000
Message-ID: <DM6PR11MB4514DDF0FF984A48DFAB0572F2189@DM6PR11MB4514.namprd11.prod.outlook.com>
References: <cover.1625709047.git.gayatri.kammela@intel.com>
 <CAE2upjQK80HF+hADt+q9PQKpX6MntqQFQ+mcXRKkus1FvxvvRQ@mail.gmail.com>
 <MW3PR11MB4523BCD490ABA17CE3B5FD94F2189@MW3PR11MB4523.namprd11.prod.outlook.com>
 <3ea67145-f22d-a8fd-bdd1-35e774c8a1bc@amd.com>
In-Reply-To: <3ea67145-f22d-a8fd-bdd1-35e774c8a1bc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.100.41
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4a92399-ffda-4a8c-9c33-08d9432d832b
x-ms-traffictypediagnostic: DM6PR11MB3468:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3468AB70657F30B46AADE62DF2189@DM6PR11MB3468.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: roew7LT9Ok4cBqOYmPDl35g4+BiCDO7qT8kidv0KNpPzjibhZXPmZiy6EmMiSGKKOCfrZXArejukttLZxdJmpwbYry6CJ70kxr50oMRMGryjkNUqZC/ILeu/EHu44hD9Wxc7g7wMbQ+Fe/LwW3OBOMsde+f2P/4YkaVjYFCF4Mrxz62JUUy9v4JQawEPWB8wBnRtlnGBwoYIPgC2DRRYBT6SuGEw1X/SpgBGGcOjxrTyUzz7FbhKm94UyV6F9y+GLG7qjvDFW3Tya0M9V/hKDRFPi1YAuFLH4Z1Hbmgpe8O1Hb9/Aq3F2IFfEe2RZoDJrPh/hmIIcu5NKlniNw65G3GGech/K6nadpYzYEHZkfUUTDbZI682u7YLZkzfd+HBS7nnvVl5R2PRhosd+Q4UrxzBfBe/dimWfigU1eodfu4xo8VKXAXDUUCm209B66J//nLudagouHAhDMDnYmob5zPOBn4sdiZ+UvSfsvzuSVvv3YCMFPXl2nx/KYhimFsIij3s04gwiTvObYjWTI8i7M5QJnJRB3RvqrI1xBQW1xV2qKF3ub7p4Yh7QJkG4OGZMtPYsb7aAEaYGJks+N5cTu21E4J5ooGgLlHQv8oMZcjsHnz6W/l6XNj41zyaHCKtKVKjdbxFzxRBm4+gZQRj25KxaZmgFDGS88oV3i1387wJ66e0QSy0rD/g4b8GyE6++/qAay68cqNntBU9PGtsYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(33656002)(71200400001)(76116006)(86362001)(83380400001)(5660300002)(7416002)(478600001)(316002)(8676002)(122000001)(186003)(64756008)(4326008)(66476007)(26005)(9686003)(7696005)(54906003)(110136005)(55016002)(2906002)(6506007)(66556008)(8936002)(38100700002)(66446008)(52536014)(53546011)(66946007)(226253002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T291T0hQYVV5SDRkekpmL0ZrSkVtTTY3THNidlByUHF5THkzemR4T2xZQkxB?=
 =?utf-8?B?QzNzUkFka1JPZ0V6RGhvNTVidjFENG55UmZ2ejRlRXh4dkhrY3QxdFNzT0sx?=
 =?utf-8?B?eUxaUjhMMFVKVm5rdmpmY2ZOeldxYjFqazZVVWx4UncxbjZiWFUxaWpOVW5X?=
 =?utf-8?B?cnRRbHBTckpnMVlHOVZIWU1wTmRUWmphczc1SlMxRkk4eHpBMnJxUkk3M2Nu?=
 =?utf-8?B?VmJ2UjZTT1VuOEc0Z1hrQzVMSDNIdWZiRXJSRmI4T3dQTkQwK3poWlBFY292?=
 =?utf-8?B?eU41Vlh3SkRvckhlc1FzUDl4bVVROVd0OGEzbGhhTkNJTXRBUTVjdW5TdEV5?=
 =?utf-8?B?Y1V5b0prZHhldm9ZM0lzNnl1WXRNZC9mRWsvNTZIallVSGE4Yjk5NDAycit6?=
 =?utf-8?B?ZEpMWGxVZTRXUStXUUtJR2J4eC96b1g1VVRWcHJSRWM4Vm9uZExTcGhFaUx2?=
 =?utf-8?B?S3k1OHBkNVI2MGNJT0VOT211aWZkNTJKZTQxaTNlUHlJRGs3TTVVcTJGc1ZE?=
 =?utf-8?B?UzdvY1dYbW5zUGdoNGY3Mnc4MnJHdHZDMTMyYnR2bUIraEx3b3dHMFdvZktv?=
 =?utf-8?B?QTFCbkg0b2ptajcvbHNZWS9kR2JPc0xqU1diME10V2lzMGRVVEc3OUttc3Y1?=
 =?utf-8?B?NGpLQXVsdEhNalF4eU9sZlZ4QjlyTktCcmMzZ3ZTdUFnblhjb3owUFpjRFZT?=
 =?utf-8?B?VHNrMVNZS3czczJra3pVSEhFVVVSdFh3RnJLa1BrSlVWSlRMaWJ1T01vU0Vn?=
 =?utf-8?B?N2FES1prVHBscEl6ME8yMHExOWl3OW9pMXpIcVp5SUdCTnl6YmRjYXphNlV0?=
 =?utf-8?B?ck1ucWVTWTNKaFh2aUpNVWwweUtkMzU2L0Jnclo0dUN3a0R0V0ZIaUt0b1Na?=
 =?utf-8?B?ZTh2RGEyNk1IU2RZbUI5azluVzM0azg0Z1FzVloycnRaNlVXbEpOL3pac01s?=
 =?utf-8?B?K0JXMGhYQ3QxamdOUzRabWwwOW5waE1oUEIwYmIxdzRnVGJ1cjNOZm9CQkpm?=
 =?utf-8?B?MEVXWjh5L3J5L0ZYWWlZcGQzeTBCSE9leWpEVnJuVkdNazJ1MkZHUWRkKzlv?=
 =?utf-8?B?cFBQYkYrUW4rN1U2TW1QRUIyT08wMzZBaXVLS3Bja01MdFAzRGVONUtTbVhE?=
 =?utf-8?B?Z0tQUnNrcEJSWEVmYXpzWUtFaTVTS0V5Zm9Zb2E1cDVJRlQrcHlrUXFCVFZj?=
 =?utf-8?B?OFZNVUE5djRERk9TazRxV2N6bkVCU2hUam41UFBQSmxRRGtBYzB5TnA0bGV6?=
 =?utf-8?B?YjNsM0t0SlNYODlxeVp0MUQ3b0ttZXUybGZzSnZSQTVkd0R0QXZtL2oyUEdL?=
 =?utf-8?B?eFhoc1JHbktNM2FBbm9nb1NGSkN6cllIdjM2azZjT3U2ekMzK29zb29iSzFU?=
 =?utf-8?B?TmhTNkFvYzZ3c3ZwanJOcDhCdlp1b3Z0OHhyNTlRU1N1dzl3L0NubEYxbW92?=
 =?utf-8?B?QUU1ZHR2dGFaa2dHQTFSei9VTnpsNVVFNXMrSG50dFhmMjUyQXBrckVpeWd0?=
 =?utf-8?B?SEh0bmRJb0xwT0NlZ3NpYzM0UVlLbFRmVGg1eno0ZmRURldCWGZocWZaSTdk?=
 =?utf-8?B?Qm4yVTk4cFcrb3g0YzljTnRmMFZETEZZOThSL0t5SU5UZUJCQkNaRU0yVUtv?=
 =?utf-8?B?LzZYKytMK3g1SzZJWkh4MG94WUxxbGpYbERUZ1FwblRqNkUwMWtqQjFTZ1VX?=
 =?utf-8?B?aXpCcE1jZjIwNE4rVGZCdGtXdVRyOEV1ZDUrVk0zSGdJRGtrWkwvcktGL2Rj?=
 =?utf-8?Q?64O/HbNpcKnPNM8OzI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a92399-ffda-4a8c-9c33-08d9432d832b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 23:01:40.1892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4U83RiR2+KRp7FyXGeIr6z/Hac6h6uqd6lSwYEyEjHde/I/xpox65ywdg9iXHj3FtFiokn2f0bzhm03tohnej8ZI31Rb9gODeKphYdrp8u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3468
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8g
PG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSA5LCAyMDIx
IDExOjMxIEFNDQo+IFRvOiBLYW1tZWxhLCBHYXlhdHJpIDxnYXlhdHJpLmthbW1lbGFAaW50ZWwu
Y29tPjsgUmFqbmVlc2ggQmhhcmR3YWoNCj4gPGlyZW5pYy5yYWpuZWVzaEBnbWFpbC5jb20+DQo+
IENjOiBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsgbWdyb3NzQGxpbnV4Lmlu
dGVsLmNvbTsNCj4gaGRlZ29lZGVAcmVkaGF0LmNvbTsgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmRy
aXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+OyB2aWNhbW8ueWFuZ0BjYW5vbmljYWwuY29t
Ow0KPiBQYW5kcnV2YWRhLCBTcmluaXZhcyA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+
OyBCb3gsIERhdmlkIEUNCj4gPGRhdmlkLmUuYm94QGludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IE1hc2hpYWgsIFRhbWFyDQo+IDx0YW1hci5tYXNoaWFoQGludGVsLmNv
bT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiByYWphdGphQGdvb2dsZS5jb207IFNo
eWFtLXN1bmRhci5TLWtAYW1kLmNvbTsNCj4gQWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbTsgbWxp
bW9uY2lAYW1kLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvNV0gQWRkIEFsZGVyIExh
a2UgUENILVMgc3VwcG9ydCB0byBQTUMgY29yZSBkcml2ZXINCj4gDQo+IE9uIDcvOS8yMDIxIDEy
OjQwLCBLYW1tZWxhLCBHYXlhdHJpIHdyb3RlOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+PiBGcm9tOiBSYWpuZWVzaCBCaGFyZHdhaiA8aXJlbmljLnJham5lZXNoQGdtYWls
LmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEp1bHkgOCwgMjAyMSAxMDozMyBBTQ0KPiA+PiBU
bzogS2FtbWVsYSwgR2F5YXRyaSA8Z2F5YXRyaS5rYW1tZWxhQGludGVsLmNvbT4NCj4gPj4gQ2M6
IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBtZ3Jvc3NAbGludXguaW50ZWwu
Y29tOw0KPiA+PiBoZGVnb2VkZUByZWRoYXQuY29tOyBBbmR5IFNoZXZjaGVua28NCj4gPj4gPGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IHZpY2Ftby55YW5nQGNhbm9uaWNhbC5j
b207DQo+ID4+IFBhbmRydXZhZGEsIFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVs
LmNvbT47IEJveCwgRGF2aWQgRQ0KPiA+PiA8ZGF2aWQuZS5ib3hAaW50ZWwuY29tPjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgTWFzaGlhaCwgVGFtYXINCj4gPj4gPHRhbWFyLm1hc2hp
YWhAaW50ZWwuY29tPjsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+ID4+IHJhamF0amFA
Z29vZ2xlLmNvbTsgU2h5YW0tc3VuZGFyLlMta0BhbWQuY29tOw0KPiA+PiBBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tOyBtbGltb25jaUBhbWQuY29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMC81XSBBZGQgQWxkZXIgTGFrZSBQQ0gtUyBzdXBwb3J0IHRvIFBNQyBjb3JlDQo+ID4+IGRy
aXZlcg0KPiA+Pg0KPiA+PiBTZXJpZXMgbG9va3MgZ29vZCB0byBtZS4NCj4gPj4NCj4gPj4gQWNr
ZWQtYnk6IFJham5lZXNoIEJoYXJkd2FqIDxpcmVuaWMucmFqbmVlc2hAZ21haWwuY29tPg0KPiA+
IFRoYW5rcyBSYWpuZWVzaCENCj4gPj4NCj4gPj4gKyBBTUQgZm9sa3MNCj4gPj4NCj4gPj4gSGkg
QWxleCwgTWFyaW8gYW5kIFNoYXltIC0gUGVyaGFwcyBBTUQgUE1DIGZpbGVzIHNob3VsZCBhbHNv
IGZvbGxvdw0KPiA+PiB0aGUgc2ltaWxhciBjb252ZW50aW9uIGFuZCBpdCBjb3VsZCBwcm9iYWJs
eSBldm9sdmUgaW4gZnV0dXJlIHdoZXJlDQo+ID4+IGJvdGggeDg2IGJhc2VkIFBNQyBkcml2ZXJz
IG1pZ2h0IHVzZSBzb21lIGNvbW1vbiBsaWJyYXJ5IGhlbHBlcg0KPiA+PiBmdW5jdGlvbnMuIFdo
YXQgZG8geW91IHRoaW5rPw0KPiANCj4gR2F5YXRyaSwNCj4gDQo+IElmIHRoZXJlIGlzIGdvaW5n
IHRvIGJlIFBNQyBzdWJmb2xkZXIsIHRoZW4geWVzIG9mIGNvdXJzZSBhbWQtcG1jLmMgc2hvdWxk
DQo+IG1vdmUgaW50byBpdCB0b28uDQo+IA0KPiBBcmUgeW91IGFsc28gdGhpbmtpbmcgdG8gbW92
ZSB1UEVQIGNvZGUgZnJvbSBkcml2ZXJzL2FjcGkveDg2L3MyaWRsZS5jIGludG8NCj4gdGhlIFBN
QyBkcml2ZXJzPyAgT3IgZG8geW91IGhhdmUgc29tZSBzdWdnZXN0aW9ucyBvbiB3aGF0IGNvZGUg
Y291bGQgYmUNCj4gc2hhcmVkIGJldHdlZW4gQU1EIGFuZCBJbnRlbCBQTUMgZHJpdmVycz8NCkhp
IE1hcmlvISBJIGFtIG5vdCBwbGFubmluZyBvbiBtb3ZpbmcgYW55IG90aGVyIGNvZGUgdG8gcG1j
IHN1YmZvbGRlci4gSSBkb27igJl0IGhhdmUgYW55IHN1Z2dlc3Rpb25zLCBidXQgd2UgY291bGQg
YXNrIEFuZHkgYW5kIEhhbnMgb24gdGhlc2UgZmlsZXMuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiA+
Pg0KPiA+Pg0KPiA+PiBPbiBXZWQsIEp1bCA3LCAyMDIxIGF0IDEwOjEwIFBNIEdheWF0cmkgS2Ft
bWVsYQ0KPiA+PiA8Z2F5YXRyaS5rYW1tZWxhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4+Pg0KPiA+
Pj4gSGksDQo+ID4+PiBUaGUgcGF0Y2ggc2VyaWVzIG1vdmUgaW50ZWxfcG1jX2NvcmUqIGZpbGVz
IHRvIHBtYyBzdWJmb2xkZXIgYXMgd2VsbA0KPiA+Pj4gYXMgYWRkIEFsZGVyIExha2UgUENILVMg
c3VwcG9ydCB0byBQTUMgY29yZSBkcml2ZXIuDQo+ID4+Pg0KPiA+Pj4gUGF0Y2ggMTogTW92ZSBp
bnRlbF9wbWNfY29yZSogZmlsZXMgdG8gcG1jIHN1YmZvbGRlciBQYXRjaCAyOiBBZGQNCj4gPj4+
IEFsZGVybGFrZSBzdXBwb3J0IHRvIHBtY19jb3JlIGRyaXZlciBQYXRjaCAzOiBBZGQgTGF0ZW5j
eSBUb2xlcmFuY2UNCj4gPj4+IFJlcG9ydGluZyAoTFRSKSBzdXBwb3J0IHRvIEFsZGVyIExha2Ug
UGF0Y2ggNDogQWRkIEFsZGVyIExha2UgbG93DQo+ID4+PiBwb3dlciBtb2RlIHN1cHBvcnQgZm9y
IHBtY19jb3JlIFBhdGNoIDU6IEFkZCBHQkUgUGFja2FnZSBDMTAgZml4IGZvcg0KPiA+Pj4gQWxk
ZXIgTGFrZQ0KPiA+Pj4NCj4gPj4+IENoYW5nZXMgc2luY2UgdjE6DQo+ID4+PiAxKSBBZGQgcGF0
Y2ggMSB0byB2MiBpLmUuLCBNb3ZlIGludGVsX3BtY19jb3JlKiBmaWxlcyB0byBwbWMNCj4gPj4+
IHN1YmZvbGRlcg0KPiA+Pj4gMikgTW9kaWZ5IGNvbW1pdCBtZXNzYWdlIGZvciBwYXRjaCAyLg0K
PiA+Pj4NCj4gPj4+IERhdmlkIEUuIEJveCAoMSk6DQo+ID4+PiAgICBwbGF0Zm9ybS94ODY6IGlu
dGVsX3BtY19jb3JlOiBBZGQgR0JFIFBhY2thZ2UgQzEwIGZpeCBmb3IgQWxkZXIgTGFrZQ0KPiA+
Pj4gICAgICBQQ0gNCj4gPj4+DQo+ID4+PiBHYXlhdHJpIEthbW1lbGEgKDQpOg0KPiA+Pj4gICAg
cGxhdGZvcm0veDg2OiBpbnRlbF9wbWNfY29yZTogTW92ZSBpbnRlbF9wbWNfY29yZSogZmlsZXMg
dG8gcG1jDQo+ID4+PiAgICAgIHN1YmZvbGRlcg0KPiA+Pj4gICAgcGxhdGZvcm0veDg2L2ludGVs
OiBpbnRlbF9wbWNfY29yZTogQWRkIEFsZGVybGFrZSBzdXBwb3J0IHRvDQo+IHBtY19jb3JlDQo+
ID4+PiAgICAgIGRyaXZlcg0KPiA+Pj4gICAgcGxhdGZvcm0veDg2L2ludGVsOiBpbnRlbF9wbWNf
Y29yZTogQWRkIExhdGVuY3kgVG9sZXJhbmNlIFJlcG9ydGluZw0KPiA+Pj4gICAgICAoTFRSKSBz
dXBwb3J0IHRvIEFsZGVyIExha2UNCj4gPj4+ICAgIHBsYXRmb3JtL3g4Ni9pbnRlbDogaW50ZWxf
cG1jX2NvcmU6IEFkZCBBbGRlciBMYWtlIGxvdyBwb3dlciBtb2RlDQo+ID4+PiAgICAgIHN1cHBv
cnQgZm9yIHBtY19jb3JlDQo+ID4+Pg0KPiA+Pj4gICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29u
ZmlnICAgICAgICAgICAgICAgICAgfCAgMjEgLS0NCj4gPj4+ICAgZHJpdmVycy9wbGF0Zm9ybS94
ODYvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAxIC0NCj4gPj4+ICAgZHJpdmVycy9wbGF0
Zm9ybS94ODYvaW50ZWwvS2NvbmZpZyAgICAgICAgICAgIHwgICAxICsNCj4gPj4+ICAgZHJpdmVy
cy9wbGF0Zm9ybS94ODYvaW50ZWwvTWFrZWZpbGUgICAgICAgICAgIHwgICAxICsNCj4gPj4+ICAg
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL0tjb25maWcgICAgICAgIHwgIDIyICsrDQo+
ID4+PiAgIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9NYWtlZmlsZSAgICAgICB8ICAg
NSArDQo+ID4+PiAgIC4uLi94ODYveyA9PiBpbnRlbC9wbWN9L2ludGVsX3BtY19jb3JlLmMgICAg
ICB8IDMwNyArKysrKysrKysrKysrKysrKy0NCj4gPj4+ICAgLi4uL3g4Ni97ID0+IGludGVsL3Bt
Y30vaW50ZWxfcG1jX2NvcmUuaCAgICAgIHwgIDE3ICsNCj4gPj4+ICAgLi4uL3sgPT4gaW50ZWwv
cG1jfS9pbnRlbF9wbWNfY29yZV9wbHRkcnYuYyAgIHwgICAwDQo+ID4+PiAgIDkgZmlsZXMgY2hh
bmdlZCwgMzUwIGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4g
Pj4+IDEwMDY0NCBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvS2NvbmZpZw0KPiA+Pj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL01ha2Vm
aWxlDQo+ID4+PiAgIHJlbmFtZSBkcml2ZXJzL3BsYXRmb3JtL3g4Ni97ID0+IGludGVsL3BtY30v
aW50ZWxfcG1jX2NvcmUuYyAoODUlKQ0KPiA+Pj4gcmVuYW1lIGRyaXZlcnMvcGxhdGZvcm0veDg2
L3sgPT4gaW50ZWwvcG1jfS9pbnRlbF9wbWNfY29yZS5oICg5NSUpDQo+ID4+PiByZW5hbWUgZHJp
dmVycy9wbGF0Zm9ybS94ODYveyA9PiBpbnRlbC9wbWN9L2ludGVsX3BtY19jb3JlX3BsdGRydi5j
DQo+ID4+PiAoMTAwJSkNCj4gPj4+DQo+ID4+PiBDYzogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jp
bml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+DQo+ID4+PiBDYzogQW5keSBTaGV2Y2hlbmtvIDxh
bmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+ID4+PiBDYzogRGF2aWQgQm94IDxk
YXZpZC5lLmJveEBpbnRlbC5jb20+DQo+ID4+PiBDYzogWW91LVNoZW5nIFlhbmcgPHZpY2Ftby55
YW5nQGNhbm9uaWNhbC5jb20+DQo+ID4+PiBDYzogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVk
aGF0LmNvbT4NCj4gPj4+DQo+ID4+PiBiYXNlLWNvbW1pdDogYTkzMWRkMzNkMzcwODk2YTY4MzIz
NmJiYTY3YzBkNmYzZDAxMTQ0ZA0KPiA+Pj4gLS0NCj4gPj4+IDIuMjUuMQ0KPiA+Pj4NCj4gPj4N
Cj4gPj4NCj4gPj4gLS0NCj4gPj4gVGhhbmtzLA0KPiA+PiBSYWpuZWVzaA0KDQo=
