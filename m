Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0727330D154
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhBCCQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhBCCQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:16:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C18C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 18:15:57 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b8so13581192plh.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 18:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqQJVpkdmCG7WXQ+xIfxVxTVkMR5bafwpt9PF7feODo=;
        b=a2U0XVGCc0WyhVnr/+/wwiP6vpzISHfksu1OdE9CyMIOUx//B2+06Pc3GVF1/fqnwT
         xhcypM/it9SQNLobk0wpIGH23GwNc16YVc6/x2HcVz99Gn8n4GuNKqsk2reobMu7rhFE
         yvvF/+wegiYv1G6nzLezcnReB28wOqSD7nYM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqQJVpkdmCG7WXQ+xIfxVxTVkMR5bafwpt9PF7feODo=;
        b=RLJYzf7povkktTQ/hmCLXqo2PHfxYjpojJp/AU4VWL0NmonDfIQNgb1UT9wL0qRWjR
         ttbH1OE/R/GB1Azhzscxz/a0uGLDsjMoISftswJe6PebJWKHA7O3sZ5JjaLzdm1O4hlX
         hMwE7NWZfiWgFj/DDS1SGM5s3t+8d7gjJ1RJUgaeWepy9Z5nmX3fB3+cPociRnh0xF1w
         pUsbZj1/Mt4QHS/2YZQaSh14QBjzhtfO6gaZ+KNbIQp3MQxZ6I8vXiiZpHbUOUl960Uj
         aOGIqwsJkNDN9lrFdayHXkwH61EF4ZUcu1q452pKFVWuyOUWz9IPXoU5lLAwfuMmP5vh
         BtDA==
X-Gm-Message-State: AOAM532kPOF0pLhCNhL4+MzBqzlOridS9UjQd4T2G5+w5qKLVhDqlaVr
        gGNIdzItAK0tbtdj93vdUyo2F1heil7rXw==
X-Google-Smtp-Source: ABdhPJzciL+pRSYbLBDb2/wRm6hgruFEWG2II6GTWt+Wwy5zcdMlZbfyfBOByZEiHdUcRHuHk8wozg==
X-Received: by 2002:a17:90a:318d:: with SMTP id j13mr810974pjb.77.1612318556191;
        Tue, 02 Feb 2021 18:15:56 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:b5ef:2e43:a515:f29c])
        by smtp.gmail.com with ESMTPSA id k31sm283869pgi.5.2021.02.02.18.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:15:55 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Clear Type C disc events
Date:   Tue,  2 Feb 2021 18:15:39 -0800
Message-Id: <20210203021539.745239-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210203021539.745239-1-pmalani@chromium.org>
References: <20210203021539.745239-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear USB Type C discovery events from the Chrome EC once they've been
successfully handled.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 28 +++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index e724a5eaef1c..f3bdb87d6dce 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -867,6 +867,18 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
 	return ret;
 }
 
+static int cros_typec_send_clear_event(struct cros_typec_data *typec, int port_num, u32 events_mask)
+{
+	struct ec_params_typec_control req = {
+		.port = port_num,
+		.command = TYPEC_CONTROL_COMMAND_CLEAR_EVENTS,
+		.clear_events_mask = events_mask,
+	};
+
+	return cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_CONTROL, &req,
+				     sizeof(req), NULL, 0);
+}
+
 static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num)
 {
 	struct ec_response_typec_status resp;
@@ -887,8 +899,14 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 		ret = cros_typec_handle_sop_disc(typec, port_num);
 		if (ret < 0)
 			dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
-		else
+		else {
 			typec->ports[port_num]->sop_disc_done = true;
+			ret = cros_typec_send_clear_event(typec, port_num,
+							  PD_STATUS_EVENT_SOP_DISC_DONE);
+			if (ret < 0)
+				dev_warn(typec->dev,
+					 "Failed SOP Disc event clear, port: %d\n", port_num);
+		}
 	}
 
 	if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
@@ -896,8 +914,14 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 		ret = cros_typec_handle_sop_prime_disc(typec, port_num);
 		if (ret < 0)
 			dev_err(typec->dev, "Couldn't parse SOP' Disc data, port: %d\n", port_num);
-		else
+		else {
 			typec->ports[port_num]->sop_prime_disc_done = true;
+			ret = cros_typec_send_clear_event(typec, port_num,
+							  PD_STATUS_EVENT_SOP_PRIME_DISC_DONE);
+			if (ret < 0)
+				dev_warn(typec->dev,
+					 "Failed SOP Disc event clear, port: %d\n", port_num);
+		}
 	}
 }
 
-- 
2.30.0.365.g02bc693789-goog

