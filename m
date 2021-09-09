Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF49404677
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352778AbhIIHlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352767AbhIIHlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:41:32 -0400
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Sep 2021 00:40:23 PDT
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D601C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1631172724;
        bh=gxJWjj01WkosV2N0mu4hAMGEcMiieeFViQnJVNUs2xk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=S77CaoXXNE9zkNWyPQv/L/isHXhXVoU5KITr572zwdqg6hEH0Ix7aaIL3xrMKET7e
         j4RPrBu1H5kGewQwiG1UXexMBvrjDRK6s+3kP6ZEfi0AsdYWNaJKhll+2LUCefU7LD
         iX8DFqVBHIlhi0h+110CMC992hlM/3wlOvawOBnO4cWh0FzNRzWAOv4jpB+qZwIsfJ
         oiYxDk9d4l+tE3wK2OrKglvUU6tIYFWeibx/l3dZwcDPZE1JkQa5YvomSkqeDlL8ek
         sPZvBElVogO6ohe4/eXRWNKwJe7OAyoUiduPQL9jz4ONag8ye1+fSPsiCr1zIVkPOJ
         XMjSVgBGOOj6A==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        kernel <kernel@dh-electronics.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Marek MV. Vasut" <marex@denx.de>
Subject: RE: [PATCH] MAINTAINERS: Add maintainers for DHCOM i.MX6 and
 DHCOM/DHCOR STM32MP1
Thread-Topic: [PATCH] MAINTAINERS: Add maintainers for DHCOM i.MX6 and
 DHCOM/DHCOR STM32MP1
Thread-Index: AQHXUJSuJd8KnePrj0my43aX64Fm16sTog0AgCVWkGCAYvuvAA==
Date:   Thu, 9 Sep 2021 07:31:41 +0000
Message-ID: <f04ba233c01d4b468201a01e809e4ecf@dh-electronics.com>
References: <20210524115853.6413-1-cniedermaier@dh-electronics.com>
 <a6229fe4-7409-deac-6c59-93a715dc4d45@denx.de>
 <0d2d38e799764058b4d69d5a87ee164c@dh-electronics.com>
In-Reply-To: <0d2d38e799764058b4d69d5a87ee164c@dh-electronics.com>
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

RnJvbTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyDQpTZW50OiBUaHVyc2RheSwgSnVseSA4LCAyMDIx
IDk6NDcgQU0NCj4gRnJvbTogTWFyZWsgVmFzdXQgW21haWx0bzptYXJleEBkZW54LmRlXQ0KPiBT
ZW50OiBNb25kYXksIEp1bmUgMTQsIDIwMjEgNTozMiBQTQ0KPj4gT24gNS8yNC8yMSAxOjU4IFBN
LCBDaHJpc3RvcGggTmllZGVybWFpZXIgd3JvdGU6DQo+Pj4gQWRkIG1haW50YWluZXJzIGZvciBE
SCBlbGVjdHJvbmljcyBESENPTSBpLk1YNg0KPj4+IGFuZCBESENPTS9ESENPUiBTVE0zMk1QMSBi
b2FyZHMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggTmllZGVybWFpZXIgPGNu
aWVkZXJtYWllckBkaC1lbGVjdHJvbmljcy5jb20+DQo+Pj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4+IENjOiBrZXJuZWxAZGgtZWxlY3Ryb25pY3MuY29tDQo+
Pj4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+PiAtLS0NCj4+PiAgIE1BSU5U
QUlORVJTIHwgMTMgKysrKysrKysrKysrKw0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJT
DQo+Pj4gaW5kZXggMDdmMDQxNGJjMmE1Li5jMzgzNmQzNGU4NDQgMTAwNjQ0DQo+Pj4gLS0tIGEv
TUFJTlRBSU5FUlMNCj4+PiArKysgYi9NQUlOVEFJTkVSUw0KPj4+IEBAIC01MzIwLDYgKzUzMjAs
MTkgQEAgRjogICAgIGluY2x1ZGUvbmV0L2RldmxpbmsuaA0KPj4+ICAgRjogIGluY2x1ZGUvdWFw
aS9saW51eC9kZXZsaW5rLmgNCj4+PiAgIEY6ICBuZXQvY29yZS9kZXZsaW5rLmMNCj4+Pg0KPj4+
ICtESCBFTEVDVFJPTklDUyBJTVg2IERIQ09NIEJPQVJEIFNVUFBPUlQNCj4+PiArTTogICBDaHJp
c3RvcGggTmllZGVybWFpZXIgPGNuaWVkZXJtYWllckBkaC1lbGVjdHJvbmljcy5jb20+DQo+Pj4g
K0w6ICAga2VybmVsQGRoLWVsZWN0cm9uaWNzLmNvbQ0KPj4+ICtTOiAgIE1haW50YWluZWQNCj4+
PiArRjogICBhcmNoL2FybS9ib290L2R0cy9pbXg2Ki1kaGNvbS0qDQo+Pj4gKw0KPj4+ICtESCBF
TEVDVFJPTklDUyBTVE0zMk1QMSBESENPTS9ESENPUiBCT0FSRCBTVVBQT1JUDQo+Pj4gK006ICAg
TWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+Pj4gK0w6ICAga2VybmVsQGRoLWVsZWN0cm9u
aWNzLmNvbQ0KPj4+ICtTOiAgIE1haW50YWluZWQNCj4+PiArRjogICBhcmNoL2FybS9ib290L2R0
cy9zdG0zMm1wMSotZGhjb20tKg0KPj4+ICtGOiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAx
Ki1kaGNvci0qDQo+Pj4gKw0KPj4+ICAgRElBTE9HIFNFTUlDT05EVUNUT1IgRFJJVkVSUw0KPj4+
ICAgTTogIFN1cHBvcnQgT3BlbnNvdXJjZSA8c3VwcG9ydC5vcGVuc291cmNlQGRpYXNlbWkuY29t
Pg0KPj4+ICAgUzogIFN1cHBvcnRlZA0KPj4NCj4+IFJldmlld2VkLWJ5OiBNYXJlayBWYXN1dCA8
bWFyZXhAZGVueC5kZT4NCj4gDQo+IEhlbGxvIEFybmQsDQo+IA0KPiBDb3VsZCB5b3UgcGljayB0
aGlzIHBhdGNoPw0KPiANCj4gQmVzdCByZWdhcmRzDQo+IENocmlzdG9waA0KDQpIZWxsbyBBcm5k
LA0KDQpDb3VsZCB5b3UgdGVsbCBtZSBob3cgdG8gZ2V0IHRoaXMgcGF0Y2ggbWFpbmxpbmU/DQpJ
cyB0aGVyZSBzb21ldGhpbmcgd3Jvbmcgd2l0aCBpdD8NCg0KTWFueSB0aGFua3MgYW5kIGdyZWV0
aW5ncw0KQ2hyaXN0b3BoDQo=
