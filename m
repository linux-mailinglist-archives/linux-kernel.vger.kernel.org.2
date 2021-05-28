Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2A0393B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 04:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhE1CJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 22:09:09 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52537 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234834AbhE1CJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 22:09:02 -0400
X-UUID: 1e1e6fe96a7841ecac571174419ff9d4-20210528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=jjcO25Xagr83g07sXePMtvR2r8MtrL12TZBb3C93zGY=;
        b=B3tcxpA1v2hlE4+qT6NFz2DLJ00VP+u3C4/Kh/X7kuDspF40ivxkUy9Ty+5aJZpHRptQcA10mOfdcgg6rFvyPEgZW0RFbPGYhstWhDEw42cDwECNIyrrF+yjwGEFTUw9vlxO1w1duMgEVcnNwe8UTGupoHxPVEBarq3GK8xVzyA=;
X-UUID: 1e1e6fe96a7841ecac571174419ff9d4-20210528
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 996442827; Fri, 28 May 2021 10:07:26 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 May
 2021 10:07:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 May 2021 10:07:19 +0800
Message-ID: <1622167640.5918.4.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] usb: common: add helper to get
 role-switch-default-mode
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 28 May 2021 10:07:20 +0800
In-Reply-To: <YK9uFwkb5+Y6Babz@kroah.com>
References: <1621933165-9661-1-git-send-email-chunfeng.yun@mediatek.com>
         <1621933165-9661-2-git-send-email-chunfeng.yun@mediatek.com>
         <YK9KG5c96VmdHfF3@kroah.com> <1622108619.5918.3.camel@mhfsdcap03>
         <YK9uFwkb5+Y6Babz@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 46C5A099E0518FE1F381C0C8780DF59102CDFEFB71DFB8CB090EC1557BF546D42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTI3IGF0IDEyOjAxICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0IDA1OjQzOjM5UE0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjEtMDUtMjcgYXQgMDk6MjggKzAyMDAsIEdyZWcg
S3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgTWF5IDI1LCAyMDIxIGF0IDA0OjU5
OjI0UE0gKzA4MDAsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiA+ID4gQWRkIGhlbHBlciB0byBn
ZXQgInJvbGUtc3dpdGNoLWRlZmF1bHQtbW9kZSIsIGFuZCBjb252ZXJ0IGl0DQo+ID4gPiA+IHRv
IHRoZSBjb3JyZXNwb25kaW5nIGVudW0gdXNiX2RyX21vZGUNCj4gPiA+ID4gDQo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4g
PiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3VzYi9jb21tb24vY29tbW9uLmMgfCAyMCArKysr
KysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgaW5jbHVkZS9saW51eC91c2Ivb3RnLmggICAgIHwg
IDEgKw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+ID4gPiA+
IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY29tbW9uL2NvbW1vbi5jIGIvZHJp
dmVycy91c2IvY29tbW9uL2NvbW1vbi5jDQo+ID4gPiA+IGluZGV4IGZmZjMxODU5NzMzNy4uNzhh
NjI1YTRlNTI2IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9jb21tb24vY29tbW9u
LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvY29tbW9uL2NvbW1vbi5jDQo+ID4gPiA+IEBA
IC0yMDcsNiArMjA3LDI2IEBAIGVudW0gdXNiX2RyX21vZGUgdXNiX2dldF9kcl9tb2RlKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gPiA+ID4gIH0NCj4gPiA+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHVz
Yl9nZXRfZHJfbW9kZSk7DQo+ID4gPiA+ICANCj4gPiA+ID4gKy8qKg0KPiA+ID4gPiArICogdXNi
X2dldF9yb2xlX3N3aXRjaF9kZWZhdWx0X21vZGUgLSBHZXQgZGVmYXVsdCBtb2RlIGZvciBnaXZl
biBkZXZpY2UNCj4gPiA+ID4gKyAqIEBkZXY6IFBvaW50ZXIgdG8gdGhlIGdpdmVuIGRldmljZQ0K
PiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFRoZSBmdW5jdGlvbiBnZXRzIHN0cmluZyBmcm9tIHBy
b3BlcnR5ICdyb2xlLXN3aXRjaC1kZWZhdWx0LW1vZGUnLA0KPiA+ID4gPiArICogYW5kIHJldHVy
bnMgdGhlIGNvcnJlc3BvbmRpbmcgZW51bSB1c2JfZHJfbW9kZS4NCj4gPiA+ID4gKyAqLw0KPiA+
ID4gPiArZW51bSB1c2JfZHJfbW9kZSB1c2JfZ2V0X3JvbGVfc3dpdGNoX2RlZmF1bHRfbW9kZShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJY29uc3QgY2hhciAqc3Ry
Ow0KPiA+ID4gPiArCWludCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlyZXQgPSBkZXZpY2Vf
cHJvcGVydHlfcmVhZF9zdHJpbmcoZGV2LCAicm9sZS1zd2l0Y2gtZGVmYXVsdC1tb2RlIiwgJnN0
cik7DQo+ID4gPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gPiA+ICsJCXJldHVybiBVU0JfRFJfTU9E
RV9VTktOT1dOOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmV0dXJuIHVzYl9nZXRfZHJfbW9kZV9m
cm9tX3N0cmluZyhzdHIpOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArRVhQT1JUX1NZTUJPTF9HUEwo
dXNiX2dldF9yb2xlX3N3aXRjaF9kZWZhdWx0X21vZGUpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICAv
KioNCj4gPiA+ID4gICAqIHVzYl9kZWNvZGVfaW50ZXJ2YWwgLSBEZWNvZGUgYkludGVydmFsIGlu
dG8gdGhlIHRpbWUgZXhwcmVzc2VkIGluIDF1cyB1bml0DQo+ID4gPiA+ICAgKiBAZXBkOiBUaGUg
ZGVzY3JpcHRvciBvZiB0aGUgZW5kcG9pbnQNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvdXNiL290Zy5oIGIvaW5jbHVkZS9saW51eC91c2Ivb3RnLmgNCj4gPiA+ID4gaW5kZXgg
YTg2ZWU2YWFkNTFiLi5iZGUzMTNjOTdmYjYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2luY2x1ZGUv
bGludXgvdXNiL290Zy5oDQo+ID4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdXNiL290Zy5oDQo+
ID4gPiA+IEBAIC0xMjEsNSArMTIxLDYgQEAgZW51bSB1c2JfZHJfbW9kZSB7DQo+ID4gPiA+ICB9
Ow0KPiA+ID4gPiAgDQo+ID4gPiA+ICBleHRlcm4gZW51bSB1c2JfZHJfbW9kZSB1c2JfZ2V0X2Ry
X21vZGUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiA+ID4gK2V4dGVybiBlbnVtIHVzYl9kcl9t
b2RlIHVzYl9nZXRfcm9sZV9zd2l0Y2hfZGVmYXVsdF9tb2RlKHN0cnVjdCBkZXZpY2UgKmRldik7
DQo+ID4gPiANCj4gPiA+IFdoYXQgb3RoZXIgY29kZSBvdXRzaWRlIG9mIHRoZSBkd2MzIGRyaXZl
ciB3aWxsIGV2ZXIgbmVlZCB0byBjYWxsIHRoaXM/DQo+ID4gSSBwcmVwYXJlIGEgc2VyaWVzIG9m
IHBhdGhlcyBmb3IgbXR1MywgYW5kIHdpbGwgc3VwcG9ydA0KPiA+ICJyb2xlLXN3aXRjaC1kZWZh
dWx0LW1vZGUiIHByb3BlcnR5DQo+IA0KPiBPaywgaG93IGFib3V0IHdlIHdhaXQgdW50aWwgYXQg
bGVhc3QgMiBkcml2ZXJzIG5lZWQgaXQgYmVmb3JlIGFjY2VwdGluZw0KPiB0aGlzIGNoYW5nZS4N
Ck1ha2VzIHNlbnNlLCB0aGFuayB5b3UNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoN
Cg==

