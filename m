Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBBB33CC37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhCPDmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhCPDln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:41:43 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E9BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:41:43 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 56273891AE;
        Tue, 16 Mar 2021 16:41:39 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615866099;
        bh=GWGYXGQeKOtp0nUm++//j8vZ07T5KACIKOjLlfENPRM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=bSZABIMiMxdeJl8cPnWhZxBiVkS1ZUNjw8ehdG1dQql5QN1VsZiZqIgSflMZze2Ap
         EMoebV9ntyEHn9XnPnPkaTo3+L2jG3tIPS96ZIq61JleEvX4ndzd6uBhoTe2cGTZxk
         pcqzeHwxa0jAn18tsLWhIg3k1djIlnSc9daNfm8L9vroG84CLezHDpKxa1/mj4O9kV
         cufv2STMCbn40EEldp72QU4cBCOxhIThglNIPnETQ1uSMlnuhb37dEEp1/GyAFFj3C
         Rd52QjwtpN8Ef0Zo2nKbM74yGlw7e3l8YT+oTyu3Z4K/so0x7AmqLqEJIde+p/ZBM8
         oWBJRedRU8bJw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B605028f30001>; Tue, 16 Mar 2021 16:41:39 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Mar 2021 16:41:38 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.012; Tue, 16 Mar 2021 16:41:38 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Thread-Topic: [PATCH 2/2] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Thread-Index: AQHXGg0JQkIPU0GURU+Z4hUV3SNYs6qFG2MAgAABaYCAAAG1AA==
Date:   Tue, 16 Mar 2021 03:41:38 +0000
Message-ID: <3458b6e9-db88-db10-0b1b-ae8e776fb830@alliedtelesis.co.nz>
References: <20210316023524.12574-1-chris.packham@alliedtelesis.co.nz>
 <20210316023524.12574-2-chris.packham@alliedtelesis.co.nz>
 <8066478b-26cb-7904-9203-054c74ccd07b@alliedtelesis.co.nz>
 <6afe1c65-d50d-4bd7-2ad3-93d9b067afc5@roeck-us.net>
In-Reply-To: <6afe1c65-d50d-4bd7-2ad3-93d9b067afc5@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E34E853FEF6BAB45A66ECEB3E02B5C1A@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GfppYjfL c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10 a=Cxg_ARczb30sDBorGzkA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNi8wMy8yMSA0OjM1IHBtLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiBPbiAzLzE1LzIx
IDg6MzAgUE0sIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBPbiAxNi8wMy8yMSAzOjM1IHBtLCBD
aHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+IFRoZSBCUEEtUlM2MDAgaXMgYSBjb21wYWN0IDYwMFcg
QUMgdG8gREMgcmVtb3ZhYmxlIHBvd2VyIHN1cHBseSBtb2R1bGUuDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+
DQo+Pj4NCj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgX19tYXliZV91bnVz
ZWQgYnBhX3JzNjAwX29mX21hdGNoW10gPSB7DQo+Pj4gKwl7IC5jb21wYXRpYmxlID0gImJsdXRl
ayxicGEtcnM2MDAiIH0sDQo+Pj4gKwl7fSwNCj4+PiArfTsNCj4+IEkgc2VlIHRoaXMgd2lsbCBm
YWxsIGZvdWwgb2YgdGhlIG5hbWUgY2hlY2sgaW4NCj4+IF9faHdtb25fZGV2aWNlX3JlZ2lzdGVy
KCkuIEhvdyBzaG91bGQgSSBuYW1lIHRoaW5ncyB0byBhdm9pZCB0aGlzPw0KPj4NCj4gSXQgaXNu
J3QgdGhlIGJpbmRpbmcuIFRoZSBkcml2ZXIgbmFtZSBzaG91bGQgbm90IGhhdmUgYSAnLScgaW4g
aXQuDQo+IFlvdSBjb3VsZCBqdXN0IG5hbWUgaXQgYnBhX3JzNjAwIGluc3RlYWQuDQoNClNvbGQu
DQoNCkknbGwgZ2l2ZSB0aGUgd29ybGQgYSBjaGFuY2UgdG8gdHVybiBzbyBwZW9wbGUgY2FuIGxv
b2sgYXQgdGhlIHJlc3Qgb2YgDQp0aGUgcGF0Y2ggYmVmb3JlIEkgc2VuZCBhIHYyLg0K
