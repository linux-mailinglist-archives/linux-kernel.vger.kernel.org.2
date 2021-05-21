Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B0D38C765
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhEUNDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhEUNDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:03:15 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DDEC061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:01:52 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a141-20020a621a930000b02902de0bf944f8so7960494pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w7NQZCFeih8HQ6CGBSGm0Dxti/IMLI0sR42V/tW/LBM=;
        b=ZOvM8pVs4SpzsuoADEA4dbmhM5M6KXyxppUN3Bcro+72TSSW+tsSr+cchzLPZARCIr
         GvLv9u0MnxheFNobxyjh96iN6EG2IMkLK6xr7bFZIfvWbD8xcacU6lXXbvv0XRpvgaNG
         H3wd9q9eqTLlNBA69QcnOqOvy4XfI/7uFeQ5B6xJdWvKoNrBecRux+4MSYc72GqRxs3C
         fgV3X1fx2aTtOX9gy/ziUbdYKRVeyHSqhh11cFIx6p0jeRlOOnEmME+HiOYPcewBzJYO
         i6X7MXQoi+kdWCwNlyuHojS89o36bI7IKbHIkC4oeTJ5UfKWtr/F9uaWyHYhuZ+hKgUk
         +/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w7NQZCFeih8HQ6CGBSGm0Dxti/IMLI0sR42V/tW/LBM=;
        b=GbWcBAdAuE4qJiLqZ0dLV4PYQFAdnSCCbuyKGYXmllSISSuxF37k3PDxhSkCuGciHs
         xVqSpheTshNv17WqFHbjy2QDmyUobJtiQA7oGYZURtSQ7CRgwc6OgPfCHKh5woOKmsGc
         Jw9h91IGm+t+p7WLyvXBEuDd8U00Zhu304EUPhLGVxuxXGQEecIbc2MsIWmJjtcs7Xi3
         Gj2wEHKsLPV+zyCep6SfvTUNfAJieQ9L/UwP9KmjoRTFKHZ5SjOMnR2y9hIivcaU44f7
         vFHx+ppPk+bvn1cC86rqHpZGNp3DUI0JL/WZuXPLZOt2Cd1DEb5xwHJvfsJA3NIgkZao
         rITw==
X-Gm-Message-State: AOAM530wDuhWmPSMLtiWc0hlZSNcHLmLzGru2wApDV9oq0YsnawKrmhM
        g4Im/no/nSBjnkCWdvX5Fj1k219kaINa
X-Google-Smtp-Source: ABdhPJzaevP+Ugt8Z6fOld2zkI4r198IINlmzW6Ir1P9VkSqnRi5IDU9iedq5SVym5ovBAZBvLj4PpJ+YKf5
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:905b:c174:8f59:4851])
 (user=kyletso job=sendgmr) by 2002:a17:902:db09:b029:f4:8d37:8d12 with SMTP
 id m9-20020a170902db09b02900f48d378d12mr12474043plx.52.1621602112242; Fri, 21
 May 2021 06:01:52 -0700 (PDT)
Date:   Fri, 21 May 2021 21:01:20 +0800
In-Reply-To: <20210521130121.1470334-1-kyletso@google.com>
Message-Id: <20210521130121.1470334-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210521130121.1470334-1-kyletso@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 1/2] usb: typec: tcpm: Properly interrupt VDM AMS
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a VDM AMS is interrupted by Messages other than VDM, the AMS needs
to be finished properly. Also start a VDM AMS if receiving SVDM Commands
from the port partner to complement the functionality of tcpm_vdm_ams().

Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 64133e586c64..deb8a9d01f73 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1550,6 +1550,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
 				typec_partner_set_svdm_version(port->partner,
 							       PD_VDO_SVDM_VER(p[0]));
+
+			tcpm_ams_start(port, DISCOVER_IDENTITY);
 			/* 6.4.4.3.1: Only respond as UFP (device) */
 			if (port->data_role == TYPEC_DEVICE &&
 			    port->nr_snk_vdo) {
@@ -1568,14 +1570,19 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			}
 			break;
 		case CMD_DISCOVER_SVID:
+			tcpm_ams_start(port, DISCOVER_SVIDS);
 			break;
 		case CMD_DISCOVER_MODES:
+			tcpm_ams_start(port, DISCOVER_MODES);
 			break;
 		case CMD_ENTER_MODE:
+			tcpm_ams_start(port, DFP_TO_UFP_ENTER_MODE);
 			break;
 		case CMD_EXIT_MODE:
+			tcpm_ams_start(port, DFP_TO_UFP_EXIT_MODE);
 			break;
 		case CMD_ATTENTION:
+			tcpm_ams_start(port, ATTENTION);
 			/* Attention command does not have response */
 			*adev_action = ADEV_ATTENTION;
 			return 0;
@@ -2287,6 +2294,12 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 	bool frs_enable;
 	int ret;
 
+	if (tcpm_vdm_ams(port) && type != PD_DATA_VENDOR_DEF) {
+		port->vdm_state == VDM_STATE_ERR_BUSY;
+		tcpm_ams_finish(port);
+		mod_vdm_delayed_work(port, 0);
+	}
+
 	switch (type) {
 	case PD_DATA_SOURCE_CAP:
 		for (i = 0; i < cnt; i++)
@@ -2459,6 +2472,16 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 	enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
 	enum tcpm_state next_state;
 
+	/*
+	 * Stop VDM state machine if interrupted by other Messages while NOT_SUPP is allowed in
+	 * VDM AMS if waiting for VDM responses and will be handled later.
+	 */
+	if (tcpm_vdm_ams(port) && type != PD_CTRL_NOT_SUPP && type != PD_CTRL_GOOD_CRC) {
+		port->vdm_state = VDM_STATE_ERR_BUSY;
+		tcpm_ams_finish(port);
+		mod_vdm_delayed_work(port, 0);
+	}
+
 	switch (type) {
 	case PD_CTRL_GOOD_CRC:
 	case PD_CTRL_PING:
@@ -2717,6 +2740,13 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
 	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
 
+	/* stopping VDM state machine if interrupted by other Messages */
+	if (tcpm_vdm_ams(port)) {
+		port->vdm_state = VDM_STATE_ERR_BUSY;
+		tcpm_ams_finish(port);
+		mod_vdm_delayed_work(port, 0);
+	}
+
 	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
 		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
 		tcpm_log(port, "Unchunked extended messages unsupported");
-- 
2.31.1.818.g46aad6cb9e-goog

