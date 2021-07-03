Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762A33BA6A1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 03:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhGCBca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 21:32:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44272 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhGCBca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 21:32:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1631TYrl060675;
        Fri, 2 Jul 2021 20:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625275774;
        bh=PQsD9bu3Yj9/Oxyt3CPaVxF18ZGP2NlQgTVQ2xBJtlE=;
        h=From:To:CC:Subject:Date;
        b=EGCsNWDzDIs7m2vpMf8T/RBXaE2YXcq4OpbsdhbwF845DnDDLEtKd5HbsYvNnNQ2I
         j3PCsL/yGpCBTyniBktC7BrpRDOUK9L+mwwuyyl/g16pEuPcaKBm1I71xAFm0cH1Zt
         /fMzMb1Zdf9RDulTYyzRjn+yEgd1P0RBTktBMn4Y=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1631TYfA062879
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jul 2021 20:29:34 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 2 Jul
 2021 20:29:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 2 Jul 2021 20:29:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1631TYup043833;
        Fri, 2 Jul 2021 20:29:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-spdx@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Christoph Hellwig <hch@lst.de>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH] LICENSES/dual/CC-BY-4.0: Lets switch to utf-8
Date:   Fri, 2 Jul 2021 20:29:31 -0500
Message-ID: <20210703012931.30604-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets drop the unicode characters that peeped in and replace with
equivalent utf-8 characters. This makes the CC-BY-4.0 file inline with
rest of license files.

This messes up code such as scripts/spdxcheck.py which assumed utf-8
LICENSE files.

Fixes: bc41a7f36469 ("LICENSES: Add the CC-BY-4.0 license")

Cc: Thorsten Leemhuis <linux@leemhuis.info>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Christoph Hellwig <hch@lst.de>
Cc: Jonathan Corbet <corbet@lwn.net>

Reported-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
also see: https://lore.kernel.org/linux-spdx/20210703012128.27946-1-nm@ti.com/T/#u

 LICENSES/dual/CC-BY-4.0 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/LICENSES/dual/CC-BY-4.0 b/LICENSES/dual/CC-BY-4.0
index 45a81b8e4669..869cad3d1643 100644
--- a/LICENSES/dual/CC-BY-4.0
+++ b/LICENSES/dual/CC-BY-4.0
@@ -392,7 +392,7 @@ Section 8 -- Interpretation.
 Creative Commons is not a party to its public
 licenses. Notwithstanding, Creative Commons may elect to apply one of
 its public licenses to material it publishes and in those instances
-will be considered the “Licensor.” The text of the Creative Commons
+will be considered the "Licensor." The text of the Creative Commons
 public licenses is dedicated to the public domain under the CC0 Public
 Domain Dedication. Except for the limited purpose of indicating that
 material is shared under a Creative Commons public license or as
-- 
2.32.0

