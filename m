Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB1359306
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhDIDbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:31:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35415 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232918AbhDIDa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:30:59 -0400
X-UUID: a238bdf067184d069822ea732deda991-20210409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=arJG16CDzyUkGqPEnWMf6l856hAp9u/dcfwy2lSC6GM=;
        b=SMUC/7J8aha+qWUl9RrZg5RUZCEJYW+XYezJcjLY4J6bFmbwEHDwqzdPjZYRXDy163q1LAIuMuvRpaVtsb3WFAo0eFc7+BC4wcNrHSWsZrhWyZhkHEuwKOT7qLXjQaVQjt5rlq4JSNCItsO6XfBzsg2dGxN4CZtECA5p2GTu0bA=;
X-UUID: a238bdf067184d069822ea732deda991-20210409
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 820148550; Fri, 09 Apr 2021 11:30:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 11:30:30 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 11:30:29 +0800
Message-ID: <1617939030.29552.2.camel@mtksdccf07>
Subject: Re: [PATCH v2 1/6] dt-bindings: devapc: Update bindings
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>
Date:   Fri, 9 Apr 2021 11:30:30 +0800
In-Reply-To: <20210408204354.GA1926089@robh.at.kernel.org>
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
         <20210408204354.GA1926089@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 38F287E4ECC4047A38808EFB92A57C55DE4F89C14B2D8C99AB07417FB55904862000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpPbiBUaHUsIDIwMjEtMDQtMDggYXQgMTU6NDMgLTA1MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiBPbiBUaHUsIEFwciAwMSwgMjAyMSBhdCAwMjozODowMlBNICswODAwLCBOaW5h
IFd1IHdyb3RlOg0KPiA+IEZyb206IE5pbmEgV3UgPE5pbmEtQ00uV3VAbWVkaWF0ZWsuY29tPg0K
PiANCj4gRXZlcnkgY2hhbmdlIGlzIGFuICd1cGRhdGUnLiBQZXJoYXBzIG1lbnRpb24gbXQ4MTky
IGluIHRoZSBzdWJqZWN0Lg0KPiANCg0KT0suDQpJIHdpbGwgdHJ5IHRvIG1ha2UgaXQgY2xlYXIg
aW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiA+IA0KPiA+IFRvIHN1cHBvcnQgbmV3ZXIgaGFyZHdh
cmUgYXJjaGl0ZWN0dXJlIG9mIGRldmFwYywNCj4gPiB1cGRhdGUgZGV2aWNlIHRyZWUgYmluZGlu
Z3MuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmluYSBXdSA8TmluYS1DTS5XdUBtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvbWVkaWF0ZWsvZGV2YXBjLnlhbWwgfCA4ICsrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZGV2YXBjLnlhbWwNCj4gPiBpbmRl
eCAzMWU0ZDNjLi40MmIyODRlIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZGV2YXBjLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sDQo+ID4g
QEAgLTIwLDExICsyMCwxNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4g
ICAgICBlbnVtOg0KPiA+ICAgICAgICAtIG1lZGlhdGVrLG10Njc3OS1kZXZhcGMNCj4gPiArICAg
ICAgLSBtZWRpYXRlayxtdDgxOTItZGV2YXBjDQo+ID4gIA0KPiA+ICAgIHJlZzoNCj4gPiAgICAg
IGRlc2NyaXB0aW9uOiBUaGUgYmFzZSBhZGRyZXNzIG9mIGRldmFwYyByZWdpc3RlciBiYW5rDQo+
ID4gICAgICBtYXhJdGVtczogMQ0KPiA+ICANCj4gPiArICB2aW8taWR4LW51bToNCj4gDQo+IE5l
ZWRzIGEgdmVuZG9yIHByZWZpeC4NCg0KT0suDQpJIHdpbGwgZml4IGl0IGluIHRoZSBuZXh0IHZl
cnNpb24uDQoNClRoYW5rcy4NCg0KPiANCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgbnVtYmVy
IG9mIHRoZSBkZXZpY2VzIGNvbnRyb2xsZWQgYnkgZGV2YXBjDQo+ID4gKyAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIG1heEl0ZW1zOiAx
DQo+ID4gKw0KPiA+ICAgIGludGVycnVwdHM6DQo+ID4gICAgICBkZXNjcmlwdGlvbjogQSBzaW5n
bGUgaW50ZXJydXB0IHNwZWNpZmllcg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiBAQCAtNDAs
NiArNDYsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICByZXF1aXJlZDoNCj4gPiAgICAtIGNvbXBhdGli
bGUNCj4gPiAgICAtIHJlZw0KPiA+ICsgIC0gdmlvLWlkeC1udW0NCj4gPiAgICAtIGludGVycnVw
dHMNCj4gPiAgICAtIGNsb2Nrcw0KPiA+ICAgIC0gY2xvY2stbmFtZXMNCj4gPiBAQCAtNTQsNiAr
NjEsNyBAQCBleGFtcGxlczoNCj4gPiAgICAgIGRldmFwYzogZGV2YXBjQDEwMjA3MDAwIHsNCj4g
PiAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktZGV2YXBjIjsNCj4gPiAgICAg
ICAgcmVnID0gPDB4MTAyMDcwMDAgMHgxMDAwPjsNCj4gPiArICAgICAgdmlvLWlkeC1udW0gPSA8
NTExPjsNCj4gPiAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE2OCBJUlFfVFlQRV9MRVZF
TF9MT1c+Ow0KPiA+ICAgICAgICBjbG9ja3MgPSA8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9ERVZJ
Q0VfQVBDPjsNCj4gPiAgICAgICAgY2xvY2stbmFtZXMgPSAiZGV2YXBjLWluZnJhLWNsb2NrIjsN
Cj4gPiAtLSANCj4gPiAyLjYuNA0KPiA+IA0KDQo=

