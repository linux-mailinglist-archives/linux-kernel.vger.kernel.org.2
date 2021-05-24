Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E822438F5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhEXWlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEXWlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:41:49 -0400
X-Greylist: delayed 37745 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 May 2021 15:40:20 PDT
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9F2AC061574;
        Mon, 24 May 2021 15:40:20 -0700 (PDT)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id F244B5DDF7;
        Tue, 25 May 2021 00:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1621895942;
        bh=xwD6Nrkylw4njEWCELAKyW9hzOGunu13drEcZOsC9Fw=;
        h=From:To:CC:Subject:Date:From;
        b=bw2WaAFqGziWDIFf2XbPvye7NJp1o/WHer8P6uHuEamrYNw18EbE1Fad/Y8qs4mTE
         5tTPm7aGoGFh3YAGve8TGAtL8OaQ51P0PRyZMdY2Df/m3VgZ1MDL4DGfFn4c9JFHxY
         H7Hk+5o8/fcaWKQOdPC6wB7C3Nx1lKlhFQ5afZBGtKLWO1eyN2aGZYmBVZ3jSXhL2X
         vLCY0MUZHkHU+841FISOhFgSmF2z0K4DURlaKmP7CnyRWlAb1jkQdEWYeCS7KS7JsV
         2DpLqor7t804RsJdEGjhpMR9YOAv3fXjsVYkNyr8k450muM4rm8MrwxSqRf5IFmwqs
         ygo9bHncYnA0A==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Tue, 25 May 2021 00:38:49 +0200
Received: from DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579]) by
 DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579%6]) with mapi id
 15.02.0858.012; Tue, 25 May 2021 00:38:49 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     'Fabio Estevam' <festevam@gmail.com>
CC:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        kernel <kernel@dh-electronics.com>
Subject: RE: [PATCH] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM DRC02
 boards [Klartext]
Thread-Topic: [PATCH] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM DRC02
 boards [Klartext]
Thread-Index: AddQ7WhkHZZwXTrRQNCfV75QCGvecw==
Date:   Mon, 24 May 2021 22:38:49 +0000
Message-ID: <4964298a8d264dafaa807c43bab5d174@dh-electronics.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.2.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KU2VudDogTW9uZGF5LCBN
YXkgMjQsIDIwMjEgMzowMyBQTQ0KPiANCj4gSGkgQ2hyaXN0b3BoLA0KPg0KDQpIaSBGYWJpbywN
Cg0KPiANCj4gT24gTW9uLCBNYXkgMjQsIDIwMjEgYXQgOToxNyBBTSBDaHJpc3RvcGggTmllZGVy
bWFpZXINCj4gPGNuaWVkZXJtYWllckBkaC1lbGVjdHJvbmljcy5jb20+IHdyb3RlOg0KPiANCj4+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBpLk1YNlMgREhDT00gRFJDMDIgQm9hcmQNCj4+ICsgICAg
ICAgIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBkaCxpbXg2cy1kaGNvbS1kcmMwMg0K
Pj4gKyAgICAgICAgICAtIGNvbnN0OiBkaCxpbXg2cy1kaGNvbS1zb20NCj4+ICsgICAgICAgICAg
LSBjb25zdDogZnNsLGlteDZzDQo+IA0KPiBXZSBkb24ndCBoYXZlIGFuIGZzbCxpbXg2cyBjb21w
YXRpYmxlIGZvciB0aGUgaS5NWDYgU29sbyB2YXJpYW50LiBXZQ0KPiBqdXN0IHVzZSBmc2wsaW14
NmRsIGluc3RlYWQuDQoNCk15IHRob3VnaHQgd2FzIHRvIGJlIGZ1dHVyZSBwcm9vZi4gSWYgdGhl
cmUgaXMgbm8gbWF0Y2ggd2l0aCB0aGUgU29sbyBub3csDQppdCB3aWxsIGZhbGwgYmFjayB0byB0
aGUgaS5NWDYgRHVhbExpdGUuIFRoYXQgaXMgd2h5IEkgYWRkZWQgYm90aCBmc2wsaW14NnMNCmFu
ZCBmc2wsaW14NmRsIGluIHRoaXMgb3JkZXIuDQoNClNob3VsZCBJIHJlbW92ZSB0aGUgbGluZSB3
aXRoIGZzbCxpbXg2cz8NCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
