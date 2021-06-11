Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B903A3AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 06:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFKEYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 00:24:11 -0400
Received: from mail-mw2nam10on2097.outbound.protection.outlook.com ([40.107.94.97]:57089
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229540AbhFKEYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 00:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKm1h/8Z+TFDHMT4FDghFYmDyXaENsCaEH15V2JX+/yoXUOEGYpyp/c4F+QdbwrusKYdYznrysSzf3pvVOvwOq05yz7czfomA4hgooOKjAVd3QLSDLFQ15YGRamHA0vXXFAjxQWYd575PBJ1R3C9fAAbTkBiUENjDSWacQNL45NuTdK0+Rv3yOw4VGVNcORiO2nugTxQT7JW/P5fW2hX8miZmoM8q8VNKULrf9H7jDmcqmlIlX8GgwPYnnq00JnrPWoo62RVpWFh+ZY+uWnIx97HvfMmCmGLfdQPGgMM8dEHzhTQ51hiegF/BSQ+UTzsMOTz9Zv7k7F3BbcSIKGf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p91vglOKOVBJ+zUtj++zxQR2ueuF0dZ9uAPTkjmbHWs=;
 b=K7+rtOo8/Kvj39JKJTWpGXCQLKlqAn9mzsRo85YnbBTf6KffWBYwyKhGSjyp+EcmUn9IqKDhsZ6hi9Sr+/fwwQLfyDTvz/PpJDD0k2UcY3nu0W+KQjlo+ry74NOf2LPe852tM7DuZSwrHFGgudvWuQUm5BnqHo78yzb0chEiRQUTX6NMGzDJXrBAspVNGl5mYcQifZ32O7r7sK77GSSukwChxrlTTkfi1tjPWUnRqjl8cwoGRfwKQdxtr9Lj20IuGeoFSj8lCvurD9fbEuVTQYTHelMlrKrF46/obE3K7mgc1fEWf5PWsLbdjngj9t4BOQHKEivNAgoMm1J1GwJcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psu.edu; dmarc=pass action=none header.from=psu.edu; dkim=pass
 header.d=psu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psu.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p91vglOKOVBJ+zUtj++zxQR2ueuF0dZ9uAPTkjmbHWs=;
 b=Qbu4GkHlze1W95lUWjqmlhrChOkt3M3OAZ2h2uKPLSNap+3G3ONRFcMPVQZThpt8ELfY4iY6Z1EcT7LLGVw2L4QRK79vkb+Po2jccMV5FCTMKJRUAntk/T3Ezg+LqaLHpOXD0n+NNK21IRh63lLKlXnwQG6s3IP3fL6OxLPuxgA=
Received: from BL0PR02MB4370.namprd02.prod.outlook.com (2603:10b6:208:42::31)
 by BL0PR02MB4338.namprd02.prod.outlook.com (2603:10b6:208:40::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Fri, 11 Jun
 2021 04:22:10 +0000
Received: from BL0PR02MB4370.namprd02.prod.outlook.com
 ([fe80::35b8:ef07:8fb7:45cc]) by BL0PR02MB4370.namprd02.prod.outlook.com
 ([fe80::35b8:ef07:8fb7:45cc%5]) with mapi id 15.20.4195.032; Fri, 11 Jun 2021
 04:22:10 +0000
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
Thread-Index: AQHXXJPcuZEfER7lZkGUYZVvC3KPw6sKLTUAgABFaQD//8QFgIAAiFAAgAKw9YCAAHAQAIAAFoKA
Date:   Fri, 11 Jun 2021 04:22:10 +0000
Message-ID: <4D94B372-CE2D-4E6F-9F02-AF3655E62A8B@psu.edu>
References: <6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu>
 <202106081125.E2DA4DE8@keescook>
 <F9847E9B-5557-4FAC-AE80-829D0AD712A3@psu.edu>
 <202106081140.F73F91F@keescook>
 <25AB8A72-B970-47C2-8688-48126075E72E@psu.edu>
 <202106081614.E57675D17@keescook>
 <C7AC6780-9DCE-4CE5-90B1-9AA0731341BF@psu.edu>
 <202106101601.E9273DD34@keescook>
In-Reply-To: <202106101601.E9273DD34@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=psu.edu;
x-originating-ip: [67.22.19.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8da7a17a-4137-4e9c-fe0d-08d92c907b52
x-ms-traffictypediagnostic: BL0PR02MB4338:
x-microsoft-antispam-prvs: <BL0PR02MB4338F7BFDE2882BE55BCF989B7349@BL0PR02MB4338.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s/sNpyQEHw/3iXgHq1zwBkG9a7O45ZeAV1JxbAFxrOUI70WXh6rOryhV/6usI9HdNVR7VyOUYGgCTP3hxt7X5bjpuli2TrE6apzsnElQxea0P5nHw7ipTTW36vpfyXN8rVTyWIDYHmiXEMhSxM0xVfHcfhWJ+azzGXrfZ2udjIOlYTH6bHxfPexAEAyc7/AjvNP0oxEcOAPi1qdy2Z/Y44iy7kX2935OI58O4izq7FaC41mY/ZJJfEqiKHq+UdEpidnjk9d1VCySeEOkIxOM4o+s9lpBvbiHNLfQ5vIxsnXPqidsRdbtv02E9VlJnbejN1UwITOWv+NV8SW4LuZfn2Sq7SaJcJI7vZg9kfTowHLBKPmI/WHhDjC1ReZEy5CCFTeUzBnbHodJsmopAIq6c+ulclGc+19csWODzkkl7INdVPp4BsvnWpzr//S/xyzeFMwiLAlZ2vnbqbSMOeG7/c3tNIrFFKcE2tdtp0TRnPzI7rUY8mBZ3tIhx5tb7qB6ZLxYwNry0tKa8dhIlLzrFsB1EoUGvjkHwp6hAoSbPa+C7WYgoFHBhQ6KMDpWb/Fbs/K7IpdcYxYYuEjuE3STwMUhZq0QaMnyq7BJG12YEr5nvvEq1vH5XQ10PNcbzCLGg2Xy/dBmfpBmGV2u8yxmpKnLHH2aaUGF5MwDgphnblg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4370.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(54906003)(2616005)(4326008)(38100700002)(91956017)(26005)(316002)(2906002)(122000001)(86362001)(786003)(6916009)(6486002)(36756003)(6506007)(478600001)(8936002)(8676002)(83380400001)(53546011)(66446008)(75432002)(71200400001)(5660300002)(66946007)(76116006)(64756008)(66476007)(6512007)(66556008)(33656002)(186003)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bno2RXBWZG1rMWRKUXcwY3M5VzN4bTlOMzAwYW9UWEx5cnRidGxKY2prNFZJ?=
 =?utf-8?B?Y2grd3hHOEEva3hiazdyQXhEODhBWFBSdmVHVVkzb1ZTSWJpZXZzMmVRaEpz?=
 =?utf-8?B?R1ZnWE9RK3FQQVY3Y2NpYUxxZGVVRjlMYXN6bTlwNVBRL1VjWkx4MVRTUXBw?=
 =?utf-8?B?S2V2UHBnV3AwaXF6RGoyNUM1VXo2MlI2L0dldFNwZGR2a2hteFRJeEJ0M2pJ?=
 =?utf-8?B?ckptRUliVlNoUDZOQ09BcUpxS0h3M282anRJakxBczVTemZ4LzNsM2JPSzRC?=
 =?utf-8?B?bjg4YWdZZkh1aVhhaDdRTUlnYnZQbTF4ZXExS3NUczlhWHpTTUpPNUtIeWIy?=
 =?utf-8?B?eVNBemxGb2hUSWI2UmdoL3I2Wmp6MnEyaDFhTW9tR1hnZlk4NWd5Ky9JTHh5?=
 =?utf-8?B?ZnRSTVQzOE9TRUVUV1lQZ0o5bEhVSkpuVzVYOGs5NEdXTlIzMVd5aWwvdXg5?=
 =?utf-8?B?UXZFYWphTEtqbUd3NHpyODdvc0dVSHk3bXhDVHp2Z3RmbGpRTEFUR2dJRmJr?=
 =?utf-8?B?b2lNc0xsRVBjMlNIQXk3MVpuL0d4MHdSREdRU2JqY2RBdVowY3FsT1lxbzNX?=
 =?utf-8?B?SzVPZTBsSGQvQmdrcmNYRlRneVR2YmxGNlVNdDVDM3d2Zm92TEJMN0xMKzNJ?=
 =?utf-8?B?enJ0T05NWlovckk4OHNHYUcrWUg5WENQZFZkR05DazNSeERKWnNPYzBVV0ZZ?=
 =?utf-8?B?UEFMTDBOcjZ3ZS9zYmM5MkQ5Ylh6aEFscXUwM2tvYVhpaFhHREpBU1hHR1k0?=
 =?utf-8?B?MjFGOVBic3FWWHNyc0ltRkhIWi82YklKenRWazdNekdKaGtlUWNxUm5YNHZw?=
 =?utf-8?B?V0NCeDJSMXg3c0M1WHRLdWZyMFk4VWQwbXNRd1BvNXJ1aVF0dFpvVGdEU29Y?=
 =?utf-8?B?L2ZodU9YMEN4citWTE1WVjA4TU15SDBLMnFUTXFUSmJpODJXVXk4TTE3RHJy?=
 =?utf-8?B?ZndPenQvd3BpUzViWjR3VE5IWE80Y1hDREU4NERzekl0Z3dLdlFseWFKQW4w?=
 =?utf-8?B?ZE9IOWlXbE0rc1BJY05Od0JLZktGb0JocXFRdkluTkVBeUlaS3RBVnZjL251?=
 =?utf-8?B?VmxZSlNRTGdvRElzNzRFbitaVWtHNVphLzl6ZWpTcGpIRUtocFRyczlwODk2?=
 =?utf-8?B?aERCRGFvS3FidEdoSzF6OFpKbGkzd2gxUXUvekJCbUVuZ09QRklJSk0xTkZX?=
 =?utf-8?B?OFBEMklVa1Zuajd2aUFvNUJFbWR6VXFRSUcvdXY3czZVc2hJaFJCanpuUlQ0?=
 =?utf-8?B?MjJhTmNaSVVaL0VvUlRTQ1dYRkZ1M1pZOXRyeFVDd2IybFM4b2VueUt2ZnN5?=
 =?utf-8?B?L3JBZjFjUWZ4bWpzSkNDcW5rS1FBT055ZEE2OXFoeVJhM2VYRGNlckdCV2Fk?=
 =?utf-8?B?S2ZkRDdzemhaeFoveDRaQ2JXY0h0QzBqOEIwUXo3M0E0TTZrNDFVL1JwNjZK?=
 =?utf-8?B?UXNQMGJYVTNQRE9NZ2o0K1YrZFJaWGZFTTMvQXZoVXlvalh5b0VnSlQyVzdK?=
 =?utf-8?B?KzQ3YmZoN3ZNd29iNzFhY2V3b2J3R2FmQzRxNFdBb2dyd3g4dUtqNTdFd0hX?=
 =?utf-8?B?U1BRMWtMSng5UjdzTDFPZ2NEWG5lRFRyUkRSeUZpTnpFNktnRTR5RmlzbG1z?=
 =?utf-8?B?VTBHK2xnbEZCb3UvZklaOFowMWR6V1djSzd6Vkk1UHdLWkIxVkpxTTVMblFM?=
 =?utf-8?B?UW4yRlRZSk9EbDBwTlhLQVpyZmx6Wm1mT1dpTi9FUzBmVU1TSXRxNEdRN2c3?=
 =?utf-8?Q?DXat7oM4joMb2WRO0W+S/UHifWDp+ygVLhjaNjd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBA7C3FABB5A70419F1D0FC15878EE70@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: psu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4370.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da7a17a-4137-4e9c-fe0d-08d92c907b52
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 04:22:10.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cf48d45-3ddb-4389-a9c1-c115526eb52e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzJWwKybPkykwJmGzkyK2dKh8qHYDBdVZ+l74CVDUdzChNxA4cGg9p9DW1auzFXA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4338
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLCB0aGF0IHNob3VsZCBiZSBlbmFibGVkIHRvIHRyaWdnZXIuIA0KDQrvu78tLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+
DQpEYXRlOiBUaHVyc2RheSwgSnVuZSAxMCwgMjAyMSBhdCA3OjAxIFBNDQpUbzogIkxpbiwgWmhl
bnBlbmciIDx6cGxpbkBwc3UuZWR1Pg0KQ2M6IENocmlzdG9waCBMYW1ldGVyIDxjbEBsaW51eC5j
b20+LCBQZWtrYSBFbmJlcmcgPHBlbmJlcmdAa2VybmVsLm9yZz4sIERhdmlkIFJpZW50amVzIDxy
aWVudGplc0Bnb29nbGUuY29tPiwgSm9vbnNvbyBLaW0gPGlhbWpvb25zb28ua2ltQGxnZS5jb20+
LCBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPiwgVmxhc3RpbWlsIEJh
YmthIDx2YmFia2FAc3VzZS5jej4sICJsaW51eC1tbUBrdmFjay5vcmciIDxsaW51eC1tbUBrdmFj
ay5vcmc+LCAibGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyIgPGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBzbHViOiBjaG9vc2UgdGhlIHJpZ2h0
IGZyZWVsaXN0IHBvaW50ZXIgbG9jYXRpb24gd2hlbiBjcmVhdGluZyBzbWFsbCBjYWNoZXMNCg0K
ICAgIE9uIFRodSwgSnVuIDEwLCAyMDIxIGF0IDA4OjIwOjMxUE0gKzAwMDAsIExpbiwgWmhlbnBl
bmcgd3JvdGU6DQogICAgPiBTb3VuZHMgZ29vZC4gQnV0IEkgd291bGQgc3VnZ2VzdCB0aGlzIHRv
IGdvIHRvIC1zdGFibGUgYXMgc29vbiBhcyBwb3NzaWJsZS4gQmVjYXVzZSB0aGlzIGJ1ZyBpcyBh
ZmZlY3RpbmcgdGhlIGJhc2ljIGZ1bmN0aW9uYWxpdHkgb2YgRENDUC4gSXQgY3Jhc2hlcyBrZXJu
ZWwgd2hlbmV2ZXIgYSBuZXcgc29ja2V0IGluIHRoaXMgbW9kdWxlIGlzIGNyZWF0ZWQuDQoNCiAg
ICBCdXQgb25seSB3aGVuIHJlZHpvbmluZyBpcyBlbmFibGVkLCB5ZXM/DQoNCiAgICAtLSANCiAg
ICBLZWVzIENvb2sNCg0K
