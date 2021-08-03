Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C3C3DEFA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbhHCOEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:04:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56658 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbhHCOEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:04:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627999448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/4b/cHCvabtr4XL0ysZCrIHkwBcY0vDqaY2dzgJfNw=;
        b=sLaolHmoLJWy4IA4wwYuAMhmX0xlPPFKDJU9GQlZLM2n4A8ATW4AW8NzH8I2Fl77AgiILr
        gyqIoJQHWCOPkTbsuSBGa8XjbvlST+9TIYRjE2wnef6mPl46xXrLbWVio6zAwbiu6nCvS2
        LrQ1V090ixUFHTz9KrrmizrPlZd6yVvCw3uSfgW1scQ9ravW/pcI2v+RVVThsDveNMa/px
        +Yir8Zp6I5ApQt86SbjJweoZXG5/Yp8bqYqBvjSRD0wNhggw/YqNllrXqD19ejjVd184Sg
        5b3uhCUMXwmcLFW3dYJevOd+qMwrbezNfp/wwiHwz2XAPJKWJa9FM0SG+D7jyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627999448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/4b/cHCvabtr4XL0ysZCrIHkwBcY0vDqaY2dzgJfNw=;
        b=AWjXZwaFwlM6Fn2/SyfUaqjuM2P/2WgQsL5iCARbB5xaK3vpWcSPkvKWzhQ0qAcSP3EDYt
        Qjg4kpi/yd6v6QBg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <20210803094832.GA8057@worktop.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135205.317820700@linutronix.de>
 <e1fde6625113e7099ddc68f291984b8bedf5e387.camel@gmx.de>
 <20210803094832.GA8057@worktop.programming.kicks-ass.net>
Date:   Tue, 03 Aug 2021 16:04:07 +0200
Message-ID: <87y29ipqug.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMDMgMjAyMSBhdCAxMTo0OCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQoNCj4g
T24gU3VuLCBBdWcgMDEsIDIwMjEgYXQgMDU6MzA6MDZQTSArMDIwMCwgTWlrZSBHYWxicmFpdGgg
d3JvdGU6DQo+PiBPbiBGcmksIDIwMjEtMDctMzAgYXQgMTU6NTAgKzAyMDAsIFRob21hcyBHbGVp
eG5lciB3cm90ZToNCj4+ID4gDQo+PiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc2NoZWQuaA0KPj4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L3NjaGVkLmgNCj4+ID4gQEAgLTE1NSw2ICsxNTUsMjcgQEAg
c3RydWN0IHRhc2tfZ3JvdXA7DQo+PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
V1JJVEVfT05DRShjdXJyZW50LT5fX3N0YXRlLCAoc3RhdGVfdmFsdWUpKTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBcDQo+PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmF3X3Nw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmN1cnJlbnQtPnBpX2xvY2ssIGZsYWdzKTvCoMKgwqBcDQo+
PiA+IMKgwqDCoMKgwqDCoMKgwqB9IHdoaWxlICgwKQ0KPj4gPiArDQo+PiA+ICsNCj4+ID4gKyNk
ZWZpbmUgY3VycmVudF9zYXZlX2FuZF9zZXRfcnRsb2NrX3dhaXRfc3RhdGUoKcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcDQo+PiA+ICvCoMKgwqDCoMKgwqDC
oGRvIHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBcDQo+PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYXdfc3Bp
bl9sb2NrKCZjdXJyZW50LT5waV9sb2NrKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgXA0KPg0KPiBUaGF0IHdhbnRzIHRvIGJlIGlycXNhZmUgbWV0aGlua3Ms
IEkgcmVhbGl6ZSB0aGlzIGlzIFBSRUVNUFRfUlQgb25seSBhbmQNCj4gdGhlcmUgdGhlIF9pcnFm
b28gY3JhcCBpcyBhIG5vLW9wIHNvIHRoaXMgZG9lc24ndCByZWFsbHkgbWF0dGVyIG9uZSB3YXkN
Cj4gb3IgdGhlIG90aGVyLCBidXQgc3RpbGwsIHRha2luZyBQSSBsb2NrIHdpdGhvdXQgSVJRIGRp
c2FibGUgbWFrZXMgbXkNCj4gaGVhZCBnbyBCVUctQlVHLUJVRyA6LSkNCg0KQWN0dWFsbHkgdGhl
IHJ1bGUgdG8gbG9jayBQSSBsb2NrIGlycXNhdmUgc3RpbGwgcGVyc2lzdHMgb24gUlQsIGJ1dCB0
aGlzDQpoYXMgdG8gYmUgY2FsbGVkIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZCAocnRtdXRleDo6
d2FpdF9sb2NrIGlzIGhlbGQpLA0Kc28gYWRkaW5nIGEgbG9ja2RlcF9hc3NlcnRfaXJxc19kaXNh
YmxlKCkgbWlnaHQgYmUgZ29vZCBlbm91Z2ggdG8gc3BhcmUNCnRoZSBleHRyYSBzYXZlL3Jlc3Rv
cmUuIEhtbT8NCg0KVGhhbmtzLA0KDQogICAgICAgIHRnbHgNCg==
