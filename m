Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C6447D9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbhKHKRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:17:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38478 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238588AbhKHKPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:19 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 812BA1EC0516;
        Mon,  8 Nov 2021 11:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MtoYV6wcauTVXH7eaqnJ0pldyJt64VOMJeAtyl78lTg=;
        b=iU6K6Z4rVlI5o9g0BTMN1oCvLmPd3voWnEwencwhFp81DjoTTp+IkVIke5y228nA1IgPZn
        iUR8IZ6d+I2yi1s9tf1s73SJRusU34fPtsYRQ/wBvhdN8pgXMBxRz26RgX7zMVAwaTYkdL
        aZ5xCMWpzsp1lDu2srWFO+yel2dCyeI=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v0 32/42] macintosh/adb: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:47 +0100
Message-Id: <20211108101157.15189-33-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/macintosh/adbhid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index 994ba5cb3678..c8cbf8588186 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -1262,8 +1262,8 @@ static int __init adbhid_init(void)
 
 	adbhid_probe();
 
-	blocking_notifier_chain_register(&adb_client_list,
-			&adbhid_adb_notifier);
+	if (blocking_notifier_chain_register(&adb_client_list, &adbhid_adb_notifier))
+		pr_warn("ADB message notifier already registered\n");
 
 	return 0;
 }
-- 
2.29.2

