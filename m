Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E11319361
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhBKTsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhBKTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17776C06178A;
        Thu, 11 Feb 2021 11:46:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q2so8174481eds.11;
        Thu, 11 Feb 2021 11:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zCukg/KgnVqLu7nAjOfWD7rNSU7F1rMMVwt26iP/dqU=;
        b=XYR/pQz9uEvf5AI5TttI/JEHzHLGpOHpqHh7VZbjtgC0T0byDcR9VGaHB9l7kCWp25
         1huu0JX0PpnA4bRE1zacdLjSI3lwu5nDrshjpY0cl/dmM6KuCS/4cl8IHwYQiRLLuahq
         TNxKfvMz+OqwDtvfmrJxZFj0g0feS+6BZxb0J/s3q2PVXCRFadOFLQLU1J5Rq9o9DWba
         I/uf3FFBjT6wQXgtF/NXusYw8gzA/6BVZJnLQlLgveSNHKj+ne9jRTEJwFYdtLYPuO+n
         M9VYKZC0FDuh68xNhU3A0nH+l5pVLR7v8FE+/d58n3qspOt5yjXoZhyyPDiGFInfcG2R
         JkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCukg/KgnVqLu7nAjOfWD7rNSU7F1rMMVwt26iP/dqU=;
        b=dqt66qiZaN6s8YUXtw6Sk2+5hlCBEy7Da9WGyo4jbGKIZ/n/F/76WalIp/jsNHfKyZ
         90fzNdccnUEv9s+LcvErw2f+uEr7DIqBz2Cso6Eb7PhHhKMdh4pIfnMbANHVbuNah+dk
         OKb7qRxYjZSwxToYHZcvm6APsJkksUTVLIkCD7Ye2MOEVLE5v/lAOy88y6QNFzy59w7w
         KppgdoUB9sttew3nPIc7ff6Nb2ZZW5gPPC4JNuedmzwmh/nGMzRY4TEbyaWHIeHHtHtO
         XMBfkkpsWf1mH+jd3l3j1E6ZRFgRM7XqZQ+MyMKuU5WeZMWMSqmnC12oyOAL67BJUv97
         vWcA==
X-Gm-Message-State: AOAM531q0WsiTbAdhc2V9E3fqfbfpaK8Mfdn6DynG4NcONSydZ/bMSsz
        EQcjqNEtOfwi3A4rprI55MWNxXo1IfyDIQ==
X-Google-Smtp-Source: ABdhPJxZfrqL/Hlp/fcEUdeOJomKlpZpEyRhdoikg5CgJlu+DSGhpCooKN61011Qe5NWC6NYVl8Egw==
X-Received: by 2002:aa7:c58f:: with SMTP id g15mr9697914edq.383.1613072811869;
        Thu, 11 Feb 2021 11:46:51 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id f6sm4728728edr.72.2021.02.11.11.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:46:51 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] platform/surface: aggregator_registry: Add DTX device
Date:   Thu, 11 Feb 2021 20:46:35 +0100
Message-Id: <20210211194636.568929-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211194636.568929-1-luzmaximilian@gmail.com>
References: <20210211194636.568929-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the detachment system (DTX) SSAM device for the Surface Book 3. This
device is accessible under the base (TC=0x11) subsystem.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 913fa5cae705..4c74e80dc34a 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -71,6 +71,12 @@ static const struct software_node ssam_node_tmp_pprof = {
 	.parent = &ssam_node_root,
 };
 
+/* DTX / detachment-system device (Surface Book 3). */
+static const struct software_node ssam_node_bas_dtx = {
+	.name = "ssam:01:11:01:00:00",
+	.parent = &ssam_node_root,
+};
+
 /* Devices for Surface Book 2. */
 static const struct software_node *ssam_node_group_sb2[] = {
 	&ssam_node_root,
@@ -86,6 +92,7 @@ static const struct software_node *ssam_node_group_sb3[] = {
 	&ssam_node_bat_main,
 	&ssam_node_bat_sb3base,
 	&ssam_node_tmp_pprof,
+	&ssam_node_bas_dtx,
 	NULL,
 };
 
-- 
2.30.0

