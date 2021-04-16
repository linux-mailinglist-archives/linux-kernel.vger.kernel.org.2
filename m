Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4653627B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244849AbhDPS2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbhDPS2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:28:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBC4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 11:28:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z22so9307906plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJ48Fl4JoBG6ZLUKedfxerGQHEajMcLwvhwKdZQIU74=;
        b=HBkMQoP8BCB0GiIs8trKlmBDVte6R070LyZK0nUT7DAwYk84yWOVYJLf75Mzjx8iF4
         aIkXXj/WlrFu8Sd7i91cPVLiPN8Y1g2bPdtYEeuf1tCmhEjoKpNYv/ZqyiABfD5oOJJD
         27V9pak+x36sT9oZBOdoHWWvRWyJ9DGVxNTUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJ48Fl4JoBG6ZLUKedfxerGQHEajMcLwvhwKdZQIU74=;
        b=mUV4TGtN8LnIRY2Iuf+gOK5lWhEriM3iitbhKfi1DCvhj/EYKbFkI0g2zT3Bfxjtdb
         i2YoQ03sPIKS8f4v9OOcqKLeKJBvBugHygcG3rB7AWevwbLYtuauZH2y3IfAZdOLa/ON
         emHLZGvPIb0+WvyR3nk3vElkSY0U20rwBswPsvILgjeYo5GRUt/7wLeQZoSQV+hWIntA
         wk/784qajjuBKlt6HxgtokCyZXPQVuVq6ON5OLB8gISvvo2B6fgllsli6OmV8jst/tDP
         oGwKWMAJ2vUnPvccHdlUsuUkop1cFVf4PG1m756t17/e9vx8xGXHmxcfCzZdCYxo4nCH
         J0pw==
X-Gm-Message-State: AOAM532miq/eRPX7VaWCfdwGHissP/CvNUkJCucIc96l++9+badyigSE
        VFnW649nwyXkRzmDaqHdC0NEKT2Pj8mHjA==
X-Google-Smtp-Source: ABdhPJzXLqvOjPyVdV5HOxdWK+FNhKeCKNvsuCEXrJvV8WHQq51nkKxVFe8tkNTT9vcecUVz/cIG5A==
X-Received: by 2002:a17:902:7886:b029:e7:1052:adad with SMTP id q6-20020a1709027886b02900e71052adadmr10723410pll.75.1618597691522;
        Fri, 16 Apr 2021 11:28:11 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:2272:aa80:99d6:697c])
        by smtp.gmail.com with ESMTPSA id f5sm5391308pfd.62.2021.04.16.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 11:28:11 -0700 (PDT)
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
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Handle hard reset
Date:   Fri, 16 Apr 2021 11:27:35 -0700
Message-Id: <20210416182739.2938473-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416182739.2938473-1-pmalani@chromium.org>
References: <20210416182739.2938473-1-pmalani@chromium.org>
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

