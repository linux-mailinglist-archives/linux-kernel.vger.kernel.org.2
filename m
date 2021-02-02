Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930B230BAB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhBBJOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:14:23 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:62192 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232875AbhBBJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:12:02 -0500
X-UUID: 775f677d5dd345f9a099aabff81950b6-20210202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=wRjR23K75RHA6M/pTcEC8v+EkXEFCsftGJj/hWO0sw0=;
        b=c3qf5KzoUI+f+Qv2Amr9tJS46m5OKSfal4qmCwiQXBuqDCNjKURAhSEauZTn2fMV1bOBO0nzE8SOi1dukh50g7vLG+esO9HZvdJqQkiOZHojKHPE50pK5SjLQQ/+MW1svwUSnEWROCsNGGHhihxXLU8d9Qu/C6guRyDw972kfXc=;
X-UUID: 775f677d5dd345f9a099aabff81950b6-20210202
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 991221200; Tue, 02 Feb 2021 17:11:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Feb 2021 17:11:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Feb 2021 17:11:08 +0800
Message-ID: <1612257068.30872.1.camel@mtksdaap41>
Subject: Re: [PATCH v6 6/8] drm/mediatek: add matrix_bits private data for
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
Date:   Tue, 2 Feb 2021 17:11:08 +0800
In-Reply-To: <20210202081237.774442-7-hsinyi@chromium.org>
References: <20210202081237.774442-1-hsinyi@chromium.org>
         <20210202081237.774442-7-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1E5761D9C1C19A1F7E42032CD881AABB413824A99811F9EA1FCE8AA218FF0E592000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIFR1ZSwgMjAyMS0wMi0wMiBhdCAxNjoxMiArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBGcm9tOiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlh
dGVrLmNvbT4NCj4gDQo+IEFkZCBtYXRyaXhfYml0cyBhbmQgY29lZmZzX3ByZWNpc2lvbiB0byBj
Y29yciBwcml2YXRlIGRhdGE6DQo+IC0gbWF0cml4IGJpdHMgb2YgbXQ4MTgzIGlzIDEwDQo+IC0g
bWF0cml4IGJpdHMgb2YgbXQ4MTkyIGlzIDExDQo+IA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNr
Lmh1QG1lZGlhdGVrLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25n
cWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSHNpbi1ZaSBXYW5nIDxo
c2lueWlAY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9jY29yci5jIHwgMjcgKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jDQo+IGluZGV4IDZjODY2NzNhODM1YzMu
LjE0MWNiMzZiOWMwN2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9jY29yci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9jY29yci5jDQo+IEBAIC0zMCw3ICszMCw3IEBADQo+ICAjZGVmaW5lIERJU1BfQ0NPUlJfQ09F
Rl80CQkJMHgwMDkwDQo+ICANCj4gIHN0cnVjdCBtdGtfZGlzcF9jY29ycl9kYXRhIHsNCj4gLQl1
MzIgcmVzZXJ2ZWQ7DQo+ICsJdTMyIG1hdHJpeF9iaXRzOw0KPiAgfTsNCj4gIA0KPiAgLyoqDQo+
IEBAIC04NSwyMSArODUsMjIgQEAgdm9pZCBtdGtfY2NvcnJfc3RvcChzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQo+ICAJd3JpdGVsX3JlbGF4ZWQoMHgwLCBjY29yci0+cmVncyArIERJU1BfQ0NPUlJfRU4p
Ow0KPiAgfQ0KPiAgDQo+IC0vKiBDb252ZXJ0cyBhIERSTSBTMzEuMzIgdmFsdWUgdG8gdGhlIEhX
IFMxLjEwIGZvcm1hdC4gKi8NCj4gLXN0YXRpYyB1MTYgbXRrX2N0bV9zMzFfMzJfdG9fczFfMTAo
dTY0IGluKQ0KPiArLyogQ29udmVydHMgYSBEUk0gUzMxLjMyIHZhbHVlIHRvIHRoZSBIVyBTMS5u
IGZvcm1hdC4gKi8NCj4gK3N0YXRpYyB1MTYgbXRrX2N0bV9zMzFfMzJfdG9fczFfbih1NjQgaW4s
IHUzMiBuKQ0KPiAgew0KPiAgCXUxNiByOw0KPiAgDQo+ICAJLyogU2lnbiBiaXQuICovDQo+IC0J
ciA9IGluICYgQklUX1VMTCg2MykgPyBCSVQoMTEpIDogMDsNCj4gKwlyID0gaW4gJiBCSVRfVUxM
KDYzKSA/IEJJVChuICsgMSkgOiAwOw0KPiAgDQo+ICAJaWYgKChpbiAmIEdFTk1BU0tfVUxMKDYy
LCAzMykpID4gMCkgew0KPiAtCQkvKiBpZGVudGl0eSB2YWx1ZSAweDEwMDAwMDAwMCAtPiAweDQw
MCwgKi8NCj4gKwkJLyogaWRlbnRpdHkgdmFsdWUgMHgxMDAwMDAwMDAgLT4gMHg0MDAobXQ4MTgz
KSwgKi8NCj4gKwkJLyogaWRlbnRpdHkgdmFsdWUgMHgxMDAwMDAwMDAgLT4gMHg4MDAobXQ4MTky
KSwgKi8NCj4gIAkJLyogaWYgYmlnZ2VyIHRoaXMsIHNldCBpdCB0byBtYXggMHg3ZmYuICovDQo+
IC0JCXIgfD0gR0VOTUFTSygxMCwgMCk7DQo+ICsJCXIgfD0gR0VOTUFTSyhuLCAwKTsNCj4gIAl9
IGVsc2Ugew0KPiAtCQkvKiB0YWtlIHRoZSAxMSBtb3N0IGltcG9ydGFudCBiaXRzLiAqLw0KPiAt
CQlyIHw9IChpbiA+PiAyMikgJiBHRU5NQVNLKDEwLCAwKTsNCj4gKwkJLyogdGFrZSB0aGUgbisx
IG1vc3QgaW1wb3J0YW50IGJpdHMuICovDQo+ICsJCXIgfD0gKGluID4+ICgzMiAtIG4pKSAmIEdF
Tk1BU0sobiwgMCk7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0dXJuIHI7DQo+IEBAIC0xMTQsNiArMTE1
LDcgQEAgdm9pZCBtdGtfY2NvcnJfY3RtX3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBk
cm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+ICAJdWludDE2X3QgY29lZmZzWzldID0geyAwIH07DQo+
ICAJaW50IGk7DQo+ICAJc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCA9IE5VTEw7DQo+ICsJdTMy
IG1hdHJpeF9iaXRzID0gY2NvcnItPmRhdGEtPm1hdHJpeF9iaXRzOw0KPiAgDQo+ICAJaWYgKCFi
bG9iKQ0KPiAgCQlyZXR1cm47DQo+IEBAIC0xMjIsNyArMTI0LDcgQEAgdm9pZCBtdGtfY2NvcnJf
Y3RtX3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUp
DQo+ICAJaW5wdXQgPSBjdG0tPm1hdHJpeDsNCj4gIA0KPiAgCWZvciAoaSA9IDA7IGkgPCBBUlJB
WV9TSVpFKGNvZWZmcyk7IGkrKykNCj4gLQkJY29lZmZzW2ldID0gbXRrX2N0bV9zMzFfMzJfdG9f
czFfMTAoaW5wdXRbaV0pOw0KPiArCQljb2VmZnNbaV0gPSBtdGtfY3RtX3MzMV8zMl90b19zMV9u
KGlucHV0W2ldLCBtYXRyaXhfYml0cyk7DQo+ICANCj4gIAltdGtfZGRwX3dyaXRlKGNtZHFfcGt0
LCBjb2VmZnNbMF0gPDwgMTYgfCBjb2VmZnNbMV0sDQo+ICAJCSAgICAgICZjY29yci0+Y21kcV9y
ZWcsIGNjb3JyLT5yZWdzLCBESVNQX0NDT1JSX0NPRUZfMCk7DQo+IEBAIC0xOTksOCArMjAxLDEz
IEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfY2NvcnJfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX2Rpc3BfY2NvcnJfZGF0YSBtdDgxODNfY2NvcnJfZHJpdmVyX2RhdGEgPSB7DQo+ICsJ
Lm1hdHJpeF9iaXRzID0gMTAsDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBtdGtfZGlzcF9jY29ycl9kcml2ZXJfZHRfbWF0Y2hbXSA9IHsNCj4gLQl7IC5j
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kaXNwLWNjb3JyIn0sDQo+ICsJeyAuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1jY29yciIsDQo+ICsJICAuZGF0YSA9ICZtdDgx
ODNfY2NvcnJfZHJpdmVyX2RhdGF9LA0KPiAgCXt9LA0KPiAgfTsNCj4gIE1PRFVMRV9ERVZJQ0Vf
VEFCTEUob2YsIG10a19kaXNwX2Njb3JyX2RyaXZlcl9kdF9tYXRjaCk7DQoNCg==

