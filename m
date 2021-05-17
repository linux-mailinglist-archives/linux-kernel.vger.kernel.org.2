Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463F3382971
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbhEQKJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:09:11 -0400
Received: from www.zeus03.de ([194.117.254.33]:39458 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236078AbhEQKJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Z0f6aV6NsliMjT
        tzNpWaoTKaZ24I1TbtLb9a3MIBU8E=; b=IMma1yLQIWMkbtuv0zbkIFwbyX5W5r
        ZLnD4j2IwGmswWWiB/Jw+VrtAVRvqcKByzwJ0uPrOWfQaOEANDBnPqf01obQlfTb
        6vDsK9Ag137TOvQF1WymA3DAUHemcFJPnmfTtQAKkOyI3mWm+iW76El4ZtM1Kkhg
        /FnaoxL3M1GdI=
Received: (qmail 2471414 invoked from network); 17 May 2021 12:07:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 May 2021 12:07:48 +0200
X-UD-Smtp-Session: l3s3148p1@luD9w4PC/rggARa4RYY7ATBvQ5FTVwg4
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 2/2] platform/x86: samsung-laptop: set debugfs blobs to read only
Date:   Mon, 17 May 2021 12:07:45 +0200
Message-Id: <20210517100746.29663-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517100746.29663-1-wsa+renesas@sang-engineering.com>
References: <20210517100746.29663-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those blobs can only be read. So, don't confuse users with 'writable'
flags. Also, remove S_IFREG because debugfs takes care of that.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

change since v2: added Andy's tag and removed S_IFREG

 drivers/platform/x86/samsung-laptop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 763d97cbbe53..7ee010aa740a 100644
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
-	debugfs_create_file("call", S_IFREG | 0444, root, samsung,
+	debugfs_create_file("call", 0444, root, samsung,
 			    &samsung_laptop_call_fops);
-	debugfs_create_blob("sdiag", 0644, root, &samsung->debug.sdiag_wrapper);
+	debugfs_create_blob("sdiag", 0444, root, &samsung->debug.sdiag_wrapper);
 }
 
 static void samsung_sabi_exit(struct samsung_laptop *samsung)
-- 
2.30.2

