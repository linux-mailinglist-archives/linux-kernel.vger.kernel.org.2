Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043F0400BC0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhIDPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 11:00:21 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51714 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236742AbhIDPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 11:00:14 -0400
X-UUID: fb87416b2cd341a5b2f243214b0085a5-20210904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=FHLgIAEEakNi3G4ByMylHoF8v7tVxUD3/E3CqkRrE1s=;
        b=T5x0080+DISa8b4E+ENJJX4uUwClB9roNFFiMLys1lLAVlhZqVS8514tV+CJfIXj+pun5XFsrm9SV3jNPhiPFWqnNkicgEykuz6w8w9BaZOB6fPuLNNUY39RQWuYTR3gKLdb7BbKcToE5uW1VdHGTt8RzUmTQj8Ed9VnPptu5LM=;
X-UUID: fb87416b2cd341a5b2f243214b0085a5-20210904
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 651858134; Sat, 04 Sep 2021 22:59:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 4 Sep 2021 22:59:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 4 Sep 2021 22:59:08 +0800
Message-ID: <f1c788985144f97d2abb6b45caf8eb17861a734f.camel@mediatek.com>
Subject: Re: [PATCH] clk: rockchip: use module_platform_driver_probe
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Sat, 4 Sep 2021 22:59:08 +0800
In-Reply-To: <163069397238.405991.15295469394989512619@swboyd.mtv.corp.google.com>
References: <20210902075713.7563-1-miles.chen@mediatek.com>
         <163069397238.405991.15295469394989512619@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA5LTAzIGF0IDExOjMyIC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgTWlsZXMgQ2hlbiAoMjAyMS0wOS0wMiAwMDo1NzoxMykNCj4gPiBSZXBsYWNlIGJ1
aWx0aW5fcGxhdGZvcm1fZHJpdmVyX3Byb2JlIHdpdGgNCj4gPiBtb2R1bGVfcGxhdGZvcm1fZHJp
dmVyX3Byb2JlDQo+ID4gYmVjYXVzZSB0aGF0IHJrMzM5OSBhbmQgcmszNTY4IGNhbiBiZSBidWls
dCBhcyBrZXJuZWwgbW9kdWxlcy4NCj4gPiANCj4gPiBDYzogU3RlcGhlbiBCb3lkIDxzYm95ZEBr
ZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5AbWVk
aWF0ZWsuY29tPg0KPiANCj4gU2hvdWxkIGl0IGhhdmUgYSBmaXhlcyB0YWc/DQoNCm9rLCBJIHdp
bGwgYWRkIGEgZml4ZXMgdGFncyBpbiB0aGUgbmV4dCBwYXRjaC4NCg==

