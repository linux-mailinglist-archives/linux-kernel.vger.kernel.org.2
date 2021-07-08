Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3BE3BF66A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhGHHrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhGHHru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:47:50 -0400
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Jul 2021 00:45:08 PDT
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E3DC061574;
        Thu,  8 Jul 2021 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1625729936;
        bh=I6hrV9gGGh9EWSDwdQa1BFZFmG4AFToJMpRml3fG6Dc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AU54ga3u+1KPt2WRS1GZEwxQ87Vi+X8PzcfJqmogBm4BUwA6ZaVPInEzPtujW/K20
         7LBpuFkJS7DKktk1tvfNcZl+bjU9umP1G2AYsa9QmUcOALuEMZ+lWCXh38ERwpKTly
         kkZ/Gi8eYAfA0LD1yJhS8zgajebf2wpAcymq4zIoCIJOlLeW5a9oomuKTOEvNqxJs/
         r/0tEWgXoqtvDvxldUG1hg2bc1SiEJggO0TMyC2uu1KHQlQhdV8GrtNGL7jFZGAzDv
         Izrww2u2rMpbeC5xdZyQ8SKFe0vwchqlVDgP2vOCff8I3z8I9KJ6ASP3HqbPaRXwf0
         T4yROFouy4aqw==
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
        "festevam@gmail.com" <festevam@gmail.com>,
        "Marek MV. Vasut" <marex@denx.de>
Subject: RE: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Thread-Topic: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Thread-Index: AQHXUXKxVloH3v/6CkGMRLXBETQyyKsBDI+AgBWQzrD//+TigIAicn3w
Date:   Thu, 8 Jul 2021 07:38:44 +0000
Message-ID: <76d6cc846f4f473083e597303956ff11@dh-electronics.com>
References: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
 <20210602195009.GA3870858@robh.at.kernel.org>
 <b765351a7c3542d2a66ab1168f1ff222@dh-electronics.com>
 <bfbd70ca-b5a6-f7a7-4c7d-72ac86874227@denx.de>
In-Reply-To: <bfbd70ca-b5a6-f7a7-4c7d-72ac86874227@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgW21haWx0bzptYXJleEBkZW54LmRlXQ0KU2VudDogV2VkbmVzZGF5
LCBKdW5lIDE2LCAyMDIxIDE6MzMgUE0NCg0KDQo+IE9uIDYvMTYvMjEgMToxOSBQTSwgQ2hyaXN0
b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4gU2VuZCByZXBseSBhbHNvIHRvIFJvYiBIZXJyaW5n
cyArZHQgZW1haWwgYWRkcmVzczoNCj4+DQo+PiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBrZXJu
ZWwub3JnPg0KPj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDIsIDIwMjEgOTo1MCBQTQ0KPj4NCj4+
PiBPbiBUdWUsIE1heSAyNSwgMjAyMSBhdCAwNDozMDowMVBNICswMjAwLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+Pj4+IEFkZCBESCBlbGVjdHJvbmljcyBESENPTSBQaWNvSVRYIGFu
ZCBESENPTSBEUkMwMiBib2FyZHMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9w
aCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNzLmNvbT4NCj4+Pj4gQ2M6
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4+PiBDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPj4+PiBDYzogcm9iaCtkdEBrZXJuZWwub3JnDQo+Pj4+IENj
OiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+Pj4+IENjOiBrZXJuZWxAZGgtZWxl
Y3Ryb25pY3MuY29tDQo+Pj4+IFRvOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPj4+PiAt
LS0NCj4+Pj4gVjI6IFJlbW92ZSBsaW5lIHdpdGggZnNsLGlteDZzIG9uIHRoZSBEUkMwMiBCb2Fy
ZA0KPj4+PiAtLS0NCj4+Pj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L2ZzbC55YW1sIHwgMTIgKysrKysrKysrKysrDQo+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL2ZzbC55YW1sDQo+Pj4+IGluZGV4IGZjZTJhODY3MGI0OS4uM2M0ZmY3OWEzYmU3
IDEwMDY0NA0KPj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L2ZzbC55YW1sDQo+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vZnNsLnlhbWwNCj4+Pj4gQEAgLTQwNyw2ICs0MDcsMTIgQEAgcHJvcGVydGllczoNCj4+Pj4g
ICAgICAgICAgICAgLSBjb25zdDogZGZpLGZzNzAwZS1tNjANCj4+Pj4gICAgICAgICAgICAgLSBj
b25zdDogZnNsLGlteDZkbA0KPj4+Pg0KPj4+PiArICAgICAgLSBkZXNjcmlwdGlvbjogaS5NWDZE
TCBESENPTSBQaWNvSVRYIEJvYXJkDQo+Pj4+ICsgICAgICAgIGl0ZW1zOg0KPj4+PiArICAgICAg
ICAgIC0gY29uc3Q6IGRoLGlteDZkbC1kaGNvbS1waWNvaXR4DQo+Pj4+ICsgICAgICAgICAgLSBj
b25zdDogZGgsaW14NmRsLWRoY29tLXNvbQ0KPj4+PiArICAgICAgICAgIC0gY29uc3Q6IGZzbCxp
bXg2ZGwNCj4+Pj4gKw0KPj4+PiAgICAgICAgIC0gZGVzY3JpcHRpb246IGkuTVg2REwgR2F0ZXdv
cmtzIFZlbnRhbmEgQm9hcmRzDQo+Pj4+ICAgICAgICAgICBpdGVtczoNCj4+Pj4gICAgICAgICAg
ICAgLSBlbnVtOg0KPj4+PiBAQCAtNDU4LDYgKzQ2NCwxMiBAQCBwcm9wZXJ0aWVzOg0KPj4+PiAg
ICAgICAgICAgICAtIGNvbnN0OiB0b3JhZGV4LGNvbGlicmlfaW14NmRsICAgICAgICAgICMgQ29s
aWJyaSBpTVg2IE1vZHVsZQ0KPj4+PiAgICAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14NmRsDQo+
Pj4+DQo+Pj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBpLk1YNlMgREhDT00gRFJDMDIgQm9hcmQN
Cj4+Pj4gKyAgICAgICAgaXRlbXM6DQo+Pj4+ICsgICAgICAgICAgLSBjb25zdDogZGgsaW14NnMt
ZGhjb20tZHJjMDINCj4+Pj4gKyAgICAgICAgICAtIGNvbnN0OiBkaCxpbXg2cy1kaGNvbS1zb20N
Cj4+Pj4gKyAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14NmRsDQo+Pj4NCj4+PiBmc2wsaW14NnM/
DQo+Pg0KPj4gSW4gdGhlIGZpcnN0IHZlcnNpb24gSSBoYWQgaGVyZSBhbiBhZGRpdGlvbmFsIGxp
bmUgd2l0aCAiZnNsLGlteDZzIiwNCj4+IGJ1dCBjdXJyZW50bHkgdGhlIGtlcm5lbCBpc24ndCBz
dXBwb3J0aW5nIHRoYXQgY29tcGF0aWJsZS4gVGhlIGkuTVg2DQo+PiBTb2xvIGlzIGN1cnJlbnRs
eSBzdXBwb3J0ZWQgYnkgImZzbCxpbXg2ZGwiLiBTbyBteSBpZGVhIHdhcyB0byBhZGQNCj4+IGJv
dGggImZzbCxpbXg2ZGwiIGFuZCAiZnNsLGlteDZzIiB0byBtYXRjaCBpdCBtYXliZSBvbiBhIGxh
dGVyIGtlcm5lbA0KPj4gdmVyc2lvbi4gSWYgdGhlcmUgaXMgbm8gbWF0Y2ggd2l0aCB0aGUgU29s
byBub3csIGl0IHdpbGwgZmFsbCBiYWNrIHRvDQo+PiB0aGUgaS5NWDYgRHVhbExpdGUuIFRoYXQg
aXMgd2h5IEkgaGFkIGJvdGggZnNsLGlteDZzIGFuZCBmc2wsaW14NmRsDQo+PiBpbiB0aGF0IG9y
ZGVyLiBPbiBGYWJpbydzIGFkdmljZSwgSSByZW1vdmVkIHRoZSBsaW5lIHdpdGggImZzbCxpbXg2
cyINCj4+IGluIHZlcnNpb24gMi4NCj4+IElzIHRoaXMgd2hhdCB5b3UgbWVhbnQgYnkgeW91ciBj
b21tZW50Pw0KPiANCj4gSSBkaWRuJ3Qgbm90aWNlIHRoYXQgYXQgZmlyc3QgbXlzZWxmLCBidXQg
SSB0aGluayB3aGF0IFJvYiBtZWFucyBpcw0KPiANCj4gLSBjb25zdDogZGgsaW14NnMtZGhjb20t
ZHJjMDINCj4gLSBjb25zdDogZGgsaW14NnMtZGhjb20tc29tDQo+IC0gY29uc3Q6IGZzbCxpbXg2
ZGwgPC0tLS0tLSB0aGlzIHNob3VsZCBiZSBjb25zaXN0ZW50IHdpdGggdGhlIHR3byBhYm92ZQ0K
PiANCj4gdGhhdCBpcw0KPiANCj4gICAtIGNvbnN0OiBkaCxpbXg2cy1kaGNvbS1kcmMwMg0KPiAg
IC0gY29uc3Q6IGRoLGlteDZzLWRoY29tLXNvbQ0KPiAtLSBjb25zdDogZnNsLGlteDZkbA0KPiAr
LSBjb25zdDogZnNsLGlteDZzDQo+ICAgICAgICAgICAgICAgIF5eXl5eDQo+IA0KPiBCdXQgdGhh
dCBpcyBhIGJpdCBvZGQgaGVyZToNCj4gLSBUaGUgTVg2UyBpcyBNWDZETCB3aXRoIG9uZSBDUFUg
Y29yZSBkaXNhYmxlZC4NCj4gLSBUaGUgRFJDMDIgZGV2aWNlIGNhbiBvbmx5IGhvdXNlIGEgU09N
IHdpdGggTVg2UyBhbmQgTk9UIHdpdGggTVg2REwNCj4gKGR1ZSB0byBzb21lIHRoZXJtYWwgZGVz
aWduIGNvbnNpZGVyYXRpb24gb3Igc29tZXRoaW5nKS4NCj4gLSBUaGUga2VybmVsIGRpc2Nlcm5z
IHRoZSBNWDZTL01YNkRMIGF1dG9tYXRpY2FsbHkgYmFzZWQgb24gdGhlIG51bWJlcg0KPiBvZiBj
b3JlcyBpdCByZWFkcyBmcm9tIHNvbWUgcmVnaXN0ZXIsIHRoZXJlZm9yZSBpdCBvbmx5IGhhcyB0
aGUNCj4gZnNsLG14NmRsIGNvbXBhdGlibGUgdG8gY292ZXIgYm90aCBNWDZTIGFuZCBNWDZETC4N
Cj4gU28sIHRoZSBjbG9zZXN0IGZhbGxiYWNrIGNvbXBhdGlibGUgZm9yIHRoaXMgZGV2aWNlIHJl
YWxseSBpcyB0aGUgTVg2REwsDQo+IGkuZS4gZnNsLGlteDZkbC4NCj4gDQo+IFNvIEkgdGhpbmsg
dGhpcyBwYXRjaCBpcyBjb3JyZWN0IGFzLWlzLCBubyA/DQoNCklzIHRoaXMgUGF0Y2ggT0s/DQoN
Cg==
