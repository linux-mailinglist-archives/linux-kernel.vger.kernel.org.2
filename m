Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB09E3FC33C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbhHaHPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:15:22 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:42962 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239112AbhHaHPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:15:20 -0400
X-UUID: 264a7f8db0d2461c95951a919d751f03-20210831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8w6G2IE3sjCnMBO0KwY4vI3XXmg7cJyry2Y2ZvnNaH8=;
        b=C/JiyAKP7OI8oifk1AWqL0NAmTOtWXpse4A2N9OabTRGIxe8yPuf/NXko1zh2AGmdRTR0oXhsEGKVAHoxKYsmigderlsrUNXs65f3SOgjgWE150tRe2na0F2H/Q+piLn6dlD88OD2rlZJkhtnpGt3W7Q+ud2MmYCER/kWxw41BY=;
X-UUID: 264a7f8db0d2461c95951a919d751f03-20210831
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 627122481; Tue, 31 Aug 2021 15:14:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Aug 2021 15:14:22 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 15:14:22 +0800
Message-ID: <81f4cecd13cd40fcbcdb980bf18375a4a894b118.camel@mediatek.com>
Subject: Re: [PATCH v6 0/5] Add gce support for mt8195
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, <hsinyi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>
Date:   Tue, 31 Aug 2021 15:14:22 +0800
In-Reply-To: <CABb+yY0rTZrM1J7mFbSf0Z5tdwjYsQ8Tff-DnVfxX8P4HRu01w@mail.gmail.com>
References: <20210825094120.5005-1-jason-jh.lin@mediatek.com>
         <CABb+yY0rTZrM1J7mFbSf0Z5tdwjYsQ8Tff-DnVfxX8P4HRu01w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyMS0wOC0z
MCBhdCAwMDozNCAtMDUwMCwgSmFzc2kgQnJhciB3cm90ZToNCj4gT24gV2VkLCBBdWcgMjUsIDIw
MjEgYXQgNDo0MSBBTSBqYXNvbi1qaC5saW4gPA0KPiBqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29t
PiB3cm90ZToNCj4gPiANCj4gPiBDaGFuZ2UgaW4gdjY6DQo+ID4gLSByZW1vdmUgdGhlIHVudXNl
ZCBkZWZpbmUgaW4gR0NFIGhlYWRlciBmaWxlLg0KPiA+IA0KPiANCj4gUGxlYXNlIHJlYmFzZSB0
aGUgcGF0Y2hlcyBvdmVyIG90aGVyIHByZXZpb3VzIG10ayBwYXRjaHNldCBmb3INCj4gbXQ4MTky
Lg0KPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdC5saW5hcm8ub3Jn
L2xhbmRpbmctdGVhbXMvd29ya2luZy9mdWppdHN1L2ludGVncmF0aW9uLmdpdC9sb2cvP2g9bWFp
bGJveC1mb3ItbmV4dF9fOyEhQ1RSTktBOXdNZzBBUmJ3ITBLZWtIQU5VTVFRN09kSC1reTBjaDFy
U2M3a09uM05QRkFPakxyc3J6c2QwWjJyRnZ5c1NGUkFyM1I2YWRZUm5BZko0JA0KPiAgDQo+IA0K
PiBUaGFua3MuDQoNCk9LLCBJJ3ZlIHJlYmFzZWQgb24gbXQ4MTkyIHNlcmllcyBhdCB2NzoNCg0K
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNo
LzIwMjEwODMxMDcwOTAzLjg2NzItMi1qYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tLw0KDQpSZWdh
cmRzLA0KSmFzb24tSkguTGluDQo=

