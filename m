Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1787B400D92
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 01:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhIDXxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 19:53:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42422 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232049AbhIDXxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 19:53:10 -0400
X-UUID: 7e0fb3618b0c430f9f05c8b2b1d0c5aa-20210905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GHSmuj3Q2BVj+Q8NFNRDWDer66bC//EsTOenC7igQ3g=;
        b=fmM2XeN1PGPsjX/Mz1mqw/yPE1dlHjQVUDkJVe2R9ac9TOsTDTvCHmdO11uH7GVDfJObb1DXVRDCBtBR4TDKSQc23Xl3w2dR5ZOGBlGeneCEkKnkvBCIXe+SeG2AomV6Fy4PCeJoCaf/Ecd71EMGcm7CCLUXFnyOHYIzjL077VI=;
X-UUID: 7e0fb3618b0c430f9f05c8b2b1d0c5aa-20210905
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1247009180; Sun, 05 Sep 2021 07:52:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 5 Sep 2021 07:52:04 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 5 Sep 2021 07:52:03 +0800
Message-ID: <0d6740ab1c40f32188881b55b06c62b28a179402.camel@mediatek.com>
Subject: Re: [PATCH v2] clk: imx: use module_platform_driver
From:   Miles Chen <miles.chen@mediatek.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Sun, 5 Sep 2021 07:52:04 +0800
In-Reply-To: <CAOMZO5AE4uGXk47uhWKLch8RDmUrvvw0zDPM+wxgz4uWJD6eGA@mail.gmail.com>
References: <20210904152946.32042-1-miles.chen@mediatek.com>
         <CAOMZO5AE4uGXk47uhWKLch8RDmUrvvw0zDPM+wxgz4uWJD6eGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTA5LTA0IGF0IDEzOjQzIC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBIaSBNaWxlcywNCj4gDQo+IE9uIFNhdCwgU2VwIDQsIDIwMjEgYXQgMTI6MjkgUE0gTWlsZXMg
Q2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IFJlcGxh
Y2UgYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXJfcHJvYmUgd2l0aA0KPiA+IG1vZHVsZV9wbGF0Zm9y
bV9kcml2ZXJfcHJvYmUNCj4gPiBiZWNhdXNlIENPTkZJR19DTEtfSU1YOFFYUCBjYW4gYmUgc2V0
IHRvID1tIChrZXJuZWwgbW9kdWxlKS4NCj4gPiANCj4gPiBGaXhlczogYzJjY2NiNmQwYjMzICgi
Y2xrOiBpbXg6IGFkZCBpbXg4cXhwIGNsayBkcml2ZXIiKQ0KPiA+IEZpeGVzOiAxZTMxMjFiZmU1
MWEgKCJjbGs6IGlteDogYWRkIGlteDhxeHAgbHBjZyBkcml2ZXIiKQ0KPiANCj4gVGhlIGNvcnJl
Y3QgRml4ZXMgdGFnIHdvdWxkIGJlOg0KPiANCj4gRml4ZXM6IGUwZDBkNGQ4NmM3NjYgKCJjbGs6
IGlteDhxeHA6IFN1cHBvcnQgYnVpbGRpbmcgaS5NWDhRWFAgY2xvY2sNCj4gZHJpdmVyIGFzIG1v
ZHVsZSIpDQo+IA0KDQpUaGFua3MsIEkgd2lsbCBmaXggdGhlIHRhZyBpbiBuZXh0IHBhdGNoLg0K
DQpNaWxlcw0KPiBUaGFua3MNCg==

