Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE213249D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhBYEnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:43:19 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:45156 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhBYEnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2510; q=dns/txt; s=iport;
  t=1614228194; x=1615437794;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=0pt6nK4HPm6RnR8G3dZ9F1akDuDmfHZQQZs2+n9g6Ag=;
  b=jAU2RZ3JWc3/RD0K++Rn/T+a/WUdoCKzNmZwyBaa09kTrHntwKsSFqpx
   pCALPUkBKZTBKBFgmeJeCpyYdrjTPlIgryKXHmhpSBtcxCHpH0Jnh+Z1h
   G9REWCK/gPgIAbbMhKYNfFp1KBkZDSrnupLHZQTywp0GinAjeKL9qcUvZ
   E=;
IronPort-PHdr: =?us-ascii?q?9a23=3AxyqwSxxn/qMPyQvXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5ZRaHt/5tlljMXJjerfVehLmev6PhXDkG5pCM+DAHfYdXXh?=
 =?us-ascii?q?AIwcMRg0Q7AcGDBEG6SZyibyEzEMlYElMw+Xa9PBteGNz5YlzPpzu19zFBUh?=
 =?us-ascii?q?n6PBB+c+LyHIOahs+r1ue0rpvUZQgAhDe0bb5oahusqgCEvcgNiowkIaE0mR?=
 =?us-ascii?q?Y=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DGAACwKTdg/4wNJK1iHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgTwGAQELAQGBUVEHdlo2MQoBhDaDSAOFOYg3JZUehAWBLoE?=
 =?us-ascii?q?lA1QLAQEBDQEBJA4CBAEBhE0ZgWACJTUIDgIDAQELAQEFAQEBAgEGBHGFYQ1?=
 =?us-ascii?q?DARABhW8BKREMAQE3AREBGQMBAgMCJgIEMBUICgQBDQWCcAGCVQMuAaRYAoo?=
 =?us-ascii?q?ldoEygwQBAQaFIxiCEgmBDioBgnWECIZEJhyBQUKBEScMEIdqgn80giuCSgF?=
 =?us-ascii?q?ZNoFtURgak36lYQqCfIk+klwDH4M0kEePTy2UH50ThQACAgICBAUCDgEBBoF?=
 =?us-ascii?q?WAjaBV3AVZQGCPglHFwINjh+Db4pZczgCBgoBAQMJfIFgiCgBgQ4BAQ?=
X-IronPort-AV: E=Sophos;i="5.81,203,1610409600"; 
   d="scan'208,223";a="840367067"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 25 Feb 2021 04:42:31 +0000
Received: from mail.cisco.com (xbe-aln-003.cisco.com [173.36.7.18])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 11P4gVT4019028
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 25 Feb 2021 04:42:31 GMT
Received: from xfe-aln-005.cisco.com (173.37.135.125) by xbe-aln-003.cisco.com
 (173.36.7.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Wed, 24 Feb 2021
 22:42:31 -0600
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by xfe-aln-005.cisco.com
 (173.37.135.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; Wed, 24 Feb 2021
 22:42:30 -0600
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-002.cisco.com (64.101.210.229) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 24 Feb 2021 23:42:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwnPUKao9kG+kvlezBOpJ/11gaM3pqi4yO9kBHqVO1KNPC1CEgYQsJIh15GmS8YuknvNISzZ4OV1az06nFm6NKbJPZR/oW/Nk+YrHGkAT/N7wI8Vm8xTzThEAaRnT2/Xb1qr5v4Sz8m8AVvEnRpYmEta4GOUf3SShB0ELAzM8CbE5IW2FRwn+FHlYZBpMLF2Xn/LxNgN/+aERyhiHABybCLYtAIHvQtltq0Oc4PlLWHkbvLHL+51A4b7A3xVcXWvbMFuuHBJMhIZlnyZAP4fKTfira/tob6T6hhP6Lj5OTzark5adsJY6gXPEYrWuHFiJ0o+2vQIL+WGeZXZjRcThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pt6nK4HPm6RnR8G3dZ9F1akDuDmfHZQQZs2+n9g6Ag=;
 b=I77AASt5uk+a7SAs24T1+bNN1ke2pwULadH5r7kNg8LHePKUjEkbmb/qY2qJYWp9EN0PloM0nxsrzMNHCxm9k0T49vO/Xd9Ky7ecfnleCAd4spa/0PX3/VZ1jNWbbF6arGEnC04sHr1Lym2hfrlXvkxi+WUPPcgliP7587X81zzVYRX7YoeijTUgJ1B00x4D01PrSjvUtEjKVuc5+oqZxCqqXpdRHZ7kFrg4HdvcyeTiBMcp+a6U0pxg3as+fDq5TTwIEGgp+xfJJKR9Yxh+IcUT14aCygHfFVuaQeqjmPtzgsDzP6L+EWcWdtqgPcQb1A4x6OILI9rTqQCuwKHS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pt6nK4HPm6RnR8G3dZ9F1akDuDmfHZQQZs2+n9g6Ag=;
 b=J7K5B2iaObc1ZIgInAmuOcSjsLMxVYqtvMg4QAluNLd1CzzdaKavlglPQEglwCO8LWtoFdXLe4turbxi2BaVOxbGnR+sgyFIO6qi3UJx++ih44B+ql2wS4e56cNq/kIwA5D0+Q5uKkyFPbTAdr14N17JXuZ+aGKYzvAQ/YVcdOA=
Received: from DM6PR11MB3787.namprd11.prod.outlook.com (2603:10b6:5:143::10)
 by DM6PR11MB4361.namprd11.prod.outlook.com (2603:10b6:5:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Thu, 25 Feb
 2021 04:42:29 +0000
Received: from DM6PR11MB3787.namprd11.prod.outlook.com
 ([fe80::c55b:18a2:be17:29c8]) by DM6PR11MB3787.namprd11.prod.outlook.com
 ([fe80::c55b:18a2:be17:29c8%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 04:42:29 +0000
From:   "Lan Zheng (lanzheng)" <lanzheng@cisco.com>
To:     Kees Cook <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Lan Zheng (lanzheng)" <lanzheng@cisco.com>
Subject: [PATCH v1 1/1] Kernel Config to make randomize_va_space read-only.
Thread-Topic: [PATCH v1 1/1] Kernel Config to make randomize_va_space
 read-only.
Thread-Index: AQHXCzCf6Zy89ILuRUyyRgkScToHXA==
Date:   Thu, 25 Feb 2021 04:42:28 +0000
Message-ID: <FA94F19F-2AB2-4983-8CEC-D89287D91E20@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [73.167.134.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd436e3f-b1ab-455f-50c3-08d8d947c1d7
x-ms-traffictypediagnostic: DM6PR11MB4361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4361DB0F83E18A9CBF8757B8DD9E9@DM6PR11MB4361.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cu2EiYhTdvoOlPXLXkTaMTbxt7xVlQ+hXUoqg4iiEuR54/k4jbbIwFYHR+ahrIEkLVWNetRbJjDhsuoCWeTgUbR9HSosW84+DE+kkQXCS4c6Z3SrYm5/qEhNvk4Ym8aaRroqHnxNIY5NDG9ogF+bU00fntMNiG9i6xc46DyVWmRhxw0G2i3O6WwRLHoVxxet+cs/zz9CS2LV0fpSapDJtLt8jiD8x0AaHRu9JNZLujt5mY/2KzfEVu2eZOTPVZz/7z0KPXWnvXA9h93jP5fXcD7ZNITapyIEY9/TgXni1iRd4tAg4wBx1pxfM38LO0j7NXyzbxg+jdi6vUsCsQdlrTkYtBUAaxg7Qsu+HJ6Q4eROYPkdXh0hYmk2fQMOtvCg87u2FXUzCL9qWL8mlxtEmu0b2Kbo/KXlnsFUMp4ltMaGg6bp/NUsXlXRzfNdTxc6BIjM/kRXU29eWaaRJ8Km4erV2WJC4MADsARiOIb6rckCPxTuN40wwpTJWoTzhC46G5/tR/5do6EyTVM8Tnj1ty2r/ihzMmwtrP/c/5V1hVXTQA/ja0fS7wtpGn6Ijr3vdhDmp8sIfeTq3ez0K2o2Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(376002)(346002)(66446008)(4326008)(76116006)(53546011)(66946007)(6486002)(83380400001)(33656002)(6512007)(86362001)(26005)(107886003)(478600001)(6506007)(8936002)(64756008)(8676002)(66476007)(316002)(36756003)(110136005)(66556008)(2616005)(186003)(5660300002)(2906002)(71200400001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cU1jT1RiVnZtc3pFUDJ5RlVBcWUzcDBHL2s5b2lubis5TXdmTjAyNnRVMm5y?=
 =?utf-8?B?Rzh0SmIyL3Y4WU1oUmc1SStETklJRnY2clJKZ1dmTWg0dVAyb0VNTW1ueTZJ?=
 =?utf-8?B?QzhicWtXMlNxNFNnbmdiaGFWWnhVL0tlODB4ZmhGL0JlVEwyUDExMHNXOEth?=
 =?utf-8?B?NmdGd0hKS1pzbTdmaXk2Vm1uSDhBN04vLzJqMTFTRENUdXRUYk11WWU3M205?=
 =?utf-8?B?RUsvY21QanNRSFVzWGF5R1Nxdlh2ZUdrRXhXUjFPUnB3endsZExKZWF1NjJl?=
 =?utf-8?B?ZC9OaUhuZytoTUdlRmlQUjd2NUFJNEduS0NBdlkwaTNXdG5zd3k1eUpLVkV5?=
 =?utf-8?B?YSswZW4ydlo5ekhaS2MyYW5zWEtaMUtVbUNmd3NGb2FWdEcxSW9hSkxPL09Q?=
 =?utf-8?B?UThXMEF5djNGU3EwUXpVVUdrK09peHptVzRwZ0RWejhQZnp0OHBZVXJLM0ZN?=
 =?utf-8?B?MzJnaHNFTTVCckI3bTluWjVORHJxQ0FBZnFKZXYzbzliWi9tNllZc0R5SHVi?=
 =?utf-8?B?d2Y1VERQdWRQdzJLRVdFT0pNaER3R25mS2dOd09TckltREpvZ05WbVRYMXB3?=
 =?utf-8?B?QndQZEhHVi80K2lBM2lIVFJJZENtZlArRDBNcGoxc2FJTHF3T0JRVGdDaDdV?=
 =?utf-8?B?ZnRBOEpMMCthNVEwRTduNWkvWFlWSG9QYURINlh3OVl6VGpFa1BFYVo4VzhZ?=
 =?utf-8?B?L1I2QThNanM0RVVJcVV3ajVndllqYXowTWxtdHhLYStQVlp1MVJCSnNyaWhN?=
 =?utf-8?B?UHQ1cTVKQjBzR05GYTlUSWpHc2MvNENDMFZoczJCQkt1WFNqQkRuYmRoWEYv?=
 =?utf-8?B?elh3OGRrbS9Gb3gyNVNCbk5DTGRCWmtxb3RlOFAyWGtGY0tOLzA2TE9VbjhQ?=
 =?utf-8?B?K3N5ZVNuM3FORlJmWjVZdTN0dzc3Y2N1S01iQzJpZ2l1azhLOWZTSTB1a1ZM?=
 =?utf-8?B?eXRUZ0orOHpQRWFMQlNIYnNrN2JBazg1TlFYME1kd3JCRkRmcXFPUm5KUkQ0?=
 =?utf-8?B?SHlHNFFaa0pXcU5GRW8yZnFjQzVvSUQvem9SZkxVeXMxNW9aZ0hqTG5OeHUx?=
 =?utf-8?B?SHZueG9EY0gxUEgzZS83UTFIcERldVc5Sitha21zSXlLSGJXMy8vOFpUdXNZ?=
 =?utf-8?B?b3hzaFZXN3N4c3dVU3pISVBoajltakRDalRtSjMwL0Jwd3haZThrUEw4VXM3?=
 =?utf-8?B?TmVsdXVPaHdtNlFFc0hleEZTRmd2R0xtbC85b056NFpIeGpqRE5GVVJlSENj?=
 =?utf-8?B?QUJJRUZOYWtGL0VNZjZGNWFSeUMwMmRzVlBwTzhpRGZJbE9FYlZBYkdGTmR2?=
 =?utf-8?B?UTdmWktQSnNQd0ZGN3oxRjB5b1cyM1dTL3Vva3dSRnhKNU9uOEluRXNIcHZE?=
 =?utf-8?B?V1p0MkorZGhKb0c1SGR6YVhsYksvL1Vqc1U2ZnF0clJkcTFBREF0THZDT1hQ?=
 =?utf-8?B?V2dHNG43OE4vVHNnSEdXbm5ldWMvTkNPOU9uZ3JMWllWSGRsVVMyS1ZhbC9O?=
 =?utf-8?B?M25vYXR0MVp1Y1NkNFlWQ0d2VVZVbS9Rb3gzeW5rOHh0ZUxjYW9ENXlTLzB2?=
 =?utf-8?B?WGlBYUtuWkswN2N6OFhZMllBWVJEMUZUMTdGbEtqMEZwd3JNTVBmSWdGRzYv?=
 =?utf-8?B?MG1JZzM0VzRFZEl0bVFoaWMzNUdLRERVdE1ETUlKZW82SXRBOTFZRGovaFdC?=
 =?utf-8?B?YjNVSldaL0lEZlRDUGlwRlgxd0VnZ0dQbHlUelRVYU9NOEIzOHJmdW5xM2d6?=
 =?utf-8?B?VHpwUnY4aUlaNUdYZGdsaVNTN0ZUVURuUDkzNWpHbU5JRVJpclpNZjF1WTQ3?=
 =?utf-8?B?akNMd3c5Sm9Fam9pQmRpdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74838927C50EB94F943E6ACEA9A9C5BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd436e3f-b1ab-455f-50c3-08d8d947c1d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 04:42:28.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NExHXQNc64s+sLuaDVIt0MC6RWFrTECJw4ItiSWN2Z5m5xz704XvuHvEYexHeKy4ugs6zUlutxvz9CARtKhhBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4361
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.18, xbe-aln-003.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbSBiYTJlYzUyZjE3MGE4ZTY5ZDZjNDQyMzhiYjU3OGY5NTE4YTdlM2I3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogbGFuemhlbmcgPGxhbnpoZW5nQGNpc2NvLmNvbT4NCkRhdGU6
IFR1ZSwgMjMgRmViIDIwMjEgMjI6NDk6MzQgLTA1MDANClN1YmplY3Q6IFtQQVRDSF0gVGhpcyBw
YXRjaCBhZGRzIGEga2VybmVsIGJ1aWxkIGNvbmZpZyBrbm9iIHRoYXQgZGlzYWxsb3dzDQogY2hh
bmdlcyB0byB0aGUgc3lzY3RsIHZhcmlhYmxlIHJhbmRvbWl6ZV92YV9zcGFjZS5JdCBtYWtlcyBo
YXJkZXIgZm9yDQogYXR0YWNrZXIgdG8gZGlzYWJsZSBBU0xSIGFuZCByZWR1Y2VzIHNlY3VyaXR5
IHJpc2tzLg0KIA0KU2lnbmVkLW9mZi1ieTogbGFuemhlbmcgPGxhbnpoZW5nQGNpc2NvLmNvbT4N
ClJldmlld2VkLWJ5OiBZb25na3VpIEhhbiA8eW9uaGFuQGNpc2NvLmNvbT4NClRlc3RlZC1ieTog
TmlybWFsYSBBcnVtdWdhbSA8bmlhcnVtdWdAY2lzY28uY29tPg0KLS0tDQoga2VybmVsL3N5c2N0
bC5jICB8IDQgKysrKw0KIHNlY3VyaXR5L0tjb25maWcgfCA4ICsrKysrKysrDQogMiBmaWxlcyBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQogDQpkaWZmIC0tZ2l0IGEva2VybmVsL3N5c2N0bC5j
IGIva2VybmVsL3N5c2N0bC5jDQppbmRleCBjOWZiZGQ4NDgxMzguLjJhYTliYzgwNDRjNyAxMDA2
NDQNCi0tLSBhL2tlcm5lbC9zeXNjdGwuYw0KKysrIGIva2VybmVsL3N5c2N0bC5jDQpAQCAtMjQy
Niw3ICsyNDI2LDExIEBAIHN0YXRpYyBzdHJ1Y3QgY3RsX3RhYmxlIGtlcm5fdGFibGVbXSA9IHsN
CiAgICAgICAgICAgICAgICAucHJvY25hbWUgICAgICAgPSAicmFuZG9taXplX3ZhX3NwYWNlIiwN
CiAgICAgICAgICAgICAgICAuZGF0YSAgICAgICAgICAgPSAmcmFuZG9taXplX3ZhX3NwYWNlLA0K
ICAgICAgICAgICAgICAgIC5tYXhsZW4gICAgICAgICA9IHNpemVvZihpbnQpLA0KKyNpZiBkZWZp
bmVkKENPTkZJR19SQU5ET01JWkVfVkFfU1BBQ0VfUkVBRE9OTFkpDQorICAgICAgICAgICAgICAg
Lm1vZGUgICAgICAgICAgID0gMDQ0NCwNCisjZWxzZQ0KICAgICAgICAgICAgICAgIC5tb2RlICAg
ICAgICAgICA9IDA2NDQsDQorI2VuZGlmDQogICAgICAgICAgICAgICAgLnByb2NfaGFuZGxlciAg
ID0gcHJvY19kb2ludHZlYywNCiAgICAgICAgfSwNCiAjZW5kaWYNCmRpZmYgLS1naXQgYS9zZWN1
cml0eS9LY29uZmlnIGIvc2VjdXJpdHkvS2NvbmZpZw0KaW5kZXggNzU2MWY2Zjk5ZjFkLi4xOGI5
ZGZmNDY0OGMgMTAwNjQ0DQotLS0gYS9zZWN1cml0eS9LY29uZmlnDQorKysgYi9zZWN1cml0eS9L
Y29uZmlnDQpAQCAtNyw2ICs3LDE0IEBAIG1lbnUgIlNlY3VyaXR5IG9wdGlvbnMiDQogDQogc291
cmNlICJzZWN1cml0eS9rZXlzL0tjb25maWciDQogDQorY29uZmlnIFJBTkRPTUlaRV9WQV9TUEFD
RV9SRUFET05MWQ0KKyAgICAgICBib29sICJEaXNhbGxvdyBjaGFuZ2Ugb2YgcmFuZG9taXplX3Zh
X3NwYWNlIg0KKyAgICAgICBkZWZhdWx0IHkNCisgICAgICAgaGVscA0KKyAgICAgICAgIElmIHlv
dSBzYXkgWSBoZXJlLCAvcHJvYy9zeXMva2VybmVsL3JhbmRvbWl6ZV92YV9zcGFjZSBjYW4gbm90
DQorICAgICAgICAgYmUgY2hhbmdlZCBieSBhbnkgdXNlciwgaW5jbHVkaW5nIHJvb3QsIHRoaXMg
d2lsbCBoZWxwIHByZXZlbnQNCisgICAgICAgICBkaXNhYmxlbWVudCBvZiBBU0xSLg0KKw0KIGNv
bmZpZyBTRUNVUklUWV9ETUVTR19SRVNUUklDVA0KICAgICAgICBib29sICJSZXN0cmljdCB1bnBy
aXZpbGVnZWQgYWNjZXNzIHRvIHRoZSBrZXJuZWwgc3lzbG9nIg0KICAgICAgICBkZWZhdWx0IG4N
Ci0tDQoNCg==
