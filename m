Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA03BC509
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 05:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhGFDQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 23:16:13 -0400
Received: from mail-m176231.qiye.163.com ([59.111.176.231]:50510 "EHLO
        mail-m176231.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhGFDQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 23:16:12 -0400
DKIM-Signature: a=rsa-sha256;
        b=kOpD+bSmG3W51I6RUJ2k7CEdrhlKqDaBu98yANcCoOuaRFNlF8y2V1M+tzJwr66uTucGr+KOIffjkt7F/udKvbe6d5wom/D10b6yq6diyrQ7jl/A7uhpMv9F0hILGXpEsOwTr/YArh0yWUr1xFonBtS/R/ObEY+EtYNTcPfO8lk=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=VNQVfa44qct0jHNvGO//4uyYAll2BIsmx0UDLI9rjcU=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176231.qiye.163.com (Hmail) with ESMTP id 444486C00F7;
        Tue,  6 Jul 2021 11:13:33 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AAIAAQC9D3YcoTdKLKLdcarM.3.1625541213263.Hmail.wangqing@vivo.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6UmU6IFJlOiBbUGhpc2hpbmcgUmlza10gW0V4dGVybmFsXSBbUEFUQ0hdIG1tOiBhZGQgR0ZQX0FUT01JQyBmbGFnIGFmdGVyIGxvY2FsX2xvY2tfaXJxc2F2ZQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.158
In-Reply-To: <CAMZfGtXSg8YbNDFQ8xtvYd-5aDf3g255Pxo+fKSS_YME11dMaQ@mail.gmail.com>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [58.213.83.158) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 6 Jul 2021 11:13:33 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Tue, 6 Jul 2021 11:13:33 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0NIGlZDSUhPSUhKHkNLHkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1PQ0JCSUpNQ09DN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6OjI6Oio4Qj9IIhgULx8wNzA3HxgaCTZVSFVKTUlOTk9KSUpITkJDVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZTkNVSUpIVUNIVUpOQ1lXWQgBWUFOSkhCNwY+
X-HM-Tid: 0a7a79ce7c63d9a9kuws444486c00f7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiBUdWUsIEp1bCA2LCAyMDIxIGF0IDEwOjQxIEFNIOeOi+aTjiA8d2FuZ3FpbmdAdml2by5j
b20+IHdyb3RlOgo+Pgo+Pgo+PiA+T24gTW9uLCBKdWwgNSwgMjAyMSBhdCA5OjU3IFBNIFdhbmcg
UWluZyA8d2FuZ3FpbmdAdml2by5jb20+IHdyb3RlOgo+PiA+Pgo+PiA+PiBVc2UgR0ZQX0FUT01J
QyB3aGVuIGxvY2FsX2xvY2tfaXJxc2F2ZSBpbiBfX2FsbG9jX3BhZ2VzX2J1bGsKPj4gPj4KPj4g
Pj4gUmVwb3J0ZWQtYnk6IHN5emJvdCtlNDU5MTlkYjJlYWI1ZTgzNzY0NkBzeXprYWxsZXIuYXBw
c3BvdG1haWwuY29tCj4+ID4+IFNpZ25lZC1vZmYtYnk6IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2
by5jb20+Cj4+ID4+IC0tLQo+PiA+PiAgbW0vcGFnZV9hbGxvYy5jIHwgMiArLQo+PiA+PiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+ID4+Cj4+ID4+IGRp
ZmYgLS1naXQgYS9tbS9wYWdlX2FsbG9jLmMgYi9tbS9wYWdlX2FsbG9jLmMKPj4gPj4gaW5kZXgg
ZDZlOTRjYy4uMzAxNmJhNQo+PiA+PiAtLS0gYS9tbS9wYWdlX2FsbG9jLmMKPj4gPj4gKysrIGIv
bW0vcGFnZV9hbGxvYy5jCj4+ID4+IEBAIC01MzA5LDcgKzUzMDksNyBAQCB1bnNpZ25lZCBsb25n
IF9fYWxsb2NfcGFnZXNfYnVsayhnZnBfdCBnZnAsIGludCBwcmVmZXJyZWRfbmlkLAo+PiA+PiAg
ICAgICAgICAgICAgICAgfQo+PiA+PiAgICAgICAgICAgICAgICAgbnJfYWNjb3VudCsrOwo+PiA+
Pgo+PiA+PiAtICAgICAgICAgICAgICAgcHJlcF9uZXdfcGFnZShwYWdlLCAwLCBnZnAsIDApOwo+
PiA+PiArICAgICAgICAgICAgICAgcHJlcF9uZXdfcGFnZShwYWdlLCAwLCBnZnAgfCBHRlBfQVRP
TUlDLCAwKTsKPj4gPgo+PiA+SGkgV2FuZyBRaW5nLAo+PiA+Cj4+ID5JIGRpZG4ndCBnZXQgdGhl
IHBvaW50IGhlcmUuIElJVUMsIHByZXBfbmV3X3BhZ2UoKSB3aWxsIG5vdCBhbGxvY2F0ZQo+PiA+
bWVtb3J5LiBTbyB3aHkgZG8gd2UgbmVlZCBHRlBfQVRPTUlDPyBXaGF0IEkgbWlzc2VkIGhlcmU/
Cj4+ID4KPj4gPlRoYW5rcy4KPj4KPj4gcHJlcF9uZXdfcGFnZSgpIHdpbGwgYWxsb2NhdGUgbWVt
b3J5IGluIHNvbWUgc2NlbmFyaW9zLiBGb3IgZGV0YWlscywKPj4geW91IGNhbiBjaGVjayB0aGUg
YnVncyBkZXRlY3RlZCBieSBzeXprYWxsZXI6Cj4+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3Qu
Y29tL2J1Zz9pZD05MWMyMDMwMjQxYWRhMGU1ZDIxODc3ZjhmMmY0NGM5OGNmZmMwNGJiCj4+Cj4+
IENhbGwgVHJhY2U6Cj4+ICBfX2R1bXBfc3RhY2sgbGliL2R1bXBfc3RhY2suYzo3OSBbaW5saW5l
XQo+PiAgZHVtcF9zdGFja19sdmwrMHhjZC8weDEzNCBsaWIvZHVtcF9zdGFjay5jOjk2Cj4+ICBf
X19taWdodF9zbGVlcC5jb2xkKzB4MWYxLzB4MjM3IGtlcm5lbC9zY2hlZC9jb3JlLmM6OTE1Mwo+
PiAgcHJlcGFyZV9hbGxvY19wYWdlcysweDNkYS8weDU4MCBtbS9wYWdlX2FsbG9jLmM6NTE3OQo+
PiAgX19hbGxvY19wYWdlcysweDEyZi8weDUwMCBtbS9wYWdlX2FsbG9jLmM6NTM3NQo+PiAgYWxs
b2NfcGFnZXMrMHgxOGMvMHgyYTAgbW0vbWVtcG9saWN5LmM6MjI3Mgo+PiAgc3RhY2tfZGVwb3Rf
c2F2ZSsweDM5ZC8weDRlMCBsaWIvc3RhY2tkZXBvdC5jOjMwMwo+PiAgc2F2ZV9zdGFjaysweDE1
ZS8weDFlMCBtbS9wYWdlX293bmVyLmM6MTIwCj4+ICBfX3NldF9wYWdlX293bmVyKzB4NTAvMHgy
OTAgbW0vcGFnZV9vd25lci5jOjE4MQo+PiAgcHJlcF9uZXdfcGFnZSBtbS9wYWdlX2FsbG9jLmM6
MjQ0NSBbaW5saW5lXQo+PiAgX19hbGxvY19wYWdlc19idWxrKzB4OGI5LzB4MTg3MCBtbS9wYWdl
X2FsbG9jLmM6NTMxMwo+Cj5Hb3QgaXQuIEJ1dCBJIGRvbid0IHRoaW5rIHRoZSBmaXggeW91IG1l
bnRpb25lZCBhYm92ZSB3YXMKPmFwcHJvcHJpYXRlLiBXaGF0IGlmIEdGUF9LRVJORUwgfCBHRlBf
QVRPTUlDPwoKWWVzIGFncmVlLCBidXQgSSBoYXZlbid0IGZpZ3VyZWQgb3V0IHdoYXQgd2lsbCBo
YXBwZW4gdGhpcyB3YXksIAp0aGUgdGVzdCBoYXMgYmVlbiBwYXNzZWQgaW4gc3l6a2FsbGVyLgpP
ciBob3cgYWJvdXQgZ2ZwIHwgR0ZQX0FUT01JQyAmIH5HRlBfS0VSTkVMID8KClRoYW5rcywKClFp
bmcKPgo+VGhhbmtzLgo+Cj4+Cj4+IFRoYW5rcy4KPj4KPj4gUWluZwo+Pgo+PiA+Cj4+ID4+ICAg
ICAgICAgICAgICAgICBpZiAocGFnZV9saXN0KQo+PiA+PiAgICAgICAgICAgICAgICAgICAgICAg
ICBsaXN0X2FkZCgmcGFnZS0+bHJ1LCBwYWdlX2xpc3QpOwo+PiA+PiAgICAgICAgICAgICAgICAg
ZWxzZQo+PiA+PiAtLQo+PiA+PiAyLjcuNAo+PiA+Pgo+Pgo+PgoNCg0K
