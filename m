Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E683715D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhECNRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:17:49 -0400
Received: from [58.211.163.100] ([58.211.163.100]:64762 "EHLO
        mail.advantech.com.cn" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S234186AbhECNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:17:36 -0400
Received: from ACNMB1.ACN.ADVANTECH.CORP (unverified [172.21.128.147]) by ACNSWEEPER.acn.advantech.com.cn
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te6407fa4dbac1580102738@ACNSWEEPER.acn.advantech.com.cn>;
 Mon, 3 May 2021 21:16:25 +0800
Received: from ACNMB2.ACN.ADVANTECH.CORP (172.21.128.148) by
 ACNMB1.ACN.ADVANTECH.CORP (172.21.128.147) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 3 May 2021 21:16:24 +0800
Received: from ACNMB2.ACN.ADVANTECH.CORP ([172.21.128.148]) by
 ACNMB2.ACN.ADVANTECH.CORP ([172.21.128.148]) with mapi id 15.00.1497.015;
 Mon, 3 May 2021 21:16:25 +0800
From:   =?utf-8?B?eXVlY2hhby56aGFvKOi1tei2iui2hSk=?= 
        <yuechao.zhao@advantech.com.cn>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "345351830@qq.com" <345351830@qq.com>,
        =?utf-8?B?UmFpbmJvdy5aaGFuZyjlvLXnjokp?= 
        <Rainbow.Zhang@advantech.com.cn>,
        =?utf-8?B?eXVueGlhLmxpKOadjuS6kemcnik=?= 
        <yunxia.li@advantech.com.cn>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        =?utf-8?B?SmlhLlN1aSjotL7nnaIp?= <Jia.Sui@advantech.com.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [v3,1/1] adv_mix955x is a scheme that multiplexes PCA9554/PCA9555
 into LED and GPIO
Thread-Topic: [v3,1/1] adv_mix955x is a scheme that multiplexes
 PCA9554/PCA9555 into LED and GPIO
Thread-Index: AQHXP0D7eEIuMrfQO0mIc3d4BQ6oyKrRvmOA
Date:   Mon, 3 May 2021 13:16:25 +0000
Message-ID: <DFBFA86F-1A66-4351-9987-C63CCB40D82A@advantech.com.cn>
References: <tencent_F8EEB847E2CD8A6813D0BF4863964CDF3508@qq.com>
 <b787cd95ad7746d9a04e8cd7f6c0b645@ACNMB2.ACN.ADVANTECH.CORP>
 <CAHp75Vce_-m5uXgpyRO300M1Vw8DX2BmnBPsF5OaUK2_hNDb_A@mail.gmail.com>
In-Reply-To: <CAHp75Vce_-m5uXgpyRO300M1Vw8DX2BmnBPsF5OaUK2_hNDb_A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [222.93.94.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1DE932D0DD303468506104A87021E34@advantech.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keQ0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5DQoNClRoZSByZWFzb24gZm9yIHdyaXRp
bmcgdGhpcyBkcml2ZXIgaXMgdGhhdCBvdXIgY3VzdG9tZXJzIGhvcGUgdGhhdCB0aGUgTEVEIGFu
ZCBHUElPIGNhbiBiZSB1c2VkIG91dCBvZiB0aGUgYm94DQpXaGVuIHRoZXkgdXNpbmcgb3VyIFg4
Ni1QbGF0Zm9ybQ0KDQpBYm91dCB0aGUgZG9jdW1lbnQgYW5kIEFDUEkgZXhwZXJ0LCBJIHdpbGwg
cHJvdmlkZSB0aGVtIGFmdGVyIEkgaW1wcm92ZSB0aGVtLiBQbGVhc2Ugd2FpdCBmb3IgYSBmZXcg
ZGF5cy4NCg0KVGhhbmsgeW91IHZlcnkgbXVjaA0KDQpZdWVjaGFvIFpoYW8NCg0K77u/5ZyoIDIw
MjEvNS8yIOS4i+WNiDY6NTDvvIzigJxBbmR5IFNoZXZjaGVua2/igJ08YW5keS5zaGV2Y2hlbmtv
QGdtYWlsLmNvbT4g5YaZ5YWlOg0KDQogICAgT24gRnJpLCBBcHIgMzAsIDIwMjEgYXQgODoyNyBB
TSB5dWVjaGFvLnpoYW8o6LW16LaK6LaFKQ0KICAgIDx5dWVjaGFvLnpoYW9AYWR2YW50ZWNoLmNv
bS5jbj4gd3JvdGU6DQogICAgPg0KICAgID4gRnJvbTogWXVlY2hhbyBaaGFvIDx5dWVjaGFvLnpo
YW9AYWR2YW50ZWNoLmNvbS5jbj4NCiAgICA+DQogICAgPiBXaXRoIHRoaXMgZHJpdmVyLCB3ZSBj
YW4gbXVsdGlwbGV4IFBDQTk1NTQvUENBOTU1NSBpbnRvIExFRCBhbmQgR1BJTw0KICAgID4gYmFz
ZWQgb24gdGhlIEFDUEkgZGF0YSBvZiBCSU9TLg0KDQogICAgTkFLIGFzIHBlciB2Mi4NCg0KICAg
IFBsZWFzZSwgYWRkIGEgcHJvcGVyIGRvY3VtZW50YXRpb24gYW5kIHNob3cgQUNQSSBleGNlcnB0
LCBhbmQgbGFzdCBidXQNCiAgICBub3QgbGVhc3QgaXMgbWlzc2luZyBqdXN0aWZpY2F0aW9uLg0K
DQoNCiAgICAtLSANCiAgICBXaXRoIEJlc3QgUmVnYXJkcywNCiAgICBBbmR5IFNoZXZjaGVua28N
Cg0K
