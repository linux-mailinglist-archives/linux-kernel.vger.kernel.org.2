Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0535BD41
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbhDLItn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:49:43 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58931 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237831AbhDLIqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:46:49 -0400
X-UUID: 2ae803f1d74144b48a69dd20ece44968-20210412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RweJgmRF+LDjf8Ds2biby3dH1UAHrROV6leebHr8sAA=;
        b=p479TbB3I8hc2HqD2k+sf8GTw9RuJdpQFbcHLXQIExKdJCJf+UDV+bRvMU1NbnSysQ3EM7+Cf7dkTrr1UFsm3stje5TqbROEkB3biIKhmc8tAzievCr+vrVO9fhKuzo2UDCwZ5bTPEKQsZArZAyPBD+A9pF38J+kYTqgS6Aybz0=;
X-UUID: 2ae803f1d74144b48a69dd20ece44968-20210412
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 846852216; Mon, 12 Apr 2021 16:46:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 16:46:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 16:46:23 +0800
Message-ID: <1618217183.16010.4.camel@mtksdaap41>
Subject: Re: [PATCH v1] drm/mediatek: adjust rdma fifo threshold calculate
 formula
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 12 Apr 2021 16:46:23 +0800
In-Reply-To: <1618212332-3547-2-git-send-email-yongqiang.niu@mediatek.com>
References: <1618212332-3547-1-git-send-email-yongqiang.niu@mediatek.com>
         <1618212332-3547-2-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B93D2EA023810F2AB99CA9F7808B7137FCA922C9F707457EE34B03921C380BE52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gTW9uLCAyMDIxLTA0LTEyIGF0IDE1OjI1ICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiB0aGUgb3JnaW5hbCBmb3JtdWxhIHdpbGwgY2F1c2VkIHJkbWEg
ZmlmbyB0aHJlc2hvbGQgY29uZmlnIG92ZXJmbG93DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb25n
cWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCj4gaW5kZXggNzI4YWFhZC4uOGM5MzcxYiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQo+IEBAIC0xNjcsNyAr
MTY3LDcgQEAgdm9pZCBtdGtfcmRtYV9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25l
ZCBpbnQgd2lkdGgsDQo+ICAJICogb3V0cHV0IHRocmVzaG9sZCB0byA2IG1pY3Jvc2Vjb25kcyB3
aXRoIDcvNiBvdmVyaGVhZCB0bw0KPiAgCSAqIGFjY291bnQgZm9yIGJsYW5raW5nLCBhbmQgd2l0
aCBhIHBpeGVsIGRlcHRoIG9mIDQgYnl0ZXM6DQo+ICAJICovDQo+IC0JdGhyZXNob2xkID0gd2lk
dGggKiBoZWlnaHQgKiB2cmVmcmVzaCAqIDQgKiA3IC8gMTAwMDAwMDsNCj4gKwl0aHJlc2hvbGQg
PSByZG1hX2ZpZm9fc2l6ZSAqIDcgLyAxMDsNCg0KSXQncyBiZXR0ZXIgdG8gc2V0IHRocmVzaG9s
ZCBieSB3aWR0aCBhbmQgaGVpZ2h0LCBidXQgaXQgc2VlbXMgdGhhdCBubw0Kb25lIGNvdWxkIGNv
bWUgb3V0IGEgc29sdXRpb24gZm9yIGFsbCBTb0MuIEkgY291bGQganVzdCBhY2NlcHQgdGhpcw0K
c29sdXRpb24sIGJ1dCBJIG5lZWQgc29tZSBhZGRpdGlvbiBjb21tZW50IGZvciB0aGlzIHNvbHV0
aW9uLiBIb3cgZG8geW91DQpkZWNpZGUgNy8xMD8gSW4gdGhlIGZ1dHVyZSwgYW5vdGhlciBtYXkg
bmVlZCB0byBtb2RpZnkgdGhpcyB2YWx1ZSBhbmQgaGUNCm5lZWQgdG8ga25vdyB3aHkgeW91IHVz
ZSA3LzEwLiBJZiB5b3UganVzdCBjaG9vc2UgaXQgYXQgcmFuZG9tLCBqdXN0DQp0ZWxsIHVzIHRo
YXQgeW91IGp1c3QgcmFuZG9tbHkgY2hvb3NlIGl0Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAgCXJl
ZyA9IFJETUFfRklGT19VTkRFUkZMT1dfRU4gfA0KPiAgCSAgICAgIFJETUFfRklGT19QU0VVRE9f
U0laRShyZG1hX2ZpZm9fc2l6ZSkgfA0KPiAgCSAgICAgIFJETUFfT1VUUFVUX1ZBTElEX0ZJRk9f
VEhSRVNIT0xEKHRocmVzaG9sZCk7DQoNCg==

