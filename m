Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE6354AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbhDFCSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:18:45 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46834 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238828AbhDFCSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:18:43 -0400
X-UUID: 70bab1c63fc84f59839b9713d3bc079d-20210406
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Gum8DmPKyJ1oZDVQaFVj6BihhQF1RHFD6805mHWOT9s=;
        b=rlcrzLAJBK/n9wRRHdh9o93Z8ea1czFDyxkhqyEvkZRCov2RH1EGc/r58AliqoRvsrFEB+Npv0CR70ZjC1Uq4rEM+2qwXB1kZA1IYeOK3RiA7TCKdSn1aSyB2nNfji3jzxagZQ18npiaLuSGNGYCqWoAEV0lPv4fSzWuEqJegaw=;
X-UUID: 70bab1c63fc84f59839b9713d3bc079d-20210406
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 483669413; Tue, 06 Apr 2021 10:18:18 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Apr
 2021 10:18:12 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Apr 2021 10:18:12 +0800
Message-ID: <1617675492.22435.4.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] usb: xhci-mtk: remove unnecessary assignments in
 periodic TT scheduler
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ikjoon Jang <ikjn@chromium.org>, Yaqii Wu <Yaqii.Wu@mediatek.com>,
        <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 6 Apr 2021 10:18:12 +0800
In-Reply-To: <YGq2YfURFApdJLxb@kroah.com>
References: <20210330080617.3746932-1-ikjn@chromium.org>
         <20210330160508.1.I797d214790033d0402d19ff6b47a34aff60d3062@changeid>
         <1617179455.2752.1.camel@mhfsdcap03> <YGq2YfURFApdJLxb@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 79BB5D152F61C279504AE40E61C8FA02534BFF7A22CD66A437832A019CFDCF482000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTA1IGF0IDA5OjA0ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFdlZCwgTWFyIDMxLCAyMDIxIGF0IDA0OjMwOjU1UE0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBjYyBZYXFpaSBXdSA8WWFxaWkuV3VAbWVkaWF0ZWsuY29tPg0KPiA+
IA0KPiA+IEknbGwgdGVzdCBpdCAsIHRoYW5rcw0KPiANCj4gRGlkIHlvdSB0ZXN0IHRoaXMgc2Vy
aWVzIGFuZCBmaW5kIGFueSBwcm9ibGVtcz8gIElmIG5vdCwgSSdsbCBnbyBxdWV1ZQ0KPiB0aGVz
ZSB1cC4uLg0KWWVzLCBmb3VuZCBhbiBpc3N1ZSBvbiB0aGUgc3RhcnQtc3BsaXQgdHJhbnNhY3Rp
b24sIGJ1dCBub3QgZm91bmQgdGhlDQpyb290IGNhdXNlIHlldCA6KA0KDQo+IA0KPiB0aGFua3Ms
DQo+IA0KPiBncmVnIGstaA0KDQo=

