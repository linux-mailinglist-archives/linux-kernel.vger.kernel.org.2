Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5AA3FB48F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhH3L32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:29:28 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:55490 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhH3L31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:29:27 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 17UBRuHu019131; Mon, 30 Aug 2021 20:27:56 +0900
X-Iguazu-Qid: 34trwupu8dwZ27DK8v
X-Iguazu-QSIG: v=2; s=0; t=1630322875; q=34trwupu8dwZ27DK8v; m=Qh63Ydy69o7sFik6daHdLCKTBHdXvgCnmFxbQcz1DSw=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
        by relay.securemx.jp (mx-mr1511) id 17UBRsMq007060;
        Mon, 30 Aug 2021 20:27:54 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
        by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 9C15C31B1F;
        Mon, 30 Aug 2021 20:27:54 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
        by Switcher-Post_Send (Postfix) with ESMTP id 5D8011907AD216;
        Mon, 30 Aug 2021 20:25:21 +0900 (JST)
Received: from localhost [127.0.0.1] 
         by CNN1ESTR03.kioxia.com with ESMTP id 0002WAAAAAA023A0;
         Mon, 30 Aug 2021 20:25:21 +0900
Received: from CNN1EXMB02.r1.kioxia.com (CNN1EXMB02.r1.kioxia.com [10.232.20.151])
        by Switcher-Pre_Send (Postfix) with ESMTP id 52836A0347643;
        Mon, 30 Aug 2021 20:25:21 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB02.r1.kioxia.com (10.232.20.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 20:27:54 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Mon,
 30 Aug 2021 20:27:54 +0900
From:   sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To:     Hannes Reinecke <hare@suse.de>, "hch@lst.de" <hch@lst.de>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH v2] nvme: update keep alive interval when kato is
 modified
Thread-Index: AdeYqq0GYCdtylBoR8GOhZA2v9EjoAAmJkqAAA6WO4ABBL/jkA==
Date:   Mon, 30 Aug 2021 11:27:53 +0000
Message-ID: <4ffa643335a9467ba586450f8820c54a@kioxia.com>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
 <20210825085345.GA31419@lst.de>
 <2fc5b98a-b397-3be1-1957-986e8b6aa732@suse.de>
In-Reply-To: <2fc5b98a-b397-3be1-1957-986e8b6aa732@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.33.106]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB02.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB02.r1.kioxia.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA4LzI1LzIxIDEwOjUzIEFNLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiA+IEFueSByZWFzb24g
d2UgY2FuJ3QganVzdCBjYWxsIHRoaXMgZnJvbSBudm1lX3Bhc3N0aHJ1X2VuZCBpbnN0ZWFkDQo+
ID4gb2YgaW52ZW50aW5nIGEgbmV3IEFQST8gIFJpZ2h0IG5vdyB0aGUgbnZtZXQgcGFzc3Rocm91
Z2ggY29kZSBuZXZlcg0KPiA+IHVzZXMgdGhlIHVuZGVybHlpbmcga2VlcCBhbGl2ZSBjb2RlLCBz
byBpdCBkb2Vzbid0IG1ha2UgYSBkaWZmZXJlbmNlLA0KPiA+IGJ1dCBJIGV4cGVjdCB3ZSdsbCBu
ZWVkIG1vcmUgaGFuZGxpbmcgZm9yIHBhc3N0aHJvdWdoIGNvbW1hbmRzIGxpa2UNCj4gPiB0aGlz
LCBhbmQgd2UgbWlnaHQgYWxzbyBncm93IG1vcmUgdXNlcnMgKGUuZy4gdGhlIGlvX3VyaW5nIGJh
c2VkDQo+ID4gcGFzc3Rocm91Z2gpLg0KPiA+DQo+IFllYWgsIHdlJ2xsIG5lZWQgdGhhdCBhbnl3
YXkgaWYgYW5kIHdoZW4gaG9zdGlkIGJlY29tZXMgc2V0dGFibGUuDQoNClRoYW5rcyBmb3IgeW91
ciBjb21tZW50cy4gVG8gY2FsbCBudm1lX3VwZGF0ZV9rZWVwX2FsaXZlIGZyb20NCm52bWVfcGFz
c3RocnVfZW5kLCBJIHRoaW5rIG52bWVfcGFzc3RocnVfZW5kIG5lZWRzIGFuIGFyZ3VtZW50IG9m
DQphIHBvaW50ZXIgdG8gbnZtZV9jb21tYW5kLiBJIHdpbGwgdHJ5IHRvIGNhbGwgaXQgZnJvbSBu
dm1lX3Bhc3N0aHJ1X2VuZC4NClBsZWFzZSBjb3JyZWN0IG1lLCBpZiBJIGFtIG1pc3VuZGVyc3Rh
bmRpbmcgd2hhdCB5b3UgbWVhbi4NCg0KVGhhbmtzLg0KDQo=

