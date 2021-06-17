Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D263AADEE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhFQHsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:48:42 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:45808 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQHsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1623915993; x=1626507993;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oBXuai7PiHNFLfV7jN6dMb7z4JMYGKSRwyvw7UK1ubw=;
        b=NUmERFLwJjJBlPfpKWOx4OgCwGncD2OGYY4wa1IxusGiJBnbogFYtu4+HLxUaamx
        LR2WpN0QrFiAze1othK2peOZLv3xLNP+Ez/ZC/8z1Z4H1JxyrLv8Ud1gGRj1t0u0
        a1LnCsKR94HXToUmfQqDZ513sOByhTQyVBQVkNLInMs=;
X-AuditID: c39127d2-a77bc70000001c5e-87-60cafdd91cb9
Received: from florix.phytec.de (florix.phytec.de [172.16.0.118])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AE.8A.07262.9DDFAC06; Thu, 17 Jun 2021 09:46:33 +0200 (CEST)
Received: from Berlix.phytec.de (172.16.0.117) by Florix.phytec.de
 (172.16.0.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 09:46:33 +0200
Received: from Berlix.phytec.de ([fe80::343f:7618:c7ce:97c9]) by
 berlix.phytec.de ([fe80::343f:7618:c7ce:97c9%3]) with mapi id 15.01.2176.009;
 Thu, 17 Jun 2021 09:46:33 +0200
From:   Yunus Bas <Y.Bas@phytec.de>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Thread-Topic: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Thread-Index: AQHXYo50G4kKLVAcj0qT5KJGCUbALasXsyMA
Date:   Thu, 17 Jun 2021 07:46:33 +0000
Message-ID: <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
References: <20210616081949.26618-1-y.bas@phytec.de> <YMm+VXRrRKIHGgmr@dell>
In-Reply-To: <YMm+VXRrRKIHGgmr@dell>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9698F7D1C92DDE45B563D104A2B5A92F@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42JZI8BQpnvz76kEgwkrdS3ufz3KaHF51xw2
        ByaPO9f2sHl83iQXwBTFZZOSmpNZllqkb5fAldF97ipzwRWDiisPN7M3MG7R72Lk5JAQMJHY
        3PmFpYuRi0NIYDmTxMWfr5ggnIeMEo962lkhnE2MEteurGDuYuTgYBNQlLhyKx+kW0TAUGLJ
        iacsIDazgKPE7b1vmUBKhAUiJOYt14AoiZRYuOASO4RtJHHv4QuwchYBVYnnazeCxXkF3CQW
        zfwINl1IwEdi4241kDCngIrEmmX/2EBsRgFZiQ0bzjNDbBKX2PTsOyvE/QISS/ZAxCUERCVe
        Pv4HFVeQaOvpBLuGWUBTYv0ufYhWC4mX7SfYIGxFiSndD6EuEJQ4OfMJywRG8VlINsxC6J6F
        pHsWku5ZSLoXMLKuYhTKzUzOTi3KzNYryKgsSU3WS0ndxAiMsMMT1S/tYOyb43GIkYmD8RCj
        BAezkgivbvGJBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8G3hLwoQE0hNLUrNTUwtSi2CyTByc
        Ug2MCj0n9v1hj23+4Gb/dkpc7Ndoq8kZ68u3Fh9L57nweiejeGXKI+OYBJ/1fY9eCccsv1a1
        8Ym+0Z7g5G3HLz8SD676Pmf+uXWr5CedEXyf+EcsIY2/eFJNZ6aTncbHXztiF3PZdD7ntHXb
        c4o/yOsuwycVZlvDMhvuh63rKm/lZIu8nFK1cQujEktxRqKhFnNRcSIAQ+hHqJ4CAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlLA0KDQpBbSBNaXR0d29jaCwgZGVtIDE2LjA2LjIwMjEgdW0gMTA6MDMgKzAxMDAgc2No
cmllYiBMZWUgSm9uZXM6DQo+IE9uIFdlZCwgMTYgSnVuIDIwMjEsIFl1bnVzIEJhcyB3cm90ZToN
Cj4gDQo+ID4gVGhlIE1GRC1jb3JlIGl0ZXJhdGVzIHRocm91Z2ggYWxsIHN1YmRldmljZXMgb2Yg
dGhlIGNvcnJlc3BvbmRpbmcNCj4gPiBNRkQtZGV2aWNlIGFuZCBjaGVja3MsIGlmIHRoZSBkZXZp
Y2V0cmVlIHN1Ym5vZGUgaGFzIGEgZml0dGluZw0KPiA+IGNvbXBhdGlibGUuDQo+ID4gV2hlbiBu
b3RoaW5nIGlzIGZvdW5kLCBhIHdhcm5pbmcgaXMgdGhyb3duLiBUaGlzIGNhbiBiZSB0aGUgY2Fz
ZSwNCj4gPiB3aGVuIGl0DQo+ID4gaXMgdGhlIGludGVudGlvbiB0byBub3QgdXNlIHRoZSBNRkQt
ZGV2aWNlIHRvIGl0J3MgZnVsbCBjb250ZW50Lg0KPiA+IFRoZXJlZm9yZSwgY2hhbmdlIHRoZSB3
YXJuaW5nIHRvIGEgZGVidWcgcHJpbnQgaW5zdGVhZCwgdG8gYWxzbyBhdm9pZA0KPiA+IGlycml0
YXRpb25zLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1bnVzIEJhcyA8eS5iYXNAcGh5dGVj
LmRlPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9tZmQvbWZkLWNvcmUuYyB8IDIgKy0NCj4gPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9tZmQtY29yZS5jIGIvZHJpdmVycy9tZmQvbWZkLWNv
cmUuYw0KPiA+IGluZGV4IDZmMDJiODAyMmM2ZC4uZTM0Yzk3MDg4OTQzIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbWZkL21mZC1jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL21mZC9tZmQtY29y
ZS5jDQo+ID4gQEAgLTIxMyw3ICsyMTMsNyBAQCBzdGF0aWMgaW50IG1mZF9hZGRfZGV2aWNlKHN0
cnVjdCBkZXZpY2UgKnBhcmVudCwNCj4gPiBpbnQgaWQsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB9DQo+ID4gwqANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlmICghcGRldi0+ZGV2Lm9mX25vZGUpDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl93YXJuKCIlczogRmFpbGVkIHRvIGxvY2F0ZSBvZl9u
b2RlIFtpZDoNCj4gPiAlZF1cbiIsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBwcl9kZWJ1ZygiJXM6IEZhaWxlZCB0byBsb2NhdGUgb2Zfbm9kZSBb
aWQ6DQo+ID4gJWRdXG4iLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjZWxsLT5uYW1lLCBwbGF0Zm9ybV9pZCk7DQo+
ID4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gDQo+IENhbiB5b3UgcHJvdmlkZSBhbiBleGFtcGxlIG9m
IGEgZGV2aWNlIHRyZWUgd2hlcmUgdGhpcyBpcyBhIHByb2JsZW0/DQoNCk9mIGNvdXJzZSwgc29y
cnkgZm9yIHRoZSBwb29yIGRlc2NyaXB0aW9uLg0KDQpIZXJlIGlzIGFuIGV4YW1wbGUgb2YgdGhl
IGlteDZxZGwtcGh5dGVjLXBoeWNvcmUtc29tLmR0c2kgd2hpY2ggdXNlcw0KdGhlIERBOTA2MiBt
dWx0aS1mdW5jdGlvbmFsIGRldmljZS4gVGhlIERBOTA2MiBoYXMgZml2ZSBtZmQtY2VsbA0KZGV2
aWNlcyB3aXRoIGNvbXBhdGlibGVzIGRlZmluZWQgYXMgc3ViZnVuY3Rpb25zLiBUaGUgZGV2aWNl
dHJlZSBuZWVkcw0KYW5kIHVzZXMganVzdCB0aHJlZSBvZiB0aGVtOg0KDQouLi4NCnBtaWM6IHBt
aWNANTggeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCmNvbXBhdGlibGUgPSAiZGxnLGRhOTA2MiI7ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICANCnBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCnBpbmN0cmwtMCA9IDwmcGluY3Ry
bF9wbWljPjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCnJlZyA9
IDwweDU4PjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICANCmludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8xPjsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCmludGVycnVwdHMgPSA8MiBJUlFfVFlQRV9MRVZFTF9M
T1c+OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCmludGVycnVwdC1jb250cm9s
bGVyOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCmdw
aW8tY29udHJvbGxlcjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICANCiNncGlvLWNlbGxzID0gPDI+OyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCmRhOTA2Ml9ydGM6IHJ0
YyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAN
CiAgICBjb21wYXRpYmxlID0gImRsZyxkYTkwNjItcnRjIjsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICANCn07ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICANCmRhOTA2Ml9vbmtleTogb25rZXkgeyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICBjb21wYXRpYmxlID0gImRsZyxk
YTkwNjItb25rZXkiOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCn07ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICANCndhdGNoZG9nIHsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICBjb21wYXRpYmxlID0gImRs
ZyxkYTkwNjItd2F0Y2hkb2ciOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICBk
bGcsdXNlLXN3LXBtOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICANCn0NCi4uLg0KDQoNClNpbmNlIHRoZSBkcml2ZXIgaXRlcmF0ZXMgdGhyb3VnaCB0
aGUgbWZkX2NlbGxzLXN0cnVjdCB0cmllcyBtYXRjaGluZw0KY29tcGF0aWJsZXMgaW4gdGhlIGRl
dmljZXRyZWUgTUZEIG5vZGUsIGl0IHRocm93cyBhIHdhcm5pbmcgd2hlbiB0aGVyZQ0KaXMgbm8g
Y291bnRlcnBhcnQgaW4gdGhlIGRldmljZXRyZWUuDQoNCkluIGZhY3QsIEkgY291bGQgYWxzbyBl
dmFsdXRhdGUgb2RlciBkZXZpY2V0cmVlJ3MgdXNpbmcgTUZELWRldmljZXMgbm90DQp0byBpdCdz
IGZ1bGwgY29udGVudC4NCiANCj4gDQo+IFByb2JhYmx5IHdvcnRoIHBvcHBpbmcgdGhhdCBpbiB0
aGUgY29tbWl0IG1lc3NhZ2UgdG9vLg0KPiANCg0KWWVzLCBJIHdpbGwgc2VuZCBhIHYyIEFTQVAu
IFRoYW5rIHlvdSBmb3IgdGhlIGFkdmljZS4NCg0KUmVnYXJkcywNCll1bnVzDQoNCi0tIA0KTWl0
IGZyZXVuZGxpY2hlbiBHcsO8w59lbg0KWXVudXMgQmFzDQoNCi1Tb2Z0d2FyZSBFbmdpbmVlci0N
ClBIWVRFQyBNZXNzdGVjaG5payBHbWJIDQpSb2JlcnQtS29jaC1TdHIuIDM5DQo1NTEyOSBNYWlu
eg0KR2VybWFueQ0KVGVsLjogKzQ5ICgwKTYxMzEgOTIyMS3CoDQ2Ng0KV2ViOsKgd3d3LnBoeXRl
Yy5kZQ0KDQpTaWUgZmluZGVuIHVucyBhdWNoIGF1ZjrCoEZhY2Vib29rLMKgTGlua2VkSW4swqBY
aW5nLMKgWW91VHViZQ0KDQpQSFlURUMgTWVzc3RlY2huaWsgR21iSCB8IFJvYmVydC1Lb2NoLVN0
ci4gMzkgfCA1NTEyOSBNYWlueiwgR2VybWFueQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUlu
Zy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXIgfA0KSGFuZGVsc3JlZ2lz
dGVyIE1haW56IEhSQiA0NjU2IHwgRmluYW56YW10IE1haW56IHwgU3QuTnIuIDI2NjUwMDYwOCwg
REUNCjE0OTA1OTg1NQ0KVGhpcyBFLU1haWwgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG9yIHBy
aXZpbGVnZWQgaW5mb3JtYXRpb24uIElmIHlvdQ0KYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBp
ZW50IChvciBoYXZlIHJlY2VpdmVkIHRoaXMgRS1NYWlsIGluIGVycm9yKQ0KcGxlYXNlIG5vdGlm
eSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZXN0cm95IHRoaXMgRS1NYWlsLiBBbnkNCnVu
YXV0aG9yaXplZCBjb3B5aW5nLCBkaXNjbG9zdXJlIG9yIGRpc3RyaWJ1dGlvbiBvZiB0aGUgbWF0
ZXJpYWwgaW4NCnRoaXMgRS1NYWlsIGlzIHN0cmljdGx5IGZvcmJpZGRlbi4NCg==
