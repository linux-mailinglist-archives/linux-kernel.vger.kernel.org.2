Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3796939C4EC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhFECAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:00:04 -0400
Received: from mail-bn8nam08on2119.outbound.protection.outlook.com ([40.107.100.119]:20288
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230169AbhFECAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:00:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egxSqdY31ZvoenbROZbM9AR/YbPfxUux8cRIYcu16tQTwEehkfFdivGsabIeHPwxIuVrokocVUMqiywK1KvPIjfTMWfcAFe65hg442PKBpBhYjKWRMSrjHBjhRXeAL77baUCjf+G9cqjkjUKoWUGDfYUJWsOiGc21Wy3UZPj1009MJ0xW0jXtofFKChsOu4/OhdgQ48X+saocF7nbtUogBNVYwdnw1UbLgwbSyGMUtGvsPxalJhHfbAHTriZmz/BTUM82QAcveB+44H/vweJ9XdVqbeuOVJ6C/WhfZ98PHX3HyXS7+ae9QLZHc5U/U6KK8nUkLV6AyeWZGf109Z9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+gbpXCsnlJwKY5rhaKXO9TugTXG3on4XJh9c1CSFDE=;
 b=AOBUQ8pD52NQ3R4AiLLh1U0rrhRKJY4NCi+B+XZ8MklQc79fE32fnkXd0jCFMItXXsnFNMJcivJTieR4pvzMqyj+Jd1d8ypKGuMzjVIjTPum6GqwVgw+YMZ/a5VY1CbNzvvpxl2sAIOB2fE+/xrXsl/dsE0EY0G8n+nktvKZeRNRUkEknETNVSdUSTuRI8JDxJNUCFq5BXtSFgBQMaZ/oUb54j+OYCZrWlN+eQoWpz0+6puWh7A4oWgIUKe4D/0y3Px04cGD4qAKmjNCnTespY71TxxlKCsmuO9tzESwHYyJlPNpwzwa8fpjH1T51S/FoeDH83e3uvCUUvYnFguvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psu.edu; dmarc=pass action=none header.from=psu.edu; dkim=pass
 header.d=psu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psu.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+gbpXCsnlJwKY5rhaKXO9TugTXG3on4XJh9c1CSFDE=;
 b=giDiUSPlDPoiI5EB8RUhHPaAqwUW2JTyBiPJDPoOzsnKaOfHy1RkHTZgh2VV4wqttF6kPgsX3q3SgtHBC35UE80nu3yROUJY4HC6mA9oVt0unBEnEYLZG7q+6g+thAAvr36HUf6FSgrdIEVaKYWNx7P43CzFk0oiqPYSzgBZDrI=
Received: from BL0PR02MB4370.namprd02.prod.outlook.com (2603:10b6:208:42::31)
 by BL3PR02MB8252.namprd02.prod.outlook.com (2603:10b6:208:343::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Sat, 5 Jun
 2021 01:58:13 +0000
Received: from BL0PR02MB4370.namprd02.prod.outlook.com
 ([fe80::b9aa:60c4:fd30:a12f]) by BL0PR02MB4370.namprd02.prod.outlook.com
 ([fe80::b9aa:60c4:fd30:a12f%7]) with mapi id 15.20.4173.030; Sat, 5 Jun 2021
 01:58:13 +0000
From:   "Lin, Zhenpeng" <zplin@psu.edu>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] slub: choose the right freelist pointer location when
  creating small caches
Thread-Topic: [PATCH] slub: choose the right freelist pointer location when
  creating small caches
Thread-Index: AQHXWa4+V/vSYomud0a9EoZDRw8H2A==
Date:   Sat, 5 Jun 2021 01:58:13 +0000
Message-ID: <6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=psu.edu;
x-originating-ip: [67.22.19.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27480e31-a3ed-4759-9840-08d927c560ac
x-ms-traffictypediagnostic: BL3PR02MB8252:
x-microsoft-antispam-prvs: <BL3PR02MB8252D373CDE2E6A2199F58FEB73A9@BL3PR02MB8252.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMyAYnyHPLEZzHZPOwgprxWbwLA+WQq7fcpwK9d5oERHiTTCROZhg7TYIPLneHDNZNxV8mAvNpE6VGWYbPgzS/anHwU6UUEmCiy25Ki7uDoknHvBZRmN2bEsxT4gd/EDHmYFI2186LcBHLusIwNJId0loo0WYQUSTJ26F0lOgH5Ku+vETzADuERfTIahU9fr3+ByeTtaRSWuHa8HdsXfmm0HYDEnzckhvTTVKuWBNxm3IPUgRxckRDRbffomVZzh0uR80pRCKivvi3Afbwbax0ywy7jy3QfrrFb+XHkozUoPE5XpW7f4WruBR4g8sAqMFg9wTlYMJw2yWjoWe+8z3qYyYtVG9xYX3JaW1wcyGBQY6tyKKWURTTDqZdvGcTyBV2JzFRHXdEX/wmpJKkKX9xCDLdXkenlzg7nsOhTYljU6xju0lAO/DQP3DJCeOFTC3SL8RHejSWX9CLRX7DoOuRVGRYtN5F5RoUqgbl+XeR1WCGHWsc/Y1ckZGEpQRNRESZ5Q4VHsDLKPUESWs5lqudClueeW7EJnbObg4NGMemzRU3gzrOd+j/e2jiZPM0bOVnavSywx5xVHEVyk88icrmLLrYWmRajbOSkrZUjPliU7j2C+V+Zb60o9GGAfToO0yf2sZTza/k1ziPTdLaBLreq2u/Nsm5imIVOIaMM74Fs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4370.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(26005)(186003)(6506007)(8676002)(786003)(36756003)(316002)(6486002)(109986005)(54906003)(4326008)(6512007)(8936002)(2616005)(478600001)(64756008)(2906002)(75432002)(71200400001)(66946007)(66476007)(66556008)(76116006)(66446008)(86362001)(83380400001)(33656002)(122000001)(38100700002)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTRYOW5LbjFJUEtwaktQRHNxRThoMWhRUDl6T3QwUEVlblliYnd1eFk2bDJH?=
 =?utf-8?B?RDl4emFzakkzTzRYc0dTQ1FodzVjZXFNZkFwNmN3aE5tdVBQYSt5dzB2c3Z3?=
 =?utf-8?B?TEM4eWZMaTU3a0I3T1ZnajdmV0VwajNHRFpSMXd1VUlKaEtIRnU5Vi9DODQ0?=
 =?utf-8?B?ZlRHeXRraXF5dlVHVkQrS3RxWTZLODg3cFRxNnBHOXZ3bHNWRm51Q0VWSWVE?=
 =?utf-8?B?TzJGLzFXSkxCYTZIa09sTmxZWVBYam5zVHBUOE1TRm1nN0IvYTlucU5TVUxM?=
 =?utf-8?B?UE9iSnpKTzQ4UlNibk1uUHc2clAzNFFDSFREVGpMMjI4b1JUZ0NXUzNsTXZt?=
 =?utf-8?B?R1Z3MXJ1VG0yekRCTG9CTWpKNzZUaWNmZEV3VmdUU3VSd2hYWCtnMEE5VjhR?=
 =?utf-8?B?cUJmQ1YvTlF0RzJEeWZ3R1MrckJ6NkVQaHZ4QVUyc0o1V1VyQTVKd2VMcUJi?=
 =?utf-8?B?TzgyUHZQekw2c3BNTHNNd0ROQTA5VFdYTnM3WlBTVmZ6bVBGTWcvWjFGOHZG?=
 =?utf-8?B?Y0duRUVCaFNRenhiL1U5NkJTUnFFSWtGTHVpNDYyWkpBdm9CYjRSQml6d2Jj?=
 =?utf-8?B?R3J4ZDBvMU84UnJDd3VndityZXIyS1Jua0o2djlOdnllY2RCSG9lQkdRc3dW?=
 =?utf-8?B?dnY2M240eDBycThIWXB6M1BLWWcrY2JWSEVicnp0L1hPaU0ybWh1UFFWdE5y?=
 =?utf-8?B?aGhyZnJiTWFCc29JQzBDWVlncHE3bjFuN3NXM3QzQmZXVStrc2ZDM1RuN0Fq?=
 =?utf-8?B?RnNienhqVmtocWhkMUl4KytoSENhajgwaGhzY2o2RExOZWRRb1Z6bWZPSVdF?=
 =?utf-8?B?Ulc4RkIvcFVjTnkwcHpBM0p6Sit5TGJ6MW1vQTZyaGdrR0NDdWVhWExyRjJP?=
 =?utf-8?B?Ym9uSHRtcXdJcHJjQ2RrSmYyTFdYV3pqbkxLK0VhKy9hVjNCUjFwbWlGMDBw?=
 =?utf-8?B?ZHM3QzBidko4bnI3ZjdYckFWK0lHS1NJbXlyQkhGSWdWNlBmaWFOeGNwdzdT?=
 =?utf-8?B?QmU4cm54N2crR3I5czBBOTU0NVpXTDFRM0cxS1dSbjFCb01GdFptWHBLK2VE?=
 =?utf-8?B?aCtDZlltVkswcXV1UlNSRGxad0MvUUg0RDJ2WmFwODFTd1pwSllDeVFSeFE4?=
 =?utf-8?B?UWRtSHhicldheHNpMkxyTGxYYll6amFhb2ZHTXNCNDlqcmZsK0lNc1loNlhE?=
 =?utf-8?B?UU5FMG1MMnpRa0xtTFoxcWFuamhLY20wZGhackRKSUpvejREcXlJQUhQQnhJ?=
 =?utf-8?B?ZHZTVVNTOFJqU2ExVzBmSmRsYmRyMXdNYXJka2hyWVpJOUpSNFlzeldEY3J1?=
 =?utf-8?B?VDZhY1pQSXFwZ2FRN3MzQ2ZqTjZpUVZZeXUzRnRUY013ODE5ZVEzTjlqWU0r?=
 =?utf-8?B?WWtGL0tLUUZtb2lSVmJHd3hRS2xpTTRTTkhyMEEzS0plRUNabkRDYmxqdHh6?=
 =?utf-8?B?M1huZTlNSWt2Q0tyZi84WHRDdDFNK25ra3g5MVViSHVYUlhrQTlFMWZMSnFI?=
 =?utf-8?B?RWRnS3F2UFZrQlh5ZHlQUStRbU5xSlMvYy9tTmRZeGtQVVR1N1hFT2VwNnlR?=
 =?utf-8?B?OFFxVTN3bkVHUEJLRm9QVklhU3JlNkxPQXBLNlc0aFFiTW44cXZHNGVYUjE1?=
 =?utf-8?B?SExBWVRuRUtyNVVUWGhhd05rNU5UdlQ4R1lneG5pdWpsMW9abzNKVTViYjFJ?=
 =?utf-8?B?ZWx6VjdvT0NjZDJwTElBemFrSjNFY0RITE8yTUVXME1GODluUUtMeE9aamRs?=
 =?utf-8?Q?oupHRKVR+Z61a4W9Z5Y/qpG72qIHl9gev9q7Ppq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <71AA9A43EF0D3C4EA81674552F6715C5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: psu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4370.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27480e31-a3ed-4759-9840-08d927c560ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2021 01:58:13.2311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cf48d45-3ddb-4389-a9c1-c115526eb52e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/JUkxmk99FFF0PVWKViveBpZTICLRuLc/IRDEpkM4ATltpzIzBuhR6sMHCV9L6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8252
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBlbmFibGluZyBDT05GSUdfU0xVQl9ERUJVRyBhbmQgYm9vdGluZyB3aXRoICJzbHViX2Rl
YnVnPVoiLCB0aGUNCmtlcm5lbCBjcmFzaGVzIGF0IGNyZWF0aW5nIGNhY2hlcyBpZiB0aGUgb2Jq
ZWN0IHNpemUgaXMgc21hbGxlcg0KdGhhbiAyKnNpemVvZih2b2lkKikuIFRoZSBwcm9ibGVtIGlz
IGR1ZSB0byB0aGUgd3JvbmcgY2FsY3VsYXRpb24NCm9mIGZyZWVwb2ludGVyX2FyZWEuIFRoZSBm
cmVlbGlzdCBwb2ludGVyIGNhbiBiZSBzdG9yZWQgaW4gdGhlDQptaWRkbGUgb2Ygb2JqZWN0IG9u
bHkgaWYgdGhlIG9iamVjdCBzaXplIGlzIG5vdCBzbWFsbGVyIHRoYW4NCjIqc2l6ZW9mKHZvaWQq
KS4gT3RoZXJ3aXNlLCB0aGUgZnJlZWxpc3QgcG9pbnRlciB3aWxsIGJlIGNvcnJ1cHRlZCBieQ0K
U0xVQl9SRURfWk9ORS4NCg0KRml4ZXM6IDMyMDJmYTYyZmI0MyAoInNsdWI6IHJlbG9jYXRlIGZy
ZWVsaXN0IHBvaW50ZXIgdG8gbWlkZGxlIG9mIG9iamVjdCIpDQpGaXhlczogODliODNmMjgyZDhi
ICgic2x1YjogYXZvaWQgcmVkem9uZSB3aGVuIGNob29zaW5nIGZyZWVwb2ludGVyIGxvY2F0aW9u
IikNClNpZ25lZC1vZmYtYnk6IFpoZW5wZW5nIExpbiA8enBsaW5AcHN1LmVkdT4NCi0tLQ0KbW0v
c2x1Yi5jIHwgNCArKy0tDQoxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbW0vc2x1Yi5jIGIvbW0vc2x1Yi5jDQppbmRleCAzZjk2
ZTA5OTgxN2EuLmNiMjMyMzNlZTY4MyAxMDA2NDQNCi0tLSBhL21tL3NsdWIuYw0KKysrIGIvbW0v
c2x1Yi5jDQpAQCAtMzcwNCw3ICszNzA0LDcgQEAgc3RhdGljIGludCBjYWxjdWxhdGVfc2l6ZXMo
c3RydWN0IGttZW1fY2FjaGUgKnMsIGludCBmb3JjZWRfb3JkZXIpDQoJICogY2FuJ3QgdXNlIHRo
YXQgcG9ydGlvbiBmb3Igd3JpdGluZyB0aGUgZnJlZXBvaW50ZXIsIHNvDQoJICogcy0+b2Zmc2V0
IG11c3QgYmUgbGltaXRlZCB3aXRoaW4gdGhpcyBmb3IgdGhlIGdlbmVyYWwgY2FzZS4NCgkgKi8N
Ci0JZnJlZXBvaW50ZXJfYXJlYSA9IHNpemU7DQorCWZyZWVwb2ludGVyX2FyZWEgPSBzLT5vYmpl
Y3Rfc2l6ZTsNCg0KI2lmZGVmIENPTkZJR19TTFVCX0RFQlVHDQoJLyoNCkBAIC0zNzUxLDcgKzM3
NTEsNyBAQCBzdGF0aWMgaW50IGNhbGN1bGF0ZV9zaXplcyhzdHJ1Y3Qga21lbV9jYWNoZSAqcywg
aW50IGZvcmNlZF9vcmRlcikNCgkJICovDQoJCXMtPm9mZnNldCA9IHNpemU7DQoJCXNpemUgKz0g
c2l6ZW9mKHZvaWQgKik7DQotCX0gZWxzZSBpZiAoZnJlZXBvaW50ZXJfYXJlYSA+IHNpemVvZih2
b2lkICopKSB7DQorCX0gZWxzZSBpZiAoZnJlZXBvaW50ZXJfYXJlYSA+PSAyICogc2l6ZW9mKHZv
aWQgKikpIHsNCgkJLyoNCgkJICogU3RvcmUgZnJlZWxpc3QgcG9pbnRlciBuZWFyIG1pZGRsZSBv
ZiBvYmplY3QgdG8ga2VlcA0KCQkgKiBpdCBhd2F5IGZyb20gdGhlIGVkZ2VzIG9mIHRoZSBvYmpl
Y3QgdG8gYXZvaWQgc21hbGwNCi0tDQoyLjE3LjENCg0KDQo=
