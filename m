Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839AD375E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 03:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhEGB2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 21:28:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57481 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231461AbhEGB2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 21:28:40 -0400
X-UUID: 44a960886378475ab669c81bb98dbe68-20210507
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iiFfXmQYkdmmOra4wpVCQ2JoiJmpXgudiKiRfa7anYw=;
        b=AtS/J5qJJ9vh8+28zslcbSJirF14gTvDZtnl5SiXvGpA5aPSM6zAowHW2XCbyxhBnlgjQeznpVfKnkrCndmGWbivYmS3vsJNpRkC0Zuw+YJUA2qRoSY+7u/99H3vdJEXbhZnZLAtInjubcfzb4/1iNJgnbSfhZX35EGCnDwav+k=;
X-UUID: 44a960886378475ab669c81bb98dbe68-20210507
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1121447950; Fri, 07 May 2021 09:27:38 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs06n1.mediatek.inc
 (172.21.101.129) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May
 2021 09:27:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 May 2021 09:27:35 +0800
Message-ID: <1620350855.10796.3.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/3] usb: xhci-mtk: use bitfield instead of bool
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Fri, 7 May 2021 09:27:35 +0800
In-Reply-To: <YJOcq+Pq5omZz3p1@kroah.com>
References: <20210506063116.41757-1-chunfeng.yun@mediatek.com>
         <YJOcq+Pq5omZz3p1@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTA2IGF0IDA5OjM3ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFRodSwgTWF5IDA2LCAyMDIxIGF0IDAyOjMxOjE0UE0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBVc2UgYml0ZmllbGQgaW5zdGVhZCBvZiBib29sIGluIHN0cnVjdA0K
PiA+IA0KPiA+IFJlZmVyIHRvIGNvZGluZy1zdHlsZS5yc3QgMTcpIFVzaW5nIGJvb2w6DQo+ID4g
IklmIGEgc3RydWN0dXJlIGhhcyBtYW55IHRydWUvZmFsc2UgdmFsdWVzLCBjb25zaWRlciBjb25z
b2xpZGF0aW5nDQo+ID4gdGhlbSBpbnRvIGEgYml0ZmllbGQgd2l0aCAxIGJpdCBtZW1iZXJzLCBv
ciB1c2luZyBhbiBhcHByb3ByaWF0ZQ0KPiA+IGZpeGVkIHdpZHRoIHR5cGUsIHN1Y2ggYXMgdTgu
Ig0KPiA+IA0KPiA+IER1ZSB0byBAaGFzX2lwcGMncyBkZWZhdWx0IHZhdWxlIGlzIDAsIG5vIG5l
ZWQgc2V0IGl0IGFnYWluIGlmIGZhaWwNCj4gPiB0byBnZXQgaXBwYyBiYXNlIGFkZHJlc3MNCj4g
DQo+IFBsZWFzZSBzcGxpdCB0aGlzIGNoYW5nZSBvdXQgaW50byBhIHNlcGFyYXRlIHBhdGNoLCBh
cyBpdCBoYXMgbm90aGluZyB0bw0KPiBkbyB3aXRoIHRoZSAiY2hhbmdlIHRvIGJpdGZpZWxkIiBj
aGFuZ2UuDQpPaywgdGhhbmtzDQoNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCg==

