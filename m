Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0954C35A9DF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbhDJBQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:16:10 -0400
Received: from m1561.mail.126.com ([220.181.15.61]:40579 "EHLO
        m1561.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhDJBQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:16:09 -0400
X-Greylist: delayed 1851 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 21:16:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=5/lTD
        DTtvqPXapa1EVayUD87lA5OjiS04PXgFp2HWM4=; b=XWKEfU3I+wKd7eE+0vtRE
        xCey5IwiHqXgbhpQbooKsST3PaWhUW5XVOCcKwlwmi+9AgOu+h9njaOtXv3Ihha6
        YLRfHAvvcmswa/xqakTDprzGiRDkLQGbKGd61djoTqrn+krD9mrgStekQx+YibUD
        sMQ1VO1P0IB6JMTBhcFaCw=
Received: from wangyingjie55$126.com ( [106.17.213.220] ) by
 ajax-webmail-wmsvr61 (Coremail) ; Sat, 10 Apr 2021 08:43:43 +0800 (CST)
X-Originating-IP: [106.17.213.220]
Date:   Sat, 10 Apr 2021 08:43:43 +0800 (CST)
From:   "Yingjie Wang" <wangyingjie55@126.com>
To:     "Alex Deucher" <alexdeucher@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Christian Koenig" <christian.koenig@amd.com>,
        "Dave Airlie" <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Airlie" <airlied@redhat.com>,
        "Maling list - DRI developers" <dri-devel@lists.freedesktop.org>,
        "amd-gfx list" <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH v1] drm/radeon: Fix a missing check bug in
 radeon_dp_mst_detect()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn 126com
In-Reply-To: <CADnq5_OujJOLukc74YQwwW4pdCA-M_4Gz_pZg8Je1ep3HZBBMw@mail.gmail.com>
References: <1617765004-5308-1-git-send-email-wangyingjie55@126.com>
 <CADnq5_OujJOLukc74YQwwW4pdCA-M_4Gz_pZg8Je1ep3HZBBMw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <50fb7dba.1f7.178b93c0caa.Coremail.wangyingjie55@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: PcqowADX5jbA9HBgFpk8AQ--.52414W
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbiVwlvp1pEDRCg5AACsT
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TXkgcGxlYXN1cmUhCkF0IDIwMjEtMDQtMDkgMDQ6MTc6MzYsICJBbGV4IERldWNoZXIiIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+QXBwbGllZC4gIFRoYW5rcyENCj4NCj5BbGV4DQo+
DQo+T24gV2VkLCBBcHIgNywgMjAyMSBhdCAyOjIzIEFNIDx3YW5neWluZ2ppZTU1QDEyNi5jb20+
IHdyb3RlOg0KPj4NCj4+IEZyb206IFlpbmdqaWUgV2FuZyA8d2FuZ3lpbmdqaWU1NUAxMjYuY29t
Pg0KPj4NCj4+IEluIHJhZGVvbl9kcF9tc3RfZGV0ZWN0KCksIFdlIHNob3VsZCBjaGVjayB3aGV0
aGVyIG9yIG5vdCBAY29ubmVjdG9yDQo+PiBoYXMgYmVlbiB1bnJlZ2lzdGVyZWQgZnJvbSB1c2Vy
c3BhY2UuIElmIHRoZSBjb25uZWN0b3IgaXMgdW5yZWdpc3RlcmVkLA0KPj4gd2Ugc2hvdWxkIHJl
dHVybiBkaXNjb25uZWN0ZWQgc3RhdHVzLg0KPj4NCj4+IEZpeGVzOiA5ODQzZWFkMDhmMTggKCJk
cm0vcmFkZW9uOiBhZGQgRGlzcGxheVBvcnQgTVNUIHN1cHBvcnQgKHYyKSIpDQo+PiBTaWduZWQt
b2ZmLWJ5OiBZaW5namllIFdhbmcgPHdhbmd5aW5namllNTVAMTI2LmNvbT4NCj4+IC0tLQ0KPj4g
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2RwX21zdC5jIHwgMyArKysNCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2RwX21zdC5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fZHBfbXN0LmMNCj4+IGluZGV4IDJjMzIxODZjNGFjZC4uNGU0YzkzN2MzNmM2IDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHBfbXN0LmMNCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2RwX21zdC5jDQo+PiBAQCAtMjQyLDYg
KzI0Miw5IEBAIHJhZGVvbl9kcF9tc3RfZGV0ZWN0KHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25u
ZWN0b3IsDQo+PiAgICAgICAgICAgICAgICAgdG9fcmFkZW9uX2Nvbm5lY3Rvcihjb25uZWN0b3Ip
Ow0KPj4gICAgICAgICBzdHJ1Y3QgcmFkZW9uX2Nvbm5lY3RvciAqbWFzdGVyID0gcmFkZW9uX2Nv
bm5lY3Rvci0+bXN0X3BvcnQ7DQo+Pg0KPj4gKyAgICAgICBpZiAoZHJtX2Nvbm5lY3Rvcl9pc191
bnJlZ2lzdGVyZWQoY29ubmVjdG9yKSkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gY29ubmVj
dG9yX3N0YXR1c19kaXNjb25uZWN0ZWQ7DQo+PiArDQo+PiAgICAgICAgIHJldHVybiBkcm1fZHBf
bXN0X2RldGVjdF9wb3J0KGNvbm5lY3RvciwgY3R4LCAmbWFzdGVyLT5tc3RfbWdyLA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByYWRlb25fY29ubmVjdG9yLT5wb3J0
KTsNCj4+ICB9DQo+PiAtLQ0KPj4gMi43LjQNCj4+DQo+PiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdA0KPj4g
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwNCg==
