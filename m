Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE51332BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCIQ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhCIQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:26:20 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18004C06174A;
        Tue,  9 Mar 2021 08:26:20 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f12so16835608wrx.8;
        Tue, 09 Mar 2021 08:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdtX2sAcluZunzjO1B5Jwegzd5Uwhijb5PNqHMJaTlc=;
        b=R8paXwW3L03tr5Z6f2dHW6O0d6W6tOShYK0YfHl3dJElK3BOPPkDh3Us+dPlTAe+l6
         DuuWgPKpmOMu6ntzXoXsl2yi5XRxdQsLXGtYHRNYDL9oMpNhTargOULruDdQpjMZ/oG8
         3i+J0Xxp63x/xV1+32cKJNmfF9+/KkXM28N6bKCSeLNHBu8+R2VZzustlNQ7tbYhp6qW
         c6UmsrsQYXJ77AzdKAR3vXg4UZgJ1oGhg2HgnODyfZHWi8M1Md9PXhgwjZ4rHSOrit0s
         7LzyozSRCt+kVh8CWY3+w1wOEv+rvlUqtEebUCYamUR8FitSvRb62t93wVbUYAbbmy2k
         gBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdtX2sAcluZunzjO1B5Jwegzd5Uwhijb5PNqHMJaTlc=;
        b=O1/JIr9kdUft9JTFsImgE03eWBHmrrxK+N+urTvMsfHOjZ8lB6FdRJWwj0if3GlA/+
         NKzD3dkViL6J9UJ6XfKIKn/+3st1KOdcQumgvfeZS4KKY1rV+rgEbaFJOAgqSIFRqHGQ
         0rr2xbPWx2TvWxj1Ve9gslmzm2GBiOaVtgbOAekLm1SwN9mbbdcgsyCiexWfCyjwXNWz
         asdN1ITTS8WgQoMzAY7WwdRG5dZQjcdolcWXJtA/5PaV2279CKcldnsRH+dRXB3i6Yxy
         U8bWQsOBxMFyQPs/cyV8TYKhCwV/HwwlDZ2OuZuETirhw8tidwLmZ9kdLA8VjLpE1mca
         iqJQ==
X-Gm-Message-State: AOAM532xA+JPCHsYICde6GMiywyiQumO9EVFhHLoGLKi4Jj7HE/OdvQc
        Wn6eFL3ctDjIpqKD1+pLpnw=
X-Google-Smtp-Source: ABdhPJwudyf+BLWnjfIraLg3ACXU3j00XkabOU3nP4//lR0XCD8y6ttlEv5GiwtvPxsNIywxP6gglg==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr28653584wrj.185.1615307178744;
        Tue, 09 Mar 2021 08:26:18 -0800 (PST)
Received: from xws.localdomain (p5487b975.dip0.t-ipconnect.de. [84.135.185.117])
        by smtp.gmail.com with ESMTPSA id a17sm5343792wmj.9.2021.03.09.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:26:18 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator_registry: Add support for Surface Pro 7+
Date:   Tue,  9 Mar 2021 17:25:50 +0100
Message-Id: <20210309162550.302161-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Surface Pro 7+ is essentially a refresh of the Surface Pro 7 with
updated hardware and a new WSID identifier.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index cdb4a95af3e8..c42b97f61a57 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -191,7 +191,7 @@ static const struct software_node *ssam_node_group_sp6[] = {
 	NULL,
 };
 
-/* Devices for Surface Pro 7. */
+/* Devices for Surface Pro 7 and Surface Pro 7+. */
 static const struct software_node *ssam_node_group_sp7[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
@@ -521,6 +521,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Pro 7 */
 	{ "MSHW0116", (unsigned long)ssam_node_group_sp7 },
 
+	/* Surface Pro 7+ */
+	{ "MSHW0119", (unsigned long)ssam_node_group_sp7 },
+
 	/* Surface Book 2 */
 	{ "MSHW0107", (unsigned long)ssam_node_group_sb2 },
 
-- 
2.30.1

