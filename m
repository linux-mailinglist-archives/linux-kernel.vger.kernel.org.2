Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804D230D10A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 02:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBCBuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 20:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhBCBub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 20:50:31 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4509BC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 17:49:51 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so13551018plh.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 17:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8F+I6p5K2e1VnHWUFWnXn/ovc04lUJB16jXKpwFUrSQ=;
        b=Wj+X3aGeVZvj0hwhbqCTuZQbtuMmdgKkpOXLPdveSET7zoS5QvkZDdDQkKk4+kSPn4
         hbCXu5J8BjHUImNyimZNG1O3FlthdVBdUnfOeI/lSwYJjVuAcQFOq5Xia8P5uw4Akd+1
         5/gupU6XHyeEi6QAXvhwPnWS/MGnxWHsaJ3Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8F+I6p5K2e1VnHWUFWnXn/ovc04lUJB16jXKpwFUrSQ=;
        b=O0RrfqFuRB1QD5eDiWaioVplT3C22jgi4QruGL94FdojhYjC4qJzBHyi1/g1j/kRUF
         SDgeUbfcNj42/wJzQWPNPUQTyAyMnGsoqo88AdxmD27VusrXhL9Dr7qCRjaS/PRgyog4
         Fo4UvTcJF2qMyYmDWAiljoD3xuwffmOMoUTwTygYL2pXrQFSVBTp9K0dR8ldxSVpdmsH
         FKTePmaCHFL+if6O1m2/tkvxVuv/+pbpvPN6ZzKHhwYGtniavDxQS0SFQftYXnOj6Mmb
         3M2gD9dgKDr3lXg22e1OzJBSQh3yvB73V9y28sCCvVNzrqJL5co3yYwiL/WLeFz9aWtg
         6PEw==
X-Gm-Message-State: AOAM531GWt809MpVpKVyl7XtunaCRC+NIl737XyXiRxESCPJmGvqZVOV
        LEQYf47xQKNkXtaT4/9bZDPBfrf5noXTRg==
X-Google-Smtp-Source: ABdhPJx76P8iwJ/6a3TmwNwT4j9QnvPQJT/hAPyOSdqZzLclvKWEv8PhxjUdCGwAlLsIbfbX27UQTw==
X-Received: by 2002:a17:902:c24b:b029:e1:8c46:f876 with SMTP id 11-20020a170902c24bb02900e18c46f876mr768919plg.15.1612316990374;
        Tue, 02 Feb 2021 17:49:50 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:b5ef:2e43:a515:f29c])
        by smtp.gmail.com with ESMTPSA id w19sm225918pgf.23.2021.02.02.17.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 17:49:49 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 1/2] platform/chrome: cros_ec: Import Type C control command
Date:   Tue,  2 Feb 2021 17:49:36 -0800
Message-Id: <20210203014939.741065-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This command is used to communicate with the Chrome Embedded Controller
(EC) regarding USB Type C events and state.

These header updates are included in the latest Chrome OS EC headers [1]

[1]
https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 .../linux/platform_data/cros_ec_commands.h    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index d3c40220b281..a95dc22a5463 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5578,6 +5578,32 @@ struct ec_response_typec_discovery {
 	struct svid_mode_info svids[0];
 } __ec_align1;
 
+
+/* USB Type-C commands for AP-controlled device policy. */
+#define EC_CMD_TYPEC_CONTROL 0x0132
+
+enum typec_control_command {
+	TYPEC_CONTROL_COMMAND_EXIT_MODES,
+	TYPEC_CONTROL_COMMAND_CLEAR_EVENTS,
+	TYPEC_CONTROL_COMMAND_ENTER_MODE,
+};
+
+struct ec_params_typec_control {
+	uint8_t port;
+	uint8_t command;	/* enum typec_control_command */
+	uint16_t reserved;
+
+	/*
+	 * This section will be interpreted based on |command|. Define a
+	 * placeholder structure to avoid having to increase the size and bump
+	 * the command version when adding new sub-commands.
+	 */
+	union {
+		uint32_t clear_events_mask;
+		uint8_t mode_to_enter;      /* enum typec_mode */
+		uint8_t placeholder[128];
+	};
+} __ec_align1;
 /*
  * Gather all status information for a port.
  *
-- 
2.30.0.365.g02bc693789-goog

