Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF51A30AB0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhBAPVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:21:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:54450 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBAPVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:21:18 -0500
IronPort-SDR: f9xyplKf0/w2XxQ2GcBiBn2ZS2P5D/WDNxKw69Bbb2b4ln37T1nBBfTbfvjdEJ9y/sD2p5tooW
 LHoK1M69T5Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="244782192"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="244782192"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:20:36 -0800
IronPort-SDR: kGptxYEMffj/dI5HNRmqALy7tUqWIw+gTj7q61nDfw+seNkcwCKLC1G59+HIPojK0kRK1uUFGQ
 6YNTbdFhtj7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="432387264"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2021 07:20:36 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 07:20:36 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 07:20:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 1 Feb 2021 07:20:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 1 Feb 2021 07:20:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrXqTJ256vv6qQ3qfNVdirlD1+r88wVeBupgUdfgZrgSh7g7VMXKKdatHZybkyNbOArMoC79gnXOEsgSXH9p3acMqjKpOSyrDAPgD5RUoLYFlk/io9qWTlhWdTqfdKyTAsXS/4IsaO6PgTReXDWL56Jwas6CZRJ4s53O7ZO7+/mC2tvCrLLPCMLI4IQkRBLQiq+ZBvQK3/1MEBXXp/gN4W2EB4AooF9LdGzFG6CqXBdjAZLYTR7M+W6uOH3jbX2pNGjlWiSRsTYoVM39sZsd+Z4FOodlMiqS+BxTEAkXozTMh2Jxp+YW+QPeXQfKDn4zxCm6f5nB8IeYi6Ef24EJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti+zcc8oWwPPoDMv+dfN0Putj3d/sNqTCUb08x6Axuo=;
 b=S2UUmJPl8Ja0pF1lUir7LgIGQAU/+5E2zYjnuNxNs2+JBIGYOPQFSRKImmSzdh90pAyAwQ25+GA/G4N54NHiWCNwryoMUU97Ijci0VQepycyOo1JfQ043iCYimkwHfqQWhssd3OOJ099AcgXWwIwYG3IvKPmGthxk8UT6N+tDL67fGWwD9ZRF7f0yH6xOoHfszDieEQIOJ4WEYAeiJvhEisZkdxOJXOxIADLIsdikrMRBSNKiAxc0yuVHcSVIi7bjBhvB2Jv+VhgSCxhGkCFGCdQWKFF1q6v8JYPLhpkS2WEFXE5/ZLY/i8obCYfrQp14ZrkJt0+SHd5Rag8U6+Qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti+zcc8oWwPPoDMv+dfN0Putj3d/sNqTCUb08x6Axuo=;
 b=hfrE2cBBZuhO5f+C55UA1VVZqvXjl2QPSnpiFCvB2Pn4DsXLEmhC0AlvsVRqt2bnWLJHwYKeAk1f8BiCfRnDZn3lJU4yzYwRjp9k8LCyQ+KDKykIwmasSWE5aCvdomFKleWAtHiY8f0O2GOvug6fcyBcMqI3oc6ppUcL1YDGqr8=
Received: from MWHPR11MB1679.namprd11.prod.outlook.com (2603:10b6:301:f::12)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Mon, 1 Feb
 2021 15:20:34 +0000
Received: from MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c47e:d3c8:2a2f:8647]) by MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c47e:d3c8:2a2f:8647%10]) with mapi id 15.20.3805.028; Mon, 1 Feb 2021
 15:20:34 +0000
From:   "Gross, Mark" <mark.gross@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
Subject: RE: [PATCH v4 29/34] Intel tsens i2c slave driver.
Thread-Topic: [PATCH v4 29/34] Intel tsens i2c slave driver.
Thread-Index: AQHW9q6m5bq1TP9WY0WSsUa7iJ4vNapCklkAgADZLiA=
Date:   Mon, 1 Feb 2021 15:20:34 +0000
Message-ID: <MWHPR11MB167981115C3319942A4F777C8EB69@MWHPR11MB1679.namprd11.prod.outlook.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
 <20210130022124.65083-65-mgross@linux.intel.com>
 <016b292b-df7b-db6e-0935-3744d8343aa8@infradead.org>
In-Reply-To: <016b292b-df7b-db6e-0935-3744d8343aa8@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.53.49.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c66cf068-3f1b-4c14-d000-08d8c6c4ebbd
x-ms-traffictypediagnostic: MW3PR11MB4556:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4556935F122E069924547BA78EB69@MW3PR11MB4556.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZYUpqrSEb95K82NtmJJxG4hsxzW8pKo5ZQjcmQHnJdPtQwLEUT7cXoN8BExzTeP4qRNsHEYpnNEaFIWRD0wkKQy5HyKiKHy4NZFw/QrFCmvO+TlOA5ch/bcvqVsrWVztHtK2zrrGrCz3b8KiDZKhfJy8hucfr7tg8m9ybR8hpQwbPnBUkhnjjDNlGdZRbuzU/rfSzAQUNTaf6+Xoa8StmBmpByAbDpEr7tAhV7P+mdUIoPKpNpC8vIpRNKASu9OvpMUpfs56fN53MK/ob3TqsHK0wQKx6a21wULLaCtYQupgDiDbeL2dpPnVTc8f1e17y2ICy3iNt1LzBs2Of0Tm5fA2+LQ+QRmCXacBagOjIfVhL2rJiaMeIiKt5dvm/eJKRHfzvnvIVun1L84tWdFqQl9w5jbfGL2GBIoxL7rx8afxVsyoLn0RXC3249b85dIyCtd208BnPcMfcyp5ppfFLjRCFRzSqc5Hx+JPSFryDp7YUvNyICfA1mTDQCD5Gk0feYkt6llXBQT13bi9NJ+3GsI+KLXdnjZcT4VWdXTJ7J+FH3tawwbSXO2doCsD1JY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1679.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(52536014)(83380400001)(71200400001)(2906002)(5660300002)(64756008)(66946007)(66446008)(86362001)(66476007)(66556008)(76116006)(478600001)(26005)(53546011)(6506007)(186003)(7416002)(4326008)(55016002)(9686003)(8936002)(33656002)(110136005)(7696005)(316002)(8676002)(54906003)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MkdIK1pjbnVTNDdsVDczTkcrUXFJeEkzcmlHdmk3SVZ6RkhNUXMyNUdjdDkv?=
 =?utf-8?B?b2hHRHN0U3IxL0dPK0RPU0NnMHB5VUE2Zm81RjdJTGxCa3JiYWNBY3R2NDhr?=
 =?utf-8?B?TkRWYzFaN0kzazBtQXAybVZER1YyU3VnR3pqRWZyVUlpQUtIdFcxYXNBRDBj?=
 =?utf-8?B?eTIxVTU1ZzFvUjFZeWMzUGhPOVhNakx0ZmJwUitTZmVGSXJtWkgvNXhGWEFm?=
 =?utf-8?B?cjQ1MmJobWtpRDZsTWQvdjRRNFNiUTdCSGJNbjh3dTZoakh6NitKSWU3TlNq?=
 =?utf-8?B?TUZRa1ZmU2tpZUxta0E1SCs4Vm82TmtFOVVkcVB0bnB6ZHdEUEdHMWwzMFhZ?=
 =?utf-8?B?YjJmUThBTW9wMFdSN1dkNU42VTBsZklkLzdvNDRYRVF2NFh5UDNieGhucmNr?=
 =?utf-8?B?OWU3VCtML1NmanlRMTJXcVRUL04vS0ovRTRPUUh5K3FMbDdwSzdQb1JPMHEy?=
 =?utf-8?B?VVI0a2FPbHpoUit2ekZOK1JwUVpQWnY4cXFjL3ltOS9GOVRsWFlMQStXazhi?=
 =?utf-8?B?cDRieEI0Rkd3d1J5YkY3MDc2YUtkRDB2Mzc3NnBRSjUxYkFjUU16UC8zajdz?=
 =?utf-8?B?QlZYckJhaUp2TDhEYkdxV3FZY24rYnFodnpLV2JIa1ZNOEdvOW1vSVczbStt?=
 =?utf-8?B?b1UvNmRCM2ZqZnEycXdlVjVpdWY0S1ljRmhNM0dwWFB4ak1SRlF4WEtRY3ZE?=
 =?utf-8?B?WVdOWjJaU3dhU25aTkVQUHZ0SldrT3VQSjFqNUp2aEwvWWZCVEN4VDhFeFI2?=
 =?utf-8?B?Wk9rR3p1SU9CbkFIMjFNKzlUZlBjM0ZMdkVZSExPdGt5aFd4NmNMamM5Y3pa?=
 =?utf-8?B?c2xTSklESkZhZzhYY1VsQUZ0Z0pBM2hQYXkyMkRXS0ZUVU15YTZYQnVBY05m?=
 =?utf-8?B?WWcwWXVkM2FtU29QaTR4NEpTT0YrdDJzdkhicjdXckljN1RwWWl5UEJ0MFFN?=
 =?utf-8?B?SHpVbEJFTlZIR043bTkzWXRjVlRQMFppRXNSRStXMDNmYmxqc0U5dkIyQVhX?=
 =?utf-8?B?SlRJd2NRUGZ0aUNlKzgwdUFtU1NvOW41bFpMTDVuM1U5ZThvN0tvSEdxVzh0?=
 =?utf-8?B?bzZadE9YcnpJakhHamY5K0pJNU41T1hwOWp5OTNPRnlCVjM0dFdMaWtzWXhK?=
 =?utf-8?B?OE9OUGM2akVOVUlLdHlxWVJqb2Q4bkdQM1Q5d1NwaG5Id054c096TVM1cmw5?=
 =?utf-8?B?TGdoT2t1OXo4UlVZczIwMGJReHo1TXh4VTJNT2lFZ3FrOWVvYkVwc1JMR3hj?=
 =?utf-8?B?YTVBM0M4T3g2c1lRTDhORjh3c2Jzc1RtaUdWRlVQK1BZcHhMSjlNR3YxaVl1?=
 =?utf-8?B?WU5KVzh0Z2NvbVBBSytqZHJKL3NvWnFUV2IyVFdDN25YcXJ5citYTk9zV2hw?=
 =?utf-8?B?aDlvMm5uQW9RNk1UTXVFb1loemNnOExSSmFPQXBIWDdFcWpublhMNTdCV0sr?=
 =?utf-8?Q?M6HCNRZx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1679.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66cf068-3f1b-4c14-d000-08d8c6c4ebbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 15:20:34.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wDpayl/6CumbcWhflUdq/YqkHD+AjYhPK+Hoy2AdRjw6XKMirFZExbz4xG8n45GReh4mFdhXTXNTdDGCpICSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgSmFudWFyeSAzMSwgMjAyMSA2
OjE0IFBNDQo+IFRvOiBtZ3Jvc3NAbGludXguaW50ZWwuY29tOyBtYXJrZ3Jvc3NAa2VybmVsLm9y
ZzsgYXJuZEBhcm5kYi5kZTsgYnBAc3VzZS5kZTsNCj4gZGFtaWVuLmxlbW9hbEB3ZGMuY29tOyBk
cmFnYW4uY3ZldGljQHhpbGlueC5jb207DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBj
b3JiZXRAbHduLm5ldDsgcGFsbWVyZGFiYmVsdEBnb29nbGUuY29tOw0KPiBwYXVsLndhbG1zbGV5
QHNpZml2ZS5jb207IHBlbmcuZmFuQG54cC5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gc2hh
d25ndW9Aa2VybmVsLm9yZzsgamFzc2lzaW5naGJyYXJAZ21haWwuY29tDQo+IENjOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBDLCBVZGhheWFrdW1hciA8dWRoYXlha3VtYXIuY0BpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMjkvMzRdIEludGVsIHRzZW5zIGkyYyBz
bGF2ZSBkcml2ZXIuDQo+IA0KPiBPbiAxLzI5LzIxIDY6MjEgUE0sIG1ncm9zc0BsaW51eC5pbnRl
bC5jb20gd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9pbnRlbF90c2Vucy9L
Y29uZmlnIGIvZHJpdmVycy9taXNjL2ludGVsX3RzZW5zL0tjb25maWcNCj4gPiBpbmRleCA4YjI2
M2ZkZDgwYzMuLmJlOGQyN2U4MTg2NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21pc2MvaW50
ZWxfdHNlbnMvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9pbnRlbF90c2Vucy9LY29u
ZmlnDQo+ID4gQEAgLTE0LDYgKzE0LDIwIEBAIGNvbmZpZyBJTlRFTF9UU0VOU19MT0NBTF9IT1NU
DQo+ID4gIAkgIFNheSBZIGlmIHVzaW5nIGEgcHJvY2Vzc29yIHRoYXQgaW5jbHVkZXMgdGhlIElu
dGVsIFZQVSBzdWNoIGFzDQo+ID4gIAkgIEtlZW0gQmF5LiAgSWYgdW5zdXJlLCBzYXkgTi4NCj4g
Pg0KPiA+ICtjb25maWcgSU5URUxfVFNFTlNfSTJDX1NMQVZFDQo+ID4gKwlib29sICJJMkMgc2xh
dmUgZHJpdmVyIGZvciBpbnRlbCB0c2VucyINCj4gPiArCWRlcGVuZHMgb24gSU5URUxfVFNFTlNf
TE9DQUxfSE9TVA0KPiA+ICsJZGVwZW5kcyBvbiBJMkM9eSAmJiBJMkNfU0xBVkUNCj4gPiArCWhl
bHANCj4gPiArCSAgVGhpcyBvcHRpb24gZW5hYmxlcyB0c2VucyBJMkMgc2xhdmUgZHJpdmVyLg0K
PiANCj4gR29vZCwgaXQncyBPSyBub3cuDQo+IFRoZSByZXBlYXQgdjMgYW5kIHRoZW4gdjQgY29u
ZnVzZWQgbWUuDQoNCkhtbSwgSSdtIGNvbmZ1c2VkIHRvby4gIEkgc2hvdWxkIGhhdmUgb25seSBz
ZW50IHY0IG9uIEZyaWRheS4gIEknbGwgbG9vayBvdmVyIG15IGhpc3RvcnkgYW5kIGxvZ3MgdG8g
c2VlIGhvdyBJIGNvdWxkIGhhdmUgc2VudCB0byBibGFzdHMgb25lIG9yIFYzIGFuZCB0aGVuIFY0
LiAgIFVnaC4gIFNvcnJ5IGFib3V0IG1peGluZyB0aGUgVjMgYW5kIFY0IHBhdGNoZXMgaW4gdGhl
IHNhbWUgYmF0Y2guDQoNCkZXSVcgSSBtYWtlIGFuIG91dGdvaW5nIGRpcmVjdG9yeSBhbmQgZm9y
Z290IHRvIGNsZWFuIG91dCB0aGUgdjMgcGF0Y2hlcyB0aGF0IHdoZXJlIHRoZXJlIGZyb20gdGhl
IGVhcmxpZXIgcG9zdGluZy4gUmVzdWx0aW5nIGluIGEgbWl4aW5nIG9mIHRoZSBvbGQgYW5kIGN1
cnJlbnQgcGF0Y2ggc2V0LiANCg0KSSdsbCB3cml0ZSBhIHNjcmlwdCB0byBhdXRvbWF0ZSB0aGUg
Y3JlYXRpb24gb2YgdGhlIG91dGdvaW5nIGRpcmVjdG9yeSBmb3IgbmV4dCB0aW1lIHRoYXQgc2hv
dWxkIGNvcnJlY3QgZnV0dXJlIHNjcmV3IHVwcy4NCg0KSSdtIHZlcnkgc29ycnkgZm9yIHRoZSBu
b2lzZS4NCg0KLS1tYXJrDQoNCg0K
