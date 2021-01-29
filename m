Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA05308595
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhA2GQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhA2GPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:15:40 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72CBC06178C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 22:14:23 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id g15so5796335pjd.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 22:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5a9vXvilUsJkEIHHvcNcA0AGVYZkJf6YL+90eMCO+bY=;
        b=T3Hpc4dc1N4vqSVRq5p3mq01HEp6AqFztlf6BwQas3cg7xfpyZccRlAOQ9XaqfUAGT
         ipsxJmNDkpIYMFLCLk3u4TnJ07YeUB35spN+f9FHqY+hva9oLebpXo8xoubfMR9ijxgE
         3yC/KAkW/H2ilEoC5DxRWPpXwK8iHo5gJFsLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5a9vXvilUsJkEIHHvcNcA0AGVYZkJf6YL+90eMCO+bY=;
        b=WxFw8ntWy9ilJw52sjcyMZg4UxVPtg2MexaW5HIO/YGkehYWYwjLLXVpTtjBNahY6G
         RWBFe5jK61AZ7F2RQltAYkNQYbnvnsGWzAnU0P1e6hyJ1P5uDE60qKOZchfyDVl0DZ9e
         LAsGp/Nh3e6vDY9Y7wb1utMYSm5OHpI5RyG0ovNXN8MzxRqoL8wjevE7f0A5ZdH/V3s1
         bWjB996jvufSAt59llSrWz6KyGqkrEIQxqKCQUXcEBU5XTDp3W1AhBTefyjbr1sbu2Sc
         7LGqdyz+Kn2OpKhT7ctltfaqTRept06FWYnuTVvnWPQArGsIj40vfJkT6Hl0AVD+wLYN
         A6fw==
X-Gm-Message-State: AOAM533vYkgF0DjrtDJXBTKx1SRBga8o6/uK/W7/Ltl54iVzAadriV4U
        LDebrerCmhxW1QhBygKxR4Vh6w==
X-Google-Smtp-Source: ABdhPJyQXFkr9PgbtsvuQLM01IhCOynxZCe0HR/Gu+HKZZGhZbp9k/YRtFDa5srPakvAwxkTCuNU7Q==
X-Received: by 2002:a17:90b:4b86:: with SMTP id lr6mr3002156pjb.107.1611900863438;
        Thu, 28 Jan 2021 22:14:23 -0800 (PST)
Received: from bleung.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id 17sm7551013pfv.13.2021.01.28.22.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 22:14:22 -0800 (PST)
From:   Benson Leung <bleung@chromium.org>
To:     heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        pmalani@chromium.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@google.com, bleung@chromium.org
Subject: [PATCH 5/6] platform/chrome: cros_ec_typec: Set Partner PD revision from status
Date:   Thu, 28 Jan 2021 22:14:05 -0800
Message-Id: <20210129061406.2680146-6-bleung@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129061406.2680146-1-bleung@chromium.org>
References: <20210129061406.2680146-1-bleung@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Status provides sop_revision. Process it, and set it using the new
setter in the typec class.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 30600e9454e1..6bc6fafd54a4 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -824,7 +824,7 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
 	return ret;
 }
 
-static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
+static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num, u16 pd_revision)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct ec_response_typec_discovery *sop_disc = port->disc_data;
@@ -842,6 +842,12 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
 		goto disc_exit;
 	}
 
+	ret = typec_partner_set_pd_revision(port->partner, pd_revision);
+	if (ret < 0) {
+		dev_err(typec->dev, "Failed to update partner PD revision, port: %d\n", port_num);
+		goto disc_exit;
+	}
+
 	memset(sop_disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
 	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
 				    sop_disc, EC_PROTO2_MAX_RESPONSE_SIZE);
@@ -885,7 +891,11 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 
 	/* Handle any events appropriately. */
 	if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE && !typec->ports[port_num]->sop_disc_done) {
-		ret = cros_typec_handle_sop_disc(typec, port_num);
+		u16 sop_revision;
+
+		/* Convert BCD to the format preferred by the TypeC framework */
+		sop_revision = (le16_to_cpu(resp.sop_revision) & 0xff00) >> 4;
+		ret = cros_typec_handle_sop_disc(typec, port_num, sop_revision);
 		if (ret < 0)
 			dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
 		else
-- 
2.30.0.365.g02bc693789-goog

