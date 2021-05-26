Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADE3910E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhEZGxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:53:23 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:34419 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232336AbhEZGxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:53:22 -0400
X-UUID: 31e06eee551c45bc9c1e10fcd046495c-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=Ef3pnCm9We5Q9KDDo1U7lOmeoKmB0n0p7CA0ZFxyAWc=;
        b=o3MLLQjyFsPEKDwPWp1edaaLPSVjLkgsVmf08ZfvqIFZKwtscTjHNj6L9pJ2C96D4Dz7JHQ14jEC/Tu+0wOUnyCmjfLW8kKnMpKx8WNJn+9sgCeNs+q9ZnLvUACENwlu11fFH81F+pCbymsai5TSQWQ3QcLlHyiOwTvVebpegLs=;
X-UUID: 31e06eee551c45bc9c1e10fcd046495c-20210526
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1480313892; Wed, 26 May 2021 14:51:47 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 14:51:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 14:51:44 +0800
Message-ID: <1622011904.21671.3.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] mailbox: mtk-cmdq: Use mailbox rx_callback
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        "Bibby Hsieh" <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 26 May 2021 14:51:44 +0800
In-Reply-To: <CAAOTY_-yo0oWfgaCNNvkESgnWf6cyY=1g0T82-_aTJ-d7EiUWw@mail.gmail.com>
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
         <20210314233323.23377-3-chunkuang.hu@kernel.org>
         <CAAOTY_-yo0oWfgaCNNvkESgnWf6cyY=1g0T82-_aTJ-d7EiUWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F74DB410A06C4BA0766489CE693BD946516CD910FEBAA2C684F99D03057429CB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0K
DQpPbiBXZWQsIDIwMjEtMDUtMjYgYXQgMTQ6MTcgKzA4MDAsIENodW4tS3VhbmcgSHUgd3JvdGU6
DQo+ICsgWW9uZ3FpYW5nDQo+IA0KPiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVs
Lm9yZz4g5pa8IDIwMjHlubQz5pyIMTXml6Ug6YCx5LiAIOS4iuWNiDc6MzPlr6vpgZPvvJoNCj4g
Pg0KPiA+IHJ4X2NhbGxiYWNrIGlzIGEgc3RhbmRhcmQgbWFpbGJveCBjYWxsYmFjayBtZWNoYW5p
c20gYW5kIGNvdWxkIGNvdmVyIHRoZQ0KPiA+IGZ1bmN0aW9uIG9mIHByb3ByaWV0YXJ5IGNtZHFf
dGFza19jYiwgc28gdXNlIHRoZSBzdGFuZGFyZCBvbmUgaW5zdGVhZCBvZg0KPiA+IHRoZSBwcm9w
cmlldGFyeSBvbmUuIEJ1dCB0aGUgY2xpZW50IGRyaXZlciBoYXMgYWxyZWFkeSB1c2VkIGNtZHFf
dGFza19jYiwNCj4gPiBzbyBrZWVwIGNtZHFfdGFza19jYiB1bnRpbCBhbGwgY2xpZW50IGRyaXZl
ciB1c2UgcnhfY2FsbGJhY2sgaW5zdGVhZCBvZg0KPiA+IGNtZHFfdGFza19jYi4NCj4gPg0KPiA+
IENjOiBKYXNzaSBCcmFyIDxqYXNzaXNpbmdoYnJhckBnbWFpbC5jb20+DQo+ID4gQ2M6IE1hdHRo
aWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+ID4gQ2M6IEhvdWxvbmcgV2Vp
IDxob3Vsb25nLndlaUBtZWRpYXRlay5jb20+DQo+ID4gQ2M6IEJpYmJ5IEhzaWVoIDxiaWJieS5o
c2llaEBtZWRpYXRlay5jb20+DQo+ID4gQ2M6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhz
aWVoQG1lZGlhdGVrLmNvbT4NCj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiA+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBDYzogbGlu
dXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW4t
S3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgMTQgKysrKysrKysrLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIGIvZHJpdmVycy9t
YWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IGluZGV4IDNkMzdjMWNkNDBmMS4uZWY1OWUy
MjM0ZjIyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMNCj4gPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gQEAg
LTE4OCw3ICsxODgsMTAgQEAgc3RhdGljIHZvaWQgY21kcV90YXNrX2V4ZWNfZG9uZShzdHJ1Y3Qg
Y21kcV90YXNrICp0YXNrLCBpbnQgc3RhKQ0KPiA+ICAgICAgICAgV0FSTl9PTihjYi0+Y2IgPT0g
KGNtZHFfYXN5bmNfZmx1c2hfY2IpTlVMTCk7DQo+ID4gICAgICAgICBkYXRhLnN0YSA9IHN0YTsN
Cj4gPiAgICAgICAgIGRhdGEuZGF0YSA9IGNiLT5kYXRhOw0KPiA+IC0gICAgICAgY2ItPmNiKGRh
dGEpOw0KPiA+ICsgICAgICAgaWYgKGNiLT5jYikNCj4gPiArICAgICAgICAgICAgICAgY2ItPmNi
KGRhdGEpOw0KPiA+ICsNCj4gPiArICAgICAgIG1ib3hfY2hhbl9yZWNlaXZlZF9kYXRhKHRhc2st
PnRocmVhZC0+Y2hhbiwgJmRhdGEpOw0KPiA+DQo+ID4gICAgICAgICBsaXN0X2RlbCgmdGFzay0+
bGlzdF9lbnRyeSk7DQo+ID4gIH0NCj4gPiBAQCAtNDUxLDEyICs0NTQsMTMgQEAgc3RhdGljIGlu
dCBjbWRxX21ib3hfZmx1c2goc3RydWN0IG1ib3hfY2hhbiAqY2hhbiwgdW5zaWduZWQgbG9uZyB0
aW1lb3V0KQ0KPiA+DQo+ID4gICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUodGFzaywg
dG1wLCAmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBsaXN0X2VudHJ5KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRhdGEuc3RhID0g
LUVDT05OQUJPUlRFRDsNCj4gPiArICAgICAgICAgICAgICAgZGF0YS5kYXRhID0gY2ItPmRhdGE7
DQo+ID4gICAgICAgICAgICAgICAgIGNiID0gJnRhc2stPnBrdC0+YXN5bmNfY2I7DQo+ID4gLSAg
ICAgICAgICAgICAgIGlmIChjYi0+Y2IpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBk
YXRhLnN0YSA9IC1FQ09OTkFCT1JURUQ7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZGF0
YS5kYXRhID0gY2ItPmRhdGE7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChjYi0+Y2IpDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgY2ItPmNiKGRhdGEpOw0KPiA+IC0gICAgICAgICAgICAg
ICB9DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBtYm94X2NoYW5fcmVjZWl2ZWRfZGF0YSh0
YXNrLT50aHJlYWQtPmNoYW4sICZkYXRhKTsNCj4gPiAgICAgICAgICAgICAgICAgbGlzdF9kZWwo
JnRhc2stPmxpc3RfZW50cnkpOw0KPiA+ICAgICAgICAgICAgICAgICBrZnJlZSh0YXNrKTsNCj4g
PiAgICAgICAgIH0NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQoNCg==

