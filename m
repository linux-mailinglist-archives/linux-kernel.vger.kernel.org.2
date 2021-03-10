Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40032333FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhCJOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhCJOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:07:33 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47057C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=C2YY/wTL0sNdY/+clOyk0UeEW2AcCezLtPf+
        51REsLM=; b=bWZyMD862nkf0DckfoNEmlSRWB1d8FstzqoPmTAvFyL4PBTRJ/TM
        IWV55A+v3HGY9/LjTOVAnVUqJO2fvTCZswCSm7Y+r2kQe5EyiaUqcaLE3bfaa8TV
        NBHe4MbPX7pdd1xrIdxF2fhY25/0054CVh57L7C5hWYvMY0+VztCIzQ=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Wed, 10 Mar
 2021 22:07:05 +0800 (GMT+08:00)
X-Originating-IP: [114.214.224.243]
Date:   Wed, 10 Mar 2021 22:07:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] greybus/operation: Drop reference when message has
 been set
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <YEiSOB05c0iyOFFj@kroah.com>
References: <20210310091014.6407-1-lyl2019@mail.ustc.edu.cn>
 <YEiSOB05c0iyOFFj@kroah.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <180e2dc9.9f50.1781c7669f7.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygBXXJCJ0khgFb0EAA--.0W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQsQBlQhn477VgALse
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIGkgbWlzdGFrZW5seSBkaXZpZGVkIHRoZSBwYXRjaCBpbnRvIHR3byBjb21taXRzLiBX
aGF0IGkgaGF2ZSBzZW50DQppcyB0aGUgbGF0ZXN0IGNvbW1pdCB3aGljaCBjb3JyZWN0ZWQgbXkg
Z3JhbW1hciBpbiB0aGUgcGF0Y2guDQoNCkkgd2lsbCBzZW5kIHRoZSBmdWxsIHBhdGNoIHNvb24u
DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkdyZWcgS0giIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTAzLTEwIDE3
OjMyOjQwICjmmJ/mnJ/kuIkpDQo+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxseWwyMDE5QG1h
aWwudXN0Yy5lZHUuY24+DQo+IOaKhOmAgTogam9oYW5Aa2VybmVsLm9yZywgZWxkZXJAa2VybmVs
Lm9yZywgZ3JleWJ1cy1kZXZAbGlzdHMubGluYXJvLm9yZywgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiDkuLvpopg6IFJlOiBbUEFUQ0hdIGdyZXlidXMvb3BlcmF0aW9uOiBEcm9wIHJl
ZmVyZW5jZSB3aGVuIG1lc3NhZ2UgaGFzIGJlZW4gc2V0DQo+IA0KPiBPbiBXZWQsIE1hciAxMCwg
MjAyMSBhdCAwMToxMDoxNEFNIC0wODAwLCBMdiBZdW5sb25nIHdyb3RlOg0KPiA+IEluIGdiX29w
ZXJhdGlvbl9yZXNwb25zZV9zZW5kLCBnZXQgYW4gZXh0cmEgcmVmZXJlbmNlDQo+ID4gYmVmb3Jl
IGdiX21lc3NhZ2Vfc2VuZCgpIHdpdGggdGhpcyBjb21tZW50ICIvKiBSZWZlcmVuY2Ugd2lsbA0K
PiA+IGJlIGRyb3BwZWQgd2hlbiBtZXNzYWdlIGhhcyBiZWVuIHNlbnQuICovIi4gVGhlcmVmb3Jl
LCB3ZQ0KPiA+IHNob3VsZCBkcm9wIHRoZSBnb3QgcmVmZXJlbmNlIG5vdCBvbmx5IGluIHRoZSBl
cnJvciBicmFuY2gsDQo+ID4gYnV0IGFsc28gaW4gdGhlIGNvbXBsZXRlIGJyYW5jaC4NCj4gDQo+
IFRoYXQncyBub3Qgd2hhdCB5b3VyIHBhdGNoIGRvZXMgYXQgYWxsIDooDQo+IA0K
