Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EAC3BF66F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhGHHuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhGHHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:50:13 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81CDC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1625730424;
        bh=dde1WsS9tS7ABtllHJehoQdQKDcbrJHK8Aivo9V/QlM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZvzCCclH5/Df9kyXBu1k1Cw97PXWAFOPXev91m6UgPAPDJFQ6rrY4M02ESp6GqqOX
         f6jIIz5SIDUGh8oKVhPhRVc/BjQNYFK6TpDN4rPcGCD79MzBuScThD3dwWllZhRB/p
         64sjHIrfkUzn/Pmw/jN7ightdmSZJzgydE61KTioiAoCsaQEzP8MvNAGE13Ib0YWkm
         /PC8n/Cxa6hj1W5fCYmAaRqAie8FiWdlnOJ0jEDl9qG6ckfLVeFG6i3WrvJCcmioUt
         0ce7RIFbyZcXbyNE5cf061Eiy+RzLfez4ckoMsuHivs8Ju4RQnEf1bSn6OR7CJW85Z
         Pjxe5xLvbF2DQ==
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
Thread-Index: AQHXUJSuJd8KnePrj0my43aX64Fm16sTog0AgCVWkGA=
Date:   Thu, 8 Jul 2021 07:46:51 +0000
Message-ID: <0d2d38e799764058b4d69d5a87ee164c@dh-electronics.com>
References: <20210524115853.6413-1-cniedermaier@dh-electronics.com>
 <a6229fe4-7409-deac-6c59-93a715dc4d45@denx.de>
In-Reply-To: <a6229fe4-7409-deac-6c59-93a715dc4d45@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgW21haWx0bzptYXJleEBkZW54LmRlXQ0KU2VudDogTW9uZGF5LCBK
dW5lIDE0LCAyMDIxIDU6MzIgUE0NCj4gT24gNS8yNC8yMSAxOjU4IFBNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+PiBBZGQgbWFpbnRhaW5lcnMgZm9yIERIIGVsZWN0cm9uaWNzIERI
Q09NIGkuTVg2DQo+PiBhbmQgREhDT00vREhDT1IgU1RNMzJNUDEgYm9hcmRzLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0
cm9uaWNzLmNvbT4NCj4+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4+IENjOiBrZXJuZWxAZGgtZWxlY3Ryb25pY3MuY29tDQo+PiBUbzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPj4gLS0tDQo+PiAgIE1BSU5UQUlORVJTIHwgMTMgKysrKysrKysrKysr
Kw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+PiBpbmRleCAwN2YwNDE0YmMyYTUuLmMz
ODM2ZDM0ZTg0NCAxMDA2NDQNCj4+IC0tLSBhL01BSU5UQUlORVJTDQo+PiArKysgYi9NQUlOVEFJ
TkVSUw0KPj4gQEAgLTUzMjAsNiArNTMyMCwxOSBAQCBGOiAgICAgaW5jbHVkZS9uZXQvZGV2bGlu
ay5oDQo+PiAgIEY6ICBpbmNsdWRlL3VhcGkvbGludXgvZGV2bGluay5oDQo+PiAgIEY6ICBuZXQv
Y29yZS9kZXZsaW5rLmMNCj4+DQo+PiArREggRUxFQ1RST05JQ1MgSU1YNiBESENPTSBCT0FSRCBT
VVBQT1JUDQo+PiArTTogICBDaHJpc3RvcGggTmllZGVybWFpZXIgPGNuaWVkZXJtYWllckBkaC1l
bGVjdHJvbmljcy5jb20+DQo+PiArTDogICBrZXJuZWxAZGgtZWxlY3Ryb25pY3MuY29tDQo+PiAr
UzogICBNYWludGFpbmVkDQo+PiArRjogICBhcmNoL2FybS9ib290L2R0cy9pbXg2Ki1kaGNvbS0q
DQo+PiArDQo+PiArREggRUxFQ1RST05JQ1MgU1RNMzJNUDEgREhDT00vREhDT1IgQk9BUkQgU1VQ
UE9SVA0KPj4gK006ICAgTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+PiArTDogICBrZXJu
ZWxAZGgtZWxlY3Ryb25pY3MuY29tDQo+PiArUzogICBNYWludGFpbmVkDQo+PiArRjogICBhcmNo
L2FybS9ib290L2R0cy9zdG0zMm1wMSotZGhjb20tKg0KPj4gK0Y6ICAgYXJjaC9hcm0vYm9vdC9k
dHMvc3RtMzJtcDEqLWRoY29yLSoNCj4+ICsNCj4+ICAgRElBTE9HIFNFTUlDT05EVUNUT1IgRFJJ
VkVSUw0KPj4gICBNOiAgU3VwcG9ydCBPcGVuc291cmNlIDxzdXBwb3J0Lm9wZW5zb3VyY2VAZGlh
c2VtaS5jb20+DQo+PiAgIFM6ICBTdXBwb3J0ZWQNCj4gDQo+IFJldmlld2VkLWJ5OiBNYXJlayBW
YXN1dCA8bWFyZXhAZGVueC5kZT4NCg0KSGVsbG8gQXJuZCwNCg0KQ291bGQgeW91IHBpY2sgdGhp
cyBwYXRjaD8NCg0KQmVzdCByZWdhcmRzDQpDaHJpc3RvcGgNCg==
