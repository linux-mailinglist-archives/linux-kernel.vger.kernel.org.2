Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81674368B44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 04:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhDWCr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 22:47:26 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:10439 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhDWCrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 22:47:25 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Apr 2021 22:47:25 EDT
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id 78540282799;
        Fri, 23 Apr 2021 10:40:57 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIMAXgAnDv8vtlWxuL6mq4q3.3.1619145657480.Hmail.frank.li@vivo.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtmMmZzLWRldl0gW1BBVENIXSBmMmZzOiBzZXQgcHJlZnJlZSBhcyBmcmVlIHNlZ21lbnRzIGFmdGVyIGNsZWFyIHByZWZyZWUgc2VnbWVudHM=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.231
In-Reply-To: <247c6055-c004-72a6-5093-3949c2ed8495@huawei.com>
MIME-Version: 1.0
Received: from frank.li@vivo.com( [58.251.74.231) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 23 Apr 2021 10:40:57 +0800 (GMT+08:00)
From:   =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Date:   Fri, 23 Apr 2021 10:40:57 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQx4dTlZKGRpCH0lMHx4dHUJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1IS01DQktISUJPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MjY6Ixw6FT8NQw0PFywDDjdNFgpPCkhVSFVKTUpCSk9OTU5MQ0pPVTMWGhIXVR0JGhUQVRcS
        Ow0SDRRVGBQWRVlXWRILWUFZTkNVSU5KVUxPVUlISllXWQgBWUFPSklMNwY+
X-HM-Tid: 0a78fc9a0c979395kuws78540282799
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEkgQ2hhbywKIAo+PiBGb3Igbm93LCB3aGVuIGRvX2NoZWNrcG9pbnQgZmFpbHMsIHRoZSBwcmVm
cmVlIGJpdG1hcCBpcyBub3QgY2xlYXJlZCwKPj4gYnV0IHRoZXNlIHNlZ21lbnRzIGFyZSBhbHJl
YWR5IGluIHRoZSBmcmVlIHN0YXRlLiBJZiB0aGVzZSBzZWdtZW50cwo+PiBhcmUgdXNlZCwgdGhl
IHNlZ21lbnRzIGluIHVzZSB3aWxsIGJlIHJlc2V0IHRvIHRoZSBmcmVlIHN0YXRlIHdoZW4KPj4g
ZjJmc19jbGVhcl9wcmVmcmVlX3NlZ21lbnRzIGlzIGNhbGxlZCBuZXh0IHRpbWUuCj4+IAo+PiBT
byBtb3ZlIHNldF9wcmVmcmVlX2FzX2ZyZWVfc2VnbWVudHMgYWZ0ZXIgY2xlYXJfcHJlZnJlZV9z
ZWdtZW50cy4KPgo+VGhhdCdzIG5vdCBjb3JyZWN0Lgo+Cj4vKgo+ICAqIFNob3VsZCBjYWxsIGYy
ZnNfY2xlYXJfcHJlZnJlZV9zZWdtZW50cyBhZnRlciBjaGVja3BvaW50IGlzIGRvbmUuCj4gICov
Cj5zdGF0aWMgdm9pZCBzZXRfcHJlZnJlZV9hc19mcmVlX3NlZ21lbnRzKHN0cnVjdCBmMmZzX3Ni
X2luZm8gKnNiaSkKPgo+Q29tbWVudHMgYWJvdmUgc2V0X3ByZWZyZWVfYXNfZnJlZV9zZWdtZW50
cygpIHNob3VsZCBoYXZlIHRvbGQgeW91Cj50aGUgcnVsZSwgb3RoZXJ3aXNlIGlmIGNoZWNrcG9p
bnQgZmFpbGVkLCB2YWxpZCBkYXRhIGluIGxhc3QgdmFsaWQKPmNoZWNrcG9pbnQgY291bGQgYmUg
Y29ycnVwdGVkIGFmdGVyIHNlZ21lbnQgcmV1c2UuCgpGb3IgZG9fY2hlY2twb2ludCBzdWNlc3M6
CgpmMmZzX3dyaXRlX2NoZWNrcG9pbnQKLT5mMmZzX2ZsdXNoX3NpdF9lbnRyaWVzCiAgICAtPnNl
dF9wcmVmcmVlX2FzX2ZyZWVfc2VnbWVudHMKLT5kb19jaGVja3BvaW50Ci0+ZjJmc19jbGVhcl9w
cmVmcmVlX3NlZ21lbnRzCgoKQ2FsbGluZyBzZXRfcHJlZnJlZV9hc19mcmVlX3NlZ21lbnRzIHdo
ZW4gZG9fY2hlY2twb2ludCBmYWlscywKc2VlbXMgdG8gYmUgaW5jb3JyZWN0LiBJIHRoaW5rIGNs
ZWFyIGZyZWUgYml0bWFwIHNob3VsZCBiZSBhZnRlcgpjbGVhciBwcmVmcmVlIGJpdG1hcC4KCkZv
ciBkb19jaGVja3BvaW50IGZhaWw6CgpmMmZzX3dyaXRlX2NoZWNrcG9pbnQKLT5mMmZzX2ZsdXNo
X3NpdF9lbnRyaWVzCiAgICAtPnNldF9wcmVmcmVlX2FzX2ZyZWVfc2VnbWVudHMKLT5kb19jaGVj
a3BvaW50Ci0+ZjJmc19yZWxlYXNlX2Rpc2NhcmRfYWRkcnMKClRoZSBwcmVmcmVlIGJpdG1hcCBp
cyBub3QgY2xlYXJlZCwgYnV0IGZyZWUgYml0bWFwIGlzIGNsZWFyZWTvvIx3aGljaCBtZWFucwp3
ZSBjYW4gdXNlIHRoZXNlIHNlZ21lbnRzIHRoYXQgYXJlIG1hcmtlZCBhcyBmcmVlLiBXaGVuIHRo
ZSBmcmVlIHNlZ21lbnRzCmlzIHVzZWQsIHRoZSBuZXh0IGYyZnNfY2xlYXJfcHJlZnJlZV9zZWdt
ZW50cyB3aWxsIG1hcmsgcHJlZnJlZSBhcyBmcmVlIGFnYWluLApjYXVzaW5nIHNvbWUgcHJvYmxl
bS4KCldpdGggdGhpcyBwYXRjaCwgZm9yIGRvX2NoZWNrcG9pbnQgZmFpbDoKCmYyZnNfd3JpdGVf
Y2hlY2twb2ludAotPmYyZnNfZmx1c2hfc2l0X2VudHJpZXMKLT5kb19jaGVja3BvaW50Ci0+ZjJm
c19yZWxlYXNlX2Rpc2NhcmRfYWRkcnMKCkF0IHRoaXMgdGltZSwgd2UgZGlkIG5vdCBtYXJrIHBy
ZWZyZWUgYXMgZnJlZSBzZWdtZW50cywgc28gdGhlc2Ugc2VnbWVudHMgd2lsbCBub3QgYmUgdXNl
ZC4KClRoeA0KDQo=
