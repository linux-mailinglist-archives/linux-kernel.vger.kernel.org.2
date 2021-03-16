Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E837E33D085
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhCPJVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:21:55 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:58181 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbhCPJVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1615886481; x=1647422481;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=XhMW3GuJW+MGrzXD+6SSBw+AvuOqwckuMAHIr2cthNc=;
  b=fJT0TLgi+D4+/g08XKfsSKhVU2po2AQe9UMeb62EDSNeBjuRYsVk8thT
   00XqR5XxVbPzQy0qyYUpNtjVVp37Nw6VCWTSyFhdZyd858vtC+WrvMyqa
   UqLYZqp+gzCHtUhVwskOsiLb7PE7mF9YPF9gNSWZBrPB5cn82DSNoOHPM
   o=;
X-IronPort-AV: E=Sophos;i="5.81,251,1610409600"; 
   d="scan'208";a="120821260"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 16 Mar 2021 09:21:14 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 64773C0051;
        Tue, 16 Mar 2021 09:21:13 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.67) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Mar 2021 09:21:09 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] docs/kokr: make sections on bug reporting match practice
Date:   Tue, 16 Mar 2021 10:20:43 +0100
Message-ID: <20210316092043.18477-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20210308075701.23411-1-sj38.park@gmail.com>
X-Originating-IP: [10.43.160.67]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cGluZz8KCk9uIE1vbiwgIDggTWFyIDIwMjEgMDg6NTc6MDEgKzAxMDAgU2VvbmdKYWUgUGFyayA8
c2ozOC5wYXJrQGdtYWlsLmNvbT4gd3JvdGU6Cgo+IEZyb206IFNlb25nSmFlIFBhcmsgPHNqcGFy
a0BhbWF6b24uZGU+Cj4gCj4gVHJhbnNsYXRlIHRoaXMgY29tbWl0IHRvIEtvcmVhbjoKPiAKPiAg
ICAgY2Y2ZDZmYzI3OTM2ICgiZG9jczogcHJvY2Vzcy9ob3d0by5yc3Q6IG1ha2Ugc2VjdGlvbnMg
b24gYnVnIHJlcG9ydGluZyBtYXRjaCBwcmFjdGljZSIpCj4gCj4gU2lnbmVkLW9mZi1ieTogU2Vv
bmdKYWUgUGFyayA8c2pwYXJrQGFtYXpvbi5kZT4KPiAtLS0KPiAgRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMva29fS1IvaG93dG8ucnN0IHwgMTggKysrKysrKysrLS0tLS0tLS0tCj4gIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2tvX0tSL2hvd3RvLnJzdCBiL0RvY3VtZW50
YXRpb24vdHJhbnNsYXRpb25zL2tvX0tSL2hvd3RvLnJzdAo+IGluZGV4IDc4N2YxZTg1ZjhhMC4u
YTJiZGQ1NjRjOTA3IDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2tv
X0tSL2hvd3RvLnJzdAo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2tvX0tSL2hv
d3RvLnJzdAo+IEBAIC0zMzksMTQgKzMzOSw4IEBAIEFuZHJldyBNb3J0b27snZgg6riA7J20IOye
iOuLpC4KPiAg67KE6re4IOuztOqzoAo+ICAtLS0tLS0tLS0KPiAgCj4gLWh0dHBzOi8vYnVnemls
bGEua2VybmVsLm9yZyDripQg66as64iF7IqkIOy7pOuEkCDqsJzrsJzsnpDrk6TsnbQg7Luk64SQ
7J2YIOuyhOq3uOulvCDstpTsoIHtlZjripQKPiAt6rOz7J2064ukLiDsgqzsmqnsnpDrk6TsnYAg
67Cc6rKs7ZWcIOuqqOuToCDrsoTqt7jrk6TsnYQg67O06rOg7ZWY6riwIOychO2VmOyXrCDsnbQg
7Yi07J2EIOyCrOyaqe2VoCDqsoPsnYQKPiAt6raM7J6l7ZWc64ukLiAga2VybmVsIGJ1Z3ppbGxh
66W8IOyCrOyaqe2VmOuKlCDsnpDshLjtlZwg67Cp67KV7J2AIOuLpOydjOydhCDssLjsobDtlZjr
nbwuCj4gLQo+IC0gICAgaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3BhZ2UuY2dpP2lkPWZh
cS5odG1sCj4gLQo+ICDrqZTsnbgg7Luk64SQIOyGjOyKpCDrlJTroInthqDrpqzsl5Ag7J6I64qU
ICdEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3JlcG9ydGluZy1pc3N1ZXMucnN0Jwo+IC3tjIzs
nbzsnYAg7Luk64SQIOuyhOq3uOudvOqzoCDsg53qsIHrkJjripQg6rKD7J2EIOuztOqzoO2VmOuK
lCDrsKnrspXsl5Ag6rSA7ZWcIOyii+ydgCDthZztlIzrpr/snbTrqbAg66y47KCc66W8Cj4gK+2M
jOydvOydgCDsu6TrhJAg67KE6re465286rOgIOyDneqwgeuQmOuKlCDqsoPsnYQg7Ja065a76rKM
IOuztOqzoO2VmOuptCDrkJjripTsp4AsIOq3uOumrOqzoCDrrLjsoJzrpbwKPiAg7LaU7KCB7ZWY
6riwIOychO2VtOyEnCDsu6TrhJAg6rCc67Cc7J6Q65Ok7J20IO2VhOyalOuhnCDtlZjripQg7KCV
67O06rCAIOustOyXh+uTpOyduOyngOulvCDsg4HshLjtnogg7ISk66qF7ZWY6rOgCj4gIOyeiOuL
pC4KPiAgCj4gQEAgLTM2Miw4ICszNTYsMTQgQEAgaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3Jn
IOuKlCDrpqzriIXsiqQg7Luk64SQIOqwnOuwnOyekOuTpOydtCDsu6TrhJDsnZgg67KECj4gIOyg
kOyImOulvCDslrvsnYQg7IiYIOyeiOuKlCDqsIDsnqUg7KKL7J2AIOuwqeuyleykkeydmCDtlZjr
gpjsnbTri6QuIOyZnOuDkO2VmOuptCDrp47snYAg7IKs656M65Ok7J2ACj4gIOuLpOuluCDsgqzr
nozrk6TsnZgg67KE6re465Ok7J2EIOyImOygle2VmOq4sCDsnITtlZjsl6wg7Iuc6rCE7J2EIOuC
reu5hO2VmOyngCDslYrquLAg65WM66y47J2064ukLgo+ICAKPiAt7J2066+4IOuztOqzoOuQnCDr
soTqt7gg66as7Y+s7Yq465Ok7J2EIOqwgOyngOqzoCDsnpHsl4XtlZjquLAg7JyE7ZW07IScIGh0
dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZwo+IC3rpbwg7LC47KGw7ZWY6528Lgo+ICvsnbTrr7gg
67O06rOg65CcIOuyhOq3uCDrpqztj6ztirjrk6TsnYQg6rCA7KeA6rOgIOyekeyXhe2VmOq4sCDs
nITtlbTshJzripQg7Jes65+s67aE7J20IOq0gOyLrOyeiOuKlAo+ICvshJzruIzsi5zsiqTthZzs
nYQg7LC+7JWE6528LiDtlbTri7kg7ISc67iM7Iuc7Iqk7YWc7J2YIOuyhOq3uOuTpOydtCDslrTr
lJTroZwg66as7Y+s7Yq4IOuQmOuKlOyngAo+ICtNQUlOVEFJTkVSUyDtjIzsnbzsnYQg7LK07YGs
7ZWY6528OyDqt7jqsbQg64yA67aA67aEIOuplOydvOungSDrpqzsiqTtirjsnbTqs6AsIOqwgOuB
lOydgCDrsoTqt7gg7LaU7KCBCj4gK+yLnOyKpO2FnOydtOuLpC4g6re4IOyepeyGjOyXkCDsnojr
ipQg7LWc6re8IOuyhOq3uCDrpqztj6ztirgg6riw66Gd65Ok7J2EIOqygOyDie2VmOqzoCDsl6zr
n6zrtoTsnbQg67O06riw7JeQCj4gK+ygge2Vqe2VmOuLpCDsi7bsnYAg6rKD7J2EIOuPhOyZgOud
vC4g7Jes65+s67aE7J2AIOuyhOq3uCDrpqztj6ztirjrpbwg7JyE7ZW0Cj4gK2h0dHBzOi8vYnVn
emlsbGEua2VybmVsLm9yZyDrpbwg7LK07YGs7ZWY6rOg7J6QIO2VoCDsiJjrj4Qg7J6I64ukOyDs
hozsiJjsnZgg7Luk64SQCj4gK+yEnOu4jOyLnOyKpO2FnOuTpOunjOydtCDrsoTqt7gg7Iug6rOg
7JmAIOy2lOyggeydhCDsnITtlbQg7ZW064u5IOyLnOyKpO2FnOydhCDsi6TsoJzroZwg7IKs7Jqp
7ZWY6rOgIOyeiOyngOunjCwKPiAr7KCE7LK0IOy7pOuEkOydmCDrsoTqt7jrk6TsnbQg6re46rOz
7JeQIOygleumrOuQnOuLpC4KPiAgCj4gIAo+ICDrqZTsnbzrp4Eg66as7Iqk7Yq465OkCj4gLS0g
Cj4gMi4xNy4xCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVz
ZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hs
YWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0
ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3
IDg3OQoKCg==

