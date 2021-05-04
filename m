Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12668372E59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhEDRBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:01:33 -0400
Received: from www.zeus03.de ([194.117.254.33]:48106 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhEDRBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=QwoCMbS9khJaBf
        4Dk09ZsCmrd5QikVNwp7vcCFcEWSk=; b=YKiJNzPqUo31BIZWxFvFt+TuszT861
        IiyTeHtZwfI8elzGwfeVNtdCT7anDuRPiqSMHGcXVe5HbKXsMBEhkvQYoY13nBjh
        Fb0nIN+LLbbvhjTLDKGxPu8UJa7/4CwEDkl8xXHEadAr3UMpF8+l1BbiSsu950Lr
        xEy1ETxMPGvqw=
Received: (qmail 1437723 invoked from network); 4 May 2021 19:00:36 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2021 19:00:36 +0200
X-UD-Smtp-Session: l3s3148p1@pDlUBITBqo8gAwDPXxOMAJUzfx/HAvHg
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: samsung-laptop: set debugfs blobs to read only
Date:   Tue,  4 May 2021 19:00:29 +0200
Message-Id: <20210504170030.58447-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210504170030.58447-1-wsa+renesas@sang-engineering.com>
References: <20210504170030.58447-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those blobs can only be read. So, don't confuse users with 'writable'
flags.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1: use octal numbers

 drivers/platform/x86/samsung-laptop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 763d97cbbe53..9aa0de8b7581 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1296,12 +1296,12 @@ static void samsung_debugfs_init(struct samsung_laptop *samsung)
 	debugfs_create_u32("d1", 0644, root, &samsung->debug.data.d1);
 	debugfs_create_u16("d2", 0644, root, &samsung->debug.data.d2);
 	debugfs_create_u8("d3", 0644, root, &samsung->debug.data.d3);
-	debugfs_create_blob("data", 0644, root, &samsung->debug.data_wrapper);
-	debugfs_create_blob("f0000_segment", 0600, root,
+	debugfs_create_blob("data", 0444, root, &samsung->debug.data_wrapper);
+	debugfs_create_blob("f0000_segment", 0400, root,
 			    &samsung->debug.f0000_wrapper);
 	debugfs_create_file("call", S_IFREG | 0444, root, samsung,
 			    &samsung_laptop_call_fops);
-	debugfs_create_blob("sdiag", 0644, root, &samsung->debug.sdiag_wrapper);
+	debugfs_create_blob("sdiag", 0444, root, &samsung->debug.sdiag_wrapper);
 }
 
 static void samsung_sabi_exit(struct samsung_laptop *samsung)
-- 
2.30.0

