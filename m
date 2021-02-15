Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120D431B8A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBOMDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:03:51 -0500
Received: from esa9.hc324-48.eu.iphmx.com ([207.54.69.27]:25404 "EHLO
        esa9.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230137AbhBOMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:02:49 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2021 07:02:46 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1613390567; x=1644926567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1mA8wIgHN+z6L4F5z86ceQfbxFBKQKsTySk3GSWNrIc=;
  b=aUPqlJGaYdSLXIay5YrnLJEhSlIMsrqffpvOclOFnu/GITa8n+BM9Tx/
   2xrMX8lt14ABA+PRzdWC3oDjKUEV2MphN1QqzlkDzTO9Wxo6Hyr9jqXnx
   0fKXVZt1sZOuavVQ6CP2svtnS4Daw70pu+7MVMOsT3acUK2WbobmKl774
   0=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa9.hc324-48.eu.iphmx.com with ESMTP/TLS; 15 Feb 2021 12:54:09 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw6.muc with ESMTP/TLS;
 15 Feb 2021 12:54:09 +0100
Received: from smucm10k.bmwgroup.net (HELO smucm10k.europe.bmw.corp) ([160.48.96.47])
 by esabb2.muc with ESMTP/TLS; 15 Feb 2021 12:54:09 +0100
Received: from smucm10m.europe.bmw.corp (160.48.96.49) by smucm10k.europe.bmw.corp
 (160.48.96.47) with Microsoft SMTP Server (TLS;
 Mon, 15 Feb 2021 12:54:09 +0100
Received: from smucm10m.europe.bmw.corp ([160.48.96.49]) by
 smucm10m.europe.bmw.corp ([160.48.96.49]) with mapi id 15.00.1497.010; Mon,
 15 Feb 2021 12:54:08 +0100
From:   <Viktor.Rosendahl@bmw.de>
To:     <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add the latency-collector to tools
Thread-Topic: [PATCH] Add the latency-collector to tools
Thread-Index: AQHXAJGP4XBNff+fAUa2aU9NFMM3FKpTTikAgAERnwCABLDZAA==
Date:   Mon, 15 Feb 2021 11:54:08 +0000
Message-ID: <d68f3fca6e72e090b56d7097884ac1a3f50f4a18.camel@bmw.de>
References: <20210126142652.41b961f2@gandalf.local.home>
         <20210211161742.25386-1-Viktor.Rosendahl@bmw.de>
         <20210211145648.1e1e1325@gandalf.local.home>
         <d2a434e4dfa012dcfdf6525f26ffaa04671fcab9.camel@bmw.de>
In-Reply-To: <d2a434e4dfa012dcfdf6525f26ffaa04671fcab9.camel@bmw.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C8112EE910BF84FA4222B76BEFAF73A@bmwmail.corp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAyLTEyIGF0IDEzOjE2ICswMTAwLCBWaWt0b3IgUm9zZW5kYWhsIHdyb3Rl
Og0KPiANCj4gDQo+IEhvd2V2ZXIsIGZvciBzb21lIHJlYXNvbiBJIGNhbm5vdCByZXByb2R1Y2Ug
dGhlIGJlaGF2aW9yIG5vdywgYWxsdGhvdWdoIEkgdXNlDQo+IGV4YWN0bHkgdGhlIHNhbWUga2Vy
bmVsLg0KPiANCj4gQmVjYXVzZSBodW1hbnMgYXJlIG1vcmUgb2Z0ZW4gYXQgZmF1bHQgdGhhbiBj
b21wdXRlcnMsIEkgY2Fubm90IGRlbnkgdGhlDQo+IHBvc3NpYmlsaXR5IHRoYXQgSSB3b3VsZCBo
YXZlIG1pc2NvbmZpZ3VyZWQgc29tZXRoaW5nIGFuZCBpdCB3YXMgYWxsIHRoZQ0KPiByZXN1bHQN
Cj4gb2YgYSBmYXVsdHkgdGVzdC4NCj4gDQoNCkp1c3QgYSBxdWljayB1cGRhdGU6IEkgd2FzIGFi
bGUgdG8gcmVwcm9kdWNlIHRoaXMgd2VpcmQgYmVoYXZpb3IgdGhhdCBJIHdyb3RlDQphYm91dCBi
dXQgaXQgdHVybmVkIG91dCB0byBiZSBhIHByb2JsZW0gd2l0aCBteSB0ZXN0aW5nLg0KDQpUaGUg
dGVzdCB3YXMgZmF1bHR5IGJlY2F1c2Ugb2YgYSBtaXN0YWtlIHRoYXQgSSBoYWQgbWFkZS4NCg0K
U29ycnkgZm9yIHRoZSBleHRyYSBub2lzZS4NCg0KYmVzdCByZWdhcmRzLA0KDQpWaWt0b3INCg0K
DQo+IEkgd2lsbCBsZXQgeW91IGtub3cgaWYgY29tZSB1cCB3aXRoIGEgd2F5IG9mIHJlcHJvZHVj
aW5nIHRoaXMgYmVoYXZpb3IgbGF0ZXIuDQo+IEkNCj4gY2Fubm90IHNwZW5kIG1vcmUgdGltZSBv
biBpdCByaWdodCBub3cuDQo+IA0KPiA+IA0KDQo=
