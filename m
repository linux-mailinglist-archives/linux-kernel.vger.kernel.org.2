Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6E39FFD2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhFHSgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:36:51 -0400
Received: from mail-sn1anam02on2091.outbound.protection.outlook.com ([40.107.96.91]:50435
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234600AbhFHSe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSadALH0Dk66z37Is/URUrh9VXjTSbddRxG7GX8b6kbWtNpvH0xzu2I0qI9oe6BJ+0aadQLY5Bwz72QrxLvMQhlp6jXOdQi/o+x9+NfYSw6KwJF5Adl8ums8PwS4p6nnAdq/U/UZacn3TZ3j2EEAiDegNV3/6b+yMz7FNa2f17ZFmyLKmyA9spT47QxFIuu6ONGgIKMSag2RXBvAMOcFd76EKZXFG3bFb3rtSrRMym+X1qW9MM0ZgxQ7EefyGjVQXUvVkhqk21fO2B9O7C6zeqG9VgBF7dPSoNF/ndOnjGbJ7o2z0JGToM2D9HMDZQVwg32tcLyDjZKw/vAr/12O5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQKTARO46pZwDPAULwslP3xLIM6HbUVqV0SmS7J5DV0=;
 b=LqU0CMv5GlBL0szppVT7sRtYqsTwZokgS1eCqxOn4GIfFDNERALWAykTeDv82dxht0XWJhzVZZ+OQqSkMuwEpqxImPA/HfT5r2bFQixmRuzdwxsO2RJPZeZRTcnoXZ0/Qj//sTYyEQojdzdNKH0PiSvbBHkrAbZy7ipTlX8ITfAONdOw1awshPo7d6tk984gY2oi9IcenKPzo/90z4ikz7DR3chTO4Kz6YfrgU9ysdWKkUd1uIcvYIROO2jIEq8RljZPrb3TDB7Pk3zmUDm/oMs9wBDvDMr/8iePqf87zaapBlZUY8VDKGp6n6kiKj/QWYmp9yUWW06P3wWwbVl1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psu.edu; dmarc=pass action=none header.from=psu.edu; dkim=pass
 header.d=psu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psu.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQKTARO46pZwDPAULwslP3xLIM6HbUVqV0SmS7J5DV0=;
 b=R5Fdt2MYtgaY1oOmioom3YDbL9kr6oo/HRNoGN7A1iuq8ES6iYR6VtgJS5y3Tyc2yj9JfZ6WYatBxWGd84ti5O4qT9xzWhBxgmpoUgjTQWFvHHWp347zzhvy3B1maSwHfkGDFoxeuu5AcD2svkziFq8ygT0QX1KeCv96iHCGAJQ=
Received: from BL0PR02MB4370.namprd02.prod.outlook.com (2603:10b6:208:42::31)
 by BL0PR02MB4961.namprd02.prod.outlook.com (2603:10b6:208:57::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 18:33:01 +0000
Received: from BL0PR02MB4370.namprd02.prod.outlook.com
 ([fe80::35b8:ef07:8fb7:45cc]) by BL0PR02MB4370.namprd02.prod.outlook.com
 ([fe80::35b8:ef07:8fb7:45cc%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 18:33:01 +0000
From:   "Lin, Zhenpeng" <zplin@psu.edu>
To:     Kees Cook <keescook@chromium.org>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slub: choose the right freelist pointer location when
 creating small caches
Thread-Topic: [PATCH] slub: choose the right freelist pointer location when
 creating small caches
Thread-Index: AQHXXJPcuZEfER7lZkGUYZVvC3KPw6sKLTUA
Date:   Tue, 8 Jun 2021 18:33:01 +0000
Message-ID: <F9847E9B-5557-4FAC-AE80-829D0AD712A3@psu.edu>
References: <6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu>
 <202106081125.E2DA4DE8@keescook>
In-Reply-To: <202106081125.E2DA4DE8@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=psu.edu;
x-originating-ip: [67.22.19.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb77e727-dc06-4d32-3cb1-08d92aabd8b8
x-ms-traffictypediagnostic: BL0PR02MB4961:
x-microsoft-antispam-prvs: <BL0PR02MB49619D984719F3A558887F26B7379@BL0PR02MB4961.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cjYJRxlxCqy02D2GHFhj/JJevE65+D3qbzEAzfOsfDR71kNVPTXH3o5lvYIBSqISYwhwDWWWzfoS808SkPKi+itJo+uon+oMPy0QZoewmJZSBxuFn8v9Qdj9bX3cQlEkNi3jKH/Sc7zPGDb+xGSXDe2ta2HToMFN0KoT1UunHu8AA27qzWQkFwfW2b/KhjCyVj0EVYjN4rS4TNIdPkcGvCNzv3V0md2t9weZkdAeH7b+fVbW2riIV/QWU7UdYhjX1Ec8FzxiMJo/clVmbBg6v6qAKftbHmLen2ZGtYMD7kIR/b01JfjeHf3haXwvL2eS+VXTQRnTYUaoM/0jljSKTXFPAzHYorAxL4Ft7Os9fyZQtGZOU7TnO7zVqqc7np2HVuKjeXZnRIS8lrFUdVB3dYXU0Kq5YzG1De42KZayAB0CODq03U89VlMjb2CXzUnjnD7Br/BPZz1Lf0ZUWJTwJySv+TroW+8LJ4pLXFE/oHd2BWOLYZlwDHuj448oN5w4xYISfzv85iqZ4yat1buUEcNZhbDh0fAvVo+uLMjfIFebz5hk8zTvAbfJQTDzd+z7tqERB3Tt60IhQOleMlksgDQGwgo4/bnMexK20zL2gkdj67cRrNhkwKOTm5qPCw2Qhlc8tTv8/eHWEdO1NRWkl5WcIOFmxixhcvKrXVeSmUJVqLz008gmmsMvjRyRTrXX/cPrJNNORVGx7asxk8B2b1l4grwEIrQvgwjgisBEGrtG//+YGMpYwx+7r+/ouWVco9OV3FgZLod7JtxHp0xzfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4370.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(26005)(6486002)(4326008)(6916009)(6506007)(2906002)(36756003)(186003)(6512007)(8676002)(66556008)(38100700002)(2616005)(66476007)(66946007)(33656002)(71200400001)(5660300002)(54906003)(86362001)(45080400002)(478600001)(75432002)(76116006)(8936002)(786003)(316002)(122000001)(966005)(64756008)(83380400001)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWorRTR0ZkR1VnhxdXorYzF3ZzA0WEdYNlJyeHJ4SXQ0eUZaZW96K0xjWVla?=
 =?utf-8?B?L1A5bW9SYlg3M05pbXEyYjZFTTJ2cG81eEJuSDhkTW1kL25LZGdVaTZjY3FG?=
 =?utf-8?B?bU51cWQrRzZnWTZOcVI3ODNwNE8zZlA5T2lPRjM2RSs5RTZvV2JyZlpjQkdy?=
 =?utf-8?B?NUU0MnhFSWtwNEFpWmV6L2h4bTRsR2tOcCtRQzkwQmRxR0l6WEpja3BRYzhZ?=
 =?utf-8?B?V3JSRkNFQTlGLzl0dUdxTVhCVUMxcmRLWTM2Z3VLOTRHTDNmaTRBKzlBZ21t?=
 =?utf-8?B?dlVQM05XWEY0WksrOWtWRjVudG9pTElBWXlOVThET3Rxdmh5UEhpUHc4SERD?=
 =?utf-8?B?cGlPcDIwTVV2UU1qK2lQR3lYbHRicHFJbFhkVkc0Ymc1UnQ3ZkJudDJwcEhX?=
 =?utf-8?B?ZHFuNnM2MEZQTXQzdldKbkQzVXJjczZyU2h5QmthdzZwUkdtMnN4RDZtVkN5?=
 =?utf-8?B?YnpWd3RENEEwSExzbSt2WUg2UHVOVzF4a0lFeCtBVWVlK09kdEptemR5c2Qx?=
 =?utf-8?B?NG1IU2N5dXB0T3R6YjRNVjVBYllaU1pNQmZEdi80VnV4aDQ2MCtHME5WYllH?=
 =?utf-8?B?UFZzZVVLWUo3ZmIyMHhSdS9HaXUydHdjN3RoV0dKVExLZkFPeGx3bVNTYm9x?=
 =?utf-8?B?bkpnaWNzckh0WUh6Y0Q2MDM0b29TOENUMldXMU1VZ25zVGNtQ1NtTU9DZ2hR?=
 =?utf-8?B?ajZxNFlST1h0ZlRNTnRLa2lPV1N5Z1VnQ1pOTE9FWG5VcHpvOEc3d2NMNWN4?=
 =?utf-8?B?TjRTR1psY1BMNFFKVUtQOU80QldWU05IbERFNzlXVkNwcS9sK0xCWVZEZ0Zv?=
 =?utf-8?B?UnRwRWV6OFBvUDkwS0xOSUY3WHY5WVlRNjh2cGpJdnJaek9hZTFpVGVjSkZv?=
 =?utf-8?B?L1VMcEVFSXluZnYwMVRGQzIrdVNEOEFITzJUQytVWEJERzgwZ0RHZXhjMVdR?=
 =?utf-8?B?V0F2bUxTK21ocXlPZkM4R1U1dkN6N2hlNWVOcFNmYnBSazNrWnhTRHlmNFhj?=
 =?utf-8?B?Y3RPVUU0VnQ3WTBIelVmSEdkY0RTRWpsT2xvSVh4UHh1SG1yQWFWL21NTUsz?=
 =?utf-8?B?bTFFWHg2RzdLT1VWK2ljSWttbmtBNGFHWFdock0rMVVDV0ttamxibklCODRl?=
 =?utf-8?B?VWF0eUdrNEI1N1hXNWRWZnZGaXJBVERLQmp1aWFsdjBZY296TnlnUHpuNjNE?=
 =?utf-8?B?OU4yOVQwZDJmSzYyRlhPc0VzekJjN0dsYW5DZ0owREdJRExVOHRFZUk1d2pU?=
 =?utf-8?B?T2FVN2duWVJzNjBBcTU0aThvVVZpbGJxVERhS1VyOFBlUGZmbWNid1FRclNN?=
 =?utf-8?B?WlRGaVR1Sk8vOW5SSVRlNkpSa1hyc3E0YWM2amRaQ0IwUHp6M1JGbTRCV0xJ?=
 =?utf-8?B?cU15MHZlN244eURzRm9ncXNmTXlIaXdCQkUySzlDeTZOUUJITGZKeEdWQ2kr?=
 =?utf-8?B?VnlzZ2t6RnBCMm5wZVg2QmJ6RjRWVkhzV2FzcGFFdWlJTXhidDg2ZlpjcEZG?=
 =?utf-8?B?UzBpZXB3M2ZyeDJYRzZVUjZuZkpPOTg3VGNrMjFMUTVYS21FR1hqWi9BRTRp?=
 =?utf-8?B?aHhmdEpIa2hFc0dMU3ltczd4U1ZpMHF5K01WZlpmOEZwU0ZiZGx5QWd2MHRE?=
 =?utf-8?B?RWgrblU0WGliSzZtUTBtV1ZQVXF5TnREOVVBYjFDTHVHNERZVThzYkNxYUxv?=
 =?utf-8?B?b3ZwT3JmSm5nYzFWSUcyalVVMUJGVFhWQzNGb2FPNmlNU3JYMlNOS2xpR3VY?=
 =?utf-8?Q?BT16gHmHYBfODOTeBjETI9dFzaKHVhOwkFNLAag?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5D9AC39D52A3D4192C8C579BBE28CFD@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: psu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4370.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb77e727-dc06-4d32-3cb1-08d92aabd8b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 18:33:01.1703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cf48d45-3ddb-4389-a9c1-c115526eb52e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRrQ+UOUsLyF/GYhBfHOXJQ4GUKXDNj6W+NCS/6VaKXtbDFiKA9OkaBQ+oD5dxvA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4961
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgZG8gZXhpc3Qgb2JqZWN0cyB3aG9zZSBzaXplIGlzIHNtYWxsZXIgdGhhbiAyKnNpemVv
Zih2b2lkKikuIEUuZy4gc3RydWN0IGNjaWQgaW4gRENDUCBtb2R1bGUuDQoNCu+7v09uIDYvOC8y
MSwgMjoyNiBQTSwgIktlZXMgQ29vayIgPGtlZXNjb29rQGNocm9taXVtLm9yZz4gd3JvdGU6DQoN
CiAgICBPbiBTYXQsIEp1biAwNSwgMjAyMSBhdCAwMTo1ODoxM0FNICswMDAwLCBMaW4sIFpoZW5w
ZW5nIHdyb3RlOg0KICAgID4gV2hlbiBlbmFibGluZyBDT05GSUdfU0xVQl9ERUJVRyBhbmQgYm9v
dGluZyB3aXRoICJzbHViX2RlYnVnPVoiLCB0aGUNCiAgICA+IGtlcm5lbCBjcmFzaGVzIGF0IGNy
ZWF0aW5nIGNhY2hlcyBpZiB0aGUgb2JqZWN0IHNpemUgaXMgc21hbGxlcg0KICAgID4gdGhhbiAy
KnNpemVvZih2b2lkKikuIFRoZSBwcm9ibGVtIGlzIGR1ZSB0byB0aGUgd3JvbmcgY2FsY3VsYXRp
b24NCiAgICA+IG9mIGZyZWVwb2ludGVyX2FyZWEuIFRoZSBmcmVlbGlzdCBwb2ludGVyIGNhbiBi
ZSBzdG9yZWQgaW4gdGhlDQogICAgPiBtaWRkbGUgb2Ygb2JqZWN0IG9ubHkgaWYgdGhlIG9iamVj
dCBzaXplIGlzIG5vdCBzbWFsbGVyIHRoYW4NCiAgICA+IDIqc2l6ZW9mKHZvaWQqKS4gT3RoZXJ3
aXNlLCB0aGUgZnJlZWxpc3QgcG9pbnRlciB3aWxsIGJlIGNvcnJ1cHRlZCBieQ0KICAgID4gU0xV
Ql9SRURfWk9ORS4NCiAgICA+IA0KICAgID4gRml4ZXM6IDMyMDJmYTYyZmI0MyAoInNsdWI6IHJl
bG9jYXRlIGZyZWVsaXN0IHBvaW50ZXIgdG8gbWlkZGxlIG9mIG9iamVjdCIpDQogICAgPiBGaXhl
czogODliODNmMjgyZDhiICgic2x1YjogYXZvaWQgcmVkem9uZSB3aGVuIGNob29zaW5nIGZyZWVw
b2ludGVyIGxvY2F0aW9uIikNCiAgICA+IFNpZ25lZC1vZmYtYnk6IFpoZW5wZW5nIExpbiA8enBs
aW5AcHN1LmVkdT4NCiAgICA+IC0tLQ0KICAgID4gbW0vc2x1Yi5jIHwgNCArKy0tDQogICAgPiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KICAgID4gDQog
ICAgPiBkaWZmIC0tZ2l0IGEvbW0vc2x1Yi5jIGIvbW0vc2x1Yi5jDQogICAgPiBpbmRleCAzZjk2
ZTA5OTgxN2EuLmNiMjMyMzNlZTY4MyAxMDA2NDQNCiAgICA+IC0tLSBhL21tL3NsdWIuYw0KICAg
ID4gKysrIGIvbW0vc2x1Yi5jDQogICAgPiBAQCAtMzcwNCw3ICszNzA0LDcgQEAgc3RhdGljIGlu
dCBjYWxjdWxhdGVfc2l6ZXMoc3RydWN0IGttZW1fY2FjaGUgKnMsIGludCBmb3JjZWRfb3JkZXIp
DQogICAgPiAJICogY2FuJ3QgdXNlIHRoYXQgcG9ydGlvbiBmb3Igd3JpdGluZyB0aGUgZnJlZXBv
aW50ZXIsIHNvDQogICAgPiAJICogcy0+b2Zmc2V0IG11c3QgYmUgbGltaXRlZCB3aXRoaW4gdGhp
cyBmb3IgdGhlIGdlbmVyYWwgY2FzZS4NCiAgICA+IAkgKi8NCiAgICA+IC0JZnJlZXBvaW50ZXJf
YXJlYSA9IHNpemU7DQogICAgPiArCWZyZWVwb2ludGVyX2FyZWEgPSBzLT5vYmplY3Rfc2l6ZTsN
CiAgICA+IA0KICAgID4gI2lmZGVmIENPTkZJR19TTFVCX0RFQlVHDQogICAgPiAJLyoNCiAgICA+
IEBAIC0zNzUxLDcgKzM3NTEsNyBAQCBzdGF0aWMgaW50IGNhbGN1bGF0ZV9zaXplcyhzdHJ1Y3Qg
a21lbV9jYWNoZSAqcywgaW50IGZvcmNlZF9vcmRlcikNCiAgICA+IAkJICovDQogICAgPiAJCXMt
Pm9mZnNldCA9IHNpemU7DQogICAgPiAJCXNpemUgKz0gc2l6ZW9mKHZvaWQgKik7DQogICAgPiAt
CX0gZWxzZSBpZiAoZnJlZXBvaW50ZXJfYXJlYSA+IHNpemVvZih2b2lkICopKSB7DQogICAgPiAr
CX0gZWxzZSBpZiAoZnJlZXBvaW50ZXJfYXJlYSA+PSAyICogc2l6ZW9mKHZvaWQgKikpIHsNCiAg
ICA+IAkJLyoNCiAgICA+IAkJICogU3RvcmUgZnJlZWxpc3QgcG9pbnRlciBuZWFyIG1pZGRsZSBv
ZiBvYmplY3QgdG8ga2VlcA0KICAgID4gCQkgKiBpdCBhd2F5IGZyb20gdGhlIGVkZ2VzIG9mIHRo
ZSBvYmplY3QgdG8gYXZvaWQgc21hbGwNCiAgICA+IC0tDQogICAgPiAyLjE3LjENCg0KICAgIE5B
SywgSSdkIHByZWZlciB0aGlzIGdldCBjbGVhbmVkIHVwIG1vcmUgY29tcGxldGVseSwgZXNwZWNp
YWxseSBzaW5jZQ0KICAgIHRoZXJlIGFyZSBubyBvYmplY3RzIG9mIHRoYXQgc2l6ZSBpbiB0aGUg
a2VybmVsIGN1cnJlbnRseToNCg0KICAgIGh0dHBzOi8vbmFtMTAuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2VybmVsLm9yZyUyRmxrbWwl
MkYyMDIwMTAxNTAzMzcxMi4xNDkxNzMxLTEta2Vlc2Nvb2slNDBjaHJvbWl1bS5vcmclMkYmYW1w
O2RhdGE9MDQlN0MwMSU3Q3pwbGluJTQwcHN1LmVkdSU3QzI4YjZmM2M1YTNiMTQ5YmU1NmU4MDhk
OTJhYWFmZDI2JTdDN2NmNDhkNDUzZGRiNDM4OWE5YzFjMTE1NTI2ZWI1MmUlN0MwJTdDMCU3QzYz
NzU4NzczNjE1NTQ5MzgxNiU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAw
JmFtcDtzZGF0YT0lMkY4Q1hWa3FsaEE3Um5mWCUyQkRQMDclMkY0dDFOSXcxQ0hzVXB1dVdyc0x5
VTlvJTNEJmFtcDtyZXNlcnZlZD0wDQoNCiAgICAtLSANCiAgICBLZWVzIENvb2sNCg0K
