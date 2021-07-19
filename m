Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0F3CCE59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 09:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhGSHVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 03:21:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49516 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234648AbhGSHU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 03:20:59 -0400
X-UUID: 97a604094717413fb36649ab61b2b197-20210719
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kcrLE2gk3RE5/35eAA/MRhhmrBDDAk4xwCCFzcoaOFM=;
        b=bPvvABPPDT5d5f/16JFYGbW1YAXh0QMpWOtrJC1oR+L++TQJVHW1rYhjKn2+ORO6+N0zxtlMTqsWGiS+PHsO//IssZzmLrIRcVcCgnJac11eI7CARuPhklNHKx1EHCNCmHFBI9OM2lgWU5+PVTIUiMiAE3ZrF8L6eKe4JplgFFk=;
X-UUID: 97a604094717413fb36649ab61b2b197-20210719
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 533750997; Mon, 19 Jul 2021 15:17:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Jul 2021 15:17:55 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Jul 2021 15:17:54 +0800
Message-ID: <1626678127.10522.2.camel@mbjsdccf07>
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add MT6779 spi master dts
 node
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 19 Jul 2021 15:02:07 +0800
In-Reply-To: <1624501564.30242.7.camel@mbjsdccf07>
References: <20210624021137.11513-1-mason.zhang@mediatek.com>
         <1624501564.30242.7.camel@mbjsdccf07>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTI0IGF0IDEwOjI2ICswODAwLCBNYXNvbiBaaGFuZyB3cm90ZToNCj4g
DQo+IERlYXIgTWF0dGhpYXM6DQo+IA0KPiAJSSdtIHNvcnJ5IHRvIGRpc3R1cmIgeW91IGFnYWlu
LCBNeSBjb21wYW55IG1haWxib3ggaGFzIGEgbGl0dGxlIGJ1ZywgaXQNCj4gY2F1c2VkIG15IGNv
bW1lbnRzIGFsd2F5cyBhcHBlYXJpbmcgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLi4uDQo+IAlJIGhh
dmUgdXBkYXRlIGNvbW1pdCBtZXNzYWdlIG5vdywgc28gZG8geW91IGhhdmUgYW55IG90aGVyIGNv
bmNlcm4NCj4gYWJvdXQgdGhpcyBwYXRjaD8gQ2FuIHlvdSBoZWxwIG1lIGdlbnRsZSBwaW5nIG9u
IHRoaXMgcGF0Y2g/DQo+IA0KPiBUaGFua3MNCj4gTWFzb24NCg0KDQpEZWFyIE1hdHRoaWFzOg0K
DQoJQ291bGQgeW91IHBsZWFzZSBnZW50bGUgcGluZyBvbiB0aGlzIHBhdGNoPw0KDQpUaGFua3MN
Ck1hc29uDQoNCg==

