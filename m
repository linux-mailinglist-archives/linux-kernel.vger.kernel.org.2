Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6449E3FE540
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbhIAWI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:08:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53968 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233019AbhIAWI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:08:57 -0400
X-UUID: 3ba14582651447f6bda4bac907e028a1-20210902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Vxm8OfcPv3Z1bZ9jCgt5GQ0yi2tsrN7IlwlS189zzpM=;
        b=HKm92zW0so/0QyMn1t98skmQMeVOfm5Nfuu0pMu9LNz2yCgomMDI1ZvhEYwy1+N2/N5SYw1SmMD8YqieLIiUrQ4LRn7pH+3my0c+kY78oZNfLl4BFQ3d0zlG4PbwW1Qtvm4gY81md61G9nVrX17rulXD3adcIteDfWV/POuOndQ=;
X-UUID: 3ba14582651447f6bda4bac907e028a1-20210902
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1153041555; Thu, 02 Sep 2021 06:07:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 06:07:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 06:07:54 +0800
Message-ID: <8f5193d84f40f400255577d5035c9e2f5f016057.camel@mediatek.com>
Subject: Re: [PATCH v2 4/4] clk: mediatek: use tristate for
 COMMON_CLK_MEDAITEK and COMMON_CLK_MT6779
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>
Date:   Thu, 2 Sep 2021 06:07:54 +0800
In-Reply-To: <163047482135.42057.4815394359554916322@swboyd.mtv.corp.google.com>
References: <20210831164210.15455-1-miles.chen@mediatek.com>
         <20210831164210.15455-5-miles.chen@mediatek.com>
         <163047482135.42057.4815394359554916322@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDIyOjQwIC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgTWlsZXMgQ2hlbiAoMjAyMS0wOC0zMSAwOTo0MjoxMCkNCj4gPiBOb3cgd2UgaGF2
ZSBhbGwgbmVjZXNzYXJ5IGV4cG9ydGVkIHN5bWJvbHMsIGNoYW5nZQ0KPiA+IENPTU1PTl9DTEtf
TUVEQUlURUsgYW5kIENPTU1PTl9DTEtfTVQ2Nzc5KiB0byB0cmlzdGF0ZS4NCj4gPiANCj4gDQo+
IFBsZWFzZSBzcXVhc2ggdGhpcyB3aXRoIHRoZSBwYXRjaCB0aGF0IG1ha2VzIHRoZW0gaW50byBt
b2R1bGFyDQo+IGRyaXZlcnMuDQoNCk5vIHByb2JsZW0uDQo+IA0KPiA+IENjOiBTdGVwaGVuIEJv
eWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IEhhbmtzIENoZW4gPGhhbmtzLmNoZW5AbWVk
aWF0ZWsuY29tPg0KPiA+IENjOiBXZW5kZWxsIExpbiA8d2VuZGVsbC5saW5AbWVkaWF0ZWsuY29t
Pg0KPiA+IENjOiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0K

