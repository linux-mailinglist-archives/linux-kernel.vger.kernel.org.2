Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7E399CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFCIq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:46:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:49492 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhFCIqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:46:55 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-260-MQ8aAEL3PzOkY4PEGJSglQ-1; Thu, 03 Jun 2021 09:45:08 +0100
X-MC-Unique: MQ8aAEL3PzOkY4PEGJSglQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Thu, 3 Jun 2021 09:45:07 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Thu, 3 Jun 2021 09:45:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Robin Murphy' <robin.murphy@arm.com>,
        Sunil Kovvuri <sunil.kovvuri@gmail.com>,
        Oliver Swede <oli.swede@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.indradead.org" 
        <linux-arm-kernel@lists.indradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>
Subject: RE: [PATCH v5 08/14] arm64: Import latest optimization of memcpy
Thread-Topic: [PATCH v5 08/14] arm64: Import latest optimization of memcpy
Thread-Index: AQHXVt6Y/3nhMCoZXEKKkfk/tVUx26sB944A
Date:   Thu, 3 Jun 2021 08:45:07 +0000
Message-ID: <d6b241979664402e907064245ebe5578@AcuMS.aculab.com>
References: <20200914150958.2200-1-oli.swede@arm.com>
 <20200914150958.2200-9-oli.swede@arm.com>
 <CA+sq2CfGu+JPJ9h3Q-nCdmM2erqWbe=p-v_eip-J-R6F2EoXbw@mail.gmail.com>
 <5156db7f-09a7-b0fa-d246-b024e40775fc@arm.com>
In-Reply-To: <5156db7f-09a7-b0fa-d246-b024e40775fc@arm.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUm9iaW4gTXVycGh5DQo+IFNlbnQ6IDAxIEp1bmUgMjAyMSAxMzowNw0KPiANCj4gT24g
MjAyMS0wNi0wMSAxMTowMywgU3VuaWwgS292dnVyaSB3cm90ZToNCj4gPiBPbiBNb24sIFNlcCAx
NCwgMjAyMCBhdCA4OjQ0IFBNIE9saXZlciBTd2VkZSA8b2xpLnN3ZWRlQGFybS5jb20+IHdyb3Rl
Og0KPiA+Pg0KPiA+PiBGcm9tOiBTYW0gVGViYnMgPHNhbS50ZWJic0Bhcm0uY29tPg0KPiA+Pg0K
PiA+PiBJbXBvcnQgdGhlIGxhdGVzdCBtZW1jcHkgaW1wbGVtZW50YXRpb24gaW50byBtZW1jcHks
DQo+ID4+IGNvcHlfe2Zyb20sIHRvIGFuZCBpbn1fdXNlci4NCj4gPj4gVGhlIGltcGxlbWVudGF0
aW9uIG9mIHRoZSB1c2VyIHJvdXRpbmVzIGlzIHNlcGFyYXRlZCBpbnRvIHR3byBmb3JtczoNCj4g
Pj4gb25lIGZvciB3aGVuIFVBTyBpcyBlbmFibGVkIGFuZCBvbmUgZm9yIHdoZW4gVUFPIGlzIGRp
c2FibGVkLCB3aXRoDQo+ID4+IHRoZSB0d28gYmVpbmcgY2hvc2VuIGJldHdlZW4gd2l0aCBhIHJ1
bnRpbWUgcGF0Y2guDQo+ID4+IFRoaXMgYXZvaWRzIGV4ZWN1dGluZyB0aGUgbWFueSBOT1BzIGVt
aXR0ZWQgd2hlbiBVQU8gaXMgZGlzYWJsZWQuDQo+ID4+DQo+ID4+IFRoZSBwcm9qZWN0IGNvbnRh
aW5pbmcgb3B0aW1pemVkIGltcGxlbWVudGF0aW9ucyBmb3IgdmFyaW91cyBsaWJyYXJ5DQo+ID4+
IGZ1bmN0aW9ucyBoYXMgbm93IGJlZW4gcmVuYW1lZCBmcm9tICdjb3J0ZXgtc3RyaW5ncycgdG8N
Cj4gPj4gJ29wdGltaXplZC1yb3V0aW5lcycsIGFuZCB0aGUgbmV3IHVwc3RyZWFtIHNvdXJjZSBp
cw0KPiA+PiBzdHJpbmcvYWFyY2g2NC9tZW1jcHkuUyBhcyBvZiBjb21taXQgNGMxNzVjOGJlMTIg
aW4NCj4gPj4gaHR0cHM6Ly9naXRodWIuY29tL0FSTS1zb2Z0d2FyZS9vcHRpbWl6ZWQtcm91dGlu
ZXMuDQo+ID4+DQouLi4NCj4gPg0KPiA+IERvIHlvdSBoYXZlIGFueSBwZXJmb3JtYW5jZSBkYXRh
IHdpdGggdGhpcyBwYXRjaCA/DQo+ID4gSSBzZWUgdGhlc2UgcGF0Y2hlcyBhcmUgc3RpbGwgbm90
IHB1c2hlZCB0byBtYWlubGluZSwgYW55IHJlYXNvbnMgPw0KPiANCj4gRnVubnkgeW91IHNob3Vs
ZCBwaWNrIHVwIG9uIHRoZSA2LW1vbnRoLW9sZCB0aHJlYWQgZGF5cyBhZnRlciBJJ3ZlIGJlZW4N
Cj4gcG9zdGluZyBuZXcgdmVyc2lvbnMgb2YgdGhlIHJlbGV2YW50IHBhcnRzWzFdIDopDQo+IA0K
PiBJIHRoaW5rIHRoaXMgc2VyaWVzIG1vc3RseSBzdGFsbGVkIG9uIHRoZSBjb21wbGV4aXR5IG9m
IHRoZSB1c2VyY29weQ0KPiBwYXJ0cywgd2hpY2ggdGhlbiB0dXJuZWQgaW50byBldmVuIG1vcmUg
b2YgYSBtb3ZpbmcgdGFyZ2V0IGFueXdheSwgaGVuY2UNCj4gd2h5IEkgZGVjaWRlZCB0byBzcGxp
dCBpdCB1cC4NCg0KSXQgaXMgYWxzbyB3b3J0aCBjaGVja2luZyB3aGF0IGtpbmQgb2YgY29weSBs
ZW5ndGhzIHRoZSAnb3B0aW1pemVkJw0Kcm91dGluZXMgYXJlIGFjdHVhbGx5IG9wdGltaXNlZCBm
b3IuDQpGb3IgaW5zdGFuY2UgYSBzZW5kbXNnKCkgc3lzdGVtIGNhbGwgaXMgbGlrZWx5IHRvIGRv
IGF0IGxlYXN0IDMgc2hvcnQNCmNvcHlfZnJvbV91c2VyKCkgcmVxdWVzdHMgYmVmb3JlIGV2ZW4g
dGhpbmtpbmcgYWJvdXQgcmVhZGluZyB0aGUgZGF0YSBidWZmZXIuDQpFdmVuIHRoZSBjb3N0cyBv
ZiB0aGUgY29tcGFyaXNvbnMgdG8gc2VsZWN0IGJldHdlZW4gc2hvcnQvbG9uZyBjb3B5DQpyZXF1
ZXN0cyBiZWNvbWUgc2lnbmlmaWNhbnQgb24gc2hvcnQgY29waWVzLg0KDQpJJ20gbm90IHN1cmUg
eW91IHdhbnQgdG8gYmUgY2FsbGluZw0KaHR0cHM6Ly9naXRodWIuY29tL0FSTS1zb2Z0d2FyZS9v
cHRpbWl6ZWQtcm91dGluZXMvYmxvYi9tYXN0ZXIvc3RyaW5nL2FhcmNoNjQvbWVtY3B5LlMNCmZv
ciAzIGJ5dGVzIQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

