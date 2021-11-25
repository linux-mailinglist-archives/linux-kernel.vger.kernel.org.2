Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B545D9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbhKYMU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:20:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42192 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239350AbhKYMS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:18:27 -0500
X-UUID: 03107496eb0f4250a40eceae39071db7-20211125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XNa56ptSVW/PBObhWFXTIZ22GAfC+uM5uwwEbvv6o/M=;
        b=nHIEfA3DaVVfdCd8h/Bi4AlcPB95vpZffM6B2xWRkW+1JuIIw+E/dMIWJu5a0K5mRGOAfEz3a7paWQbhgQ5G91lvR/BUnlkltRdGSJfVGXPPWT9vnCkTl0sSrFcV8ceGaED+STcGxpgIMzjkN0sNwqz/Ff2Lm7GQewaAIO9FZeM=;
X-UUID: 03107496eb0f4250a40eceae39071db7-20211125
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1041156523; Thu, 25 Nov 2021 20:15:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 25 Nov 2021 20:15:12 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Nov 2021 20:15:11 +0800
Message-ID: <926a0bb2ec2ad64ba579d38e761e1e97ba5bba3f.camel@mediatek.com>
Subject: Re: [PATCH v4 10/12] ARM: dts: Add PCIe support for Airoha EN7523
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        <linux-arm-kernel@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <john@phrozen.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 25 Nov 2021 20:15:11 +0800
In-Reply-To: <20211125110738.41028-11-nbd@nbd.name>
References: <20211125110738.41028-1-nbd@nbd.name>
         <20211125110738.41028-11-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVsaXgsDQoNCk9uIFRodSwgMjAyMS0xMS0yNSBhdCAxMjowNyArMDEwMCwgRmVsaXggRmll
dGthdSB3cm90ZToNCj4gVGhpcyB1c2VzIHRoZSBNZWRpYVRlayBNVDc2MjIgUENJZSBkcml2ZXIs
IHNpbmNlIHRoZSBQQ0llIElQIGJsb2NrIGlzDQo+IG5lYXJseQ0KPiBpZGVudGljYWwgdG8gdGhl
IG9uZSBpbiBNVDc2MjINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEZpZXRrYXUgPG5iZEBu
YmQubmFtZT4NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9lbjc1MjMtZXZiLmR0cyB8IDEy
ICsrKysrKysNCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2VuNzUyMy5kdHNpICAgIHwgNjANCj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNzIgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2VuNzUyMy1l
dmIuZHRzDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvZW43NTIzLWV2Yi5kdHMNCj4gaW5kZXggZThl
NWMwMzRjZWU3Li5hZjFhOGRkNDBhNDEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2VuNzUyMy1ldmIuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2VuNzUyMy1ldmIuZHRz
DQo+IEBAIC0yNSwzICsyNSwxNSBAQCBtZW1vcnlAODAwMDAwMDAgew0KPiAgCQlyZWcgPSA8MHg4
MDAwMDAwMCAweDIwMDAwMDAwPjsNCj4gIAl9Ow0KPiAgfTsNCj4gKw0KPiArJnBjaWUgew0KPiAr
CXN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZwY2llMCB7DQo+ICsJc3RhdHVzID0g
Im9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnBjaWUxIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+
ICt9Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvZW43NTIzLmR0c2kNCj4gYi9h
cmNoL2FybS9ib290L2R0cy9lbjc1MjMuZHRzaQ0KPiBpbmRleCBlYWJmM2ZkYjNkNTIuLmQ5YmRi
NTE2MTRiNSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvZW43NTIzLmR0c2kNCj4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvZW43NTIzLmR0c2kNCj4gQEAgLTExOSw0ICsxMTksNjQg
QEAgdWFydDE6IHNlcmlhbEAxZmJmMDAwMCB7DQo+ICAJCWNsb2NrLWZyZXF1ZW5jeSA9IDwxODQz
MjAwPjsNCj4gIAkJc3RhdHVzID0gIm9rYXkiOw0KPiAgCX07DQo+ICsNCj4gKwlwY2llOiBwY2ll
QDFhMTQwMDAwIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJhaXJvaGEsZW43NTIzLXBjaWUiLCAibWVk
aWF0ZWssbXQ3NjIyLQ0KPiBwY2llIjsNCj4gKwkJZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4gKwkJ
cmVnID0gPDB4MWZhOTEwMDAgMHgxMDAwPiwNCj4gKwkJICAgICAgPDB4MWZhOTIwMDAgMHgxMDAw
PjsNCj4gKwkJcmVnLW5hbWVzID0gInBvcnQwIiwgInBvcnQxIjsNCj4gKwkJI2FkZHJlc3MtY2Vs
bHMgPSA8Mz47DQo+ICsJCSNzaXplLWNlbGxzID0gPDI+Ow0KPiArCQlpbnRlcnJ1cHRzID0gPEdJ
Q19TUEkgMzkgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ICsJCQkgICAgIDxHSUNfU1BJIDQwIElS
UV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQljbG9ja3MgPSA8JnNjdSBFTjc1MjNfQ0xLX1BDSUU+
LA0KPiArCQkJIDwmc2N1IEVONzUyM19DTEtfUENJRT47DQo+ICsJCWNsb2NrLW5hbWVzID0gInN5
c19jazAiLCAic3lzX2NrMSI7DQo+ICsJCWJ1cy1yYW5nZSA9IDwweDAwIDB4ZmY+Ow0KPiArCQly
YW5nZXMgPSA8MHg4MjAwMDAwMCAwIDB4MjAwMDAwMDAgIDB4MjAwMDAwMDAgIDANCj4gMHgxMDAw
MDAwMD47DQo+ICsJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJcGNpZTA6IHBjaWVA
MCwwIHsNCj4gKwkJCWRldmljZV90eXBlID0gInBjaSI7DQo+ICsJCQlyZWcgPSA8MHgwMDAwIDAg
MCAwIDA+Ow0KPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQo+ICsJCQkjc2l6ZS1jZWxscyA9
IDwyPjsNCj4gKwkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+ICsJCQlyYW5nZXM7DQo+ICsJ
CQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArDQo+ICsJCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8
MCAwIDAgNz47DQo+ICsJCQlpbnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEgJnBjaWVfaW50YzAgMD4s
DQo+ICsJCQkJCTwwIDAgMCAyICZwY2llX2ludGMwIDE+LA0KPiArCQkJCQk8MCAwIDAgMyAmcGNp
ZV9pbnRjMCAyPiwNCj4gKwkJCQkJPDAgMCAwIDQgJnBjaWVfaW50YzAgMz47DQo+ICsJCQlwY2ll
X2ludGMwOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+ICsJCQkJaW50ZXJydXB0LWNvbnRyb2xs
ZXI7DQo+ICsJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MD47DQo+ICsJCQkJI2ludGVycnVwdC1jZWxs
cyA9IDwxPjsNCj4gKwkJCX07DQo+ICsJCX07DQo+ICsNCj4gKwkJcGNpZTE6IHBjaWVAMSwwIHsN
Cj4gKwkJCWRldmljZV90eXBlID0gInBjaSI7DQo+ICsJCQlyZWcgPSA8MHgwODAwIDAgMCAwIDA+
Ow0KPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQo+ICsJCQkjc2l6ZS1jZWxscyA9IDwyPjsN
Cj4gKwkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+ICsJCQlyYW5nZXM7DQo+ICsJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KPiArDQo+ICsJCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MCAwIDAg
Nz47DQo+ICsJCQlpbnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEgJnBjaWVfaW50YzEgMD4sDQo+ICsJ
CQkJCTwwIDAgMCAyICZwY2llX2ludGMxIDE+LA0KPiArCQkJCQk8MCAwIDAgMyAmcGNpZV9pbnRj
MSAyPiwNCj4gKwkJCQkJPDAgMCAwIDQgJnBjaWVfaW50YzEgMz47DQo+ICsJCQlwY2llX2ludGMx
OiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+ICsJCQkJaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+
ICsJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MD47DQo+ICsJCQkJI2ludGVycnVwdC1jZWxscyA9IDwx
PjsNCj4gKwkJCX07DQo+ICsJCX07DQo+ICsJfTsNCg0KVGhlcmUgYXJlIHNvbWUga25vd24gaXNz
dWVzIHdpdGggdGhpcyBkZXZpY2Ugbm9kZSBzdHlsZSwgcGxlYXNlIHNwbGl0DQp0aGUgUENJZSBu
b2RlIGludG8gdHdvIGluZGVwZW5kZW50IG5vZGVzIHRvIGNvbXBseSB3aXRoIHRoZSBoYXJkd2Fy
ZQ0KZGVzaWduLg0KDQpIZXJlIGlzIHRoZSBmaXggcGF0Y2ggd2Ugc2VudCBiZWZvcmU6DQoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDIxMDgyMzAzMjgwMC4xNjYwLTYtY2h1
YW5qaWEubGl1QG1lZGlhdGVrLmNvbS8NCg0KVGhhbmtzLg0KDQo+ICB9Ow0K

