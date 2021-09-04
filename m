Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AB5400BBE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhIDPAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 11:00:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36916 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236731AbhIDO76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 10:59:58 -0400
X-UUID: dd2f59c10dde40eb8b351b4c0373b116-20210904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NcyKglH3WRKZUH2Gc+Xwk717ZaqTZxcE/SFRFahdX94=;
        b=YJftiIpO5RlukKqyVFE2rv2hlVHvyEdBWqTVJb4KUq/EDb2it7jQB58aRtTXrml8qi/dqyOUtcTdKbp0CkiuE4oxq7fbulOeaGqDW6+h76McuCpFiZU+QUmcJ1OPAQMrbQkXfSTYCywPYymOSURGdENxubBKPn2SnOpqYZMCyl0=;
X-UUID: dd2f59c10dde40eb8b351b4c0373b116-20210904
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 322213940; Sat, 04 Sep 2021 22:58:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 4 Sep 2021 22:58:50 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 4 Sep 2021 22:58:50 +0800
Message-ID: <bb2772830f6c47157493a3da3c380590588c9fd5.camel@mediatek.com>
Subject: Re: [PATCH] clk: imx: use module_platform_driver
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Sat, 4 Sep 2021 22:58:50 +0800
In-Reply-To: <163069398650.405991.6861280615873228198@swboyd.mtv.corp.google.com>
References: <20210902080211.7922-1-miles.chen@mediatek.com>
         <163069398650.405991.6861280615873228198@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA5LTAzIGF0IDExOjMzIC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgTWlsZXMgQ2hlbiAoMjAyMS0wOS0wMiAwMTowMjoxMSkNCj4gPiBSZXBsYWNlIGJ1
aWx0aW5fcGxhdGZvcm1fZHJpdmVyX3Byb2JlIHdpdGgNCj4gPiBtb2R1bGVfcGxhdGZvcm1fZHJp
dmVyX3Byb2JlDQo+ID4gYmVjYXVzZSB0aGF0IENPTkZJR19DTEtfSU1YOFFYUCBjYW4gYmUgc2V0
IHRvID1tIChrZXJuZWwgbW9kdWxlKS4NCj4gPiANCj4gPiBDYzogU3RlcGhlbiBCb3lkIDxzYm95
ZEBrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5A
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiANCj4gU2hvdWxkIGl0IGhhdmUgYSBmaXhlcyB0YWc/
DQoNCm9rLCBJIHdpbGwgYWRkIGEgZml4ZXMgdGFncyBpbiB0aGUgbmV4dCBwYXRjaC4NCg==

