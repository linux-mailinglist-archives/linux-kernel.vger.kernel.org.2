Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA53BF106
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhGGUvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:51:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59232 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhGGUvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:51:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 167KmgXF117595;
        Wed, 7 Jul 2021 15:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625690922;
        bh=6HPmRna3waQ2ClqP2nauya0jag1AjaDVOXfeFC0wbWc=;
        h=From:To:CC:Subject:Date;
        b=YklCtSerr2qyb05xEtsc1ES/XxEXfDcE8Pqbmr0D29tWei73gFdTuvQ8w5kDxwBI8
         Tce1wDq1pQIHG+sTMb7pNDOUELS7p6Jz1CpZK/AiZu8VAvpObZkIzlOXiMDAlI0spc
         jFVjy+DsxsviqYdaMpoVtmvLzKt/DvrtYwZctDdA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 167Kmgk0089987
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Jul 2021 15:48:42 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 7 Jul
 2021 15:48:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 7 Jul 2021 15:48:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 167Kmfmh015408;
        Wed, 7 Jul 2021 15:48:41 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "Ravikumar, Rahul" <r-ravikumar@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-spdx <linux-spdx@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] scripts/spdxcheck.py: Strictly read license files in utf-8
Date:   Wed, 7 Jul 2021 15:48:40 -0500
Message-ID: <20210707204840.30891-1-nm@ti.com>
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
needs unicode quotes, instead, force spdxcheck to read utf-8.

Reported-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---

Changes since V1:
* Commit message update to drop "Let's" "Let us".
* Picked up Thomas' Reviewed-by

V1: https://lore.kernel.org/linux-spdx/20210703012128.27946-1-nm@ti.com/

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

