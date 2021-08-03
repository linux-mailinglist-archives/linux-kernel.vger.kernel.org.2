Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CEA3DF620
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbhHCULd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbhHCULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:11:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A7EC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 13:11:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628021478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=Mz/DG2RX6J+O82WQF8U7GE7fIRtWYMzFycP1aZRGY6E=;
        b=4QQE9oLnt//jjL1P8ue5SjYOJDGTqdrVPUmxGMA3eXhH9fDZZprAxOwWexj50oU94huoEf
        OV3I7jo+lcJKPsR7E0zN8qEDGtuJdYkxmX2EuQ3tV+vZfhca3+RImb03W0aIXXVYHBj0pW
        jvtB0Wac5XsJullXOuqDnQyjp3dP5aTKfMz1YKl0RCGqC2VsAvAz5Q81tz8cLnoUuRgTRi
        HsUu3Y5dhtt/sjBgOeCKbdcjafrYRVabYv3Ekm9bbENZcFEfIJTBA4lepcHcfKel9GeaLM
        PZaGkT6J6USBmbMzxUUcDhEkRNz5Tq3qe+ZdkC/QI5M6lNy2cEDt/5G5JbfWvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628021478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=Mz/DG2RX6J+O82WQF8U7GE7fIRtWYMzFycP1aZRGY6E=;
        b=7fav9Q+tqqPadoUU9THzxJ+NgFjQY/+XgR/LJ/9S55t3I0459z6R4GnokAiZLsWrjUG2BP
        eG7JbS2+tO6F7RBQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 03/63] sched: Prepare for RT sleeping spin/rwlocks
In-Reply-To: <YQlYB7wE8HaDjyd7@hirez.programming.kicks-ass.net>
Date:   Tue, 03 Aug 2021 22:11:17 +0200
Message-ID: <87v94m2sre.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMDMgMjAyMSBhdCAxNjo1MSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9u
IFR1ZSwgQXVnIDAzLCAyMDIxIGF0IDA0OjA0OjA3UE0gKzAyMDAsIFRob21hcyBHbGVpeG5lciB3
cm90ZToNCj4+IE9uIFR1ZSwgQXVnIDAzIDIwMjEgYXQgMTE6NDgsIFBldGVyIFppamxzdHJhIHdy
b3RlOg0KPj4gDQo+PiA+IE9uIFN1biwgQXVnIDAxLCAyMDIxIGF0IDA1OjMwOjA2UE0gKzAyMDAs
IE1pa2UgR2FsYnJhaXRoIHdyb3RlOg0KPj4gPj4gT24gRnJpLCAyMDIxLTA3LTMwIGF0IDE1OjUw
ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+PiA+PiA+IA0KPj4gPj4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3NjaGVkLmgNCj4+ID4+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zY2hlZC5o
DQo+PiA+PiA+IEBAIC0xNTUsNiArMTU1LDI3IEBAIHN0cnVjdCB0YXNrX2dyb3VwOw0KPj4gPj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFdSSVRFX09OQ0UoY3VycmVudC0+X19z
dGF0ZSwgKHN0YXRlX3ZhbHVlKSk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPj4gPj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhd19zcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZjdXJyZW50LT5waV9sb2NrLCBmbGFncyk7wqDCoMKgXA0KPj4gPj4gPiDCoMKgwqDCoMKgwqDC
oMKgfSB3aGlsZSAoMCkNCj4+ID4+ID4gKw0KPj4gPj4gPiArDQo+PiA+PiA+ICsjZGVmaW5lIGN1
cnJlbnRfc2F2ZV9hbmRfc2V0X3J0bG9ja193YWl0X3N0YXRlKCnCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPj4gPj4gPiArwqDCoMKgwqDCoMKgwqBkbyB7
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgXA0KPj4gPj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmF3X3NwaW5f
bG9jaygmY3VycmVudC0+cGlfbG9jayk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoFwNCj4+ID4NCj4+ID4gVGhhdCB3YW50cyB0byBiZSBpcnFzYWZlIG1ldGhp
bmtzLCBJIHJlYWxpemUgdGhpcyBpcyBQUkVFTVBUX1JUIG9ubHkgYW5kDQo+PiA+IHRoZXJlIHRo
ZSBfaXJxZm9vIGNyYXAgaXMgYSBuby1vcCBzbyB0aGlzIGRvZXNuJ3QgcmVhbGx5IG1hdHRlciBv
bmUgd2F5DQo+PiA+IG9yIHRoZSBvdGhlciwgYnV0IHN0aWxsLCB0YWtpbmcgUEkgbG9jayB3aXRo
b3V0IElSUSBkaXNhYmxlIG1ha2VzIG15DQo+PiA+IGhlYWQgZ28gQlVHLUJVRy1CVUcgOi0pDQo+
PiANCj4+IEFjdHVhbGx5IHRoZSBydWxlIHRvIGxvY2sgUEkgbG9jayBpcnFzYXZlIHN0aWxsIHBl
cnNpc3RzIG9uIFJULCBidXQgdGhpcw0KPj4gaGFzIHRvIGJlIGNhbGxlZCB3aXRoIGludGVycnVw
dHMgZGlzYWJsZWQgKHJ0bXV0ZXg6OndhaXRfbG9jayBpcyBoZWxkKSwNCj4+IHNvIGFkZGluZyBh
IGxvY2tkZXBfYXNzZXJ0X2lycXNfZGlzYWJsZSgpIG1pZ2h0IGJlIGdvb2QgZW5vdWdoIHRvIHNw
YXJlDQo+PiB0aGUgZXh0cmEgc2F2ZS9yZXN0b3JlLiBIbW0/DQo+DQo+IFdvcmtzIGZvciBtZS4u
IGFuZCB5ZXMsIGR1aCwgcmF3Xy4NCg0KQW5kIHRoZSBsb2NrZGVwX2Fzc2VydF9pcnFzX2Rpc2Fi
bGVkKCkgaXMgcmVkdW5kYW50IGFzIHdlbGwgYmVjYXVzZSBpZg0KcmF3X3NwaW5fbG9jaygmY3Vy
cmVudC0+cGlfbG9jaykgaXMgaW52b2tlZCB3aXRoIGludGVycnVwdHMgZW5hYmxlZA0KbG9ja2Rl
cCB3aWxsIHllbGwgdG9vLiBCdXQsIHllcyBpdCBtYWtlcyBpdCBtb3JlIGV4cGxpY2l0Lg0KDQpU
aGFua3MsDQoNCiAgICAgICAgdGdseA0K
