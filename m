Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E503FE32D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245590AbhIATk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:40:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:10314 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244663AbhIATk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:40:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="241117500"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="241117500"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 12:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="476317683"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2021 12:39:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 12:39:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 1 Sep 2021 12:39:58 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 12:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR4qpahQptezZ1C+BXLpFuRZudLDS75R6V9Nn/6xkGYWMiNNinlenxxsb1FQ5GyhWpm4CGTeOZqT3WUJW0+8pjtCrBBKpBN/qfbl9il0Xn2kP0wJt0/VkvVcE5kizn0GTr4ivmeYP470xD4uRQ8tKNG08lGsNNXyOjdWw5y1PhcfRX2gMK/QXk8FdPJiDtdd1PZZrt62TSeJlCbiQmPfbmzQ3uoBG4OgdI2NvdcMduKllkQkeBc+XDSJuJevMiISryN/wUbB1WvpIcJEpYczgzp4DoveyE/xMOPCA3RoGqQescI0AL7H+B8JTPiqiZffryejd+8MJgGFCM7u/mmm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qMOUvt1d48cCAeN0swzwUhvxu+hW+cb1RfQN9mnXvtA=;
 b=cInFFws1xkBPbuV3/3YZTItbyAPKU7pBaQF8jE7lKBWyzEhYnolKEMN3xmHdsvgNnEc3y6hKdPM8H9pKnnl5323rei/57w1rP4mIdPMWKXusbKQF7xbiTdW6txoqIaOngLFRfqKRwWQJSTWuFrd4kesma1nZm3sJKp9gub9SZl/SzTwb31JjURhu6Qb2SsHVptGwQ9rz9WiZ/OvrIdN6/ruidjeAmLD+AWcAuiYl3Fsgo9tsY68jx8rhRb2HCj0eEnsyaRIM3p7BxvdzIVlGRYEUZuB4hwtcmwvELucgDcT8Z7QsUqesC/KgNN+qSxS0Lr/IjAbxNzf2lMFSLVSyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMOUvt1d48cCAeN0swzwUhvxu+hW+cb1RfQN9mnXvtA=;
 b=aizZx7p5nELCpwmgI0CvqQ9/qWZ6P40ObzPGeN1uEx/bsTNKDqYu7Df3ftfTtrO6nEPLqrqLLiTwZ9080xT7xB+wB7ozwFOCZuGve75rJ0U5QgBqSStPZgDeVi1LfxiWvQIEj+26RN4kEKbBhnAiZ9wbPeuM2B2RWbz1iWzsjUU=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by BYAPR11MB2965.namprd11.prod.outlook.com (2603:10b6:a03:82::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 19:39:56 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5d75:50e:dcf:6efd]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5d75:50e:dcf:6efd%4]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 19:39:56 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>
Subject: Re: [PATCH v3 3/3] virtio-mem: disallow mapping virtio-mem memory via
 /dev/mem
Thread-Topic: [PATCH v3 3/3] virtio-mem: disallow mapping virtio-mem memory
 via /dev/mem
Thread-Index: AQHXn2kkRgUvLy3vZ0W5ZEQ9Q7pL6w==
Date:   Wed, 1 Sep 2021 19:39:56 +0000
Message-ID: <ecf4b178c23be1faa89e71f51c9b2dae24542d6e.camel@intel.com>
References: <20210831202141.13846-1-david@redhat.com>
         <20210831202141.13846-4-david@redhat.com>
In-Reply-To: <20210831202141.13846-4-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e5d0e9b-3423-421f-4ab0-08d96d804743
x-ms-traffictypediagnostic: BYAPR11MB2965:
x-microsoft-antispam-prvs: <BYAPR11MB2965152702653A3DB077E2BAC6CD9@BYAPR11MB2965.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5s+1L8bdYG4yr2fkQVnF7BeEjah57cnJlnwDmf+3uFLqpFyKLWcyP0QlfEDLuoa2aumE8G+bDgWsoGmre9oET0cq2hjcHaMZ9pZ1Qa/HII/e/IS8TULKeLiRj6OSCSKxbNJ+/RgNATnxtZFLEjCKTperdOj9VibzvdppJifH6dBzTuVvq2Qj6yRFe1EBoTeNLjK2pS4e0aSzwBJkYANp2yvlBzc88b8k3cLVoJ7YBpJvKbdWNTFnu6uRtvVHqRNEubHnY+SjkJ1LZfw+cBTSfR05SfiH7anNEvv0oigRRrDn1U7znoxHyML3CpSBPG2uKPgulYwbGtxISGHxm8ZNRfiS6UaPqVc1gC9J454JCJOx33niXaTrkiCc527q2oWZyE+NdxX2U/9lFS9YqBSueYgExefR2YvGCpJ6Lgrx7xyMRBTzEMYlo6Y4ZRFMONfFMUHaAO630naunr1TsoGzmzAEJUNjVebtCIl8OhQEJeLjZwwTAlSpQFCuNKeO/aksc38w+1L5yieykhcNUu4YuHgJfhLyF93H6lTDqrTQqh/tlOykOiUSzREN5Nh4rWK3kMfJ3QEwKVfgYDUbSlmdLzOlSe3ac2CqBjtk9pU1IUU7y7FQlAQoaS76TUBsKuIpFCDqF/Jg0lYePG3QZySW++Nc+d+EIDjHxTR8C8Hr9ggTcS2j6aDIUF6jgrs1gfDCv6Rf0+At731S8MsPTSRR/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(122000001)(38100700002)(110136005)(2906002)(6486002)(316002)(8936002)(71200400001)(5660300002)(508600001)(36756003)(26005)(8676002)(186003)(2616005)(91956017)(38070700005)(76116006)(6506007)(66446008)(66556008)(66476007)(6512007)(64756008)(66946007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmJ2OFZSMEFLQTdsbEkxelVuN0s5UjZLbWM4aStxb3FlNmxVVWcyd0paUkp1?=
 =?utf-8?B?UDUxbXVzSEprRjh1dmlERjRmdDdjREt2M01meFdKak0rNkpvaW5CNG5yRHFi?=
 =?utf-8?B?RUJ1UXRFWG1MT2dsVXJBOTVHL2JsOEtObC9TQVdyRnMvb29Uajk1UjB4UXMy?=
 =?utf-8?B?R2JvSVAvdnRXek5sV1V0N2JhM1dLaGRTR1ltVmdEMWtaa2Qzc1BmQys2TEpU?=
 =?utf-8?B?TDBreElwTUVPRzFQa21wcnNreXVXSUZ4eWlxVnY1UjNBckdBMy9xU0hiaGFW?=
 =?utf-8?B?Y1B4ZVRHZWFKN0plZFV1RjdPR0hMMmtDVlRQOTRZd2tLV3NuTUc2WFBLSmxv?=
 =?utf-8?B?OWs4ZWcxbHJ1c3ppcjdwMVZET1VyU0JXM2gyOVpHVFQ3RU8zc2YzSEp0aU1w?=
 =?utf-8?B?d2N2ZlB6YkIyQkxicHlnckZDUktONkg3aFgyWnlEejZta3dpWmx1aHRhVHlk?=
 =?utf-8?B?Y05ROVBDeWdrT1V5NURid0pFbVJmeXNtTWdMdkNzS2lUTXc1bFdnVUxsMVA5?=
 =?utf-8?B?YlluYjBLclNIZHNWUGhpNUVKSlZwYXlSWHN5Zlk5eE5zY0UzcUk2cEdCeVVu?=
 =?utf-8?B?cE9OYUp1ZDNEdDFWNk94UVlPcVJzUzBOcktSYUV6MzYyMkczWEZ4Q0EzYTRH?=
 =?utf-8?B?Smx2TkR2Y2duMlg2Qi9UbWJ4QVNvaWtDaldSalhGYmVzR0hMYng3Y080ZCs3?=
 =?utf-8?B?ZTVYczRFTjEraXhFamVBQmJsMCtQclpZN25ielQ1VzlINWQ5UlZlZjRjeWor?=
 =?utf-8?B?OEUzaG4xdkdHZ3F2emVUeUMwNFRwSUhOeTVYNjVlWm8wL3ZBSFpSZlhRWlEz?=
 =?utf-8?B?TEw2S01DeGdtSU5MRU1qZTBoM0dXUlJMa3U5ajBDQVJRcTRUdS9WaWhpbVEy?=
 =?utf-8?B?azI2MjZkRCtaQlIyZXc1aWhSdWpKbTBQakJLK2xuSTViaDdJWHlBZGRSM3dW?=
 =?utf-8?B?eVJ5YnBqWDFsTEFob1k2dUhBanBndkZpa25HZWgwUS9Xc215eU9OZkNYakdX?=
 =?utf-8?B?VmV5TEJMVk12bzdrUVEwR1pZRjAzenJFTEVXUkNCQm5uOHd1WmlRRWJyZmNt?=
 =?utf-8?B?SkpsVmlsYXVobit3b2kzeXNaVjZpcXgvRjFnVlFCMG9NL0hmYWZ0MW5leXor?=
 =?utf-8?B?Nmh3QWlya0l4Q3NwODdqYVJqZElNT1FqMnNrQkRFc2tZTmtkbUJRNFQyYUJG?=
 =?utf-8?B?VDlZaXhNZ1FDZXBPV2hRaXZsTHBPWGUvMG1mckhnRERrV096U1ZKdTRIdTRo?=
 =?utf-8?B?WmRVdVBFRzd5dmJxTHRva1dtbTA4Vk5iSEt6Y1dFSTRpS3JxWlBBWm5oVzRu?=
 =?utf-8?B?K0cxNlNwZzhjODFVZ25PNjg5NUZsd3E2YzRqOFFBK0diZTl2L1lOYXVwby9i?=
 =?utf-8?B?ZHBkVloxdE11clpwaVAxckszT2hBYzJKTk04MXpMOFVvY3RJS1o2dzRpOEE0?=
 =?utf-8?B?bk5LM1p2T3JWR3ZrNzdJWC8xVzBPSll2ZExyVU1xOXRuK0pPNGhDcUdxYW1Q?=
 =?utf-8?B?amROTUl1TW9xT0szeXdVNERPdjJuY0pCZXJ4SG1QOXVoeWlndEVsdjdkdXU2?=
 =?utf-8?B?Nk53a3ZqZk1ieS9LYWhmYXZWS0tXSG4rdmRiZFVWVTYrTURGYjFZekRJckhR?=
 =?utf-8?B?MEhVMmg3dHBvcDJyOXNmZmgvOExXUFpCbjlraWZXVDZSelM0aE1YemZXQ0VK?=
 =?utf-8?B?SmhaRE9RM1NEZk9TSGpTUHNtWFFqUGM5VkpFRFZSZTdOTzJUYnduUGxYcjho?=
 =?utf-8?B?bW5vUE5EWXEzRlZmdVBVS3hRU0tJbnJsUWZtYUhhbWlLUThjaVVvWjNBaHlZ?=
 =?utf-8?B?N2p1bEpiUHA0cTNPNDRMQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <828B3DF3CFED074FB9160DD689C409DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5d0e9b-3423-421f-4ab0-08d96d804743
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 19:39:56.7484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwttEH0zciHvZAzuJ59gC5y8agYOd8kCilsI5yF8ehhAiqW4GrBVwbnauFhdXRmpwhB1s3KdvgZcfhwoWe7mFEHih3aG8rGE48KC4jQL/c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2965
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDIyOjIxICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gV2UgZG9uJ3Qgd2FudCB1c2VyIHNwYWNlIHRvIGJlIGFibGUgdG8gbWFwIHZpcnRpby1t
ZW0gZGV2aWNlIG1lbW9yeQ0KPiBkaXJlY3RseSAoZS5nLiwgdmlhIC9kZXYvbWVtKSBpbiBvcmRl
ciB0byBoYXZlIGd1YXJhbnRlZXMgdGhhdCBpbiBhIHNhbmUNCj4gc2V0dXAgd2UnbGwgbmV2ZXIg
YWNjaWRlbnRpYWxseSBhY2Nlc3MgdW5wbHVnZ2VkIG1lbW9yeSB3aXRoaW4gdGhlDQo+IGRldmlj
ZS1tYW5hZ2VkIHJlZ2lvbiBvZiBhIHZpcnRpby1tZW0gZGV2aWNlLCBqdXN0IGFzIHJlcXVpcmVk
IGJ5IHRoZQ0KPiB2aXJ0aW8tc3BlYy4NCj4gDQo+IEFzIHNvb24gYXMgdGhlIHZpcnRpby1tZW0g
ZHJpdmVyIGlzIGxvYWRlZCwgdGhlIGRldmljZSByZWdpb24gaXMgdmlzaWJsZQ0KPiBpbiAvcHJv
Yy9pb21lbSB2aWEgdGhlIHBhcmVudCBkZXZpY2UgcmVnaW9uLiBGcm9tIHRoYXQgcG9pbnQgb24g
dXNlciBzcGFjZQ0KPiBpcyBhd2FyZSBvZiB0aGUgZGV2aWNlIHJlZ2lvbiBhbmQgd2Ugd2FudCB0
byBkaXNhbGxvdyBtYXBwaW5nIGFueXRoaW5nDQo+IGluc2lkZSB0aGF0IHJlZ2lvbiAod2hlcmUg
d2Ugd2lsbCBkeW5hbWljYWxseSAodW4pcGx1ZyBtZW1vcnkpIHVudGlsDQo+IHRoZSBkcml2ZXIg
aGFzIGJlZW4gdW5sb2FkZWQgY2xlYW5seSBhbmQgZS5nLiwgYW5vdGhlciBkcml2ZXIgbWlnaHQg
dGFrZQ0KPiBvdmVyLg0KPiANCj4gQnkgY3JlYXRpbmcgb3VyIHBhcmVudCBJT1JFU09VUkNFX1NZ
U1RFTV9SQU0gcmVzb3VyY2Ugd2l0aA0KPiBJT1JFU09VUkNFX0VYQ0xVU0lWRSwgd2Ugd2lsbCBk
aXNhbGxvdyBhbnkgL2Rldi9tZW0gYWNjZXNzIHRvIG91cg0KPiBkZXZpY2UgcmVnaW9uIHVudGls
IHRoZSBkcml2ZXIgd2FzIHVubG9hZGVkIGNsZWFubHkgYW5kIHJlbW92ZWQgdGhlDQo+IHBhcmVu
dCByZWdpb24uIFRoaXMgd2lsbCB3b3JrIGV2ZW4gdGhvdWdoIG9ubHkgc29tZSBtZW1vcnkgYmxv
Y2tzIGFyZQ0KPiBhY3R1YWxseSBjdXJyZW50bHkgYWRkZWQgdG8gTGludXggYW5kIGFwcGVhciBh
cyBidXN5IGluIHRoZSByZXNvdXJjZSB0cmVlLg0KPiANCj4gU28gYWNjZXNzIHRvIHRoZSByZWdp
b24gZnJvbSB1c2VyIHNwYWNlIGlzIG9ubHkgcG9zc2libGUNCj4gYSkgaWYgd2UgZG9uJ3QgbG9h
ZCB0aGUgdmlydGlvLW1lbSBkcml2ZXIuDQo+IGIpIGFmdGVyIHVubG9hZGluZyB0aGUgdmlydGlv
LW1lbSBkcml2ZXIgY2xlYW5seS4NCj4gDQo+IERvbid0IGJ1aWxkIHZpcnRpby1tZW0gaWYgYWNj
ZXNzIHRvIC9kZXYvbWVtIGNhbm5vdCBiZSByZXN0cmljdGljdGVkIC0tDQo+IGlmIHdlIGhhdmUg
Q09ORklHX0RFVk1FTT15IGJ1dCBDT05GSUdfU1RSSUNUX0RFVk1FTSBpcyBub3Qgc2V0Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+
IC0tLQ0KPiDCoGRyaXZlcnMvdmlydGlvL0tjb25maWfCoMKgwqDCoMKgIHwgMSArDQo+IMKgZHJp
dmVycy92aXJ0aW8vdmlydGlvX21lbS5jIHwgNCArKystDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZpcnRpby9LY29uZmlnIGIvZHJpdmVycy92aXJ0aW8vS2NvbmZpZw0KPiBpbmRleCBjZTFiM2Y2
ZWMzMjUuLmZmODBjZDAzZjFkMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vS2NvbmZp
Zw0KPiArKysgYi9kcml2ZXJzL3ZpcnRpby9LY29uZmlnDQo+IEBAIC0xMDEsNiArMTAxLDcgQEAg
Y29uZmlnIFZJUlRJT19NRU0NCj4gwqDCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gTUVNT1JZX0hP
VFBMVUdfU1BBUlNFDQo+IMKgwqDCoMKgwqDCoMKgwqBkZXBlbmRzIG9uIE1FTU9SWV9IT1RSRU1P
VkUNCj4gwqDCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gQ09OVElHX0FMTE9DDQo+ICvCoMKgwqDC
oMKgwqDCoGRlcGVuZHMgb24gIURFVk1FTSB8fCBTVFJJQ1RfREVWTUVNDQoNClRoYW5rcyBmb3Ig
dGhpcy4gSXQga2VlcHMgdGhlIHNwZWNpYWwgY2FzZSBvdXQgb2YgdGhlIGltcGxlbWVudGF0aW9u
DQp3aGlsZSBub3QgY29tcHJvbWlzaW5nIGludGVncml0eSBmb3IgVklSVElPX01FTS4NCg0KUmV2
aWV3ZWQtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KDQo+IMKg
wqDCoMKgwqDCoMKgwqBoZWxwDQo+IMKgwqDCoMKgwqDCoMKgwqAgVGhpcyBkcml2ZXIgcHJvdmlk
ZXMgYWNjZXNzIHRvIHZpcnRpby1tZW0gcGFyYXZpcnR1YWxpemVkIG1lbW9yeQ0KPiDCoMKgwqDC
oMKgwqDCoMKgIGRldmljZXMsIGFsbG93aW5nIHRvIGhvdHBsdWcgYW5kIGhvdHVucGx1ZyBtZW1v
cnkuDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLmMgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fbWVtLmMNCj4gaW5kZXggYjkxYmM4MTBhODdlLi5jMmQ5MzQ5MmNmMGYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tZW0uYw0KPiArKysgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLmMNCj4gQEAgLTI1MjMsOCArMjUyMywxMCBAQCBzdGF0aWMg
aW50IHZpcnRpb19tZW1fY3JlYXRlX3Jlc291cmNlKHN0cnVjdCB2aXJ0aW9fbWVtICp2bSkNCj4g
wqDCoMKgwqDCoMKgwqDCoGlmICghbmFtZSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gLUVOT01FTTsNCj4gwqANCj4gK8KgwqDCoMKgwqDCoMKgLyogRGlzYWxsb3cg
bWFwcGluZyBkZXZpY2UgbWVtb3J5IHZpYSAvZGV2L21lbSBjb21wbGV0ZWx5LiAqLw0KPiDCoMKg
wqDCoMKgwqDCoMKgdm0tPnBhcmVudF9yZXNvdXJjZSA9IF9fcmVxdWVzdF9tZW1fcmVnaW9uKHZt
LT5hZGRyLCB2bS0+cmVnaW9uX3NpemUsDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBuYW1lLCBJT1JFU09VUkNFX1NZU1RFTV9SQU0pOw0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmFtZSwgSU9SRVNPVVJDRV9TWVNURU1f
UkFNIHwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElPUkVT
T1VSQ0VfRVhDTFVTSVZFKTsNCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghdm0tPnBhcmVudF9yZXNv
dXJjZSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGtmcmVlKG5hbWUpOw0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl93YXJuKCZ2bS0+dmRldi0+ZGV2
LCAiY291bGQgbm90IHJlc2VydmUgZGV2aWNlIHJlZ2lvblxuIik7DQoNCg==
