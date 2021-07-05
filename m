Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12C03BB838
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhGEHw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:52:59 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:63388 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEHw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1625471419; x=1628063419;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oogMehEDsCkbfzRhFf1VEz10kYjp8oG0WM32FUe0mbY=;
        b=Tl7aY5rQj8rk+Ao+YrGcTI5+1RLuj3Fe/g73G/Pkb6JbmFRhqwLwDYo8OQk789YZ
        Xdr6v1L5z/csxjlFuVlGFg8eD2brP0JYPBdEzw1JSl7ybsBYB11Jl7BOC5WkfDdm
        hpxaeID4XskdVIM+/UJ/jayxgAFMnDP8dDw3Tnu8MNo=;
X-AuditID: c39127d2-a77bc70000001c5e-71-60e2b9bb436a
Received: from berlix.phytec.de (Berlix.phytec.de [172.16.0.117])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 78.EC.07262.BB9B2E06; Mon,  5 Jul 2021 09:50:19 +0200 (CEST)
Received: from Berlix.phytec.de (172.16.0.117) by Berlix.phytec.de
 (172.16.0.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Jul 2021
 09:50:19 +0200
Received: from Berlix.phytec.de ([fe80::343f:7618:c7ce:97c9]) by
 berlix.phytec.de ([fe80::343f:7618:c7ce:97c9%3]) with mapi id 15.01.2176.009;
 Mon, 5 Jul 2021 09:50:19 +0200
From:   Yunus Bas <Y.Bas@phytec.de>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Thread-Topic: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Thread-Index: AQHXYo50G4kKLVAcj0qT5KJGCUbALasXsyMAgAALWACAEsq3gIAAaGmAgAEqgoCAADpBgIAAG2MAgAHE0ICAAWbwAIAAXhiAgAAJhgCAA/HSgIAAAecAgAAFSgA=
Date:   Mon, 5 Jul 2021 07:50:19 +0000
Message-ID: <614d720b0f468334e74a4e29b626d498f25a7c31.camel@phytec.de>
References: <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
         <YNsid9K4PdUJbKqs@dell>
         <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
         <20210630105557.eaktwdz5p6yzuron@maple.lan> <YNxktsFmlzLcn4+Y@dell>
         <9b5d0003cce92cad57e7712d1e46c78c10f1a0ab.camel@phytec.de>
         <20210702125920.fydyfhwqe7tyr7oi@maple.lan> <YN9cl1/7k/UlllSq@dell>
         <20210702191012.mecgw577ggkabxr6@maple.lan>
         <c2ca83c4d67a47a8e104e5c54a4920cac56312b1.camel@phytec.de>
         <YOK1RvQI1rHvaXEy@dell>
In-Reply-To: <YOK1RvQI1rHvaXEy@dell>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4D4A0B6C4B1CC4EAA083F63282F3454@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWyRoChVHf3zkcJBlfW6ViceXOX3eL+16OM
        Fpd3zWGzuPp7PYsDi8eKT/oed67tYfP4vEkugDmKyyYlNSezLLVI3y6BK+P3h48sBQ3CFVMX
        XmdpYDwg1MXIySEhYCJxsf0TexcjF4eQwHImiYlTl7JCOA8YJebPv80C4WwEclZNZ+xi5OBg
        E1CUuHIrH6RbRMBQYsmJp2A1zAIHGSW2blnBBlIjLBAhMW+5BkRNpMTCBZfANogIdDFKvP93
        iQUkwSKgInFl3jVWkHpeATeJEz0WELs+M0v8+NEMVsMJVNP9eC0ziM0oICuxYcN5MJtZQFxi
        07PvrBAvCEgs2QMRlxAQlXj5+B9UXEGiraeTCWQ+s4CmxPpd+hCtFhKf2t4yQtiKElO6H7KD
        2LwCghInZz5hmcAoPgvJhlkI3bOQdM9C0j0LSfcCRtZVjEK5mcnZqUWZ2XoFGZUlqcl6Kamb
        GIExeHii+qUdjH1zPA4xMnEwHmKU4GBWEuEVmfIoQYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        Bt6SMCGB9MSS1OzU1ILUIpgsEwenVANj4ovTTDcS9/IHvZJWavrEdfSKzqGTMUfubV3FxHF0
        66uKBWcfVrG6ppt5zfsY8i54Y3e+Bu+k2H1fvmY4MV77eydr3ZKux25rfrD+MJswUdTxkMjP
        lz/9d9V8Drp2yGRFkVjpr/kRgVPOtKRGr/96vMlZskKed9IUdR8ZbdWQlPBZVYvbLSp7lViK
        MxINtZiLihMBxHw3nK8CAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gTW9udGFnLCBkZW0gMDUuMDcuMjAyMSB1bSAwODozMSArMDEwMCBzY2hyaWViIExlZSBKb25l
czoNCj4gT24gTW9uLCAwNSBKdWwgMjAyMSwgWXVudXMgQmFzIHdyb3RlOg0KPiANCj4gPiBUaGFu
ayB5b3UgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBJJ20gbm93IGF3YXJlIG9uIGhvdyB0byBoYW5k
bGUNCj4gPiBNRkQncw0KPiA+IGluIHRoZSBkZXZpY2V0cmVlLiBCdXQgZ2l2ZW4gdGhpcywgdGhl
IGRlZmF1bHQgYmVoYXZpb3Igb2YgTUZEJ3MNCj4gPiBzaG91bGQNCj4gPiBkZWZpbml0ZWx5IGJl
IGRvY3VtZW50ZWQgc2luY2UgaSBjb3VsZCBzZWUgbWFueSBvdGhlciBkZXZpY2V0cmVlDQo+ID4g
ZXhhbXBsZXMgaGFuZGxpbmcgdGhpcyBhbHNvIG5vdCBpbiB0aGUgcHJvcGVyIG1hbm5lci4NCj4g
DQo+IEluIHRoZSA4IHllYXJzIEkndmUgYmVlbiB3b3JraW5nIHdpdGggRFQgYW5kIE1GRCwgdGhp
cyBpcyB0aGUgZmlyc3QNCj4gdGltZSB0aGlzIHBhcnRpY3VsYXIgaXNzdWUgaGFzIGFyaXNlbiwg
YnV0IGlmIHlvdSdkIGxpa2UgdG8gc3VibWl0DQo+IHN1Y2ggYSBkb2N1bWVudCwgaXQgd2lsbCBi
ZSBjb25zaWRlcmVkIGZvciBpbmNsdXNpb24uDQoNClRoaXMgaXMgYmVjYXVzZSBvbiBvbGRlciBr
ZXJuZWwgdmVyc2lvbnMgKG9yIGF0IGxlYXN0IG9uIHRoZSBsYXN0IExUUykNCnRoZXJlIHdhcyBu
byB3YXJuaW5nIGluIHRoZSBmaXJzdCBwbGFjZS4gVGhlIHdhcm5pbmcgd2FzIGFkZGVkIHdpdGgg
dGhlDQpmb2xsb3dpbmcgcGF0Y2ggb2YgeW91cnM6DQoNCkNvbW1pdCA0NjZhNjJkNzY0MmYgKCJt
ZmQ6IGNvcmU6IE1ha2UgYSBiZXN0IGVmZm9ydCBhdHRlbXB0IHRvIG1hdGNoDQpkZXZpY2VzIHdp
dGggdGhlIGNvcnJlY3Qgb2Zfbm9kZXMiKQ0KDQp3aGljaCB3YXMgYWRkZWQgYXJvdW5kIGxhc3Qg
eWVhci4NCg0KPiANCj4gUmVhbGx5IHBsZWFzZWQgeW91IGhhdmUgdGhpcyBmaWd1cmVkIG91dCB0
aG91Z2guDQo+IA0KDQotLSANCk1pdCBmcmV1bmRsaWNoZW4gR3LDvMOfZW4NCll1bnVzIEJhcw0K
DQotU29mdHdhcmUgRW5naW5lZXItDQpQSFlURUMgTWVzc3RlY2huaWsgR21iSA0KUm9iZXJ0LUtv
Y2gtU3RyLiAzOQ0KNTUxMjkgTWFpbnoNCkdlcm1hbnkNClRlbC46ICs0OSAoMCk2MTMxIDkyMjEt
IDQ2Ng0KV2ViOiB3d3cucGh5dGVjLmRlDQoNClNpZSBmaW5kZW4gdW5zIGF1Y2ggYXVmOiBGYWNl
Ym9vaywgTGlua2VkSW4sIFhpbmcsIFlvdVR1YmUNCg0KUEhZVEVDIE1lc3N0ZWNobmlrIEdtYkgg
fCBSb2JlcnQtS29jaC1TdHIuIDM5IHwgNTUxMjkgTWFpbnosIEdlcm1hbnkNCkdlc2Now6RmdHNm
w7xocmVyOiBEaXBsLi1JbmcuIE1pY2hhZWwgTWl0ZXpraSwgRGlwbC4tSW5nLiBCb2RvIEh1YmVy
IHwNCkhhbmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8IEZpbmFuemFtdCBNYWlueiB8IFN0
Lk5yLiAyNjY1MDA2MDgsIERFDQoxNDkwNTk4NTUNClRoaXMgRS1NYWlsIG1heSBjb250YWluIGNv
bmZpZGVudGlhbCBvciBwcml2aWxlZ2VkIGluZm9ybWF0aW9uLiBJZiB5b3UNCmFyZSBub3QgdGhl
IGludGVuZGVkIHJlY2lwaWVudCAob3IgaGF2ZSByZWNlaXZlZCB0aGlzIEUtTWFpbCBpbiBlcnJv
cikNCnBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZGVzdHJveSB0aGlz
IEUtTWFpbC4gQW55DQp1bmF1dGhvcml6ZWQgY29weWluZywgZGlzY2xvc3VyZSBvciBkaXN0cmli
dXRpb24gb2YgdGhlIG1hdGVyaWFsIGluDQp0aGlzIEUtTWFpbCBpcyBzdHJpY3RseSBmb3JiaWRk
ZW4uDQoNCg==
