Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702E3351403
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhDAK5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:57:46 -0400
Received: from mail-177142.yeah.net ([123.58.177.142]:30906 "EHLO
        mail-177142.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhDAK5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:57:31 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Apr 2021 06:57:31 EDT
Received: from vivo.com (localhost [127.0.0.1])
        by mail-177142.yeah.net (Hmail) with ESMTP id 4A48F645E61;
        Thu,  1 Apr 2021 18:49:37 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ACUA-ACHDo4PFmCPQ3ckzKr7.3.1617274177288.Hmail.zhouchuangao@vivo.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gYXJtNjQva2VybmVsL3Byb2JlczogVXNlIEJVR19PTiBpbnN0ZWFkIG9mIGlmIGNvbmRpdGlvbiBmb2xsb3dlZCBieSBCVUcu?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210330120801.GA5908@willie-the-truck>
MIME-Version: 1.0
Received: from zhouchuangao@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 1 Apr 2021 18:49:37 +0800 (GMT+08:00)
From:   =?UTF-8?B?5ZGo5Lyg6auY?= <zhouchuangao@vivo.com>
Date:   Thu, 1 Apr 2021 18:49:37 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQx4fQ0pKQ05OHh5CVkpNSkxJTE9KTExISkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1JT0xOTEJPSU1IN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6OC46Vjo4Mz8UTys9FjgrKkgYEAEwCUxVSFVKTUpMSUxPSkxMTUtPVTMWGhIXVQETFA4YEw4a
        FRwaFDsNEg0UVRgUFkVZV1kSC1lBWUhNVUpOSVVKT05VSkNJWVdZCAFZQUhISkg3Bg++
X-HM-Tid: 0a788d0d871b6473kurs4a48f645e61
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiBUdWUsIE1hciAzMCwgMjAyMSBhdCAwNDo1Nzo1MEFNIC0wNzAwLCB6aG91Y2h1YW5nYW8g
d3JvdGU6Pj4gSXQgY2FuIGJlIG9wdGltaXplZCBhdCBjb21waWxlIHRpbWUuCj4KPkhtbSwgSSBk
b24ndCBzZWUgaXQgKGFuZCBJIGFsc28gZG9uJ3QgdW5kZXJzdGFuZCB3aHkgd2UgY2FyZSkuIERv
IHlvdSBoYXZlCj5udW1iZXJzIHNob3dpbmcgdGhhdCB0aGlzIGlzIHdvcnRod2hpbGU/Cj4KCiNk
ZWZpbmUgQlVHX09OKGNvbmRpdGlvbikgZG8geyBpZiAodW5saWtlbHkoY29uZGl0aW9uKSkgQlVH
KCk7IH0gd2hpbGUgKDApCgpCVUdfT04gdXNlcyB1bmxpa2VseSBpbiBpZigpLiBUaHJvdWdoIGRp
c2Fzc2VtYmx5LCB3ZSBjYW4gc2VlIHRoYXQKYnJrICMweDgwMCBpcyBjb21waWxlZCB0byB0aGUg
ZW5kIG9mIHRoZSBmdW5jdGlvbi4KQXMgeW91IGNhbiBzZWUgYmVsb3c6CiAgICAuLi4uLi4KICAg
IGZmZmZmZjgwMDg2NjBiZWM6ICAgZDY1ZjAzYzAgICAgcmV0CiAgICBmZmZmZmY4MDA4NjYwYmYw
OiAgIGQ0MjEwMDAwICAgIGJyayAjMHg4MDAKClVzdWFsbHksIHRoZSBjb25kaXRpb24gaW4gaWYg
KCkgaXMgbm90IHNhdGlzZmllZC4gRm9yIHRoZSBtdWx0aS1zdGFnZSBwaXBlbGluZSwgCndlIGRv
IG5vdCBuZWVkIHRvIHBlcmZvcm0gZmV0Y2ggZGVjb2RlIGFuZCBleGN1dGUgb3BlcmF0aW9uIG9u
IGJyayAKaW5zdHJ1Y3Rpb24uCgpJbiBteSBvcGluaW9uLCB0aGlzIGNhbiBpbXByb3ZlIHRoZSBl
ZmZpY2llbmN5IG9mIHRoZSBtdWx0aS1zdGFnZSBwaXBlbGluZS4KCnpob3VjaHVhbmdhbwoKPldp
bGwKDQoNCg==
