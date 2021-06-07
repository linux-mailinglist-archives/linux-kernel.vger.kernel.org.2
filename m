Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ECA39D8C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFGJcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:32:19 -0400
Received: from mx4.securetransport.de ([178.254.6.145]:47804 "EHLO
        mx4.securetransport.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:32:17 -0400
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 21C407201B4;
        Mon,  7 Jun 2021 11:29:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1623058189;
        bh=+6auGPbZCtv9tPU3eCRXafqXv4hPgEKs0lCgziJNTEk=;
        h=From:To:CC:Subject:Date:From;
        b=f3zymEuTbyQmz1pIkabgo1HrBqQ9dXuuUvOTteYbZ6eGW6FQ/QQqi3o5Acldh6fsP
         3QCjA6IVlSIv4hBdbSLJxA3BcP4S1Rr1RbAMOJYwKSkOT38HmUdGt8QwSgf92iYuU8
         q+MlDRQUhZ6dMgY3CjIvvXDKSSQrM/H66cxSyw400Ryh0dB+MJd+Fkxlosmo3DDVjd
         7uQe0Vb7bz8gKIs+5DZCSQDMMKOZMYtrnFM/R9d0FG8XvqfKOwvA1oZ3aWMgZ784DR
         JdrTTJoCzSF9hx0NGs434j/IfiuZ+QJEmapo73ovC8o/EYQATIIVfrA25lraxzaupT
         J/WoAo6a95yvQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Mon, 7 Jun 2021 11:29:36 +0200
Received: from DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579]) by
 DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579%6]) with mapi id
 15.02.0858.012; Mon, 7 Jun 2021 11:29:36 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     'Rob Herring' <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        kernel <kernel@dh-electronics.com>,
        'Fabio Estevam' <festevam@gmail.com>
Subject: RE: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards [Klartext]
Thread-Topic: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards [Klartext]
Thread-Index: AddbfDo8Ks0G0YHCRbyJey/zlL/7Ig==
Date:   Mon, 7 Jun 2021 09:29:36 +0000
Message-ID: <fb1e21a4a27948d08f960b24dc5dbe54@dh-electronics.com>
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

RnJvbTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NClNlbnQ6IFdlZG5lc2RheSwgSnVu
ZSAyLCAyMDIxIDk6NTAgUE0NCg0KPiBPbiBUdWUsIE1heSAyNSwgMjAyMSBhdCAwNDozMDowMVBN
ICswMjAwLCBDaHJpc3RvcGggTmllZGVybWFpZXIgd3JvdGU6DQo+PiBBZGQgREggZWxlY3Ryb25p
Y3MgREhDT00gUGljb0lUWCBhbmQgREhDT00gRFJDMDIgYm9hcmRzLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNz
LmNvbT4NCj4+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+IENj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+PiBDYzogcm9iaCtkdEBrZXJuZWwub3Jn
DQo+PiBDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPj4gQ2M6IGtlcm5lbEBk
aC1lbGVjdHJvbmljcy5jb20NCj4+IFRvOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPj4g
LS0tDQo+PiBWMjogUmVtb3ZlIGxpbmUgd2l0aCBmc2wsaW14NnMgb24gdGhlIERSQzAyIEJvYXJk
DQo+PiAtLS0NCj4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55
YW1sIHwgMTIgKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9mc2wueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNs
LnlhbWwNCj4+IGluZGV4IGZjZTJhODY3MGI0OS4uM2M0ZmY3OWEzYmU3IDEwMDY0NA0KPj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPj4gQEAg
LTQwNyw2ICs0MDcsMTIgQEAgcHJvcGVydGllczoNCj4+ICAgICAgICAgICAgLSBjb25zdDogZGZp
LGZzNzAwZS1tNjANCj4+ICAgICAgICAgICAgLSBjb25zdDogZnNsLGlteDZkbA0KPj4NCj4+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBpLk1YNkRMIERIQ09NIFBpY29JVFggQm9hcmQNCj4+ICsgICAg
ICAgIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBkaCxpbXg2ZGwtZGhjb20tcGljb2l0
eA0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBkaCxpbXg2ZGwtZGhjb20tc29tDQo+PiArICAgICAg
ICAgIC0gY29uc3Q6IGZzbCxpbXg2ZGwNCj4+ICsNCj4+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBp
Lk1YNkRMIEdhdGV3b3JrcyBWZW50YW5hIEJvYXJkcw0KPj4gICAgICAgICAgaXRlbXM6DQo+PiAg
ICAgICAgICAgIC0gZW51bToNCj4+IEBAIC00NTgsNiArNDY0LDEyIEBAIHByb3BlcnRpZXM6DQo+
PiAgICAgICAgICAgIC0gY29uc3Q6IHRvcmFkZXgsY29saWJyaV9pbXg2ZGwgICAgICAgICAgIyBD
b2xpYnJpIGlNWDYgTW9kdWxlDQo+PiAgICAgICAgICAgIC0gY29uc3Q6IGZzbCxpbXg2ZGwNCj4+
DQo+PiArICAgICAgLSBkZXNjcmlwdGlvbjogaS5NWDZTIERIQ09NIERSQzAyIEJvYXJkDQo+PiAr
ICAgICAgICBpdGVtczoNCj4+ICsgICAgICAgICAgLSBjb25zdDogZGgsaW14NnMtZGhjb20tZHJj
MDINCj4+ICsgICAgICAgICAgLSBjb25zdDogZGgsaW14NnMtZGhjb20tc29tDQo+PiArICAgICAg
ICAgIC0gY29uc3Q6IGZzbCxpbXg2ZGwNCj4gDQo+IGZzbCxpbXg2cz8NCg0KSW4gdGhlIGZpcnN0
IHZlcnNpb24gSSBoYWQgaGVyZSBhbiBhZGRpdGlvbmFsIGxpbmUgd2l0aCAiZnNsLGlteDZzIiwN
CmJ1dCBjdXJyZW50bHkgdGhlIGtlcm5lbCBpc24ndCBzdXBwb3J0aW5nIHRoYXQgY29tcGF0aWJs
ZS4gVGhlIGkuTVg2DQpTb2xvIGlzIGN1cnJlbnRseSBzdXBwb3J0ZWQgYnkgImZzbCxpbXg2ZGwi
LiBTbyBteSBpZGVhIHdhcyB0byBhZGQNCmJvdGggImZzbCxpbXg2ZGwiIGFuZCAiZnNsLGlteDZz
IiB0byBtYXRjaCBpdCBtYXliZSBvbiBhIGxhdGVyIGtlcm5lbA0KdmVyc2lvbi4gSWYgdGhlcmUg
aXMgbm8gbWF0Y2ggd2l0aCB0aGUgU29sbyBub3csIGl0IHdpbGwgZmFsbCBiYWNrIHRvDQp0aGUg
aS5NWDYgRHVhbExpdGUuIFRoYXQgaXMgd2h5IEkgaGFkIGJvdGggZnNsLGlteDZzIGFuZCBmc2ws
aW14NmRsDQppbiB0aGF0IG9yZGVyLiBPbiBGYWJpbydzIGFkdmljZSwgSSByZW1vdmVkIHRoZSBs
aW5lIHdpdGggImZzbCxpbXg2cyINCmluIHZlcnNpb24gMi4NCklzIHRoaXMgd2hhdCB5b3UgbWVh
bnQgYnkgeW91ciBjb21tZW50Pw0KDQo+IA0KPj4gKw0KPj4gICAgICAgIC0gZGVzY3JpcHRpb246
IGkuTVg2U0wgYmFzZWQgQm9hcmRzDQo+PiAgICAgICAgICBpdGVtczoNCj4+ICAgICAgICAgICAg
LSBlbnVtOg0KPj4gLS0NCj4+IDIuMTEuMA0KDQpSZWdhcmRzDQpDaHJpc3RvcGgNCg==
