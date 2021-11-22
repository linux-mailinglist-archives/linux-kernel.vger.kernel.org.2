Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C932E4589FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhKVHon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:44:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:60729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238822AbhKVHof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637566869;
        bh=dTmZMthKahVkE+y6Z29DpA/hG4mF7c7sYvRewTqOYIs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=efvzeR1j08+ZaiGUCEP0oI1H8s3eh0sajASbFxczLk+8bq7JrIsO3ELw1NsLyKkNi
         1jqnlJJOvZ9pZjR25VgQv0R8zG553pvprEDzYIyx4OFIqLKzOq4MTl6D/r8kdlWG2L
         8aQ0N7xmxLgua9KkOeJRt5/urZM1y7O6HU4nPU68=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.218]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1mn8PL4A07-004CX5; Mon, 22
 Nov 2021 08:41:09 +0100
Message-ID: <813ba08684c710a4c3d82d7f894c37838a8cec5a.camel@gmx.de>
Subject: Re: mm: LTP/memcg testcase regression induced by
 8cd7c588decf..66ce520bb7c2 series
From:   Mike Galbraith <efault@gmx.de>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        lkml <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Mel Gorman <mgorman@techsingularity.net>
Date:   Mon, 22 Nov 2021 08:41:08 +0100
In-Reply-To: <723736b7736da3810cab582dee4591fec063618b.camel@gmx.de>
References: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
         <6cc591c5-ed71-3213-3119-c778b3b2823d@leemhuis.info>
         <723736b7736da3810cab582dee4591fec063618b.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:OKSFMELpZPFlviVMukTZ5Pu6u1os7E4Tx89OkEPfe3zKRK0cS98
 3FsqSGqZYkkCpqUS9mxZ4QNEzFqLZ93RjrUquiCf08XDDfcmAV4p6/AWzRDCuEgYp7/O8Ft
 sZ2iW0gB0abxNomvwEKkbrLWvgLupgGxBK8DhiboFVXOjbcRjqBdTVKL3tSF5cRXLlNk0p3
 drKbs+ZjNZOr3wEj+83Yw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tDAjn74Zc38=:ON2ZZe9o7u6RhvU2lzGgpW
 gbWLEzgZVgfJJnjMnq1SB3icpR2AAIuoW8D4U1bCnsbq6Rn6gruh9Q2wCXR6PDAZPa1oa4zCC
 tAOZdOj/4FW7fE7oR2BwF0hl18q6HGoTIUfkQ24H4LryiEo3NpkiDcgnt417UMlGTC/80jqFS
 u/SCjJgOXyR7a0UMdl/7SV+J2v8dOKLuzEFRj2bXeq518crTO16GBwB3l2tpkStyWqGqZyScd
 c5IyviLBtjYhFh97Oe2biiLRflmA5HVJW0mqQBP/H5Ew/LFI0nm4WvcXyF3kt/XPSP8sCe9Pd
 Cmys88szD4DNovPsTTeLHkFYtDYlwjXRXJ0O4rGI2tIS4xXQ2y0r77eAlWHDWdn35aZGHLCGa
 JN1Ul0WG/juMsDfKuQIRQPRS9TJ5kPPfzPIGQbo0z0Y7t4+RJRkxUUdmZYff2tIqmk8OSCDv2
 G8Bph5if2AV+3oWWTlXNr7aoybrLseh1SQ26NGk57sMTZjF+GKO5veI4424UGEusFKZX8Vl/U
 YX0Wfh6lUHdO/cM80ukOKXgXOvRARKy8sn6odAxVxF+KXXE1KnAkKa0lVAtItqkf273Xz91Dj
 /d1psWWsUTwxnRKFL01dhBdxqqnzI81021Tu1q97FFaFvWUDYaCZVNWiwWfFi4YjLek0Iv5BG
 EZGkE6JkpWth7YsM/yupFB3VJQumnSTShGd5g9Ay7thTLLQlLZ8iq6MqHZye7o0/5X0IBACq/
 rftXMb2hb32ItATbYvRzXDdI/Yv+Y+RklERPMw2tDmXBmVwXmrGS5ZLuGFZl3Mt2XAVp/UX2J
 64ACFs4QDqG2eqvEMmtsqCuNV+xABMRuFXPW1jqmeSZ1ixEUxVU5QuLvNN/oRUeK3x94m2cJD
 zYBbDVI3QvlItd74tScq2jMbsJxOJnnXp+/VMNr8Yv0q8UdOnGMIgVsxdYuOREH3jHjP7cMHU
 0Wl1wd2pEKqwYLlFE02mXRE0L2T+tD16NhspL/Op8rsp396mzfddmQ8Jjml3TUIDwVuYNxxcs
 yyDeWjWBZrOY+S60kIhm0VJUFaRaFNswNb2GEkYF3i6T8KMWHMVu+gokWD8wco7LW6titKOnZ
 0Az12a0rU36RC8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTExLTIyIGF0IDA3OjQ2ICswMTAwLCBNaWtlIEdhbGJyYWl0aCB3cm90ZToN
Cj4gDQo+ICMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tDQo+ICMgQnVnOsKgwqDCoCBUaGUgYnVnIHdh
cywgd2hpbGUgZm9ya2luZyBtYXNzIHByb2Nlc3NlcywgdHJpZ2dlcg0KPiBtZW1jZ3JvdXAgT09N
LA0KPiAjwqDCoMKgwqDCoMKgwqDCoCB0aGVuIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBtYXkg
YmUgaGl0Lg0KPiAjIEtlcm5lbDogMi42LjI1LXJjWA0KPiAjIExpbmtzOsKgIGh0dHA6Ly9sa21s
Lm9yZy9sa21sLzIwMDgvNC8xNC8zOA0KPiAjIEZpeDrCoMKgwqAgY29tbWl0IGUxMTVmMmQ4OTI1
MzQ5MGZiMmRiZjMwNGI2MjdmOGQ5MDhkZjI2ZjENCj4gIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tLS0N
Cj4gdGVzdF8xKCkNCj4ge8KgwqDCoMKgwqDCoCANCj4gwqDCoMKgwqDCoMKgwqAgbWtkaXIgbWVt
Y2cvMC8NCj4gwqDCoMKgwqDCoMKgwqAgZWNobyAwID4gbWVtY2cvMC9tZW1vcnkubGltaXRfaW5f
Ynl0ZXMNCj4gwqDCoMKgwqDCoMKgwqAgDQo+IMKgwqDCoMKgwqDCoMKgIC4vbWVtY2dfdGVzdF8x
DQo+IMKgwqDCoMKgwqDCoMKgIA0KPiDCoMKgwqDCoMKgwqDCoCBybWRpciBtZW1jZy8wLw0KPiDC
oMKgwqDCoMKgwqDCoCANCj4gwqDCoMKgwqDCoMKgwqAgY2hlY2tfa2VybmVsX2J1ZyANCj4gwqDC
oMKgwqDCoMKgwqAgaWYgWyAkPyAtZXEgMSBdOyB0aGVuDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0c3RfcmVzbSBUUEFTUyAibm8ga2VybmVsIGJ1ZyB3YXMgZm91bmQiDQo+IMKg
wqDCoMKgwqDCoMKgIGZpDQo+IH0NCj4gDQo+IA0KPiBJJ20gZ29ubmEganVzdCBjb21tZW50IHRo
ZSBsaXR0bGUgYnVnZ2VyIG91dCBhcyBvYnNvbGV0ZSBhbmQgd2Fsaw0KPiBhd2F5Lg0KDQp0ZXN0
MigpIGFuZCB0ZXN0MygpIHRoZW4gcGFzcywgYnV0IHRlc3RfNCgpIGhhbmdzLCBhbmQgbG9va3Mg
bGlrZSBpdA0Kc2hvdWxkIG5vdCwgc28uLi4NCg0KCS1NaWtlDQo=
