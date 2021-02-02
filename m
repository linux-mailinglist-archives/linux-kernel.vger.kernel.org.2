Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531D430B75B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 06:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhBBFsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 00:48:04 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:17593 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230168AbhBBFsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 00:48:00 -0500
X-UUID: e483f0c25a2346c6a957f7cfa9873242-20210202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+z6sGY3stDidbHZO1wGRqes+rRr8z1LIfXjlelWJf6Y=;
        b=ZhOCXOzZFhotfhcD4nDZ3HA/7Guij8RUK0ZVOQwO5r+PvZVz6P7FkxKQHmbH/EdmuwRmhsjhqyKEdbNFLW8K3xU1hcSKnRBeGt9g08rNFP+ld7UhrKVsdcC6ixVRtgLLEgTkhLh5MkXMunSVPbgZO6obr628IEVsvmUVetd+mMU=;
X-UUID: e483f0c25a2346c6a957f7cfa9873242-20210202
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1545056741; Tue, 02 Feb 2021 13:47:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Feb 2021 13:47:09 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Feb 2021 13:47:09 +0800
Message-ID: <1612244829.5495.5.camel@mtksdaap41>
Subject: Re: [PATCH v5 6/8] drm/mediatek: add matrix_bits private data for
 ccorr
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Date:   Tue, 2 Feb 2021 13:47:09 +0800
In-Reply-To: <20210201103727.376721-7-hsinyi@chromium.org>
References: <20210201103727.376721-1-hsinyi@chromium.org>
         <20210201103727.376721-7-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2B1541456084131A4B3C3B272388F1487FBE970D39AE745FD1A1D5124297493C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIE1vbiwgMjAyMS0wMi0wMSBhdCAxODozNyArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBGcm9tOiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlh
dGVrLmNvbT4NCj4gDQo+IEFkZCBtYXRyaXhfYml0cyBhbmQgY29lZmZzX3ByZWNpc2lvbiB0byBj
Y29yciBwcml2YXRlIGRhdGE6DQo+IC0gbWF0cml4IGJpdHMgb2YgbXQ4MTgzIGlzIDEwDQo+IC0g
bWF0cml4IGJpdHMgb2YgbXQ4MTkyIGlzIDExDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlh
bmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSHNp
bi1ZaSBXYW5nIDxoc2lueWlAY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jIHwgMzQgKysrKysrKysrKysrKysrKy0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIu
YyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jDQo+IGluZGV4IDZj
ODY2NzNhODM1YzMuLmZiODZmM2E4YjNhMTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9jY29yci5jDQo+IEBAIC0yOSw4ICsyOSwxMCBAQA0KPiAgI2RlZmluZSBE
SVNQX0NDT1JSX0NPRUZfMwkJCTB4MDA4Qw0KPiAgI2RlZmluZSBESVNQX0NDT1JSX0NPRUZfNAkJ
CTB4MDA5MA0KPiAgDQo+ICsjZGVmaW5lIENDT1JSX01BVFJJWF9CSVRTCQkJMTANCj4gKw0KPiAg
c3RydWN0IG10a19kaXNwX2Njb3JyX2RhdGEgew0KPiAtCXUzMiByZXNlcnZlZDsNCj4gKwl1MzIg
bWF0cml4X2JpdHM7DQo+ICB9Ow0KPiAgDQo+ICAvKioNCj4gQEAgLTg1LDIxICs4NywyMiBAQCB2
b2lkIG10a19jY29ycl9zdG9wKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAl3cml0ZWxfcmVsYXhl
ZCgweDAsIGNjb3JyLT5yZWdzICsgRElTUF9DQ09SUl9FTik7DQo+ICB9DQo+ICANCj4gLS8qIENv
bnZlcnRzIGEgRFJNIFMzMS4zMiB2YWx1ZSB0byB0aGUgSFcgUzEuMTAgZm9ybWF0LiAqLw0KPiAt
c3RhdGljIHUxNiBtdGtfY3RtX3MzMV8zMl90b19zMV8xMCh1NjQgaW4pDQo+ICsvKiBDb252ZXJ0
cyBhIERSTSBTMzEuMzIgdmFsdWUgdG8gdGhlIEhXIFMxLm4gZm9ybWF0LiAqLw0KPiArc3RhdGlj
IHUxNiBtdGtfY3RtX3MzMV8zMl90b19zMV9uKHU2NCBpbiwgdTMyIG4pDQo+ICB7DQo+ICAJdTE2
IHI7DQo+ICANCj4gIAkvKiBTaWduIGJpdC4gKi8NCj4gLQlyID0gaW4gJiBCSVRfVUxMKDYzKSA/
IEJJVCgxMSkgOiAwOw0KPiArCXIgPSBpbiAmIEJJVF9VTEwoNjMpID8gQklUKG4gKyAxKSA6IDA7
DQo+ICANCj4gIAlpZiAoKGluICYgR0VOTUFTS19VTEwoNjIsIDMzKSkgPiAwKSB7DQo+IC0JCS8q
IGlkZW50aXR5IHZhbHVlIDB4MTAwMDAwMDAwIC0+IDB4NDAwLCAqLw0KPiArCQkvKiBpZGVudGl0
eSB2YWx1ZSAweDEwMDAwMDAwMCAtPiAweDQwMChtdDgxODMpLCAqLw0KPiArCQkvKiBpZGVudGl0
eSB2YWx1ZSAweDEwMDAwMDAwMCAtPiAweDgwMChtdDgxOTIpLCAqLw0KPiAgCQkvKiBpZiBiaWdn
ZXIgdGhpcywgc2V0IGl0IHRvIG1heCAweDdmZi4gKi8NCj4gLQkJciB8PSBHRU5NQVNLKDEwLCAw
KTsNCj4gKwkJciB8PSBHRU5NQVNLKG4sIDApOw0KPiAgCX0gZWxzZSB7DQo+IC0JCS8qIHRha2Ug
dGhlIDExIG1vc3QgaW1wb3J0YW50IGJpdHMuICovDQo+IC0JCXIgfD0gKGluID4+IDIyKSAmIEdF
Tk1BU0soMTAsIDApOw0KPiArCQkvKiB0YWtlIHRoZSBuKzEgbW9zdCBpbXBvcnRhbnQgYml0cy4g
Ki8NCj4gKwkJciB8PSAoaW4gPj4gKDMyIC0gbikpICYgR0VOTUFTSyhuLCAwKTsNCj4gIAl9DQo+
ICANCj4gIAlyZXR1cm4gcjsNCj4gQEAgLTExNCw2ICsxMTcsNyBAQCB2b2lkIG10a19jY29ycl9j
dG1fc2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkN
Cj4gIAl1aW50MTZfdCBjb2VmZnNbOV0gPSB7IDAgfTsNCj4gIAlpbnQgaTsNCj4gIAlzdHJ1Y3Qg
Y21kcV9wa3QgKmNtZHFfcGt0ID0gTlVMTDsNCj4gKwl1MzIgbWF0cml4X2JpdHM7DQo+ICANCj4g
IAlpZiAoIWJsb2IpDQo+ICAJCXJldHVybjsNCj4gQEAgLTEyMSw4ICsxMjUsMTMgQEAgdm9pZCBt
dGtfY2NvcnJfY3RtX3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fY3J0Y19zdGF0
ZSAqc3RhdGUpDQo+ICAJY3RtID0gKHN0cnVjdCBkcm1fY29sb3JfY3RtICopYmxvYi0+ZGF0YTsN
Cj4gIAlpbnB1dCA9IGN0bS0+bWF0cml4Ow0KPiAgDQo+ICsJaWYgKGNjb3JyLT5kYXRhKQ0KDQpj
Y29yci0+ZGF0YSBpcyBhbHdheXMgdHJ1ZSwgaXNuJ3QgaXQ/DQoNCj4gKwkJbWF0cml4X2JpdHMg
PSBjY29yci0+ZGF0YS0+bWF0cml4X2JpdHM7DQo+ICsJZWxzZQ0KPiArCQltYXRyaXhfYml0cyA9
IENDT1JSX01BVFJJWF9CSVRTOw0KPiArDQo+ICAJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUo
Y29lZmZzKTsgaSsrKQ0KPiAtCQljb2VmZnNbaV0gPSBtdGtfY3RtX3MzMV8zMl90b19zMV8xMChp
bnB1dFtpXSk7DQo+ICsJCWNvZWZmc1tpXSA9IG10a19jdG1fczMxXzMyX3RvX3MxX24oaW5wdXRb
aV0sIG1hdHJpeF9iaXRzKTsNCj4gIA0KPiAgCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIGNvZWZm
c1swXSA8PCAxNiB8IGNvZWZmc1sxXSwNCj4gIAkJICAgICAgJmNjb3JyLT5jbWRxX3JlZywgY2Nv
cnItPnJlZ3MsIERJU1BfQ0NPUlJfQ09FRl8wKTsNCj4gQEAgLTE5OSw4ICsyMDgsMTMgQEAgc3Rh
dGljIGludCBtdGtfZGlzcF9jY29ycl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
ZGlzcF9jY29ycl9kYXRhIG10ODE4M19jY29ycl9kcml2ZXJfZGF0YSA9IHsNCj4gKwkubWF0cml4
X2JpdHMgPSBDQ09SUl9NQVRSSVhfQklUUywNCg0KRHJvcCBDQ09SUl9NQVRSSVhfQklUUyBhbmQg
dXNlIDEwIGhlcmUuDQoNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIG10a19kaXNwX2Njb3JyX2RyaXZlcl9kdF9tYXRjaFtdID0gew0KPiAtCXsgLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtY2NvcnIifSwNCj4gKwl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE4My1kaXNwLWNjb3JyIiwNCj4gKwkgIC5kYXRhID0gJm10ODE4M19j
Y29ycl9kcml2ZXJfZGF0YX0sDQo+ICAJe30sDQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJM
RShvZiwgbXRrX2Rpc3BfY2NvcnJfZHJpdmVyX2R0X21hdGNoKTsNCg0K

