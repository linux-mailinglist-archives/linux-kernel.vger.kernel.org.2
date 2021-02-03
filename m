Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6D130D153
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhBCCQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhBCCQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:16:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBB7C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 18:15:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z9so3630156pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 18:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbVLjE4pA7oT0/uWGg6EJq6VOaWfRHtB4HcfCVBTp08=;
        b=Zc9ez/AZT+omA/BorwYfH1EEwTl+ewgo/tZBxUhlxlGzgGZuFRlE3qeomMqselW38n
         SxDt8KE8EGYXLmBzP4rBm+TNzs00EMMqdOFuaHWXzyWOoMgVvmsGvE5Md19rwmkdBiSW
         6/LcPnx4he5OK4NTdRU+e37cKv9IolhtJdaPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbVLjE4pA7oT0/uWGg6EJq6VOaWfRHtB4HcfCVBTp08=;
        b=K1rKirF9Uu1t/IrhHYw4sf1OFTzk3nU2Z7bSx5hc1gN+3z0qtxFTEv5RLHGrat6/gt
         DT+5Oj71kQ+0MLxNIGyZUr5X8lXYnIpH37UtSJ03VTbo9X0CeX/rObvaO4VnWRK481kG
         mpWZPc7L06AdqB44gW+dgLlmR0ukcVG0zOOnkBsyl3+oDvd80RjEGdyng2yFrms2yopO
         fpnloAphQkT4RIJBVeoMQF2tJ+j8g7esvTcSgwqo0cTjZa4co8flfvB6JZJK1fd+tCnC
         +unDNqj3OslYGLlDGR32YoGUR2DCo/AWvWNkh82P2I53p0PdsjFJvji56wu01SKxLMTu
         RQrA==
X-Gm-Message-State: AOAM53008icVOkEPxa7vadYP6HtFk33avB010b9exb+fjrCEIqtkm6Lj
        2PEn/8IpcMl2/BN5bXEFd21etmppb43hJA==
X-Google-Smtp-Source: ABdhPJzO/6xe5/292sYG9QgSIjcClJEhT0/7/cC5YTsy8x3NQxVPZ1xdqN5wiT+TpY+3QiWj01Bfvg==
X-Received: by 2002:a17:902:cec3:b029:de:901b:d0be with SMTP id d3-20020a170902cec3b02900de901bd0bemr1152733plg.26.1612318544163;
        Tue, 02 Feb 2021 18:15:44 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:b5ef:2e43:a515:f29c])
        by smtp.gmail.com with ESMTPSA id k31sm283869pgi.5.2021.02.02.18.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:15:43 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec: Import Type C control command
Date:   Tue,  2 Feb 2021 18:15:37 -0800
Message-Id: <20210203021539.745239-1-pmalani@chromium.org>
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

Changes in v2:
- Fixed new line errors.

 .../linux/platform_data/cros_ec_commands.h    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index d3c40220b281..5a967c9f8aca 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5578,6 +5578,32 @@ struct ec_response_typec_discovery {
 	struct svid_mode_info svids[0];
 } __ec_align1;
 
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
+
 /*
  * Gather all status information for a port.
  *
-- 
2.30.0.365.g02bc693789-goog

