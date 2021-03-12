Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175823386CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCLHuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:50:54 -0500
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com ([40.107.92.84]:61473
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231352AbhCLHux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:50:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htYtg1nHOucPFBw24n9bBq9pUhb9mN4dZjS9xvevlm9jNkEZ9YLlQUWakQW7hC/FFIrxiGc+8ooo8KiHQk+TyWDLbuaBZJqSP5ILrJ0+xmaVP3f2Ho7MZEnqzV4KDLV7IHCf93JC1EPYWvHXZgbn21PI9dQtfuStYGPNWu6Vqay2t6jvbR9vco0BOBdC2ih7uR+7EQSsPrEgcLvu0+o3GP82myAQK/FCUl34pxxNKgC6ghLRWe95HkfJCdceguQDMZeSykjGC6zycYJ+6zotHK4x9NzmH37QA9pWoe0f6hiM/ct8VeQvE/u+B1GYZtilAAW0zaO7tPcJ5FXGTG4H5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vvZAFbUpytrTAA/0zizMS5HIk4xWtOoQ8wEhs11cMk=;
 b=B6SAemneUx4xeJ+AN48C6LAsp3UGmqNqDkINyeNh3UE8jhPRQk1DF1njrVfzDZEKCw0XVs2HO+DeTb+mXg1jYLC21qCvpuqn0Kyc6ACHjeHhP47K7C74BF7zWoxp1KGVjghx+AoLEsG2zmUpYcV3i8UUkFANRXR8A4/TLrn5nygxfiaEZJkaMm275U+jVJJGMm6StWfh/qGQqPrVCdW05QHx0wpPbqElAhAWRUvsf3f5ZB4nyl9Hh7RaAp0awDLvUcAZvkZPZx41ivVQXZQECEkkkDlZ+p8GOPe4baO0OT2qZE4nlVOUA/2Ld8obr3O0iFbgen97fRZujzJdNrfaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vvZAFbUpytrTAA/0zizMS5HIk4xWtOoQ8wEhs11cMk=;
 b=FuRL1SfE17q286S6VyXHerMAnyXVyP0T5TM1Pv6CaF61FQOnxNPbClqyCSaEFnbxw7Vymhd1SBt8FC7tHTXS0XfHM6D+/Td+3ZRdnV0/eXX1mW2zskecIkSrx4a+n8pUYVtl6a6qg+5EzeDl+3R2rOpcLHs/LRVViCO7Tbyi1Z8=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 07:50:51 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3890.042; Fri, 12 Mar 2021
 07:50:51 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBBUk06IEZpeCBpbmNvcnJlY3QgdXNlIG9mIHNtcF9w?=
 =?gb2312?Q?rocessor=5Fid()_by_syzbot_report?=
Thread-Topic: [PATCH] ARM: Fix incorrect use of smp_processor_id() by syzbot
 report
Thread-Index: AQHXFvX+sav11F3Y4kS3WhZoS3H7Pap/5JcAgAAPsxY=
Date:   Fri, 12 Mar 2021 07:50:50 +0000
Message-ID: <BYAPR11MB2632B2128CAA2EDC34B79C52FF6F9@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210312041246.15113-1-qiang.zhang@windriver.com>,<CACT4Y+ZS5ehyHrm0i-4fAX-Zk6OUN5PqGs0ZT_RC5K=fFgst5w@mail.gmail.com>
In-Reply-To: <CACT4Y+ZS5ehyHrm0i-4fAX-Zk6OUN5PqGs0ZT_RC5K=fFgst5w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfef0425-4016-4e34-c031-08d8e52b8e84
x-ms-traffictypediagnostic: SJ0PR11MB4784:
x-microsoft-antispam-prvs: <SJ0PR11MB4784CD5550226B14572EC1E4FF6F9@SJ0PR11MB4784.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: esOIkKM63RbKBa0DMgcNcdA6cyzdLDvrmxp9h94dpi/KxBeq8vfLRgg/bl3TZCaEO0wqCzEwQYKPyg8bLaWBVEKv65qokd1mFsKjLF6Nd5pyURlVE/Rpi8thOEQrj4YpSsGGw3DVZEKgkuPG+PHtzwB6sb7bxB33o0YD2nGvuF88RsB4QnXBWq+uH5iWsAgTsNDfeXCrpf3K03VSZGm6rgyMPUqFSknuoEezrvb+Zr+pG3MLi+bSSLNI7l/U7PUrszJEQadAXJTSM+VT2luLwUNdJvaOIzY0ulucLEV9XsPqJ2900/gg00SrndDxp0vzIc51m5ViFBmvBVjfBNRhlMe+bkIiD96n/nWwfJ3W+UYvKRNzT21xY2rt5GWo8Z3acFteo4mhJUw+XXZYCAkP7dRo0welCZbD8a9fySes04Pb2+kcufSnsU6bkXJ9FDHqhcyxAPrB/m9N2nzUZheUkMsYE2M/Fx+PJ1xQFpiaG5QLpF/fOW0b0dyRxdEhZKoDPGz9JlA4IazKcKuQMLALVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39850400004)(136003)(53546011)(8936002)(4326008)(26005)(86362001)(7696005)(186003)(54906003)(316002)(64756008)(66556008)(6506007)(478600001)(76116006)(5660300002)(66446008)(91956017)(52536014)(9686003)(6916009)(33656002)(66476007)(71200400001)(55016002)(66946007)(224303003)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?N3JUaUNkR0dvWnJHYmZXQnh2ZTNXS3RyMVNXQzFrQWlDWm9DQlBKRlY1MTYz?=
 =?gb2312?B?T3VlYVorVWpEYm8xTXdubUFXbm1uc3BHNDJoSDRzcHB1RWh6YmVJTFpLQVlV?=
 =?gb2312?B?OCtRSXpab0MzRXJ0ZERZUXVQaVQ2aER4bG1FcDdWdXRYWWVqQTd5THN3UG5o?=
 =?gb2312?B?UlJaL0Y5RWNXeEwvS1dTZlZ1czZYWHJDYWZFVDh1SGNESzdFcnZ3bjN0cTBk?=
 =?gb2312?B?MkN6eUIwaFQ4RFdoQWxWU2tYZG9iNUxheXMzakdKMzlZaUVOM000UnZRN2pY?=
 =?gb2312?B?NWc4T0tyVSs3ZUlhK1p4L3ZFbXY1QkczRGJFQnhPWkgwM1BQZkFZQTFMclBT?=
 =?gb2312?B?bGhHK050T1lQQVBJUmROWENtUWNlT1l1UzRrV3pIMFNLMnU4S09zMzlVOVps?=
 =?gb2312?B?dkVmVzhCS2NGVVQ2aTh1SCtxZXpKK3UxVXk3SitiajE1SDJRS3Q3OHN6NEMy?=
 =?gb2312?B?Zm9tcXo0aWplSU40MjY5VkJUb2hOWGdJZU11ZytQY0RhSHFBdDBsQTl1U1dh?=
 =?gb2312?B?VFc4ZHFEZVQ4Y1JSNjhTVkpJdCtEQllzeEU1UjZYV0NneEd6Qk9HNDgvbnJo?=
 =?gb2312?B?UnVtTGRadGhsb0h5Rk11dHdTam44UWNIL2Q4QmdtQVJ6aXRTT2NQVGhwdWli?=
 =?gb2312?B?T1N4aXpJU3o4YkFkR3kxeUZyMzdPbTZyQm00dlN0S0FHenROUFNWUGd0WGJT?=
 =?gb2312?B?TUR5RCtPb0NJYjcwSklHUDkwajNVNWtnZUhHdUtFcW1GQzZGRWY2NHI1RWk5?=
 =?gb2312?B?TXhOR2F6dS9sMkNCZFJSMXl3RkV0RmppUUtaeTRvRE51cW84VS9xaFJCMkVo?=
 =?gb2312?B?VnNQTUVnK2xUTkdzd2F1M0ZST0M0QmlvTStrNGVZK1R3ckVtdElwNGtRbnJP?=
 =?gb2312?B?eUcwTUtVUnNOM294aTNEWDgwS2gxQkF5ejk3dlVnQmpXb2l4cWxaSUt4azZk?=
 =?gb2312?B?cmtpNm9CanVoS2FVOFFFb2c3YjVYL0pZU3Q3TFRMYWg1Wi9EV3dMbTRpM3Bq?=
 =?gb2312?B?SElYQm05RUZmUWxyS2NmOWlHVjJqWmovb09zV2tlSGRJcmtCaEJWTGpFM2Iz?=
 =?gb2312?B?LzMySG1ZZGx5S3VrOWJDVlQ3UEpmd2hiS2FqelNXRDRQNmhGL0p3RzRCTDc0?=
 =?gb2312?B?azUvUVpiMDh6Z3BFMzJnaDY4eFlyQmYzL216bjg5VmU1YnpwM0pmNmg2WUgv?=
 =?gb2312?B?Y2RrOG4vQWJOSUtyVk9mbnNUa1BZSys1MEtpWjJlQWN4Unh6Vng3SGoyRnVF?=
 =?gb2312?B?a2JjY0Y1UGJBemRVQUVlV1FEdW5YVUc5YmtLeDZjK2ZZL01yd1FsYlZRZzRr?=
 =?gb2312?B?Wk5LMm1KUWpHQUszTHlVZHloRkFQeUNWcFY0a1Y4K3llNXoxRDloQkFKQnBW?=
 =?gb2312?B?MHVSQTVXaXBMVmIwYmN5bEFGV3lkZlMwUThzODQ1a2hyMURmS1laUDJHU2hS?=
 =?gb2312?B?YUFrZmJIYWYwMnhiTk83RDJodUFkY0ZIMHdRVENxOUVjUEw2MVNwdnJNYlBQ?=
 =?gb2312?B?WEZsVlZ1bHNTei9SenM2eGxreHNQaXJlR0hYRVRPZkhNVG9nZFZLM0RRVEpX?=
 =?gb2312?B?aFlMcEU4YzlKTTN4SUlPNE9nK2xaWlRtNnRnVUM3Ym9CbVY4b1JiMTlrNnBq?=
 =?gb2312?B?KzV5ZGpRWnNQQThCUWNDT05lVmVnY0ZLbFNwdWc4VkcwcE54cWFRVE0wTlZz?=
 =?gb2312?B?NkZNT1B0M3lFaWdxLzFHUWFNRnVZL2lhazdJNHZMVWhuK1EwbGh5WGJHN1Jp?=
 =?gb2312?Q?lTFqavaeCO3Nyz8Ca0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfef0425-4016-4e34-c031-08d8e52b8e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 07:50:50.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeVNF1TW5Q4F41oO6PCmtS+QbAPH6NuUStkvv/DNfNfafaDusotDUsygvHah55KFXcGq0YGpe4oEiHgh8pm08xALs3RnUYpkBZTkIenLXMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogRG1pdHJ5
IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPgq3osvNyrG85DogMjAyMcTqM9TCMTLI1SAxNDoz
MArK1bz+yMs6IFpoYW5nLCBRaWFuZwqzrcvNOiBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXg7IEFu
ZHJldyBNb3J0b247IExLTUw7IExpbnV4IEFSTTsgc3l6a2FsbGVyLWJ1Z3MK1vfM4jogUmU6IFtQ
QVRDSF0gQVJNOiBGaXggaW5jb3JyZWN0IHVzZSBvZiBzbXBfcHJvY2Vzc29yX2lkKCkgYnkgc3l6
Ym90IHJlcG9ydAoKW1BsZWFzZSBub3RlOiBUaGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFM
IGUtbWFpbCBhZGRyZXNzXQoKT24gRnJpLCBNYXIgMTIsIDIwMjEgYXQgNToxMyBBTSA8cWlhbmcu
emhhbmdAd2luZHJpdmVyLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBacWlhbmcgPHFpYW5nLnpoYW5n
QHdpbmRyaXZlci5jb20+Cj4KPiBCVUc6IHVzaW5nIHNtcF9wcm9jZXNzb3JfaWQoKSBpbiBwcmVl
bXB0aWJsZSBbMDAwMDAwMDBdIGNvZGU6Cj4gc3l6LWV4ZWN1dG9yLjAvMTU4NDEKPiBjYWxsZXIg
aXMgZGVidWdfc21wX3Byb2Nlc3Nvcl9pZCsweDIwLzB4MjQKPiBsaWIvc21wX3Byb2Nlc3Nvcl9p
ZC5jOjY0Cj4KPiBUaGUgc21wX3Byb2Nlc3Nvcl9pZCgpIGlzIHVzZWQgaW4gYSBjb2RlIHNlZ21l
bnQgd2hlbgo+IHByZWVtcHRpb24gaGFzIGJlZW4gZGlzYWJsZWQsIG90aGVyd2lzZSwgd2hlbiBw
cmVlbXB0aW9uCj4gaXMgZW5hYmxlZCB0aGlzIHBvaW50ZXIgaXMgdXN1YWxseSBubyBsb25nZXIg
dXNlZnVsCj4gc2luY2UgaXQgbWF5IG5vIGxvbmdlciBwb2ludCB0byBwZXIgY3B1IGRhdGEgb2Yg
dGhlCj4gY3VycmVudCBwcm9jZXNzb3IuCj4KPiBSZXBvcnRlZC1ieTogc3l6Ym90IDxzeXpib3Qr
YTdlZTQzZTU2NDIyM2YxOTVjODRAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbT4KPiBGaXhlczog
ZjVmZTEyYjFlYWVlICgiQVJNOiBzcGVjdHJlLXYyOiBoYXJkZW4gdXNlciBhYm9ydHMgaW4ga2Vy
bmVsIHNwYWNlIikKPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZl
ci5jb20+Cj4gLS0tCj4gIGFyY2gvYXJtL2luY2x1ZGUvYXNtL3N5c3RlbV9taXNjLmggfCAyICsr
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9pbmNsdWRlL2FzbS9zeXN0ZW1fbWlzYy5oIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vc3lz
dGVtX21pc2MuaAo+IGluZGV4IDY2ZjZhM2FlNjhkMi4uNjE5MTZkYzdkMzYxIDEwMDY0NAo+IC0t
LSBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL3N5c3RlbV9taXNjLmgKPiArKysgYi9hcmNoL2FybS9p
bmNsdWRlL2FzbS9zeXN0ZW1fbWlzYy5oCj4gQEAgLTIxLDggKzIxLDEwIEBAIHR5cGVkZWYgdm9p
ZCAoKmhhcmRlbl9icmFuY2hfcHJlZGljdG9yX2ZuX3QpKHZvaWQpOwo+ICBERUNMQVJFX1BFUl9D
UFUoaGFyZGVuX2JyYW5jaF9wcmVkaWN0b3JfZm5fdCwgaGFyZGVuX2JyYW5jaF9wcmVkaWN0b3Jf
Zm4pOwo+ICBzdGF0aWMgaW5saW5lIHZvaWQgaGFyZGVuX2JyYW5jaF9wcmVkaWN0b3Iodm9pZCkK
PiAgewo+ICsgICAgICAgcHJlZW1wdF9kaXNhYmxlKCk7Cj4gICAgICAgICBoYXJkZW5fYnJhbmNo
X3ByZWRpY3Rvcl9mbl90IGZuID0gcGVyX2NwdShoYXJkZW5fYnJhbmNoX3ByZWRpY3Rvcl9mbiwK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNtcF9w
cm9jZXNzb3JfaWQoKSk7Cj4gKyAgICAgICBwcmVlbXB0X2VuYWJsZSgpOwo+ICAgICAgICAgaWYg
KGZuKQo+ICAgICAgICAgICAgICAgICBmbigpOwo+ICB9Cgo+SGkgUWlhbmcsCj4KPklmIHRoZSBD
UFUgY2FuIGNoYW5nZSBoZXJlLCB3aGF0IGlmIGl0IGNoYW5nZXMgcmlnaHQgYWZ0ZXIgPnByZWVt
cHRfZW5hYmxlKCk/Cj5EaXNhYmxpbmcgcHJlZW1wdGlvbiBqdXN0IGFyb3VuZCByZWFkaW5nIHRo
ZSBjYWxsYmFjayBsb29rcyBsaWtlIGEKPm5vLW9wLiBTaG91bGRuJ3Qgd2UgZGlzYWJsZSBwcmVl
bXB0aW9uIGF0IGxlYXN0IGFyb3VuZCByZWFkaW5nIGFuZAo+Y2FsbGluZyB0aGUgY2FsbGJhY2s/
CgpIaSBkdnl1a292CgpPaCwgSSdtIGNvbmZ1c2VkLCB3ZSBzaG91bGQgY2FsbCBwcmVlbXB0X2Vu
YWJsZSBhZnRlciBjYWxsaW5nIGNhbGxiYWNrIGZ1bmN0aW9uLCB0byBtYWtlIHN1cmUgY2FsbGJh
Y2sgZnVuY3Rpb24gaXMgY2FsbGVkIG9uICBjdXJyZW50IHByb2Nlc3NvciAuIHRoYW5rICB5b3Ug
Zm9yIHlvdXIgcmVtaW5kLgoKPgo+T24gdGhlIHNlY29uZCBsb29rLCB0aGUgZm4gc2VlbXMgdG8g
YmUgY29uc3QgYWZ0ZXIgaW5pdCwgc28gbWF5YmUgd2UKPm5lZWQgdG8gdXNlIHJhd19zbXBfcHJv
Y2Vzc29yX2lkKCkgaW5zdGVhZCB3aXRoIGFuIGV4cGxhbmF0b3J5Cj5jb21tZW50PwoK
