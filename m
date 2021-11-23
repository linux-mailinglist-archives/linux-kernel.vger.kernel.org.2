Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7537D459F84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhKWJxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:53:12 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60590 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234440AbhKWJxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:53:11 -0500
X-UUID: fd855079537643c4b9462606bf4cdca8-20211123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eK8cNyw7sAT+aeXPMqxaBd/3F94Dku6ahUx4FSXj9aE=;
        b=rGK3uz95OVIl5bMVczCheemocfss6rK5W3/FpyrEYRG4CYAQqx1mr1s+noPBZ71YDT/sdC3hfBpr0JWcWvwBBE9SAJ8+/q+JenX82uF02nBjBJBNCzTld7r4kOvA3Q677JVjJ0eIW0YtLCLs3rfDeDgNpRozlcwMHupiEv/nHuE=;
X-UUID: fd855079537643c4b9462606bf4cdca8-20211123
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1528247596; Tue, 23 Nov 2021 17:49:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 23 Nov 2021 17:49:58 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Nov 2021 17:49:57 +0800
Message-ID: <a0eddcc82cf4fc28eb96d7cb37cf1ad4252d39c3.camel@mediatek.com>
Subject: Re: [PATCH] ASoC: mt8192: remove unnecessary CONFIG_PM
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Tzung-Bi Shih <tzungbi@google.com>
CC:     <broonie@kernel.org>, <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>, kernel test robot <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 23 Nov 2021 17:49:57 +0800
In-Reply-To: <CA+Px+wWeV=9DF7wdSyjaZKS=XCJjri1Dmpf-kfNVZOqm5fV33w@mail.gmail.com>
References: <20211122164644.19442-1-jiaxin.yu@mediatek.com>
         <20211122164644.19442-2-jiaxin.yu@mediatek.com>
         <CA+Px+wWeV=9DF7wdSyjaZKS=XCJjri1Dmpf-kfNVZOqm5fV33w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTIzIGF0IDExOjEyICswODAwLCBUenVuZy1CaSBTaGloIHdyb3RlOg0K
PiBPbiBUdWUsIE5vdiAyMywgMjAyMSBhdCAxMjo0OCBBTSBKaWF4aW4gWXUgPGppYXhpbi55dUBt
ZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYXhpbiBZdSA8amlh
eGluLnl1QG1lZGlhdGVrLmNvbT4NCj4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3Qg
PGxrcEBpbnRlbC5jb20+DQo+IA0KPiBBY2tlZC1ieTogVHp1bmctQmkgU2hpaCA8dHp1bmdiaUBn
b29nbGUuY29tPg0KPiANCj4gQ291bGQgeW91IGFsc28gc3VibWl0IGFub3RoZXIgc2VyaWVzIGZv
ciB0aGUgY2xlYW51cD8NCj4gDQo+IEF0IGxlYXN0IGZvciBzb3VuZC9zb2MvbWVkaWF0ZWsvOg0K
PiAkIHJnIC0tZmlsZXMtd2l0aC1tYXRjaGVzIENPTkZJR19QTSBzb3VuZC9zb2MvbWVkaWF0ZWsv
DQo+IHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxNzMvbXQ4MTczLXJ0NTY1MC1ydDU2NzYuYw0KPiBz
b3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTczL210ODE3My1ydDU2NTAuYw0KPiBzb3VuZC9zb2MvbWVk
aWF0ZWsvbXQ4MTczL210ODE3My1tYXg5ODA5MC5jDQo+IHNvdW5kL3NvYy9tZWRpYXRlay9tdDgx
NzMvbXQ4MTczLXJ0NTY1MC1ydDU1MTQuYw0KPiBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ2Nzk3L210
Njc5Ny1hZmUtcGNtLmMNCj4gc291bmQvc29jL21lZGlhdGVrL210MjcwMS9tdDI3MDEtYWZlLXBj
bS5jDQo+IHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLWFmZS1wY20uYw0KPiBzb3Vu
ZC9zb2MvbWVkaWF0ZWsvbXQ4MTgzL210ODE4My1hZmUtcGNtLmMNCg0KSGkgVHp1bmctQmksDQoN
Ck9rLCBJIHdpbGwgcmVtb3ZlIHRoZW0gZnJvbSBzb3VuZC9zb2MvbWVkaWF0ZWsgZm9sZGVyIGlu
IFBBVENIIHYyLg0KVGhhbmsgeW91IGZvciByZW1pbmRpbmcuDQo=

