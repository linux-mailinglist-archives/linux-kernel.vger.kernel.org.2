Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18D2354CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243996AbhDFG1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:27:06 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:26508 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238121AbhDFG1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:27:03 -0400
X-Greylist: delayed 1648 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 02:27:03 EDT
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1365xPjr029728;
        Tue, 6 Apr 2021 05:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=7iLMRaPk+dwpiiBfIYFy0Bs/my98riT/2MdjpCkq2Ss=;
 b=FgcQ9FOET0K+mkshUhFX3yWDDrCQejVsADrgqcDQ7rwYD4b4izmuqCP6c4Z2KUDAkG45
 Q33ENduzj+hWiFPyNTbUcySQr12Fa3Axx/GzlCKRzD3u0jRfqcTKOeHF+GhHeplnqsQ3
 V4WVb4BqSS3iGybY0P2rMcMFxdjMB5uZ6mO11MjLyQTZQ2C4dYfuwJ7KJ0uGuoxnOekC
 7J3x9BcrJ8aQUJfAT3VNkyNJFLnPia9Y7UeHI2VPLqPUaFvOWTkWj70Ymvx1dzZTIn2V
 n37Ac/rzph0g6BwUuxJvgZavbti6237dofRzNpZsoVO5FAIU4BvDEp+x6oy8j/zsjae7 xg== 
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50])
        by mx08-001d1705.pphosted.com with ESMTP id 37q2p19a0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 05:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etCcyK1f958d5hF/tp0hoe6kFuBX+Ble5xaC2PvxXzbT3il/u1OgUPRuaUyAyo/LFGpOs8yGz3OHA0/Gy1Qt19NFSWtQZYTpP4czRJQOnmi73zNEhnzjH4K9w1TqUus1P9J8DDA1hOCeI7YbGjlVBOC0YnqJY5BvuhncSeHGebqY7s8TR4CaqU2ac4meaYmX1RHHMnV4JX4Y6aYRNwyvXpgi2VJDPn499xDKZFDtGgPTu7ajwwo2oih7aQdaPQS5KJKw684OgCbEhPTUmll+kXpCsvCDKZsEBbtruix36KCifruCwj1iGLT0uf40W3T3ZEZaKGrBd0MuAWtn9Qj7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iLMRaPk+dwpiiBfIYFy0Bs/my98riT/2MdjpCkq2Ss=;
 b=bZvlF25D3L0eUMnb+uWZIeobVR/5C5LS26a1Iil+sE6rOOtq5kW9mVIRuEKRMIj1M6lly+9AZBT81zSrjaHvkOBtPpGlZ9gLlFS+bmUpaOF4YDimHc3L7cI23dMW5VUZLlZxCOvbkzfuT1G13qi4t3YD4vZky8xtpoqu5piuB6G0aKHXdE0O85PmikQgeFLkxEUsot56MeHfZEytf2UWCgcyEaR+HCx1zSDlVjM6dsIKC5hc+qlmhmZAQocScobJjl1IJkB4lXFHhddG5bZq+gLh6tmiVA1fqy/j/fdhiepEd4KKTIUFhOUq/NB6piAfgNdzaHwrGheM3MaOZZ1gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM0P193MB0626.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:14b::8)
 by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 05:59:06 +0000
Received: from AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
 ([fe80::e1e0:7364:3d3a:ea33]) by AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
 ([fe80::e1e0:7364:3d3a:ea33%7]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 05:59:06 +0000
From:   <Peter.Enderborg@sony.com>
To:     <keescook@chromium.org>, <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: Make debugfs_allow RO after init
Thread-Topic: [PATCH] debugfs: Make debugfs_allow RO after init
Thread-Index: AQHXKmRDdvDyavXQDEOPcJ2wtfSwN6qm/xgA
Date:   Tue, 6 Apr 2021 05:59:06 +0000
Message-ID: <88e49a04-cbd7-c9ee-fd4f-13d4dae8d5e2@sony.com>
References: <20210405213959.3079432-1-keescook@chromium.org>
In-Reply-To: <20210405213959.3079432-1-keescook@chromium.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d103951-baa7-4f7e-2a7a-08d8f8c1166e
x-ms-traffictypediagnostic: AM9P193MB1491:
x-microsoft-antispam-prvs: <AM9P193MB14915922229805FE70D4BE5E86769@AM9P193MB1491.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rq4f7L1o2MWRD+cSvoY+PaOSloPqMXN3PE12O+hvRPBrUVKpeKbzQbKHO4FJIT6UayJcJNE5YRMEropTGvTQVTctGKU1HfEL2RBGm1nyoxjVVfsRUhbMIkGWUE11UQ8mWvxwn+GrMIae0kPF2kMWFNXfcXjcafPtEx0fL6IyH6YB9cAAjx82Usq78/k+kLSa6vADRRCAm5OQH78ERur8m/Xi072KKG7s3OHCESPpsTpCIMqgWn4v0XCUz5HZpXio9xCy8ZP2Ig1x6u+3HPpri8MYWL5QTdG/rM1pMaaLebUrbG5wQPx3bsw7+g7m6pWSGoAJ7CsVrKoQuVX0+udXD7VCpt0YmfoRy7YIJy+bWpMylboBjBMI8Pr+yAQxpJKUSy1e2zRIIXSC1R0SZHrLPKKPFfTyPULPKbvIsGBQ5k7wxtGsd8KQJkdvYYuJ9bZqcjFb28KGBNP3fIexGHnFO5J5Axg8CLaVRRQWMBy5In61vCHHR6cn4ZaCK2MANp9UBY7yOY11NBkxQ5LIn1ELz5vfaL94Rdj8njQU1ESl8p0yh7PWfEn/mOuxn7Hq4bL1sflHVfAeAtJGUeJqnc7U/JNpclIH5uZm9RAInZVhr7rPFOYcngg1Hf/bQgz+rWnr8J2zaPw0diIgKSgfGHS/Dn0IsbA8yxmhCJJGXvpY3G0WzFwPUYnjHXAKfLsJiwyVaoSvJ9prypNDZdZ8mVppOFlkxwumwaEv5g4CTo+Zulo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0626.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(396003)(376002)(136003)(66556008)(66476007)(38100700001)(66446008)(64756008)(76116006)(6512007)(66946007)(2906002)(83380400001)(6486002)(2616005)(8676002)(54906003)(36756003)(6506007)(26005)(4744005)(53546011)(71200400001)(86362001)(4326008)(31686004)(91956017)(5660300002)(316002)(110136005)(8936002)(186003)(31696002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?czdBaFN4QWJCMEIzMFY2LzFYSDF2MTRhZTE1T25YdzBhVWNreE9xUjVYMWhj?=
 =?utf-8?B?ckxNOTJoVU5nem8vNUx4Z0J4a2thbHV5WmpBa3JlSm9HN2UzK2l4ZXF4a0hK?=
 =?utf-8?B?TFhKTmwrNmdJODE1b0k1M0t6SEJ4YzRYMEZBcDJ1TzJGNTFlcVdJcnFrQm1G?=
 =?utf-8?B?TlFIdWtIamJydFZzcmpuNmVKMVlMcGQzei81OGo5U1dTbmwzZDZXQXZ0NVZH?=
 =?utf-8?B?RklrekxhV3NCem9QMllycWhucmxyVHFyWlBXMG1RQ0U5REkrL2tBYmNudGFM?=
 =?utf-8?B?dTlhSlI0SFBIdno5R2xQYjk4OGgvTXZ6aUlwNXpYVHpYR1lXaWdUUmsvckN1?=
 =?utf-8?B?Y1p1NXBCaFJCSENNNC9ib3RBTTBkZ2Q3MnRvQXgvQUFlTmFZT25iU2orT1Zp?=
 =?utf-8?B?NTI4ZWkzM0c1SjJZZmRPQlAvbFlUV2ZUaVlWL0Zqa3oyUmpqYm8wbVhyMnlp?=
 =?utf-8?B?bGI1TWw0Qjd4SWhiOEt6M2RLM0dhT2Q5Q3QvR0xSbFkyOUt6b09jQTFYL2Er?=
 =?utf-8?B?d1lNR0Jlc2lsdE9WZndNK1BGKy9xNCtsVnZOS2FwTTlDK2tidllURm1vbGVY?=
 =?utf-8?B?djhteDhRZCtieWZucnk3ZXZrZ0YyV3lhVnZtNllPY0plQlhHQWNXYXg1L2JX?=
 =?utf-8?B?N0tvTVFCRHdEN0lLeGlWbmwxNDBFaC9EcTZFNWhyUjRRUjhjTjRzNStkMTF6?=
 =?utf-8?B?cnd5eFBwT1JKT2xwdkdrSDhPMGNjOGlpTVhhWFZINVlMSngwaUpybW01NkVS?=
 =?utf-8?B?SnJBekQrOFZUWWNmRmdkd0tMR3NHM2NRcnhJeEgyV3lmTzNSZHgxUlIrOVdr?=
 =?utf-8?B?WXNpSHNuRHRDajhLLytyVllaUS9GWGIvaGltL3FlZDgyeVZCcmNCTFl0ejBn?=
 =?utf-8?B?T2ZxVzdyMnJ5NWdNYXNLOXZ1U2cxRGszaXNrTzBQR241eDVVL0YxR2dwWE9Q?=
 =?utf-8?B?NjZRK2FMZW1vT3R2ZmR5SEZUNmRmNks4c0pXYTk1c3h2aDRYVGFCQytYUVJT?=
 =?utf-8?B?a2JoVzJxazA5MmVjWTlRenMzQnlrdUpZQUM2b2J6VFQ0aEx2WThFNE1yc1dH?=
 =?utf-8?B?OGhiWVNYTDQvSnZ1SjM4bW0zcXYxUHNFb0J5QlpLSnIzdERrUjBKa2RpeXor?=
 =?utf-8?B?ZDN0dEVPNE0zQ00vb1Q1NmVoOHdWMis5Znc5R0dGSHhhUktFNzJOQ0haYk9x?=
 =?utf-8?B?TFBiMnlkUDJrcjVQMmVOVHhsY21oUGRSNFVJZXlOTFpMSmxtOGVQNVdkQStw?=
 =?utf-8?B?Z0Z4UXpVZ2RHSExkeDkrR3lieW4rc0tsMmhpQUhpMU5POWUxNk5YR3h3Slhr?=
 =?utf-8?B?ZmV6eVpYTkR5V2JwMnlnZWNIaldyb0ZwNEdmNzNiR0RmZHNjQUpuUUZ5bGJt?=
 =?utf-8?B?YVVabXk0dDZ4ZUY2Si9idUdyamovbFh1d3M1MWI0YVlBMlByZStrNG81amdM?=
 =?utf-8?B?MVB6QmhjbEhPb1hYSElVNUlIUmdmK2QzUUlsL09DbEpra21SUXhzT2NXek9n?=
 =?utf-8?B?Qms4azIyYTdpUloyRnllMVpOM1FqNnJOMEVQaXJqN0xNUzhyWmJ1NUgwOWhn?=
 =?utf-8?B?NUx1TGs4Y2hCbnU3SlJJdGhvNTZzRkFBdzJ2YUlualRRVjA4djJ2aDU4UURh?=
 =?utf-8?B?QS9wMXk3LzlYMTUxYVZQVHVkRXVlcjl4T0JuZndWdGRZTFNSNXIzamFtMUo1?=
 =?utf-8?B?WVpTV093cjZoSXZyVzk4RHN3NXlEZzNrUlpSbkc2c05RL2pmK2x0clkzaXNs?=
 =?utf-8?Q?f/hurpOZnz+VTjdJbEms1ylGkiiEY/HZACoutax?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <752432B5D9D64A4398553FA7F282CD01@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d103951-baa7-4f7e-2a7a-08d8f8c1166e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 05:59:06.0863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29fjebG0Kb5TrCxaKXvV1CFeQGjBq1R8DELg3xyZIrZjl8datRcnV9GrdOGZMguDMqnhXvAJUjm539yz8Szl5HGoTg1X7K3lTIkt/hjb058=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1491
X-Proofpoint-GUID: aH_4gp6iD17sp2GpFBjtKvFJ9fpzc2mG
X-Proofpoint-ORIG-GUID: aH_4gp6iD17sp2GpFBjtKvFJ9fpzc2mG
X-Sony-Outbound-GUID: aH_4gp6iD17sp2GpFBjtKvFJ9fpzc2mG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_01:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC81LzIxIDExOjM5IFBNLCBLZWVzIENvb2sgd3JvdGU6DQo+IFNpbmNlIGRlYnVnZnNfYWxs
b3cgaXMgb25seSBzZXQgYXQgYm9vdCB0aW1lIGR1cmluZyBfX2luaXQsIG1ha2UgaXQNCj4gcmVh
ZC1vbmx5IGFmdGVyIGJlaW5nIHNldC4NCj4NCj4gQ2M6IFBldGVyIEVuZGVyYm9yZyA8cGV0ZXIu
ZW5kZXJib3JnQHNvbnkuY29tPg0KPiBGaXhlczogYTI0YzZmN2JjOTIzICgiZGVidWdmczogQWRk
IGFjY2VzcyByZXN0cmljdGlvbiBvcHRpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBLZWVzIENvb2sg
PGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+ICBmcy9kZWJ1Z2ZzL2lub2RlLmMgfCAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2ZzL2RlYnVnZnMvaW5vZGUuYyBiL2ZzL2RlYnVnZnMvaW5vZGUuYw0K
PiBpbmRleCAyMmU4NmFlNGRkNWEuLjFkMjUyMTY0ZDk3YiAxMDA2NDQNCj4gLS0tIGEvZnMvZGVi
dWdmcy9pbm9kZS5jDQo+ICsrKyBiL2ZzL2RlYnVnZnMvaW5vZGUuYw0KPiBAQCAtMzUsNyArMzUs
NyBAQA0KPiAgc3RhdGljIHN0cnVjdCB2ZnNtb3VudCAqZGVidWdmc19tb3VudDsNCj4gIHN0YXRp
YyBpbnQgZGVidWdmc19tb3VudF9jb3VudDsNCj4gIHN0YXRpYyBib29sIGRlYnVnZnNfcmVnaXN0
ZXJlZDsNCj4gLXN0YXRpYyB1bnNpZ25lZCBpbnQgZGVidWdmc19hbGxvdyA9IERFRkFVTFRfREVC
VUdGU19BTExPV19CSVRTOw0KPiArc3RhdGljIHVuc2lnbmVkIGludCBkZWJ1Z2ZzX2FsbG93IF9f
cm9fYWZ0ZXJfaW5pdCA9IERFRkFVTFRfREVCVUdGU19BTExPV19CSVRTOw0KPiAgDQo+ICAvKg0K
PiAgICogRG9uJ3QgYWxsb3cgYWNjZXNzIGF0dHJpYnV0ZXMgdG8gYmUgY2hhbmdlZCB3aGlsc3Qg
dGhlIGtlcm5lbCBpcyBsb2NrZWQgZG93bg0KDQpUbnguIExvb2tzIGdvb2QgdG8gbWUuDQoNCllv
dSBjYW4gYWRkOg0KDQpSZXZpZXdlZC1ieTogUGV0ZXIgRW5kZXJib3JnIDxwZXRlci5lbmRlcmJv
cmdAc29ueS5jb20+DQoNCg==
