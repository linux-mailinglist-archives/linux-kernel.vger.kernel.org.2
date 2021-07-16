Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F993CB209
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 07:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhGPFtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 01:49:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53994 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230057AbhGPFtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:49:50 -0400
X-UUID: 5ca8a674cf86426da59ec0fc202128fa-20210716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=huBBs74sIuYd7dGr/eJzbVMsc2ILmvG+DwEkvTlnfDg=;
        b=ayzXhE1D5SFGgBfWzklTPW+wDAo2iDdbWvLMqSrujeE0LtSoEsfMXzg/7B9zX2XvxPlrt2p+8V1XYTLf7WCP2PjQk1u1+5P9SYo6814qpgb9vsfQ3q2amqfWdKuu9M1QjGbEBgibkvHhyM2y3AoFV7O/Hb+x6kVLn1IF1rHTi5k=;
X-UUID: 5ca8a674cf86426da59ec0fc202128fa-20210716
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 373819757; Fri, 16 Jul 2021 13:46:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 13:46:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Jul 2021 13:46:52 +0800
Message-ID: <1626414412.24603.0.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: mtk-dpi: Set out_fmt from config if not
 the last bridge
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 16 Jul 2021 13:46:52 +0800
In-Reply-To: <20210712094657.1159299-1-hsinyi@chromium.org>
References: <20210712094657.1159299-1-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4teWk6DQoNCk9uIE1vbiwgMjAyMS0wNy0xMiBhdCAxNzo0NiArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBhdG9taWNfZ2V0X291dHB1dF9idXNfZm10cygpIGlzIG9ubHkgY2Fs
bGVkIHdoZW4gdGhlIGJyaWRnZSBpcyB0aGUgbGFzdA0KPiBlbGVtZW50IGluIHRoZSBicmlkZ2Ug
Y2hhaW4uDQo+IA0KPiBJZiBtdGstZHBpIGlzIG5vdCB0aGUgbGFzdCBicmlkZ2UsIHRoZSBmb3Jt
YXQgb2Ygb3V0cHV0X2J1c19jZmcgaXMNCj4gTUVESUFfQlVTX0ZNVF9GSVhFRCwgYW5kIG10a19k
cGlfZHVhbF9lZGdlKCkgd2lsbCBmYWlsIHRvIHdyaXRlIGNvcnJlY3QNCj4gdmFsdWUgdG8gcmVn
cy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZp
eGVzOiBlYzg3NDdjNTI0MzQgKCJkcm0vbWVkaWF0ZWs6IGRwaTogQWRkIGJ1cyBmb3JtYXQgbmVn
b3RpYXRpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBIc2luLVlpIFdhbmcgPGhzaW55aUBjaHJvbWl1
bS5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyB8IDQg
KysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RwaS5jDQo+IGluZGV4IGJjZWQ1NTU2NDhiMDEuLjI1YzU2NWY5MTc5Y2Mg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiBAQCAtNjEwLDYgKzYxMCwx
MCBAQCBzdGF0aWMgaW50IG10a19kcGlfYnJpZGdlX2F0b21pY19jaGVjayhzdHJ1Y3QgZHJtX2Jy
aWRnZSAqYnJpZGdlLA0KPiAgDQo+ICAJb3V0X2J1c19mb3JtYXQgPSBicmlkZ2Vfc3RhdGUtPm91
dHB1dF9idXNfY2ZnLmZvcm1hdDsNCj4gIA0KPiArCWlmIChvdXRfYnVzX2Zvcm1hdCA9PSBNRURJ
QV9CVVNfRk1UX0ZJWEVEKQ0KPiArCQlpZiAoZHBpLT5jb25mLT5udW1fb3V0cHV0X2ZtdHMpDQo+
ICsJCQlvdXRfYnVzX2Zvcm1hdCA9IGRwaS0+Y29uZi0+b3V0cHV0X2ZtdHNbMF07DQo+ICsNCj4g
IAlkZXZfZGJnKGRwaS0+ZGV2LCAiaW5wdXQgZm9ybWF0IDB4JTA0eCwgb3V0cHV0IGZvcm1hdCAw
eCUwNHhcbiIsDQo+ICAJCWJyaWRnZV9zdGF0ZS0+aW5wdXRfYnVzX2NmZy5mb3JtYXQsDQo+ICAJ
CWJyaWRnZV9zdGF0ZS0+b3V0cHV0X2J1c19jZmcuZm9ybWF0KTsNCg0K

