Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A1B3C9F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhGONFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 09:05:11 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:59924 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhGONFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:05:09 -0400
DKIM-Signature: a=rsa-sha256;
        b=ec0mgI6TSn26h05me9Y511YkmKix0j2choqab79NQpWwdYwHdae579KGyy32asZ940yJttkOXeOEXz7BfbEtwPcxeMoE9P9XXr20Lh+TJ4WWJml9KCFmGyQ2J3ksHDdspYW13Vnovsni8+q2YvjrBAPnyyw3ndPji21T4WCFsrk=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=afWtvPuUPasiz54i1xEfKaQE+Zpd2SbORekVq+VnRAM=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176216.qiye.163.com (Hmail) with ESMTP id C064DC201CD;
        Thu, 15 Jul 2021 21:02:14 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AHYA9ADdD1ErH8DLzqN8tqrS.3.1626354134777.Hmail.link@vivo.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel@vivo.com,
        syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com,
        Wang Qing <wangqing@vivo.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCB2Ml0gbW0vcGFnZV9hbGxvYzogZml4IGFsbG9jX3BhZ2VzX2J1bGsvc2V0X3BhZ2Vfb3duZXIgcGFuaWMgb24gaXJxIGRpc2FibGVk?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210715115731.GS3809@techsingularity.net>
MIME-Version: 1.0
Received: from link@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 15 Jul 2021 21:02:14 +0800 (GMT+08:00)
From:   =?UTF-8?B?5p2o5qyi?= <link@vivo.com>
Date:   Thu, 15 Jul 2021 21:02:14 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUIeT0hWGRhCTR4fGU9KT0
        pMVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1OSk1KS0hNTEJON1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MyI6Qjo*Hz9KPgkzQz83AQo1Qw8KCShVSFVKTUlNSE5PSkhOS0NCVTMWGhIXVRcSFRA7DRIN
        FFUYFBZFWVdZEgtZQVlITVVKTklVSk9OVUpDSVlXWQgBWUFNS01MNwY+
X-HM-Tid: 0a7aaa42af0ad976kuwsc064dc201cd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQgYXQg
bW0vcGFnZV9hbGxvYy5jOjUxNzkKPj4gaW5fYXRvbWljKCk6IDAsIGlycXNfZGlzYWJsZWQoKTog
MSwgbm9uX2Jsb2NrOiAwLCBwaWQ6IDEsIG5hbWU6IHN3YXBwZXIvMAo+PiAKPj4gX19kdW1wX3N0
YWNrIGxpYi9kdW1wX3N0YWNrLmM6NzkgW2lubGluZV0KPj4gZHVtcF9zdGFja19sdmwrMHhjZC8w
eDEzNCBsaWIvZHVtcF9zdGFjay5jOjk2Cj4+IF9fX21pZ2h0X3NsZWVwLmNvbGQrMHgxZjEvMHgy
Mzcga2VybmVsL3NjaGVkL2NvcmUuYzo5MTUzCj4+IHByZXBhcmVfYWxsb2NfcGFnZXMrMHgzZGEv
MHg1ODAgbW0vcGFnZV9hbGxvYy5jOjUxNzkKPj4gX19hbGxvY19wYWdlcysweDEyZi8weDUwMCBt
bS9wYWdlX2FsbG9jLmM6NTM3NQo+PiBhbGxvY19wYWdlcysweDE4Yy8weDJhMCBtbS9tZW1wb2xp
Y3kuYzoyMjcyCj4+IHN0YWNrX2RlcG90X3NhdmUrMHgzOWQvMHg0ZTAgbGliL3N0YWNrZGVwb3Qu
YzozMDMKPj4gc2F2ZV9zdGFjaysweDE1ZS8weDFlMCBtbS9wYWdlX293bmVyLmM6MTIwCj4+IF9f
c2V0X3BhZ2Vfb3duZXIrMHg1MC8weDI5MCBtbS9wYWdlX293bmVyLmM6MTgxCj4+IHByZXBfbmV3
X3BhZ2UgbW0vcGFnZV9hbGxvYy5jOjI0NDUgW2lubGluZV0KPj4gX19hbGxvY19wYWdlc19idWxr
KzB4OGI5LzB4MTg3MCBtbS9wYWdlX2FsbG9jLmM6NTMxMwo+PiAKPj4gVGhlIHByb2JsZW0gaXMg
Y2F1c2VkIGJ5IHNldF9wYWdlX293bmVyIGFsbG9jIG1lbW9yeSB0byBzYXZlIHN0YWNrIHdpdGgK
Pj4gR0ZQX0tFUk5FTCBpbiBsb2NhbF9yaXEgZGlzYWJsZWQuCj4+IFNvLCB3ZSBqdXN0IGNhbid0
IGFzc3VtZSB0aGF0IGFsbG9jIGZsYWdzIHNob3VsZCBiZSBzYW1lIHdpdGggbmV3IHBhZ2UsCj4+
IHByZXBfbmV3X3BhZ2Ugc2hvdWxkIHByZXAvdHJhY2UgdGhlIHBhZ2UgZ2ZwLCBidXQgc2hvdWxk
bid0IHVzZSB0aGUgc2FtZQo+PiBnZnAgdG8gZ2V0IG1lbW9yeSwgbGV0J3MgZGVwZW5kIG9uIGNh
bGxlci4KPj4gU28sIGhlcmUgaXMgdHdvIGdmcCBmbGFncywgYWxsb2NfZ2ZwIHVzZWQgdG8gYWxs
b2MgbWVtb3J5LCBkZXBlbmQgb24KPj4gY2FsbGVyLCBwYWdlX2dmcF9tYXNrIGlzIHBhZ2UncyBn
ZnAsIHVzZWQgdG8gdHJhY2UvcHJlcCBpdHNlbGYKPj4gQnV0IGluIG1vc3Qgc2l0dWF0aW9uLCBz
YW1lIGlzIG9rLCBpbiBhbGxvY19wYWdlc19idWxrLCB1c2UgR0ZQX0FUT01JQwo+PiBpcyBvay4o
ZXZlbiBpZiBzZXRfcGFnZV9vd25lciBzYXZlIGJhY2t0cmFjZSBmYWlsZWQsIGxpbWl0ZWQgaW1w
YWN0KQo+PiAKPj4gdjI6Cj4+IC0gYWRkIG1vcmUgZGVzY3JpcHRpb24uCj4+IAo+PiBGaXhlczog
MGY4N2Q5ZDMwZjIxICgibW0vcGFnZV9hbGxvYzogYWRkIGFuIGFycmF5LWJhc2VkIGludGVyZmFj
ZSB0byB0aGUgYnVsayBwYWdlIGFsbG9jYXRvciIpCj4+IFJlcG9ydGVkLWJ5OiBzeXpib3QrYjA3
ZDg0NDBlZGI1Zjg5ODhlZWFAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+PiBTdWdnZXN0ZWQt
Ynk6IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcg
SHVhbiA8bGlua0B2aXZvLmNvbT4KPgo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIx
MDcxMzE1MjEwMC4xMDM4MS0yLW1nb3JtYW5AdGVjaHNpbmd1bGFyaXR5Lm5ldC8KPmlzIG5vdyBw
YXJ0IG9mIGEgc2VyaWVzIHRoYXQgaGFzIGJlaW5nIHNlbnQgdG8gTGludXMuIEhlbmNlLCB0aGUg
Rml4ZXMKPnBhcnQgaXMgbm8gbG9uZ2VyIGFwcGxpY2FibGUgYW5kIHRoZSBwYXRjaCB3aWxsIG5v
IGxvbmdlciBiZSBhZGRyZXNpbmcKPmFuIGF0b21pYyBzbGVlcCBidWcuICBUaGlzIHBhdGNoIHNo
b3VsZCBiZSB0cmVhdGVkIGFzIGFuIGVuaGFuY2VtZW50CkhpIE1lbCBHb3JtYW4sIHRoYW5rcyBm
b3IgeW91ciByZXBseS4KSSBzZWUgdGhlIGZpeCBwYXRjaCwgaXQgZml4IHRoaXMgYnVnIGJ5IGFi
YW5kb24gYWxsb2MgYnVsayBmZWF0dXJlIHdoZW4gcGFnZV9vd25lciBpcyBzZXQuIApCdXQgaW4g
bXkgb3BpbmlvbiwgaXQgY2FuJ3QgcmVhbGx5IGZpeCB0aGlzIGJ1ZywgaXQncyBhIGNpcmN1bXZl
bnRpb24gcGxhbi4KPnRvIGFsbG93IGJ1bGsgYWxsb2NhdGlvbnMgd2hlbiBQQUdFX09XTkVSIGlz
IHNldC4gRm9yIHRoYXQsIGl0IHNob3VsZAo+aW5jbHVkZSBhIG5vdGUgb24gdGhlIHBlcmZvcm1h
bmNlIGlmIFBBR0VfT1dORVIgaXMgdXNlZCB3aXRoIGVpdGhlciBORlMKPm9yIGhpZ2gtc3BlZWQg
bmV0d29ya2luZyB0byBqdXN0aWZ5IHRoZSBhZGRpdGlvbmFsIGNvbXBsZXhpdHkuCk15IHBhdGNo
IGp1c3Qgc3BsaXQgdGhlIHByZXBfbmV3X3BhZ2UgcGFnZV9nZnAgaW50byBhbGxvY19nZnAoZm9y
IGFsbG9jIGJ1bGsgaXMgR0ZQX0FUT01JQywKZm9yIG90aGVyJ3Mgbm8gY2hhbmdlKSBhbmQgdHJh
Y2UgcGFnZSBnZnAuICBTbywgd2Ugd2lsbCBub3QgdXNlIHRoZSBlcnJvciB3YXkgdG8gZ2V0IG1l
bW9yeS4gClNvLCBJIHRoaW5rIHRoaXMgd2lsbCBub3QgYWZmZWN0IGFsbG9jIGJ1bGsgcGVyZm9y
bWFuY2Ugd2hlbiBwYWdlX293bmVyIGlzIG9uKGNvbXBhcmUgd2l0aCBvcmlnaW4gcGF0Y2gpIGJ1
dApjYW4gcmVhbGx5IGZpeCB0aGlzICBidWcgcmF0aGVyIHRoYW4gZXZhZGUuCkFuZCB0aGlzIHBh
dGNoIGNhbiBsZXQgYWxsb2MgYnVsayBmZWF0dXJlIGFuZCBwYWdlX293bmVyIGZlYXR1cmUgd29y
ayB0b2doZXIKU28sIEkgd2lsbCBzZW5kIHBhdGNoIGFnYWluIGJhc2VkIG9uIHRoZSBmaXggcGF0
Y2guClRoYW5rIHlvdQpZYW5nIEh1YW4KPgo+LS0gCj5NZWwgR29ybWFuCj5TVVNFIExhYnMKDQoN
Cg==
