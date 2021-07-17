Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2BC3CC0AE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 04:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhGQCF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 22:05:28 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:59564 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhGQCFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 22:05:25 -0400
DKIM-Signature: a=rsa-sha256;
        b=LmYyR+MHs+Kua4a39UfF+mah/HOkBJ/jMvXLcV5LIsKi7ErWzh0HMcwTy0AxZMiO/Z0Sg4JxRHypLJqB3Jvss52ScqPaQGejexDoWFk/jxbI4a2hLzoRk792PXTeUhHj9uuVnMstlplccY2zObcpEq8E5HKCU6TYYBUDHfQwJ+g=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=hFKnWCXkUxwvQIoj6/v8eaB5OM/6m8gf+LOyUsbY5vk=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176216.qiye.163.com (Hmail) with ESMTP id B7B2AC20091;
        Sat, 17 Jul 2021 10:02:28 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AI6A1gAJD1YuOGo4nTT21Ko0.1.1626487348736.Hmail.link@vivo.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel@vivo.com,
        Wang Qing <wangqing@vivo.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gbW0vcGFnZV9hbGxvYzogZW5hYmxlIGFsbG9jIGJ1bGsgd2hlbiBwYWdlIG93bmVyIGlzIG9u?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
MIME-Version: 1.0
Received: from link@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Sat, 17 Jul 2021 10:02:28 +0800 (GMT+08:00)
From:   =?UTF-8?B?5p2o5qyi?= <link@vivo.com>
Date:   Sat, 17 Jul 2021 10:02:28 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJKSBhWTEJMTh9MGR5DHU
        hMVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzoyTTpKHDoxP0oiDjQ8FE8VLy9J
        SjAUS1VKVUpNSU1PQ0xIT0JLSkNVMxYaEhdVFxIVEDsNEg0UVRgUFkVZV1kSC1lBWUhNVUpOSVVK
        T05VSkNJWVdZCAFZQU9ITEM3Bg++
X-HM-Tid: 0a7ab2335e19d976kuwsb7b2ac20091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cgo+PiBMYXN0IGFsbG9jIGJ1bGsgdmVyc2lvbiBoYXZlIGEgYnVnLCB3aGVuIHBhZ2Vfb3duZXIg
aXMgb24sIHN5c3RlbSBtYXliZQo+PiBjcmFzaGVkIGR1ZSB0byBhbGxvYyBidWxrIGludm9rZSBw
cmVwX25ld19wYWdlIGluIGlycSBkaXNhYmxlZCBjb250ZXh0LAo+PiBhbmQgc2V0X3BhZ2Vfb3du
ZXIgdXNlIHBhZ2VfZmxhZyhtYXkgR0ZQX0tFUk5FTCkgdG8gZ2V0IG1lbW9yeSBhbmQgc2F2ZQo+
PiBzdGFja3RyYWNlLgo+PiBXZSBmaXggaXQgYnkgYSBjaXJjdW12ZW50aW9uIHBsYW4gLS0gYmFu
ZG9uIGFsbG9jIGJ1bGsgZmVhdHVyZSB3aGVuCj4+IHBhZ2Vfb3duZXIgaXMgc2V0Lgo+PiBJIHRo
aW5rIGJvdGggYWxsb2NfYnVsayBhbmQgcGFnZV9vd25lciBpcyB2YWx1YWJsZSwgc28sIGl0J3Mg
d29ydGggdG8KPj4gZmluZCBhIHdheSBlbmFibGUgYWxsb2MgYnVsayB3aGVuIHBhZ2Ugb3duZXIg
aXMgb24uCj4KPldoeSBkbyB5b3UgdGhpbmsgaXQncyB2YWx1YWJsZT8gIFRoZSBwb2ludCBvZiBh
bGxvY19idWxrIGlzIHNwZWVkLgo+RG9pbmcgdGhlIGFsbG9jYXRpb24gb2YgYSBzdGFjayBmb3Ig
ZWFjaCBwYWdlIHJlbW92ZXMgdGhlIHNwZWVkLgoKPldoZXJlJ3MgdGhlIHZhbHVlPwpXaXRob3V0
IGFsbG9jIGJ1bGssIHdlIGFsc28gbmVlZCB0byBhbGxvYyBwYWdlcyBmcm9tIGxvb3AgaW52b2tl
CmFsbG9jX3BhZ2UsIGFuZCB0aGlzIGFsc28gd2lsbCBpbnZva2Ugc2V0X3BhZ2Vfb3duZXIgdG8g
c2F2ZSBzdGFjay4KU28sIGZpbmQgYSB3YXkgdG8gbGV0IGFsbG9jX2J1bGsgd29yaywgSSB0aGlu
ayBpcyB2YWx1YWJsZS4KSWYgeW91IGRvbid0IHRoaW5rIHNvLCBJIHNvcnJ5IGZvciBteSBkaXN0
dXJiLgoKPklmIHlvdSdyZSByZWFsbHkgaW50ZXJlc3RlZCBpbiBtYWtpbmcgYm90aCB0aGVzZSB0
aGluZ3Mgd29yayB0b2dldGhlciwKPnRoZW4gSSBvYnNlcnZlZCB0aGF0IGFsbCBvZiB0aGVzZSBw
YWdlcyBhcmUgZ29pbmcgdG8gaGF2ZSB0aGUgc2FtZQo+YWxsb2NhdGlvbiBzdGFjay4gIEFsbG9j
YXRpbmcgdGhhdCBzdGFjayBvbmNlIHBlciBjYWxsIHRvIGFsbG9jX2J1bGssCj5yZWZlcmVuY2Ug
Y291bnRpbmcgaXQgYW5kIGhhdmluZyBlYWNoIHBhZ2UgdXNlIHRoZSBzaGFyZWQgc3RhY2sgd291
bGQgCgo+YmUgYSBnb29kIHdheSBvZiBjb21iaW5pbmcgdGhlIHR3byAoaXQnZCBldmVuIHNhdmUg
bWVtb3J5ISkKWWVzLCB5b3VyIGlkZWEgaXMgdmVyeSBnb29kLgoKQnV0LCBob3cgd2UgbGV0IHNl
dF9wYWdlX293bmVyIGtuZXcgdGhhdCByZWNlbnQgcGFnZXMgYXJlIGFsbCBpbiBzYW1lIHN0YWNr
PwpNYXliZSBzYXZlIHN0YWNrIGJ5IGNhbGxlciwgYW5kIHBhc3NlZCBoYW5kbGUgaW4gcHJlcF9u
ZXdfcGFnZT8KQnV0LCBJIHRoaW5rIGNhbGxlciBzaG91bGRuJ3QgY2FyZSBvZiBwYWdlIHRyYWNl
LCBpdCdzIHBhZ2Ugb3duZXIgZmVhdHVyZSdzIGR1dGllcy4KTGV0IHNhbWUgc3RhY2sncyBwYWdl
IGhhdmUgc2FtZSBtYWdpYyBudW1iZXIgbWF5YmUgYSBnb29kIHdheSwgZW1tCkJ1dCwgZXZlbiB0
aGV5IGhhdmUgc2FtZSBzdGFjaywgc2V0X3BhZ2Vfb3duZXIgc2hvdWxkIGtub3cgaG93IHRvIGdl
dCBtZW1vcnkKcmlnaHRseSAoVW5sZXNzIHlvdSBwYXNzIGl0IHRvLCBzbyBiYWNrIHRvIHRoZSBk
dXRpZXMpLgpJbiB0aGUgcGFzdCwgd2UganVzdCBwYXNzIHBhZ2UgZ2ZwIHRvIGl0LCBpbiBhbGxv
YyBidWxrLCBub3QgcmlnaHQuCgo+VGhpcyBwYXRjaCwgSSB0aGluaywgZG9lcyBub3QgbWFrZSBz
ZW5zZS4KV2VsbCwgdGhpcyBpcyBhIHNpbXBsZSB3YXkgdGhhdCBJIGNhbiBmaW5kLCBhbmQgbm90
IGFmZmVjdCBwZXJmZXJtYW5jZSBib3RoIGluIG5vcm1hbCBhbmQKUEFHRV9PV05FUiBpcyBvbiwg
YnV0IGNhbiB3b3JrIGFsbG9jIGJ1bGsgYW5kIFBBR0VfT1dORVIuIApJZiB5b3UgZG9uJ3QgdGhp
bmsgc28sICBJJ20gc29ycnkgZm9yIHRoYXQKDQoNCg==
