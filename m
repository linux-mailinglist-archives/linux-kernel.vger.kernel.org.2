Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED33446467
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhKENsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:48:54 -0400
Received: from mail-eopbgr1400132.outbound.protection.outlook.com ([40.107.140.132]:18386
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230512AbhKENsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:48:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvAkkIEyDDavlEVuWiRmVMh3NdGxu0/CNFyR9r1PvPClHrCXRH8MZ/ghX1x7QaCW624PThvhefFDUWHUNkJ7c8xRgRpSbySeFU2xpsfbcsOXUZJfEaOyaJn5l860k1VI77KI5VOHblw4Es3rUad2LoNbCi9qb4cOarcQnLoWmyLhmpqgpFhEo2EcxKG6jfmcxfiw2ZbEGA41+uoR89Ti24mAApBE+/vpcTI9RTffxgh4wuk62QTYOt6L3tZ2IsgtozLXpGgLOC2HOG1CaqK+DgsiHRsHxkT+s5UpA9kBhc5BwKv7yhv/c3/h6eP1dmIy18ho4JhVThT+8nUJqZcXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DolFqyd9JhKjegbMRz+AafxSZ795XC9LMq88Tyg8S1k=;
 b=elCqs5uLXo80YNJjQ21TI+/T0gtcwZZEC52bXfM8CrknEWRk5JKGodR+zslG9SViIgxMdf4Ogbdf8MDGpHYbkRYEq6oSE6ZvkzJ/sxhuJn/cSrOh6f3urod0ie1S6ZcANtAa6E67KW0jHD8q6W4u0Lq/gVtazy71dIzJhcVZRXtKt5kY9uXkWp3gQvTrkZ80/rAg84tortmqEBGtPAmm9QLolBisk3Qi822s8cmWiNJcGcdVLSvtAxZDTkNBFhZzQKRHtpS/1Sy25BSPoRYkT9ybxlRpXEJVEKts+L91uEFDjRnGt09DvA98Tj8LuFvFHeAbrgwTPOFyxnnJQMjUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DolFqyd9JhKjegbMRz+AafxSZ795XC9LMq88Tyg8S1k=;
 b=DSatVdY/5bP3rLkV4V3bWjhS0BPdf9Xn81uoSF9oUZlebDerKLiDnPhC/3nk4xwjZiW9xo6C63KF+2hh9sUMM9jDhAP+oF0gspNUZm9UPMif2KYawdfLZRVivqIbEtoR1MF4/Rv2oP+CwGg4NywmKGQXBljjAASqW5OxOJchPP0=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB0954.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Fri, 5 Nov 2021 13:46:11 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%6]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 13:46:11 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "sre@kernel.org" <sre@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBIU0k6IGNvcmU6IEZpeCByZXR1cm4gZnJlZWQgb2Jq?=
 =?gb2312?B?ZWN0IGluIGhzaV9uZXdfY2xpZW50?=
Thread-Topic: [PATCH] HSI: core: Fix return freed object in hsi_new_client
Thread-Index: AQHX0ktdY853O5RntEWfbe19utagQ6v08i8g
Date:   Fri, 5 Nov 2021 13:46:11 +0000
Message-ID: <TYCP286MB118869772419427E0279BAE48A8E9@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <20211105134507.31946-1-cyeaa@connect.ust.hk>
In-Reply-To: <20211105134507.31946-1-cyeaa@connect.ust.hk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe40b378-45e2-427f-504f-08d9a062a0d5
x-ms-traffictypediagnostic: TYYP286MB0954:
x-microsoft-antispam-prvs: <TYYP286MB09540167562E94717175E1338A8E9@TYYP286MB0954.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +YiO4h0GM9gaemTZJmzLZr/4/JmyV5VQ8TTo/ZNB1kK68yU0Cp91iFfVIFTo2XmsHPn6H8U/p9vjgsaN8iGA2ldiMGOtJh8a5I5yoHaJVCGMXfOSrA3JYtN7jqSP03IuYcKsnBmJuiLkbQeIkYQasoyQ2d0kGsxDJW6qu2a0+4UYcTOy88QesydcNogzYiiLDKc7/oIE7QeOBPgRPzv+n1KTYFMQkLSn0ozAStIJv9T5WNtxFSjZK+bnKufOrvmO1/GNuIgNuozH+X+lB4bXjRhyj8mPwYvIyfAreALwJW5c8BdUPCyoviLDCuvSybdoaoqlCi2N1aFD+aTNkuTk56M3MxS3T5FaQUi+OVKBPxpQh/+5Y7hkBgbJADKiQwiV6xr4Ux0Bb37+u7Og6LjwN8GO2OXIUQiSED/4r5+c2VM6UkS8doAzIzbwT4BDr/rj+0IdzG+FcwPZ/M2sc/XWcudsbKUGrg32NHUsG4KtBXJaY3YBTfLJPyOHdkwItU90g+nJ/66ui13/3Qrsm/HDPbVxusclmLyNvT7C1wxS0Yf09krzFp3RnySWvZUban0H9Dzluv+QGykM+K8edTJlGzOY4bIf3nj5Ibln+9d7OQzdwApcOCsbMxtXZQDaZYp+HCwM5pGzKn34pIxFSBr0EuB+lHvL7aRIvZkfWa10h1XeLZW1OD//Td3tMKYJTj2rDPEKANiyPhfhAm9EGEANzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(38100700002)(186003)(66476007)(52536014)(76116006)(8936002)(66946007)(6916009)(33656002)(66556008)(4744005)(64756008)(71200400001)(38070700005)(86362001)(66446008)(9686003)(224303003)(498600001)(55016002)(2906002)(26005)(7696005)(5660300002)(122000001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Rnplb3Evd1RzdW1zYW9aQWF0K3FlajF2bE5zTGpGNTFjUU5KZWlCSlQ3VTJE?=
 =?gb2312?B?N3h5a0dKcFRjRmNKNndja2VGc0U5VUIvUXNuUENjeXJHU0dkOUs2dURsNWpY?=
 =?gb2312?B?bTFaWDRBWVZnYkowUTBvVm43bUZLZTdnMkNHMms2NzJsaGtzWE95RHBicjIy?=
 =?gb2312?B?Rml4RmlmY0dJL3dadzZmSGxWVG1udTBmdnpaZk92eUIreW9jb01ZQXVHd2dE?=
 =?gb2312?B?d1pKL1lGZXdteTgreXlJK2VUdXIxNjdwMGp6eUNYU1dRR1JBUGN1WHkyeW1k?=
 =?gb2312?B?VzQ4QWN6US9uSVFpK2c5RzI1Wmd5V0Evb3IyWGM4dU1peHcyYjdTM2oyRmZH?=
 =?gb2312?B?QTNQRWJpT0dzKzkyUVBNaG5DeVZzUlp3NjgrQnFVQXVRWUMza2hGYWFKOXJQ?=
 =?gb2312?B?UW83RzNGbGZLN2pFWlIvR0hKbWMvWXpac01XWVRtZGFxcVBGc0VmUVBjZ3pX?=
 =?gb2312?B?RDRpQlJ1K0xxSHA1N2NBclpuV04yekRDZURWRFFsUGZIWXJNMlJveTZacDY4?=
 =?gb2312?B?NlM2RWZKK0hlZ2pmRHZod3lEWjJEdEFZNDNuTGh5b2ZFQTVwL3Q0TW9UdUNV?=
 =?gb2312?B?K3dBSWd6T0FuSzlINzhjYVNId1g2cXhRcUdlSzEvZkpwdDA2dDJYSlN0NmFn?=
 =?gb2312?B?Yndvdmd4Z2dhcDh0alFWc3RBVkh2RXQzeklZOEh2QTdlVDhROUZuNVc0RVFy?=
 =?gb2312?B?ZE4rV3NvdkFuSCtHVTVSemV6RVdUQ0NmeFVaMGk4UVR5cGppSkVxbGZHVDFu?=
 =?gb2312?B?OXhCOFFFeEc4VTdmRHVmaTZSMzBYbTU4Q3JUZGdOTEtIQTJ3N1BUcTRjWGdP?=
 =?gb2312?B?ZG9rTzJvNGx1d2M5c1J1RHhxZjhoODFyZXBmVWhpQ21vN2VydzErS0xwa0pj?=
 =?gb2312?B?aVEwU0xzSmgyRDhWM1ZZZWsreWJrMWJkOHJGUEJEdG1tNzdqc3hpVTgzN1NN?=
 =?gb2312?B?dncxMVUvQ1FIcDhqOXhnZjdML05CengwZTJRMGkwRHZ4NUp3c3JjOVBuQk43?=
 =?gb2312?B?NE4vZWZpQjRtRGdLTnlhbnlCUlM0NS9KMVBNbkxJakhoZGdyOWpMRUVYcUVI?=
 =?gb2312?B?NE5NSmR6RHFRVFpCY0Z4NFlIL3oyV3grQy9PM2gvRzZ0NTZuQkJUSU13Y3dv?=
 =?gb2312?B?MWFtUGF6OXpFYXU0QXpWY2lyZ1A3QXArRU9ib2Q0Uk1CejhKUGJNM2pwanlU?=
 =?gb2312?B?eGk5MkU1WEZmNnBobDFsQnZyT01McmpyeEFNTXdlK0I0T2JOd1o3c0tmMzVU?=
 =?gb2312?B?SXF3Tm45eStLTkRGZmdNNDUrNFJDWDZvK2xvelZWRG1SRzh0WG1qalAvRWEx?=
 =?gb2312?B?dzFkNnI0TTFhK2NLdkt2NVYzZm9CWHE4UElxd2dldGNSYUdPdW53UndqTHZS?=
 =?gb2312?B?U1lYR3E4VVdMSmVGcEQ5WUVMeHlWYlRxQzFpdlR2b2svcGlDQzlqYjhWSSts?=
 =?gb2312?B?OGpMTmFGVWhFVjBNUWR5VnJXR2g3RVZsK3BTdDYrODY0ZGZlZ1hDRzdvUC9m?=
 =?gb2312?B?TFg5VUhOeWszUXc3ZDBqRHpkVC9yS1YvT2JGQW5RbUZDWFpwcE9aY1RpdlRD?=
 =?gb2312?B?NlpsVTc5RzVpZ0g3NVBmUVY1RWFwMFNWZ1l5ZUdaampqakRla1ZkZEIvMUlD?=
 =?gb2312?B?enI2Umx2bXBxUXpzMTVpQ3pZanZDM1lNUm5iVmVsS0o2cnB0NHJNbnVlR2Za?=
 =?gb2312?B?UHFNMGNjR1hCSkM0alVVdlloUE9ZWXk1L3JrS3RlYVdTMjZFNEk1K056T3Zi?=
 =?gb2312?B?dUhrcFphdTFvWkJGWGlSR2xXM295UjBiYm9EVTRFVjZWd1R1eXIzNEV4RGhr?=
 =?gb2312?B?aDBPbElWL3pFTk9kTUxlVElSbXl5ZTRzOWRhUFIrT1RUNzRGTXloVVpXT21r?=
 =?gb2312?B?VXRPOVNoamQ2U2c1T0RuUkE2dW5jeDNZd3hyU3laZndLQ25sL3FvZXd5WWRa?=
 =?gb2312?B?UjJDdlBLRjNoZDlJbTBPUkZuaitBcEYrd2x2NjYzTzFKV3VCUUZHNEJtdDNk?=
 =?gb2312?B?MHFsRS9UL2g0aTR1TzhIVjR6NStqalZFYmkwUkpXL2FaLzExcnVUQnBzQVZk?=
 =?gb2312?B?cWVmZUR5VzVUblNiK3ZJTmVPb0xTa3BmVGYxODZObFAyaUFwTkhsYnBUVFAw?=
 =?gb2312?B?T2xoTDk2dmxvWDFwajFYUDF6a2tuazF6NS95QkNrejlpR0w3VElsU05aaHln?=
 =?gb2312?B?bFE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fe40b378-45e2-427f-504f-08d9a062a0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 13:46:11.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4fyV80FtSVjsNCV/TSBsHmOM68xIGkwklZK2tUQ/zsepI48eLnNsZBwp+9ypPBUbly9IdOx/3U15hSqvKLktw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB0954
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KDQpXZSBzZW5kIGEgcGF0Y2ggZm9yIHRoaXMgc3VzcGVjdGVkIHVhZiBpc3N1ZS4gV291
bGQgeW91IGxpa2UgdG8gaGF2ZSBhIGxvb2sgYXQgaXQ/DQoNCkJlc3QgcmVnYXJkcywNCkNoZW5n
ZmVuZw0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogWUUgQ2hlbmdmZW5nIA0Kt6LLzcqx
vOQ6IDIwMjHE6jEx1MI1yNUgMjE6NDUNCsrVvP7Iyzogc3JlQGtlcm5lbC5vcmcNCrOty806IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFlFIENoZW5nZmVuZyA8Y3llYWFAY29ubmVjdC51
c3QuaGs+DQrW98ziOiBbUEFUQ0hdIEhTSTogY29yZTogRml4IHJldHVybiBmcmVlZCBvYmplY3Qg
aW4gaHNpX25ld19jbGllbnQNCg0KY2wgaXMgZnJlZWQgb24gZXJyb3Igb2YgY2FsbGluZyBkZXZp
Y2VfcmVnaXN0ZXIsIGJ1dCB0aGlzIG9iamVjdCBpcyByZXR1cm4gbGF0ZXIsIHdoaWNoIHdpbGwg
Y2F1c2UgdWFmIGlzc3VlLiBGaXggaXQgYnkgcmV0dXJuIE5VTEwgb24gZXJyb3IuDQoNClNpZ25l
ZC1vZmYtYnk6IENoZW5nZmVuZyBZZSA8Y3llYWFAY29ubmVjdC51c3QuaGs+DQotLS0NCiBkcml2
ZXJzL2hzaS9oc2lfY29yZS5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2hzaS9oc2lfY29yZS5jIGIvZHJpdmVycy9oc2kvaHNp
X2NvcmUuYyBpbmRleCBlYzkwNzEzNTY0ZTMuLjg4NDA2NjEwOTY5OSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvaHNpL2hzaV9jb3JlLmMNCisrKyBiL2RyaXZlcnMvaHNpL2hzaV9jb3JlLmMNCkBAIC0x
MDIsNiArMTAyLDcgQEAgc3RydWN0IGhzaV9jbGllbnQgKmhzaV9uZXdfY2xpZW50KHN0cnVjdCBo
c2lfcG9ydCAqcG9ydCwNCiAJaWYgKGRldmljZV9yZWdpc3RlcigmY2wtPmRldmljZSkgPCAwKSB7
DQogCQlwcl9lcnIoImhzaTogZmFpbGVkIHRvIHJlZ2lzdGVyIGNsaWVudDogJXNcbiIsIGluZm8t
Pm5hbWUpOw0KIAkJcHV0X2RldmljZSgmY2wtPmRldmljZSk7DQorCQlnb3RvIGVycjsNCiAJfQ0K
IA0KIAlyZXR1cm4gY2w7DQotLQ0KMi4xNy4xDQoNCg==
