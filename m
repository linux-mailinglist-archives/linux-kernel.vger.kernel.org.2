Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BF141E5D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 03:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351352AbhJABi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 21:38:27 -0400
Received: from unicom146.biz-email.net ([210.51.26.146]:22152 "EHLO
        unicom146.biz-email.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhJABi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 21:38:26 -0400
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((LNX1044)) with ASMTP (SSL) id UBL00036;
        Fri, 01 Oct 2021 09:36:36 +0800
Received: from jtjnmail201621.home.langchao.com (10.100.2.21) by
 jtjnmail201624.home.langchao.com (10.100.2.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 1 Oct 2021 09:36:36 +0800
Received: from jtjnmail201621.home.langchao.com ([fe80::31c7:1db7:6c09:282a])
 by jtjnmail201621.home.langchao.com ([fe80::31c7:1db7:6c09:282a%7]) with mapi
 id 15.01.2308.014; Fri, 1 Oct 2021 09:36:36 +0800
From:   =?gb2312?B?SGFycmlzIHNvbmcgKMvOv60pLcDLs7HQxc+i?= 
        <songkai01@inspur.com>
To:     "dja@axtens.net" <dja@axtens.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "paulus@samba.org" <paulus@samba.org>
Subject: Re: [PATCH] powerpc/eeh:Fix some mistakes in comments
Thread-Topic: [PATCH] powerpc/eeh:Fix some mistakes in comments
Thread-Index: Ade2Y/xuvP/VNTy0RX60R6t1xsfTFw==
Date:   Fri, 1 Oct 2021 01:36:36 +0000
Message-ID: <1423aa2e2ae343ffa487b4e34a815a51@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.27.192]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
tUid:   20211001093636a1d5289678fc2b889ceccaf9b7be5ba6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQo+IEhpIEthaSwNCj4NCj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1
dGlvbiB0byB0aGUgcG93ZXJwYyBrZXJuZWwhDQo+DQo+ID4gR2V0IHJpZCBvZiB3YXJuaW5nOg0K
PiA+IGFyY2gvcG93ZXJwYy9rZXJuZWwvZWVoLmM6Nzc0OiB3YXJuaW5nOiBleHBlY3RpbmcgcHJv
dG90eXBlIGZvcg0KPiA+IGVlaF9zZXRfcGVfZnJlc2V0KCkuIFByb3RvdHlwZSB3YXMgZm9yIGVl
aF9zZXRfZGV2X2ZyZXNldCgpIGluc3RlYWQNCj4NCj4gWW91IGhhdmVuJ3Qgc2FpZCB3aGVyZSB0
aGlzIHdhcm5pbmcgaXMgZnJvbS4gSSB0aG91Z2h0IGl0IG1pZ2h0IGJlIGZyb20gc3BhcnNlDQo+
IGJ1dCBJIGNvdWxkbid0IHNlZW0gdG8gcmVwcm9kdWNlIGl0IC0gaXMgbXkgdmVyc2lvbiBvZiBz
cGFyc2UgdG9vIG9sZCBvciBhcmUgeW91DQo+IHVzaW5nIGEgZGlmZmVyZW50IHRvb2w/DQoNCldl
IGNhbiBnZXQgdGhpcyB3YXJuaW5nIHdoZW4gYnVpbGRpbmcga2VybmVsIHdpdGggJ1c9MScgLg0K
WW91IGNhbiByZWZlciB0byB0aGlzOiAgaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzY4MzQ3Ni8N
Cm9yIHRoaXM6IGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy80NDAwNjAvDQoNCj4gPiAgLyoqDQo+
ID4gLSAqIGVlaF9zZXRfcGVfZnJlc2V0IC0gQ2hlY2sgdGhlIHJlcXVpcmVkIHJlc2V0IGZvciB0
aGUgaW5kaWNhdGVkDQo+ID4gZGV2aWNlDQo+ID4gLSAqIEBkYXRhOiBFRUggZGV2aWNlDQo+ID4g
KyAqIGVlaF9zZXRfZGV2X2ZyZXNldCAtIENoZWNrIHRoZSByZXF1aXJlZCByZXNldCBmb3IgdGhl
IGluZGljYXRlZA0KPiA+ICsgZGV2aWNlDQo+ID4gKyAqIEBlZGV2OiBFRUggZGV2aWNlDQo+ID4g
ICAqIEBmbGFnOiByZXR1cm4gdmFsdWUNCj4gPiAgICoNCj4gPiAgICogRWFjaCBkZXZpY2UgbWln
aHQgaGF2ZSBpdHMgcHJlZmVycmVkIHJlc2V0IHR5cGU6IGZ1bmRhbWVudGFsIG9yDQo+DQo+IFRo
aXMgbG9va3MgbGlrZSBhIGdvb2QgYW5kIGNvcnJlY3QgY2hhbmdlLg0KPg0KPiBJIGNoZWNrZWQg
dGhyb3VnaCBnaXQgaGlzdG9yeSB3aXRoIGdpdCBibGFtZSB0byBzZWUgd2hlbiB0aGUgZnVuY3Rp
b24gd2FzDQo+IHJlbmFtZWQuIFRoZXJlIGFyZSAyIGNvbW1pdHMgdGhhdCBzaG91bGQgaGF2ZSB1
cGRhdGVkIHRoZSBjb21tZW50Og0KPiBvbmUgcmVuYW1lZCB0aGUgZnVuY3Rpb24gYW5kIG9uZSBy
ZW5hbWVkIGFuIGFyZ3VtZW50LiBTbywgSSB0aGluayB0aGlzDQo+IGNvbW1pdCBjb3VsZCBoYXZl
Og0KPg0KPiBGaXhlczogZDZjNDkzMmZiZjI0ICgicG93ZXJwYy9lZWg6IFN0cmVuZ3RoZW4gdHlw
ZXMgb2YgZWVoIHRyYXZlcnNhbA0KPiBmdW5jdGlvbnMiKQ0KPiBGaXhlczogYzI3MGEyNGM1OWJk
ICgicG93ZXJwYy9lZWg6IERvIHJlc2V0IGJhc2VkIG9uIFBFIikNCj4NCj4gQnV0IEkgZG9uJ3Qg
a25vdyBpZiBhbiBvdXQgb2YgZGF0ZSBjb21tZW50IGlzIGVub3VnaCBvZiBhICdidWcnIHRvIGp1
c3RpZnkgYQ0KPiBGaXhlczogdGFnPyAobXBlLCBJJ20gc3VyZSBJJ3ZlIGFza2VkIHRoaXMgYmVm
b3JlLCBzb3JyeSEpDQo+DQo+IEFsbCB1cCwgdGhpcyBpcyBhIGdvb2QgY29ycmVjdGlvbiB0byB0
aGUgY29tbWVudC4NCj4NCj4gVGhlcmUgYXJlIGEgZmV3IG90aGVyIGZ1bmN0aW9ucyBpbiB0aGUg
ZmlsZSB0aGF0IGhhdmUgaW5jb3JyZWN0DQo+IGRvY3N0cmluZ3M6DQo+DQo+ICAtIGVlaF9wY2lf
ZW5hYmxlIC0gbWlzc2luZyBwYXJhbWV0ZXINCj4NCj4gIC0gZWVoX3BlX3Jlc2V0IGFuZCBlZWhf
cGVfcmVzZXRfZnVsbCAtIG1pc3NpbmcgcGFyYW1ldGVyDQo+DQo+ICAtIGVlaF9pbml0IC0gbWlz
c2luZyBwYXJhbWV0ZXINCj4NCj4gIC0gZWVoX3BlX2luamVjdF9lcnIgLSB3cm9uZyBuYW1lIGZv
ciBhIHBhcmFtZXRlcg0KPg0KPiBDb3VsZCB5b3UgZml4IGFsbCBvZiB0aGUgZG9jc3RyaW5ncyBp
biB0aGUgZmlsZSBhdCBvbmNlPw0KDQpJbiBmYWN0LCB0aGVyZSAgYXJlIG90aGVyIHdhcm5pbmdz
IGluIHRoaXMgZmlsZSwgSSB3aWxsIGZpeCB0aGVtIGFuZCBzZW5kIGENCm5ldyBwYXRjaCBzb29u
Lg0KDQpLaW5kIHJlZ2FyZHMsDQpLYWkNCg0K
