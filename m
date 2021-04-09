Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2F359211
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhDIChO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:37:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55787 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232616AbhDIChN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:37:13 -0400
X-UUID: 98d529d427c7440180603aafa709ea04-20210409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8T4E01kxeJRJGPw3gtkiLtJJA6A36FPUJNhqK297rMY=;
        b=tMG5NX2WGYibQZEjbLW5lXAOz/3X36inEQjL7AxEskoMMg4ji91PmzNaYG5GC0PAYLUzsjaO1iGQvHy1bV3ghojofPW20Ux3JQDryj9vq9Jqg7k7+tanPhdm9gGnkc6gRJML0Nm0nlOCws2N+ThLLsfTNJI8Ub5btoI9P3LxYFs=;
X-UUID: 98d529d427c7440180603aafa709ea04-20210409
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2026875261; Fri, 09 Apr 2021 10:36:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 10:36:50 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 10:36:49 +0800
Message-ID: <1617935237.16711.6.camel@mbjsdccf07>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: add MT6779 spi master dts node
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hanks.chen@mediatek.com>,
        <wsd_upstream@mediatek.com>
Date:   Fri, 9 Apr 2021 10:27:17 +0800
In-Reply-To: <4e39785a-06a6-4ec5-5930-8a5bf53e4f7b@gmail.com>
References: <20210226105918.3057-1-Mason.Zhang@mediatek.com>
         <4e39785a-06a6-4ec5-5930-8a5bf53e4f7b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA0LTA3IGF0IDEzOjE3ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gRnJvbSB0aGUgYmluZGluZyBkZXNjcmlwdGlvbjoNCj4gLSAjYWRkcmVzcy1jZWxs
czogc2hvdWxkIGJlIDEuDQo+IA0KPiAtICNzaXplLWNlbGxzOiBzaG91bGQgYmUgMC4NCj4gDQo+
IFdlIGFyZSBtaXNzaW5nIGJvdGggaGVyZS4gUGxlYXNlIGZpeCB0aGF0Lg0KPiANCj4gQXBhcnQg
dGhlIGJpbmRpbmcgZGVzY3JpcHRpb24gaXMgbmFtaW5nIFBMTCwgY2xvY2sgbXV4IGFuZCBjbG9j
ayBnYXRlIElEcyB3aGljaA0KPiBkbyBub3QgY29ycmVzcG9uZCB0byB0aGUgb25lcyB1c2VkIGhl
cmUuIEl0IHNlZW1zIHRoYXQgdGhpcyBiaW5kaW5nIHdhcyB0YWlsb3JlZA0KPiBmb3IgYSBzcGVj
aWZpYyBTb0MgZmFtaWx5IGJ1dCBuZXZlciBtYWRlIGdlbmVyaWMuIElmIHlvdSB3YW50LCBwbGVh
c2UgZG8gc28gYW5kDQo+IGNvbnZlcnQgaXQgdG8geWFtbC4NCg0KDQpEZWFyIE1hdHRoaWFzOg0K
DQoJSSBoYXZlIHVwZGF0ZSBwYXRjaCB2MjoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIxMDQwOTAxNTY1MS4xMTQ3NC0xLU1hc29u
LlpoYW5nQG1lZGlhdGVrLmNvbS8NCg0KCVBsZWFzZSBnZW50bGUgcGluZyBvbiB0aGlzIHBhdGNo
LiBUaGFua3N+DQoJDQpUaGFua3MNCk1hc29uDQoNCgkJCQkgICAgICAgCQkNCg0KDQoNCg0KDQoN
Cg0KDQo=

