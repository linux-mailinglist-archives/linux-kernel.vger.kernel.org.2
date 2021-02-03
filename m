Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99830D110
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 02:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhBCBvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 20:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhBCBvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 20:51:05 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5065C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 17:50:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lw17so2609408pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 17:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3X02P0XWu1xjA+PUSicQqXJIBS1eL1Aig/zSKSWj65U=;
        b=NXgoeR9kNvTBulnsFwHbl7swY6Xta2LRKoI5+T1XaLTRsFizeAa7MqASp95Qr0ZX/A
         048lOfqU0eloFvs1UaWaHnmNCS03N/ldO9tZGO446A7RkPhSUKU2Tqtvftw/10dosmmq
         mFiYu8JapLWDHoBnheT1Ao2lSLSnvOk1FB7tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3X02P0XWu1xjA+PUSicQqXJIBS1eL1Aig/zSKSWj65U=;
        b=O+s2IFtDxxvJWIQIKtSg3cZwfn4hUp32urb8p4ac5wM+OfyD/iIRpwFZTF1gDoHPnu
         j47N255RjA3l3kDtkJiX2fgLzSDICb9BWJTJaKqCj0fSSG+tt1in9m+T3g+KBb9QIRkC
         m+UDwCZWEbLXSRsQ2+rGixzpLhkqfAPz5L8HtiFjQDoOxzeDOAg2AIIWMsfebz2uxLZG
         qjLrklVPvoW1O1nRkqBehKMdAahfWmbSoJ6PuWYCtMFiwijppvYL5ZJnThD2IJ5OP8bf
         RcenIMhk9B/Na9Y6aCJrRHYDnM3wLdygADyL5eBxldGGxZbKMXZw/7lmkhYq836nc61z
         l91A==
X-Gm-Message-State: AOAM530TgBASAwXe7xMLl3AxAuZ+lX1HRGaxpGMcLxEM9eItTSy1WW75
        Zso6hrTdeO7wS50OnRgmG/6Lyb6H+zzj/w==
X-Google-Smtp-Source: ABdhPJzjj8oL7K1lojsxPB9BZ5qiRJsrOuK5eRgSbsDBR0zyhPfq9sqG1YE/gIA6t/vU5gF2rk9ABQ==
X-Received: by 2002:a17:90a:4a0e:: with SMTP id e14mr740001pjh.200.1612317024253;
        Tue, 02 Feb 2021 17:50:24 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:b5ef:2e43:a515:f29c])
        by smtp.gmail.com with ESMTPSA id w19sm225918pgf.23.2021.02.02.17.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 17:50:23 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 2/2] platform/chrome: cros_ec_typec: Clear Type C disc events
Date:   Tue,  2 Feb 2021 17:49:38 -0800
Message-Id: <20210203014939.741065-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210203014939.741065-1-pmalani@chromium.org>
References: <20210203014939.741065-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear USB Type C discovery events from the Chrome EC once they've been
successfully handled.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
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

