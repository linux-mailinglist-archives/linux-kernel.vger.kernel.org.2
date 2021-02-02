Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA2930C66F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbhBBQsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbhBBQqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:46:23 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF027C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:45:43 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o63so15233408pgo.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NG3TbeCGSsI4uKAhjtspkiRLO8Ot3EEQlnLM9/MQOtI=;
        b=DvZVdNb4tNoJkxrI6GGJUhGoeYmhWZk9ILPO+noChdQdNqa9QZY+rSZGTQDi+G+6uC
         qMAuN743kVuissOUFRVp8+0pnGZnkwOlu5f2c8G138R2GxX2LpPmH90b9EPvCgCWmR92
         0QH1jdtSLg2EUtmfSkzHBRwVJe1n8krfRyVCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NG3TbeCGSsI4uKAhjtspkiRLO8Ot3EEQlnLM9/MQOtI=;
        b=A3k5QHYJQo6dOAMtf/DqiTGuFIcqYtOu5kELBNrVnlxEm7Ndbei9KPHlC9HwDbM+lc
         8MUziAay3wrX87aVF9zroFm2rzw+6GwAgv8gUAICQsDTWt3wwXs9zTGCk7OZjxhGfj2o
         J50qU27Yj/7O6xh4X7mnSLVZ2r2d9+OPyOmdiIn/VgMsNWJMEXMQqL4j1XW3JJqjDSwq
         aEpt+qB6SpmneqSrQswBTQgthM4kKAS/07Nvb92KvHO7d8P7OqWSrT9v3OeUvLfWFZlG
         ggwGJF+AnponPHZNPvAODUeoSjX80CalVAOwYLtWyPCx3FMGMwx5Y7nnCVxZxPHAUjph
         EQew==
X-Gm-Message-State: AOAM5304q7Nfzar23/cIedJiW/fqh1zcPSV1hY5/GUSBQ1Zqtwreojs2
        NOkp6Ro96yGshrGrnV+A+LlhyA==
X-Google-Smtp-Source: ABdhPJwXN8EQOf2SclCXwjIhK5XPHYrvBZf5JQep8fJfjzv8MM+5zoYXlntyhf4Cgq8nmqycNlCLFw==
X-Received: by 2002:aa7:95ba:0:b029:1c0:9d17:b36b with SMTP id a26-20020aa795ba0000b02901c09d17b36bmr22719105pfk.5.1612284343397;
        Tue, 02 Feb 2021 08:45:43 -0800 (PST)
Received: from bleung.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id q15sm19251101pfk.181.2021.02.02.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:45:42 -0800 (PST)
From:   Benson Leung <bleung@chromium.org>
To:     heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        pmalani@chromium.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kyletso@google.com, bleung@google.com, bleung@chromium.org
Subject: [PATCH v2] platform/chrome: cros_ec_typec: Fix call to typec_partner_set_pd_revision
Date:   Tue,  2 Feb 2021 08:45:31 -0800
Message-Id: <20210202164531.3982778-1-bleung@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typec_partner_set_pd_revision returns void now.

Fixes: cefc011f8daf ("platform/chrome: cros_ec_typec: Set Partner PD revision from status")
Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index a7778258d0a0..7b93dfd02999 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -842,11 +842,7 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
 		goto disc_exit;
 	}
 
-	ret = typec_partner_set_pd_revision(port->partner, pd_revision);
-	if (ret < 0) {
-		dev_err(typec->dev, "Failed to update partner PD revision, port: %d\n", port_num);
-		goto disc_exit;
-	}
+	typec_partner_set_pd_revision(port->partner, pd_revision);
 
 	memset(sop_disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
 	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
-- 
2.30.0.365.g02bc693789-goog

