Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27E83B8BFC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 04:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbhGACQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 22:16:13 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:60361 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234257AbhGACQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 22:16:12 -0400
X-UUID: 47e6d98a0df343a8adeac2f95f895f98-20210701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=AcP3gEPnP4tM/McdpWeWTQWUaen+Pk00C+pKqpN58ew=;
        b=WPjcmcCy3Z+FlUS3crGm4RaOeqb0/DKyr4SUzxhFSVY7EkVAhXcOEs1+r4KHxmpOmY+/UzHHIVH1oCPLdULSFHiE+WRkbg8VseJmHVqJZjwA9FOjO9BVDrslb0Pho5NzAVAqrFI/RcripT7IEVC4aF4ZMhMtgm0Gvwf7LyH2e1g=;
X-UUID: 47e6d98a0df343a8adeac2f95f895f98-20210701
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1710508295; Thu, 01 Jul 2021 10:13:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 1 Jul 2021 10:13:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 1 Jul 2021 10:13:39 +0800
Message-ID: <da0db357ac7e41ca6ec2007eccccbb465049cd01.camel@mediatek.com>
Subject: Re: [v11 01/19] dt-bindings: ARM: Mediatek: Add new document
 bindings of MT8192 clock
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 1 Jul 2021 10:13:39 +0800
In-Reply-To: <CAAOTY_8SgZ5SN9Q0nfL_jQVTbB7ZDqgoGFRkKe8+QJwUi55Hew@mail.gmail.com>
References: <20210630132804.20436-1-chun-jie.chen@mediatek.com>
         <20210630132804.20436-2-chun-jie.chen@mediatek.com>
         <CAAOTY_8SgZ5SN9Q0nfL_jQVTbB7ZDqgoGFRkKe8+QJwUi55Hew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTMwIGF0IDIyOjMwICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgQ2h1bi1KaWU6DQo+IA0KPiBDaHVuLUppZSBDaGVuIDxjaHVuLWppZS5jaGVuQG1lZGlh
dGVrLmNvbT4g5pa8IDIwMjHlubQ25pyIMzDml6Ug6YCx5LiJIOS4i+WNiDk6MzDlr6vpgZPvvJoN
Cj4gPiANCj4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIG5ldyBiaW5kaW5nIGRvY3VtZW50YXRpb24g
Zm9yIHN5c3RlbSBjbG9jaw0KPiA+IGFuZCBmdW5jdGlvbmFsIGNsb2NrIG9uIE1lZGlhdGVrIE1U
ODE5Mi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuLUppZSBDaGVuIDxjaHVuLWppZS5j
aGVuQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz4NCj4gPiAtLS0NCj4gDQo+IFtzbmlwXQ0KPiANCj4gPiArDQo+ID4gKyAgLSB8DQo+
ID4gKyAgICBtbXN5czogY2xvY2stY29udHJvbGxlckAxNDAwMDAwMCB7DQo+IA0KPiBtbXN5cyBp
cyBhIHN5c3RlbSBjb250cm9sbGVyIHJhdGhlciB0aGFuIGNsb2NrIGNvbnRyb2xsZXIsIGlzbid0
IGl0Pw0KPiANCj4gUmVnYXJkcywNCj4gQ2h1bi1LdWFuZy4NCj4gDQo+ID4gKyAgICAgICAgY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItbW1zeXMiOw0KPiA+ICsgICAgICAgIHJlZyA9IDww
eDE0MDAwMDAwIDB4MTAwMD47DQo+ID4gKyAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+
ICsgICAgfTsNCj4gPiArDQoNClRoYW5rcyBmb3IgeW91IHJlbWluZGVyLCBJIHdpbGwgbW92ZSBt
bXN5cyB0byBzeXN0ZW0gY2xvY2sgY29udHJvbGxlci4NCg0KQmVzdCBSZWdhcmRzLA0KQ2h1bi1K
aWUNCg==

