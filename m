Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547C530BB2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhBBJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhBBJfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:35:47 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECE2C06121D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:34:09 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id j14so12661563qtv.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=x0kHz4XtxKkom+zRNKnnp4MgCeBYWS7Fk/X1sDcZ9lU=;
        b=Xyci0DE8YTLvCIvUKPG/julsOqmGAJQczRVTCm1utiQ+ngxeHoitsUHAdpFZFSkfCq
         X/p/BaxcTeYBPo0C8d4rz7s/v3QDN4EM6MeWdP9JA/oav2M5LgCHlErDzQK6jfX6MKFf
         w1Me7LkxP3O5Yvfr6tTgk4r1MNBBPhc5tYMIHYho25CEwp0IpgqBQOBZNGJULdHncgLX
         WsVogbftrPxc3l5k89gxIm4sNIwAkZUpYrA09NhudR5VZ3/mmlgmKnbHVPg3P8jr9flc
         qqUfeBNDhLscAh5JweBtVO8OXYfkv2HC1jWtLiPwnQWKE9TD3aONdt6jWTGj8DeGIqev
         WHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x0kHz4XtxKkom+zRNKnnp4MgCeBYWS7Fk/X1sDcZ9lU=;
        b=MXWzao2mXfJMPrJQ3IDWsgJklEyqcifiHyEQ3qxYPmIrb5DhB5r+SyfYR19DlJgXuC
         E9RlWF2oORdTdi1HY1wyBF2G3Kej1MMhxNYp83lpKIbCPlDOBtlcM01gzmPc/KRNjBPy
         65nhdZkyfDaMg8seAOu09Cw8ihPTmT0wzlo4Skdnfv5CDslLzTbMbwHTNk9SYyTHRphZ
         axrIdeV0vghCbUZnqxkUWbqV2T69l4z7u+F+kznk+fUtmMPc8SqBmJ/XmGtPoJZYUzjd
         2fW0V990Un/e8chevg9cE8b1e9KJudKXwU+wcPp3ulPPRovbAUYtHqO4BPgYWwPNek9/
         0vGw==
X-Gm-Message-State: AOAM531yjJnawMh66AdG3e6TNZCjxvub0LIQLXUeU9YSBMBlTxYlhXCR
        C+tCVhVOJm5z5jkqtdFVdBtpQWUgzk/w
X-Google-Smtp-Source: ABdhPJyqmNuS9gu9YAlz1M+KeHOdP3p4n4n3v/6FvDMmLgk1D9Mf85oLtkHIhwQIYRRGq0JkEDkQ2tlZwM2b
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:dd94:c753:a81d:c855])
 (user=kyletso job=sendgmr) by 2002:a0c:906c:: with SMTP id
 o99mr5167269qvo.28.1612258448306; Tue, 02 Feb 2021 01:34:08 -0800 (PST)
Date:   Tue,  2 Feb 2021 17:33:39 +0800
In-Reply-To: <20210202093342.738691-1-kyletso@google.com>
Message-Id: <20210202093342.738691-6-kyletso@google.com>
Mime-Version: 1.0
References: <20210202093342.738691-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 5/8] usb: typec: ucsi: Detemine common SVDM Version
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the following requirement in the Spec.

PD Spec Revision 3.0 Version 2.0 + ECNs 2020-12-10
  6.4.4.2.3 Structured VDM Version
  "The Structured VDM Version field of the Discover Identity Command
  sent and received during VDM discovery Shall be used to determine the
  lowest common Structured VDM Version supported by the Port Partners or
  Cable Plug and Shall continue to operate using this Specification
  Revision until they are Detached."

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/ucsi/displayport.c | 12 +++++++++---
 drivers/usb/typec/ucsi/ucsi.c        |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 261131c9e37c..b58ef26a50e0 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -48,6 +48,7 @@ struct ucsi_dp {
 static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 {
 	struct ucsi_dp *dp = typec_altmode_get_drvdata(alt);
+	struct typec_port *port = dp->con->port;
 	struct ucsi *ucsi = dp->con->ucsi;
 	u64 command;
 	u8 cur = 0;
@@ -83,7 +84,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	 * mode, and letting the alt mode driver continue.
 	 */
 
-	dp->header = VDO(USB_TYPEC_DP_SID, 1, CMD_ENTER_MODE);
+	dp->header = VDO(USB_TYPEC_DP_SID, 1, typec_get_svdm_version(port), CMD_ENTER_MODE);
 	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
 	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
 
@@ -101,6 +102,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 static int ucsi_displayport_exit(struct typec_altmode *alt)
 {
 	struct ucsi_dp *dp = typec_altmode_get_drvdata(alt);
+	struct typec_port *port = dp->con->port;
 	u64 command;
 	int ret = 0;
 
@@ -120,7 +122,7 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
 	if (ret < 0)
 		goto out_unlock;
 
-	dp->header = VDO(USB_TYPEC_DP_SID, 1, CMD_EXIT_MODE);
+	dp->header = VDO(USB_TYPEC_DP_SID, 1, typec_get_svdm_version(port), CMD_EXIT_MODE);
 	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
 	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
 
@@ -184,6 +186,7 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 				u32 header, const u32 *data, int count)
 {
 	struct ucsi_dp *dp = typec_altmode_get_drvdata(alt);
+	struct typec_port *port = dp->con->port;
 	int cmd_type = PD_VDO_CMDT(header);
 	int cmd = PD_VDO_CMD(header);
 
@@ -200,7 +203,10 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 
 	switch (cmd_type) {
 	case CMDT_INIT:
-		dp->header = VDO(USB_TYPEC_DP_SID, 1, cmd);
+		if (PD_VDO_SVDM_VER(header) < typec_get_svdm_version(port))
+			typec_set_svdm_version(port, PD_VDO_SVDM_VER(header));
+
+		dp->header = VDO(USB_TYPEC_DP_SID, 1, typec_get_svdm_version(port), cmd);
 		dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
 
 		switch (cmd) {
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index ca3f4194ad90..8c4897a7bf75 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -764,6 +764,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	if (con->status.change & UCSI_CONSTAT_CONNECT_CHANGE) {
 		typec_set_pwr_role(con->port, role);
+		typec_set_svdm_version(con->port, con->typec_cap.svdm_version);
 
 		switch (UCSI_CONSTAT_PARTNER_TYPE(con->status.flags)) {
 		case UCSI_CONSTAT_PARTNER_TYPE_UFP:
@@ -1052,6 +1053,7 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 
 	cap->revision = ucsi->cap.typec_version;
 	cap->pd_revision = ucsi->cap.pd_version;
+	cap->svdm_version = SVDM_VER_2_0;
 	cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
 
 	if (con->cap.op_mode & UCSI_CONCAP_OPMODE_AUDIO_ACCESSORY)
-- 
2.30.0.365.g02bc693789-goog

