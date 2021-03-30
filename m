Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606C534ECF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhC3PyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:54:04 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:33515 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231928AbhC3Pxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:53:51 -0400
X-UUID: cdfcb64d03e249b68ac9cf69be0be67d-20210330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Wr7OqfMZ053MusTJu/z+VocLvngnE0TDREtT13ee894=;
        b=P6AF6UVnsg5ccVpaHqw+Mv/WrX1xihFP/yybTX4o9QcJCjy9Xh/CJRK6Duuso6slZMXPuEOzaNgdhKONRk6zxU9bd7wErdsWaHUv8q0u6OU3f10FMydKKNbCsjqteZZbO3EvYtE9EG+tN6EPjBQ+UPrT4pL63ndwXRue1uIDCpQ=;
X-UUID: cdfcb64d03e249b68ac9cf69be0be67d-20210330
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1627379242; Tue, 30 Mar 2021 23:53:44 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 23:53:34 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 30 Mar 2021 23:53:34 +0800
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
Subject: [PATCH 1/3] drm/mediatek: dpi dual edge sample mode support
Date:   Tue, 30 Mar 2021 23:53:28 +0800
Message-ID: <20210330155330.28759-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20210330155330.28759-1-jitao.shi@mediatek.com>
References: <20210330155330.28759-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4E04AEDD8294558B6CA67C7A5725B4939BD2C14C727429A5AA679777471F38242000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFBJIGNhbiBzYW1wbGUgb24gZmFsbGluZywgcmlzaW5nIG9yIGJvdGggZWRnZS4NCldoZW4gRFBJ
IHNhbXBsZSB0aGUgZGF0YSBib3RoIHJpc2luZyBhbmQgZmFsbGluZyBlZGdlLg0KSXQgY2FuIHJl
ZHVjZSBoYWxmIGRhdGEgaW8gcGlucy4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRh
by5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYyB8IDEyICsrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KaW5kZXggNTJmMTFhNjNhMzMwLi5jY2Q2
ODFhMmE0YzIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQpAQCAtODEsNiArODEs
NyBAQCBzdHJ1Y3QgbXRrX2RwaSB7DQogCXN0cnVjdCBwaW5jdHJsICpwaW5jdHJsOw0KIAlzdHJ1
Y3QgcGluY3RybF9zdGF0ZSAqcGluc19ncGlvOw0KIAlzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGlu
c19kcGk7DQorCWJvb2wgZGRyX2VkZ2Vfc2VsOw0KIAlpbnQgcmVmY291bnQ7DQogfTsNCiANCkBA
IC0xMTksNiArMTIwLDcgQEAgc3RydWN0IG10a19kcGlfY29uZiB7DQogCXVuc2lnbmVkIGludCAo
KmNhbF9mYWN0b3IpKGludCBjbG9jayk7DQogCXUzMiByZWdfaF9mcmVfY29uOw0KIAlib29sIGVk
Z2Vfc2VsX2VuOw0KKwlib29sIGR1YWxfZWRnZTsNCiB9Ow0KIA0KIHN0YXRpYyB2b2lkIG10a19k
cGlfbWFzayhzdHJ1Y3QgbXRrX2RwaSAqZHBpLCB1MzIgb2Zmc2V0LCB1MzIgdmFsLCB1MzIgbWFz
aykNCkBAIC0zNzgsNiArMzgwLDE1IEBAIHN0YXRpYyB2b2lkIG10a19kcGlfY29uZmlnX2NvbG9y
X2Zvcm1hdChzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KIAl9DQogfQ0KIA0KK3N0YXRpYyB2b2lkIG10
a19kcGlfZHVhbF9lZGdlKHN0cnVjdCBtdGtfZHBpICpkcGkpDQorew0KKwlpZiAoZHBpLT5jb25m
LT5kdWFsX2VkZ2UpIHsNCisJCW10a19kcGlfbWFzayhkcGksIERQSV9ERFJfU0VUVElORywgRERS
X0VOIHwgRERSXzRQSEFTRSwNCisJCQkgICAgIEREUl9FTiB8IEREUl80UEhBU0UpOw0KKwkJbXRr
X2RwaV9tYXNrKGRwaSwgRFBJX09VVFBVVF9TRVRUSU5HLCBkcGktPmRkcl9lZGdlX3NlbCA/IEVE
R0VfU0VMIDogMCwgRURHRV9TRUwpOw0KKwl9DQorfQ0KKw0KIHN0YXRpYyB2b2lkIG10a19kcGlf
cG93ZXJfb2ZmKHN0cnVjdCBtdGtfZHBpICpkcGkpDQogew0KIAlpZiAoV0FSTl9PTihkcGktPnJl
ZmNvdW50ID09IDApKQ0KQEAgLTUxNiw2ICs1MjcsNyBAQCBzdGF0aWMgaW50IG10a19kcGlfc2V0
X2Rpc3BsYXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KIAltdGtfZHBpX2NvbmZpZ195Y19t
YXAoZHBpLCBkcGktPnljX21hcCk7DQogCW10a19kcGlfY29uZmlnX2NvbG9yX2Zvcm1hdChkcGks
IGRwaS0+Y29sb3JfZm9ybWF0KTsNCiAJbXRrX2RwaV9jb25maWdfMm5faF9mcmUoZHBpKTsNCisJ
bXRrX2RwaV9kdWFsX2VkZ2UoZHBpKTsNCiAJbXRrX2RwaV9jb25maWdfZGlzYWJsZV9lZGdlKGRw
aSk7DQogCW10a19kcGlfc3dfcmVzZXQoZHBpLCBmYWxzZSk7DQogDQotLSANCjIuMTIuNQ0K

