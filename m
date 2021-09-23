Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5752F415A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbhIWJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:04:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:43227 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239985AbhIWJEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:04:15 -0400
X-UUID: d79db8a8e5c34f1c83bbd2c232c2dd86-20210923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/30howK7j/l7YGY93CiAwgCUFI2vv6zdM/0ApO7kiuo=;
        b=We9c6Iwrv9Jqzzzaqx0HGUw0LYmV2mlIul47NPc3BdcH5GGT2iAqV8MJLHJRVuuJ5l1nuaxRg9LsEE5QAsCsaMzCJW4klSUWD6hrZFT9nibXCZv5Oz1o4Y6rnHeAugoGCB2CoviE8FA2+II17LSxpQLMhV9npogPNvVuCznLB3Y=;
X-UUID: d79db8a8e5c34f1c83bbd2c232c2dd86-20210923
Received: from mtkcas35.mediatek.inc [(172.27.6.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1225004111; Thu, 23 Sep 2021 17:02:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Sep
 2021 17:02:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 17:02:32 +0800
Message-ID: <cf5a0b929b9600ec3314f1370939a94ee43a5519.camel@mediatek.com>
Subject: Re: [PATCH] phy: mediatek: Kconfig: Add configuration menu for
 Mediatek phy drivers
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Sep 2021 17:02:34 +0800
In-Reply-To: <20210923025036.348-1-caihuoqing@baidu.com>
References: <20210923025036.348-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9A3403D1E5A39C749996F7595B03727C5473FB5913C85F838A9D17F76712A9BE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA5LTIzIGF0IDEwOjUwICswODAwLCBDYWkgSHVvcWluZyB3cm90ZToNCj4g
QWRkaW5nIGEgY29uZmlndXJhdGlvbiBtZW51IHRvIGhvbGQgbWFueSBNZWRpYXRlayBwaHkgZHJp
dmVycw0KPiBoZWxwcyB0byBtYWtlIHRoZSBtZW51IGRpc3BsYXkgbW9yZSBjb25jaXNlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQ2FpIEh1b3FpbmcgPGNhaWh1b3FpbmdAYmFpZHUuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvcGh5L21lZGlhdGVrL0tjb25maWcgfCAxMCArKysrKy0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL0tjb25maWcNCj4gYi9kcml2ZXJzL3BoeS9t
ZWRpYXRlay9LY29uZmlnDQo+IGluZGV4IDU1ZjhlNmMwNDhhYi4uNWRhMDQ1ODEzYjVhIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMv
cGh5L21lZGlhdGVrL0tjb25maWcNCj4gQEAgLTIsOSArMiwxMSBAQA0KPiAgIw0KPiAgIyBQaHkg
ZHJpdmVycyBmb3IgTWVkaWF0ZWsgZGV2aWNlcw0KPiAgIw0KPiArbWVudSAiUEhZIGRyaXZlcnMg
Zm9yIE1lZGlhdGVrIHBsYXRmb3JtcyINCj4gKwlkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgfHwg
Q09NUElMRV9URVNUDQo+ICsNCj4gIGNvbmZpZyBQSFlfTVRLX1RQSFkNCj4gIAl0cmlzdGF0ZSAi
TWVkaWFUZWsgVC1QSFkgRHJpdmVyIg0KPiAtCWRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8fCBD
T01QSUxFX1RFU1QNCj4gIAlkZXBlbmRzIG9uIE9GICYmIE9GX0FERFJFU1MNCj4gIAlkZXBlbmRz
IG9uIEhBU19JT01FTQ0KPiAgCXNlbGVjdCBHRU5FUklDX1BIWQ0KPiBAQCAtMTgsNyArMjAsNiBA
QCBjb25maWcgUEhZX01US19UUEhZDQo+ICANCj4gIGNvbmZpZyBQSFlfTVRLX1VGUw0KPiAgCXRy
aXN0YXRlICJNZWRpYVRlayBVRlMgTS1QSFkgZHJpdmVyIg0KPiAtCWRlcGVuZHMgb24gQVJDSF9N
RURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCj4gIAlkZXBlbmRzIG9uIE9GDQo+ICAJc2VsZWN0IEdF
TkVSSUNfUEhZDQo+ICAJaGVscA0KPiBAQCAtMjksNyArMzAsNiBAQCBjb25maWcgUEhZX01US19V
RlMNCj4gIA0KPiAgY29uZmlnIFBIWV9NVEtfWFNQSFkNCj4gIAl0cmlzdGF0ZSAiTWVkaWFUZWsg
WFMtUEhZIERyaXZlciINCj4gLQlkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9U
RVNUDQo+ICAJZGVwZW5kcyBvbiBPRiAmJiBPRl9BRERSRVNTDQo+ICAJZGVwZW5kcyBvbiBIQVNf
SU9NRU0NCj4gIAlzZWxlY3QgR0VORVJJQ19QSFkNCj4gQEAgLTQwLDcgKzQwLDYgQEAgY29uZmln
IFBIWV9NVEtfWFNQSFkNCj4gIA0KPiAgY29uZmlnIFBIWV9NVEtfSERNSQ0KPiAgCXRyaXN0YXRl
ICJNZWRpYVRlayBIRE1JLVBIWSBEcml2ZXIiDQo+IC0JZGVwZW5kcyBvbiBBUkNIX01FRElBVEVL
IHx8IENPTVBJTEVfVEVTVA0KPiAgCWRlcGVuZHMgb24gQ09NTU9OX0NMSw0KPiAgCWRlcGVuZHMg
b24gT0YNCj4gIAlzZWxlY3QgR0VORVJJQ19QSFkNCj4gQEAgLTQ5LDkgKzQ4LDEwIEBAIGNvbmZp
ZyBQSFlfTVRLX0hETUkNCj4gIA0KPiAgY29uZmlnIFBIWV9NVEtfTUlQSV9EU0kNCj4gIAl0cmlz
dGF0ZSAiTWVkaWFUZWsgTUlQSS1EU0kgRHJpdmVyIg0KPiAtCWRlcGVuZHMgb24gQVJDSF9NRURJ
QVRFSyB8fCBDT01QSUxFX1RFU1QNCj4gIAlkZXBlbmRzIG9uIENPTU1PTl9DTEsNCj4gIAlkZXBl
bmRzIG9uIE9GDQo+ICAJc2VsZWN0IEdFTkVSSUNfUEhZDQo+ICAJaGVscA0KPiAgCSAgU3VwcG9y
dCBNSVBJIERTSSBmb3IgTWVkaWF0ZWsgU29Dcy4NCj4gKw0KPiArZW5kbWVudQ0KDQpSZXZpZXdl
ZC1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3Mg
YSBsb3QNCg0K

