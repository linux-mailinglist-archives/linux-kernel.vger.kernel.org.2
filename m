Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7162F37BC83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhELMa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:30:28 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:34912 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232196AbhELMa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:30:27 -0400
X-UUID: 56acb10324ea40e2bea1352a797416fa-20210512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ewPs1Oa6a3lyJ4v/+R+Na+4N5EnjMReDZVRwjMtKeis=;
        b=ewEoqOKvSAWVqKqd0u9hldRL4upWs4M/EifpIJ8EQaXDgkQ3tFEDnplJWcc44suitQcRVH3My30OOlv9FVrLYXvY5Mmt5Wqwo4vJJRN/nqjCvKEWg4bzO6izgAZi/BpIqHHp4e4b1//axLcRhg4In1omHMg+L8VZUrmmL5Q0Ulg=;
X-UUID: 56acb10324ea40e2bea1352a797416fa-20210512
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 172632164; Wed, 12 May 2021 20:29:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 20:29:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 May 2021 20:29:07 +0800
Message-ID: <1620822547.2983.8.camel@mhfsdcap03>
Subject: Re: [PATCH v5 13/16] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
From:   Yong Wu <yong.wu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yi.kuo@mediatek.com>, <eizan@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
Date:   Wed, 12 May 2021 20:29:07 +0800
In-Reply-To: <CAJMQK-iTrQRDDm_=LNqSpvXFd431LYRxXMasJHUpN+K8rJ=Qpg@mail.gmail.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
         <20210410091128.31823-14-yong.wu@mediatek.com>
         <CAJMQK-iTrQRDDm_=LNqSpvXFd431LYRxXMasJHUpN+K8rJ=Qpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7780E5B9D2712AB2AE1806AA941E22A5D94145B0E8BDFD93F8EBEB7BFDD94F3E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA1LTEyIGF0IDE3OjIwICswODAwLCBIc2luLVlpIFdhbmcgd3JvdGU6DQo+
IE9uIFNhdCwgQXByIDEwLCAyMDIxIGF0IDU6MTQgUE0gWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRl
ay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gTWVkaWFUZWsgSU9NTVUgaGFzIGFscmVhZHkgYWRkZWQg
dGhlIGRldmljZV9saW5rIGJldHdlZW4gdGhlIGNvbnN1bWVyDQo+ID4gYW5kIHNtaS1sYXJiIGRl
dmljZS4gSWYgdGhlIHZjb2RlYyBkZXZpY2UgY2FsbCB0aGUgcG1fcnVudGltZV9nZXRfc3luYywN
Cj4gPiB0aGUgc21pLWxhcmIncyBwbV9ydW50aW1lX2dldF9zeW5jIGFsc28gYmUgY2FsbGVkIGF1
dG9tYXRpY2FsbHkuDQo+ID4NCj4gPiBDQzogVGlmZmFueSBMaW4gPHRpZmZhbnkubGluQG1lZGlh
dGVrLmNvbT4NCj4gPiBDQzogSXJ1aSBXYW5nIDxpcnVpLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBFdmFuIEdyZWVuIDxldmdyZWVuQGNocm9taXVtLm9yZz4NCj4gPiBBY2tlZC1ieTog
VGlmZmFueSBMaW4gPHRpZmZhbnkubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4u
L3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19kZWNfcG0uYyAgIHwgMzcgKystLS0tLS0t
LS0tLS0tDQo+ID4gIC4uLi9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZHJ2LmggICAg
ICB8ICAzIC0tDQo+ID4gIC4uLi9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZW5jLmMg
ICAgICB8ICAxIC0NCj4gPiAgLi4uL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19lbmNf
cG0uYyAgIHwgNDYgKystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKyksIDc3IGRlbGV0aW9ucygtKQ0KDQpbLi4uXQ0KDQo+ID4gQEAgLTEwOCwx
MyArODAsNiBAQCB2b2lkIG10a192Y29kZWNfZW5jX2Nsb2NrX29uKHN0cnVjdCBtdGtfdmNvZGVj
X3BtICpwbSkNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4g
LSAgICAgICByZXQgPSBtdGtfc21pX2xhcmJfZ2V0KHBtLT5sYXJidmVuYyk7DQo+ID4gLSAgICAg
ICBpZiAocmV0KSB7DQo+ID4gLSAgICAgICAgICAgICAgIG10a192NGwyX2VycigibXRrX3NtaV9s
YXJiX2dldCBsYXJiMyBmYWlsICVkIiwgcmV0KTsNCj4gPiAtICAgICAgICAgICAgICAgZ290byBj
bGtlcnI7DQo+ID4gLSAgICAgICB9DQo+ID4gLSAgICAgICByZXR1cm47DQo+IA0KPiBZb3UgY2Fu
J3QgZGVsZXRlIHRoZSByZXR1cm47IGhlcmUsIG90aGVyd2lzZSB2Y29kZWNfY2xrIHdpbGwgYmUg
dHVybmVkDQo+IG9mZiBpbW1lZGlhdGVseSBhZnRlciB0aGV5IGFyZSB0dXJuZWQgb24uDQoNClRo
YW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIgcmV2aWV3Lg0KDQpTb3JyeSBmb3IgdGhpcy4gWW91IGFy
ZSBxdWl0ZSByaWdodC4NCg0KSSBjaGVja2VkIHRoaXMsIGl0IHdhcyBpbnRyb2R1Y2VkIGluIHY0
IHdoZW4gSSByZWJhc2UgdGhlIGNvZGUuIEkgd2lsbA0KZml4IGl0IGluIG5leHQgdGltZS4NCg0K
PiANCj4gPiAtDQo+ID4gIGNsa2VycjoNCj4gPiAgICAgICAgIGZvciAoaSAtPSAxOyBpID49IDA7
IGktLSkNCj4gPiAgICAgICAgICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGVuY19jbGst
PmNsa19pbmZvW2ldLnZjb2RlY19jbGspOw0KPiA+IEBAIC0xMjUsNyArOTAsNiBAQCB2b2lkIG10
a192Y29kZWNfZW5jX2Nsb2NrX29mZihzdHJ1Y3QgbXRrX3Zjb2RlY19wbSAqcG0pDQo+ID4gICAg
ICAgICBzdHJ1Y3QgbXRrX3Zjb2RlY19jbGsgKmVuY19jbGsgPSAmcG0tPnZlbmNfY2xrOw0KPiA+
ICAgICAgICAgaW50IGkgPSAwOw0KPiA+DQo+ID4gLSAgICAgICBtdGtfc21pX2xhcmJfcHV0KHBt
LT5sYXJidmVuYyk7DQo+ID4gICAgICAgICBmb3IgKGkgPSBlbmNfY2xrLT5jbGtfbnVtIC0gMTsg
aSA+PSAwOyBpLS0pDQo+ID4gICAgICAgICAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShl
bmNfY2xrLT5jbGtfaW5mb1tpXS52Y29kZWNfY2xrKTsNCj4gPiAgfQ0KPiA+IC0tDQo+ID4gMi4x
OC4wDQo+ID4NCg0K

