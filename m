Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541BD3F4500
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 08:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhHWGeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 02:34:46 -0400
Received: from mail-m176231.qiye.163.com ([59.111.176.231]:10294 "EHLO
        mail-m176231.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhHWGep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:34:45 -0400
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176231.qiye.163.com (Hmail) with ESMTP id 44F786C01FA;
        Mon, 23 Aug 2021 14:33:59 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJEACAC1D27qN9TVG8Nujqqw.3.1629700439268.Hmail.wangqing@vivo.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCxSRVNFTkRdIHNvZnRpcnE6IEludHJvZHVjZSBTT0ZUSVJRX0ZPUkNFRF9USFJFQURJTkc=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.158
In-Reply-To: <b9b55cad5b7ca120ebec2acbbbd0a7fc1a986ec7.camel@gmx.de>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [58.213.83.158) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 23 Aug 2021 14:33:59 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Mon, 23 Aug 2021 14:33:59 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkYQk9WHhoZGhpLS0xLTh
        1DVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1NSUpPQ09NSUhNN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MT46ODo4Sj9JTAo1Qi8tPEM1DhEKCgxVSFVKTUlCTEtLT09LSU9LVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZTkNVSUpIVUNIVUpOQ1lXWQgBWUFPS0xINwY+
X-HM-Tid: 0a7b71b73cf9d9a9kuws44f786c01fa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiBNb24sIDIwMjEtMDgtMjMgYXQgMTE6MzMgKzA4MDAsIFdhbmcgUWluZyB3cm90ZToKPj4g
QXQgcHJlc2VudCwgd2hldGhlciB0aGUgc29mdGlycSBpcyBleGVjdXRlZCB3aGVuIHRoZSBpbnRl
cnJ1cHQgZXhpdHMKPj4gaXMgY29udHJvbGxlZCBieSBJUlFfRk9SQ0VEX1RIUkVBRElORy4gVGhp
cyBpcyB1bnJlYXNvbmFibGUuIEl0IHNob3VsZAo+PiBiZSBzcGxpdCBhbmQgYWxsb3dlZCB0byB0
YWtlIGVmZmVjdCBzZXBhcmF0ZWx5Lgo+Cj5EZWNhZGVzIGxvbmcgcHJhY3RpY2Ugc3VkZGVubHkg
YmVjYW1lICJ1bnJlYXNvbmFibGUiPyAgSSB0aGluayBub3QuIMKgCgoidW5yZWFzb25hYmxlIiBt
YXkgYmUgbXkgbWlzbm9tZXIsIGJ1dCBpdCBpcyByZWFsbHkgbmVjZXNzYXJ5IHRvIHNlcGFyYXRl
CnNvZnRpcnEgZnJvbSBJUlFfRk9SQ0VEX1RIUkVBRElORywgd2hpY2ggY2FuIGJlIGVmZmVjdGl2
ZSBzZXBhcmF0ZWx5LgoKPgo+VHJ5aW5nIHRvIGNhcnZlIG91dCBiaXRzIGFuZCBwaWVjZXMgb2Yg
UlQgdG8gbWVyZ2UgaW1tZWRpYXRlbHkgaXNuJ3QKPmxpa2VseSB0byBtYWtlIHRoZSBvbmdvaW5n
IG1lcmdlIGVmZm9ydCBnbyBhbnlmYXN0ZXIgb3Igc21vb3RoZXIuCgpJIGFtIG5vdCB0cnlpbmcg
dG8gY2FydmUgb3V0IGJpdHMgYW5kIHBpZWNlcyBvZiBSVCwgYnV0IEkgZW5jb3VudGVyZWQgYWN0
dWFsCnByb2JsZW1zIGluIG15IHByb2plY3QuIEZvciBleGFtcGxlLCBpbiBBbmRyb2lkLCB3ZSB3
aWxsIG5vdCBlbmFibGUgCklSUV9GT1JDRURfVEhSRUFESU5HLCBBbmRyb2lkIGlzIG5vdCBhIGhp
Z2ggcmVhbC10aW1lIHJlcXVpcmVtZW50cywgCmJ1dCBpbiBzb21lIHNjZW5hcmlvc3NvbWUsIFJU
IHByb2Nlc3NlcyBjYW5ub3QgYmUgc2NoZWR1bGVkIGluIHRpbWUKYW5kIHRoZSBmcmFtZSBpcyBk
cm9wcGVkIGR1ZSB0byB0aGUgZXhlY3V0aW9uIHRpbWUgb2Ygc29mdGlycSBpcyB0b28gbG9uZywK
YWxzbyBzb21lIHNvZnRpcnEgY2Fubm90IGJlIGV4ZWN1dGVkIGluIHRpbWUgaW4ga3NvZnRpcnFz
LCBhbmQgZGVsYXlzIG9jY3VyLCAKc3VjaCBhcyBJTy4KClRoZXJlZm9yZSwgd2h5IG5vdCBnaXZl
IHRoZSB1c2VyIGEgY2hvaWNlIHRvIGJhbGFuY2UgdGhlIGV4ZWN1dGlvbiBvZiBzb2Z0aXJxCndo
aWxlIG5vdCBlbmFibGUgSVJRX0ZPUkNFRF9USFJFQURJTkcsIHNvIGFzIHRvIG1lZXQgdGhlIGlu
Y29uc2lzdGVudCAKc2NlbmVzIGFuZCBuZWVkcwoKVGhhbmtzLgpRaW5nCj4KPglKdXN0IG15ICQu
MDIsCj4KPgktTWlrZQo+Cj4KDQoNCg==
