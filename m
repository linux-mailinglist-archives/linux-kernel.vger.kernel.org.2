Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265DA4370BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 06:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhJVETx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 00:19:53 -0400
Received: from mx24.baidu.com ([111.206.215.185]:41408 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhJVETw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 00:19:52 -0400
Received: from BJHW-Mail-Ex13.internal.baidu.com (unknown [10.127.64.36])
        by Forcepoint Email with ESMTPS id F00EA967357571ED5FB3;
        Fri, 22 Oct 2021 12:17:33 +0800 (CST)
Received: from BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) by
 BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 22 Oct 2021 12:17:33 +0800
Received: from BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) by
 BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) with mapi id
 15.01.2308.014; Fri, 22 Oct 2021 12:17:33 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBzY2hlZC9jb3JlOiByZXR1cm4gcHJpb19sZXNzKCkg?=
 =?gb2312?B?ZGlyZWN0bHkgaW4gX19zY2hlZF9jb3JlX2xlc3M=?=
Thread-Topic: [PATCH] sched/core: return prio_less() directly in
 __sched_core_less
Thread-Index: AQHXmNF+Dv1QkQ3o702Af16VSoU8Davexbew
Date:   Fri, 22 Oct 2021 04:17:33 +0000
Message-ID: <720137bdc33749a49b00ecb412d954da@baidu.com>
References: <1629800356-45550-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1629800356-45550-1-git-send-email-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.206.4]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex13_2021-10-22 12:17:33:981
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZw0KDQotTGkNCg0KPiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBMaSxSb25ncWlu
ZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ILeiy83KsbzkOiAyMDIxxOo41MIyNMjVIDE4OjE5
DQo+IMrVvP7IyzogbWluZ29AcmVkaGF0LmNvbTsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGp1cmku
bGVsbGlAcmVkaGF0LmNvbTsNCj4gdmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpLFJvbmdxaW5nDQo+IDxsaXJvbmdxaW5nQGJhaWR1LmNv
bT4NCj4g1vfM4jogW1BBVENIXSBzY2hlZC9jb3JlOiByZXR1cm4gcHJpb19sZXNzKCkgZGlyZWN0
bHkgaW4gX19zY2hlZF9jb3JlX2xlc3MNCj4gDQo+IHJldHVybiBwcmlvX2xlc3MoKSBkaXJlY3Rs
eSB0byBhdm9pZCB1bm5lY2Vzc2FyeSBjaGVja2luZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGkg
Um9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiAtLS0NCj4gIGtlcm5lbC9zY2hlZC9j
b3JlLmMgfCAgICA1ICstLS0tDQo+ICAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvY29yZS5jIGIv
a2VybmVsL3NjaGVkL2NvcmUuYyBpbmRleCAyZDlmZjQwLi43MzQ3OGM5DQo+IDEwMDY0NA0KPiAt
LS0gYS9rZXJuZWwvc2NoZWQvY29yZS5jDQo+ICsrKyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMNCj4g
QEAgLTE0MCwxMCArMTQwLDcgQEAgc3RhdGljIGlubGluZSBib29sIF9fc2NoZWRfY29yZV9sZXNz
KHN0cnVjdCB0YXNrX3N0cnVjdA0KPiAqYSwgc3RydWN0IHRhc2tfc3RydWN0ICoNCj4gIAkJcmV0
dXJuIGZhbHNlOw0KPiANCj4gIAkvKiBmbGlwIHByaW8sIHNvIGhpZ2ggcHJpbyBpcyBsZWZ0bW9z
dCAqLw0KPiAtCWlmIChwcmlvX2xlc3MoYiwgYSwgdGFza19ycShhKS0+Y29yZS0+Y29yZV9mb3Jj
ZWlkbGUpKQ0KPiAtCQlyZXR1cm4gdHJ1ZTsNCj4gLQ0KPiAtCXJldHVybiBmYWxzZTsNCj4gKwly
ZXR1cm4gcHJpb19sZXNzKGIsIGEsIHRhc2tfcnEoYSktPmNvcmUtPmNvcmVfZm9yY2VpZGxlKTsN
Cj4gIH0NCj4gDQo+ICAjZGVmaW5lIF9fbm9kZV8yX3NjKG5vZGUpIHJiX2VudHJ5KChub2RlKSwg
c3RydWN0IHRhc2tfc3RydWN0LCBjb3JlX25vZGUpDQo+IC0tDQo+IDEuNy4xDQoNCg==
