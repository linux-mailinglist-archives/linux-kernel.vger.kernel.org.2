Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF4F33FD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhCRCOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:14:38 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:16207 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCRCOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:14:21 -0400
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id EF4CB282965;
        Thu, 18 Mar 2021 10:14:18 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AD2AAwDtDgN4Fh3ZMJ2Tcap5.3.1616033658963.Hmail.wangqing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gc2NoZWQ6IHN3YWl0OiB1c2Ugd2FrZV91cF9wcm9jZXNzKCkgaW5zdGVhZCBvZiB3YWtlX3VwX3N0YXRlKCk=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <YFHbdojO5TtztzEn@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 18 Mar 2021 10:14:18 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Thu, 18 Mar 2021 10:14:18 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTksZSUkYGhgZSEgZVkpNSk1LSEhNTkJLSUtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1JSk1MTk5MTk5CN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6P0k6Ogw*Dz8cNU89E0ghNjFJLxgaC05VSFVKTUpNS0hITU5CSUJMVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZSE1VSk5JVUpPTlVKQ0lZV1kIAVlBSEhNTDcG
X-HM-Tid: 0a78431cb8699395kuwsef4cb282965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IAo+PiAqIE1pa2UgR2FsYnJhaXRoIDxlZmF1bHRAZ214LmRlPiB3cm90ZToKPj4gCj4+ID4g
T24gVHVlLCAyMDIxLTAzLTE2IGF0IDE5OjIwICswODAwLCBXYW5nIFFpbmcgd3JvdGU6Cj4+ID4g
PiBXaHkgbm90IGp1c3QgdXNlIHdha2VfdXBfcHJvY2VzcygpLgo+PiA+IAo+PiA+IElNTyB0aGlz
IGlzIG5vdCBhbiBpbXByb3ZlbWVudC4gIFRoZXJlIGFyZSBvdGhlciBwbGFjZXMgd2hlcmUgZXhw
bGljaXQKPj4gPiBUQVNLX05PUk1BTCBpcyB1c2VkIGFzIHdlbGwsIGFuZCB0aGV5J3JlIGFsbCBw
ZXJmZWN0bHkgY2xlYXIgYXMgaXMuCj4+IAo+PiBBcmd1YWJseSB0aG9zZSBjb3VsZCBhbGwgYmUg
Y29udmVydGVkIHRvIHdha2VfdXBfcHJvY2VzcygpIGFzIHdlbGwuIAo+PiBJdCdzIGEgdmVyeSBz
bWFsbCBrZXJuZWwgY29kZSBzaXplIG9wdGltaXphdGlvbi4gVGhlcmUncyBhYm91dCAzIHN1Y2gg
Cj4+IHBsYWNlcywgY291bGQgYmUgY29udmVydGVkIGluIGEgc2luZ2xlIHBhdGNoLgo+Cj5JdCdz
IHN0aWxsIHBvaW50bGVzcyBjaHVybiBJTU8uCgpVc2luZyB3YWtlX3VwX3Byb2Nlc3MoKSBpcyBt
b3JlIHNpbXBsZXIgYW5kIGZyaWVuZGx5IGZvciBiZWdpbm5lcnMsIAphbmQgaXQgaXMgbW9yZSBj
b252ZW5pZW50IGZvciBhbmFseXNpcyBhbmQgc3RhdGlzdGljcy4KDQoNCg==
