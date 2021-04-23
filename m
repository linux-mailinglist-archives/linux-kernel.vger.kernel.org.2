Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6C3689EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbhDWAjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:39:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49537 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236896AbhDWAjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:39:03 -0400
X-UUID: 614ca0896ed040a596488d13a30df04c-20210423
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=FEiz4MQ68oyPYAAvIdQyHnWL6vlPbuhFdtR/TLrAy5I=;
        b=BWxaLPumfojDd06VKoTv6lAoNa7qVMdwDkyLcpzOO0S4+53o8brbfXuzL0Tp4JuJJiEYL1m2ELQCUaoP31qxEzXBqROITQ8iLJmVFU2geE0t/hhlbnf9zSmh+zTM3jEnurvEEUF6lep/YmBy3ev8ViEdqRjaHVytl+vLR/5Piqk=;
X-UUID: 614ca0896ed040a596488d13a30df04c-20210423
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1250232820; Fri, 23 Apr 2021 08:38:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Apr 2021 08:38:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Apr 2021 08:38:22 +0800
Message-ID: <0fd8e103cc2886724979f7d93066b86b773032eb.camel@mediatek.com>
Subject: Re: [PATCH 1/1] sched: remove the redundant 'success' in the sched
 tracepoint
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <stanley.chu@mediatek.com>, <loda.chou@mediatek.com>
Date:   Fri, 23 Apr 2021 08:38:22 +0800
In-Reply-To: <20210422114629.2b1ea3ad@gandalf.local.home>
References: <20210422122226.9415-1-ed.tsai@mediatek.com>
         <20210422114629.2b1ea3ad@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTIyIGF0IDExOjQ2IC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gVGh1LCAyMiBBcHIgMjAyMSAyMDoyMjoyNiArMDgwMA0KPiBFZCBUc2FpIDxlZC50c2Fp
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiA+ICdzdWNjZXNzJyBpcyBsZWZ0IGhlcmUgZm9y
IGEgbG9uZyB0aW1lIGFuZCBhbHNvIGl0IGlzIG1lYW5pbmdsZXNzDQo+ID4gZm9yIHRoZSB1cHBl
ciB1c2VyLiBKdXN0IHJlbW92ZSBpdC4NCj4gDQo+IEhhdmUgeW91IHRlc3RlZCBhbGwgdXNlcnNw
YWNlIGNvZGUgdGhhdCBtaWdodCB1c2UgdGhpcz8NCj4gDQo+IFRoaXMgaXMgdGhlICJwb3N0ZXIg
Ym95IiBleGFtcGxlIG9mIHdoeSBQZXRlciBaaWpsc3RyYSBoYXRlcyB0cmFjZQ0KPiBldmVudHMg
Oy0pDQo+IA0KPiBJIGtub3cgSSd2ZSB1cGRhdGVkIHRyYWNlLWNtZCB0byBjaGVjayB0byBzZWUg
aWYgdGhpcyBmaWVsZCBleGl0cw0KPiBiZWZvcmUNCj4gZGVwZW5kaW5nIG9uIGl0LCBidXQgdGhl
cmUgbWF5IGJlIHNvbWUgb3RoZXIgdG9vbHMgdGhhdCBtYXkgbm90Lg0KPiBQZXJoYXBzDQo+IG5v
dGhpbmcgd2lsbCBicmVhay4NCj4gDQo+IEknbSBhbGwgZm9yIHRoaXMgY2hhbmdlLCBidXQgYmUg
d2FyZSwgaXQgbWlnaHQgYmUgcmV2ZXJ0ZWQgaWYgdGhlcmUncw0KPiBzb21lDQo+IHRvb2wgb3V0
IHRoYXQgdGhhdCBleHBlY3RzIGl0IHRvIGV4aXN0LiBUaGlzIGlzIHdoeSBpdCBoYXNuJ3QgYmVl
bg0KPiByZW1vdmVkLg0KPiANCj4gLS0gU3RldmUNCg0KSXQgaXMgbGVmdCBoZXJlIG92ZXIgNSB5
ZWFycy4gT2xkIHVzZXJzcGFjZSBjb2RlIG5lZWQgdGhpcyBlbnRyeSBhbmQNCmFsc28gc29tZW9u
ZSBtYXkgdXNlIGl0IGZvciBhIG5ldyB0b29sLiBJIGhhdGUgdGhpcyBidXQgaXQgaXMgYSBwcm9i
bGVtDQpzaG91bGQgYmUgcmVzb2x2ZWQgZm9yIHRoZSBrZXJuZWwgb3IgaWdub3JlIGp1c3QgZmlu
ZS4NCg0KDQoNCg==

