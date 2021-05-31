Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3796E395889
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhEaJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhEaJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:59:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C418DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 02:57:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n129-20020a2527870000b02904ed02e1aab5so13105264ybn.21
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GFmnrSxFaguj2aSVxkHYJEDQvGpUJsqUQ/z8ZPXi5vA=;
        b=lvm00MCg5Am0VfQOlojBaj1hJttqNTPvvJbgBvZ4HTzFoOPnXpTGv6dI2vFrwOF/28
         l7xsx0lJ763RKlh682CFqN9lDxpBQ4gdPXDN77XJydMwjZjMd8ISQsNW2+0waEsjMQSe
         6Rns6AY7aDCF4hRevcVcyfCl6jc5pOzhPINDw8+dNCT4DYUUhdUOlXfLZTMyYdg05xrT
         rNTXgh1qlZyHN7Yn7dp5Edq5veto5wBvPQMsNgyd1WYqP1ehBJ655gSN8YiwA2YCMlQe
         ySPLmhxwTDoON42WTS850ABjOidk8lMstFWcJTeUYT6XX5FML8Gp1t1nsUdyRPGTmtnh
         ybNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GFmnrSxFaguj2aSVxkHYJEDQvGpUJsqUQ/z8ZPXi5vA=;
        b=U28ngsHxrlFRlCoq7alZqfH/TSs/P5wavXCCNWc9hG3GyQQWg68HD/ttaVa4SWWChA
         Wp9cBJWwAUuXCtKGYBUE+UsE9sG2a3FXSxO0EP64JpW4oHK0VKMmhpmFQGRcQ8JbLKJS
         fEfP7PiqvGuNm8+owcr83f6Nnxz9XMv/d9/5wbjTBUZmaOoUKD7fpdkhDtw4tmIDcXu7
         +FTLJ6Mdi1tSrjakt3qf1mFHC7D278loXRsp3tSSHrupOjAjEj7g2NoTpqA0Usu+Jby7
         ob5q0ImSz1s3usribOhSkmKju7DxWCbzm3UOrElbOeC02nFIa/30njKpKpiyR8gcr8PW
         MMFw==
X-Gm-Message-State: AOAM532wBEjr/AZiEJSq3aboAabfOa4zoJpw8JuInWgB9g/CQWje5O8m
        hr1afcd9UhwGLWD7p6K3ZBeXo6Nc8kXG
X-Google-Smtp-Source: ABdhPJxymxjG2D0FU3c7MsS76yEr9nMnvijKp3L0JgmUS5VgZJPutzIzDeerBRhwcXZUT/zdN8JSs1kjkYzI
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:1330:7a47:8be2:d9b7])
 (user=kyletso job=sendgmr) by 2002:a25:16c2:: with SMTP id
 185mr30186118ybw.24.1622455069972; Mon, 31 May 2021 02:57:49 -0700 (PDT)
Date:   Mon, 31 May 2021 17:57:35 +0800
In-Reply-To: <20210531095737.2258642-1-kyletso@google.com>
Message-Id: <20210531095737.2258642-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210531095737.2258642-1-kyletso@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 1/3] usb: typec: tcpm: Correct the responses in SVDM
 Version 2.0 DFP
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In USB PD Spec Rev 3.1 Ver 1.0, section "6.12.5 Applicability of
Structured VDM Commands", DFP is allowed and recommended to respond to
Discovery Identity with ACK. And in section "6.4.4.2.5.1 Commands other
than Attention", NAK should be returned only when receiving Messages
with invalid fields, Messages in wrong situation, or unrecognize
Messages.

Still keep the original design for SVDM Version 1.0 for backward
compatibilities.

Fixes: 193a68011fdc ("staging: typec: tcpm: Respond to Discover Identity commands")
Signed-off-by: Kyle Tso <kyletso@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
changes since v1:
- no code change
- add Acked-by tag

 drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0db685d5d9c0..617f48cdd90c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1575,19 +1575,25 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			if (PD_VDO_VID(p[0]) != USB_SID_PD)
 				break;
 
-			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
+			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
 				typec_partner_set_svdm_version(port->partner,
 							       PD_VDO_SVDM_VER(p[0]));
+				svdm_version = PD_VDO_SVDM_VER(p[0]);
+			}
 
 			tcpm_ams_start(port, DISCOVER_IDENTITY);
-			/* 6.4.4.3.1: Only respond as UFP (device) */
-			if (port->data_role == TYPEC_DEVICE &&
+			/*
+			 * PD2.0 Spec 6.10.3: respond with NAK as DFP (data host)
+			 * PD3.1 Spec 6.4.4.2.5.1: respond with NAK if "invalid field" or
+			 * "wrong configuation" or "Unrecognized"
+			 */
+			if ((port->data_role == TYPEC_DEVICE || svdm_version >= SVDM_VER_2_0) &&
 			    port->nr_snk_vdo) {
 				/*
 				 * Product Type DFP and Connector Type are not defined in SVDM
 				 * version 1.0 and shall be set to zero.
 				 */
-				if (typec_get_negotiated_svdm_version(typec) < SVDM_VER_2_0)
+				if (svdm_version < SVDM_VER_2_0)
 					response[1] = port->snk_vdo[0] & ~IDH_DFP_MASK
 						      & ~IDH_CONN_MASK;
 				else
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

