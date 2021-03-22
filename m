Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9B3343D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCVJpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:45:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3915 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCVJo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:44:58 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F3qL55Mwvz5gmZ;
        Mon, 22 Mar 2021 17:42:53 +0800 (CST)
Received: from dggpemm000004.china.huawei.com (7.185.36.154) by
 DGGEML401-HUB.china.huawei.com (10.3.17.32) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 17:44:51 +0800
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggpemm000004.china.huawei.com (7.185.36.154) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 17:44:51 +0800
Received: from dggpemm000003.china.huawei.com ([7.185.36.128]) by
 dggpemm000003.china.huawei.com ([7.185.36.128]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 17:44:51 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSB1c2I6IGR3YzI6IFVzaW5nIHRhYiBpbnN0ZWFkIG9m?=
 =?gb2312?Q?_blank?=
Thread-Topic: [PATCH] usb: dwc2: Using tab instead of blank
Thread-Index: AQHXHJ7CYXITNeMCTUWEhMMQIr9bg6qKhfYAgAUlsRA=
Date:   Mon, 22 Mar 2021 09:44:50 +0000
Message-ID: <ee6595c7ee57447992a2858feb0da144@hisilicon.com>
References: <1616144456-15381-1-git-send-email-prime.zeng@hisilicon.com>
 <YFRveKbKUxbf/I0y@kroah.com>
In-Reply-To: <YFRveKbKUxbf/I0y@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.69.38.183]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWluYXMsIGdyZWcgay1oDQoNClBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCwgaXQncyBhbiBp
bmNvbXBsZXRlIHZlcnNpb24gc2VudCBieSBtaXN0YWtlLA0KIFNvcnJ5IGZvciB0aGUgbm9pc2Uu
DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogR3JlZyBLcm9haC1IYXJ0bWFuIFtt
YWlsdG86Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+ILeiy83KsbzkOiAyMDIxxOoz1MIx
OcjVIDE3OjMyDQo+IMrVvP7IyzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNv
bT4NCj4gs63LzTogaG1pbmFzQHN5bm9wc3lzLmNvbTsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdl
aS5jb20+Ow0KPiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+INb3zOI6IFJlOiBbUEFUQ0hdIHVzYjogZHdjMjogVXNpbmcgdGFiIGluc3Rl
YWQgb2YgYmxhbmsNCj4gDQo+IE9uIEZyaSwgTWFyIDE5LCAyMDIxIGF0IDA1OjAwOjU1UE0gKzA4
MDAsIFplbmcgVGFvIHdyb3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IFplbmcgVGFvIDxwcmltZS56
ZW5nQGhpc2lsaWNvbi5jb20+DQo+IA0KPiBJIGNhbiBub3QgdGFrZSBwYXRjaGVzIHdpdGhvdXQg
YW55IGNoYW5nZWxvZyB0ZXh0LCBzb3JyeS4NCj4gDQo+IGdyZWcgay1oDQo=
