Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA963A9905
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhFPLXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhFPLXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:23:31 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C40C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1623842378;
        bh=C1Voj2chiPoqhhte2ZbJcFpUi5azCaqVTcaFP8tmZfU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=N7zROu4A6SiGjxj0r8LxdvvRiMgx8aPRgw41ksDWoDyS5XtwlQh8T9r8oV/VNqQqe
         NyBbUos4j/juRMvqfL62D8SRn9KNoFPxj6+/OXBk9zPhCNmOSFy5wBGipbAebNZRWo
         V7b4Ex+RO9dMF+oKxZbPHZp6ZcD1j4ywoYqvRZnjcvNXtaiz9OgUzvQrQtxmWCsDi4
         Ih0AQbuMPSv/3jvkMVF+/acukTwKIk2lRAf0bjOAt0CIVwfopyas3lb4zVwSupQOl8
         xHuxhRak6CKNc7ADAbc7CUj6G/7FZZYoRJgqD69TLTUlPIlZCjJjlO4/kimm8LSoQ0
         wcfAVk/WvcU/g==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        kernel <kernel@dh-electronics.com>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Thread-Topic: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Thread-Index: AQHXUXKxVloH3v/6CkGMRLXBETQyyKsBDI+AgBWQzrA=
Date:   Wed, 16 Jun 2021 11:19:28 +0000
Message-ID: <b765351a7c3542d2a66ab1168f1ff222@dh-electronics.com>
References: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
 <20210602195009.GA3870858@robh.at.kernel.org>
In-Reply-To: <20210602195009.GA3870858@robh.at.kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VuZCByZXBseSBhbHNvIHRvIFJvYiBIZXJyaW5ncyArZHQgZW1haWwgYWRkcmVzczoNCg0KRnJv
bTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NClNlbnQ6IFdlZG5lc2RheSwgSnVuZSAy
LCAyMDIxIDk6NTAgUE0NCg0KPiBPbiBUdWUsIE1heSAyNSwgMjAyMSBhdCAwNDozMDowMVBNICsw
MjAwLCBDaHJpc3RvcGggTmllZGVybWFpZXIgd3JvdGU6DQo+PiBBZGQgREggZWxlY3Ryb25pY3Mg
REhDT00gUGljb0lUWCBhbmQgREhDT00gRFJDMDIgYm9hcmRzLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNzLmNv
bT4NCj4+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+PiBDYzogcm9iaCtkdEBrZXJuZWwub3JnDQo+
PiBDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPj4gQ2M6IGtlcm5lbEBkaC1l
bGVjdHJvbmljcy5jb20NCj4+IFRvOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPj4gLS0t
DQo+PiBWMjogUmVtb3ZlIGxpbmUgd2l0aCBmc2wsaW14NnMgb24gdGhlIERSQzAyIEJvYXJkDQo+
PiAtLS0NCj4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1s
IHwgMTIgKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9mc2wueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlh
bWwNCj4+IGluZGV4IGZjZTJhODY3MGI0OS4uM2M0ZmY3OWEzYmU3IDEwMDY0NA0KPj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPj4gQEAgLTQw
Nyw2ICs0MDcsMTIgQEAgcHJvcGVydGllczoNCj4+ICAgICAgICAgICAgLSBjb25zdDogZGZpLGZz
NzAwZS1tNjANCj4+ICAgICAgICAgICAgLSBjb25zdDogZnNsLGlteDZkbA0KPj4NCj4+ICsgICAg
ICAtIGRlc2NyaXB0aW9uOiBpLk1YNkRMIERIQ09NIFBpY29JVFggQm9hcmQNCj4+ICsgICAgICAg
IGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBkaCxpbXg2ZGwtZGhjb20tcGljb2l0eA0K
Pj4gKyAgICAgICAgICAtIGNvbnN0OiBkaCxpbXg2ZGwtZGhjb20tc29tDQo+PiArICAgICAgICAg
IC0gY29uc3Q6IGZzbCxpbXg2ZGwNCj4+ICsNCj4+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBpLk1Y
NkRMIEdhdGV3b3JrcyBWZW50YW5hIEJvYXJkcw0KPj4gICAgICAgICAgaXRlbXM6DQo+PiAgICAg
ICAgICAgIC0gZW51bToNCj4+IEBAIC00NTgsNiArNDY0LDEyIEBAIHByb3BlcnRpZXM6DQo+PiAg
ICAgICAgICAgIC0gY29uc3Q6IHRvcmFkZXgsY29saWJyaV9pbXg2ZGwgICAgICAgICAgIyBDb2xp
YnJpIGlNWDYgTW9kdWxlDQo+PiAgICAgICAgICAgIC0gY29uc3Q6IGZzbCxpbXg2ZGwNCj4+DQo+
PiArICAgICAgLSBkZXNjcmlwdGlvbjogaS5NWDZTIERIQ09NIERSQzAyIEJvYXJkDQo+PiArICAg
ICAgICBpdGVtczoNCj4+ICsgICAgICAgICAgLSBjb25zdDogZGgsaW14NnMtZGhjb20tZHJjMDIN
Cj4+ICsgICAgICAgICAgLSBjb25zdDogZGgsaW14NnMtZGhjb20tc29tDQo+PiArICAgICAgICAg
IC0gY29uc3Q6IGZzbCxpbXg2ZGwNCj4gDQo+IGZzbCxpbXg2cz8NCg0KSW4gdGhlIGZpcnN0IHZl
cnNpb24gSSBoYWQgaGVyZSBhbiBhZGRpdGlvbmFsIGxpbmUgd2l0aCAiZnNsLGlteDZzIiwNCmJ1
dCBjdXJyZW50bHkgdGhlIGtlcm5lbCBpc24ndCBzdXBwb3J0aW5nIHRoYXQgY29tcGF0aWJsZS4g
VGhlIGkuTVg2DQpTb2xvIGlzIGN1cnJlbnRseSBzdXBwb3J0ZWQgYnkgImZzbCxpbXg2ZGwiLiBT
byBteSBpZGVhIHdhcyB0byBhZGQNCmJvdGggImZzbCxpbXg2ZGwiIGFuZCAiZnNsLGlteDZzIiB0
byBtYXRjaCBpdCBtYXliZSBvbiBhIGxhdGVyIGtlcm5lbA0KdmVyc2lvbi4gSWYgdGhlcmUgaXMg
bm8gbWF0Y2ggd2l0aCB0aGUgU29sbyBub3csIGl0IHdpbGwgZmFsbCBiYWNrIHRvDQp0aGUgaS5N
WDYgRHVhbExpdGUuIFRoYXQgaXMgd2h5IEkgaGFkIGJvdGggZnNsLGlteDZzIGFuZCBmc2wsaW14
NmRsDQppbiB0aGF0IG9yZGVyLiBPbiBGYWJpbydzIGFkdmljZSwgSSByZW1vdmVkIHRoZSBsaW5l
IHdpdGggImZzbCxpbXg2cyINCmluIHZlcnNpb24gMi4NCklzIHRoaXMgd2hhdCB5b3UgbWVhbnQg
YnkgeW91ciBjb21tZW50Pw0KDQo+IA0KPj4gKw0KPj4gICAgICAgIC0gZGVzY3JpcHRpb246IGku
TVg2U0wgYmFzZWQgQm9hcmRzDQo+PiAgICAgICAgICBpdGVtczoNCj4+ICAgICAgICAgICAgLSBl
bnVtOg0KPj4gLS0NCj4+IDIuMTEuMA0KDQpSZWdhcmRzDQpDaHJpc3RvcGgNCg==
