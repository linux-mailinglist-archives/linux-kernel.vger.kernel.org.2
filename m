Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1A3DCC6E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhHAPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 11:31:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:59881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231940AbhHAPbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 11:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627831808;
        bh=oJkDS/c2NVfZVRD4Sv91PMvmSnhs4rL07Fj9CuVdM5Q=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=FS8ajDl3hWfvH2CKiGs37O7d0TM6PCjSQLapgS+rRkRGt0rElhrcSZmNFmbXlhXhI
         QAUIrQ94xgGsLxGvW5lLB7p6SIaNqVwCIOJXgImDxMVCxRzsex7RQ3PUg1WTMR4WP1
         i43+xL2F/aXvjbWYPZdF4UV2fqgL7nAdCsuiuLLo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.118]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1mOiva3Y3J-00GncA; Sun, 01
 Aug 2021 17:30:07 +0200
Message-ID: <e1fde6625113e7099ddc68f291984b8bedf5e387.camel@gmx.de>
Subject: Re: [patch 03/63] sched: Prepare for RT sleeping spin/rwlocks
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Date:   Sun, 01 Aug 2021 17:30:06 +0200
In-Reply-To: <20210730135205.317820700@linutronix.de>
References: <20210730135007.155909613@linutronix.de>
         <20210730135205.317820700@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:PDPJhVaqn59zDx8CwLeDiV9Sijv8NnBD149X9bfLn04GJhdsnCR
 wyTrmE/4nx2SMN6VJRZ6w0BmmoBJcTqAuCx1v3xm8RPg94O5jPKbFzPCEPlkU3iMcIDgajI
 W+XtTtlQvurRwxz0Q5pW3SihM6g0xHth3JmutpbUA8I8b7KF9llUJIz0CKQW8y5ezlUPsXt
 yFFvQBDGROYrDG5gomzJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f8rLOtoR/WI=:OZpRk8MpBrxMfsh3EJNgv+
 tnlN6nAvLhoYevz6+etdgkRRNZj5fpCBPZn1NY5BEjCb8ekTekisuKHet30w1Wo9WwcrmPXMh
 ee+TERN9mqG2d7W5vwIDcNAh1zz8zneezkxnD7BHN+UoWrci0I8ZeY9ik5nTXX5hB+8V4oZLB
 XvyWmtPvQbHbb/bj+VLHrnK11E8td/milCXPGBwTq/ILXfFNOPlmT4EXG09jUJh5P1gHys5xR
 Iq8VOPgW3Bywa6UJEV9542XDpY/2lBN4EHFsFVgWIDpBKARq5ICmC5IHmCHk1lrE8P03vF1Mg
 wYe8n1tqYTS/AoP2BIrkFmLzXxdiPFIKTKPVoVK4Rp31v3L3i11sEn3lAFOVTIwsTw897dMnp
 syK+roUulLIDxezNHNKzk85tL08CpGNRvnFLIE1lSjRQAl8aRsVjw/QO0pmgsvldwiFa/sgZ/
 Zoc5N1EH8Ukwk+C/0/IzLRkfUE2Okyl5MyjrCgE4FmrTD9g/0T2MJ35lxPiuJxD7NFKDly5gH
 qBVx+SlM3CxIxAdt8AOKFGww+KW4zV/l/moR1l7yZk7W2Qikb9gTHW361rZ4MxOzMmpVXCFL4
 PUzjEZyXfr7u85MS6apXtpqRMnOFlr8EklwddNfNxCT2IHTJwP+PwSB92d0IfB/uNpo9doFvn
 CmeQjTlS7R0ftudVWKi8Orgf/CjTphTB6jGZDxydvy0o933QXyfj09bbL/H9qPNXIa/3rPMDh
 WSICwzw/dOI277z/R7HWG7JI3/h+U+P1yy2kFQXDNukMf5SKNvX94QSIJevic9ZecdY/hcAt5
 KiLsTtaL8wRCmIDD7WvYSyQC+PjnTAtbr+5YvWjxhJs4NJz95aZisJ1V/IZjTNWPdGe2UrmOn
 QXxERHX5B9vObKvxeXUmVZ2ps4iqJRLuCtsV9cOSVR2LjFNZc90uaRe0jY2ciJHmZX4uYyUMy
 kKEODLmKJVmCQI3LmReTinQb1cRVUITME5yjd+6qHq9DT35tHh00Q3fScedPcMR1J4sFJp5BU
 CVZFMbYMhMCtHU0twuX2oqjfWSE5a7LijFwRaxhc/c/CYEsFdpWX3LN0KiFDsrcVeQAv+rJxL
 8lQNO6WDt+GWDMy0r1mmDpqhkXfDL/f5gP1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA3LTMwIGF0IDE1OjUwICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkLmgNCj4gKysrIGIvaW5jbHVkZS9saW51
eC9zY2hlZC5oDQo+IEBAIC0xNTUsNiArMTU1LDI3IEBAIHN0cnVjdCB0YXNrX2dyb3VwOw0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFdSSVRFX09OQ0UoY3VycmVudC0+X19zdGF0
ZSwgKHN0YXRlX3ZhbHVlKSk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZjdXJyZW50
LT5waV9sb2NrLCBmbGFncyk7wqDCoMKgXA0KPiDCoMKgwqDCoMKgwqDCoMKgfSB3aGlsZSAoMCkN
Cj4gKw0KPiArDQo+ICsjZGVmaW5lIGN1cnJlbnRfc2F2ZV9hbmRfc2V0X3J0bG9ja193YWl0X3N0
YXRlKCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPiAr
wqDCoMKgwqDCoMKgwqBkbyB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmF3X3NwaW5fbG9jaygmY3VycmVudC0+cGlfbG9jayk7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGN1cnJlbnQtPnNhdmVkX3N0YXRlID0gY3VycmVudC0+X19zdGF0ZTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXl5zaG91bGQgdGhhdCBiZSB1c2luZyBSRUFEX09OQ0UoKT8NCg0KPiArI2RlZmluZSBj
dXJyZW50X3NhdmVfYW5kX3NldF9ydGxvY2tfd2FpdF9zdGF0ZSgpwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwNCj4gK8KgwqDCoMKgwqDCoMKgZG8ge8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oFwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhd19zcGluX2xvY2soJmN1cnJl
bnQtPnBpX2xvY2spO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBcDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjdXJyZW50LT5zYXZlZF9zdGF0
ZSA9IGN1cnJlbnQtPl9fc3RhdGU7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eZGl0dG8/DQoNCg0K
