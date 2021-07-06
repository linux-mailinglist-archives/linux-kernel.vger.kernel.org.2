Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186033BC4E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 04:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhGFCwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 22:52:06 -0400
Received: from mail-m176231.qiye.163.com ([59.111.176.231]:21430 "EHLO
        mail-m176231.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFCwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 22:52:05 -0400
DKIM-Signature: a=rsa-sha256;
        b=mz7qmqEUp0M7bdbuHTNw8iaO1hLgerTha3FQDZvth+8iQaniDyoMg84QTAtgY4MwVIPsRi84umAtoVyjg68r2xn+5mGEM78/7Rtg7674G6qBi/eFHlKKDWcptRPjHlQltoqMWOs4QWDS+CindQJkeKh6h44OMw7gE2p5vcF+kL0=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=5pu1lW7II5PwyAx/vGZsdzf//8tdLf8E2BZd7BYtp8U=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176231.qiye.163.com (Hmail) with ESMTP id E54986C00F3;
        Tue,  6 Jul 2021 10:41:21 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AEsAOwC*DyQcdDctDg-oWKqc.3.1625539281909.Hmail.wangqing@vivo.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6UmU6IFtQaGlzaGluZyBSaXNrXSBbRXh0ZXJuYWxdIFtQQVRDSF0gbW06IGFkZCBHRlBfQVRPTUlDIGZsYWcgYWZ0ZXIgbG9jYWxfbG9ja19pcnFzYXZl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.158
In-Reply-To: <CAMZfGtUbX+TAx-7RJ4ZpoNLHDa9mp6k+DBqHaYiLjhSJokh3Sw@mail.gmail.com>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [58.213.83.158) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 6 Jul 2021 10:41:21 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Tue, 6 Jul 2021 10:41:21 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0MdTVYZHxpLGUMYTh9ISkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1PQ0JMTUNOSElON1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Pgg6NAw4UT8CKhgfPxgPPxxWFCwwChhVSFVKTUlOTkhCSUNJSUhCVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZTkNVSUpIVUNIVUpOQ1lXWQgBWUFPT0tKNwY+
X-HM-Tid: 0a7a79b10417d9a9kuwse54986c00f3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiBNb24sIEp1bCA1LCAyMDIxIGF0IDk6NTcgUE0gV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZv
LmNvbT4gd3JvdGU6Cj4+Cj4+IFVzZSBHRlBfQVRPTUlDIHdoZW4gbG9jYWxfbG9ja19pcnFzYXZl
IGluIF9fYWxsb2NfcGFnZXNfYnVsawo+Pgo+PiBSZXBvcnRlZC1ieTogc3l6Ym90K2U0NTkxOWRi
MmVhYjVlODM3NjQ2QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KPj4gU2lnbmVkLW9mZi1ieTog
V2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4KPj4gLS0tCj4+ICBtbS9wYWdlX2FsbG9jLmMg
fCAyICstCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL21tL3BhZ2VfYWxsb2MuYyBiL21tL3BhZ2VfYWxsb2MuYwo+PiBp
bmRleCBkNmU5NGNjLi4zMDE2YmE1Cj4+IC0tLSBhL21tL3BhZ2VfYWxsb2MuYwo+PiArKysgYi9t
bS9wYWdlX2FsbG9jLmMKPj4gQEAgLTUzMDksNyArNTMwOSw3IEBAIHVuc2lnbmVkIGxvbmcgX19h
bGxvY19wYWdlc19idWxrKGdmcF90IGdmcCwgaW50IHByZWZlcnJlZF9uaWQsCj4+ICAgICAgICAg
ICAgICAgICB9Cj4+ICAgICAgICAgICAgICAgICBucl9hY2NvdW50Kys7Cj4+Cj4+IC0gICAgICAg
ICAgICAgICBwcmVwX25ld19wYWdlKHBhZ2UsIDAsIGdmcCwgMCk7Cj4+ICsgICAgICAgICAgICAg
ICBwcmVwX25ld19wYWdlKHBhZ2UsIDAsIGdmcCB8IEdGUF9BVE9NSUMsIDApOwo+Cj5IaSBXYW5n
IFFpbmcsCj4KPkkgZGlkbid0IGdldCB0aGUgcG9pbnQgaGVyZS4gSUlVQywgcHJlcF9uZXdfcGFn
ZSgpIHdpbGwgbm90IGFsbG9jYXRlCj5tZW1vcnkuIFNvIHdoeSBkbyB3ZSBuZWVkIEdGUF9BVE9N
SUM/IFdoYXQgSSBtaXNzZWQgaGVyZT8KPgo+VGhhbmtzLgoKcHJlcF9uZXdfcGFnZSgpIHdpbGwg
YWxsb2NhdGUgbWVtb3J5IGluIHNvbWUgc2NlbmFyaW9zLiBGb3IgZGV0YWlscywgCnlvdSBjYW4g
Y2hlY2sgdGhlIGJ1Z3MgZGV0ZWN0ZWQgYnkgc3l6a2FsbGVyOgpodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS9idWc/aWQ9OTFjMjAzMDI0MWFkYTBlNWQyMTg3N2Y4ZjJmNDRjOThjZmZjMDRi
YgoKQ2FsbCBUcmFjZToKIF9fZHVtcF9zdGFjayBsaWIvZHVtcF9zdGFjay5jOjc5IFtpbmxpbmVd
CiBkdW1wX3N0YWNrX2x2bCsweGNkLzB4MTM0IGxpYi9kdW1wX3N0YWNrLmM6OTYKIF9fX21pZ2h0
X3NsZWVwLmNvbGQrMHgxZjEvMHgyMzcga2VybmVsL3NjaGVkL2NvcmUuYzo5MTUzCiBwcmVwYXJl
X2FsbG9jX3BhZ2VzKzB4M2RhLzB4NTgwIG1tL3BhZ2VfYWxsb2MuYzo1MTc5CiBfX2FsbG9jX3Bh
Z2VzKzB4MTJmLzB4NTAwIG1tL3BhZ2VfYWxsb2MuYzo1Mzc1CiBhbGxvY19wYWdlcysweDE4Yy8w
eDJhMCBtbS9tZW1wb2xpY3kuYzoyMjcyCiBzdGFja19kZXBvdF9zYXZlKzB4MzlkLzB4NGUwIGxp
Yi9zdGFja2RlcG90LmM6MzAzCiBzYXZlX3N0YWNrKzB4MTVlLzB4MWUwIG1tL3BhZ2Vfb3duZXIu
YzoxMjAKIF9fc2V0X3BhZ2Vfb3duZXIrMHg1MC8weDI5MCBtbS9wYWdlX293bmVyLmM6MTgxCiBw
cmVwX25ld19wYWdlIG1tL3BhZ2VfYWxsb2MuYzoyNDQ1IFtpbmxpbmVdCiBfX2FsbG9jX3BhZ2Vz
X2J1bGsrMHg4YjkvMHgxODcwIG1tL3BhZ2VfYWxsb2MuYzo1MzEzCgpUaGFua3MuCgpRaW5nCgo+
Cj4+ICAgICAgICAgICAgICAgICBpZiAocGFnZV9saXN0KQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICBsaXN0X2FkZCgmcGFnZS0+bHJ1LCBwYWdlX2xpc3QpOwo+PiAgICAgICAgICAgICAgICAg
ZWxzZQo+PiAtLQo+PiAyLjcuNAo+PgoNCg0K
