Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4E38E69D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhEXMb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhEXMbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:31:55 -0400
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 May 2021 05:30:26 PDT
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4DE3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:30:26 -0700 (PDT)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 810225E9B3;
        Mon, 24 May 2021 14:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1621858856;
        bh=oAEP7Bx2kRgmVjQH+ibDkqNcf1DVDndBjF/hRNk5XtU=;
        h=From:To:CC:Subject:Date:From;
        b=KKsHz/E6wWc/yBxnFOXPdK8snYAW0oPS45Jm02uxu9TIXRYHKCmdmYlOzgf6Fo+Ru
         XrybAT6BCxsSYrctA2FuMCOxSGC0xt1Jg8pMOjJTcg3vq3QFIV1pvvel3BhImp+YAc
         4RqKLRwds9HMaQ4rof4nyW/YaHRvlD/p3KMP+gTPCEVPULRropMiCg8Wsiye6ytUfB
         5uupIx+wD47hGucM3Y0hi+BtYvIU+KcRwKjUpoTSRbNTANWXi77Quvpo0iwVJ5iboy
         pZuGT1PiOMg/eaPJttsbxb4gqDyL9LFMLBICeLXiUqV1VM1i1UUgaQ78IgBTAEX7Ok
         igMtP+6iXOgLA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Mon, 24 May 2021 14:20:39 +0200
Received: from DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579]) by
 DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579%6]) with mapi id
 15.02.0858.012; Mon, 24 May 2021 14:20:39 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        kernel <kernel@dh-electronics.com>
Subject: RE: [PATCH] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM DRC02
 boards [Klartext]
Thread-Topic: [PATCH] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM DRC02
 boards [Klartext]
Thread-Index: AddQlvQ3s4HwqoC/Q+OS4TW/MyA42Q==
Date:   Mon, 24 May 2021 12:20:39 +0000
Message-ID: <9282a98aad9a4f8585b7dae5679b0e2b@dh-electronics.com>
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

RnJvbTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyIDxjbmllZGVybWFpZXJAZGgtZWxlY3Ryb25pY3Mu
Y29tPg0KU2VudDogTW9uZGF5LCBNYXkgMjQsIDIwMjEgMjowNCBQTQ0KPiANCj4gQWRkIERIIGVs
ZWN0cm9uaWNzIERIQ09NIFBpY29JVFggYW5kIERIQ09NIERSQzAyIGJvYXJkcy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0
cm9uaWNzLmNvbT4NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogcm9iaCtkdEBrZXJuZWwu
b3JnDQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IENjOiBrZXJuZWxA
ZGgtZWxlY3Ryb25pY3MuY29tDQo+IFRvOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiAt
LS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwgfCAx
MyArKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNs
LnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1s
DQo+IGluZGV4IGZjZTJhODY3MGI0OS4uYWZiZGVhMDc4YWJiIDEwMDY0NA0KPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQo+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCj4gQEAgLTQwNyw2ICs0
MDcsMTIgQEAgcHJvcGVydGllczoNCj4gICAgICAgICAgICAtIGNvbnN0OiBkZmksZnM3MDBlLW02
MA0KPiAgICAgICAgICAgIC0gY29uc3Q6IGZzbCxpbXg2ZGwNCj4gDQo+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiBpLk1YNkRMIERIQ09NIFBpY29JVFggQm9hcmQNCj4gKyAgICAgICAgaXRlbXM6DQo+
ICsgICAgICAgICAgLSBjb25zdDogZGgsaW14NmRsLWRoY29tLXBpY29pdHgNCj4gKyAgICAgICAg
ICAtIGNvbnN0OiBkaCxpbXg2ZGwtZGhjb20tc29tDQo+ICsgICAgICAgICAgLSBjb25zdDogZnNs
LGlteDZkbA0KPiArDQo+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBpLk1YNkRMIEdhdGV3b3JrcyBW
ZW50YW5hIEJvYXJkcw0KPiAgICAgICAgICBpdGVtczoNCj4gICAgICAgICAgICAtIGVudW06DQo+
IEBAIC00NTgsNiArNDY0LDEzIEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAgICAgLSBjb25zdDog
dG9yYWRleCxjb2xpYnJpX2lteDZkbCAgICAgICAgICAjIENvbGlicmkgaU1YNiBNb2R1bGUNCj4g
ICAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14NmRsDQo+IA0KPiArICAgICAgLSBkZXNjcmlwdGlv
bjogaS5NWDZTIERIQ09NIERSQzAyIEJvYXJkDQo+ICsgICAgICAgIGl0ZW1zOg0KPiArICAgICAg
ICAgIC0gY29uc3Q6IGRoLGlteDZzLWRoY29tLWRyYzAyDQo+ICsgICAgICAgICAgLSBjb25zdDog
ZGgsaW14NnMtZGhjb20tc29tDQo+ICsgICAgICAgICAgLSBjb25zdDogZnNsLGlteDZzDQo+ICsg
ICAgICAgICAgLSBjb25zdDogZnNsLGlteDZkbA0KPiArDQo+ICAgICAgICAtIGRlc2NyaXB0aW9u
OiBpLk1YNlNMIGJhc2VkIEJvYXJkcw0KPiAgICAgICAgICBpdGVtczoNCj4gICAgICAgICAgICAt
IGVudW06DQo+IC0tDQo+IDIuMTEuMA0KDQpJZ25vcmUgdGhpcyBvbmUsIGJlY2F1c2UgdGhlIHJl
Y2lwaWVudCBpcyB3cm9uZyENCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
