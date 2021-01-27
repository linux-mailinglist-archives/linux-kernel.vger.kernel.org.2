Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5EA305041
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhA0DxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:53:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:12672 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391974AbhA0BZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 20:25:39 -0500
IronPort-SDR: KqqT9UmTKLCUdpfaX6CGYWB8y0Q8f1Q8zPJ/iISRfD2I3vPb9Xg9ArlPoeM8sPC5tG+shCuUcD
 a2/WitnGCf6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180145370"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="180145370"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 17:23:29 -0800
IronPort-SDR: jxpBjdk366odujts8M59hctgKJ1YYNg+1Yn653a8rcZiWqEi7AhjZH+DS8iq/e3v5lJV1k8qqV
 oDQXPubTC8Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="406929208"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2021 17:23:29 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 17:23:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 26 Jan 2021 17:23:28 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 26 Jan 2021 17:23:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tsl0EQNd/7hRjED4s0MJss5btp7CJQ05pjKlRQgidp8ooVQ8XKlH2NWxT/f7ppmomEv9IzunF4tWztinBmvCkl6uNdRqXYHlCrYJ7Up8cEp8F6+c9EI2uke/xoTUvdfw9kPmqG59YbpyescwexE1erKgSA2oa52oaxSYOW2spRUSAn2qiBKvtCC4Xz+vgdNl9b4vglYHD70WKHJaymWtXoKu+Bv0nq0rFZGJ4c09Zl9G/Fp+JsrAOOzVokr9ibwd4ghgriDVC/c4eD0SX2vJEMnyiSHDg7jUq+EshCLD7bLCKcJ2aeKOibcrLz6/TyfJzx4h+/K6Fhv3Pmki8mBxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4DRJMvLcA8ZcDa5DWeNSUGLFjD5ZIO6l4bGqwqicb8=;
 b=YXuv8tPcdzlIQuwSGSbkWE3KTsG+XVpoY6C5tXuQgjyDPH6Wu1zvJ3BddT+8N3CBJrN5TM9WcC/050NOuidwz7IviRW5y6J4t3SrcXlYbBXc6vQrVRjLHr5XfuHXPppKQnxrvd3AGrxnkJrFzRVQzagCj1GbETZEWK4sV/MPuTwvUsd/s1rPZ6Bd67qhqW5eefavxPnDGjxj0NjtAQ2lQmrAuE2iL/oUmZvGZATcQnb1lEgP5K50DUJYe/9Aj0d+ck/8/I4PCtBI68vywIEJgIYjO9XQAmWZly0UTPrDh6Qxf4kdwb6UMfSxochdgp9FOw3Rjh4bhpWsVZgz7jRCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4DRJMvLcA8ZcDa5DWeNSUGLFjD5ZIO6l4bGqwqicb8=;
 b=iu2XfbhAZaM237nkOrG5sgj2wqYrVb3Agi4taXo0yKyjjOw66E3zlrUcxlsdtGas2k4G34SmWeTppSKaI4KEf/Ahe+w8kWgEz/OZfWkJORljkot1jKwoSGJRlW1uN7x8ZhvSsoQTSPU2GdYIbghYrNn7p4Vyktny0HnSghA4bmM=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 01:23:26 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 01:23:26 +0000
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
Subject: Re: [PATCH v3 05/21] x86/fpu/xstate: Add a new variable to indicate
 dynamic user states
Thread-Topic: [PATCH v3 05/21] x86/fpu/xstate: Add a new variable to indicate
 dynamic user states
Thread-Index: AQHW2UTormq3m1yC2UO34PiN5/gVtKoo1SIAgABm4gCABgkoAIAAMiUAgAQwoQCABzuIgA==
Date:   Wed, 27 Jan 2021 01:23:26 +0000
Message-ID: <ECD78824-BE93-4D84-B5F6-C5D4BF9441C6@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-6-chang.seok.bae@intel.com>
 <20210115133924.GE11337@zn.tnic>
 <E7E5BE72-C3AB-4ABB-93B5-EF040595442E@intel.com>
 <20210119155758.GF27634@zn.tnic>
 <EF7FB3DA-868D-4597-B841-F786E094BFCF@intel.com>
 <20210122105632.GA5123@zn.tnic>
In-Reply-To: <20210122105632.GA5123@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50afc459-8bf1-4059-ec32-08d8c2622565
x-ms-traffictypediagnostic: PH0PR11MB4885:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB48858B3F5CAEBA8EC90B0018D8BB9@PH0PR11MB4885.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xU65+b7Q7TTTkVjEhd+kEAp9eP36s1qaHPZNlCnwAQStdxmPuHxaLTOPXE9xGVv6UMCUIwY6t0jPgE4SdtfwAk4guAcqxbZInDa22t87HmgAJ0SVq+MkGdlmE0ipf/c/dx8GtYHiyLt0fkXpP1Ky7Td43+ZjxnILQ9MgDYF+clOH6qHJ+9PEXDN0rfavZB274qaT+9lwi9FYLV24kok/X1d2zJbzwNEf37VyMd4FWsM6G87h6ebQxnJlKms1sn6RAkboqHTu32sh7e8SQ+bwtX0en1xD6xn8SKUAR23Do07BD7ld0S6gkZTafmflvrGxuC2RvYwT00u5TP4EfmNIUCrJSROtia9BMcp9t4jjnid3foAaMZChSybemj65pL8flGVn5geoYCNDFQ14zIpq1+zAwryCbpScHtWOgav+7zqVTZ2q9eXmSe88gc6g6v+0qYnexrjTyquHmlBJ9yv77S6Kr8iP+iluJe63NINQONNBPkEM0qqUstanWqqKkAku55xQs24VLf3auwcdGYMt4SfnyQYMtPtWEAwVSc3ZtJQ6Rvia73n/VMuGAnJ7RoqsehrBOlmiwlNH55jcT6TA7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(186003)(91956017)(76116006)(2616005)(53546011)(33656002)(6506007)(2906002)(8676002)(66946007)(26005)(8936002)(36756003)(66476007)(64756008)(6486002)(66446008)(66556008)(6512007)(4326008)(478600001)(6916009)(5660300002)(71200400001)(86362001)(316002)(83380400001)(4744005)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c1ZtTGt2Mjh6TlExZnVqZVU5RTgzdVBEYW1Sa3Fvcy9zWVZWc2ZOWnFGdklP?=
 =?utf-8?B?bGpvL1RqZzQvTDc2WUFwTEQ0N0c2WmhXcVBRR2xabldGQ3hURXQ4cGlmNW9S?=
 =?utf-8?B?V2xaWko0dU8wd2EvZ2IzcEFDR3JzOWpFbjlWQlFnZEV2d2RYanh6ZGkxZ0RR?=
 =?utf-8?B?VFVpRE5TeEJKdFNsMVJ5VTRJamRvdkVPRFRVWFR2dGE1NXkwMDNHTk9hcjBW?=
 =?utf-8?B?K3pzeW9SV1Z5SWc4QXVuQ0ltNmh2emovREQ1NHljNkxmZ09OclNRNDlxQ2s3?=
 =?utf-8?B?TWl5eEFDQ0UvRWtMbjErMjhhanpobnhvZ05yK2lwVldTenh2RzUxdGphRUl5?=
 =?utf-8?B?UTZoZ0tuNktMdTZHUDVQbUNEMXMyYlY4cGJUeWtlZDlYS200NGlnbUd1NzVW?=
 =?utf-8?B?VGViM3JGc0JTc2JQTWJ1ejlZTDFIUGF4UDRVcmZDMEo4SU1qRzVUeERzNGNa?=
 =?utf-8?B?TjdTSkVKMVNQOHBiaFJMQjVlT0JUSVFrMW5xUVJPdndYemt4U2g1QzV0aVhC?=
 =?utf-8?B?OFhoWVpSVE1oR1hhbzhYZDRlNkp6alh3NVhJRWVNeW9iZEFXWDAyK1o2QjJV?=
 =?utf-8?B?MTdiTHYwNlNBQVRHUHN4QlRsU2tzUEdMd3pPZEtxek9xc09VSHViUEtpTEdB?=
 =?utf-8?B?NzFmYW5GUjNXQXFlaTVEVHpmTzFWUXBUbGVyYnIwMkRIa3M5aVNBcmlNMys3?=
 =?utf-8?B?Kzd5NTJnUkFJRUxGWk9DTWZJMEU2R1ZqN3ZLZ09SVFFadXl1RnJraHFDcE8w?=
 =?utf-8?B?aTIyc1NGUW5XNUVzbDR3bEdZdCtvSU10TTdVVTFleUZ2NmVEVWh2RzA5S2tr?=
 =?utf-8?B?TUNUWDh1TGV2V28vQ2dLcU9PelZoUzJxdW5iUUJHZmVkejFMbCtRZTAvRURC?=
 =?utf-8?B?ZlpGSGxKek5pV0diOXhOdkswckVLZVBxdTBza05PK2VkalpvM3I1NzVBaDVu?=
 =?utf-8?B?ZXBzZGsyVWdHV0tpZUdibGlsZSt6S0hnVWpFblF3RStKNThxVndkUlV0bm5p?=
 =?utf-8?B?U0pQSkFmVUc2OER4UTcySk1GS0pCN2FGeTdaQnhNSlRac3k3RGNEZjM1NjBW?=
 =?utf-8?B?eHNYNkFPTGJyY0Nudk02TkNDSXZOYTB5MEw3a05jRVRTQUlaandXOG5KcDZv?=
 =?utf-8?B?dzNCV21IczNzYmNsOXdDclRjZWNlQnFsVHlEa1N4dTk4NXJBb3ZSMVh5MVFv?=
 =?utf-8?B?WGYxN1ZjMEVHK2xxZmcrczdrTEU5UVN2Y2ZTVXluMlhIL1lvbmJVVGQrWGww?=
 =?utf-8?B?eEtxRWIxblpjNWowYk55ZWRvZGxqUzFWd1Roc3RpUnNWVzdoa3NpRDBST0JM?=
 =?utf-8?B?NjRQV2hhS1hMcXNrbGFkUC9Fa2gydE5FcmpFS1I0RDlFV2c3LzhFQWJPQmZu?=
 =?utf-8?B?V2l3WWdBWVhvNm5BcS9ieVVyY3hZQ2hDWklITktsQy8ybmVnTCtDNm5nZFEx?=
 =?utf-8?B?UTBTUWhLeHVWS0NPN1lCVWtXdWZHeS9GektoZGxBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA7F5D7A22D06047897568A02ECD52D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50afc459-8bf1-4059-ec32-08d8c2622565
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 01:23:26.1760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eLGsT00QOF/tzEWTXjfUVHcdCJgH7F+DSebuIxOglTXe5+MmzDgkWuY3fq6pncIn0h7aokTc6/kWvjBpcRdtDEPI//ExlBBjUB6k75DgOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSmFuIDIyLCAyMDIxLCBhdCAwMjo1NiwgQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPiB3
cm90ZToNCj4gT24gVHVlLCBKYW4gMTksIDIwMjEgYXQgMDY6NTc6MjZQTSArMDAwMCwgQmFlLCBD
aGFuZyBTZW9rIHdyb3RlOg0KPj4gVGhpcyBzZXJpZXMgYXR0ZW1wdHMgdG8gc2F2ZSB0aGUgQU1Y
IHN0YXRlIGluIHRoZSBjb250ZXh0IHN3aXRjaCBidWZmZXIgb25seQ0KPiANCj4gV2hhdCBpcyB0
aGUgY29udGV4dCBzd2l0Y2ggYnVmZmVyPw0KPiANCj4gSSB0aGluayB5b3UgbWVhbiBzaW1wbHkg
dGhlIHhzdGF0ZSBwZXItdGFzayBidWZmZXIgd2hpY2ggaXMgc3dpdGNoZWQgb24NCj4gY29udGV4
dCBzd2l0Y2hlcy4uLg0KDQpZZXMsIEkgd2lsbCB1c2Ug4oCYeHN0YXRlIHBlci10YXNrIGJ1ZmZl
cuKAmSBpbnN0ZWFkIG9mIGl0Lg0KDQo+PiBIb3cgYWJvdXQgdGhlIGNoYW5nZWxvZyBtZXNzYWdl
IGxpa2UgdGhpczoNCj4+IA0KPj4gIg0KPj4gVGhlIGNvbnRleHQgc3dpdGNoIGJ1ZmZlciBpcyBp
biBwcmVwYXJhdGlvbiB0byBiZSBkeW5hbWljIGZvciB1c2VyIHN0YXRlcy4NCg0Kcy9jb250ZXh0
IHN3aXRjaC94c3RhdGUgcGVyLXRhc2svDQoNClRoYW5rcywNCkNoYW4NCg0K
