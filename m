Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243B532BAD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443408AbhCCL7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:59:01 -0500
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:18758
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237959AbhCCF5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 00:57:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZMkRZwhTYdxCZTqPJJA1hw5VY9utSP7I7pdEqbTOh2R/JWiGiJpEcm2Yb5tj+HXvI5M2qohTTCVyJSdBrJZQ5CjXqK3MQl99yO9BN2rmPV82HLOONWUD1t3ILXPItjZpT26IY6oOh1aBPTpoLoKsh3g5K5En8Id/f9YtjCO9wR5FfLLIulBvlBnbQyhXnYy7ls38AVtZbNB8SuR+GX8Oy/zMu3mK404D+oPEPyzwI0iLybxNs4sp/RPdyofj2gD8OuD03jFUV9dHlJI12tEtOzYbWQ/m8MZhphV0abPoW6p1ycSnAhuGvv+48Z42A6m70tqRK+8PzE2VSSxHxgtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgRFXF/30opkj++59rBf2tXkUJsR6J0zFVDY+f6UTUE=;
 b=i9J7GlSvCHbM7LmeaYPORDaffHj48hUZKzB6vHMW+RSfRDqud2XH8dBErJvQv6VwDsOGGXKMwcq2qTqPPQQT20oYJtticRr3Cf1mC6UhsMvhk2uWIU+mscLlBIqShu2qZQMjaHzYWFGg0RxeM4yTIxh+Mmtv38Bgdy0o/oGgXtcZzrD0jE4n7CDu1mEsEjNaF4o7nkqeybVemvXd7QUBwC32881CCheKdha5QgwVwqr4/ER7gOtU6F1xqphKNmat+tIfW0cuSVHHvkDP5HyOk6F93cPDn8sE5tSpzqwQ6xPfYKxjeNLa7L22ufG8uW/JzRpu/olaTISSxDsgFb3HHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgRFXF/30opkj++59rBf2tXkUJsR6J0zFVDY+f6UTUE=;
 b=ck0r2Hcvdw4wzK+hX7r6BBaH1QnIE4M5h/ahI13NZ/UwIPqe2wK1V15nBnwuq1nMM9lr8u9WpPYppeetzILvvQK5MkKZshfD5+CbrzPHr0PO/RvpojBOAQ5ErvM9oc07WWTgOstVzI7UZKzU8jt/3y3me05JyaDHDrS9QVJ+Zpg=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3301.namprd11.prod.outlook.com (2603:10b6:a03:7f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 3 Mar
 2021 05:56:20 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 05:56:19 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>, Tejun Heo <htejun@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSB3b3JrcXVldWU6IE1vdmUgdGhlIHBvc2l0aW9u?=
 =?gb2312?B?IG9mIGRlYnVnX3dvcmtfYWN0aXZhdGUoKSBpbiBfX3F1ZXVlX3dvcmsoKQ==?=
Thread-Topic: [PATCH v2] workqueue: Move the position of debug_work_activate()
 in __queue_work()
Thread-Index: AQHXBaSJHER6h55uZEqpyxuP2SELpapx1xIT
Date:   Wed, 3 Mar 2021 05:56:19 +0000
Message-ID: <BYAPR11MB2632E9F24134D8CA6E9FB863FF989@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210218031649.151638-1-qiang.zhang@windriver.com>
In-Reply-To: <20210218031649.151638-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3388845-5d35-4056-1a8d-08d8de091137
x-ms-traffictypediagnostic: BYAPR11MB3301:
x-microsoft-antispam-prvs: <BYAPR11MB3301BCA01B25BBEBE64682CFFF989@BYAPR11MB3301.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ClLBu4OJ/qIHmQX++M4Jaeo5zwl0q6huWATmTplwKki8hj4rthVP8IRicMcy47JsBVUYA1RCB3OvPPWQras8xHPQ7GirzFzfKDlV3Rr7g3WoDkesdoDgkzYBXafzMCnG6rKt6ogQjKUsil3l81Ubp5h8a0PpI7Z4htaO0dNLKpVhNpGQNrWtMs5GKZgtgV68AOSdicBgwyDop3eFCKNF9sDGBAjRDMPOublaiT/4FE6/5KKyur6/Fjz3hBBSWe+G5geMDqzXRcxPH0YliSaHy+0etX8j49MU0B4eNncNbbF5gwDEDscu3mSb8XPjNr4Uvj04Y6pJa+HGeYSqbztkWsjct1RRF8TgNY+a6K/6zxNlflDZgl3jWxaELjcVe/tMMPomkTdtxgScnWROip3FXTxojiQkjKnL7QKZ/6BCTU/X7QqGZr+QueheYBEeThDayuF3xMEt2H1lbBGr7OniMJEZ9uWGIatCAGgw/DgqCc0JryuWflw7vsc4NUt7y2AIKwzNEwHWbZY0n0e2WXFTtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(366004)(136003)(346002)(9686003)(66946007)(5660300002)(86362001)(478600001)(7696005)(186003)(4326008)(66556008)(33656002)(26005)(66446008)(76116006)(55016002)(224303003)(64756008)(91956017)(8936002)(71200400001)(6506007)(316002)(52536014)(110136005)(83380400001)(66476007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?aTlkdElwQ0FmYWIwUkhRc05sNEtSUnh6MlRYY2tycGNpbGRBYk1pZEcvS3J5?=
 =?gb2312?B?eHkvZmxINXFDNjB3OUxrZVFZT08xbjNZN1g3N3oxQ081amJ0dVNGV0kwMjFu?=
 =?gb2312?B?MEdMemV2NFFlUldRbWE4bEFVRmtzc1hMSWdKaWUySjZobnpvTVRtMy9xT0RB?=
 =?gb2312?B?WWgwY1VlZmxEN1ZzSHpMaE50bUF5S2lWenR2MENxRDY5bDBnTERPRG5zaFVk?=
 =?gb2312?B?L0I2SXpIMFlVNDErbTBIWXZUVXdwbXFWTnQzYVlTRGdaM3JtVDBsaDFhRjB4?=
 =?gb2312?B?bUdLM29GMzg0Q0R3M09wL1U4STgxVkczcnBMVVJYTEJQWlRvTGF6eXAzRFI0?=
 =?gb2312?B?M20xQytudUNIUjdOQitIT3JsZGRMWmk2aG1hZVk3YzZONkdWNHE3RFFzMDlL?=
 =?gb2312?B?U2FUNUNCblRpQitqSUFKNmdkRDdaNkNQdzYzTUdmRWZEd0tkU0RpN3VBbXRK?=
 =?gb2312?B?b0NjSW5lZ1JCZUdFODVrM3RyajdjeHA2TWZlcFNVakNySUc0cjg4clo5L0JH?=
 =?gb2312?B?a2EvVWF4YzdzdHRIWDVuVW94NHBjYXBwUGRFbWhIN0lyRk10RSs1NlZsOUU5?=
 =?gb2312?B?ZmtyNkNYL3drUUd5VjYxdmJiTTZnMDVLS1pydG5HSFAxYlFSN2JoTlhDQnlu?=
 =?gb2312?B?T2tQM1M4WEpPalJqU0Y1L1NIWTlBdmxIWmxhdGxRMTRKT1NTRHN2RmtveExF?=
 =?gb2312?B?c2dLNndaaUhpNWE0STVOVnFsR2ZiUXRBdzFyZTFEWWhGZEcrZlcvMUhXTXc0?=
 =?gb2312?B?aHlEdDUrKzZzWFBsK0VUYUxZQm1xRStqT1BraE9SZ1p6OVhKME8yVlBmU3J5?=
 =?gb2312?B?K0h4eEFhOFZKdzd5VTNEczVlMTY2K2d5SVhEMjhuSURmVHJWWmg5bFJFQ3Bs?=
 =?gb2312?B?WExYbEZ0Q2QwdkZnM1FVSlR1ZFFEU2dHeS9JTE9RVzUrV3NuMTlQM1FEOFJG?=
 =?gb2312?B?YmFaNCsweGZJNmtYVENqeEMzVTkwMGR3UnFqYjkzaDJlSC9aOXJ2a254U0xn?=
 =?gb2312?B?QUQvMDNmcEU2VEdVUzE0ZVlaS3lXUDJrRkRKVGExRlZIQTR0RWRzY1EwekN5?=
 =?gb2312?B?WldzcGRCeitlRm5lQndURkFEWndnNnVTZThMU2dhU3BqVkFZQjRGa0V3NzAv?=
 =?gb2312?B?Q0tTemg3Nnd2aUR0WGFmLytTc3Ryb0MzVDBPNUo3eGRnYWJ4cjk4enZWc0xy?=
 =?gb2312?B?RHNaeENsZmFQSFUrWFZTaUNMemY2TFFFc2xETTNrMnNxVDZ5TzNJc21OVkFy?=
 =?gb2312?B?eHljTmpwU240ampwVG5wT1QrRWIvWVNkS2YrTjZXTHNNVHdOYnZUeTArVUdM?=
 =?gb2312?B?MlBWWUZ0WFVma2JoWDV5T2Q1TlRDTjI2K0xDQ0ZvS2lqWUVxT210ajlVYzVL?=
 =?gb2312?B?Q1NsQkN2Y2tqWEtQcHpiQ1dzSGhhTmhOOG82SGZqNzB3THZlOVQrbTB5dXoz?=
 =?gb2312?B?RFd4Q2VUZktsL05IaG9JNTJoNlNvK0xaVG1DNnBYbnhQZHQ0RHZYUkRrMncr?=
 =?gb2312?B?YWVHQjV2MUlhMHJnVmZYYmwwbDAyR3R2SDUxdHkwUUNHdHZ6ZHFnYVhUQXBx?=
 =?gb2312?B?bUt2d3hpd3lheGdQQzZEenR2azVxQUVqMnhYc3V1SU55Z0VSMGxJN1BtVkVF?=
 =?gb2312?B?Z0VRNkxRZWdjZytpU2QvbUdicGNPMVoyNk5BSnJrMm9waVZqaFdTbTRsZFAr?=
 =?gb2312?B?MCsreWFCN0tobUMvQWtlVzF4ZEh3ZHdsUXlmcjk0OFZiaWY5RG4zT3dVNThQ?=
 =?gb2312?Q?NahzSBknkz+hJRoruo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3388845-5d35-4056-1a8d-08d8de091137
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 05:56:19.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHwob1JLusCNXt4/hzRQBX7jwBYuwdi1+HA12QDmYYVZ+WwlwDTzTiU3tzkbwZ0ze6Sk/vo823fg8GdHhnDqMuqpG1YXI1tXE1u/YzEjibE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3301
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVGVqdW4KClBsZWFzZSByZXZpZXcgdGhpcyBjaGFuZ2UuCgpUaGFua3MKUWlhbmcKCj5f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj63orz+yMs6IFpoYW5nLCBR
aWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KPreiy83KsbzkOiAyMDIxxOoy1MIxOMjV
IDExOjE3Cj7K1bz+yMs6IGppYW5nc2hhbmxhaUBnbWFpbC5jb207IHRqQGtlcm5lbC5vcmcKPrOt
y806IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPtb3zOI6IFtQQVRDSCB2Ml0gd29ya3F1
ZXVlOiBNb3ZlIHRoZSBwb3NpdGlvbiBvZiA+ZGVidWdfd29ya19hY3RpdmF0ZSgpIGluIF9fcXVl
dWVfd29yaygpCj4KPkZyb206IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KPgo+
VGhlIGRlYnVnX3dvcmtfYWN0aXZhdGUoKSBpcyBjYWxsZWQgb24gdGhlIHByZW1pc2UgdGhhdAo+
dGhlIHdvcmsgY2FuIGJlIGluc2VydGVkLCBiZWNhdXNlIGlmIHdxIGJlIGluIFdRX0RSQUlOSU5H
Cj5zdGF0dXMsIGluc2VydCB3b3JrIG1heSBiZSBmYWlsZWQuCj4KPkZpeGVzOiBlNDFlNzA0YmM0
ZjQgKCJ3b3JrcXVldWU6IGltcHJvdmUgZGVzdHJveV93b3JrcXVldWUoKSA+ZGVidWdnYWJpbGl0
eSIpCj5TaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+Cj5S
ZXZpZXdlZC1ieTogTGFpIEppYW5nc2hhbiA8amlhbmdzaGFubGFpQGdtYWlsLmNvbT4KPi0tLQo+
djEtPnYyOgo+IGFkZCBGaXhlcyB0YWcuCj4KPiBrZXJuZWwvd29ya3F1ZXVlLmMgfCAyICstCj4g
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPmRpZmYgLS1n
aXQgYS9rZXJuZWwvd29ya3F1ZXVlLmMgYi9rZXJuZWwvd29ya3F1ZXVlLmMKPmluZGV4IDBkMTUw
ZGEyNTJlOC4uMjFmYjAwYjUyZGVmIDEwMDY0NAo+LS0tIGEva2VybmVsL3dvcmtxdWV1ZS5jCj4r
KysgYi9rZXJuZWwvd29ya3F1ZXVlLmMKPkBAIC0xNDEyLDcgKzE0MTIsNiBAQCBzdGF0aWMgdm9p
ZCBfX3F1ZXVlX3dvcmsoaW50IGNwdSwgc3RydWN0ID53b3JrcXVldWVfc3RydWN0ICp3cSwKPiAg
ICAgICAgICovCj4gICAgICAgIGxvY2tkZXBfYXNzZXJ0X2lycXNfZGlzYWJsZWQoKTsKPgo+LSAg
ICAgICBkZWJ1Z193b3JrX2FjdGl2YXRlKHdvcmspOwo+Cj4gICAgICAgIC8qIGlmIGRyYWluaW5n
LCBvbmx5IHdvcmtzIGZyb20gdGhlIHNhbWUgd29ya3F1ZXVlIGFyZSBhbGxvd2VkID4qLwo+ICAg
ICAgIGlmICh1bmxpa2VseSh3cS0+ZmxhZ3MgJiBfX1dRX0RSQUlOSU5HKSAmJgo+QEAgLTE0OTQs
NiArMTQ5Myw3IEBAIHN0YXRpYyB2b2lkIF9fcXVldWVfd29yayhpbnQgY3B1LCBzdHJ1Y3QgPndv
cmtxdWV1ZV9zdHJ1Y3QgKndxLAo+ICAgICAgICAgICAgICAgIHdvcmtsaXN0ID0gJnB3cS0+ZGVs
YXllZF93b3JrczsKPiAgICAgICAgfQo+Cj4rICAgICAgIGRlYnVnX3dvcmtfYWN0aXZhdGUod29y
ayk7Cj4gICAgICAgIGluc2VydF93b3JrKHB3cSwgd29yaywgd29ya2xpc3QsIHdvcmtfZmxhZ3Mp
Owo+Cj4gb3V0Ogo+LS0KPjIuMjUuMQoK
