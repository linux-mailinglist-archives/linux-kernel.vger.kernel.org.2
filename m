Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E840441D166
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347801AbhI3C1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3C1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:27:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A2C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:26:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h12so3102831pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bm0QWavcPccJEBgdU6SXr+uCQX4Agx3Fx2YngHReRRk=;
        b=YUWqqPdkVHsy0lVvh2f+cvkALwoV2qLfrjRXPA3phsaisSUIZBGWIrhRFDELjLjteo
         aUD0+x7CQpMaEmg3peOS0N4rYBW5QiZQA/bPR5ooTOwVvSXkdBrsgTxv/kJyJoW9GrqC
         bVsnBuInvBNyBKyYMclPAzHVgdy6y9IhMusFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bm0QWavcPccJEBgdU6SXr+uCQX4Agx3Fx2YngHReRRk=;
        b=NGrnhSrpPpu9W2qgWULUDAANZC/QBarGWYS8aOYieirvaJgjtN8GrQQUqKzvi/9+vr
         OzLRBu5AvpWrC0g0wl0gSHZvtU8Oz/AKzW2O9of0jZ7Nq2p0NfMIksr9W4ynQX5xskx/
         gC/5eTtuF1UUuRiO/dt4yFCNi26qKegso+Uc2y6JVRAGY1O68CFbIjbWvm9gI6nQDRYL
         Jxs+nzGdR2f+t218TQG4HgBJNyNcyBPfdzMBqIIRLCnR6Yh/eMKZ+sA2Ha/EC//ZonIP
         FBTjWNt/WhmCaguPBXCxOgym8nUqUinGA3KjSz+AFj6+e/t02KiY9Aes3e4axHEDkhEG
         lytA==
X-Gm-Message-State: AOAM530vKXpsUv5XVRESqAdVVUP3IN0bDojQK5i2kuuhVBJOg8Q+XHNt
        i78Bac8LEFUVoyhsf9kJM8007+NoKPUsjw==
X-Google-Smtp-Source: ABdhPJxG6nhRRjWuav9Zstbd/yJkGTX7a5GzNbt3n/C12VMxob5gjgEorYTXL4rYKMA7KgIFpLlANQ==
X-Received: by 2002:a17:90a:1a4c:: with SMTP id 12mr3491287pjl.175.1632968769316;
        Wed, 29 Sep 2021 19:26:09 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:479:c131:ee9:f257])
        by smtp.gmail.com with ESMTPSA id 126sm898070pgi.86.2021.09.29.19.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 19:26:09 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 5/5] platform/chrome: cros_ec_typec: Use cros_ec_command()
Date:   Wed, 29 Sep 2021 19:23:56 -0700
Message-Id: <20210930022403.3358070-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210930022403.3358070-1-pmalani@chromium.org>
References: <20210930022403.3358070-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-use the existing cros_ec_command() instead of relying on a duplicate
version.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 69 +++++++------------------
 1 file changed, 19 insertions(+), 50 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 7b3afb6cda5d..5de0bfb0bc4d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -379,37 +379,6 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	return ret;
 }
 
-static int cros_typec_ec_command(struct cros_typec_data *typec,
-				 unsigned int version,
-				 unsigned int command,
-				 void *outdata,
-				 unsigned int outsize,
-				 void *indata,
-				 unsigned int insize)
-{
-	struct cros_ec_command *msg;
-	int ret;
-
-	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->version = version;
-	msg->command = command;
-	msg->outsize = outsize;
-	msg->insize = insize;
-
-	if (outsize)
-		memcpy(msg->data, outdata, outsize);
-
-	ret = cros_ec_cmd_xfer_status(typec->ec, msg);
-	if (ret >= 0 && insize)
-		memcpy(indata, msg->data, insize);
-
-	kfree(msg);
-	return ret;
-}
-
 static int cros_typec_usb_safe_state(struct cros_typec_port *port)
 {
 	port->state.mode = TYPEC_STATE_SAFE;
@@ -596,8 +565,8 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	/* Sending Acknowledgment to EC */
 	mux_ack.port = port_num;
 
-	if (cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_MUX_ACK, &mux_ack,
-				  sizeof(mux_ack), NULL, 0) < 0)
+	if (cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_ACK, &mux_ack,
+			    sizeof(mux_ack), NULL, 0) < 0)
 		dev_warn(typec->dev,
 			 "Failed to send Mux ACK to EC for port: %d\n",
 			 port_num);
@@ -668,8 +637,8 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
 		.port = port_num,
 	};
 
-	return cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_MUX_INFO, &req,
-				     sizeof(req), resp, sizeof(*resp));
+	return cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO, &req,
+			       sizeof(req), resp, sizeof(*resp));
 }
 
 /*
@@ -776,8 +745,8 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
 	int ret = 0;
 
 	memset(disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
-	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
-				    disc, EC_PROTO2_MAX_RESPONSE_SIZE);
+	ret = cros_ec_command(typec->ec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
+			      disc, EC_PROTO2_MAX_RESPONSE_SIZE);
 	if (ret < 0) {
 		dev_err(typec->dev, "Failed to get SOP' discovery data for port: %d\n", port_num);
 		goto sop_prime_disc_exit;
@@ -859,8 +828,8 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
 	typec_partner_set_pd_revision(port->partner, pd_revision);
 
 	memset(sop_disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
-	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
-				    sop_disc, EC_PROTO2_MAX_RESPONSE_SIZE);
+	ret = cros_ec_command(typec->ec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
+			      sop_disc, EC_PROTO2_MAX_RESPONSE_SIZE);
 	if (ret < 0) {
 		dev_err(typec->dev, "Failed to get SOP discovery data for port: %d\n", port_num);
 		goto disc_exit;
@@ -892,8 +861,8 @@ static int cros_typec_send_clear_event(struct cros_typec_data *typec, int port_n
 		.clear_events_mask = events_mask,
 	};
 
-	return cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_CONTROL, &req,
-				     sizeof(req), NULL, 0);
+	return cros_ec_command(typec->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
+			       sizeof(req), NULL, 0);
 }
 
 static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num)
@@ -904,8 +873,8 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 	};
 	int ret;
 
-	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_STATUS, &req, sizeof(req),
-				    &resp, sizeof(resp));
+	ret = cros_ec_command(typec->ec, 0, EC_CMD_TYPEC_STATUS, &req, sizeof(req),
+			      &resp, sizeof(resp));
 	if (ret < 0) {
 		dev_warn(typec->dev, "EC_CMD_TYPEC_STATUS failed for port: %d\n", port_num);
 		return;
@@ -983,9 +952,9 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
 	req.swap = USB_PD_CTRL_SWAP_NONE;
 
-	ret = cros_typec_ec_command(typec, typec->pd_ctrl_ver,
-				    EC_CMD_USB_PD_CONTROL, &req, sizeof(req),
-				    &resp, sizeof(resp));
+	ret = cros_ec_command(typec->ec, typec->pd_ctrl_ver,
+			      EC_CMD_USB_PD_CONTROL, &req, sizeof(req),
+			      &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 
@@ -1035,8 +1004,8 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 
 	/* We're interested in the PD control command version. */
 	req_v1.cmd = EC_CMD_USB_PD_CONTROL;
-	ret = cros_typec_ec_command(typec, 1, EC_CMD_GET_CMD_VERSIONS,
-				    &req_v1, sizeof(req_v1), &resp,
+	ret = cros_ec_command(typec->ec, 1, EC_CMD_GET_CMD_VERSIONS,
+			      &req_v1, sizeof(req_v1), &resp,
 				    sizeof(resp));
 	if (ret < 0)
 		return ret;
@@ -1119,8 +1088,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 	typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
 	typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
 
-	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
-				    &resp, sizeof(resp));
+	ret = cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
+			      &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 
-- 
2.33.0.685.g46640cef36-goog

