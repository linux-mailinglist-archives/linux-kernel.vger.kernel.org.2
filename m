Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB044BA84
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 04:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhKJDFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 22:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhKJDFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 22:05:03 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A33C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 19:02:16 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E0B00806A8;
        Wed, 10 Nov 2021 16:02:11 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1636513331;
        bh=vjSIZmMgIx3V1nxApZdklS/Kti2loeYo/1WqFgIieYc=;
        h=From:To:Subject:Date;
        b=kW/na6oM0/PWU1Qrh7JfxRodXFncjIHmfVFs5RI7iLg14KIkBWGCMWKmcnLPSn94r
         LLpdBLP6TCObG8Ga5ld+GIx9aFDOUHLDvGAhxtngiJXoKGwGkYBwuODoW+nEX5tSB7
         e7ReGczsj5U1Q57lGJ3XWHiJkgcum0+yRLlN7pf6+fUppSPljc0YHXgj+pyh0ADPOD
         0SIQSPSeBgBrBVnDegaNBw34KfpOZhpXkX9FitEqvJrMJQBz5YNzMI+zft1zXNk+5C
         fdxYZ2YqenGkf2xPwBWkYH3GzLN8RkJNwG4Q2jCIzNOvlC+yCOsIOBt2p5HSFhL5MP
         DcEPogHkxDgNQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B618b36330000>; Wed, 10 Nov 2021 16:02:11 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.24; Wed, 10 Nov 2021 16:02:11 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.024; Wed, 10 Nov 2021 16:02:11 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Dealing with custom hardware on x86
Thread-Topic: Dealing with custom hardware on x86
Thread-Index: AQHX1d9bV9KaxyAm9kmZoGSBHWA2lg==
Date:   Wed, 10 Nov 2021 03:02:11 +0000
Message-ID: <4ad5a438-ddc4-ca0a-a792-09d17edeb66b@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <07189659D22DC94A9A00A7AF87D1F526@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eIJtc0h1 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=vIxV3rELxO4A:10 a=MijwRMMebF1R3jJnlZkA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkknbSBhYm91dCB0byBzdGFydCBhIHByb2plY3QgaW52b2x2aW5nIGN1c3RvbSBoYXJk
d2FyZSB1c2luZyBhbiB4ODYgQ1BVLiANCkNvbXBsaWNhdGluZyB0aGluZ3Mgc29tZXdoYXQgd2Ug
d2lsbCBoYXZlIGEgQ1BVIGJvYXJkIHN1cHBsaWVkIGJ5IGEgM3JkIA0KcGFydHkgdmVuZG9yIHVz
aW5nIGEgQ09NIEV4cHJlc3MgdHlwZSA3IGNvbm5lY3RvciB3aGljaCB3aWxsIHBsdWcgaW4gdG8g
DQp0aGUgYm9hcmQgd2UncmUgZGVzaWduaW5nIChhY3R1YWxseSAyIGRpZmZlcmVudCBib2FyZHMg
ZWFjaCB3aXRoIHNvbWUgDQptb2R1bGFyIGFzcGVjdHMpIC4NCg0KQ29taW5nIGZyb20gYW4gZW1i
ZWRkZWQgKG1vc3RseSBBUk0pIGJhY2tncm91bmQgSSdtIHVzZWQgdG8gZGVzY3JpYmluZyANCnRo
ZSBoYXJkd2FyZSB2aWEgYSBkZXZpY2V0cmVlIGFuZCBkZWFsaW5nIHdpdGggcGx1Zy1pbiBtb2R1
bGVzIGJ5IA0KbG9hZGluZyBkZXZpY2V0cmVlIG92ZXJsYXlzLiBIb3cgZG8gcGVvcGxlIGFjaGll
dmUgdGhpcyBraW5kIG9mIHRoaW5nIG9uIA0KeDg2Pw0KDQpJIGdhdGhlciBBQ1BJIGlzIGludm9s
dmVkIHNvbWV3aGVyZSBidXQgdGhlIGtub3dsZWRnZSB0aGF0IHRoZSBCSU9TIGhhcyANCndpbGwg
Z28gYXMgZmFyIGFzIHRoZSBDT00gRXhwcmVzcyBoZWFkZXIgYW5kIHNvbWVob3cgd2UnbGwgaGF2
ZSB0byB0ZWxsIA0KdGhlIGtlcm5lbCBhYm91dCB0aGUgdmFyaW91cyBub24tcHJvYmVhYmxlICht
b3N0bHkgaTJjKSBkZXZpY2VzIG9uIG91ciANCmJvYXJkIHdoaWNoIGlzIGtpbmQgb2Ygd2hlcmUg
SSdtIHN0dWNrLiBBbnkgcG9pbnRlcnMgd291bGQgYmUgZ3JlYXRseSANCmFwcHJlY2lhdGVkLg0K
DQpUaGFua3MsDQpDaHJpcw0K
