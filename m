Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1444337069F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhEAJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 05:32:35 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:22838 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231882AbhEAJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 05:32:34 -0400
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1419Ucg0028397;
        Sat, 1 May 2021 09:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=yH1k2ppXtp2yQpMa3umQZbpoJAqksWO0lAKqvVY35Q4=;
 b=OCEEbZGi4rYdC1BAYbU86wWPbXim7BqaBkK3DY3h4dxC/DyP3KqUewCyk8VcVHg1f/K+
 yi5VMu1Lrp9kgXurd/in80tu/UfeUJOUpnJPRTEp66Qb6RJfJvcuQvQTd3e3i8sP2IA7
 sJXQZhD+sg6W9lCl3P1gVbz0Td9io7q+n4xbGa1kwCTINH65naH+NTZxSuEAS/Hd8wp3
 O9902xFD4WNNEb5jTFoNxBwhwGdDD7QQaXy+xzF+YyKmT1/eNQXc89IM076EGxqigV6Y
 +53RavRsNZMo3Pi5gQJdX2RUogWULSOKXwiSVoJKQp8roQIrA/e7dZ5po2cm9SUfAJ1G vg== 
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58])
        by mx08-001d1705.pphosted.com with ESMTP id 388v8204xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 May 2021 09:30:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHuAanzi90uwqWZcHrJucUkF56YxB/I8xcJzAnriojha7+/4eRc5i5Xu+DDE6b9IQ43aTD0czORoTsi6ncUPrB3Wuc0zndaGULBHASudCwF+MzY9mefNJWzBrufgsm0Umij72Jy5INnlrAG2fINHhWquTwA5urO3vtOi3MxGga8bn14Tq3dQGOkUYDspcQZ71eCq0hwKZobMJH+butoWz2IaDaj5wC/NUInnqQT+MXJHn4sHlqmnqD85vD1ky2h06ZEHZKqVztS2H9n2f55xRl0G3hMvK3TaHiMVNQ48z/H9qg61hAHNBh/UQbheKf2enDF7Nn/xCZkIX2etStewoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH1k2ppXtp2yQpMa3umQZbpoJAqksWO0lAKqvVY35Q4=;
 b=dHviBGUA32ya40Ud/oEE+PqO4yqxEPQ6mIAuiqGO+YTrvxu34887SllCWF17tJUvZD7mKyyyMC1BfWUdZWIlCao2AreTJinSfDo+44s2y0XHqZK5wZwIsrhlh1TiD9r6zqfRTu0HOraVTFTfp0b/1YJ80eL4xzz46PmlSex9mlr97iu8vnICoiRz/5/+2nW5nFpU3xrEc9wAGf3bkq4RWaH8hGZ9T7xj8z5arSMetdVRTSbLOHxt96EiuPaiyAeeODzk2QActQTQ2O9by8BBdMFnqZSpVkLZpPx2RaCUQIFdchWBKDn0ZdX+xU5vF+sCaxLocCsekvrqSw+IPmwP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB1764.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Sat, 1 May
 2021 09:29:41 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::311d:abde:1437:dde1]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::311d:abde:1437:dde1%7]) with mapi id 15.20.4087.038; Sat, 1 May 2021
 09:29:41 +0000
From:   <Peter.Enderborg@sony.com>
To:     <ebiederm@xmission.com>
CC:     <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <akpm@linux-foundation.org>,
        <peterz@infradead.org>, <ast@kernel.org>,
        <christian.brauner@ubuntu.com>, <dave@stgolabs.net>,
        <walken@google.com>, <jannh@google.com>,
        <mathieu.desnoyers@efficios.com>, <christophe.leroy@c-s.fr>,
        <minchan@kernel.org>
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
Thread-Topic: [PATCH 1/2] tracing: Add a trace for task_exit
Thread-Index: AQHXPcxKtEu4vBDankanfcyX4+Z7rarNVmxPgAEHAAA=
Date:   Sat, 1 May 2021 09:29:41 +0000
Message-ID: <4bb24db4-f720-f5e7-9054-36bdeaee1d79@sony.com>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
 <20210430142223.25500-2-peter.enderborg@sony.com>
 <m14kfnzmsp.fsf@fess.ebiederm.org>
In-Reply-To: <m14kfnzmsp.fsf@fess.ebiederm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99b5d302-81ec-4094-ae71-08d90c83a5e8
x-ms-traffictypediagnostic: AM9P193MB1764:
x-microsoft-antispam-prvs: <AM9P193MB1764E26550644F6BAD2631FD865D9@AM9P193MB1764.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NSZFE8uzwZrQ1IdNpSEfWJCYT9kh53rdvy3HLTNiKBd1ET3Hxt5AwB5NQAUDXHAEPiZgRmZqXVySS4gHHeI1mqK9TFQP3d55ByIDv9rIpH3oh8X+N50kBMcAK8j6S7BL2IbeY4kZOeagpwJK6jWqgCqBFHN13b4LoOga94t9FSS3zy6RxNskOk0vZplvKBn0lY5Sd/2JGoaRG/VxPbVZ+FtIC9ZBAg4Syecv86lky9sotoXRK0m0uGwpcQnhtxOL6N8duUOYjnkXwrJjKMxi9Zh0sOzcR4Uw+CeYwUCJEr+2JyJqhV4YKcVCNuf2HQ0fDsBa490vDmk81oXeTFGx5BUNGqOV3K/He88uoAzdpBeHThkIZunhPcXmM8OmyJDqHzTRlEjL+OfR3/CMoFo0CHG8UMWJO8iYeVCVuA9fCLCgA4Pekr8FZTW6LajNqxUBYCC+UqAMJzA/nILnMPniBV3dXTsGzicd5S+MJsrZGewUr7FmYgMjkZrxVXn/gsjkh4sXvCtIjgciqjHcco5anKloMnbv1xQAE+Rj0c5yGowLdMpS/T4vCl4G5iNtkk44UQPx6XPV03kA2c4Bzl+0GzKUqbWr4XBznPXhZb5MdrmwumOySrmZkw7URQHBgDy03gJmq3reA5l4zzwRuA9fY3B0ZSJNS3c9kTNT6vVKmzVdgqftpHz0k/DQCpwrviSi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(346002)(136003)(376002)(54906003)(186003)(316002)(83380400001)(8936002)(71200400001)(2616005)(31696002)(86362001)(122000001)(2906002)(5660300002)(38100700002)(31686004)(66946007)(64756008)(91956017)(76116006)(66476007)(66446008)(6506007)(8676002)(53546011)(6486002)(478600001)(6512007)(36756003)(7416002)(4326008)(26005)(6916009)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?em9BUU1jdmREOXlEWkZvRkJpVHE1K0ZPWkQ4S2ZhZDdrOWtwMGRsR0tGdWl6?=
 =?utf-8?B?MDdRMmNJYU9NNFl1aUx2WWhHM3o0Y3dMMkJDamNBbEdxejI0YmtqZHcyVkRM?=
 =?utf-8?B?VlA4dG0rSnAzejJsdFV3V2RZVWtKTll2bUJYWHhvQnJ1U3Q4ZkxreHNuZHV5?=
 =?utf-8?B?Ulp3SVZ6OEgrbG9UVEtuOC8vZWlLdHJydXhQUFFjR2ZNeEE0UzlZQktQYW4r?=
 =?utf-8?B?ZUpscU1FODVqSzdjSUhkRW5NSXlZNXdQM05zZmxiclNBOGFUdmV0cUdGa3dj?=
 =?utf-8?B?Y2RoaXBMTHhNWEtseVgraFdiVUlybjQ4VkZ4THJ4MlN1SDB3YktHS1JZUE5U?=
 =?utf-8?B?N1ViQlllWHEwN20xckJwbnZtcERqelBaRnBEQTNXalRBQ2ZBWjhrTHVmUEI3?=
 =?utf-8?B?cTZHcExnTDlmS3NkT1FzdUxldGpPOE9neHh1bDFwQWpOVVcrb0ZuQmRSTzlW?=
 =?utf-8?B?d3BlQW45RFBxUVRkN1EwWHA2V2hNRkNFaTlaWC9BVDVHK2tHcHhEVDFIaGVU?=
 =?utf-8?B?c3FoM0VtZ0cyQ1RwT2Z1Mjd1UGFDUXJVSklpaVFPaXhrWHRWa1hXZnoxb3Jz?=
 =?utf-8?B?RkRqSGh5QkdaK1p5WjhkK0svZm9YdDhZdFJPUDNyaVplTnlrdGJxeUpmWVZh?=
 =?utf-8?B?eDY4ZW16SllvUGFJYVYzd0pROXdPWEpRUzJFUzNobmwvSk5LMlZGYUROOTl6?=
 =?utf-8?B?dHFpbGpFYTBSNlBnUTVtZjZ6VDRiQ01Cais5MXdlZDF2OXlBcXNURWUyRk5X?=
 =?utf-8?B?T1QyUjR3ZjNmM3BCd0FFQUVhQkNZSUlpY2h6UXhvRnkvcDZEeHhlOVgyMmlU?=
 =?utf-8?B?NlJ2NGFpLzY4eHhrRkNub1hkOU1WWnBQSG9BU0Rjek10V1Myc2NwUitaY201?=
 =?utf-8?B?WDlVQ2w3dDAzQ3M3anpQTGpQc0h2V0hJZkR1ZmluZC83VFdUR2Z6blpNZ3hK?=
 =?utf-8?B?S1pJS0ZGUFN4ZjVEOWNVNHV1Vk5vVDBsekdJeUJMRE45UUVGdTJ1ZVZoNFd0?=
 =?utf-8?B?YUpDaWNrWDNSeklOWkVSeWdWaUZYM1FxemRUZ1gxODMrbWR6bm1mQUJMTGNo?=
 =?utf-8?B?aWhRTFFRbVNLTDNYbnV3YXFxNUJIMUhPU1hMekVkakxGSVNpOXY5a0FqSFJF?=
 =?utf-8?B?M2RNdWZaSjhqclFMVGpLSlA1ZnMzWTdaVVFEQWhzV3lvaXJ4VFBVQkhYNVY5?=
 =?utf-8?B?SDZIUG94akIwYUxHa3JKcnAzZkk4RGJGUUJleGdiVkowQUMxZEVUQTNtZVNN?=
 =?utf-8?B?WTYza0dYK2tETUIrVjlIWndSL3pCcHJvQUEyckZPMDNKdEtyRXA2bnVpOFpi?=
 =?utf-8?B?YXBvdDBBS1hnd2JlYUlSVmthd2xmZ3hzN09lK0JrVWY4NHYzTlFIQkFtejRY?=
 =?utf-8?B?R1BWbXIzWUd2bUNERGs0cHhuQ3RvR29IbHpqaDVQR05GRTBaVFhqY1U5V3Zi?=
 =?utf-8?B?eDNZT2ZvQ0xvTjJIQTUyN1dJZmRUTi9Uem5aYW1KWUFIN0dmZzRFTGZlcnFy?=
 =?utf-8?B?S0w1cCtLM1c0TzZzcENoODRMdFo1cW1vTENmTFdoQjFZTnBxMFBoaE1uTUk1?=
 =?utf-8?B?SWhzbEE1VUlxK0pZRVZzVXkva3pBYVozZnVTWi9WbVlaY3BqN2FtdmJpeGVE?=
 =?utf-8?B?UkVSQ0Z6OS96VzlSbTRodE9QSzUzM0lBQ1JndjBvd0o2NW1aSmxsSWZhQS90?=
 =?utf-8?B?NWJEdmZJYyswbXVhWllTWjcyNjdpV2d3LzhuV0dFV0h4RkdreklqVTYrK2hz?=
 =?utf-8?Q?Ii42zFFG9nSH517CCwWk5TXMbKXyMhoV+o4mo4T?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D68D78BA7F26FF4AA92F83FB026E6302@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b5d302-81ec-4094-ae71-08d90c83a5e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2021 09:29:41.2797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KxLvSraA760goXLP/eUHWcEGPpPkiH+QCpMSHgVTcNAR4k7fBTYW4cKhRsidjJqCG3NE1tKUQSYRUejueqscucRbx9REhutPT5EK8GhqhvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1764
X-Proofpoint-GUID: JshidESJJSjiWyMKhGUxuv_zrzLs-2qG
X-Proofpoint-ORIG-GUID: JshidESJJSjiWyMKhGUxuv_zrzLs-2qG
X-Sony-Outbound-GUID: JshidESJJSjiWyMKhGUxuv_zrzLs-2qG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-01_07:2021-04-30,2021-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105010066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8zMC8yMSA3OjQ4IFBNLCBFcmljIFcuIEJpZWRlcm1hbiB3cm90ZToNCj4gUGV0ZXIgRW5k
ZXJib3JnIDxwZXRlci5lbmRlcmJvcmdAc29ueS5jb20+IHdyaXRlczoNCj4NCj4+IFRoaXMgaXMg
dGhlIHBlZXIgZnVuY3Rpb25zIHRvIHRhc2tfcmVuYW1lIGFuZCB0YXNrX25ld3Rhc2suDQo+PiBX
aXRoIHRoaXMgd2UgZ2V0IGhvbGUgImxpZmUtY3ljbGUiIG9mIHRhc2sgYW5kIGNhbiBlYXNpbHkN
Cj4+IHNlZSBzaG9ydCBsaXZpZWQgdGFzayBhbmQgdGhlaXIgZXhpdCBzdGF0dXMuDQo+IFRoaXMg
cGF0Y2ggaXMgaW5jb3JyZWN0LiAgVGhlIGxvY2F0aW9uIHlvdSBhcmUgZGVhbGluZyB3aXRoIGlz
IG5vdCBwYXJ0DQo+IG9mIHRhc2sgZXhpdC4gIFRoZSBsb2NhdGlvbiB5b3UgaGF2ZSBpbnN0cnVt
ZW50ZWQgaXMgcGFydCBvZiByZWFwaW5nIGENCj4gdGFzayB3aGljaCBjYW4gY29tZSBhcmJpdHJh
cmlseSBsb25nIGFmdGVyIHRoZSB0YXNrIGV4aXRzLg0KDQpUaGF0IGlzIHdoYXQgaXQgYWltaW5n
LiBXaGVuIHVzaW5nIHRoaXMgYXMgdG9vbCBmb3IgdXNlcnNwYWNlIHlvdQ0Kd291bGQgbGlrZSB0
byBrbm93IHdoZW4gdGhlIHRhc2sgaXMgZG9uZS4gV2hlbiBpdCBubyBsb25nZXINCmhvbGRzIGFu
eSB0aGluZyB0aGF0IG1pZ2h0IGhhdmUgYW55IGltcGFjdC4gSWYgeW91IHRoaW5rIHRoZQ0KZXhp
dCBpbXBseSBzb21ldGhpbmcgbW9yZSBzcGVjaWZpYyBJIGNhbiBjaGFuZ2UgdGhlIG5hbWUuDQoN
CkkgdGhvdWdodCBleGl0IHdhcyBhIGdvb2QgbmFtZSwgaXQgaXMgaW4gaW4gZXhpdC5jLg0KDQpX
aWxsIHRoZSBuYW1lIHRhc2tfZG9uZSwgdGFza19maW5pc2hlZCBvciB0YXNrX3JlYXBlZCB3b3Jr
IGZvciB5b3U/DQoNCg0KPg0KPiBUaGVyZSBhcmUgc29tZSBzcGVjaWFsIHJ1bGVzIGFzc29jaWF0
ZWQgd2l0aCB0YXNrX2NvbW0gc28gSSBkb24ndCBrbm93DQo+IGlmIHlvdXIgY2hhbmdlIHRvIF9f
c3RyaW5nIGZyb20gYSBmaXhlZCBzaXplIGNoYXJhY3RlciBhcnJheSBpcyBzYWZlLg0KPg0KPiBD
ZXJ0YWlubHkgc29tZXRoaW5nIGxpa2UgdGhhdCBuZWVkcyBhbiBleHBsYW5hdGlvbiBvZiB3aHkg
c3VjaCBhIHR5cGUNCj4gY2hhbmdlIGlzIHNhZmUuDQo+DQo+IEVyaWMNCj4NCj4NCj4+IEZvcm1h
dCBtaWdodCBsb29rIGxpa2U6DQo+PiAgICAgICAgICAgICBiYXNoLTExNDQgICAgWzAwNl0gLi4u
LiAgMTMwNi42MDE3MDc6IHRhc2tfbmV3dGFzazogcGlkPTExODEgY29tbT1iYXNoIGNsb25lX2Zs
YWdzPTEyMDAwMDAgb29tX3Njb3JlX2Fkaj0wDQo+PiAgICAgICAgICAgIDwuLi4+LTExODEgICAg
WzAwN10gLi4uLiAgMTMwNi42MDIwODA6IHRhc2tfcmVuYW1lOiBwaWQ9MTE4MSBvbGRjb21tPWJh
c2ggbmV3Y29tbT1scyBvb21fc2NvcmVfYWRqPTANCj4+ICAgICAgICAgICAgIGJhc2gtMTE0NCAg
ICBbMDA2XSBkLi4uICAxMzA2Ljc4NTk2MDogdGFza19leGl0OiBwaWQ9MTE4MSBvb21fc2NvcmVf
YWRqPTAgZXhpdF9zaWduYWw9MTcgZXhpdF9jb2RlPTAgZXhpdF9zdGF0ZT0weDEwIGNvbW09bHMN
Cj4+DQo+PiBGb3IgYSBzZXF1ZW5jZSB3aGVuIGEgYmFzaCBzaGVsbCBydW5zIHRoZSBscyBjb21t
YW5kLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBldGVyIEVuZGVyYm9yZyA8cGV0ZXIuZW5kZXJi
b3JnQHNvbnkuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS90cmFjZS9ldmVudHMvdGFzay5oIHwg
MzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBrZXJuZWwvZXhpdC5jICAg
ICAgICAgICAgICAgfCAgMyArKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMo
KykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvdGFzay5oIGIvaW5j
bHVkZS90cmFjZS9ldmVudHMvdGFzay5oDQo+PiBpbmRleCA2NGQxNjA5MzBiMGQuLjJlOTc3ZDI5
MzVlMSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3Rhc2suaA0KPj4gKysr
IGIvaW5jbHVkZS90cmFjZS9ldmVudHMvdGFzay5oDQo+PiBAQCAtNTYsNiArNTYsMzggQEAgVFJB
Q0VfRVZFTlQodGFza19yZW5hbWUsDQo+PiAgCQlfX2VudHJ5LT5uZXdjb21tLCBfX2VudHJ5LT5v
b21fc2NvcmVfYWRqKQ0KPj4gICk7DQo+PiAgDQo+PiArVFJBQ0VfRVZFTlQodGFza19leGl0LA0K
Pj4gKw0KPj4gKwlUUF9QUk9UTyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2spLA0KPj4gKw0KPj4g
KwlUUF9BUkdTKHRhc2spLA0KPj4gKw0KPj4gKwlUUF9TVFJVQ1RfX2VudHJ5KA0KPj4gKwkJX19m
aWVsZChwaWRfdCwJcGlkKQ0KPj4gKwkJX19maWVsZChzaG9ydCwJb29tX3Njb3JlX2FkaikNCj4+
ICsJCV9fZmllbGQoaW50LAlleGl0X3NpZ25hbCkNCj4+ICsJCV9fZmllbGQoaW50LAlleGl0X2Nv
ZGUpDQo+PiArCQlfX2ZpZWxkKGludCwJZXhpdF9zdGF0ZSkNCj4+ICsJCV9fc3RyaW5nKGNvbW0s
IHRhc2stPmNvbW0pDQo+PiArDQo+PiArCSksDQo+PiArDQo+PiArCVRQX2Zhc3RfYXNzaWduKA0K
Pj4gKwkJX19lbnRyeS0+cGlkID0gdGFzay0+cGlkOw0KPj4gKwkJX19lbnRyeS0+b29tX3Njb3Jl
X2FkaiA9IHRhc2stPnNpZ25hbC0+b29tX3Njb3JlX2FkajsNCj4+ICsJCV9fZW50cnktPmV4aXRf
c2lnbmFsID0gdGFzay0+ZXhpdF9zaWduYWw7DQo+PiArCQlfX2VudHJ5LT5leGl0X2NvZGUgPSB0
YXNrLT5leGl0X2NvZGU7DQo+PiArCQlfX2VudHJ5LT5leGl0X3N0YXRlID0gdGFzay0+ZXhpdF9z
dGF0ZTsNCj4+ICsJCV9fYXNzaWduX3N0cihjb21tLCB0YXNrLT5jb21tKTsNCj4+ICsJKSwNCj4+
ICsNCj4+ICsJVFBfcHJpbnRrKCJwaWQ9JWQgb29tX3Njb3JlX2Fkaj0laGQgZXhpdF9zaWduYWw9
JWQgZXhpdF9jb2RlPSVkIGV4aXRfc3RhdGU9MHgleCBjb21tPSVzIiwNCj4+ICsJCSAgX19lbnRy
eS0+cGlkLA0KPj4gKwkJICBfX2VudHJ5LT5vb21fc2NvcmVfYWRqLCBfX2VudHJ5LT5leGl0X3Np
Z25hbCwNCj4+ICsJCSAgX19lbnRyeS0+ZXhpdF9jb2RlLCBfX2VudHJ5LT5leGl0X3N0YXRlLA0K
Pj4gKwkJICBfX2dldF9zdHIoY29tbSkpDQo+PiArKTsNCj4+ICsNCj4+ICAjZW5kaWYNCj4+ICAN
Cj4+ICAvKiBUaGlzIHBhcnQgbXVzdCBiZSBvdXRzaWRlIHByb3RlY3Rpb24gKi8NCj4+IGRpZmYg
LS1naXQgYS9rZXJuZWwvZXhpdC5jIGIva2VybmVsL2V4aXQuYw0KPj4gaW5kZXggMDQwMjllMzVl
NjlhLi4zYWIwOTQ0ZTVkZmMgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvZXhpdC5jDQo+PiArKysg
Yi9rZXJuZWwvZXhpdC5jDQo+PiBAQCAtNjgsNiArNjgsNyBAQA0KPj4gICNpbmNsdWRlIDxsaW51
eC91YWNjZXNzLmg+DQo+PiAgI2luY2x1ZGUgPGFzbS91bmlzdGQuaD4NCj4+ICAjaW5jbHVkZSA8
YXNtL21tdV9jb250ZXh0Lmg+DQo+PiArI2luY2x1ZGUgPHRyYWNlL2V2ZW50cy90YXNrLmg+DQo+
PiAgDQo+PiAgc3RhdGljIHZvaWQgX191bmhhc2hfcHJvY2VzcyhzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnAsIGJvb2wgZ3JvdXBfZGVhZCkNCj4+ICB7DQo+PiBAQCAtMTA3LDYgKzEwOCw4IEBAIHN0YXRp
YyB2b2lkIF9fZXhpdF9zaWduYWwoc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQo+PiAgCQlwb3Np
eF9jcHVfdGltZXJzX2V4aXRfZ3JvdXAodHNrKTsNCj4+ICAjZW5kaWYNCj4+ICANCj4+ICsJdHJh
Y2VfdGFza19leGl0KHRzayk7DQo+PiArDQo+PiAgCWlmIChncm91cF9kZWFkKSB7DQo+PiAgCQl0
dHkgPSBzaWctPnR0eTsNCj4+ICAJCXNpZy0+dHR5ID0gTlVMTDsNCg0K
