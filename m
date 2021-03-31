Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCAB34FBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhCaIbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:31:12 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:6035 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231172AbhCaIbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:31:02 -0400
X-UUID: 3850fc3b5091490a92c4b838fc5deb04-20210331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=W3q5DAk4wjiboZB+4xm4r+D77u+vIj/xKBGT22s32q4=;
        b=P3tlUBa1Wl0b+SOqp9657Xsv25LXjXJL8x5LVHWExBGTQi1DM5TDydDf2yaZTopcyjecIfaGlivcxMxlbX311BW40n8+SMFhTMETys7fCHHwKrkhakzwd/7rC5EYEyzzCAYVRyUw3/ig/un6k8VEnAUETDqz2DgNqXtyXSCauu4=;
X-UUID: 3850fc3b5091490a92c4b838fc5deb04-20210331
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 711188797; Wed, 31 Mar 2021 16:30:59 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 31 Mar
 2021 16:30:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 31 Mar 2021 16:30:55 +0800
Message-ID: <1617179455.2752.1.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] usb: xhci-mtk: remove unnecessary assignments in
 periodic TT scheduler
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>, Yaqii Wu <Yaqii.Wu@mediatek.com>
CC:     <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 31 Mar 2021 16:30:55 +0800
In-Reply-To: <20210330160508.1.I797d214790033d0402d19ff6b47a34aff60d3062@changeid>
References: <20210330080617.3746932-1-ikjn@chromium.org>
         <20210330160508.1.I797d214790033d0402d19ff6b47a34aff60d3062@changeid>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BC6F4D0A80AC4B87C9CE430B543EEBEF87DF16C0DE213A0549C1FAF1B0B002352000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y2MgWWFxaWkgV3UgPFlhcWlpLld1QG1lZGlhdGVrLmNvbT4NCg0KSSdsbCB0ZXN0IGl0ICwgdGhh
bmtzDQoNCk9uIFR1ZSwgMjAyMS0wMy0zMCBhdCAxNjowNiArMDgwMCwgSWtqb29uIEphbmcgd3Jv
dGU6DQo+IFJlbW92ZSB1bm5lY2Vzc2FyeSB2YXJpYWJsZXMgaW4gY2hlY2tfc2NoX2J3KCkuDQo+
IE5vIGZ1bmN0aW9uYWwgY2hhbmdlcywganVzdCBmb3IgYmV0dGVyIHJlYWRhYmlsaXR5Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSWtqb29uIEphbmcgPGlram5AY2hyb21pdW0ub3JnPg0KPiAtLS0N
Cj4gDQo+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5jIHwgNTIgKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygr
KSwgMzEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94
aGNpLW10ay1zY2guYyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMNCj4gaW5kZXgg
YTU5ZDFmNmQ0NzQ0Li4wY2I0MTAwN2VjNjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2hv
c3QveGhjaS1tdGstc2NoLmMNCj4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2gu
Yw0KPiBAQCAtNDc5LDYgKzQ3OSw5IEBAIHN0YXRpYyBpbnQgY2hlY2tfc2NoX3R0KHN0cnVjdCBt
dTNoX3NjaF9lcF9pbmZvICpzY2hfZXAsIHUzMiBvZmZzZXQpDQo+ICAJdTMyIHN0YXJ0X2NzLCBs
YXN0X2NzOw0KPiAgCWludCBpOw0KPiAgDQo+ICsJaWYgKCFzY2hfZXAtPnNjaF90dCkNCj4gKwkJ
cmV0dXJuIDA7DQo+ICsNCj4gIAlzdGFydF9zcyA9IG9mZnNldCAlIDg7DQo+ICANCj4gIAlpZiAo
c2NoX2VwLT5lcF90eXBlID09IElTT0NfT1VUX0VQKSB7DQo+IEBAIC02MDYsNTQgKzYwOSw0MSBA
QCBzdGF0aWMgdTMyIGdldF9lc2l0X2JvdW5kYXJ5KHN0cnVjdCBtdTNoX3NjaF9lcF9pbmZvICpz
Y2hfZXApDQo+ICBzdGF0aWMgaW50IGNoZWNrX3NjaF9idyhzdHJ1Y3QgbXUzaF9zY2hfYndfaW5m
byAqc2NoX2J3LA0KPiAgCQkJc3RydWN0IG11M2hfc2NoX2VwX2luZm8gKnNjaF9lcCkNCj4gIHsN
Cj4gLQl1MzIgb2Zmc2V0Ow0KPiAtCXUzMiBtaW5fYnc7DQo+IC0JdTMyIG1pbl9pbmRleDsNCj4g
LQl1MzIgd29yc3RfYnc7DQo+IC0JdTMyIGJ3X2JvdW5kYXJ5Ow0KPiAtCXUzMiBlc2l0X2JvdW5k
YXJ5Ow0KPiAtCXUzMiBtaW5fbnVtX2J1ZGdldDsNCj4gLQl1MzIgbWluX2NzX2NvdW50Ow0KPiAt
CWludCByZXQgPSAwOw0KPiArCWludCBpLCBmb3VuZCA9IC0xOw0KPiArCWNvbnN0IHUzMiBlc2l0
X2JvdW5kYXJ5ID0gZ2V0X2VzaXRfYm91bmRhcnkoc2NoX2VwKTsNCj4gKwljb25zdCB1MzIgYndf
Ym91bmRhcnkgPSBnZXRfYndfYm91bmRhcnkoc2NoX2VwLT5zcGVlZCk7DQo+ICsJdTMyIG1pbl9i
dyA9IH4wOw0KPiAgDQo+ICAJLyoNCj4gIAkgKiBTZWFyY2ggdGhyb3VnaCBhbGwgcG9zc2libGUg
c2NoZWR1bGUgbWljcm9mcmFtZXMuDQo+ICAJICogYW5kIGZpbmQgYSBtaWNyb2ZyYW1lIHdoZXJl
IGl0cyB3b3JzdCBiYW5kd2lkdGggaXMgbWluaW11bS4NCj4gIAkgKi8NCj4gLQltaW5fYncgPSB+
MDsNCj4gLQltaW5faW5kZXggPSAwOw0KPiAtCW1pbl9jc19jb3VudCA9IHNjaF9lcC0+Y3NfY291
bnQ7DQo+IC0JbWluX251bV9idWRnZXQgPSBzY2hfZXAtPm51bV9idWRnZXRfbWljcm9mcmFtZXM7
DQo+IC0JZXNpdF9ib3VuZGFyeSA9IGdldF9lc2l0X2JvdW5kYXJ5KHNjaF9lcCk7DQo+IC0JZm9y
IChvZmZzZXQgPSAwOyBvZmZzZXQgPCBzY2hfZXAtPmVzaXQ7IG9mZnNldCsrKSB7DQo+IC0JCWlm
IChzY2hfZXAtPnNjaF90dCkgew0KPiAtCQkJcmV0ID0gY2hlY2tfc2NoX3R0KHNjaF9lcCwgb2Zm
c2V0KTsNCj4gLQkJCWlmIChyZXQpDQo+IC0JCQkJY29udGludWU7DQo+IC0JCX0NCj4gKwlmb3Ig
KGkgPSAwOyBpIDwgc2NoX2VwLT5lc2l0OyBpKyspIHsNCj4gKwkJdTMyIHdvcnN0X2J3Ow0KPiAg
DQo+IC0JCWlmICgob2Zmc2V0ICsgc2NoX2VwLT5udW1fYnVkZ2V0X21pY3JvZnJhbWVzKSA+IGVz
aXRfYm91bmRhcnkpDQo+ICsJCWlmICgoaSArIHNjaF9lcC0+bnVtX2J1ZGdldF9taWNyb2ZyYW1l
cykgPiBlc2l0X2JvdW5kYXJ5KQ0KPiAgCQkJYnJlYWs7DQo+ICANCj4gLQkJd29yc3RfYncgPSBn
ZXRfbWF4X2J3KHNjaF9idywgc2NoX2VwLCBvZmZzZXQpOw0KPiArCQlpZiAoY2hlY2tfc2NoX3R0
KHNjaF9lcCwgaSkpDQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiArCQl3b3JzdF9idyA9IGdldF9t
YXhfYncoc2NoX2J3LCBzY2hfZXAsIGkpOw0KPiArCQlpZiAod29yc3RfYncgPiBid19ib3VuZGFy
eSkNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICAJCWlmIChtaW5fYncgPiB3b3JzdF9idykgew0K
PiAgCQkJbWluX2J3ID0gd29yc3RfYnc7DQo+IC0JCQltaW5faW5kZXggPSBvZmZzZXQ7DQo+IC0J
CQltaW5fY3NfY291bnQgPSBzY2hfZXAtPmNzX2NvdW50Ow0KPiAtCQkJbWluX251bV9idWRnZXQg
PSBzY2hfZXAtPm51bV9idWRnZXRfbWljcm9mcmFtZXM7DQo+ICsJCQlmb3VuZCA9IGk7DQo+ICAJ
CX0NCj4gIAkJaWYgKG1pbl9idyA9PSAwKQ0KPiAgCQkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+IC0J
YndfYm91bmRhcnkgPSBnZXRfYndfYm91bmRhcnkoc2NoX2VwLT5zcGVlZCk7DQo+ICAJLyogY2hl
Y2sgYmFuZHdpZHRoICovDQo+IC0JaWYgKG1pbl9idyA+IGJ3X2JvdW5kYXJ5KQ0KPiAtCQlyZXR1
cm4gcmV0ID8gcmV0IDogLUVTQ0hfQldfT1ZFUkZMT1c7DQo+ICsJaWYgKGZvdW5kIDwgMCkNCj4g
KwkJcmV0dXJuIC1FU0NIX0JXX09WRVJGTE9XOw0KPiAgDQo+IC0Jc2NoX2VwLT5vZmZzZXQgPSBt
aW5faW5kZXg7DQo+IC0Jc2NoX2VwLT5jc19jb3VudCA9IG1pbl9jc19jb3VudDsNCj4gLQlzY2hf
ZXAtPm51bV9idWRnZXRfbWljcm9mcmFtZXMgPSBtaW5fbnVtX2J1ZGdldDsNCj4gKwlzY2hfZXAt
Pm9mZnNldCA9IGZvdW5kOw0KPiAgDQo+ICAJcmV0dXJuIGxvYWRfZXBfYncoc2NoX2J3LCBzY2hf
ZXAsIHRydWUpOw0KPiAgfQ0KDQo=

