Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584D4368CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbhDWGHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:07:42 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:50274 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230131AbhDWGHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:07:39 -0400
X-UUID: 71cd7dbfa9b64ae2b60d6fe83610377d-20210423
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qKNRpZ4EQ+9jotaNrjrSFEj6kXwJTJJ5QGpQogNsh2I=;
        b=boRMQ6X63mW9Unsu6RN8B/XyaRt6w4sFEq9vPV7Ic8yLNFNB17F1AJ8Utc3Gr5/EgyWgfV4Srd6Ll1WREKbcI7gwZBEoBw8OClJ1yRrwSDCShLjGTyOqJyPRf7BttOkCYzfOWk5Pd2ohaMA3potJme7Vi946aEH8nVArxbRk6cY=;
X-UUID: 71cd7dbfa9b64ae2b60d6fe83610377d-20210423
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1793768800; Fri, 23 Apr 2021 14:06:55 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 14:06:49 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Apr 2021 14:06:48 +0800
Message-ID: <1619158008.4048.10.camel@mhfsdcap03>
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
Date:   Fri, 23 Apr 2021 14:06:48 +0800
In-Reply-To: <YIJZvN8py7s+Zq6I@kroah.com>
References: <20210330080617.3746932-1-ikjn@chromium.org>
         <20210330160508.1.I797d214790033d0402d19ff6b47a34aff60d3062@changeid>
         <1617179455.2752.1.camel@mhfsdcap03> <YGq2YfURFApdJLxb@kroah.com>
         <1617675492.22435.4.camel@mhfsdcap03> <YIE3z7qYNtk7G/VB@kroah.com>
         <1619148391.4048.6.camel@mhfsdcap03> <YIJZvN8py7s+Zq6I@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1B667E5A54943B80BF95B365D7D390CBCA4920A8D3A472FCE67460DA8E430A4E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTIzIGF0IDA3OjIzICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIEZyaSwgQXByIDIzLCAyMDIxIGF0IDExOjI2OjMxQU0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjEtMDQtMjIgYXQgMTA6NDYgKzAyMDAsIEdyZWcg
S3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgQXByIDA2LCAyMDIxIGF0IDEwOjE4
OjEyQU0gKzA4MDAsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCAyMDIxLTA0
LTA1IGF0IDA5OjA0ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+ID4gPiA+ID4g
T24gV2VkLCBNYXIgMzEsIDIwMjEgYXQgMDQ6MzA6NTVQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+ID4gPiA+ID4gY2MgWWFxaWkgV3UgPFlhcWlpLld1QG1lZGlhdGVrLmNvbT4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSdsbCB0ZXN0IGl0ICwgdGhhbmtzDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gRGlkIHlvdSB0ZXN0IHRoaXMgc2VyaWVzIGFuZCBmaW5kIGFueSBwcm9ibGVt
cz8gIElmIG5vdCwgSSdsbCBnbyBxdWV1ZQ0KPiA+ID4gPiA+IHRoZXNlIHVwLi4uDQo+ID4gPiA+
IFllcywgZm91bmQgYW4gaXNzdWUgb24gdGhlIHN0YXJ0LXNwbGl0IHRyYW5zYWN0aW9uLCBidXQg
bm90IGZvdW5kIHRoZQ0KPiA+ID4gPiByb290IGNhdXNlIHlldCA6KA0KPiA+ID4gDQo+ID4gPiBT
byB5b3UgYXJlIG9iamVjdGluZyB0byB0aGVzZSBiZWluZyBtZXJnZWQgYXQgdGhpcyBwb2ludCBp
biB0aW1lPyANCj4gPiBZZXMNCj4gPiANCj4gPiA+ICBDYW4NCj4gPiA+IHlvdSBwcm92aWRlIGZl
ZWRiYWNrIHRvIHRoZSBhdXRob3IgYWJvdXQgd2hhdCBpcyB3cm9uZz8NCj4gPiBBbHJlYWR5IHBy
b3ZpZGVkIGZlZWRiYWNrIGFkZCBkaXNjdXNzZWQgb24gaXNzdWUgdHJhY2tlciBpbiBwcml2YXRl
DQo+IA0KPiBUaGF0IGRvZXNuJ3QgaGVscCB1cyBtdWNoIGFzIHdlIGNhbid0IHNlZSB0aGF0IDoo
DQo+IA0KPiBQbGVhc2UgYWx3YXlzIGtlZXAgdXMgaW5mb3JtZWQgYXMgdG8gd2hhdCBpcyBnb2lu
ZyBvbiB3aXRoIHB1YmxpY2FsbHkNCj4gcG9zdGVkIGNoYW5nZXMsIG90aGVyd2lzZSB5b3UgY291
bGQgZmluZCB0aGVtIGJlaW5nIHBpY2tlZCB1cCBhbmQgbWVyZ2VkDQo+IGludG8gdHJlZXMgd2l0
aG91dCBhbiBvYmplY3Rpb24uDQpHb3QgaXQuDQpJJ2xsIHVwZGF0ZSBzdGF0dXMgd2hlbiBmaW5k
IHRoZSByb290IGNhdXNlIG9mIFNTIHRyYW5zYWN0aW9uIGlzc3VlLA0KdGhhbmtzIGEgbG90Lg0K
DQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQo=

