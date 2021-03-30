Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5160134ECEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhC3Px6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:53:58 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26439 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232019AbhC3Pxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:53:43 -0400
X-UUID: e5880d103ace46bf9422aabf77eb5f49-20210330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ra2tQWislgrrvR/NNOOoxRe0xoVjwCWjHOtfv1mHfLs=;
        b=D6hOLsg/MHGNArJKE1W6jM63Zkti4CNPCCwZfHQRFqf65/AvqS737uKFbf17+kj7QOnjwhiV8rG18O4akuQFqMILdMZUrEwMcTDiFHCtZ7+/9s/k4nUXoPMFFhTMVwuQrZtXmficshBrC7Tpx0NoE+96ptVSQgZfYJ4aEN0ygvM=;
X-UUID: e5880d103ace46bf9422aabf77eb5f49-20210330
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1995736300; Tue, 30 Mar 2021 23:53:39 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 23:53:37 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 30 Mar 2021 23:53:36 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        <rex-bc.chen@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 3/3] drm/mediatek: dpi: add bus format negociation
Date:   Tue, 30 Mar 2021 23:53:30 +0800
Message-ID: <20210330155330.28759-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20210330155330.28759-1-jitao.shi@mediatek.com>
References: <20210330155330.28759-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C82F1249AC34DA01D8B6F8A0C1B09D132640BF19AE22DA65BDDE8C39F907EC832000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRoZSBhdG9taWNfZ2V0X291dHB1dF9idXNfZm10cywgYXRvbWljX2dldF9pbnB1dF9idXNf
Zm10cyB0byBuZWdvY2lhdGUNCnRoZSBwb3NzaWJsZSBvdXRwdXQgYW5kIGlucHV0IGZvcm1hdHMg
Zm9yIHRoZSBjdXJyZW50IG1vZGUgYW5kIG1vbml0b3IsDQphbmQgdXNlIHRoZSBuZWdvdGlhdGVk
IGZvcm1hdHMgaW4gYSBiYXNpYyBhdG9taWNfY2hlY2sgY2FsbGJhY2suDQoNClNpZ25lZC1vZmYt
Ynk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgfCA5NiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5MSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCmluZGV4IDg3YmIyNzY0OWM0Yy4u
NGU0NWQxYjAxYjBjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KQEAgLTgxLDYg
KzgxLDggQEAgc3RydWN0IG10a19kcGkgew0KIAlzdHJ1Y3QgcGluY3RybCAqcGluY3RybDsNCiAJ
c3RydWN0IHBpbmN0cmxfc3RhdGUgKnBpbnNfZ3BpbzsNCiAJc3RydWN0IHBpbmN0cmxfc3RhdGUg
KnBpbnNfZHBpOw0KKwl1bnNpZ25lZCBpbnQgaW5fYnVzX2Zvcm1hdDsNCisJdW5zaWduZWQgaW50
IG91dF9idXNfZm9ybWF0Ow0KIAlib29sIGRkcl9lZGdlX3NlbDsNCiAJaW50IHJlZmNvdW50Ow0K
IH07DQpAQCAtNTM0LDYgKzUzNiw5MiBAQCBzdGF0aWMgaW50IG10a19kcGlfc2V0X2Rpc3BsYXlf
bW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KIAlyZXR1cm4gMDsNCiB9DQogDQorI2RlZmluZSBN
QVhfT1VUUFVUX1NFTF9GT1JNQVRTCTINCisNCitzdGF0aWMgdTMyICptdGtfZHBpX2JyaWRnZV9h
dG9taWNfZ2V0X291dHB1dF9idXNfZm10cyhzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlLA0KKwkJ
CQkJc3RydWN0IGRybV9icmlkZ2Vfc3RhdGUgKmJyaWRnZV9zdGF0ZSwNCisJCQkJCXN0cnVjdCBk
cm1fY3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSwNCisJCQkJCXN0cnVjdCBkcm1fY29ubmVjdG9yX3N0
YXRlICpjb25uX3N0YXRlLA0KKwkJCQkJdW5zaWduZWQgaW50ICpudW1fb3V0cHV0X2ZtdHMpDQor
ew0KKwlzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSA9ICZjcnRjX3N0YXRlLT5tb2RlOw0K
Kwl1MzIgKm91dHB1dF9mbXRzOw0KKwlzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gYnJpZGdlX3RvX2Rw
aShicmlkZ2UpOw0KKw0KKwkqbnVtX291dHB1dF9mbXRzID0gMDsNCisNCisJb3V0cHV0X2ZtdHMg
PSBrY2FsbG9jKE1BWF9PVVRQVVRfU0VMX0ZPUk1BVFMsIHNpemVvZigqb3V0cHV0X2ZtdHMpLA0K
KwkJCSAgICAgIEdGUF9LRVJORUwpOw0KKwlpZiAoIW91dHB1dF9mbXRzKQ0KKwkJcmV0dXJuIE5V
TEw7DQorDQorCS8qIERlZmF1bHQgOGJpdCBSR0IgZmFsbGJhY2sgKi8NCisJaWYgKGRwaS0+Y29u
Zi0+ZHVhbF9lZGdlKSB7DQorCQlvdXRwdXRfZm10c1swXSA9ICBNRURJQV9CVVNfRk1UX1JHQjg4
OF8yWDEyX0xFOw0KKwkJb3V0cHV0X2ZtdHNbMV0gPSAgTUVESUFfQlVTX0ZNVF9SR0I4ODhfMlgx
Ml9CRTsNCisJCSpudW1fb3V0cHV0X2ZtdHMgPSAyOw0KKwl9IGVsc2Ugew0KKwkJb3V0cHV0X2Zt
dHNbMF0gPSAgTUVESUFfQlVTX0ZNVF9SR0I4ODhfMVgyNDsNCisJCSpudW1fb3V0cHV0X2ZtdHMg
PSAxOw0KKwl9DQorDQorCXJldHVybiBvdXRwdXRfZm10czsNCit9DQorDQorI2RlZmluZSBNQVhf
SU5QVVRfU0VMX0ZPUk1BVFMJMQ0KKw0KK3N0YXRpYyB1MzIgKm10a19kcGlfYnJpZGdlX2F0b21p
Y19nZXRfaW5wdXRfYnVzX2ZtdHMoc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCisJCQkJCXN0
cnVjdCBkcm1fYnJpZGdlX3N0YXRlICpicmlkZ2Vfc3RhdGUsDQorCQkJCQlzdHJ1Y3QgZHJtX2Ny
dGNfc3RhdGUgKmNydGNfc3RhdGUsDQorCQkJCQlzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcl9zdGF0ZSAq
Y29ubl9zdGF0ZSwNCisJCQkJCXUzMiBvdXRwdXRfZm10LA0KKwkJCQkJdW5zaWduZWQgaW50ICpu
dW1faW5wdXRfZm10cykNCit7DQorCXUzMiAqaW5wdXRfZm10czsNCisNCisJKm51bV9pbnB1dF9m
bXRzID0gMDsNCisNCisJaW5wdXRfZm10cyA9IGtjYWxsb2MoTUFYX0lOUFVUX1NFTF9GT1JNQVRT
LCBzaXplb2YoKmlucHV0X2ZtdHMpLA0KKwkJCSAgICAgR0ZQX0tFUk5FTCk7DQorCWlmICghaW5w
dXRfZm10cykNCisJCXJldHVybiBOVUxMOw0KKw0KKwkqbnVtX2lucHV0X2ZtdHMgPSAxOw0KKwlp
bnB1dF9mbXRzWzBdID0gTUVESUFfQlVTX0ZNVF9SR0I4ODhfMVgyNDsNCisNCisJcmV0dXJuIGlu
cHV0X2ZtdHM7DQorfQ0KKw0KK3N0YXRpYyBpbnQgbXRrX2RwaV9icmlkZ2VfYXRvbWljX2NoZWNr
KHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQorCQkJCSAgICAgICBzdHJ1Y3QgZHJtX2JyaWRn
ZV9zdGF0ZSAqYnJpZGdlX3N0YXRlLA0KKwkJCQkgICAgICAgc3RydWN0IGRybV9jcnRjX3N0YXRl
ICpjcnRjX3N0YXRlLA0KKwkJCQkgICAgICAgc3RydWN0IGRybV9jb25uZWN0b3Jfc3RhdGUgKmNv
bm5fc3RhdGUpDQorew0KKwlzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gYnJpZGdlLT5kcml2ZXJfcHJp
dmF0ZTsNCisNCisJZHBpLT5vdXRfYnVzX2Zvcm1hdCA9IGJyaWRnZV9zdGF0ZS0+b3V0cHV0X2J1
c19jZmcuZm9ybWF0Ow0KKw0KKwlkcGktPmluX2J1c19mb3JtYXQgPSBicmlkZ2Vfc3RhdGUtPmlu
cHV0X2J1c19jZmcuZm9ybWF0Ow0KKw0KKwlkZXZfZGJnKGRwaS0+ZGV2LCAiaW5wdXQgZm9ybWF0
IDB4JTA0eCwgb3V0cHV0IGZvcm1hdCAweCUwNHhcbiIsDQorCQlicmlkZ2Vfc3RhdGUtPmlucHV0
X2J1c19jZmcuZm9ybWF0LA0KKwkJYnJpZGdlX3N0YXRlLT5vdXRwdXRfYnVzX2NmZy5mb3JtYXQp
Ow0KKw0KKwlpZiAoZHBpLT5vdXRfYnVzX2Zvcm1hdCA9PSBNRURJQV9CVVNfRk1UX1JHQjg4OF8y
WDEyX0xFIHx8DQorCSAgICBkcGktPm91dF9idXNfZm9ybWF0ID09IE1FRElBX0JVU19GTVRfUkdC
ODg4XzJYMTJfQkUpIHsNCisJCWRwaS0+ZGRyX2VkZ2Vfc2VsID0NCisJCQkoZHBpLT5vdXRfYnVz
X2Zvcm1hdCA9PSBNRURJQV9CVVNfRk1UX1JHQjg4OF8yWDEyX0xFKSA/DQorCQkJIHRydWUgOiBm
YWxzZTsNCisJfQ0KKw0KKwlkcGktPmJpdF9udW0gPSBNVEtfRFBJX09VVF9CSVRfTlVNXzhCSVRT
Ow0KKwlkcGktPmNoYW5uZWxfc3dhcCA9IE1US19EUElfT1VUX0NIQU5ORUxfU1dBUF9SR0I7DQor
CWRwaS0+eWNfbWFwID0gTVRLX0RQSV9PVVRfWUNfTUFQX1JHQjsNCisJZHBpLT5jb2xvcl9mb3Jt
YXQgPSBNVEtfRFBJX0NPTE9SX0ZPUk1BVF9SR0I7DQorDQorCXJldHVybiAwOw0KK30NCisNCiBz
dGF0aWMgaW50IG10a19kcGlfYnJpZGdlX2F0dGFjaChzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdl
LA0KIAkJCQkgZW51bSBkcm1fYnJpZGdlX2F0dGFjaF9mbGFncyBmbGFncykNCiB7DQpAQCAtNTcy
LDYgKzY2MCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2JyaWRnZV9mdW5jcyBtdGtfZHBp
X2JyaWRnZV9mdW5jcyA9IHsNCiAJLm1vZGVfc2V0ID0gbXRrX2RwaV9icmlkZ2VfbW9kZV9zZXQs
DQogCS5kaXNhYmxlID0gbXRrX2RwaV9icmlkZ2VfZGlzYWJsZSwNCiAJLmVuYWJsZSA9IG10a19k
cGlfYnJpZGdlX2VuYWJsZSwNCisJLmF0b21pY19jaGVjayA9IG10a19kcGlfYnJpZGdlX2F0b21p
Y19jaGVjaywNCisJLmF0b21pY19nZXRfb3V0cHV0X2J1c19mbXRzID0gbXRrX2RwaV9icmlkZ2Vf
YXRvbWljX2dldF9vdXRwdXRfYnVzX2ZtdHMsDQorCS5hdG9taWNfZ2V0X2lucHV0X2J1c19mbXRz
ID0gbXRrX2RwaV9icmlkZ2VfYXRvbWljX2dldF9pbnB1dF9idXNfZm10cywNCiB9Ow0KIA0KIHN0
YXRpYyB2b2lkIG10a19kcGlfc3RhcnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCkNCkBAIC02
MjEsMTEgKzcxMiw2IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGRldmljZSAqbWFzdGVyLCB2b2lkICpkYXRhKQ0KIAkJZ290byBlcnJfY2xlYW51
cDsNCiAJfQ0KIA0KLQlkcGktPmJpdF9udW0gPSBNVEtfRFBJX09VVF9CSVRfTlVNXzhCSVRTOw0K
LQlkcGktPmNoYW5uZWxfc3dhcCA9IE1US19EUElfT1VUX0NIQU5ORUxfU1dBUF9SR0I7DQotCWRw
aS0+eWNfbWFwID0gTVRLX0RQSV9PVVRfWUNfTUFQX1JHQjsNCi0JZHBpLT5jb2xvcl9mb3JtYXQg
PSBNVEtfRFBJX0NPTE9SX0ZPUk1BVF9SR0I7DQotDQogCXJldHVybiAwOw0KIA0KIGVycl9jbGVh
bnVwOg0KLS0gDQoyLjEyLjUNCg==

