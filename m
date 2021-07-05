Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59563BB7C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGEH1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:27:15 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:62562 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhGEH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1625469876; x=1628061876;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=88hMsxMeWmz42zPU7wU/UsNdTMYw7nJFZYAG4x3Ec30=;
        b=nUTpKksX35FnrR7l51tNVqERxq85rhse+6M5ebGSEFEVSlgpmUvX4SzZwqv4JKCh
        keBX61Tzkx4q9tTOlivYL9CAiQQBqaiCQcLwFI8zl+1mA1JM6Ar63xbEE8cLIO29
        FfrMY3ogkXXATdTTEsiRyuYBf4OJ8Gl/H0Ckno6wF+s=;
X-AuditID: c39127d2-a77bc70000001c5e-43-60e2b3b4ce92
Received: from Diagnostix.phytec.de (Diagnostix.phytec.de [172.16.0.119])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 49.7C.07262.4B3B2E06; Mon,  5 Jul 2021 09:24:36 +0200 (CEST)
Received: from Berlix.phytec.de (172.16.0.117) by Diagnostix.phytec.de
 (172.16.0.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Jul 2021
 09:24:36 +0200
Received: from Berlix.phytec.de ([fe80::343f:7618:c7ce:97c9]) by
 berlix.phytec.de ([fe80::343f:7618:c7ce:97c9%3]) with mapi id 15.01.2176.009;
 Mon, 5 Jul 2021 09:24:36 +0200
From:   Yunus Bas <Y.Bas@phytec.de>
To:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Thread-Topic: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Thread-Index: AQHXYo50G4kKLVAcj0qT5KJGCUbALasXsyMAgAALWACAEsq3gIAAaGmAgAEqgoCAADpBgIAAG2MAgAHE0ICAAWbwAIAAXhiAgAAJhgCAA/HSgA==
Date:   Mon, 5 Jul 2021 07:24:36 +0000
Message-ID: <c2ca83c4d67a47a8e104e5c54a4920cac56312b1.camel@phytec.de>
References: <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
         <YMsHXEP36Vxr7lAb@dell>
         <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
         <YNsid9K4PdUJbKqs@dell>
         <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
         <20210630105557.eaktwdz5p6yzuron@maple.lan> <YNxktsFmlzLcn4+Y@dell>
         <9b5d0003cce92cad57e7712d1e46c78c10f1a0ab.camel@phytec.de>
         <20210702125920.fydyfhwqe7tyr7oi@maple.lan> <YN9cl1/7k/UlllSq@dell>
         <20210702191012.mecgw577ggkabxr6@maple.lan>
In-Reply-To: <20210702191012.mecgw577ggkabxr6@maple.lan>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E982EBDF0FF0D24F9F69A666ACF449B8@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWyRoChXHfL5kcJBrOmaVmceXOX3eL+16OM
        Fpd3zWGzuPp7PYsDi8eKT/oed67tYfP4vEkugDmKyyYlNSezLLVI3y6BK2PRn7+sBU1mFV2H
        r7A0MF4w6WLk4JAQMJFYtoK/i5GLQ0hgPZPElCVbmSGcJ4wSsxtfsUA4GxklVk68ygjSwSag
        KHHlVn4XIyeHiECexPH581hBbGaBFkaJvovyICXCAhES85ZrQJRESixccIkdwq6TmPbwGpjN
        IqAicfjPaTYQm1fATWLnf5hVn5klpmz9wQSS4BSwkPh58hsLiM0oICuxYcN5Zohd4hKbnn0H
        2yshICCxZA9EXEJAVOLl439QcQWJtp5OJpB7mAU0Jdbv0ocwLST+bdCEmKIoMaX7ITvECYIS
        J2c+YZnAKD4LyYJZCM2zEJpnIWmehaR5ASPrKkah3Mzk7NSizGy9gozKktRkvZTUTYzA2Ds8
        Uf3SDsa+OR6HGJk4GA8xSnAwK4nwikx5lCDEm5JYWZValB9fVJqTWnyIUZqDRUmcdwNvSZiQ
        QHpiSWp2ampBahFMlomDU6qBcVets1cjW1fDlfV/Cys3lLKsD1ky8etuu49a09+l9UzcHLsw
        Ztn+7QqrL+xTPFGXJTHZRcOGfYZTqac1553Jz7qTlA3flmWdPbw16dOZhqy22sW9R0V5fm40
        SQjLv5exkOtr4+E8y+mxLybNKLxYpvq+uGvWik6XyLBXSf9LLW51sV9VTOwRUmIpzkg01GIu
        Kk4EAOyMKlKrAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciB0aGUgY2xhcmlmaWNhdGlvbi4gSSdtIG5vdyBhd2FyZSBvbiBob3cgdG8g
aGFuZGxlIE1GRCdzDQppbiB0aGUgZGV2aWNldHJlZS4gQnV0IGdpdmVuIHRoaXMsIHRoZSBkZWZh
dWx0IGJlaGF2aW9yIG9mIE1GRCdzIHNob3VsZA0KZGVmaW5pdGVseSBiZSBkb2N1bWVudGVkIHNp
bmNlIGkgY291bGQgc2VlIG1hbnkgb3RoZXIgZGV2aWNldHJlZQ0KZXhhbXBsZXMgaGFuZGxpbmcg
dGhpcyBhbHNvIG5vdCBpbiB0aGUgcHJvcGVyIG1hbm5lci4NCg0KUmVnYXJkcywgWXVudXMNCg0K
QW0gRnJlaXRhZywgZGVtIDAyLjA3LjIwMjEgdW0gMjA6MTAgKzAxMDAgc2NocmllYiBEYW5pZWwg
VGhvbXBzb246DQo+IE9uIEZyaSwgSnVsIDAyLCAyMDIxIGF0IDA3OjM2OjA3UE0gKzAxMDAsIExl
ZSBKb25lcyB3cm90ZToNCj4gPiBPbiBGcmksIDAyIEp1bCAyMDIxLCBEYW5pZWwgVGhvbXBzb24g
d3JvdGU6DQo+ID4gDQo+ID4gPiBPbiBUaHUsIEp1bCAwMSwgMjAyMSBhdCAwMzozNDo0M1BNICsw
MDAwLCBZdW51cyBCYXMgd3JvdGU6DQo+ID4gPiA+IEFtIE1pdHR3b2NoLCBkZW0gMzAuMDYuMjAy
MSB1bSAxMzozMyArMDEwMCBzY2hyaWViIExlZSBKb25lczoNCj4gPiA+ID4gPiBPbiBXZWQsIDMw
IEp1biAyMDIxLCBEYW5pZWwgVGhvbXBzb24gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBPbiBXZWQsIEp1biAzMCwgMjAyMSBhdCAwNzoyNzozMkFNICswMDAwLCBZdW51cyBCYXMgd3Jv
dGU6DQo+ID4gPiA+ID4gPiA+IEFtIERpZW5zdGFnLCBkZW0gMjkuMDYuMjAyMSB1bSAxNDozOSAr
MDEwMCBzY2hyaWViIExlZQ0KPiA+ID4gPiA+ID4gPiBKb25lczoNCj4gPiA+ID4gPiA+ID4gSW1h
Z2luZSBvbmx5IHJlcXVpcmVkIHBhcnRzIG9mIHRoZSBNRkQgaXMgY29ubmVjdGVkIHRvDQo+ID4g
PiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiBkZXNpZ25lZA0KPiA+ID4gPiA+ID4gPiBzeXN0
ZW0gYW5kIHVucmVxdWlyZWQgcGFydHMgYXJlIG5vdC4gSW4gdGhhdCBjYXNlLCBmdWxseQ0KPiA+
ID4gPiA+ID4gPiBkZXNjcmliaW5nIHRoZQ0KPiA+ID4gPiA+ID4gPiBNRkQgaW4gdGhlIGRldmlj
ZXRyZWUgd291bGRuJ3QgcmVwcmVzZW50IHRoZSBzeXN0ZW0gYXQNCj4gPiA+ID4gPiA+ID4gYWxs
Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUbyBkZXNjcmliZSBoYXJkd2FyZSB0aGF0IGlz
IHByZXNlbnQgYnV0IHVudXNlZCB3ZSB3b3VsZA0KPiA+ID4gPiA+ID4gbm9ybWFsbHkNCj4gPiA+
ID4gPiA+IHVzZQ0KPiA+ID4gPiA+ID4gc3RhdHVzID0gImRpc2FibGVkIi4NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gU28gaWYsIGZvciBleGFtcGxlLCB5b3VyIGJvYXJkIGNhbm5vdCB1c2Ug
dGhlIFJUQyBmb3Igc29tZQ0KPiA+ID4gPiA+ID4gcmVhc29uDQo+ID4gPiA+ID4gPiAocGVyaGFw
cyB0aGUgYm9hcmQgaGFzIG5vIDMyS0h6IG9zY2lsbGF0b3I/KSB0aGVuIHRoZQ0KPiA+ID4gPiA+
ID4gREE5MDYyIHN0aWxsDQo+ID4gPiA+ID4gPiBjb250YWlucyB0aGUgaGFyZHdhcmUgYnV0IGl0
IGlzIHVzZWxlc3MuIFN1Y2ggaGFyZHdhcmUNCj4gPiA+ID4gPiA+IGNvdWxkIGJlDQo+ID4gPiA+
ID4gPiBkZXNjcmliZWQgYXM6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRhOTA2Ml9ydGM6
IHJ0YyB7DQo+ID4gPiA+ID4gPiDCoMKgwqAgY29tcGF0aWJsZSA9ICJkbGcsZGE5MDYyLXJ0YyI7
DQo+ID4gPiA+ID4gPiDCoMKgwqAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiA+ID4gPiA+IH0N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSXMgdGhpcyBzdWZmaWNpZW50IHRvIHN1cHByZXNz
IHRoZSB3YXJuaW5ncyB3aGVuIHRoZQ0KPiA+ID4gPiA+ID4gaGFyZHdhcmUgaXMNCj4gPiA+ID4g
PiA+IG5vdCBmdWxseSBkZXNjcmliZWQ/DQo+ID4gPiA8c25pcD4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBSaWdodC7CoCBUaGlzIGlzIGEgcG90ZW50aWFsIHNvbHV0aW9uLg0KPiA+ID4gPiANCj4g
PiA+ID4gQERhbmllbCwgeW91IGhpdCB0aGUgbmFpbCBvbiB0aGUgaGVhZCA6KS4gVGhhbmsgeW91
IGZvciB0aGF0Lg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBzb2x1dGlvbiB3b3VsZCBpbmRlZWQg
c3VycHJlc3MgdGhlIHdhcm5pbmdzLMKgYnV0IHdoYXQgaXMNCj4gPiA+ID4gdGhlDQo+ID4gPiA+
IGJlbmVmaXQgb2YgdGhpcz8gV2Ugd291bGQgZGVmaW5lIG5ldmVyIHVzZWQgZGV2aWNlIG5vZGVz
IGp1c3QNCj4gPiA+ID4gdG8NCj4gPiA+ID4gc2F0aXNmeSB0aGUgZHJpdmVyLg0KPiA+ID4gDQo+
ID4gPiBJIHdvdWxkIHNheSB0aGF0IGRvaW5nIHNvIHJlc29sdmVzIGFuIGF3a3dhcmQgYW1iaWd1
aXR5IG9mDQo+ID4gPiBpbnRlcnByZXRhdGlvbiB3LnIudC4gdGhlIGJpbmRpbmdzLg0KPiA+ID4g
DQo+ID4gPiAxLiBUaGUgTUZEIGRldmljZSBjb21wYXRpYmxlICJkbGcsZGE5MDYyIiB0ZWxscyB0
aGUgT1MgdGhhdCB3ZQ0KPiA+ID4gwqDCoCBoYXZlIGFuIERBOTA2Mi4gQW4gREE5MDYyIGNvbnRh
aW5zIHNpeCBmdW5jdGlvbnMgYW5kIHRoaXMgY2FuDQo+ID4gPiBiZQ0KPiA+ID4gwqDCoCBpbmZl
cnJlZCAqZW50aXJlbHkqIGZyb20gdGhlIE1GRCBjb21wYXRpYmxlIHN0cmluZy4gV2UgZG8gbm90
DQo+ID4gPiDCoMKgIG5lZWQgYW55IHN1Ym5vZGVzIHRvIHRlbGwgdXMgdGhhdCBhIERBOTA2MiBj
b250YWlucyBhbiBSVEMuDQo+ID4gPiBUaGUgT1MNCj4gPiA+IMKgwqAgY2FuIChhbmQgaW4gdGhp
cyBjYXNlLCBkb2VzKSBhbHJlYWR5IGtub3cgdGhhdCB0aGVyZSBpcyBhbiBSVEMNCj4gPiA+IMKg
wqAgYmVjYXVzZSB3ZSBoYXZlIGEgREE5MDYyIChhbmQgYSBkYXRhc2hlZXQpLg0KPiA+ID4gDQo+
ID4gPiAyLiBUaGUgZGVmYXVsdCBiZWhhdmlvdXIgd2hlbiBhIG5vZGUgaGFzIG5vIHN0YXR1cyBm
aWVsZCBpcyB0bw0KPiA+ID4gwqDCoCBhc3N1bWUgdGhhdCBpcyBpcyAqZW5hYmxlZCouDQo+ID4g
PiANCj4gPiA+IEJhc2VkIG9uICMxIGFuZCAjMiBhYm92ZSB0aGVuIGFzc3VtaW5nIHRoYXQgYSBE
VCB0aGF0IG9taXRzIHRoZQ0KPiA+ID4gc3ViLW5vZGVzIGFjdHVhbGx5IG1lYW5zICJkaXNhYmxl
IHRoZSBSVEMiIGlzIHJpc2t5LiAjMiBtaWdodA0KPiA+ID4gYWN0dWFsbHkgbWFrZSBpdCBtb3Jl
IG5hdHVyYWwgdG8gYXNzdW1lIHRoYXQgdGhlIGRldmljZSBpcw0KPiA+ID4gcHJlc2VudCBhbmQN
Cj4gPiA+IGZ1bmN0aW9uYWwgYmVjYXVzZSB0aGVyZSBpcyBubyBzdGF0dXMgZmllbGQgdG8gdGVs
bCBNRkQgKm5vdCogdG8NCj4gPiA+IGluaXRpYWxpemUgaXQuDQo+ID4gDQo+ID4gRXhhY3RseS7C
oCBOaWNlbHkgcHV0Lg0KPiA+IA0KPiA+ID4gVGhhdCBsZWF2ZXMgdXMgaW4gYSBzaXR1YXRpb24g
d2hlcmUgdGhlcmUgaXMgbm8gd2F5IHRvIGNvcnJlY3RseQ0KPiA+ID4gZ3Vlc3MNCj4gPiA+IHRo
ZSBhdXRob3JzIGludGVudCB3aGVuIHN1Yi1ub2RlcyBhcmUgb21pdHRlZCBmcm9tIHRoZSBEVC4N
Cj4gPiANCj4gPiA+IEdpdmVuIHRoaXMgaXMgc29tZXRoaW5nIG9mIGEgY29ybmVyIGNhc2UgYW5k
IHRoZSBkb2N1bWVudGF0aW9uIGlzDQo+ID4gPiBhbWJpZ3VvdXMgdGhlbiBhIHdhcm5pbmcgb2Yg
dGhlIGF1dGhvciBkb2VzIG5vdCBjbGVhcmx5IHJlc29sdmUNCj4gPiA+IHRoZQ0KPiA+ID4gYW1i
aWd1aXR5IHNlZW1zIHJlYXNvbmFibGUuDQo+ID4gDQo+ID4gSSdtIGhhdmluZyB0cm91YmxlIHBh
cnNpbmcgdGhpcyBwYXJ0Lg0KPiANCj4gVGhhdCdzIHF1aXRlIHJlYXNvbmFibGUgYmVjYXVzZSB3
YXMgaXMgd3JpdHRlbiBpcyBub25zZW5zZSENCj4gUGVyaGFwcyBzL3dhcm5pbmcgb2YgdGhlIGF1
dGhvci93YXJuaW5nIGlmIHRoZSBhdXRob3IvIHdpbGwgaGVscA0KPiBidXQgdGhlcmUgYXJlIHN0
aWxsIHRvbyBtYW55IHdvcmRzIHRvIHNheSBzb21ldGhpbmcgdmVyeSBzaW1wbGUuDQo+IFRoZSB3
aG9sZSBsYXN0IHBhcmFncmFwaCBjb3VsZCBzaW1wbHkgc2F5Og0KPiANCj4gwqAgVGhlIGJpbmRp
bmdzIGRvY3VtZW50YXRpb24gaXMgYW1iaWd1b3VzIHNvIGlzIGl0IHJlYXNvbmFibGUNCj4gwqAg
Zm9yIHRoZSBPUyB0byBpc3N1ZSBhIHdhcm5pbmcgd2hlbiB0aGUgZGV2aWNldHJlZSBhdXRob3Ig
ZG9lcw0KPiDCoCBub3QgY2xlYXJseSByZXNvbHZlIHRoZSBhbWJpZ3VpdHkuDQo+IA0KPiBUaGlz
IGlzIHN0aWxsIGEgbG9uZyBzZW50ZW5jZSBidXQgYXQgbGVhc3QgaXQgaXMgbm8gbG9uZ2VyIGEN
Cj4gY29tcGxpY2F0ZWQgb25lIQ0KPiANCj4gDQo+IERhbmllbC4NCg0KLS0gDQpNaXQgZnJldW5k
bGljaGVuIEdyw7zDn2VuDQpZdW51cyBCYXMNCg0KLVNvZnR3YXJlIEVuZ2luZWVyLQ0KUEhZVEVD
IE1lc3N0ZWNobmlrIEdtYkgNClJvYmVydC1Lb2NoLVN0ci4gMzkNCjU1MTI5IE1haW56DQpHZXJt
YW55DQpUZWwuOiArNDkgKDApNjEzMSA5MjIxLSA0NjYNCldlYjogd3d3LnBoeXRlYy5kZQ0KDQpT
aWUgZmluZGVuIHVucyBhdWNoIGF1ZjogRmFjZWJvb2ssIExpbmtlZEluLCBYaW5nLCBZb3VUdWJl
DQoNClBIWVRFQyBNZXNzdGVjaG5payBHbWJIIHwgUm9iZXJ0LUtvY2gtU3RyLiAzOSB8IDU1MTI5
IE1haW56LCBHZXJtYW55DQpHZXNjaMOkZnRzZsO8aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1p
dGV6a2ksIERpcGwuLUluZy4gQm9kbyBIdWJlciB8DQpIYW5kZWxzcmVnaXN0ZXIgTWFpbnogSFJC
IDQ2NTYgfCBGaW5hbnphbXQgTWFpbnogfCBTdC5Oci4gMjY2NTAwNjA4LCBERQ0KMTQ5MDU5ODU1
DQpUaGlzIEUtTWFpbCBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgb3IgcHJpdmlsZWdlZCBpbmZv
cm1hdGlvbi4gSWYgeW91DQphcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgKG9yIGhhdmUg
cmVjZWl2ZWQgdGhpcyBFLU1haWwgaW4gZXJyb3IpDQpwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIg
aW1tZWRpYXRlbHkgYW5kIGRlc3Ryb3kgdGhpcyBFLU1haWwuIEFueQ0KdW5hdXRob3JpemVkIGNv
cHlpbmcsIGRpc2Nsb3N1cmUgb3IgZGlzdHJpYnV0aW9uIG9mIHRoZSBtYXRlcmlhbCBpbg0KdGhp
cyBFLU1haWwgaXMgc3RyaWN0bHkgZm9yYmlkZGVuLg0KDQo=
