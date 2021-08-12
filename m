Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38323E9CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 05:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhHLDQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 23:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhHLDQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 23:16:15 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571DEC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 20:15:50 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 67393806B5;
        Thu, 12 Aug 2021 15:15:45 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1628738145;
        bh=+aeRJE8lBBEpOv4Yz590FcNPGDPhOZJQuB70ZkeBZCA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=GV4pbBUbQnPFmxS0F/1+5HH0wXWEGAPU73pUJ+VBHQ0LO0qJERW1uCiGPGj1LCXP8
         x3XiX6yvXMGo+nOXdIMBG7WwXJFrC/st21kzEOZHsUd4S/q3JtJxHmAc/qJR9Rcaqe
         VVOh/DvfKe2Wo0rg8X9o+g4wRBwj6BXktWrU8e3HNl1r6NwrYIfMbxlnsG53Rt+g5H
         xUqOEMc66aAPtFyZy4TES6u46Za0IZ+wsc3p3jEPiK7U//8gKpLQ3tFmTqyB0/ZK29
         1TzQrIpHWcyvXfd0hY64i2Z8ONL2/c3hX/M6V0/mx4gfbylMEzTKLf8lKvx+ogAUiw
         Vv6qPfBPnNNzQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B611492610001>; Thu, 12 Aug 2021 15:15:45 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 12 Aug 2021 15:15:45 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.023; Thu, 12 Aug 2021 15:15:45 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] hwmon: (pmbus/bpa-rs600) cleanup and workaround
Thread-Topic: [PATCH 0/2] hwmon: (pmbus/bpa-rs600) cleanup and workaround
Thread-Index: AQHXjmfUhftEq+42BUuRDDpemCFUEKtuarIA
Date:   Thu, 12 Aug 2021 03:15:44 +0000
Message-ID: <a181b3a5-41f7-fa49-e7fe-ab32dc39ff39@alliedtelesis.co.nz>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8383F7ECAB3E344A93114472F017971F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=MhDmnRu9jo8A:10 a=VwQbUJbxAAAA:8 a=U6DuVk5YAAAA:20 a=gbS8T0rqnHn9gnFFVREA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMS8wOC8yMSA0OjE3IHBtLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBUaGlzIHNlcmll
cyBidWlsZHMgb24gdG9wIG9mIHRoZSBCUEQtUlM2MDAgc3VwcG9ydFsxXSB3aGljaCBpcyBpbiBH
dWVudGVyJ3MNCj4gdHJlZSBieSBoYXNuJ3QgbWFkZSBpdCB0byBMaW51cycgeWV0LiBUaGV5IG1p
Z2h0IGFjdHVhbGx5IGNsZWFubHkgYXBwbHkgd2l0aG91dA0KPiBpdCBzaW5jZSB0aGV5IHRvdWNo
IGRpZmZlcmVudCBwYXJ0cyBvZiB0aGUgZmlsZS4NCj4NCj4gWzFdIC0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtaHdtb24vMjAyMTA3MDgyMjA2MTguMjM1NzYtMS1jaHJpcy5wYWNraGFt
QGFsbGllZHRlbGVzaXMuY28ubnovDQo+DQo+IENocmlzIFBhY2toYW0gKDIpOg0KPiAgICBod21v
bjogKHBtYnVzL2JwYS1yczYwMCkgUmVtb3ZlIGR1cGxpY2F0ZSBkZWZpbmluaXRpb25zDQo+ICAg
IGh3bW9uOiAocG1idXMvYnBhLXJzNjAwKSBBZGQgd29ya2Fyb3VuZCBmb3IgaW5jb3JyZWN0IFBp
biBtYXgNCj4NCj4gICBkcml2ZXJzL2h3bW9uL3BtYnVzL2JwYS1yczYwMC5jIHwgNDQgKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2Vy
dGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KDQpJJ3ZlIGFsc28gc2VudCBhIFBSIGZvciBhZGRp
bmcgZGlzcGxheSBvZiB0aGUgcmF0ZWQgdmFsdWVzIHRvIGxtLXNlbnNvcnMNCg0KaHR0cHM6Ly9n
aXRodWIuY29tL2xtLXNlbnNvcnMvbG0tc2Vuc29ycy9wdWxsLzM1OA0K
