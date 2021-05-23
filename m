Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C3538D82A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 03:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhEWCAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 22:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhEWCAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 22:00:42 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E4C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 18:59:16 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b17-20020a63eb510000b029021a1da627beso15790731pgk.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 18:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H6DCutqubwJuJjvPJwe7l/OnSLXXzPw/jZHLkgFWdDE=;
        b=ruy/YTaXfqzlL3MV5kAlgn8JjkrV//gYFNSsvIKb/gjvo1V/qZ/ime7UbsCLL0VPJe
         y0+PbjrBzJkRYVAiit09guodIUm+5/NPn7Pss0zQdYxamEE9lel8Qo6ixfBb993Y4e8f
         bxkMnETUdRJ0A5yULoO2kWaRIUECTUEz1cMGxaNwwGQBvgDXeIUaiHyUYWYWgFrmgCIi
         rNVTLCqQJCeVr2WR3K78GTYy52LfXRbRP1w7XvSqfyqa8e8Nl6LLuUlnHt7Cb3gSaSw8
         Camz5jf4qwlDiB6CoFFKdnI7QcFz+ZjUKSbU+e3vTBVxA/H/P9cqfZKFdBx3O2ug37Xy
         Jorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H6DCutqubwJuJjvPJwe7l/OnSLXXzPw/jZHLkgFWdDE=;
        b=qL13yKG7jN5Rc8tz/EBerIZ/AXbnPeMgdWiw/uFwRcQx+F0hJGA+BUyfy7ShcFfoDu
         dwrwxzj06V5n6KWoFHUWimVURazz4TOm/TfNo+l2AYmencooXC/ZS+1+bPFwjyPJy/sz
         meu1SJo689+UpWBvVkjUz6rQj+Xt/I8AvD+vZrIqAa3FwP+dN4lLBvbO0spPJpgnUM2p
         gAv3kmc6trE38mkvKhA4bXa1TItYwEN8oBpi/OHkxCxYsASk0l//yzo+pncgqBhVnQEc
         Yrdi9ICncpUURnTtL061w8Di91GKsN2ZVDVXI00jFlLiOPKiNkg7qIv9mitcK8cxX0s5
         Zs6A==
X-Gm-Message-State: AOAM531DQve9iAFmf8RoGHT7VqOgI57aiIFqlBw18EW+BND2MyislYoC
        MdcYV8yKwaLumlZ1xjwbU9VbUyVyKnnA
X-Google-Smtp-Source: ABdhPJwPv2a5TJQDT4U043frZyFA7P6/X9Ntzhw2GIvl1a/oiYrqceaTh/mwNwrBlHB7L5VUzdOrf1e3VYEz
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:7015:3f20:3a0c:ecc2])
 (user=kyletso job=sendgmr) by 2002:a62:6444:0:b029:2e7:46b3:237c with SMTP id
 y65-20020a6264440000b02902e746b3237cmr3874724pfb.22.1621735155946; Sat, 22
 May 2021 18:59:15 -0700 (PDT)
Date:   Sun, 23 May 2021 09:58:54 +0800
In-Reply-To: <20210523015855.1785484-1-kyletso@google.com>
Message-Id: <20210523015855.1785484-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210523015855.1785484-1-kyletso@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2 1/2] usb: typec: tcpm: Properly interrupt VDM AMS
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a VDM AMS is interrupted by Messages other than VDM, the AMS needs
to be finished properly. Also start a VDM AMS if receiving SVDM Commands
from the port partner to complement the functionality of tcpm_vdm_ams().

Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
Signed-off-by: Kyle Tso <kyletso@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm/tcpm.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3feaf5d6419e..7db6ae3e9c0b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1578,6 +1578,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
 				typec_partner_set_svdm_version(port->partner,
 							       PD_VDO_SVDM_VER(p[0]));
+
+			tcpm_ams_start(port, DISCOVER_IDENTITY);
 			/* 6.4.4.3.1: Only respond as UFP (device) */
 			if (port->data_role == TYPEC_DEVICE &&
 			    port->nr_snk_vdo) {
@@ -1596,14 +1598,19 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
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
@@ -2315,6 +2322,12 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 	bool frs_enable;
 	int ret;
 
+	if (tcpm_vdm_ams(port) && type != PD_DATA_VENDOR_DEF) {
+		port->vdm_state = VDM_STATE_ERR_BUSY;
+		tcpm_ams_finish(port);
+		mod_vdm_delayed_work(port, 0);
+	}
+
 	switch (type) {
 	case PD_DATA_SOURCE_CAP:
 		for (i = 0; i < cnt; i++)
@@ -2487,6 +2500,16 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
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
@@ -2745,6 +2768,13 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
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

