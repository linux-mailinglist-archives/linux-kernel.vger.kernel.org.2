Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C110940C4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhIOMPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:15:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49018 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhIOMPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:15:52 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18FCEPvl070268;
        Wed, 15 Sep 2021 07:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631708065;
        bh=lvzYtyNJkMB3akJY5gtdKxadl4HY0hIQuy4gkmH6BTk=;
        h=From:To:CC:Subject:Date;
        b=IwDY2+fC+/RuCi3wxH5MQkiwsrIGvgSTqyi5kJl+Qq+xrVNP0RS9lU0fiy30c/qex
         JVRuH36ksLGsXSaX77mgGG0EZqGyXm6bOWKgFmZUyCR1jaCLwYdw3LLgO4BM/BQl9M
         wEBoBtHGngZvjkCmiqPx2dVeQHyT9nsrL24hlr0U=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18FCEP62080919
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 07:14:25 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 07:13:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 07:13:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18FCDLgr092069;
        Wed, 15 Sep 2021 07:13:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] MAINTAINERS: Add Vignesh to TI K3 platform maintainership
Date:   Wed, 15 Sep 2021 07:13:08 -0500
Message-ID: <20210915121308.26795-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vignesh to TI K3 platform maintainership. We will rotate roles for
each kernel version to help spread the work load a little better.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..21d44498674e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2712,6 +2712,7 @@ F:	drivers/power/reset/keystone-reset.c
 
 ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE
 M:	Nishanth Menon <nm@ti.com>
+M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Tero Kristo <kristo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
-- 
2.32.0

