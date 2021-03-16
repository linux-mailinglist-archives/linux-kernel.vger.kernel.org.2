Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19C833CC21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhCPDar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:30:47 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56462 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCPDad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:30:33 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E69D0891AE;
        Tue, 16 Mar 2021 16:30:29 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615865429;
        bh=vmWfl3H3Aa1nxkLwG2dy4DHtQEEA/roKlx2zgxf/RJM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=12WMCtOUR7yDGv4e4UqZY9HtX2JhehEZs6gDubgLSDgsrwA+OkqPNmVvnR6BQJy1/
         MfaJNwaPk/llcFVtCcd+WN5lq3slPPBmbKMLOdzxDY82D1YupMrxPMRZ8o9S++EbVw
         DJt/hJRYaFFvPmTYdsygrwSSRgJz0XKXFlftieBaBsNOOpxJcslesErSa2OkZFR60u
         dvXoqGYt6+bb5Rd2fqpg/Shlbr2bvQvQLe6ZNmGjSPi7ReTg08RThImz34Hi2WFJi+
         PWE/McztgcoXVZBwjbvKFql6usrxYc8Bgt6yzST03y4d9t0GzLiBxPDDs591Xp/JtQ
         6UkNA693RnOoA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B605026550001>; Tue, 16 Mar 2021 16:30:29 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 16 Mar 2021 16:30:29 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.012; Tue, 16 Mar 2021 16:30:29 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Thread-Topic: [PATCH 2/2] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Thread-Index: AQHXGg0JQkIPU0GURU+Z4hUV3SNYs6qFG2MA
Date:   Tue, 16 Mar 2021 03:30:28 +0000
Message-ID: <8066478b-26cb-7904-9203-054c74ccd07b@alliedtelesis.co.nz>
References: <20210316023524.12574-1-chris.packham@alliedtelesis.co.nz>
 <20210316023524.12574-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20210316023524.12574-2-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7CF9C0323BA3143B7C61BEF52CF165C@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GfppYjfL c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10 a=GpMvjJetwIR_TAr8NAQA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNi8wMy8yMSAzOjM1IHBtLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBUaGUgQlBBLVJT
NjAwIGlzIGEgY29tcGFjdCA2MDBXIEFDIHRvIERDIHJlbW92YWJsZSBwb3dlciBzdXBwbHkgbW9k
dWxlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFs
bGllZHRlbGVzaXMuY28ubno+DQo+DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBfX21heWJlX3VudXNlZCBicGFfcnM2MDBfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7IC5jb21wYXRp
YmxlID0gImJsdXRlayxicGEtcnM2MDAiIH0sDQo+ICsJe30sDQo+ICt9Ow0KDQpJIHNlZSB0aGlz
IHdpbGwgZmFsbCBmb3VsIG9mIHRoZSBuYW1lIGNoZWNrIGluIA0KX19od21vbl9kZXZpY2VfcmVn
aXN0ZXIoKS4gSG93IHNob3VsZCBJIG5hbWUgdGhpbmdzIHRvIGF2b2lkIHRoaXM/DQo=
