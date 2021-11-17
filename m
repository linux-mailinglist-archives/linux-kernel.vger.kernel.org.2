Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14A345427A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhKQIWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhKQIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:22:00 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5A6C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:19:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso4059789wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gJO+hq67wFWIADyKs7hg47r83klJFHiDVa9gUS5v9J8=;
        b=quTwTPHH+rAXIkc/+l5DE4z2+gAKWVNjg1OCK018bHrffz0C0nDb5GEJHXGrQ01CQL
         Ziea4IeXjSPgC8BvxMh+Dl6NvzqTr/9lACqC6GoNlstd5wQ9Vl4vphNvtu0+RUwR8U76
         I9/NPr/qj95YZcchye9J5w73dHLUDH7EHmR8jIbU7uO2iODzcCVH2yWp6cFtHeYsNAFf
         1sgh61pp0jHPxr7K52vXfLZqF/vAwL83NUQ7QsmuFhA+S7WohICY5uk4Lr5xv5P428Y7
         XinfvJ4s33iuyUnAZlk/Rkb3rJhki6OM/VwTdDHsnddgVWrgxz8BGtzmiCz+HG9Ch+7o
         Ld4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gJO+hq67wFWIADyKs7hg47r83klJFHiDVa9gUS5v9J8=;
        b=ZNqH3+QMLYeZf96tO8dIsayb7wuGmdEei4c7xz1di8pIFkF1o2KeLUxOptDKxfjaAw
         OgcqbU8vYyOSKbGFlLhT6/bdoCFa/jiQcnHqvjuGtoy/zBnaYcdlYybWmTCO95qKMS18
         xEJB05C06s5b+uK9B5sulbCY3l9JM05yY5Qnd3Dt7/9Zvhc5MqfC2Zq2BoAvI3WLcS5K
         1qbyJV7rV1Y3b4AusqCZwwmcFsjPs3xIib5Ufn9rdyUXPuW/40aCOJ/rqsfmU3PqKL0l
         rcbSQ6NAbRrT4RtDhhit8RjrCJXmFVc6UQu25+i7dsNGIieGTW5r0V1C/WmKA4/M34qP
         wO5A==
X-Gm-Message-State: AOAM532LbmEDr6InwIR/dFUqdh9VIAPcY74DOaCHp3lHYGZTPLN85fJz
        0OgsoHuFenNARRBCxk53cejiThpCggfLew==
X-Google-Smtp-Source: ABdhPJxHRS+Yy3wpCUHh2hkl176fv28z9dLSXZaKn4MqGrtRjCVloK/qmx3sLpk46mOmJqUG7VEwBA==
X-Received: by 2002:a05:600c:35cb:: with SMTP id r11mr77914397wmq.190.1637137140659;
        Wed, 17 Nov 2021 00:19:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:24f0:d30b:4818:6b7])
        by smtp.gmail.com with ESMTPSA id s8sm14598254wro.19.2021.11.17.00.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 00:18:59 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] arm/scmi: fix base agent discover response
Date:   Wed, 17 Nov 2021 09:18:56 +0100
Message-Id: <20211117081856.9932-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to scmi specification, the response of the discover agent request
is made of:
- int32 status
- uint32 agent_id
- uint8 name[16]

but the current implementation doesn't take into account the agent_id field
and only allocates a rx buffer of SCMI_MAX_STR_SIZE length

Allocate the correct length for rx buffer and copy the name from the
correct offset in the response.

While no error were returned until v5.15, v5.16-rc1 fails with virtio_scmi
transport channel:

[    1.093253] arm-scmi firmware:scmi0: SCMI Notifications - Core Enabled.
[    1.114776] arm-scmi firmware:scmi0: SCMI Protocol v2.0 'Linaro:PMWG' Firmware version 0x2090000
[    1.117544] scmi-virtio virtio0: tx:used len 28 is larger than in buflen 24

Fixes: b6f20ff8bd94 ("firmware: arm_scmi: add common infrastructure and support for base protocol")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
---

Change since v1:
- Added Fixes tag
- Added Tested and Review tag

 drivers/firmware/arm_scmi/base.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index de416f9e7921..f5219334fd3a 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -34,6 +34,12 @@ struct scmi_msg_resp_base_attributes {
 	__le16 reserved;
 };
 
+struct scmi_msg_resp_base_discover_agent {
+	__le32 agent_id;
+	u8 name[SCMI_MAX_STR_SIZE];
+};
+
+
 struct scmi_msg_base_error_notify {
 	__le32 event_control;
 #define BASE_TP_NOTIFY_ALL	BIT(0)
@@ -225,18 +231,21 @@ static int scmi_base_discover_agent_get(const struct scmi_protocol_handle *ph,
 					int id, char *name)
 {
 	int ret;
+	struct scmi_msg_resp_base_discover_agent *agent_info;
 	struct scmi_xfer *t;
 
 	ret = ph->xops->xfer_get_init(ph, BASE_DISCOVER_AGENT,
-				      sizeof(__le32), SCMI_MAX_STR_SIZE, &t);
+				      sizeof(__le32), sizeof(*agent_info), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(id, t->tx.buf);
 
 	ret = ph->xops->do_xfer(ph, t);
-	if (!ret)
-		strlcpy(name, t->rx.buf, SCMI_MAX_STR_SIZE);
+	if (!ret) {
+		agent_info = t->rx.buf;
+		strlcpy(name, agent_info->name, SCMI_MAX_STR_SIZE);
+	}
 
 	ph->xops->xfer_put(ph, t);
 
-- 
2.17.1

