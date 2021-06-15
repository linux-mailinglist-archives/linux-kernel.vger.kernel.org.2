Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB933A8C99
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhFOXhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFOXhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:37:04 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFDEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:34:59 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5661683640;
        Wed, 16 Jun 2021 11:34:54 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1623800094;
        bh=G1H0mb21cXYg9GUq4GgDMzE/Jr4DAcN5lY9tb2wXSDI=;
        h=From:To:CC:Subject:Date;
        b=PoccY+OuX3QGSQnbIwZxtYTUvv/+YU7L1qgjxv1i9CsXunXolixlq50WjzzzLFDN3
         m7NQTom5EIElCCQwBuh3dAUsHFBo6aEoihcl59aTJALfdwjSBhR2OvsNJrJp9x4PHz
         PF+0AWRspLOXcK5KvlIPQv4OTRDAVFUoYHRI9UI7bRdv2gWcmIEnd8gPspmiWm5Cw/
         zbB5MTv7NQcpWycWARpYETN9TGw1xvG73J2jdNqMMmofTuPXmlGBp4aucg/K3Xqwbg
         IQ8y3oqsl9Zstx5dE9V1wdcQt7fLxYH7XvVClV0ycGcBHe4iOPED2hbgEj0PE5x+3M
         QraUOFD++eTSg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60c9391e0001>; Wed, 16 Jun 2021 11:34:54 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.18; Wed, 16 Jun 2021 11:34:54 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.018; Wed, 16 Jun 2021 11:34:54 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: pmbus: dealing with unsigned mantissa in linear reading
Thread-Topic: pmbus: dealing with unsigned mantissa in linear reading
Thread-Index: AQHXYj8KPszxT0us6UK8aq+XcguhFg==
Date:   Tue, 15 Jun 2021 23:34:53 +0000
Message-ID: <67dd830c-c40f-b555-2b4e-3b7d383ef2c9@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFC41A3C6AE3EA45968CFC96323B2E2E@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=IOh89TnG c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=r6YtysWOX24A:10 a=PdBuntdOPsKOewribI0A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VlbnRlciwNCg0KSSd2ZSBoYWQgYSByZXBvcnQgZnJvbSBzb21lb25lIHRlc3RpbmcgdGhl
IEJQQS1SUzYwMC4NCg0KV2hlbiB0aGV5IGhhdmUgdGhlIGlucHV0IHZvbHRhZ2Ugc2V0IHRvID49
IDI1NlYgKGFwcGFyZW50bHkgdGhlIFBTVSBjYW4gDQpoYW5kbGUgaW5wdXQgdXAgdG8gMjY0Viku
IFRoZSBWaW4gcmVhZGluZyBnb2VzIG5lZ2F0aXZlLg0KDQpDTUQgMHg4OCwgVkFMPTB4ZjNmOCwg
VmluPTI1NA0KQ01EIDB4ODgsIFZBTD0weGYzZmMsIFZpbj0yNTUNCkNNRCAweDg4LCBWQUw9MHhm
NDAwLCBWaW49LTI1Ng0KDQpMb29raW5nIGF0IHBtYnVzX3JlZzJkYXRhX2xpbmVhcigpIHRoZSBt
YW50aXNzYSBpcyBjYXN0IHRvIHMxNiB3aGljaCBpcyANCmNvcnJlY3QgYWNjb3JkaW5nIHRvIHNl
Y3Rpb24gNy4xIG9mIHRoZSBQTUJVUyBzcGVjIHdoaWNoIHNheXMgdGhhdCB0aGUgDQptYW50aXNz
YSBpcyBhbiAxMS1iaXQgdHdvJ3MgY29tcGxlbWVudCB2YWx1ZS4NCg0KSXQgc2VlbXMgdGhhdCB0
aGUgQlBBLVJTNjAwIGlzIHVzaW5nIGEgbm9uLXN0YW5kYXJkIGZvcm1hdCBmb3IgdGhlIA0KbWFu
dGlzc2EgKHByb2JhYmx5IGJlY2F1c2UgdGhlIHJhbmdlIG9mIHRoZSBzdGFuZGFyZCBsaW5lYXIg
ZW5jb2RpbmcgDQpjYW4ndCBzdXBwb3J0IHZhbHVlcyA+MjU1VikuIERvZXMgdGhlIHBtYnVzIGlu
ZnJhc3RydWN0dXJlIHByb3ZpZGUgYSB3YXkgDQpmb3IgbWUgdG8gZGVmaW5lIGEgY3VzdG9tIGZv
cm1hdC9jb252ZXJzaW9uIGZvciBhIGdpdmVuIHNlbnNvcj8NCg0KVGhhbmtzLA0KQ2hyaXMNCg==
