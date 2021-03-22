Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F00343666
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCVBro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:47:44 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:52294 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCVBrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:47:39 -0400
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id C9FBD2829C4;
        Mon, 22 Mar 2021 09:47:32 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AKkAMQCvDsZ83ICT09iZeKpv.3.1616377652812.Hmail.wangqing@vivo.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrey Ignatov <rdna@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCBWMl0gd29ya3F1ZXVlOiB3YXRjaGRvZzogdXBkYXRlIHdxX3dhdGNoZG9nX3RvdWNoZWQgZm9yIHVuYm91bmQgbG9ja3VwIGNoZWNraW5n?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <YFY8/u0Bmf8TpJTS@slm.duckdns.org>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 22 Mar 2021 09:47:32 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Mon, 22 Mar 2021 09:47:32 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZH0NLGk0aT0gZSklPVkpNSk1ITExNTklDT09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1JSUhDTU1LTExNN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MBA6Nio4DT8IIUNIMjgvS0ISIR4wCw1VSFVKTUpNSExMTU5ITElNVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZSE1VSk5JVUpPTlVKQ0lZV1kIAVlBSE1ITjcG
X-HM-Tid: 0a78579da6619395kuwsc9fbd2829c4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiBGcmksIE1hciAxOSwgMjAyMSBhdCAwNDowMDozNlBNICswODAwLCBXYW5nIFFpbmcgd3Jv
dGU6Cj4+IFdoZW4gdG91Y2hfc29mdGxvY2t1cF93YXRjaGRvZygpIGlzIGNhbGxlZCwgb25seSB3
cV93YXRjaGRvZ190b3VjaGVkX2NwdSAKPj4gdXBkYXRlZCwgd2hpbGUgdGhlIHVuYm91bmQgd29y
a2VyX3Bvb2wgcnVubmluZyBvbiBpdHMgY29yZSB1c2VzIAo+PiB3cV93YXRjaGRvZ190b3VjaGVk
IHRvIGRldGVybWluZSB3aGV0aGVyIGxvY2tlZCB1cC4gVGhpcyBtYXkgYmUgbWlzY2hlY2tlZC4K
Pgo+Q2FuIHlvdSBwbGVhc2UgZWxhYm9yYXRlIGhlcmUsIHByZWZlcmFibHkgd2l0aCBhIGNvbmNy
ZXRlIHNjZW5hcmlvIHdoZXJlIHRoZQo+bmV3IGNvZGUgaXMgYmV0dGVyPwoKVGhlIHByZXZpb3Vz
IGNvZGUgaXMgcHJvYmxlbWF0aWMgZm9yIGp1ZGdpbmcgd2hldGhlciB0aGUgdW5ib3VuZCBwb29s
IGlzIGxvY2tlZCB1cDoKV2hlbiB0aGUgZXhwZWN0ZWQgc2luZ2xlIGNwdSBzdGFsbCBvY2N1cnMs
IG9ubHkgd3Ffd2F0Y2hkb2dfdG91Y2hlZF9jcHUgaXMgdXBkYXRlZCwgCkhvd2V2ZXIsIHRoZSB1
bmJvdW5kIHBvb2wgdXNlcyB3cV93YXRjaGRvZ190b3VjaGVkIHRvIGRldGVybWluZSB3aGV0aGVy
IGl0IGlzIApsb2NrZWQgdXAsIHNvIHdoZW4gdGhlIHVuYm91bmQgcG9vbCBpcyBydW5uaW5nIGlu
IGEgc2NlbmFyaW8gd2hlcmUgdGhlIGNwdSBzdGFsbCBpcyAKZXhwZWN0ZWQsIGEgbWlzanVkZ21l
bnQgd2lsbCBvY2N1ciwgYmVjYXVzZSB3cV93YXRjaGRvZ190b3VjaGVkIG9ubHkgYmUgdXBkYXRl
IAp3aGVuIGFsbCB0aGUgY3B1IHN0YWxsIGFzIGV4cGVjdC4KClNvIHdlIG5lZWQgdG8gdXBkYXRl
IHdxX3dhdGNoZG9nX3RvdWNoZWQgaW4gdG91Y2hfc29mdGxvY2t1cF93YXRjaGRvZygpLCBhbmQg
aXQgaXMgCm9ubHkgdXNlZCBmb3IgdW5ib3VuZCBwb29sLCAgaXQgd2lsbCBub3QgYWZmZWN0IHRo
ZSBib3VuZCBwb29sIGluIGFueSB3YXkuCgpUaGFua3MsCgpRaW5nCgo+Cj5UaGFua3MuCj4KPi0t
IAo+dGVqdW4KDQoNCg==
