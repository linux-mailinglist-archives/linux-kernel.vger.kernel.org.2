Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE633BA69D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 03:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhGCBYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 21:24:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38826 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhGCBYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 21:24:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1631LXGq007360;
        Fri, 2 Jul 2021 20:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625275293;
        bh=zVvtE+AlFB2PYU6ItsAID/6QpeNW3BE/7JiEspCGzjM=;
        h=From:To:CC:Subject:Date;
        b=sE+U7ZNzQZ2dZWMvESTpsoegh5CBK7nDSFa6+TXBjTbH28KVXDzJ6se5gIcDNiGc9
         nBvp0BjMciN13kTGso6ky4IUa0+oO0z1MIvEl5xTNIzCvJ3RzN7EurVSGRaR1OqidA
         4ECT0xSFnDBJid1ElDqvpKxAGNk6CR238H5H5NdA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1631LXs7079563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jul 2021 20:21:33 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 2 Jul
 2021 20:21:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 2 Jul 2021 20:21:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1631LWbL050889;
        Fri, 2 Jul 2021 20:21:32 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-spdx@vger.kernel.org>,
        Rahul T R <r-ravikumar@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] scripts/spdxcheck.py: Lets strictly read license files in utf-8
Date:   Fri, 2 Jul 2021 20:21:28 -0500
Message-ID: <20210703012128.27946-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bc41a7f36469 ("LICENSES: Add the CC-BY-4.0 license")
unfortunately introduced LICENSES/dual/CC-BY-4.0 in UTF-8 Unicode text
While python will barf at it with:

FAIL: 'ascii' codec can't decode byte 0xe2 in position 2109: ordinal not in range(128)
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 244, in <module>
    spdx = read_spdxdata(repo)
  File "scripts/spdxcheck.py", line 47, in read_spdxdata
    for l in open(el.path).readlines():
  File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
    return codecs.ascii_decode(input, self.errors)[0]
UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 2109: ordinal not in range(128)

While it is indeed debatable if 'Licensor.' used in the license file
needs unicode quotes, instead, let us force spdxcheck to read utf-8
instead.

Reported-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 scripts/spdxcheck.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 3e784cf9f401..ebd06ae642c9 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -44,7 +44,7 @@ def read_spdxdata(repo):
                 continue
 
             exception = None
-            for l in open(el.path).readlines():
+            for l in open(el.path, encoding="utf-8").readlines():
                 if l.startswith('Valid-License-Identifier:'):
                     lid = l.split(':')[1].strip().upper()
                     if lid in spdx.licenses:
-- 
2.32.0

