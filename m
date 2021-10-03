Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C686A42045D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 00:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhJCWiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 18:38:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:37262 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhJCWio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 18:38:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="222691611"
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="222691611"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 15:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="566669810"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2021 15:36:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 3 Oct 2021 15:36:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 3 Oct 2021 15:36:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 3 Oct 2021 15:36:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3lpTauVKYh9uEpMfEiO1ltZDJ3sfKNsLHxNpUFrLDJfagBa/GiR+T5OnI6wBCUFhdL1KoWsopTzFOkWfF4eghXbawFRODHEoZj9Qyz8x2nSb6+E5JNCPWCeH/UTMqeJdMRn1go727k8K2km2GtddSPRhnZSe7aW6n5DQhnaZtmJn+BwG0gclVNL2gpi1/JUovzpQrUy2nVq6H36SeiHsvnu8CkgyK6XvQyCGvX4dThgjl6StqOM5XRkxdvzFT0n9dNXaFuUI4Azpd76QNCQi5oUTs+wItCRhjv1zQ2YCBkngc0hMqVCTmLJi9DhC+Zqa3E98CphZbumDAzSr+cbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvd5l3gTYgZ62R+ojfTOcNeQ5sKST+CnE9Mmu1egsgY=;
 b=iIBhE7PdXl1pjA6HjgKt7r/iKI9CKahX/V56yESo4p7BuoFYW2daTEJ6LOvoB2YesPJ7nij5xKv0shG8wRS7skRfHQIh7+BIg0x4GYJdS+MjBxWYNWJeIxa2xqfEe7I0QeefZXN4Vr1CikWn8JWxGNQTA3y3K5XPK9bdD6iTMulC3C4sOMlrHVbUxVJ4i/0DZCZU41cKZI/No8+S3V7fL4XX23iqWYkE330KCMjr9XAO+sO8aC/rFhaOSUzWkX7UylxFIJxEnHP8WJqMdY3VWARyk4G9SLYcjbB68omk1Enn//FAxZP4aQ0MeV3g0FjLvvoJm3J46vqbWFXc/xfp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvd5l3gTYgZ62R+ojfTOcNeQ5sKST+CnE9Mmu1egsgY=;
 b=aVYxlB7JfGDoZdJX9j+VV4+TMcFKvR3UwhHPiYcc9ISmvfFJ6edYbWesApavPCHUTcw1EeyB0VbccPR2P2c2Hv6msf7A4jqe/f+2Svj8cG59FzFw8So2lRYtPRHn9/UBFIe5smygZVQ6hTejISlTQAg2miscIHlKtYDIdZO3PSw=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Sun, 3 Oct
 2021 22:36:54 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Sun, 3 Oct 2021
 22:36:54 +0000
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
Subject: Re: [PATCH v10 09/28] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Topic: [PATCH v10 09/28] x86/fpu/xstate: Introduce helpers to manage
 the XSTATE buffer dynamically
Thread-Index: AQHXmcp3eDLiM7GkkEqq18335v7eiKu+a1QAgAOvaQA=
Date:   Sun, 3 Oct 2021 22:36:54 +0000
Message-ID: <CAF9A956-5623-4D24-BA3E-AF139C0A7CE6@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-10-chang.seok.bae@intel.com> <874ka06d3z.ffs@tglx>
In-Reply-To: <874ka06d3z.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a17cf114-0c79-4d42-339d-08d986be4d13
x-ms-traffictypediagnostic: PH0PR11MB4821:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4821B2A60C0E078E541ED406D8AD9@PH0PR11MB4821.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LuUROytD5tQr9PyF6B6IyIO9wybrBYTbzpTF/1u0JpGt00ttSp6rq+q6YtRwpilDAuZF1x12NNccfoLqlUf0D2DFIQrj/7SRCdxmIIPza33TK5pqHTsM8DHfVd4XS1sTW9a/2C8d7s/e/fmghxpQ9TXZKnrKJzplgDUtCQoJXLNpmreC9ygw7jQmDyLPy37/F5IUnufobaOWyDZ2ItEha4WxXX86WViPArSxTHKDC+Ps/unWI7GcYHXtc9yha9laAE0bVsBtXl4mblHvsSPHxh0RpxLBSVXFOu8/2JHl7+i/Jr0Elhq4vdfPGPQ80bZoTnwmIn58KWZRwdYvU2xKK8dp/P1GZsTZ+fhNmzg6LTxoOsWY/xu6U6YU7ICoBz4mRTUOZ4Bo/dJ9FA1oGajMt1QyCbVkcSuZZ3u+Nwo1Q5qcICyOPiR0S88k/Ym0yHqvkofiNjdO8sMXa8I+tdYgLQr9lFrQmT4SZTw7wC+5SPHhg87+2YXT3hoZitEADti41ewwpaQaXp7ydWw44HPJJEN1VUQGM2o7Ivdm5jwOV2crIegVeDoOufT+8Vr13IOaEVc5+UnEv+TipU0F/XJVZE7dJNRJ6at0GCHDjqCnPMxnUJcuvNiqDucb/UkUOOD1XIci3ww0GzuoHasQVZdIRLU7FXXvxYbgdPe0AiySiRGrykjsdWf4a/U6hd9hX2xn2RSEw9njBx+LVvBLcNDyxwwixQE1sbaU5RlM+Pc7YPMgVZJEaOfVyL1II62pnsxg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6916009)(33656002)(2906002)(4326008)(5660300002)(76116006)(66946007)(66446008)(64756008)(66556008)(86362001)(83380400001)(66476007)(8676002)(71200400001)(2616005)(186003)(6486002)(316002)(508600001)(6506007)(53546011)(122000001)(36756003)(6512007)(26005)(38070700005)(38100700002)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z29DejBRajZkQWJmcEZ3WFJtRDltREZDNXpUTDUvMTcyYmtadGJpNUdyU1FK?=
 =?utf-8?B?RDl2RjdwV3hnbTY4bTY4ajJiQTE1c3ZTcU9IdlQ5Z0VRS0U1N0pVUUEyRnRx?=
 =?utf-8?B?aHNYU1BOVmV0QTdoMmdybUJ0TWxMZ00zc2hJM3ZWWDlxY0x1NE1mTzZhSEd1?=
 =?utf-8?B?eTR4WXR6d0ZkVWFhWFRrWUZqUm1uS2hpT3JoZzNaam8xYzlkWWpUMUU0b3BM?=
 =?utf-8?B?K2JwZ2t2b0hReFVrVWlTQzc4d21vekRaSEh5d2t0MUZJRmluSjZ1QTBxSjdV?=
 =?utf-8?B?M1UrM3dPbXlwRFgwNXpqb3B0NmRzRmYzQ2RvWGNKVkZUQjBNdFREQ29GbVVu?=
 =?utf-8?B?OTdQTVlNYTRjaWRJcFBPUFpVWFFvN0w2WElKVXovMmI4bjVhMDFyZkR6TkEy?=
 =?utf-8?B?dVNrQlZtSXRNMFJJMTlxL0Y3anlBcFEweDJLZ3BnRHByNEVmeFByckpuZW00?=
 =?utf-8?B?OVJURjhvZHNYdndkN3V1TWszTGlSTk1YdlpNNWN3MWZpd1M3ZWd4Ynk3MVRP?=
 =?utf-8?B?d2R0QWwrUDFDMDZaZDE3Wlc0d0FXdEkzZG0vRzN4N1ROMnNEajIwWU5Db2tq?=
 =?utf-8?B?QWQyU1hsMnJ1bmhDeXlVamtjQU5OUXMyRTk3dFhMVE5hZTNQV1Z0THN3WEdC?=
 =?utf-8?B?VmdRNVNyRTNkVnJtangwQk9RM2lEUUJjRFU4eSs2YlJpeDZmQmlVUzZnajI3?=
 =?utf-8?B?VUZuMXliV0JsNG1nWHJFNUE0TytMZnQxRStiYitSVDBPMnVYYWZVWDNIK241?=
 =?utf-8?B?c2pJSnlibnI0RVYxZnQxaE50NGNzTHdBalRXNWl4OG9kbi93RHBBcVAzMkx1?=
 =?utf-8?B?UTJ5K3hPWFNJRGNCOVI4THVIelRud3pockxnWjZwc1RHZmJQTW5odlIxTU9W?=
 =?utf-8?B?VHhER1RSbmhXV2o0S3ZBdGRoZWIxeVVhKzdHaFJJVWlWMW5VY0gzM2ZiSXdB?=
 =?utf-8?B?Z2c5QTZoTEFlL2JnVkp6dllaV2pLWTAvM0ZYcERpcUpaVm0xN1NOM3BoWmc3?=
 =?utf-8?B?SmJRbW1ZbTJDdDlFc3VUdlVBTWM1MHNaanRTamVKOTVjMG14YUxQck5xUGFO?=
 =?utf-8?B?b25hREM0Z0hkSDltNUhPaEZYRUJJSkV3dXVTWFJwMFNBWldFSjFXakR2NUFI?=
 =?utf-8?B?WWRzQ2x4Q2hTbmlIWkV2c3ErblJ0dlkzaS9laFd4QVVZWjF3MUpxQURqNFBw?=
 =?utf-8?B?NkUzTE91Y29BNktZTWl6U2tlbGVlZS9ndWptcGpkcUdVRDB4OGdsTGkrR296?=
 =?utf-8?B?elhHV2MyRmFmWUk5cUpEejhXWGhWejVLOWhqWlB0KzdrOUdlVlQ1UTd5TTZE?=
 =?utf-8?B?SENaK0diTDZzbzViT1lqdHRzYWxCQ0lscXhrMHZFaGpSRTZLQ21mbGo2SDA1?=
 =?utf-8?B?L09SNGplRkFPVUlGRnFabWVUQzlLdllIK2Z0ellFd2FVTmhoeGFoTHRSL0tD?=
 =?utf-8?B?b3pHakpLN0ovSm4rY3B2ckV1RmlKRkpGdFp5ZkpzNGIwVGFiYjVwWGIvZmx3?=
 =?utf-8?B?UkVDMnRhZ21xQndMeURSMEZZS2dwcHNDdUJoKzNsRkhzVk9jTXo1Qm0yWUk5?=
 =?utf-8?B?c3Z0TXFxTTRxVFNDUmZGeEFQdUQyeXJicDZPU3IzaVU0VDBmTUR0Zit1azRN?=
 =?utf-8?B?RGFOalo1UTU2K2ZCa3czV1drWUgxcHRPbGE2cldpWDJ4T2xZLzBYOE1yejRs?=
 =?utf-8?B?MUNtSHVaeGcydGZwRnNkTE1jWFJWTUsvSkpRellwQkpOL0lrT3pKUkNtOEVP?=
 =?utf-8?Q?aaQFhZRpCNCu8ViDlOVAu3TYyv86PChLOlTaxer?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69560D9A4F31A8448AE46ED720C188FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17cf114-0c79-4d42-339d-08d986be4d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2021 22:36:54.3045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sK1KYiwh//j7AZwebPXY+CyVTDjTN4WlM61fHmlvRlYatGCWJxDqGGMuD6dnra5kLY4XQHP9gwabTAVrOUdEPAbJbyY31cEArwyLn48jxSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gT2N0IDEsIDIwMjEsIGF0IDA3OjIwLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDI1IDIwMjEgYXQgMDg6NTMsIENoYW5nIFMuIEJh
ZSB3cm90ZToNCj4+ICsvKioNCj4+ICsgKiBjYWxjdWxhdGVfeHN0YXRlX2J1Zl9zaXplX2Zyb21f
bWFzayAtIENhbGN1bGF0ZSBhbiB4c3RhdGUgYnVmZmVyIHNpemUNCj4+ICsgKiBAbWFzazoJQSBi
aXRtYXAgdG8gdGVsbCB3aGljaCBjb21wb25lbnRzIHRvIGJlIHNhdmVkIGluIHRoZSBidWZmZXIu
DQo+PiArICoNCj4+ICsgKiBBdmFpbGFibGUgb25jZSB0aG9zZSBhcnJheXMgZm9yIHRoZSBvZmZz
ZXQsIHNpemUsIGFuZCBhbGlnbm1lbnQgaW5mbyBhcmUNCj4+ICsgKiBzZXQgdXAsIGJ5IHNldHVw
X3hzdGF0ZV9mZWF0dXJlcygpLg0KPj4gKyAqDQo+PiArICogUmV0dXJuczoJVGhlIGJ1ZmZlciBz
aXplDQo+PiArICovDQo+PiArdW5zaWduZWQgaW50IGNhbGN1bGF0ZV94c3RhdGVfYnVmX3NpemVf
ZnJvbV9tYXNrKHU2NCBtYXNrKQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgaW50IHNpemUgPSBGWFNB
VkVfU0laRSArIFhTQVZFX0hEUl9TSVpFOw0KPj4gKwlpbnQgaSwgbnI7DQo+PiArDQo+PiArCWlm
ICghbWFzaykNCj4+ICsJCXJldHVybiAwOw0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBUaGUgbWlu
aW11bSBidWZmZXIgc2l6ZSBleGNsdWRlcyB0aGUgZHluYW1pYyB1c2VyIHN0YXRlLiBXaGVuIGEN
Cj4+ICsJICogdGFzayB1c2VzIHRoZSBzdGF0ZSwgdGhlIGJ1ZmZlciBjYW4gZ3JvdyB1cCB0byB0
aGUgbWF4IHNpemUuDQo+PiArCSAqLw0KPj4gKwlpZiAobWFzayA9PSAoeGZlYXR1cmVzX21hc2tf
YWxsICYgfnhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1pYykpDQo+PiArCQlyZXR1cm4gZnB1X2J1
Zl9jZmcubWluX3NpemU7DQo+PiArCWVsc2UgaWYgKG1hc2sgPT0geGZlYXR1cmVzX21hc2tfYWxs
KQ0KPj4gKwkJcmV0dXJuIGZwdV9idWZfY2ZnLm1heF9zaXplOw0KPj4gKw0KPj4gKwluciA9IGZs
czY0KG1hc2spIC0gMTsNCj4+ICsJaWYgKG5yIDwgRklSU1RfRVhURU5ERURfWEZFQVRVUkUpDQo+
PiArCQlyZXR1cm4gc2l6ZTsNCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogRWFjaCBzdGF0ZSBvZmZz
ZXQgaW4gdGhlIG5vbi1jb21wYWN0ZWQgZm9ybWF0IGlzIGZpeGVkLiBUYWtlIHRoZQ0KPj4gKwkg
KiBzaXplIGZyb20gdGhlIGxhc3QgZmVhdHVyZSAnbnInLg0KPj4gKwkgKi8NCj4+ICsJaWYgKCFj
cHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hTQVZFUykpDQo+PiArCQlyZXR1cm4geHN0
YXRlX29mZnNldHNbbnJdICsgeHN0YXRlX3NpemVzW25yXTsNCj4+ICsNCj4+ICsJLyoNCj4+ICsJ
ICogV2l0aCB0aGUgZ2l2ZW4gbWFzaywgbm8gcmVsZXZhbnQgc2l6ZSBpcyBmb3VuZCBzbyBmYXIu
IFNvLA0KPj4gKwkgKiBjYWxjdWxhdGUgaXQgYnkgc3VtbWluZyB1cCBlYWNoIHN0YXRlIHNpemUu
DQo+PiArCSAqLw0KPj4gKwlmb3IgKGkgPSBGSVJTVF9FWFRFTkRFRF9YRkVBVFVSRTsgaSA8PSBu
cjsgaSsrKSB7DQo+PiArCQlpZiAoIShtYXNrICYgQklUX1VMTChpKSkpDQo+PiArCQkJY29udGlu
dWU7DQo+PiArDQo+PiArCQlpZiAoeHN0YXRlXzY0Ynl0ZV9hbGlnbmVkW2ldKQ0KPj4gKwkJCXNp
emUgPSBBTElHTihzaXplLCA2NCk7DQo+PiArCQlzaXplICs9IHhzdGF0ZV9zaXplc1tpXTsNCj4+
ICsJfQ0KPj4gKwlyZXR1cm4gc2l6ZTsNCj4+ICt9DQo+IA0KPiBTbyB3ZSBoYXZlIHlldCBhbm90
aGVyIHNsaWdodGx5IGRpZmZlcmVudCBmdW5jdGlvbiB0byBjYWxjdWxhdGUgdGhlDQo+IGJ1ZmZl
ciBzaXplLiBXaHkgZG8gd2Ugc3RpbGwgbmVlZCBjYWxjdWxhdGVfeHN0YXRlX3NpemUoKT8NCg0K
ZG9fZXh0cmFfeHN0YXRlX3NpemVfY2hlY2tzKCkgKHJlbmFtZWQgYXMgY2FsY3VsYXRlX3hzdGF0
ZV9zaXplKCkgaW4gdGhpcw0Kc2VyaWVzKSBkb2VzIGNhbGN1bGF0ZSB0aGUgWFNUQVRFIHNpemUu
IEJ1dCBpdCByZWZlcnMgdG8gQ1BVSUQgYXMgYmVmb3JlDQpzZXR1cF94c3RhdGVfZmVhdHVyZXMo
KSB3aGljaCByZWNvcmRzIG9mZnNldCwgc2l6ZSwgYW5kIGFsaWdubWVudCBpbmZvLiBUaGUNCmFi
b3ZlIGh1bmsgcmVmZXJlbmNlcyB0aGUgc3RvcmVkIHZhbHVlcyBhdCBydW50aW1lLg0KDQpBbHRo
b3VnaCBJIGNvdWxkIGFnZ3Jlc3NpdmVseSB0cnkgdG8gY29tYmluZSB0aGVtLCBJIHRob3VnaHQg
bm90IHRoYXQgY2xlYW51cA0KaXMgbmVjZXNzYXJ5IGZvciB0aGlzIHNlcmllcy4gQnV0IHBlcmhh
cHMgSSBtYXkgZm9sbG93LXVwIHRoaXMgYXMgY2xlYW51cCBwYXRjaC4NCg0KPj4gK3ZvaWQgZnJl
ZV94c3RhdGVfYnVmZmVyKHN0cnVjdCBmcHUgKmZwdSkNCj4+ICt7DQo+IA0KPiBDYW4geW91IHBs
ZWFzZSBwdXQgdGhlIGNoZWNrOg0KPiANCj4+ICsJaWYgKGZwdS0+c3RhdGUgIT0gJmZwdS0+X19k
ZWZhdWx0X3N0YXRlKQ0KPiANCj4gaW50byB0aGlzIGZ1bmN0aW9uPyBJZiBpdCBpcyBldmVyIGNh
bGxlZCB3aXRob3V0IGNoZWNraW5nIGl0IGFuZCBzdGF0ZQ0KPiBwb2ludHMgYXQgZnB1LT5fX2Rl
ZmF1bHRfc3RhdGUgdGhlbiB0aGUgZXhwbG9zaW9ucyBhcmUgZ29pbmcgdG8gYmUNCj4gaW50ZXJl
c3RpbmcuDQo+IA0KPj4gKwl2ZnJlZShmcHUtPnN0YXRlKTsNCj4+ICt9DQoNCkkgd3JvdGUgdGhh
dCBvcmlnaW5hbGx5LiBCdXQgaXQgaGFzIGJlZW4gY2hhbmdlZCBsaWtlIHRoaXMsIGFzIHBlciBC
b3Jpc+KAmToNCg0KICAgID4+ICt2b2lkIGZyZWVfeHN0YXRlX2J1ZmZlcihzdHJ1Y3QgZnB1ICpm
cHUpDQogICAgPj4gK3sNCiAgICA+PiArCS8qIEZyZWUgdXAgb25seSB0aGUgZHluYW1pY2FsbHkt
YWxsb2NhdGVkIG1lbW9yeS4gKi8NCg0KICAgID5UaGlzIGJlbG9uZ3MgYWJvdmUgdGhlIGZ1bmN0
aW9uIGFsb25nIHdpdGggYW4gZXhwbGFuYXRpb24gd2hlbiBpdCBuZWVkcw0KICAgID50byBiZSBj
YWxsZWQuDQoNCiAgICA+PiArCWlmIChmcHUtPnN0YXRlICE9ICZmcHUtPl9fZGVmYXVsdF9zdGF0
ZSkNCiAgICA+PiArCQl2ZnJlZShmcHUtPnN0YXRlKTsNCiAgICA+PiArfQ0KDQoNCkl0IHNlZW1z
IHRoYXQgSSBtaXNzZWQgY29tbWVudHMgb24gdGhvc2UgY2FsbCBzaXRlcy4gQnV0IEkgd291bGQg
bGlrZSB0byB0YWtlDQp5b3VyIHBvaW50Lg0KDQo+PiArLyoqDQo+PiArICogcmVhbGxvY194c3Rh
dGVfYnVmZmVyIC0gUmUtYWxsb2MgYSBidWZmZXIgd2l0aCB0aGUgc2l6ZSBjYWxjdWxhdGVkIGZy
b20NCj4+ICsgKgkJCSAgIEBtYXNrLg0KPj4gKyAqDQo+PiArICogQGZwdToJQSBzdHJ1Y3QgZnB1
ICogcG9pbnRlcg0KPj4gKyAqIEBtYXNrOglUaGUgYml0bWFwIHRlbGxzIHdoaWNoIGNvbXBvbmVu
dHMgdG8gYmUgcmVzZXJ2ZWQgaW4gdGhlIG5ldw0KPj4gKyAqCQlidWZmZXIuDQo+PiArICoNCj4+
ICsgKiBJdCBkZWFscyB3aXRoIGVubGFyZ2luZyB0aGUgeHN0YXRlIGJ1ZmZlciB3aXRoIGR5bmFt
aWMgc3RhdGVzLg0KPj4gKyAqDQo+PiArICogVXNlIHZ6YWxsb2MoKSBzaW1wbHkgaGVyZS4gSWYg
dGhlIHRhc2sgd2l0aCBhIHZ6YWxsb2MoKS1hbGxvY2F0ZWQgYnVmZmVyDQo+PiArICogdGVuZHMg
dG8gdGVybWluYXRlIHF1aWNrbHksIHZmcmVlKCktaW5kdWNlZCBJUElzIG1heSBiZSBhIGNvbmNl
cm4uDQo+PiArICogQ2FjaGluZyBtYXkgYmUgaGVscGZ1bCBmb3IgdGhpcy4gQnV0IHRoZSB0YXNr
IHdpdGggbGFyZ2Ugc3RhdGUgaXMgbGlrZWx5DQo+PiArICogdG8gbGl2ZSBsb25nZXIuDQo+PiAr
ICoNCj4+ICsgKiBBbHNvLCB0aGlzIG1ldGhvZCBkb2VzIG5vdCBzaHJpbmsgb3IgcmVjbGFpbSB0
aGUgYnVmZmVyLg0KPj4gKyAqDQo+PiArICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIC1FTk9NRU0g
b24gYWxsb2NhdGlvbiBlcnJvci4NCj4+ICsgKi8NCj4+ICtpbnQgcmVhbGxvY194c3RhdGVfYnVm
ZmVyKHN0cnVjdCBmcHUgKmZwdSwgdTY0IG1hc2spDQo+PiArew0KPj4gKwl1bmlvbiBmcHJlZ3Nf
c3RhdGUgKnN0YXRlOw0KPj4gKwl1NjQgc3RhdGVfbWFzazsNCj4+ICsNCj4+ICsJc3RhdGVfbWFz
ayA9IGZwdS0+c3RhdGVfbWFzayB8IG1hc2s7DQo+PiArCWlmICgoc3RhdGVfbWFzayAmIGZwdS0+
c3RhdGVfbWFzaykgPT0gc3RhdGVfbWFzaykNCj4+ICsJCXJldHVybiAwOw0KPj4gKw0KPj4gKwlz
dGF0ZSA9IHZ6YWxsb2MoY2FsY3VsYXRlX3hzdGF0ZV9idWZfc2l6ZV9mcm9tX21hc2soc3RhdGVf
bWFzaykpOw0KPj4gKwlpZiAoIXN0YXRlKQ0KPj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+PiArDQo+
PiArCS8qDQo+PiArCSAqIEFzIGxvbmcgYXMgdGhlIHJlZ2lzdGVyIHN0YXRlIGlzIGludGFjdCwg
c2F2ZSB0aGUgeHN0YXRlIGluIHRoZQ0KPj4gKwkgKiBuZXcgYnVmZmVyIGF0IHRoZSBuZXh0IGNv
bnRleHQgc3dpdGNoIG9yIHB0cmFjZSdzIGNvbnRleHQNCj4+ICsJICogaW5qZWN0aW9uLg0KPiAN
Cj4gV2hhdCBleGFjdGx5IGd1YXJhbnRlZXMgdGhhdCBjdXJyZW50J3MgeHN0YXRlIGlzIHZhbGlk
IGluIHRoZSBoYXJkd2FyZQ0KPiByZWdpc3RlcnM/IFRoaXMgaGFzIHRvIGJlIGZ1bGx5IHByZWVt
cHRpYmxlIGNvbnRleHQsIG90aGVyd2lzZSB5b3UgY291bGQNCj4gbm90IGludm9rZSB2emFsbG9j
KCkgd2hpY2ggY2FuIHNsZWVwLg0KPiANCj4gV2hpY2ggaW4gdHVybiBtZWFucyB0aGF0IHRoZSBw
bGFjZW1lbnQgb2YgdGhlIGV4Y2VwdGlvbiBmaXh1cCBpbiBhIGxhdGVyDQo+IHBhdGNoIGlzIGJy
b2tlbjoNCj4gDQo+PiBERUZJTkVfSURURU5UUlkoZXhjX2RldmljZV9ub3RfYXZhaWxhYmxlKQ0K
Pj4gew0KPj4gCXVuc2lnbmVkIGxvbmcgY3IwID0gcmVhZF9jcjAoKTsNCj4+IA0KPj4gKwlpZiAo
aGFuZGxlX3hmZF9ldmVudCgmY3VycmVudC0+dGhyZWFkLmZwdSwgcmVncykpDQo+PiArCQlyZXR1
cm47DQo+IA0KPiBBbmQgbm8sIHdlIGFyZSBub3QgZ29pbmcgdG8gdXNlIGFuIGF0b21pYyBhbGxv
Y2F0aW9uIGZvciB0aGlzLg0KPiANCj4gRm9yIHRoZSBvdGhlciBjYWxsIHNpdGUgZnJvbSB4c3Rh
dGVyZWdzX3NldCgpIHRoZSBGUFUgcmVnaXN0ZXIgc3RhdGUgaXMNCj4gZGVmaW5pdGVseSBub3Qg
bGl2ZSBiZWNhdXNlIHRoZSB0YXNrIGlzIHN0b3BwZWQgYW5kIHRoZSBGUFUgcmVnaXN0ZXJzDQo+
IGlmIGxpdmUgYmVsb25nIHRvIHRoZSBwdHJhY2VyLg0KPiANCj4gU28geW91IHJlYWxseSB3YW50
IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiBzdGF0aWMgc3RydWN0IGZwcmVnc19zdGF0ZSAq
c3dhcF9mcHN0YXRlKGZwdSwgbmV3c3RhdGUsIG1hc2ssIHNpemUpDQo+IHsNCj4gICAgICAgIG9s
ZF9zdGF0ZSA9IGZwdS0+c3RhdGU7DQo+ICAgICAgICBmcHUtPnN0YXRlID0gbmV3c3RhdGU7DQo+
ICAgICAgICBmcHUtPnN0YXRlX21hc2sgPSBtYXNrOw0KPiAgICAgICAgZnB1LT5zdGF0ZV9zaXpl
ID0gc2l6ZTsNCj4gICAgICAgIHJldHVybiBvbGRfc3RhdGUgIT0gZnB1LT5fX2RlZmF1bHRfc3Rh
dGUgPyBvbGRfc3RhdGUgOiBOVUxMOw0KPiB9DQo+IA0KPiBpbnQgcmVhbGxvY194c3RhdGVfYnVm
ZmVyKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLCB1NjQgbWFzaykNCj4gew0KPiAJb2xkX3N0YXRl
Ow0KPiAgICAgICAgZnB1ID0gdHNrLT5mcHU7DQo+IA0KPiAgICAgICAgc2l6ZSA9IGNhbGNfc2l6
ZShzdGF0ZV9tYXNrKTsNCj4gICAgICAgIHN0YXRlID0gdnphbGxvYyhzaXplKTsNCj4gICAgICAg
IGlmICghc3RhdGUpDQo+ICAgICAgICAJcmV0dXJuIC1FTk9NRU07DQo+IA0KPiAJaWYgKGNwdV9m
ZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfWFNBVkVTKSkNCj4gCQlmcHN0YXRlX2luaXRfeHN0
YXRlKCZzdGF0ZS0+eHNhdmUsIHN0YXRlX21hc2spOw0KPiANCj4gICAgICAgIGlmICh0c2sgIT0g
Y3VycmVudCkgew0KPiAgICAgICAgICAgICAgICAvLyBQVFJBQ0UgLi4uLg0KPiAgICAgICAgCW9s
ZF9zdGF0ZSA9IHN3YXBfZnBzdGF0ZShmcHUsIHN0YXRlLCBzdGF0ZV9tYXNrLCBzaXplKTsNCj4g
ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgIGZwcmVnc19sb2NrKCk7DQo+ICAgICAg
ICAgICAgICAgIGlmICghcmVnaXN0ZXJzX3ZhbGlkKCkpDQo+ICAgICAgICAgICAgICAgICAgICAg
IGNvcHlfc3RhdGUoc3RhdGUsIGZwdS0+c3RhdGUpOw0KPiAgICAgICAgICAgICAgICBvbGRfc3Rh
dGUgPSBzd2FwX2Zwc3RhdGUoZnB1LCBzdGF0ZSwgc3RhdGVfbWFzaywgc2l6ZSk7DQo+ICAgICAg
ICAgICAgICAgIGZwcmVnc191bmxvY2soKTsNCj4gICAgICAgIH0NCj4gDQo+ICAgICAgICB2ZnJl
ZShvbGRfc3RhdGUpOw0KPiAgICAgICAgcmV0dXJuIDA7DQo+IH0NCj4gDQo+IEFuZCB0aGUgZXhj
ZXB0aW9uIGZpeHVwIGhhcyB0byBtb3ZlIGludG8gdGhlIGlycSBlbmFibGVkIHJlZ2lvbi4gSSBj
b21lDQo+IHRvIHRoYXQgcGF0Y2ggbGF0ZXIuDQoNCk9rYXksIElJVUMsICgxKSB2emFsbG9jKCkg
Y2FuIHNsZWVwLCAoMikgdGhlIGNhbGwgc2l0ZSBoYXMgdG8gYmUgcHJlZW1wdGlibGUsDQp0aHVz
ICgzKSBsb2NrIHJlZ2lzdGVyIHN0YXRlcy4NCg0KVGhhbmtzIGZvciB0aGUgY29kZS4NCg0KPj4g
QEAgLTExNDcsNiArMTI2OCw4IEBAIHN0YXRpYyBpbnQgY29weV91YWJpX3RvX3hzdGF0ZShzdHJ1
Y3QgZnB1ICpmcHUsIGNvbnN0IHZvaWQgKmtidWYsDQo+PiAJaWYgKHZhbGlkYXRlX3VzZXJfeHN0
YXRlX2hlYWRlcigmaGRyKSkNCj4+IAkJcmV0dXJuIC1FSU5WQUw7DQo+PiANCj4+ICsJaGRyLnhm
ZWF0dXJlcyAmPSBmcHUtPnN0YXRlX21hc2s7DQo+IA0KPiBUaGlzIGlzIHJlYWxseSB0aGUgd3Jv
bmcgcGF0Y2ggZG9pbmcgdGhpcy4gVGhpcyBiZWxvbmdzIGludG8gdGhlIG9uZQ0KPiB3aGljaCBp
bnRyb2R1Y2VzIGZwdS0+c3RhdGVfbWFzay4NCg0KVGhlIHN0YXRlX21hc2sgZmllbGQgd2FzIGlu
dHJvZHVjZWQgaGVyZToNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS90
eXBlcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZnB1L3R5cGVzLmgNCmluZGV4IGFkNWNiZjky
MmUzMC4uMGNjOWY2YzVhMTBjIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZnB1
L3R5cGVzLmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS90eXBlcy5oDQpAQCAtMzM2
LDYgKzMzNiwxMyBAQCBzdHJ1Y3QgZnB1IHsNCiAJICovDQogCXVuc2lnbmVkIGxvbmcJCQlhdng1
MTJfdGltZXN0YW1wOw0KIA0KKwkvKg0KKwkgKiBAc3RhdGVfbWFzazoNCisJICoNCisJICogVGhl
IGJpdG1hcCByZXByZXNlbnRzIHN0YXRlIGNvbXBvbmVudHMgdG8gYmUgc2F2ZWQgaW4gLT5zdGF0
ZS4NCisJICovDQorCXU2NAkJCQlzdGF0ZV9tYXNrOw0KDQpCdXQgYXMgeW91IHN1Z2dlc3RlZCBp
biB0aGUgb3RoZXIgZW1haWwsIEnigJltIGdvaW5nIHRvIGNyZWF0ZSBhIG5ldyBwYXRjaCB0aGF0
DQppbnRyb2R1Y2VzIG5ldyBtYXNrIGFuZCBzdGF0ZSBmaWVsZHMgaW4gc3RydWN0IGZwdSBhbmQg
YWRkIHRoaXMuDQoNClRoYW5rcywNCkNoYW5nDQoNCg==
