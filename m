Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B99437569
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 12:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhJVK3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 06:29:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:59249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232483AbhJVK3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634898371;
        bh=5pQ0UIyCuEkYj1S7J/C65hOgpZIs3Is7agey6DO509A=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=G65ugNP1KhvZiWSB93tYpVnX8ZvffGBKkZfJrXJZikes60YEBUCWPn5OMxcYMVFd9
         8jLUE5g2x7mQiFoGgBa93gyDfQ9aDHs4R8d3R2b59fdmVveAkhdSDgtDOat9oWil4C
         BUMYERvyQhCTlsreSwUzFcIwQcIudRZybUBvqzXQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.113]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1mWlHl08vy-00BbDn; Fri, 22
 Oct 2021 12:26:11 +0200
Message-ID: <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Oct 2021 12:26:08 +0200
In-Reply-To: <20211021145603.5313-2-mgorman@techsingularity.net>
References: <20211021145603.5313-1-mgorman@techsingularity.net>
         <20211021145603.5313-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:zjsCGx40dgYNkdcSzgpgcx9bZmnfMhAJgwdMhSFDaJUpF5p6tr3
 KPS2aYKXR6rQJHd2DZsrrzjZZJfkKHSJHBjiaVtvvKsnHRTwspyvSt1LyjKHhQNq+rn7+8X
 nN02CJ80Fcm6Mk92y2MM4mCOlxwByxhQO85IdFxR3huwbBfN9t3qbRjE1PPmabfbutZ6Q15
 YP+aZXIZ+nBDkbd/A52pw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Vfz4lR8lUc=:7PqE1OUtL6jy7jEM16K1fZ
 HwJGqst2LfMDHMf1mJTs8nDaOnJUsDcNVzj1usggc2Nmf8CDu59FJ10kszG8fiT1SWG5pDDpa
 Lp3377a/C3qbvwQ1pkbR72/xv0tCnfeY/6ScMGe96jyt1BoJuP86EDVewhLxVu8SUaf12cdIR
 qew4VZC3WUHZWE4dh+mrkMBF2DX4dk+kBn+x314AqxKPC4zPRKUkoyeSia35S4A6BHdxE1rHA
 So1yJzIf7RIdmgbXWF9MM4gZ5v2mEGA9PovTejqmKVjQ5DfKintGkyO9zMGQ6ShKp8InTMkHz
 96GZyj7X8W7OARd1O+amY6GDuUq8DGc8eIE9sPzf0zo/8FniuE4X27wKr2wYYdYaU9/1/yJTU
 haNL90zB3121FovQZEj8w3KT6d/vibs0J33JPDiKu2lZfk82d+OTlouX/gtQlnG6YSiy4+KZT
 BNkQpWvD7XwAIvSuiQL9i0GMGRjG8TnEfxMmwMrVzsY+4Zt2arohHNqdPj2rPjX84yVIUYool
 AD/1qBCrSbkQPhLgI+wxc8I5ViUJgeADMfTcAMyVJiySj3L3zS74vPjqlBxNvY1ytwfTtfVdy
 RzXKNSNKL0o+yfq0gDcl9XMt1X/kB/qIlDNmUR0D7V4MkTtbvuIJHInLZzlLpkLskPaGdt+Ag
 d5NYngQ9geQrZMIqqb37VQlk9useVG8xKn+nOzu4kfkUGq0XLC3kd6SOLsDvfwY3uOvFrPlsk
 RFfjT99WNxqhN9WpL+K6tVYqBBC1kvrTvh8wxfBybtPgw2D5XH2bQ7qephkyo7f5P9HazRQsV
 ucNqvBkJrFGXYF1w9CvbE4muT0t3wA1fe0Ln/s44DAxtk0I7WmpMzwrUjlkCHTy+wW7IsbHVE
 K9l9EQ0EAW1/ytVnMM/l6qsnIkq3nQYHHwqLcz49wcmTyooS/SoTk8VNeywYS/K2woIIvSP6o
 v4CQ+g0srzWW1HJSJ3IrAJ6yMzCuzqso/dlmcHm44jmrH+yQK3KPPXV0h+BXYB8aSA0LLIGhY
 J410zXr7W4ED0jrG6SIrkGYR126veFUejIfoWdnxg78UAB0Jo1bhUaDrECLNGlF32xTeKLiT1
 pvHGVuMfUAJL84=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTEwLTIxIGF0IDE1OjU2ICswMTAwLCBNZWwgR29ybWFuIHdyb3RlOg0KPiAN
Cj4gRnJvbSBhZGRpdGlvbmFsIHRlc3RzIG9uIHZhcmlvdXMgc2VydmVycywgdGhlIGltcGFjdCBp
cyBtYWNoaW5lIGRlcGVuZGFudA0KPiBidXQgZ2VuZXJhbGx5IHRoaXMgcGF0Y2ggaW1wcm92ZXMg
dGhlIHNpdHVhdGlvbi4NCj4gDQo+IGhhY2tiZW5jaC1wcm9jZXNzLXBpcGVzDQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDUuMTUuMC1yYzPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgNS4xNS4wLXJjMw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YW5pbGxhwqAgc2NoZWQtd2FrZWVm
bGlwcy12MXIxDQo+IEFtZWFuwqDCoMKgwqAgMcKgwqDCoMKgwqDCoMKgIDAuMzY2NyAowqDCoCAw
LjAwJSnCoMKgwqDCoMKgIDAuMzg5MCAowqAgLTYuMDklKQ0KPiBBbWVhbsKgwqDCoMKgIDTCoMKg
wqDCoMKgwqDCoCAwLjUzNDMgKMKgwqAgMC4wMCUpwqDCoMKgwqDCoCAwLjUyMTcgKMKgwqAgMi4z
NyUpDQo+IEFtZWFuwqDCoMKgwqAgN8KgwqDCoMKgwqDCoMKgIDAuNTMwMCAowqDCoCAwLjAwJSnC
oMKgwqDCoMKgIDAuNTM4NyAowqAgLTEuNjQlKQ0KPiBBbWVhbsKgwqDCoMKgIDEywqDCoMKgwqDC
oMKgIDAuNTczNyAowqDCoCAwLjAwJSnCoMKgwqDCoMKgIDAuNTQ0MyAowqDCoCA1LjExJSkNCj4g
QW1lYW7CoMKgwqDCoCAyMcKgwqDCoMKgwqDCoCAwLjY3MjcgKMKgwqAgMC4wMCUpwqDCoMKgwqDC
oCAwLjY0ODcgKMKgwqAgMy41NyUpDQo+IEFtZWFuwqDCoMKgwqAgMzDCoMKgwqDCoMKgwqAgMC44
NTgzICjCoMKgIDAuMDAlKcKgwqDCoMKgwqAgMC44MDMzICjCoMKgIDYuNDElKQ0KPiBBbWVhbsKg
wqDCoMKgIDQ4wqDCoMKgwqDCoMKgIDEuMzk3NyAowqDCoCAwLjAwJSnCoMKgwqDCoMKgIDEuMjQw
MCAqwqAgMTEuMjglKg0KPiBBbWVhbsKgwqDCoMKgIDc5wqDCoMKgwqDCoMKgIDEuOTc5MCAowqDC
oCAwLjAwJSnCoMKgwqDCoMKgIDEuODIwMCAqwqDCoCA4LjAzJSoNCj4gQW1lYW7CoMKgwqDCoCAx
MTDCoMKgwqDCoMKgIDIuODAyMCAowqDCoCAwLjAwJSnCoMKgwqDCoMKgIDIuNTgyMCAqwqDCoCA3
Ljg1JSoNCj4gQW1lYW7CoMKgwqDCoCAxNDHCoMKgwqDCoMKgIDMuNjY4MyAowqDCoCAwLjAwJSnC
oMKgwqDCoMKgIDMuMjIwMyAqwqAgMTIuMjElKg0KPiBBbWVhbsKgwqDCoMKgIDE3MsKgwqDCoMKg
wqAgNC42Njg3ICjCoMKgIDAuMDAlKcKgwqDCoMKgwqAgMy44MjAwICrCoCAxOC4xOCUqDQo+IEFt
ZWFuwqDCoMKgwqAgMjAzwqDCoMKgwqDCoCA1LjIxODMgKMKgwqAgMC4wMCUpwqDCoMKgwqDCoCA0
LjMzNTcgKsKgIDE2LjkxJSoNCj4gQW1lYW7CoMKgwqDCoCAyMzTCoMKgwqDCoMKgIDYuMTA3NyAo
wqDCoCAwLjAwJSnCoMKgwqDCoMKgIDQuODA0NyAqwqAgMjEuMzMlKg0KPiBBbWVhbsKgwqDCoMKg
IDI2NcKgwqDCoMKgwqAgNy4xMzEzICjCoMKgIDAuMDAlKcKgwqDCoMKgwqAgNS4xMjQzICrCoCAy
OC4xNCUqDQo+IEFtZWFuwqDCoMKgwqAgMjk2wqDCoMKgwqDCoCA3Ljc1NTcgKMKgwqAgMC4wMCUp
wqDCoMKgwqDCoCA1LjU5NDAgKsKgIDI3Ljg3JSoNCj4gDQo+IFdoaWxlIGRpZmZlcmVudCBtYWNo
aW5lcyBzaG93ZWQgZGlmZmVyZW50IHJlc3VsdHMsIGluIGdlbmVyYWwNCj4gdGhlcmUgd2VyZSBt
dWNoIGxlc3MgQ1BVIG1pZ3JhdGlvbnMgb2YgdGFza3MNCg0KUGF0Y2hsZXQgaGVscGVkIGhhY2ti
ZW5jaD8gIFRoYXQncy4uIHVuZXhwZWN0ZWQgKGF0IGxlYXN0IGJ5IG1lKS4NCg0KPiB0YmVuY2g0
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
NS4xNS4wLXJjM8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA1LjE1LjAtcmMzDQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFuaWxs
YcKgIHNjaGVkLXdha2VlZmxpcHMtdjFyMQ0KPiBIbWVhbsKgwqDCoMKgIDHCoMKgwqDCoMKgwqDC
oMKgIDgyNC4wNSAowqDCoCAwLjAwJSnCoMKgwqDCoMKgIDgwMi41NiAqwqAgLTIuNjElKg0KPiBI
bWVhbsKgwqDCoMKgIDLCoMKgwqDCoMKgwqDCoCAxNTc4LjQ5ICjCoMKgIDAuMDAlKcKgwqDCoMKg
IDE2NDUuMTEgKsKgwqAgNC4yMiUqDQo+IEhtZWFuwqDCoMKgwqAgNMKgwqDCoMKgwqDCoMKgIDI5
NTkuMDggKMKgwqAgMC4wMCUpwqDCoMKgwqAgMjk4NC43NSAqwqDCoCAwLjg3JSoNCj4gSG1lYW7C
oMKgwqDCoCA4wqDCoMKgwqDCoMKgwqAgNTA4MC4wOSAowqDCoCAwLjAwJSnCoMKgwqDCoCA1MTcz
LjM1ICrCoMKgIDEuODQlKg0KPiBIbWVhbsKgwqDCoMKgIDE2wqDCoMKgwqDCoMKgIDgyNzYuMDIg
KMKgwqAgMC4wMCUpwqDCoMKgwqAgOTMyNy4xNyAqwqAgMTIuNzAlKg0KPiBIbWVhbsKgwqDCoMKg
IDMywqDCoMKgwqDCoCAxNTUwMS42MSAowqDCoCAwLjAwJSnCoMKgwqAgMTU5MjUuNTUgKsKgwqAg
Mi43MyUqDQo+IEhtZWFuwqDCoMKgwqAgNjTCoMKgwqDCoMKgIDI3MzEzLjY3ICjCoMKgIDAuMDAl
KcKgwqDCoCAyNDEwNy44MSAqIC0xMS43NCUqDQo+IEhtZWFuwqDCoMKgwqAgMTI4wqDCoMKgwqAg
MzI5MjguMTkgKMKgwqAgMC4wMCUpwqDCoMKgIDM2MjYxLjc1ICrCoCAxMC4xMiUqDQo+IEhtZWFu
wqDCoMKgwqAgMjU2wqDCoMKgwqAgMzU0MzQuNzMgKMKgwqAgMC4wMCUpwqDCoMKgIDM4NjcwLjYx
ICrCoMKgIDkuMTMlKg0KPiBIbWVhbsKgwqDCoMKgIDUxMsKgwqDCoMKgIDUwMDk4LjM0ICjCoMKg
IDAuMDAlKcKgwqDCoCA1MzI0My43NSAqwqDCoCA2LjI4JSoNCj4gSG1lYW7CoMKgwqDCoCAxMDI0
wqDCoMKgIDY5NTAzLjY5ICjCoMKgIDAuMDAlKcKgwqDCoCA2NzQyNS4yNiAqwqAgLTIuOTklKg0K
PiANCj4gQml0IG9mIGEgbWl4ZWQgYmFnIGJ1dCB3aW5zIG1vcmUgdGhhbiBpdCBsb3Nlcy4NCg0K
SG0uICBJZiBwYXRjaGxldCByZXBlYXRhYmx5IGltcGFjdHMgYnVkZHkgcGFpcnMgb25lIHdheSBv
ciB0aGUgb3RoZXIsDQppdCBzaG91bGQgcHJvYmFibHkgYmUgdG9zc2VkIG91dCB0aGUgbmVhcmVz
dCB3aW5kb3cuDQoNCg0KCS1NaWtlDQo=
