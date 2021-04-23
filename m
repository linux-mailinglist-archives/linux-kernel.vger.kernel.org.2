Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEC368B91
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbhDWD1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:27:17 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:4564 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231261AbhDWD1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:27:15 -0400
X-UUID: c56bed2877ae42219d9da0dbf8aaa13c-20210423
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=a8s8o3QmfKXtnGeUcw7iC6xSARqbgnnv/EVHI3BDnSE=;
        b=YtGTyDGyIRXk4vdnsGGUJj4Vv4CBw6MATwFvqj1EGReQUwF+Ts7s0WyLlb0AxhX8R/wkxjWJg+Glk6Jakvp/+PDX0sK3VIf+mShZYtamgsB7S180BU+4ZbbnqGIbrV7afUqC+UKKY7OTcMY52duwg3inA2vOxg6ZtJLG01Q96Oo=;
X-UUID: c56bed2877ae42219d9da0dbf8aaa13c-20210423
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 711767088; Fri, 23 Apr 2021 11:26:34 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 11:26:32 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Apr 2021 11:26:31 +0800
Message-ID: <1619148391.4048.6.camel@mhfsdcap03>
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
Date:   Fri, 23 Apr 2021 11:26:31 +0800
In-Reply-To: <YIE3z7qYNtk7G/VB@kroah.com>
References: <20210330080617.3746932-1-ikjn@chromium.org>
         <20210330160508.1.I797d214790033d0402d19ff6b47a34aff60d3062@changeid>
         <1617179455.2752.1.camel@mhfsdcap03> <YGq2YfURFApdJLxb@kroah.com>
         <1617675492.22435.4.camel@mhfsdcap03> <YIE3z7qYNtk7G/VB@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FF15610A808A1ABA467C7CCB2094D285B754C1D6C4AAC46A6E4B9CB772A635982000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTIyIGF0IDEwOjQ2ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFR1ZSwgQXByIDA2LCAyMDIxIGF0IDEwOjE4OjEyQU0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjEtMDQtMDUgYXQgMDk6MDQgKzAyMDAsIEdyZWcg
S3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiA+IE9uIFdlZCwgTWFyIDMxLCAyMDIxIGF0IDA0OjMw
OjU1UE0gKzA4MDAsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiA+ID4gY2MgWWFxaWkgV3UgPFlh
cWlpLld1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IEknbGwgdGVzdCBpdCAsIHRo
YW5rcw0KPiA+ID4gDQo+ID4gPiBEaWQgeW91IHRlc3QgdGhpcyBzZXJpZXMgYW5kIGZpbmQgYW55
IHByb2JsZW1zPyAgSWYgbm90LCBJJ2xsIGdvIHF1ZXVlDQo+ID4gPiB0aGVzZSB1cC4uLg0KPiA+
IFllcywgZm91bmQgYW4gaXNzdWUgb24gdGhlIHN0YXJ0LXNwbGl0IHRyYW5zYWN0aW9uLCBidXQg
bm90IGZvdW5kIHRoZQ0KPiA+IHJvb3QgY2F1c2UgeWV0IDooDQo+IA0KPiBTbyB5b3UgYXJlIG9i
amVjdGluZyB0byB0aGVzZSBiZWluZyBtZXJnZWQgYXQgdGhpcyBwb2ludCBpbiB0aW1lPyANClll
cw0KDQo+ICBDYW4NCj4geW91IHByb3ZpZGUgZmVlZGJhY2sgdG8gdGhlIGF1dGhvciBhYm91dCB3
aGF0IGlzIHdyb25nPw0KQWxyZWFkeSBwcm92aWRlZCBmZWVkYmFjayBhZGQgZGlzY3Vzc2VkIG9u
IGlzc3VlIHRyYWNrZXIgaW4gcHJpdmF0ZQ0KDQpUaGFua3MgYSBsb3QNCg0KPiANCj4gdGhhbmtz
LA0KPiANCj4gZ3JlZyBrLWgNCg0K

