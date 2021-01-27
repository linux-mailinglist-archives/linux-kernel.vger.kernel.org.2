Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BF6305337
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhA0GbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:31:13 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:49424 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232381AbhA0DIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:08:40 -0500
X-UUID: bf9dee5188064403aeeb1dde90a5d4d7-20210127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Rw/VpEX3T9vli1tbHyKZzNAiYyU8LmRhAEbiaUGY6bs=;
        b=DjXlJcKP0MPY9pVjuPJblfduT3x/oHr6ShWowDqhLj6/QXn0FHrMtMcGHeVcZpdK2463w2nTYN03C+Goyq+FeujHSDMKLSsprGtTP7LmSMYCReCV2lZXhJ0hQfgVBDRSlC3H5acsMxqSHqUkoPCMePNu42wn5UFA54oM/SwBSNY=;
X-UUID: bf9dee5188064403aeeb1dde90a5d4d7-20210127
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1625078767; Wed, 27 Jan 2021 10:14:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 10:14:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 10:14:22 +0800
Message-ID: <1611713663.3905.19.camel@mhfsdcap03>
Subject: Re: [PATCH v6] usb: xhci-mtk: fix unreleased bandwidth data
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ikjoon Jang <ikjn@chromium.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Jan 2021 10:14:23 +0800
In-Reply-To: <b8a2cd47-ff32-2251-4431-da05a0f038f7@intel.com>
References: <20210113180444.v6.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
         <YBAjjmpc4yPrpmgQ@kroah.com>
         <b8a2cd47-ff32-2251-4431-da05a0f038f7@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 017506B0ECBD3990E5B8BE4EFC066A9874C9FCE0C451CA2BA053A9B4C643E5EA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTI2IGF0IDE2OjI3ICswMjAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiBPbiAyNi4xLjIwMjEgMTYuMTMsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiBPbiBX
ZWQsIEphbiAxMywgMjAyMSBhdCAwNjowNToxMVBNICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToN
Cj4gPj4geGhjaS1tdGsgbmVlZHMgWEhDSV9NVEtfSE9TVCBxdWlyayBmdW5jdGlvbnMgaW4gYWRk
X2VuZHBvaW50KCkgYW5kDQo+ID4+IGRyb3BfZW5kcG9pbnQoKSB0byBoYW5kbGUgaXRzIG93biBz
dyBiYW5kd2lkdGggbWFuYWdlbWVudC4NCj4gPj4NCj4gPj4gSXQgc3RvcmVzIGJhbmR3aWR0aCBk
YXRhIGludG8gYW4gaW50ZXJuYWwgdGFibGUgZXZlcnkgdGltZQ0KPiA+PiBhZGRfZW5kcG9pbnQo
KSBpcyBjYWxsZWQsIGFuZCBkcm9wcyB0aG9zZSBpbiBkcm9wX2VuZHBvaW50KCkuDQo+ID4+IEJ1
dCB3aGVuIGJhbmR3aWR0aCBhbGxvY2F0aW9uIGZhaWxzIGF0IG9uZSBlbmRwb2ludCwgYWxsIGVh
cmxpZXINCj4gPj4gYWxsb2NhdGlvbiBmcm9tIHRoZSBzYW1lIGludGVyZmFjZSBjb3VsZCBzdGls
bCByZW1haW4gYXQgdGhlIHRhYmxlLg0KPiA+Pg0KPiA+PiBUaGlzIHBhdGNoIG1vdmVzIGJhbmR3
aWR0aCBtYW5hZ2VtZW50IGNvZGVzIHRvIGNoZWNrX2JhbmR3aWR0aCgpIGFuZA0KPiA+PiByZXNl
dF9iYW5kd2lkdGgoKSBwYXRoLiBUbyBkbyBzbywgdGhpcyBwYXRjaCBhbHNvIGFkZHMgdGhvc2Ug
ZnVuY3Rpb25zDQo+ID4+IHRvIHhoY2lfZHJpdmVyX292ZXJyaWRlcyBhbmQgbGV0cyBtdGsteGhj
aSB0byByZWxlYXNlIGFsbCBmYWlsZWQNCj4gPj4gZW5kcG9pbnRzIGluIHJlc2V0X2JhbmR3aWR0
aCgpIHBhdGguDQo+ID4+DQo+ID4+IEZpeGVzOiAwOGU0NjlkZTg3YTIgKCJ1c2I6IHhoY2ktbXRr
OiBzdXBwb3J0cyBiYW5kd2lkdGggc2NoZWR1bGluZyB3aXRoIG11bHRpLVRUIikNCj4gPj4gU2ln
bmVkLW9mZi1ieTogSWtqb29uIEphbmcgPGlram5AY2hyb21pdW0ub3JnPg0KPiA+IA0KPiA+IE1h
dGhpYXMsIGFueSBvYmplY3Rpb24gdG8gbWUgdGFraW5nIHRoaXMgcGF0Y2gsIG9yIGRvIHlvdSBo
YXZlIG90aGVycw0KPiA+IGJlaW5nIHF1ZXVlZCB1cCBmb3IgNS4xMS1maW5hbD8NCj4gPiANCj4g
DQo+IE5vIG9iamVjdGlvbnMsIGhhdmVuJ3QgdHJpZWQgaXQgb3V0IGJ1dCBpdCBsb29rcyBnb29k
IHRvIG1lLg0KPiANCj4gSWYgSSBmaW5pc2ggc29tZSBhZGRpdGlvbmFsIHNtYWxsIGZpeCBmb3Ig
NS4xMS1maW5hbCBJIGNhbiBtYWtlIGl0IG9uIHRvcCBvZiB0aGlzDQpQbGVhc2UgZ2l2ZSBtZSBz
b21lIHRpbWUgdG8gdGVzdCB0aGlzIHBhdGNoLCB0aGFuayB5b3UNCg0KPiANCj4gLU1hdGhpYXMg
DQoNCg==

