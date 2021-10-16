Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B854D42FFB1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 04:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbhJPCPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 22:15:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44174 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232812AbhJPCPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 22:15:35 -0400
X-UUID: 54cbac1625e440ccaad6ae10a489fec2-20211016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ea7oQlIojI/CGgtbObieSmBoMcrvgHikxIPi+z+qGZo=;
        b=CyyA9mgGRTtgLaaqSGtWXjHj02ijqysJmbrlSK677JNC3lw713X65BJFHeWIqygS4z7gVojbgQ4hXq7srZ/q5e5IIyLmccYsXXLvTnzAczpLTGtMWOKHTunznLmYkKAOruB8AaBFAfyaf14OMmUNS6vkYVfLXpY8XACF3KOVFu0=;
X-UUID: 54cbac1625e440ccaad6ae10a489fec2-20211016
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 207952531; Sat, 16 Oct 2021 10:13:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 16 Oct 2021 10:13:22 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Oct 2021 10:13:21 +0800
Message-ID: <5e411c148ac44d5d970b6fba8861f63434f83ec5.camel@mediatek.com>
Subject: Re: [PATCH] memory: mtk-smi: Use ARRAY_SIZE to define
 MTK_SMI_CLK_NR_MAX
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <krzysztof.kozlowski@canonical.com>
CC:     <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 16 Oct 2021 10:13:21 +0800
In-Reply-To: <20211015151557.510726-1-angelogioacchino.delregno@collabora.com>
References: <20211015151557.510726-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTE1IGF0IDE3OjE1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gVGhpcyBkZWZpbml0aW9uIGlzIHRpZWQgdG8gdGhlIG51bWJlciBvZiBT
TUkgY29tbW9uIGNsb2NrcyAodGhlIGFycmF5DQo+IG10a19zbWlfY29tbW9uX2Nsa3MpOiBpbXBy
b3ZlIHRoZSBkZWZpbml0aW9uIGJ5IHVzaW5nIHRoZSBBUlJBWV9TSVpFDQo+IG1hY3JvIGluc3Rl
YWQuIFRoYXQgd2lsbCBhbHNvIHJlZHVjZSByb29tIGZvciBtaXN0YWtlcyB3aGVuIHVwZGF0aW5n
DQo+IHRoZSBhZm9yZW1lbnRpb25lZCBhcnJheSBpbiB0aGUgZnV0dXJlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5v
LmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQoNClJldmlld2VkLWJ5OiBZb25nIFd1IDx5b25nLnd1
QG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIGZvciB0aGlzIHBhdGNoLg0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9tZW1vcnkvbXRrLXNtaS5jIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9y
eS9tdGstc21pLmMgYi9kcml2ZXJzL21lbW9yeS9tdGstc21pLmMNCj4gaW5kZXggYjg4M2RjYzBi
YmZhLi42MzMxNDIyMTQxZTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVtb3J5L210ay1zbWku
Yw0KPiArKysgYi9kcml2ZXJzL21lbW9yeS9tdGstc21pLmMNCj4gQEAgLTk0LDggKzk0LDYgQEAg
ZW51bSBtdGtfc21pX3R5cGUgew0KPiAgCU1US19TTUlfR0VOMl9TVUJfQ09NTSwJLyogZ2VuMiBz
bWkgc3ViIGNvbW1vbiAqLw0KPiAgfTsNCj4gIA0KPiAtI2RlZmluZSBNVEtfU01JX0NMS19OUl9N
QVgJCQk0DQo+IC0NCj4gIC8qIGxhcmJzOiBSZXF1aXJlIGFwYi9zbWkgY2xvY2tzIHdoaWxlIGdh
bHMgaXMgb3B0aW9uYWwuICovDQo+ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IG10a19zbWlf
bGFyYl9jbGtzW10gPSB7ImFwYiIsICJzbWkiLA0KPiAiZ2FscyJ9Ow0KPiAgI2RlZmluZSBNVEtf
U01JX0xBUkJfUkVRX0NMS19OUgkJMg0KPiBAQCAtMTA2LDYgKzEwNCw3IEBAIHN0YXRpYyBjb25z
dCBjaGFyICogY29uc3QgbXRrX3NtaV9sYXJiX2Nsa3NbXSA9DQo+IHsiYXBiIiwgInNtaSIsICJn
YWxzIn07DQo+ICAgKiBzdWIgY29tbW9uOiBSZXF1aXJlIGFwYi9zbWkvZ2FsczAgY2xvY2tzIGlu
IGhhc19nYWxzIGNhc2UuDQo+IE90aGVyd2lzZSwgb25seSBhcGIvc21pIGFyZSByZXF1aXJlZC4N
Cj4gICAqLw0KPiAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBtdGtfc21pX2NvbW1vbl9jbGtz
W10gPSB7ImFwYiIsICJzbWkiLA0KPiAiZ2FsczAiLCAiZ2FsczEifTsNCj4gKyNkZWZpbmUgTVRL
X1NNSV9DTEtfTlJfTUFYCQlBUlJBWV9TSVpFKG10a19zbWlfY29tbW9uX2Nsa3MpDQo+ICAjZGVm
aW5lIE1US19TTUlfQ09NX1JFUV9DTEtfTlIJCTINCj4gICNkZWZpbmUgTVRLX1NNSV9DT01fR0FM
U19SRVFfQ0xLX05SCU1US19TTUlfQ0xLX05SX01BWA0KPiAgI2RlZmluZSBNVEtfU01JX1NVQl9D
T01fR0FMU19SRVFfQ0xLX05SIDMNCg==

