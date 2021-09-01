Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7649B3FE534
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243412AbhIAWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:05:19 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:37564 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232025AbhIAWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:05:18 -0400
X-UUID: f2d4b787ce034378bb80a742a64efce9-20210902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dechZ3xSa+k6eciQYNq2w2jcJKlpQJ63PvPD4NTpepM=;
        b=SQU1gIwhzcwrNYRwtiDrAsJ6ax2tYANm3kmm6W3ubEsDz1H9CQNhg4olDUjOPH+id3ekEyb88srRJ/+rzOQ4elzNt46XGCGeS6eQxGct5K/c0EK903nOzphlZFo7QUEG8PNLNK7zltSLNcudFsVEI4xZFWE+BhRC1yF2ikvk88E=;
X-UUID: f2d4b787ce034378bb80a742a64efce9-20210902
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1029753929; Thu, 02 Sep 2021 06:04:18 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 06:04:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 06:04:16 +0800
Message-ID: <67a7d4bccfc56c5960ca370bcbfb5ca6c9693f21.camel@mediatek.com>
Subject: Re: [RESEND PATCH 3/4] clk: mediatek: support COMMON_CLK_MT6779
 module build
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        "Hanks Chen" <hanks.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>
Date:   Thu, 2 Sep 2021 06:04:16 +0800
In-Reply-To: <163047434049.42057.5688419707288938766@swboyd.mtv.corp.google.com>
References: <20210813032429.14715-1-miles.chen@mediatek.com>
         <20210813032429.14715-4-miles.chen@mediatek.com>
         <163021049667.2676726.10138202396240942833@swboyd.mtv.corp.google.com>
         <1630348984.24981.2.camel@mtkswgap22>
         <163047434049.42057.5688419707288938766@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDIyOjMyIC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgTWlsZXMgQ2hlbiAoMjAyMS0wOC0zMCAxMTo0MzowNCkNCj4gPiANCj4gPiBzb3Jy
eSBmb3IgbXkgbGF0ZSByZXNwb25zZS4gDQo+ID4gDQo+ID4gVGhhbmtzIGZvciBwb2ludGluZyB0
aGlzIG91dC4gSSBoYXZlIHRoZSBzYW1lIHF1ZXN0aW9uIHdoZW4gSSB3YXMNCj4gPiBidWlsZGlu
ZyB0aGlzIHBhdGNoLiBUaGF0IHRpbWUgSSBmb3VuZCBzb21lIGV4YW1wbGVzIHdoZXJlDQo+ID4g
dGhleSBhcmUgdXNpbmcgYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIgYW5kIGNhbiBiZSBidWlsdCBh
cyANCj4gPiBrZXJuZWwgbW9kdWxlczoNCj4gPiANCj4gPiBjb25maWcgQ0xLX0lNWDhRWFAgKHRy
aXN0YXRlKSAmJiBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhxeHAtbHBjZy5jDQo+ID4gY29uZmln
IENMS19SSzMzOTkgKHRyaXN0YXRlKSAmJiBkcml2ZXJzL2Nsay9yb2NrY2hpcC9jbGstcmszMzk5
LmMNCj4gDQo+IFdlIHNob3VsZCBmaXggdGhvc2UgZHJpdmVycy4gQ2FyZSB0byBzZW5kIGEgcGF0
Y2g/DQoNCk5vIHByb2JsZW0uIEkgd2lsbCBjaGVjayBkcnZpZXJzL2NsayBhbmQgc3VibWl0IGZp
eCBwYXRjaGVzLg0KDQpNaWxlcw0K

