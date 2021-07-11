Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D066C3C3B2B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 10:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhGKI1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 04:27:35 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17805 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229758AbhGKI1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 04:27:34 -0400
X-UUID: 0d2c36d8a8c24bf3ad6a7ad3e43786aa-20210711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=q0F3BMX9DhrivUfCw8fXy37GhI3a19wIIbjYly0hYiw=;
        b=BFc3Z1+WkZUSuRj7r2D0vceekqVFDOPW6OQtLw8SUPJc6wAPt+WYWwbm4RsLNaK1UbqGXWoo3rUuS7Adjx3EN5VViSl7zGvWEwmG+090Z++JCFu4vWw/KQ3T+zDw+XlgOJt7pLafZn6hdCqd1Q0yckX37Ab0tcksKUpMbf58W/A=;
X-UUID: 0d2c36d8a8c24bf3ad6a7ad3e43786aa-20210711
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 658732960; Sun, 11 Jul 2021 16:24:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 11 Jul
 2021 16:24:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 11 Jul 2021 16:24:41 +0800
Message-ID: <1625991881.22309.9.camel@mhfsdcap03>
Subject: Re: [PATCH 1/9] dt-bindings: memory: mediatek: Add mt8195 smi
 binding
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>
Date:   Sun, 11 Jul 2021 16:24:41 +0800
In-Reply-To: <6e512d15-3acc-2097-1fd1-e021552fdc8d@canonical.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
         <20210616114346.18812-2-yong.wu@mediatek.com>
         <6e512d15-3acc-2097-1fd1-e021552fdc8d@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 20D1DC0E5D2AB0B038420097B719AD1457E17388391A66EBA32555C39061F2FD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA3LTA4IGF0IDExOjI2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNi8wNi8yMDIxIDEzOjQzLCBZb25nIFd1IHdyb3RlOg0KPiA+IFRoaXMgcGF0
Y2ggYWRkcyBtdDgxOTUgc21pIHN1cHBvcnRpbmcgaW4gdGhlIGJpbmRpbmdzLg0KPiA+IA0KPiA+
IEluIG10ODE5NSwgdGhlcmUgYXJlIHR3byBzbWktY29tbW9uIEhXLCBvbmUgaXMgZm9yIHZkbyh2
aWRlbyBvdXRwdXQpLA0KPiA+IHRoZSBvdGhlciBpcyBmb3IgdnBwKHZpZGVvIHByb2Nlc3Npbmcg
cGlwZSkuIFRoZXkgY29ubmVjdHMgd2l0aCBkaWZmZXJlbnQNCj4gPiBzbWktbGFyYnMsIHRoZW4g
c29tZSBzZXR0aW5nKGJ1c19zZWwpIGlzIGRpZmZlcmVudC4gRGlmZmVyZW50aWF0ZSB0aGVtDQo+
ID4gd2l0aCB0aGUgY29tcGF0aWJsZSBzdHJpbmcuDQo+ID4gDQo+ID4gU29tZXRoaW5nIGxpa2Ug
dGhpczoNCj4gPiANCj4gPiAgICAgSU9NTVUoVkRPKSAgICAgICAgICBJT01NVShWUFApDQo+ID4g
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgU01JX0NPTU1PTl9WRE8gICAgICBT
TUlfQ09NTU9OX1ZQUA0KPiA+ICAgLS0tLS0tLS0tLS0tLS0tICAgICAtLS0tLS0tLS0tLS0tLS0t
DQo+ID4gICB8ICAgICAgfCAgIC4uLiAgICAgIHwgICAgICB8ICAgICAuLi4NCj4gPiBsYXJiMCBs
YXJiMiAgLi4uICAgIGxhcmIxIGxhcmIzICAgIC4uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGlu
Z3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24ueWFtbCAgICB8IDYgKysr
KystDQo+ID4gIC4uLi9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxh
cmIueWFtbCAgICAgIHwgMyArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gDQo+IEkgY2Fubm90IGZpbmQgaXQgb24gZGV2aWNl
dHJlZSBsaXN0LCBpdCBzZWVtcyB5b3UgZGlkIG5vdCBDYyBpdC4gUGxlYXNlDQo+IHVzZSBzY3Jp
cHRzL2dldF9tYWludGFpbmVyLnBsLg0KDQpNeSBmYXVsdC4gSSB3aWxsIGFkZCBpbiB0aGUgbmV4
dCB2ZXJzaW9uLg0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4
LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bWVkaWF0ZWsNCg0K

