Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654A23FE341
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbhIAToZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:44:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:9021 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344805AbhIAToS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:44:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="304422795"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="304422795"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 12:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="542059619"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2021 12:43:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 12:43:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 1 Sep 2021 12:43:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 12:43:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ663eEDp6iT+Jp57BPH4rHMGt6YZ/T26rv83BSshJFVwGLTz0ZBRo4ps740RUKE7R1WCayGMOAr9sbCU3egEfvtDvqEJXDBSVaRUF/tJ9vd1xSJ/KFssJSjef19n/cGhvl6ivIt2Zpw7cV1fu++TNJCqrN8E3f4trzbYrn/qcrM+bFQTkYvoDUcpJ0hdanALikt8o5scnLBzcW7/jmWD7M9wgSOggDHKuTSuaoZJq0nFVi8E6Jvj4qJZwDBG1VFm97A4qWuIzqzheFfiSPlHFC44al7si+jTQjheLNIj8EoYSC9mbjoCK5njfcyhTVZPnHtyDRR8SblM3R1P+1xEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CKkM3O6JdEDUMVYOzK4Rl8p8siabrncQ1Xo3DcxHDLA=;
 b=US/adTT63USs0mY0j5OerwIexLBTEWa5+hXvufk2FIdGsJxQ7ASMOXZbffKdwJ2DVgEclTPT7E8mEP2/9afbmKjJ3AN9+8660ocGcAA4JmPYwjFKVUk+NsiH7sSVjwzVxh1jrMq8vGkBR8Jyskvu/iitrCWFdf0E2FxClhqUroWfGYgaiST0CzL7x13NGLlBHH5ry/8WjvhTqMUWjeTTkOJZmqQRJpVV6de0Sag2Nq8BFRlvkIyDtdzNFZehSmOS98sep8gFoR/ZywcU/dRScCEX209w/LcjiLJ/XI49pe9rgZ1xpZzxWCgTI3ecKkUnsE2/zSOQ5qndTf0jjlXelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKkM3O6JdEDUMVYOzK4Rl8p8siabrncQ1Xo3DcxHDLA=;
 b=uNkD7rTfedoF3QR0C3a0cBA8HFMz9L6lhLan8rjGaGKwcSSJ3bN3MPiyFgHLNi5bknwcYQXZxGSK3SK7lQ283PUylo0Uais+2p8LY2tTmNiJyCugsDyX24yxrgJpu60pnADBwYrXyO9XfeHUzG9ioOIxMNsI/1scCeUvXOIDMFI=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 19:43:18 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5d75:50e:dcf:6efd]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5d75:50e:dcf:6efd%4]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 19:43:18 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>
Subject: Re: [PATCH v3 1/3] kernel/resource: clean up and optimize
 iomem_is_exclusive()
Thread-Topic: [PATCH v3 1/3] kernel/resource: clean up and optimize
 iomem_is_exclusive()
Thread-Index: AQHXn2mc6pa/RWgWVkmdjZn8vZIJ2Q==
Date:   Wed, 1 Sep 2021 19:43:18 +0000
Message-ID: <16141669368a89f8304b1777094e982942d51bba.camel@intel.com>
References: <20210831202141.13846-1-david@redhat.com>
         <20210831202141.13846-2-david@redhat.com>
In-Reply-To: <20210831202141.13846-2-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c727030-8c09-48ee-493b-08d96d80bf82
x-ms-traffictypediagnostic: SJ0PR11MB5087:
x-microsoft-antispam-prvs: <SJ0PR11MB5087D375708E67873A28CA74C6CD9@SJ0PR11MB5087.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AoAtwYx98QKSTWkdkqszif/tkp5HknBpZVx8tkUSf11Fl6JIL0hvZAFi6mA3CMMMcpsFNoYJw//u5GHa9rfe2pn7NsWyqJU9kY2MsG2OcfnSQqUj/WfjA8nU1ygsu7rxAX4aeHuNVM26XAjRP0JSrrtY4eG/H81BLAID7Qec9mv2HIW70QZkhgTBcsl19TPcTLeJVp8IC5eO+ZlQyKveYPTrP0Hjy+r4eIiLyEqJ4m3P+4VFtwFkP0+0LfRI4FrdzqougFSIPmDu29Nzr7UpndaOyjY4OJ1680OMmRYxgkc3C1F0tJOCndzs5sA+asEu1Znu1Dm08RwjHmluRVUU2g6zPnbKUm1eZuBf/nPd1tFF12+BF6+cq5gt4ENFZb6d/od4OzsiJB4MVegQjS5vaUBFVuzm5v0f+kaAdNwcIqa1/3gx75Tsfq+zYk/5ryjDQJhazVCqmpAD4wx8XeKRX3PqqEFog4XEeUrCmfrFnak2rogsTkuVBGKeS6wbLi1C1Cc9zrJXjHkYvDliHT448YQ8JXs1eAni92trg4MpASqsewbTpe7WsavlJfsZfl5vqkM7RcUrixcseZtVdX8w/dB8bKvuaIVjp+XS58hzCo+zLkqI7Pv+WbQipFn5ucmkdZGz6wpjWKLtCocDACmCDdKBWvJfOJA8U6kGrzUJIT48dZIpUFO+f9xmpnMgC5jeitA4pgAfQBFcf0ZemlIBTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(6486002)(5660300002)(478600001)(71200400001)(86362001)(4744005)(2906002)(6512007)(122000001)(6506007)(38100700002)(36756003)(26005)(316002)(2616005)(186003)(8676002)(110136005)(8936002)(38070700005)(91956017)(83380400001)(66946007)(66476007)(76116006)(66556008)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG1UMGpEOHorbFpJbFV2cmNjMWlsVzIyaCtqZjJ5ekJVN1MyVEZndGErRHhB?=
 =?utf-8?B?TnJRRUp6VEFySzhqK2xCdnd5bDZCcThSa3Y0amx5SzRXK3ZHamFEaVhwTUZE?=
 =?utf-8?B?ekNMcjNMRnRGcTNwRG9KbUViaGJNUjIvL2VKN2paMVpmWFYzamxwQ0U0RnFZ?=
 =?utf-8?B?c0JnNmxzQkNsMWkzTFZtRDJXMnZ5SDgrK29ITnFuYmV1MVhDSnpPRkJKRjVD?=
 =?utf-8?B?YXpwQncwdW43SE9TM0hHYXNyeGRkY2FPaUVJaXIvU3lkbjJmY3B5TUFBZkdG?=
 =?utf-8?B?WnA4Z2RHVEVReHd1M29TZFZOTytlRzNQRm52MjIwZm90MnY3ZXdKUFFiM0hN?=
 =?utf-8?B?Nkg4SUpZb3RlclF4ekpjR09zVVorK1k3QU9wcWU0WWVMTFVBNmR5dWRSRENj?=
 =?utf-8?B?ZnJSSUp0NlcyVzBER3B5T0ZGZWRRRHZYWlRINFl5bFFWUk5zVmM1MkMrRzVJ?=
 =?utf-8?B?V201YllDSUdyN1g0eVJkRHBvakNobEkrWjYweGYvYnRUUGxPbHF3cWJraitU?=
 =?utf-8?B?MHBHaVpDd1pKbEF3N1FNVjZLR1JGMGs4TzBZZ3lXbHY5eWh0bmpwbjI2eWxQ?=
 =?utf-8?B?V2pqanowVC8wZ2h2S2RsV1FpMUt5UTNURTlmemN6NDlvTFpHY1pIKzJoL242?=
 =?utf-8?B?WjNTc1NodFdHWXFMcVN5U2lXQlMxZkFtNVpQQVJhcXY4RjJnR1F5alJJc2Rm?=
 =?utf-8?B?UFBjK1RMLzE0aUtsVDBIazJKYUF3Y1gwRkZMT2MrODhFemE3UGxBZFJQSTlO?=
 =?utf-8?B?VFVtZFE3dlZwRXpmSVdxclZhQ2h3ZzVwV1BGMzNDVnM0NjRNSUdWWUdZcU1N?=
 =?utf-8?B?dU15ZU5aNXN3ZXYwY0c1dElwNlhkRjFZRldJNHJGVjU4d0dtY0VRZlowSkpt?=
 =?utf-8?B?Ti9WZmI2cVhrTVhpWVNWU1JQYTBrcmZkQW1udFhVVTZEUDZFWk9yOFNMZVM0?=
 =?utf-8?B?clFFRGh0c1YvTFIwQUt6TS85K2pXWDh1OS9TUmF4dHlqbk1RNUtzMnpHT0JX?=
 =?utf-8?B?UTdCNy83bHRYK0pjUVRsQXA1aVBnTUVXUDdsRmF0S1lFN2hjM3NaUktXUWEx?=
 =?utf-8?B?T21ROExUSU9MTklsODR6dWVFMUg3bkRWR1lJRW1ZczdQRk1aK1JIN1dCZ2Uw?=
 =?utf-8?B?MmhVL1VtUzJPTGtQVDlISVBZWWZMMkFBZTJiek9xdXE2QllpN1ZIZS9XeU4v?=
 =?utf-8?B?VFpHRUE1UWFYSHVpa3B4TjlkVzFVRGhLZEs1WVVWS1hvdmJocnBwcnU1cXlX?=
 =?utf-8?B?aTFIZE5teVVKNlpNa0VVcHQ4UGdsb2tsanV1T1FBdGdpam8ycjNwZTJPaEd6?=
 =?utf-8?B?SUpaS01CM3orUU5tY0lwd1pPQU9INlpRNklLS2FlenBGNUdwUFo3YytqSDBS?=
 =?utf-8?B?SUJlejF2aEhEcmZUcVJHc0pLSzBrSzFzeEtIVTBCZjZyamZlOGNwcTRxak1o?=
 =?utf-8?B?WE5xT2pqVGRPdnB2S21Sd09WQjIxSHBXWVV4RzRzakhQK0JnOVZCZjBMWHpU?=
 =?utf-8?B?elBabVRlYWtIbkd5OHgvYW4zRlZLc3R4WWhXYWU0NFdlb1BmSWNVT25DUjNM?=
 =?utf-8?B?Ni8yeml6TVBnVXVRWHp1enp1OFlyalMzanZtcFFadWpBRlF0RFBud0FXbTd4?=
 =?utf-8?B?NzdhWTRTenY5eExMNFFHUXNBaDI0M3praXVSMEMwNWkyUjh3bzV3cWZBVllO?=
 =?utf-8?B?SWh0NVBXN1BhWTBSR21QRTNWWTI3MXN6WWF5bCtUaWE3ejl5dzA2N0tmWWg1?=
 =?utf-8?B?ZXRKUzl5c085NzZOL2pWaFNaL29EVFQ1cUh5aU5JbUd5MENYOVB2MDBWc0FG?=
 =?utf-8?B?QXJ1NFZCZkMxQkhnM1d3Zz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE613DE935479E49AD011710EEA0D721@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c727030-8c09-48ee-493b-08d96d80bf82
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 19:43:18.4470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cj4DBQZ3YSvRAP52W0F4dcK2HiZ++eX0WG8/cH0AEz56Z2PUf3QI98FebmkG9cpz4NaSzgd6hr9NabuQPJysJEu0b6WE5jj5qrOM6hKnm0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDIyOjIxICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gV2UgZW5kIHVwIHRyYXZlcnNpbmcgc3VidHJlZXMgb2YgcmFuZ2VzIHdlIGFyZSBub3Qg
aW50ZXJlc3RlZCBpbjsgbGV0J3MNCj4gb3B0aW1pemUgdGhpcyBjYXNlLCBza2lwcGluZyBzdWNo
IHN1YnRyZWVzLCBjbGVhbmluZyB1cCB0aGUgZnVuY3Rpb24gYSBiaXQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IMKg
a2VybmVsL3Jlc291cmNlLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNClRoYXQgZGlm
ZnN0YXQgZG9lcyBub3QgY29tZSBhY3Jvc3MgYXMgImNsZWFudXAiLCBhbmQgdGhlIHNraXBfY2hp
bGRyZW4NCmZsYWcgY2hhbmdpbmcgdmFsdWVzIG1pZC1pdGVyYXRpb24gZmVlbHMgdHJpY2t5LiBJ
cyB0aGVyZSBhIHdpbiBoZXJlLA0KdGhlIHNhbWUgbnVtYmVyIG9mIGVudHJpZXMgc3RpbGwgbmVl
ZCB0byBiZSBhY2Nlc3NlZCwgcmlnaHQ/DQoNCkJUVywgSSBoYWQgdG8gcHVsbCB0aGlzIGZyb20g
bG9yZSB0byByZXBseSB0byBpdCwgbG9va3MgbGlrZSB0aGUNCmludGVuZGVkIENjJ3Mgd2VyZSBt
aXNzaW5nPw0K
