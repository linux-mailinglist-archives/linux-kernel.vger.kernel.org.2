Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA435FFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 04:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhDOCPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 22:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDOCPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 22:15:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E97C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 19:15:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y2so11198217plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 19:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVafvuqo+oqVv3R0z+UhwP7IxEUU45oF4bwHpMKuj3E=;
        b=EB3A5SgW2ysi0j29CEaSefobCsn8T4OY5jZRc9ll4/C+7tvatOT1ufbmM6HAAjbFsb
         t5QGaIaT/tgaM/v7B+SMxSPaaRBS6k0gSbua7Yjf0PQ7qAfBD+wBlncLqqNPHj00osmc
         W6q6LNqlK+omJIoQbw+TeYJ2AjM67ahBB9imU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVafvuqo+oqVv3R0z+UhwP7IxEUU45oF4bwHpMKuj3E=;
        b=ox7GK6nZcqKspfamMiwMESGwzLN9AV7mlPETKgKdCmB/Twn7uasygQCvg03sxHAwOR
         omTMygS/HRHu7ay9WU40G//nVhy18D0bdOw+VoA6W6olh5TBS18CDYVvwVRhkIhpiS6J
         kJ8BSctJeAKOOZuiIeheSfEUUX+/j4uJ/nATmiJ96O2fqsi/u21DYN8jLjnh+tWFaXwf
         lwg+kHWSeh7xY6iiqBJcdxdoeQ0VTLHoZlYefbCM0HsznCF/8juR/+0xTHHm3XSBxTPH
         6XbdN2IjMijLfDxS9aKDVmxLxgN4s1cY+ZtIVWaWstvlHWlDmL6qTwz0r/SsJZc2D/4O
         oxQw==
X-Gm-Message-State: AOAM530i4SsYRx2rrCyS8GzIq3+AWz5/zW2D9xogGQsekkHKvMqyfweZ
        6MWVdIWLj4N0BCGGIOxcAOccP6zzq5hQ2A==
X-Google-Smtp-Source: ABdhPJxgDjqg4RbZ7O31D5ragyJk3TNznIMeMnVjSC0VstJbBYBQKTe5NGpKHxUUECF1yvaWGBi25g==
X-Received: by 2002:a17:902:8217:b029:e6:2875:b1d9 with SMTP id x23-20020a1709028217b02900e62875b1d9mr1330779pln.70.1618452900482;
        Wed, 14 Apr 2021 19:15:00 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:401c:b81c:c7f5:e1bf])
        by smtp.gmail.com with ESMTPSA id k15sm586572pfi.0.2021.04.14.19.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:15:00 -0700 (PDT)
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
Subject: [PATCH] platform/chrome: cros_ec_typec: Handle hard reset
Date:   Wed, 14 Apr 2021 19:14:53 -0700
Message-Id: <20210415021456.1805797-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Chrome Embedded Controller (EC) generates a hard reset type C event
when a USB Power Delivery (PD) hard reset is encountered. Handle this
event by unregistering the partner and cable on the associated port and
clearing the event flag.

Also update the EC command header to include the new event bit. This bit
is included in the latest version of the Chrome EC headers[1].

[1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h

Cc: Benson Leung <bleung@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c        | 13 +++++++++++++
 include/linux/platform_data/cros_ec_commands.h |  1 +
 2 files changed, 14 insertions(+)

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
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 5ff8597ceabd..9156078c6fc6 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5678,6 +5678,7 @@ enum tcpc_cc_polarity {
 
 #define PD_STATUS_EVENT_SOP_DISC_DONE		BIT(0)
 #define PD_STATUS_EVENT_SOP_PRIME_DISC_DONE	BIT(1)
+#define PD_STATUS_EVENT_HARD_RESET		BIT(2)
 
 struct ec_params_typec_status {
 	uint8_t port;
-- 
2.31.1.295.g9ea45b61b8-goog

