Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F944AE2C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhKIM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 07:58:53 -0500
Received: from mout.gmx.net ([212.227.15.19]:39031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234083AbhKIM6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636462527;
        bh=vyCmbt4olg/Zpq6nmfcn8BztE9kDIE9joQr4n1kV1SE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=RVZZcMj9ECvW3mG0lb6HYRiamdtSgv4hSAXdGy1wlZW/rWWacqfC0UCEI9UAvgSvv
         aWEmR/+ULgft1goKbk4dJtYMSMSvcI3GiAjkmtA+ehBqt20ZOU5Qua04Me9XUzKbvM
         LMfBA3+07qDG4je91LG76QUXJulXC41nZPunPbBM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.107]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1HZo-1mhfV63u5C-002sgu; Tue, 09
 Nov 2021 13:55:27 +0100
Message-ID: <dd879d19f63914caed02e97a196c14e4af07216f.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Nov 2021 13:55:24 +0100
In-Reply-To: <YYph/EuzlGr/3vG/@hirez.programming.kicks-ass.net>
References: <20211021145603.5313-1-mgorman@techsingularity.net>
         <20211021145603.5313-2-mgorman@techsingularity.net>
         <YYph/EuzlGr/3vG/@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Lnj/qj+gAFFmtwobWODTXsKEeKfoYSBl7vdtO6UMsiDqNLaBYxh
 t5o1OG8zESfjHKvY2X+ODB8138774otLhUAdC+MYk+ilba7y0pXsWz09k2bd6/oQA/lq11a
 hAQG8/0I1t3FLzW5r3QvqG4l9FqAAgmAJZQZujVD5CwKJk1teXE+U3/tKLLhh9mguDhXK7t
 7koY1bJbtgUI5KQ6crtww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9QWLAKxz01I=:FjPCZChfSwdxOUh3IGHIqr
 oPTYKwKUB1k1JrqCrdVRSyTXw2aumtz2l74ol4aMvyGVvrtKBkQ5ddxn07i2vBssv8kLDvYTK
 TrsVcdSTAzaYRcqjvFxXrPBBH1aEkEcY7jmhvNFM9AoyuX35o6VXlN99SzTdFB0xlKd5hptdM
 I7dZKDr1+Z0MQLVek8YLCCYIhaTjd6Uz/VfeROgmt4rgGi2jD+PcR6jb796MGnNn50+kdRw0h
 cPvNTc+z9DS8PHdzQjImRi8ODhf7vsN8A5nkxVscKsZQEXT2iVkDfIeu3vm8nMeEdbBgtaL4E
 BOvZsO5F6u9EGGNmiM78qgIShqKNU9netekqdYymjwrV7TyFw8DVh3VFDQimZIWQnxLi+vN6n
 Fj+XxwXLnztZH+VzsDgBpT8jMr1jeYADdUuX+9/2WAIvGxCCk0Rkv0jxcKDCVvv+Awt5xTBLw
 4EaRnFLspm4Fs0HpsIvl1KwV9RsNIxSL0hVeSFmbZ4+qTHpOTHLz0eLLFPtx2cmtt4jnCybYg
 dDNkvGZ78NLXCb3Om3ljDd0iX+ymOheAZnK7kHlA95pzHhI44uYag/2MtauJoXVV+1XfFDmCu
 a4AlNooUKRuc4riv2s9y+2hJCou4jQjl6NkTT2lAugIs1Npd6JIT2z02qCKRUUUJKBjRTtSEF
 MUamTYGwVYoWk2P4V8GEAT8oBfaz8AjeHxvhQ3sY5hnMLAsgYjvPne8APwQrQdWFnRg5b2rIW
 DUf+qAhh7B7lYnt5qrtxQ8HJ/mxqAPlNehXBoeCMBePCyf4GnMrhMy7icyzC64Bj1vtI7Zaye
 /eRfrxJkSBiMFb+fKfXP9RDMUcjXK6Y8aMenb4xcJh2CeptY+2GAKpS9C2ynYxbx4+prwdgsf
 qUseuWLomr6qfAXjlogfEaN6Boc8MoOwX2Nt3aFguy9CWWxOATh8J0Y3pSHMYUmOJhmNHOZD8
 Bq/sCTXalxllUzPCU3Gyi920A7EEJSt1e8UzT19IxZz/aPjZVUvcQQlpaDy3fZoxqjuTZGEdE
 P3OgpKR0y1RilkMqMQbD6Y9pbSI7K5TeKjN1BkQX67nRI0N+3FC6lMsXkZu99sJowaKbhq0Yk
 6AvvuJipzwju0A=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTA5IGF0IDEyOjU2ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gDQo+IA0KPiA+IEBAIC01ODk1LDcgKzU5MDMsNyBAQCBzdGF0aWMgaW50IHdha2Vfd2lkZShz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnApDQo+ID4gwqANCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG1h
c3RlciA8IHNsYXZlKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3dhcCht
YXN0ZXIsIHNsYXZlKTsNCj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoc2xhdmUgPCBmYWN0b3IgfHwg
bWFzdGVyIDwgc2xhdmUgKiBmYWN0b3IpDQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKChzbGF2ZSA8
IGZhY3RvciAmJiBtYXN0ZXIgPCAoZmFjdG9yPj4xKSpmYWN0b3IpIHx8IG1hc3RlciA8IHNsYXZl
ICogZmFjdG9yKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAxOw0KPiA+IMKgfQ0KPiANCj4gaGFzIGZhY3Rv
ci4NCj4gDQo+IE5vdzoNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqAhKHNsYXZlIDwgZmFjdG9yIHx8
IG1hc3RlciA8IHNsYXZlICogZmFjdG9yKQ0KPiANCj4gwqAgISh4IHx8IHkpID09ICF4ICYmICF5
LCBnaXZlczoNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqBzbGF2ZSA+PSBmYWN0b3IgJiYgbWFzdGVy
ID49IHNsYXZlICogZmFjdG9yDQo+IA0KPiDCoCBzdWJzdCBsaHIgaW4gcmhzOg0KPiANCj4gwqDC
oMKgwqDCoMKgwqDCoG1hc3RlciA+PSBmYWN0b3IgKiBmYWN0b3INCj4gDQo+IA0KPiB5b3VyIGV4
dHJhIHRlcm06DQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKgISgoc2xhdmUgPCBmYWN0b3IgJiYgbWFz
dGVyIDwgKGZhY3RvcipmYWN0b3IpLzIpIHx8IG1hc3RlciA8IHNsYXZlICogZmFjdG9yKQ0KPiAN
Cj4gY2hhbmdlcyB0aGF0IGhvdz8gQUZBSUNUIGl0J3MgYSBub3AuDQoNClRoYXQgY2FuIGhhcHBl
biB3aGVuIHR3aWRkbGluZy4gIFRoZSB0aG91Z2h0IHdhcyB0byBsZXQgdm9sdW1lIG9uIHRoZQ0K
cmlnaHQgb3ZlcnJpZGUgaW5kaXZpZHVhbCB0aHJlYWQgZGVjYXkgb24gdGhlIGxlZnQgdG8gYSBs
aW1pdGVkIGV4dGVudC4NCg0KCS1NaWtlDQo=
