Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9837447CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbhKHJgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:36:43 -0500
Received: from mx2.tq-group.com ([93.104.207.82]:42810 "EHLO mx2.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235884AbhKHJgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:36:42 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 04:36:41 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636364038; x=1667900038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-id:
   content-transfer-encoding;
  bh=YsIfsjOydbJ7yEJPmixPtzgjosr/9p2WG1NwLYBVfNI=;
  b=UpOxOqpdorvBK3bVXBy9MKQ1zD8BDwwiK4uv+2602XNG+seRS5eHjTRX
   j9SsmZRMIWEaQuKcLGVrM/6AOS9oJEklxb1oowLmyv1uWozH+L4nl+7DU
   aKNF6qHNGZgmwpGQNQJF3lEybPZ/tFTazGmCaxoYZ+LpSytCno7F1+tea
   PQLEo6ztau2cF1f1oADT7ZPLUtCqxxMiBr5hZd/n27Xy8+jwUc4f/ulRU
   FQwA8i0eiNuNkNgDKVSC1KhevFKXZh7Ssmp4H6AbOu0W4we98P/yaCjqq
   t+WfhvCiRIKiG46VBR7JyXiUefrOGPOWQtoB+GlV7cYNddvqI4FCWA4+3
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="1159645"
Received: from unknown (HELO tq-pgp-pr2.tq-net.de) ([192.168.6.18])
  by mx2-pgp.tq-group.com with ESMTP; 08 Nov 2021 10:26:49 +0100
Received: from mx2.tq-group.com ([192.168.6.8])
  by tq-pgp-pr2.tq-net.de (PGP Universal service);
  Mon, 08 Nov 2021 10:26:49 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr2.tq-net.de on Mon, 08 Nov 2021 10:26:49 +0100
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="1159644"
Received: from vmail01.tq-net.de ([10.150.72.11])
  by mx2.tq-group.com with ESMTP; 08 Nov 2021 10:26:49 +0100
Received: from vmail01.tq-net.de (10.150.72.11) by vmail01.tq-net.de
 (10.150.72.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 8 Nov
 2021 10:26:49 +0100
Received: from vmail01.tq-net.de ([10.150.72.11]) by vmail01.tq-net.de
 ([10.150.72.11]) with mapi id 15.01.2308.015; Mon, 8 Nov 2021 10:26:49 +0100
From:   "Stein, Alexander" <Alexander.Stein@tq-group.com>
To:     "p.yadav@ti.com" <p.yadav@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: (EXT) [PATCH 1/2] mtd: spi-nor: Fix shift-out-of-bounds
Thread-Topic: (EXT) [PATCH 1/2] mtd: spi-nor: Fix shift-out-of-bounds
Thread-Index: AQHX0uPOpq2SCHKAhUucvM9nE2hnpqv5TviA
Date:   Mon, 8 Nov 2021 09:26:49 +0000
Message-ID: <5f104ec3b6ad492212105ad59ba135ff8ed2cd0d.camel@tq-group.com>
References: <20211106075616.95401-1-tudor.ambarus@microchip.com>
         <20211106075616.95401-2-tudor.ambarus@microchip.com>
In-Reply-To: <20211106075616.95401-2-tudor.ambarus@microchip.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.150.72.21]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <578596A275E6EF4698090A05E2C24D9E@tq-group.com>
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkFtIFNhbXN0YWcsIGRlbSAwNi4xMS4yMDIxIHVtIDA5OjU2ICswMjAwIHNjaHJpZWIgVHVk
b3IgQW1iYXJ1czoNCj4gV2hlbiBwYXJpbmcgU0ZEUCB3ZSBtYXkgY2hvb3NlIHRvIG1hc2sgb3V0
IGFuIGVyYXNlIHR5cGUsIHBhc3NpbmcNCj4gYW4gZXJhc2Ugc2l6ZSBvZiB6ZXJvIHRvIHNwaV9u
b3Jfc2V0X2VyYXNlX3R5cGUoKS4NCj4gRml4IHNoaWZ0LW91dC1vZi1ib3VuZHMgYW5kIGp1c3Qg
Y2xlYXIgdGhlIGVyYXNlIHBhcmFtcyB3aGVuDQo+IHBhc3NpbmcgemVybyBmb3IgZXJhc2Ugc2l6
ZS4NCj4gV2hpbGUgaGVyZSBhdm9pZCBhIHN1cGVyZmx1b3VzIGRlcmVmZXJlbmNlIGFuZCB1c2Ug
J3NpemUnIGRpcmVjdGx5Lg0KPiANCj4gVUJTQU46IHNoaWZ0LW91dC1vZi1ib3VuZHMgaW4gZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmM6MjIzNzoyNA0KPiBzaGlmdCBleHBvbmVudCA0Mjk0OTY3
Mjk1IGlzIHRvbyBsYXJnZSBmb3IgMzItYml0IHR5cGUgJ2ludCcNCj4gDQo+IEZpeGVzOiA1Mzkw
YThkZjc2OWUgKCJtdGQ6IHNwaS1ub3I6IGFkZCBzdXBwb3J0IHRvIG5vbi11bmlmb3JtIFNGRFAN
Cj4gU1BJIE5PUiBmbGFzaCBtZW1vcmllcyIpDQo+IFJlcG9ydGVkLWJ5OiBBbGV4YW5kZXIgU3Rl
aW4gPA0KPiBBbGV4YW5kZXIuU3RlaW5AdHEtZ3JvdXAuY29tDQo+ID4NCj4gU2lnbmVkLW9mZi1i
eTogVHVkb3IgQW1iYXJ1cyA8DQo+IHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbQ0KPiA+DQo+
IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCA5ICsrKysrKystLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jDQo+IGluZGV4IDNkOTdjMTg5YzMzMi4uYTFiNWQ1NDMyZjQxIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9y
L2NvcmUuYw0KPiBAQCAtMjIzMCw4ICsyMjMwLDEzIEBAIHZvaWQgc3BpX25vcl9zZXRfZXJhc2Vf
dHlwZShzdHJ1Y3QNCj4gc3BpX25vcl9lcmFzZV90eXBlICplcmFzZSwgdTMyIHNpemUsDQo+ICAJ
ZXJhc2UtPnNpemUgPSBzaXplOw0KPiAgCWVyYXNlLT5vcGNvZGUgPSBvcGNvZGU7DQo+ICAJLyog
SkVERUMgSkVTRDIxNkIgU3RhbmRhcmQgaW1wb3NlcyBlcmFzZSBzaXplcyB0byBiZSBwb3dlciBv
Zg0KPiAyLiAqLw0KPiAtCWVyYXNlLT5zaXplX3NoaWZ0ID0gZmZzKGVyYXNlLT5zaXplKSAtIDE7
DQo+IC0JZXJhc2UtPnNpemVfbWFzayA9ICgxIDw8IGVyYXNlLT5zaXplX3NoaWZ0KSAtIDE7DQo+
ICsJaWYgKHNpemUpIHsNCj4gKwkJZXJhc2UtPnNpemVfc2hpZnQgPSBmZnMoc2l6ZSkgLSAxOw0K
PiArCQllcmFzZS0+c2l6ZV9tYXNrID0gKDEgPDwgZXJhc2UtPnNpemVfc2hpZnQpIC0gMTsNCj4g
Kwl9IGVsc2Ugew0KPiArCQllcmFzZS0+c2l6ZV9zaGlmdCA9IDA7DQo+ICsJCWVyYXNlLT5zaXpl
X21hc2sgPSAwOw0KPiArCX0NCj4gIH0NCj4gIA0KPiAgLyoqDQoNClRlc3RlZC1CeTogQWxleGFu
ZGVyIFN0ZWluIDxBbGV4YW5kZXIuU3RlaW5AdHEtZ3JvdXAuY29tPg0KDQpJdCBmaXhlcyB0aGUg
VUJTQU4gZXJyb3IgYW5kIG15IHNwaS1ub3IgZmxhc2ggY2FuIHN0aWxsIGJlIGRldGVjdGVkLg0K
DQpCZXN0IHJlZ2FyZHMsDQpBbGV4YW5kZXINCg0K
