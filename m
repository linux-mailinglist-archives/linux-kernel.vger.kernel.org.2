Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDE83FD1F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 05:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbhIADt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 23:49:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39178 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241754AbhIADt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 23:49:27 -0400
X-UUID: d800d3cac50c4706b9b06b80dc798561-20210901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hGt1wc4kq8kljXgVH5HFAtVh2cBIgecvwIJfVOk/B78=;
        b=XGSc1ODAjT0mV2s0iM2ZCN5ZLLFj97vqirnpITeZ4O7adYUA9512FZ4vcLrrq/5iuNcvvFZuG4v6OzeCUYPyZ/MbWvq0HK1YjUsUM32iw7cNLz2SZbKUDenOdIhQ4mLCVRgQLNcvmqgfpXdalXKXNIN/CP/0waxuPj+Z6x1gpj4=;
X-UUID: d800d3cac50c4706b9b06b80dc798561-20210901
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1611709793; Wed, 01 Sep 2021 11:48:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Sep 2021 11:48:27 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Sep 2021 11:48:27 +0800
Message-ID: <535478691c3a9ed31b508f59dc897be57c4213c0.camel@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: SND_SOC_MT8195 should depend on
 ARCH_MEDIATEK
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 1 Sep 2021 11:48:27 +0800
In-Reply-To: <7e628e359bde04ceb9ddd74a45931059b4a4623c.1630415860.git.geert+renesas@glider.be>
References: <7e628e359bde04ceb9ddd74a45931059b4a4623c.1630415860.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDE1OjE4ICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IFRoZSBNZWRpYXRlayBNVDgxOTUgc291bmQgaGFyZHdhcmUgaXMgb25seSBwcmVzZW50
IG9uIE1lZGlhdGVrIE1UODE5NQ0KPiBTb0NzLiAgSGVuY2UgYWRkIGEgZGVwZW5kZW5jeSBvbiBB
UkNIX01FRElBVEVLLCB0byBwcmV2ZW50IGFza2luZyB0aGUNCj4gdXNlciBhYm91dCB0aGlzIGRy
aXZlciB3aGVuIGNvbmZpZ3VyaW5nIGEga2VybmVsIHdpdGhvdXQgTWVkaWF0ZWsgU29DDQo+IHN1
cHBvcnQuDQo+IA0KPiBGaXhlczogNjc0NmNjODU4MjU5OTg1YSAoIkFTb0M6IG1lZGlhdGVrOiBt
dDgxOTU6IGFkZCBwbGF0Zm9ybQ0KPiBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiAtLS0NCj4gIHNvdW5kL3Nv
Yy9tZWRpYXRlay9LY29uZmlnIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvS2NvbmZpZyBiL3NvdW5k
L3NvYy9tZWRpYXRlay9LY29uZmlnDQo+IGluZGV4IGNmNTY3YTg5ZjQyMWI0YzAuLmM4YzgxNWY1
OTlkYTkwYmYgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9LY29uZmlnDQo+ICsr
KyBiL3NvdW5kL3NvYy9tZWRpYXRlay9LY29uZmlnDQo+IEBAIC0xODcsNiArMTg3LDcgQEAgY29u
ZmlnIFNORF9TT0NfTVQ4MTkyX01UNjM1OV9SVDEwMTVfUlQ1NjgyDQo+ICANCj4gIGNvbmZpZyBT
TkRfU09DX01UODE5NQ0KPiAgCXRyaXN0YXRlICJBU29DIHN1cHBvcnQgZm9yIE1lZGlhdGVrIE1U
ODE5NSBjaGlwIg0KPiArCWRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8fCBDT01QSUxFX1RFU1QN
Cj4gIAlzZWxlY3QgU05EX1NPQ19NRURJQVRFSw0KPiAgCWhlbHANCj4gIAkgIFRoaXMgYWRkcyBB
U29DIHBsYXRmb3JtIGRyaXZlciBzdXBwb3J0IGZvciBNZWRpYXRlayBNVDgxOTUNCj4gY2hpcA0K
DQpIaSBHZWVydCwNCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoIGZpcnN0Lg0KSSByZWFsbHkgbWlz
c2VkIHRoZSBkZXBlbmRlbmN5IGRlY2xhcmF0aW9uLg0KQnV0IHdlIG9ubHkgdGVzdCAiZGVwZW5k
cyBvbiBBUkNIX01FRElBVEVLIiBpbnRlcm5hbGx5LCBtYXliZSByZW1vdmluZw0KIkNPTVBJTEVf
VEVTVCIgbGlrZSBvdGhlciBNVEsgc2VyaWVzIGlzIGJldHRlciBmb3IgdGhlIG1haW50ZW5hbmNl
IGluDQp0aGUgZnV0dXJlLg0KDQpUaGFua3MsDQpUcmV2b3INCg==

