Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381323EE1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhHQA57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:57:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33154 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237458AbhHQA5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:57:23 -0400
X-UUID: ce495c5686564724827ffbe9e808d723-20210817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8Se+dA6bWDSCT1uz7OrMcwbFzv7R0Gbma0mJSh3g/IE=;
        b=IreyQIm+HEdAUkdKeuVFSS3S8PPo7aKvgcFk4dE5ezLF24ACJKXIjjP5SPqXceX+95rp6EW2dvjD3iJDKh6brWwsKj29RP+npN4e+7UEznMJD1bWQzfstrEClrbOxKe27epjzjO6Uu6pNjjW7LfiFUD+ahT2TzWBpY1j3GsFvc0=;
X-UUID: ce495c5686564724827ffbe9e808d723-20210817
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 359255259; Tue, 17 Aug 2021 08:56:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 Aug 2021 08:56:46 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Aug 2021 08:56:46 +0800
Message-ID: <326b8ef66a70b526d11b0e2fad4f94b22241e9c1.camel@mediatek.com>
Subject: Re: [PATCH 08/22] clk: mediatek: Add MT8195 ccusys clock support
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 17 Aug 2021 08:56:46 +0800
In-Reply-To: <CAGXv+5ETXT-pxuP1NFEUrV+m3RR25zD9RZmDjHxVOLOy7gGj8w@mail.gmail.com>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
         <20210616224743.5109-9-chun-jie.chen@mediatek.com>
         <CAGXv+5ETXT-pxuP1NFEUrV+m3RR25zD9RZmDjHxVOLOy7gGj8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA3LTA2IGF0IDE3OjAwICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
IE9uIFRodSwgSnVuIDE3LCAyMDIxIGF0IDY6NTkgQU0gQ2h1bi1KaWUgQ2hlbg0KPiA8Y2h1bi1q
aWUuY2hlbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEFkZCBNVDgxOTUgY2N1c3lz
IGNsb2NrIHByb3ZpZGVyDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bi1KaWUgQ2hlbiA8
Y2h1bi1qaWUuY2hlbkBtZWRpYXRlay5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogQ2hlbi1ZdSBU
c2FpIDx3ZW5zdEBjaHJvbWl1bS5vcmc+DQo+IA0KPiBBbHNvLCBJIG5vdGljZWQgdGhhdCBNZWRp
YXRlayBkcml2ZXJzIGRvbid0IHN1cHBvcnQgdGhlIHJlc2V0DQo+IGNvbnRyb2xzIGZvdW5kDQo+
IGluIHRoZXNlIGNsb2NrIGNvbnRyb2xsZXJzLiBBcmUgdGhlcmUgcGxhbnMgdG8gYWRkIHN1cHBv
cnQgZm9yIHRoZW0/DQoNCkF0IHByZXNlbnQsIHdlIGhhdmUgbm8gcGxhbiB0byBzdXBwb3J0IHJl
c2V0IGNvbnRyb2wgaW4gY2xvY2sNCmNvbnRyb2xsZXJzIGJlY2F1c2Ugbm8gcmVxdWVzdCBmcm9t
IHN1YiBzeXN0ZW0sIGJ1dCB3ZSBoYXZlIHJlc2V0DQpjb250cm9sbGVyIGluIE1UODE5NSBmcm9t
IFRPUFJHVSBbMV0uDQoNClsxXSANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9NTIxMjE5DQoNCkJlc3QgUmVnYXJkcywNCkNo
dW4tSmllDQo=

