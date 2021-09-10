Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB80406AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhIJLp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhIJLp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:45:28 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35EAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:44:17 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id y144so1548136qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=+sNrClIRmKT39DXtlmngVLlo+ZAbFPvIJCSeUYEI0gw=;
        b=W3KawHv25sca09OHMXXsSx9jinI5IGxVA4u+TBi7/ZccoOdj/05pVya+fdn2Uv8NG6
         znx+S3ky21ocFeY8WeTbMNQ3YPFmv+4FhnVys6hulPumngd3GAHAHS4Ahw90toLsYHEp
         WS+Px4tcXrS1sp0deWhygiBOxxabgkb5lYF5cIJqvPSskoGBuRnJzcHIbTDuu7Gt+ThQ
         Q1BYLS+PjaugXM0w+aNhxAqqDn9k0kjKyHXDHwCfE9Mlqvnf8U1j5kAxutMJxEzw7BNT
         4BirtTccrsPay2tef3fSlbrFdRoy8M7Wp5xm+lKGTgU134vqQKF6bEf2KTnXu0Psa9iU
         Olkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+sNrClIRmKT39DXtlmngVLlo+ZAbFPvIJCSeUYEI0gw=;
        b=YldpkQb2feTUt2j8o8aY/y2RzPyRQgRcl3h0zron+vLtCJLREQOmvLW8WBDUtMTs6K
         a0riEHngQTGU0ujSlUarex5oRz4P9EY2ch4hI8IS5enEVlCmrXU9r71IEq0JIZ0Hb3+E
         1BonceaZ3YrG2rdHpC0UFVhIOG0dPC5g5nZAlhK4THJeajti1zVJaGsCLN4ZLg4pU4xM
         UTMQUK35GVTFks9CCIgBmoABdlxJ53/ckrxmqJ/rLw3wvdrvzHmZAQhbxdtO2ZQix1UE
         sPBFL2rEWaPBSTKncAhF01aa8XfsbD5NTIjghodIGvM5zrTyV1UDpAbjqmInuhC09/Ox
         xseA==
X-Gm-Message-State: AOAM533EyWYMPucJ80eLVAuUEDP6FPETNXl/01Wvlnbk55IVQEBuLF5j
        oO7QeAkHuafBitUH9VXvSPo6aSIuf/LwjJE6sumU4mQuEyDsEA==
X-Google-Smtp-Source: ABdhPJxljxd4MZntzMSRtGTYxE8bT9PcPHRPF0kSsskgic35Do8kFW6ZsNTJeKfyfmh1G91CkbKnFDOhAZnGUxvrBsc=
X-Received: by 2002:a05:620a:69b:: with SMTP id f27mr7220864qkh.287.1631274256924;
 Fri, 10 Sep 2021 04:44:16 -0700 (PDT)
MIME-Version: 1.0
From:   Du Dengke <pinganddu90@gmail.com>
Date:   Fri, 10 Sep 2021 19:44:05 +0800
Message-ID: <CAKHP1dt+X_A=0=inaav5nLnJFdmhhEiD47eBJvTnzNzL2_o73Q@mail.gmail.com>
Subject: scripts/checkstack.pl: fix minor spelling mistake
To:     linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009dc94105cba2a2e0"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009dc94105cba2a2e0
Content-Type: text/plain; charset="UTF-8"

Hi maintainer:
    This is a patch to fix scripts/checkstack.pl minor spelling mistake.
Thanks!

--0000000000009dc94105cba2a2e0
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-scripts-checkstack.pl-fix-spelling-mistakes.patch"
Content-Disposition: attachment; 
	filename="0001-scripts-checkstack.pl-fix-spelling-mistakes.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kteak9dj0>
X-Attachment-Id: f_kteak9dj0

RnJvbSA3YmEzZGQ0Njk0OTQ3NmJkNmVhODg3MWNkN2FmM2Q1MjQxN2Y4NzVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB6aGFveGluY2hhbyA8d2FuZ2h1b0B1Y2FzLmNvbS5jbj4KRGF0
ZTogVGh1LCA5IFNlcCAyMDIxIDAxOjQ1OjU5IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gc2NyaXB0
cy9jaGVja3N0YWNrLnBsOiBmaXggbWlub3Igc3BlbGxpbmcgbWlzdGFrZXMuCgpTaWduZWQtb2Zm
LWJ5OiB6aGFveGluY2hhbyA8d2FuZ2h1b0B1Y2FzLmNvbS5jbj4KLS0tCiBzY3JpcHRzL2NoZWNr
c3RhY2sucGwgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9zY3JpcHRzL2NoZWNrc3RhY2sucGwgYi9zY3JpcHRzL2NoZWNr
c3RhY2sucGwKaW5kZXggZDJjMzg1ODRlY2U2Li5hNDM5MTEyOGIwNTUgMTAwNzU1Ci0tLSBhL3Nj
cmlwdHMvY2hlY2tzdGFjay5wbAorKysgYi9zY3JpcHRzL2NoZWNrc3RhY2sucGwKQEAgLTMwLDcg
KzMwLDcgQEAgdXNlIHN0cmljdDsKICMgJCYgKHdob2xlIHJlKSBtYXRjaGVzIHRoZSBjb21wbGV0
ZSBvYmpkdW1wIGxpbmUgd2l0aCB0aGUgc3RhY2sgZ3Jvd3RoCiAjICQxIChmaXJzdCBicmFja2V0
KSBtYXRjaGVzIHRoZSBzaXplIG9mIHRoZSBzdGFjayBncm93dGgKICMKLSMgJGRyZSBpcyBzaW1p
bGFyLCBidXQgZm9yIGR5bmFtaWMgc3RhY2sgcmVkdXRpb25zOgorIyAkZHJlIGlzIHNpbWlsYXIs
IGJ1dCBmb3IgZHluYW1pYyBzdGFjayByZWR1Y3Rpb25zOgogIyAkJiAod2hvbGUgcmUpIG1hdGNo
ZXMgdGhlIGNvbXBsZXRlIG9iamR1bXAgbGluZSB3aXRoIHRoZSBzdGFjayBncm93dGgKICMgJDEg
KGZpcnN0IGJyYWNrZXQpIG1hdGNoZXMgdGhlIGR5bmFtaWMgYW1vdW50IG9mIHRoZSBzdGFjayBn
cm93dGgKICMKLS0gCjIuMTcuMQoK
--0000000000009dc94105cba2a2e0--
