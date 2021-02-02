Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D4230B74F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 06:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhBBFpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 00:45:53 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46975 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231816AbhBBFpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 00:45:46 -0500
X-UUID: 616ef20b39544bfda3a062f56e4f4edc-20210202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=vWZcC6YYw0lqvkHoZHkoY+ftCFJwcPe9Rtlupgtwkho=;
        b=qR6n7zYCrjsTKIGiSMZ/aQsBrPeN74rGsNBiHhxquNcMhzxbXhilPHqbM3i9pd+G/1HHcmS1sGrhMXTFYKgo2uI3GaQcr2YbJ/cpa23X88kL8YXkHbtM0tFscMhCxIgZmF9xTQfoxwO38sC1Do196c9Z3BWUC7EZswVCD5aHTUg=;
X-UUID: 616ef20b39544bfda3a062f56e4f4edc-20210202
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1819939490; Tue, 02 Feb 2021 13:45:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Feb 2021 13:44:57 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Feb 2021 13:44:57 +0800
Message-ID: <1612244696.5495.3.camel@mtksdaap41>
Subject: Re: [PATCH v5 5/8] drm/mediatek: Fix ccorr size config
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Date:   Tue, 2 Feb 2021 13:44:56 +0800
In-Reply-To: <20210201103727.376721-6-hsinyi@chromium.org>
References: <20210201103727.376721-1-hsinyi@chromium.org>
         <20210201103727.376721-6-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A2F3823DA73417D98C8401BF44D7E2D7A02393686702781434F89992CD26FE732000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIE1vbiwgMjAyMS0wMi0wMSBhdCAxODozNyArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBGcm9tOiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlh
dGVrLmNvbT4NCj4gDQo+IEZpeCBzZXR0aW5nIHRvIGZvbGxvdyBoYXJkd2FyZSBkYXRhc2hlZXQu
IFRoZSBvcmlnaW5hbCBlcnJvciBzZXR0aW5nDQo+IGFmZmVjdHMgbXQ4MTkyIGRpc3BsYXkuDQoN
ClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogSHNpbi1ZaSBXYW5nIDxoc2lueWlAY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Njb3JyLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYw0KPiBpbmRleCA2ZWUyNDMxZTZiODQz
Li42Yzg2NjczYTgzNWMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfY2NvcnIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfY2NvcnIuYw0KPiBAQCAtNjUsNyArNjUsNyBAQCB2b2lkIG10a19jY29ycl9jb25maWcoc3Ry
dWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2Rp
c3BfY2NvcnIgKmNjb3JyID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICANCj4gLQltdGtfZGRw
X3dyaXRlKGNtZHFfcGt0LCBoIDw8IDE2IHwgdywgJmNjb3JyLT5jbWRxX3JlZywgY2NvcnItPnJl
Z3MsDQo+ICsJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgdyA8PCAxNiB8IGgsICZjY29yci0+Y21k
cV9yZWcsIGNjb3JyLT5yZWdzLA0KPiAgCQkgICAgICBESVNQX0NDT1JSX1NJWkUpOw0KPiAgCW10
a19kZHBfd3JpdGUoY21kcV9wa3QsIENDT1JSX0VOR0lORV9FTiwgJmNjb3JyLT5jbWRxX3JlZywg
Y2NvcnItPnJlZ3MsDQo+ICAJCSAgICAgIERJU1BfQ0NPUlJfQ0ZHKTsNCg0K

