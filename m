Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8D1446A77
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 22:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhKEVSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:18:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39140 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231461AbhKEVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:18:51 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A5LDX34011763
        for <linux-kernel@vger.kernel.org>; Fri, 5 Nov 2021 14:16:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=359th4BlrJfsiuSnVbB88L8p0va+v3SqxDl2eas2ykQ=;
 b=Lk3VZqqKZAJ15pRrYZ+rVczWFUpnDrO/ln4Gdj+aanDGBmeG6zYyjw4nTwu9sBn8fM+R
 ugwGgvGPq9uaWX72U1j5wecQgs1QNpE0wGiyIDZui3JN5BUMJ4HEPUzUbDJKGJpuFMHK
 5MGM+lXTiMbtUJxAQEQregfmlYcnjRnSoLM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c4t7q83y4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 14:16:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 5 Nov 2021 14:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/Svxk5hEKyOmS3EbbF9z2BXCbjBZCkfN3Ka0uvX5PnYEiNv/84Ck7TQisBT6umsNHIQNbMauaMAzkyXrYZmNTXr6GLRrwO/r9Cdo9FdchiNaN0a9KtMWJjMDSo/4y1zksyIdC/lYXqvfMx8aO5vI6A0XCCcCg8WLmSxU0v+6tgVW3Zklrn/b7V6qDGmyQljhKLxTyTns0U7qP+anBAV7eTHlVEbZG+bZZ3EqhzRdbGnXLINBX/ejJM5wTQzynFue5NG87P5bENO9kyIDCcimdSsef+CMB5N9FQRojwOAXbKbiKUixc7VC4jVymmjeW085NN2/0zeSAWW4MiSPsgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=359th4BlrJfsiuSnVbB88L8p0va+v3SqxDl2eas2ykQ=;
 b=JHKlmQU/F3QAtGq0UrIFtK7JL2+4cxt8FboIlI522oSIMGqlZIpsXyNcMOItThY8ee5V7b1teeePu7NUBLku7Aznaeki0MSjYZ/z38hdLNbl2ccjfqkgnFCjndCXOXIcm09jxmTtKa0QOFAZWIkZaOvWq/I9tegtH1aWLE2zni3IxSdbuRjdmyOGl/p7AlIwvCXIHUuZOHG9jxccQxxdGXSbAOgTOeZXsXrSkDMuNeOmzm/dyo+s1x4fkINDjimdHuqtk0YDG2AtH0IsmjFb5zJfRagGDK06d8gwG9qWVrw87zpE/GcRg79ZWDSx1bsS4T2lkkJ4JvRhuThj7Be/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2407.namprd15.prod.outlook.com (2603:10b6:a02:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 21:16:08 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 21:16:08 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] lib: zstd: Add cast to silence clang's
 -Wbitwise-instead-of-logical
Thread-Topic: [PATCH] lib: zstd: Add cast to silence clang's
 -Wbitwise-instead-of-logical
Thread-Index: AQHXxrmhV8EJKX2UAE+nrwZQNmVvMavkgQmAgACZsECAADwbgIAAdfmAgA+6cYA=
Date:   Fri, 5 Nov 2021 21:16:07 +0000
Message-ID: <F7676163-1EEA-4A7E-A0F7-475411ECD7A8@fb.com>
References: <20211021202353.2356400-1-nathan@kernel.org>
 <4245BD7A-4B12-4172-B4EE-76A99C717C7D@fb.com>
 <d21e97487ba3447194538ccf0e88ead9@AcuMS.aculab.com>
 <YXgKgQMHQzvQgE4J@archlinux-ax161>
 <2c664a6701b44050a0525b541292ce21@AcuMS.aculab.com>
In-Reply-To: <2c664a6701b44050a0525b541292ce21@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da6ecb2a-989a-489d-d0e8-08d9a0a17c01
x-ms-traffictypediagnostic: BYAPR15MB2407:
x-microsoft-antispam-prvs: <BYAPR15MB2407A93A822986C910721C4BAB8E9@BYAPR15MB2407.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ypwqIXuNBtN0Z9nBmR98idHFUGfCS7EVHFi46QlQhxUNGfiGcrvgjD/Wp7PtMZ3F6+pqEyVSPtbp6Kl6UbBLaXfR4RPmwKBWh0SsbhXLwutUvTIOQJyqaiSnMT+eSU+OL+dxsjOXFpGZd1rGqUWb+JnlTxZ8yJJ7ZyjuJ8J2puXyuF040kfMxaQOsLT0edc/DRVLGLM+6QFYF3MJTmilcVyM+PyLbdf1K/JmH8gFwZHBZ9Kbrd/z8kTuUY1Y4quAQutSVtAnyrGMGns4PQPlqfLUo+G1f3Q9iLbHrdew2CPWf9cfQK9PkLsSSn73LTnhf/cu9/ESOktlFo82SPKZ8qkNwmhQISKmb6tx8TXMbb3vTBjTIm7SQH6aXIPOAGb3yul9Jt+wfLHvlbP8BtrWxDggAiPTvK1SFZa8lL36jvkmqABJhTGmW73t0emq1ck5wOT6OeQfhOg3aoZg6VQTxfmxV1fw6vk0ITRVw6o6IAXsUwj1B7ccpuOKLZtVKR/za3FN/Lmf3BNThcFapXFDOCVPaf7jpGOOEWaYtkc7PkB47WYEjrxIBB+T5W0qoT6g1kAMrDt96jVtR9Zg2kumhE1lY6DZkFbCDxkpdIUXnCyHl+sB8c1toMTsmVw/G5peBIYBRJsYfcHgwpZrsvoL9yq+KcU7H47ZDw8kb4ewW/E4Se2NnE3OSD2vj4WIdticko6kfNEOOZuUD9SiFjAXBGh1X8w6jBzaokyLKuwMzPvCJ6QRvjP6nSjlat4HjsLD446cknekq6FiCuHBi4XGsyJRKipsnP048+hBTTwTzsEhnXzo3hTbBbWsr83RR4xsPAlDnAljpxUmJtyKOJIhsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(64756008)(6506007)(33656002)(66946007)(508600001)(53546011)(66556008)(71200400001)(5660300002)(966005)(4326008)(36756003)(83380400001)(76116006)(6916009)(91956017)(66476007)(6512007)(86362001)(38070700005)(2906002)(8676002)(122000001)(54906003)(2616005)(6486002)(316002)(186003)(8936002)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzBhNW5UQ01aNkEydldOajRZc0Q0SzN1aGJJSk9LemZtVTJjVzMvR2F4bHBn?=
 =?utf-8?B?MHpqaHViNjhFNlJQMk5uaUpSTEdjZ1BpRnNZN3lrVDQ0UkpFYnc2WEQ3bjVO?=
 =?utf-8?B?OUl6Rk0xSVhJZWVHcjZrUUxCR1dRMi9udEJ2SENhemY4VDUyMHdHVUNKWlA5?=
 =?utf-8?B?d3EwdnlFY0lETTdaZk11bHZTNTlkdm95anBGWWRLb0tibGZGV2wwN0xGZldq?=
 =?utf-8?B?ZU9Pa0RaWG9RcVBHMHRza2hZNjlSRTZYa01DcjVkZXRsUm9UME1sdmZTTXhM?=
 =?utf-8?B?V3l3eXJOZnU1UE1LdEMvd1VTeHU4Nyt2aHAzZDJPeC9ka240K0ZMTnJ3d1Zi?=
 =?utf-8?B?dXVkTzZBZzlEbFJsS3dZenFTVjN1b09rVm9zZmxyamg3eFFyNDkvbEU1THZq?=
 =?utf-8?B?MUJCb3JPUC8vRnJRY1JERUh5ZHdRZS9KNzRieWxhZzFSdEd1TVJTeFVoS0Mw?=
 =?utf-8?B?bTYzYlVXRFRCc1NoSFd1Y0NIWkFXZnhJdVlrOGlTUlFoTGRUdlRwbFgvME5p?=
 =?utf-8?B?QW1pTWNNRVIxMjAxamRzVUE1SUk2MC96eUY2b25iMU1JZ2lmazZNdjN0WEpD?=
 =?utf-8?B?TmFvbElJb3Z2TGJSUUxjSUlZR1IzVjlLaHptUkNHQWNnRVFER0d6RnBPMzRr?=
 =?utf-8?B?ZEtUdTRQL3FuMjZudmpQRHI0b0hkSXJqOFlXMDhzY2tCRXpDUUxCanZyTXdK?=
 =?utf-8?B?eUhIM2tsWUF6Ri95YlUvRWR3bFQvMDQyMkdQSjY3YlMyVkJiSnlCZzNXSlJE?=
 =?utf-8?B?bVJtUnlod3hZYmhxbWJWN084ZDZheTYzSXZ4bWs5VFcreDdaM3c5b2lIVU9w?=
 =?utf-8?B?ZmNuSkROYTBZbTdyMnBCYWlWSzZOdTlvUTlzdTdoYUx6QWNWd29XOG1wMEs1?=
 =?utf-8?B?enkvWDFhWXp4UkZMdjNtS1hWeStSWHY0SU15dmVvb1R6eXNpdGpiVlpnakhu?=
 =?utf-8?B?K3FZQnd4a2xqck1qZXBnZHJmTVlPVnpScTZMZ25WTjBXakttSndsS3RCU1lM?=
 =?utf-8?B?R1NxU1BUME0wV1JRMXVtSXFZblcya1ZUUCs1a000V21KdjBZSFhadVFRYTVu?=
 =?utf-8?B?MXp6U3Yrc0VVcmJlTGY2Q2RPRkw4WTVIM1BWOHpsSGg4NFN3TkFJaFJwMEE4?=
 =?utf-8?B?VWNTQTUzSk1VbUttQ2ZDQ052QlEzbWt1dUFidFZMY1BQaEF5cHBGRU5WREd4?=
 =?utf-8?B?REJYRUcxU2k4eWJxR29ST2tpYmxDOGNWMnNxVnBwTlQrNmQrVjlyS2w1N3NT?=
 =?utf-8?B?SkptelI4em5LTmVWWi9GT3NwWHJQeUR3aGJtMW9sejE2RWxqNUVCQkhxS1Fa?=
 =?utf-8?B?QnVzZ0JMQUg1VFNkZndPenpiV0c3OFhSUWpadEZrdlhQT1YzNXpHVFEreEp0?=
 =?utf-8?B?V2libVZrMU1kY3BuT3lwODl5WjdoaFk3RWJSUVZLa1pjVnVtRlJKNENlOU1w?=
 =?utf-8?B?K3pvRDU2cTZoTEY3eDVtTXZqbjI5TTB3TTMrUlJncnJFbjJmd2tkRHpwdnF3?=
 =?utf-8?B?dEM2amJ1bnVxZDRad1FtL09EamJUZm9mWUhNS2w0UGtSK0xNZ3J0WDhwK0Rx?=
 =?utf-8?B?R2JlWGdJMGcxTDV3bVdDU2x2WkpSd2RVVk9YYzZXaU5rTEtNU2h2T3ovOVR1?=
 =?utf-8?B?UVZmRyt1aFF3THZBUGVXS0dNbmRUaTNUbGpPNEwwTkxYNnFOOGhqOVBuc05u?=
 =?utf-8?B?V1RWSnNmM3k5TS9LYWdMcWtud3VubUJDTDNZc0Rac1owZkVlcDdaejR1QnU4?=
 =?utf-8?B?MHJhdFNVWHd2d215Tk5ZZ3ZDZ3dkbkFLd3NkOHV1eW5FS2JHbnYxSVRiUUFP?=
 =?utf-8?B?aWxmcTlodFIvZXFQYXVRL0psSU0vZDI0UDQxY3pIR1lGYXlaSUl6NGNPNHc5?=
 =?utf-8?B?OVFxeUQ2bGFHSnR3ZDQ2WEtyZmpGcnpyY3B5bktoMTlUVVErR3FxZTJuaHF1?=
 =?utf-8?B?Ung4bTFZbk01MWhTWGtDSFZaUnhpWlFmblNaMGZUbElTYXJUdFp0Z0p4TUZv?=
 =?utf-8?B?dHArOFJ3cy95VEtxb1dCZFczYnhUeGNjeG9UR3FMbDFDcGFlUThqakJCdXoy?=
 =?utf-8?B?UDQ5NDNPU0Y3YlNZdklIQ2wyaE1Sb0RXZ1p2VzNTSk1zbGU5N2RVZkRUUFRo?=
 =?utf-8?B?S2ZBUUV3VkE3WVR0NnJwbjVVdnVaYkZzYnZqL3QrVE42cjZsSEo2VENzanNM?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F263C41BEA3B66458344F1E0BC326AB6@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6ecb2a-989a-489d-d0e8-08d9a0a17c01
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 21:16:07.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yrEuS2VRQaP94OaltUBBhssZUxP/XCyoe+tzoPgvLZTjORyEUSrm0KK3Fek28ic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2407
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: EuoC_8r_ATou3xKYRjid959cDnlq7cqa
X-Proofpoint-GUID: EuoC_8r_ATou3xKYRjid959cDnlq7cqa
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDI2LCAyMDIxLCBhdCAyOjA0IFBNLCBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBBQ1VMQUIuQ09NPiB3cm90ZToNCj4gDQo+IEZyb206IE5hdGhhbiBDaGFuY2VsbG9yDQo+
PiBTZW50OiAyNiBPY3RvYmVyIDIwMjEgMTU6MDMNCj4gLi4uDQo+Pj4gSXNuJ3QgZW5hYmxpbmcg
dGhhdCB3YXJuaW5nIGNvbXBsZXRlbHkgc3R1cGlkPw0KPj4+IFRoZSBjYXN0cyByZXF1aXJlZCB0
byBzaWxlbmNlIGl0IGNvdWxkIGVhc2lseSBjYXVzZSBtb3JlIHByb2JsZW1zDQo+Pj4gLSBieSBo
aWRpbmcgbW9yZSBpbXBvcnRhbnQgYnVncy4gQW5kIHNlcmlvdXNseSBhZmZlY3QgY29kZSByZWFk
YWJpbGl0eS4NCj4+IA0KPj4gV2hpY2ggd2FybmluZz8NCj4+IA0KPj4gLVdiaXR3aXNlLWluc3Rl
YWQtb2YtbG9naWNhbCBpcyBpbmNsdWRlZCBpbiBjbGFuZydzIC1XYWxsIGFuZCBJIGRvIG5vdA0K
Pj4gdGhpbmsgaXQgc2hvdWxkIGJlIGRpc2FibGVkOyB0aGlzIGlzIHRoZSBmaXJzdCBpbnN0YW5j
ZSBvZiB0aGUgd2FybmluZw0KPj4gdGhhdCBoYXMgYmVlbiBzaWxlbmNlZCB3aXRoIGEgY2FzdC4N
Cj4gDQo+IEknbSBub3Qgc3VyZSBhYm91dCB0aGF0IG9uZS4NCj4gSSBoYXZlIGEgZmVlbGluZyBp
dCB3aWxsIGdlbmVyYXRlIGZhbHNlIHBvc2l0aXZlcyBmb3IgY2FyZWZ1bGx5IG9wdGltaXNlZA0K
PiBjb2RlIG1vcmUgb2Z0ZW4gdGhhdCBpdCBmaW5kcyBhbnl0aGluZyB3aGVyZSAnc2hvcnQgY2ly
Y3VpdGluZycgd2lsbA0KPiBiZSBhIHJlYWwgZ2Fpbi4NCj4gRXNwZWNpYWxseSBmb3IgdmFsdWVz
IHdpdGggYXJlIGtub3duIHRvIGJlIGVpdGhlciAwIG9yIDEuDQo+IA0KPj4gLVdzaG9ydGVuLTY0
LXRvLTMyIHdpbGwgbmV2ZXIgYmUgZW5hYmxlZCBmb3IgTGludXggYnV0IHpzdGQgaXMgYQ0KPj4g
c2VwYXJhdGUgcHJvamVjdCB0aGF0IGNhbiBiZSBidWlsdCBmb3IgYSB2YXJpZXR5IG9mIG9wZXJh
dGluZyBzeXN0ZW1zIHNvDQo+PiB0aGF0IGhhcyB0byBiZSBjb25zaWRlcmVkIHdoZW4gZGV2ZWxv
cGluZyBjaGFuZ2VzIGZvciB0aGUga2VybmVsIGJlY2F1c2UNCj4+IHRoZSBrZXJuZWwgY2hhbmdl
cyBuZWVkIHRvIGdvIHVwc3RyZWFtIGV2ZW50dWFsbHkgaWYgdGhleSB0b3VjaCBjb3JlDQo+PiB6
c3RkIGNvZGUsIG90aGVyd2lzZSB0aGV5IHdpbGwganVzdCBnZXQgYmxvd24gYXdheSBvbiB0aGUg
bmV4dCBpbXBvcnQuDQo+PiBTcGVjaWZpY2FsbHksIHRoaXMgd2FybmluZyB3YXMgZW5hYmxlZCBv
biBpT1M6DQo+PiBodHRwczovL2dpdGh1Yi5jb20vZmFjZWJvb2svenN0ZC9wdWxsLzIwNjINCj4g
DQo+IFRoYXQgb25lLi4uDQo+IElmIHlvdSBhcmUgZ29pbmcgdG8gZW5hYmxlIGl0LCB0aGVuIHlv
dSBuZWVkIGEgc3RhdGljIGlubGluZSBmdW5jdGlvbg0KPiB0byBjb252ZXJ0IHU2NCB0byB1MzIs
IG5vdCBhIEMgY2FzdC4NCj4gDQo+IEknbSBzdXJlIHRoYXQgaXQgd29uJ3QgYmUgbG9uZyBiZWZv
cmUgdGhlIGNvbXBpbGVyIHdyaXRlcyBzdGFydCBhbg0KPiAnb3BlbiBzZWFzb24nIG9uIGNhc3Rz
Lg0KPiBUaGV5IHJlYWxseSBhcmUgbW9yZSBkYW5nZXJvdXMgdGhhbiB0aGUgd2FybmluZ3MgdGhl
eSBhcmUgdHJ5aW5nIHRvIHJlbW92ZS4NCj4gDQo+Pj4gLi4uYw0KPj4+Pj4gaW5kZXggMDU1NzBl
ZDVmOGJlLi41MTA1ZTU5YWMwNGEgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9saWIvenN0ZC9kZWNvbXBy
ZXNzL2h1Zl9kZWNvbXByZXNzLmMNCj4+Pj4+ICsrKyBiL2xpYi96c3RkL2RlY29tcHJlc3MvaHVm
X2RlY29tcHJlc3MuYw0KPj4+Pj4gQEAgLTg4Niw3ICs4ODYsNyBAQCBIVUZfZGVjb21wcmVzczRY
Ml91c2luZ0RUYWJsZV9pbnRlcm5hbF9ib2R5KA0KPj4+Pj4gICAgICAgICAgICBIVUZfREVDT0RF
X1NZTUJPTFgyXzAob3AyLCAmYml0RDIpOw0KPj4+Pj4gICAgICAgICAgICBIVUZfREVDT0RFX1NZ
TUJPTFgyXzAob3AzLCAmYml0RDMpOw0KPj4+Pj4gICAgICAgICAgICBIVUZfREVDT0RFX1NZTUJP
TFgyXzAob3A0LCAmYml0RDQpOw0KPj4+Pj4gLSAgICAgICAgICAgIGVuZFNpZ25hbCA9IChVMzIp
TElLRUxZKA0KPj4+Pj4gKyAgICAgICAgICAgIGVuZFNpZ25hbCA9IChVMzIpTElLRUxZKChVMzIp
DQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgIChCSVRfcmVsb2FkRFN0cmVhbUZhc3QoJmJp
dEQxKSA9PSBCSVRfRFN0cmVhbV91bmZpbmlzaGVkKQ0KPj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgJiAoQklUX3JlbG9hZERTdHJlYW1GYXN0KCZiaXREMikgPT0gQklUX0RTdHJlYW1fdW5maW5p
c2hlZCkNCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICYgKEJJVF9yZWxvYWREU3RyZWFtRmFz
dCgmYml0RDMpID09IEJJVF9EU3RyZWFtX3VuZmluaXNoZWQpDQo+Pj4gDQo+Pj4gSXNuJ3QgdGhh
dCB0aGUgc2FtZSBhczoNCj4+PiAJKChCSVRfcmVsb2FkKCkgJiBCSVRfcmVsb2FkKCkgJiBCSVRf
cmVsb2FkKCkpID09IEJJVF9EU3RyZWFtX3VuZmluaXNoZWQpDQo+Pj4gd2hpY2ggd2lsbCBnZW5l
cmF0ZSBtdWNoIGJldHRlciBjb2RlLg0KPj4+IEVzcGVjaWFsbHkgb24gY3B1IHdpdGhvdXQgJ3Nl
dGVxJyBpbnN0cnVjdGlvbnMuDQo+PiANCj4+IEkgZG9uJ3QgdGhpbmsgc28uIEZlZWwgZnJlZSB0
byBkb3VibGUgY2hlY2sgbXkgbWF0aC4NCj4+IA0KPj4gQklUX3JlbG9hZERTdHJlYW1GYXN0KCkg
Y2FuIHJldHVybiBlaXRoZXIgQklUX0RTdHJlYW1fdW5maW5pc2hlZCAoMCkgb3INCj4+IEJJVF9E
U3RyZWFtX292ZXJmbG93ICgzKS4uLi4NCj4gDQo+IEFoLCBJJ2QgYXNzdW1lZCB0aGF0IEJJVF9E
U3RyZWFtX3VuZmluaXNoZWQgd2FzIG5vbi16ZXJvLg0KPiBTbyB5b3UgYWN0dWFsbHkgd2FudDoN
Cj4gCWVuZFNpZ25hbCA9ICEoQklUKCkgfCBCSVQoKSB8IEJJVCgpKTsNCj4gDQo+IEp1c3Qga2ls
bCB0aGUgQ2FNZUxzIGFuZCB1bm5lY2Vzc2FyeSBjb25zdGFudHMuDQo+IFRoZW4gdGhlIGNvZGUg
YmVjb21lcyBzdWNjaW50LCBlYXNpZXIgdG8gcmVhZC9jaGVjayBldGMuDQoNCmBCSVRfcmVsb2Fk
RFN0cmVhbUZhc3QoKWAgaGFzIGEgbGlrZWx5IGJyYW5jaCB3aGljaCByZXR1cm5zIGBCSVRfRFN0
cmVhbV91bmZpbmlzaGVkYC4NClRoaXMgY29uc3RydWN0aW9uIGlzIHRlbGxpbmcgdGhlIGNvbXBp
bGVyIHRoYXQgaXQgaXMgYWxsb3dlZCB0byByZS1vcmRlciBlYWNoIGNhbGwgYW5kIGNvbGxlY3QN
CnRoZSByZXN1bHRzLiBJIGRvbuKAmXQgZXhwZWN0IHRoYXQgaXQgd2lsbCB0cmFuc2xhdGUgZGly
ZWN0bHkgdG8gYSBzZXQgb2YgYW5kIGluc3RydWN0aW9ucywgdGhvdWdoDQpJ4oCZZCBoYXZlIHRv
IGRvdWJsZSBjaGVjayB0aGUgYXNzZW1ibHkgdG8gYmUgc3VyZS4NCg0KSWYgeW91IGZlZWwgdGhl
IGNvZGUgY291bGQgYmUgY2xlYXJlciwgeW914oCZcmUgd2VsY29tZSB0byBzdWJtaXQgYSBQUiB1
cHN0cmVhbSEgSG93ZXZlciwNCnNpbmNlIGlzIGEgaG90IGxvb3AsIHdlIGdlbmVyYWxseSBmYXZv
ciBwZXJmb3JtYW5jZSBvdmVyIGNsYXJpdHkgdG8gc29tZSBleHRlbnQsIHNvIGl0IHdpbGwNCmhh
dmUgdG8gYmUgYSBwZXJmIG5ldXRyYWwgcmVmYWN0b3JpbmcuDQoNCkJlc3QsDQpOaWNrIFRlcnJl
bGwNCg0KPiAJRGF2aWQNCj4gDQo+IC0NCj4gUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQo+IFJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo+IA0KDQo=
