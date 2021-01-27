Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA630504C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbhA0Dz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:55:27 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46931 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403813AbhA0Bns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 20:43:48 -0500
X-UUID: 9c54fa535fe94b1fa5a9c195855639f9-20210127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=W0SI6VZP8Q1hw4fDOJjfeymFT5BpumTc7D7uysoxZVU=;
        b=Gx5IuA2e4jUfJdC2k8p80uA5Ru4Qd1NyhwS1gy1qW2fkq0zaQ/Ng9JPLtYQVpG9pBtfCS0+J/UD8fSZX/C4MEug7tFATjAwX6nvXjErWNm1PCwmy1OQszZaaYYYq+qE7UMDnwbhx4ENYGJnBp/11n2boL6UCZk9TCyzbE8jXGFE=;
X-UUID: 9c54fa535fe94b1fa5a9c195855639f9-20210127
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1374956924; Wed, 27 Jan 2021 09:35:00 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 09:34:54 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 09:34:54 +0800
Message-ID: <1611711294.3905.15.camel@mhfsdcap03>
Subject: Re: [PATCH v6] usb: xhci-mtk: fix unreleased bandwidth data
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ikjoon Jang <ikjn@chromium.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Jan 2021 09:34:54 +0800
In-Reply-To: <YBAjRUSEd/6sCl4O@kroah.com>
References: <20210113180444.v6.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
         <1611640920.3905.13.camel@mhfsdcap03> <YBAjRUSEd/6sCl4O@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7E05161C49408F22B8B7A5B2831864F5353E2B4C9D13DED2804C36A88EDAC4192000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTI2IGF0IDE1OjEyICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFR1ZSwgSmFuIDI2LCAyMDIxIGF0IDAyOjAyOjAwUE0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBIaSBJa2pvb24sDQo+ID4gDQo+ID4gQ2FuIEkgcHV0IHRoaXMgcGF0
Y2ggaW50byBteSBwYXRjaCBzZXJpZXMgYWJvdXQgYmFuZHdpZHRoIHNjaGVkdWxlcj8NCj4gPiB0
aGUgc2VyaWVzIGFsc28gaW5jbHVkZSAiW1JGQyBQQVRDSCB2MyAxLzVdIHVzYjogeGhjaS1tdGs6
IGltcHJvdmUNCj4gPiBiYW5kd2lkdGggc2NoZWR1bGluZyB3aXRoIG11bHRpLVRUIiwgcHV0IHRo
ZW0gdG9nZXRoZXIgd2lsbCBoZWxwIHRvIGZpeA0KPiA+IGRlcGVuZGVuY2UgaXNzdWUsIG1lYW53
aGlsZSBJIHRyeSB0byBidWlsZCB4aGNpLW10ay1zY2guYyBpbnRvDQo+ID4geGhjaS1tdGsua28g
aW5zdGVhZCBvZiB4aGNpLWhjZC5rby4NCj4gDQo+IFRoaXMgc2hvdWxkIHByb2JhYmx5IGJlIG1l
cmdlZCBub3csIGZpcnN0LCBhcyBpdCBmaXhlcyBhbiBpc3N1ZSB0aGF0DQo+IHNob3dlZCB1cCBp
biA0LjIwIHNvIHRoaXMgbmVlZHMgdG8gYmUgYmFja3BvcnRlZCB0byBvbGRlciBrZXJuZWxzLg0K
PiANCj4gUGxlYXNlIHJlYmFzZSB5b3VyIGZ1dHVyZSBwYXRjaGVzIG9uIHRvcCBvZiB0aGlzLg0K
T2sNCg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K

