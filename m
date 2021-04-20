Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBD365E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhDTRRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbhDTRRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:17:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FAEC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:16:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso15706284pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3seW7xHEYDTF8KNnfQ+uuRDSSbA2HxxQ7koTgxNqW8=;
        b=itl8qrfUMATSudiR4kX1RZjiXCEV2SVRBzsaNyV6HJD9HYJ9czNBxtgG3wI977YYpU
         ZuexkgKfhw0r66scZCIv78z5kOIPI9C39nbYJtss9te7F58MM7WigDJfKXic/fpybVBO
         H1LUzCQG2Hkogy+FyX64YBqCDAByBqBAAX0wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3seW7xHEYDTF8KNnfQ+uuRDSSbA2HxxQ7koTgxNqW8=;
        b=LtTJyCRojade05h1cLivTaJKy+epVyafacZc6DCbdzBYCY5IhXXwQvBtz6QpHxwvOA
         zdjlL3zC8sq/R5eNfKDX62l2lV178s/EJtUyMIpxO6zdKcwUTGgZpeCTy8PLKsl3FWC4
         guRbkqQ73k0f6r6m5C0x2vsHkuYO7Okf2PVgAiR39LNj2iNVb9mt0k+N/vuIYEYQTAdR
         NkuYGjzVDq/UXg4D029hTfhR52L67aZCBGyBAAUWu59t52ZL1LGNS81k/3RbnLdMdg6a
         QbCvI8/wBO0mxEUsXz2kyoGJHexMsLkRTMU8R/+MQFeYvc/t26cfNVa7BIedHNt+vNb6
         rBhA==
X-Gm-Message-State: AOAM533eKrwszcCDCjxfn2vlNYbaKGnpIDHZmvhKJy6Rh+GDqBs6qd1G
        O2/2rvXdrDt3vZUAk01HZBYrK7GCDdJRkQ==
X-Google-Smtp-Source: ABdhPJwFUFEJcPZQ326DqywA3vpnVB91rfDuxFg5G30LDUwODVa9XIHM3EPmisaSw4cCIXlFtFgleQ==
X-Received: by 2002:a17:90a:cc0d:: with SMTP id b13mr6083999pju.219.1618939000925;
        Tue, 20 Apr 2021 10:16:40 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:ee88:6ec6:b8ee:20b9])
        by smtp.gmail.com with ESMTPSA id n48sm2260384pfv.130.2021.04.20.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:16:40 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH v3 2/2] platform/chrome: cros_ec_typec: Handle hard reset
Date:   Tue, 20 Apr 2021 10:16:13 -0700
Message-Id: <20210420171617.3830902-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420171617.3830902-1-pmalani@chromium.org>
References: <20210420171617.3830902-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Chrome Embedded Controller (EC) generates a hard reset type C event
when a USB Power Delivery (PD) hard reset is encountered. Handle this
event by unregistering the partner and cable on the associated port and
clearing the event flag.

Cc: Benson Leung <bleung@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v3:
- No changes.

Changes in v2:
- Split the header change into a separate patch.
- Updated the commit message to reflect the above.

v1:
https://lore.kernel.org/lkml/20210415021456.1805797-1-pmalani@chromium.org/

 drivers/platform/chrome/cros_ec_typec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d3df1717a5fd..22052f569f2a 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -905,6 +905,19 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 		return;
 	}
 
+	/* If we got a hard reset, unregister everything and return. */
+	if (resp.events & PD_STATUS_EVENT_HARD_RESET) {
+		cros_typec_remove_partner(typec, port_num);
+		cros_typec_remove_cable(typec, port_num);
+
+		ret = cros_typec_send_clear_event(typec, port_num,
+						  PD_STATUS_EVENT_HARD_RESET);
+		if (ret < 0)
+			dev_warn(typec->dev,
+				 "Failed hard reset event clear, port: %d\n", port_num);
+		return;
+	}
+
 	/* Handle any events appropriately. */
 	if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE && !typec->ports[port_num]->sop_disc_done) {
 		u16 sop_revision;
-- 
2.31.1.368.gbe11c130af-goog

