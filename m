Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6BF35C42C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbhDLKj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:39:29 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10]:53880 "EHLO
        netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbhDLKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:39:24 -0400
Received: from 172.17.5.170 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey256); Mon, 12 Apr 2021 10:39:07 GMT
Received: from ex01.beckhoff.com (172.17.2.168) by ex04.beckhoff.com
 (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.4; Mon, 12 Apr
 2021 12:39:03 +0200
Received: from ex01.beckhoff.com ([fe80::8caa:afd3:30d9:a097]) by
 ex01.beckhoff.com ([fe80::8caa:afd3:30d9:a097%7]) with mapi id
 15.01.2242.004; Mon, 12 Apr 2021 12:39:03 +0200
From:   linux-kernel-dev <linux-kernel-dev@beckhoff.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: pmc_atom: Match all Beckhoff Automation
 baytrail boards with critclk_systems DMI table
Thread-Topic: [PATCH] platform/x86: pmc_atom: Match all Beckhoff Automation
 baytrail boards with critclk_systems DMI table
Thread-Index: AQHXL4BPaMnkOe6iy0OPHOeVEHiMsqqwj5SA
Date:   Mon, 12 Apr 2021 10:39:03 +0000
Message-ID: <f406a5a6c6bfe0e458925821b6830e9dc5a151c1.camel@beckhoff.com>
References: <20210412090430.167463-1-linux-kernel-dev@beckhoff.com>
         <CAHp75VfLQBDv-Bcj5=Ksv6kp2XH2v8msDvNjsdj6=WZiCk=Q9w@mail.gmail.com>
In-Reply-To: <CAHp75VfLQBDv-Bcj5=Ksv6kp2XH2v8msDvNjsdj6=WZiCk=Q9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.136.117.151]
Content-Type: text/plain; charset="utf-8"
Content-ID: <43D189DD6A60F143BCB75E120EABFEA1@beckhoff.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW8sIDIwMjEtMDQtMTIgYXQgMTI6NDMgKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToN
Cj4NCj4gT24gTW9uLCBBcHIgMTIsIDIwMjEgYXQgMTI6MjkgUE0gU3RlZmZlbiBEaXJrd2lua2Vs
DQo+IDxsaW51eC1rZXJuZWwtZGV2QGJlY2tob2ZmLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBTdGVmZmVuIERpcmt3aW5rZWwgPHMuZGlya3dpbmtlbEBiZWNraG9mZi5jb20+DQo+ID4NCj4g
PiBwbWNfcGx0X2NsayogY2xvY2tzIGFyZSB1c2VkIGZvciBldGhlcm5ldCBjb250cm9sbGVycyBz
byBuZWVkIHRvIHN0YXkNCj4gPiB0dXJuZWQgb24uIFRoaXMgYWRkcyB0aGUgYWZmZWN0ZWQgYm9h
cmQgZmFtaWx5IHRvIGNyaXRjbGtfc3lzdGVtcyBETUkNCj4gPiB0YWJsZSBzbyB0aGUgY2xvY2tz
IGFyZSBtYXJrZWQgYXMgQ0xLX0NSSVRJQ0FMIGFuZCBub3QgdHVybmVkIG9mZi4NCj4gPg0KPiA+
IFRoaXMgcmVwbGFjZXMgdGhlIHByZXZpb3NseSBsaXN0ZWQgYm9hcmRzIHdpdGggYSBtYXRjaCBm
b3IgdGhlIHdob2xlDQo+DQo+ICIuLi5wcmV2aW91c2x5Li4uIg0KdGhhbmtzDQoNCj4NCj4gPiBk
ZXZpY2UgZmFtaWx5LiBUaGVyZSBhcmUgbmV3IGFmZmVjdGVkIGJvYXJkcyB0aGF0IHdvdWxkIG90
aGVyd2lzZSBuZWVkDQo+ID4gdG8gYmUgbGlzdGVkLiBUaGVyZSBhcmUgb25seSBmZXcgdW5hZmZl
Y3RlZCBib2FyZHMgaW4gdGhlIGZhbWlseSBhbmQNCj4NCj4gIi4uLm9ubHkgYSBmZXcuLi4iDQp3
aWxsIGRyb3AgdGhlIHBocmFzZQ0KDQo+DQo+ID4gaGF2aW5nIHRoZSBjbG9ja3MgdHVybmVkIG9u
IGlzIG5vdCBhbiBpc3N1ZSBvbiB0aG9zZS4NCj4NCj4gIi4uLm5vdCBhbiBpc3N1ZS4iDQpOb3Qg
YW4gaXNzdWUgZm9yIHRoZXNlIGluZHVzdHJpYWwgUENzIGFzIHNsZWVwIGlzIGFuIHVudXN1YWwg
dXNlIGNhc2UuDQpIYXZpbmcgbm8gZXRoZXJuZXQgYWZ0ZXIgYm9vdC9zbGVlcCBpcyB3b3JzZS4N
Cg0KPg0KPiA+IEZpeGVzOiA2NDhlOTIxODg4YWQgKCJjbGs6IHg4NjogU3RvcCBtYXJraW5nIGNs
b2NrcyBhcyBDTEtfSVNfQ1JJVElDQUwiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZmZW4gRGly
a3dpbmtlbCA8cy5kaXJrd2lua2VsQGJlY2tob2ZmLmNvbT4NCj4NCj4gSSdtIGFmcmFpZCBpdCdz
IGEgYml0IHRvbyBtdWNoLiBJcyB0aGVyZSBhbnkgZ3VhcmFudGVlIGFsbCB0aGUgYm9hcmRzDQo+
IGJhc2VkIG9uIHg4NiB3aWxsIGJlIEJheXRyYWlsIG9ubHk/DQo+DQpTb3JyeSwgSSBndWVzcyBJ
IHNob3VsZCBtYWtlIHRoaXMgY2xlYXJlciBpbiB0aGUgbWVzc2FnZS4NCkFsbCBib2FyZHMgd2l0
aCAiQ0J4eDYzIiBhcmUgQmF5dHJhaWwuDQoNCg0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywN
Cj4gQW5keSBTaGV2Y2hlbmtvDQo+DQoNCkJlY2tob2ZmIEF1dG9tYXRpb24gR21iSCAmIENvLiBL
RyB8IE1hbmFnaW5nIERpcmVjdG9yOiBEaXBsLiBQaHlzLiBIYW5zIEJlY2tob2ZmIFJlZ2lzdGVy
ZWQgb2ZmaWNlOiBWZXJsLCBHZXJtYW55IHwgUmVnaXN0ZXIgY291cnQ6IEd1ZXRlcnNsb2ggSFJB
IDcwNzUNCg0K

