Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C21A3A840D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhFOPgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:36:11 -0400
Received: from mg.richtek.com ([220.130.44.152]:60284 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhFOPgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:36:05 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2021 11:36:04 EDT
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(14675:0:AUTH_RELAY)
        (envelope-from <prvs=179866FE6D=cy_huang@richtek.com>); Tue, 15 Jun 2021 23:33:58 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(7294:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Tue, 15 Jun 2021 23:24:28 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Tue, 15 Jun 2021
 23:24:27 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Tue, 15 Jun 2021
 23:24:27 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: rt6160: Remove vsel_active_low from struct
 rt6160_priv
Thread-Topic: [PATCH] regulator: rt6160: Remove vsel_active_low from struct
 rt6160_priv
Thread-Index: AQHXYdLPWOiSrOYaEEmzo+neCpG1NKsUqK8AgAACnYA=
Date:   Tue, 15 Jun 2021 15:24:27 +0000
Message-ID: <1623770667.4571.4.camel@richtek.com>
References: <20210615103947.3387994-1-axel.lin@ingics.com>
         <162376572819.36399.17993990572863185568.b4-ty@kernel.org>
In-Reply-To: <162376572819.36399.17993990572863185568.b4-ty@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F006F7500B81314397AF173D1B559322@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmsvQXhlbDoNCk5vLCB5b3UgbWF5IG1pc3VuZGVyc3RhbmQgaXQuDQpJZiB2c2VsIGFj
dGl2ZSBpcyBoaWdoLCB0aGUgbm9ybWFsIHZvbHRhZ2Ugb3V0cHV0IHJlZ2lzdGVyIGlzIHZzZWxo
IHJlZ2lzdGVyLA0KYW5kIHRoZSBzdXNwZW5kIHZvbHRhZ2UgaXMgdnNlbGwgcmVnaXN0ZXIuIEVs
c2UsIHJldmVyc2UuDQoNCkF4ZWwncyBjaGFuZ2Ugd2lsbCBjYXVzZSB0aGUgbm9ybWFsL3N1c3Bl
bmQgdm9sdGFnZSBiZSBjb25maWd1cmVkIGZvciB0aGUgc2FtZQ0KcmVnaXN0ZXIuIEl0J3Mgbm90
IGZvciBvdXIgcmVmZXJlbmNlIHVzYWdlLg0KPiBPbiBUdWUsIDE1IEp1biAyMDIxIDE4OjM5OjQ3
ICswODAwLCBBeGVsIExpbiB3cm90ZToNCj4gPg0KPiA+IFVzZSBhIGxvY2FsIHZhcmlhYmxlIGlu
c3RlYWQgaXMgZW5vdWdoLCB0aGlzIHNpbXBsaWZpZXMgdGhlIGNvZGUuDQo+IEFwcGxpZWQgdG8N
Cj4NCj4gICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
YnJvb25pZS9yZWd1bGF0b3IuZ2l0IGZvci0NCj4gbmV4dA0KPg0KPiBUaGFua3MhDQo+DQo+IFsx
LzFdIHJlZ3VsYXRvcjogcnQ2MTYwOiBSZW1vdmUgdnNlbF9hY3RpdmVfbG93IGZyb20gc3RydWN0
IHJ0NjE2MF9wcml2DQo+ICAgICAgIGNvbW1pdDogZjNmNGYzN2Q1M2JlNTc4YzY1ZGQzMmExZmZh
ZDQzMmIzM2FlZjIzNg0KPg0KPiBBbGwgYmVpbmcgd2VsbCB0aGlzIG1lYW5zIHRoYXQgaXQgd2ls
bCBiZSBpbnRlZ3JhdGVkIGludG8gdGhlIGxpbnV4LW5leHQNCj4gdHJlZSAodXN1YWxseSBzb21l
dGltZSBpbiB0aGUgbmV4dCAyNCBob3VycykgYW5kIHNlbnQgdG8gTGludXMgZHVyaW5nDQo+IHRo
ZSBuZXh0IG1lcmdlIHdpbmRvdyAob3Igc29vbmVyIGlmIGl0IGlzIGEgYnVnIGZpeCksIGhvd2V2
ZXIgaWYNCj4gcHJvYmxlbXMgYXJlIGRpc2NvdmVyZWQgdGhlbiB0aGUgcGF0Y2ggbWF5IGJlIGRy
b3BwZWQgb3IgcmV2ZXJ0ZWQuDQo+DQo+IFlvdSBtYXkgZ2V0IGZ1cnRoZXIgZS1tYWlscyByZXN1
bHRpbmcgZnJvbSBhdXRvbWF0ZWQgb3IgbWFudWFsIHRlc3RpbmcNCj4gYW5kIHJldmlldyBvZiB0
aGUgdHJlZSwgcGxlYXNlIGVuZ2FnZSB3aXRoIHBlb3BsZSByZXBvcnRpbmcgcHJvYmxlbXMgYW5k
DQo+IHNlbmQgZm9sbG93dXAgcGF0Y2hlcyBhZGRyZXNzaW5nIGFueSBpc3N1ZXMgdGhhdCBhcmUg
cmVwb3J0ZWQgaWYgbmVlZGVkLg0KPg0KPiBJZiBhbnkgdXBkYXRlcyBhcmUgcmVxdWlyZWQgb3Ig
eW91IGFyZSBzdWJtaXR0aW5nIGZ1cnRoZXIgY2hhbmdlcyB0aGV5DQo+IHNob3VsZCBiZSBzZW50
IGFzIGluY3JlbWVudGFsIHVwZGF0ZXMgYWdhaW5zdCBjdXJyZW50IGdpdCwgZXhpc3RpbmcNCj4g
cGF0Y2hlcyB3aWxsIG5vdCBiZSByZXBsYWNlZC4NCj4NCj4gUGxlYXNlIGFkZCBhbnkgcmVsZXZh
bnQgbGlzdHMgYW5kIG1haW50YWluZXJzIHRvIHRoZSBDQ3Mgd2hlbiByZXBseWluZw0KPiB0byB0
aGlzIG1haWwuDQo+DQo+IFRoYW5rcywNCj4gTWFyaw0KKioqKioqKioqKioqKiBFbWFpbCBDb25m
aWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQoNClRoZSBpbmZvcm1hdGlv
biBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueSBhdHRhY2ht
ZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQsIG9yIG90
aGVyd2lzZSBleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQg
aXMgaW50ZW5kZWQgdG8gYmUgY29udmV5ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGll
bnQocykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJl
dGFpbmluZyBvciBjb3B5aW5nIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1l
bnRzKSBieSB1bmludGVuZGVkIHJlY2lwaWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFu
ZCBtYXkgYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBv
ZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZSB0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1t
YWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgKGJ5IHJl
cGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgYWxsIGNvcGllcyBvZiB0aGlz
IGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgZnJvbSB5b3VyIHN5c3RlbSwgYW5k
IGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFpbCB0byBhbnkgb3RoZXIg
cGVyc29uLiBUaGFuayB5b3UhDQo=
