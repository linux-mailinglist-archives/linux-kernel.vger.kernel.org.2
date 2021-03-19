Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BEE34124F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCSBvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhCSBvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:51:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C1DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:51:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so3658837pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KteKfv2UOoa8aiw67O0HB3mAuGAIS/NCodKalMZV6y0=;
        b=fF4OpddNvP33iqd3ddlDpPwpaiobXfGPonzUVFjoohJgrsIcj1D4Jo4l3UVRflnp5e
         ykKQpLwNJB/mX+OPJWRYZzLRD+yNvHZQjYjnzlItpTpvKB9KzNhPYKILdaX3SlibNNHn
         AnzIG6Iw/w3KVYFGw65qahxhOUbDmGgINvyyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KteKfv2UOoa8aiw67O0HB3mAuGAIS/NCodKalMZV6y0=;
        b=lzmthe0qJoyFGvmnqKHKwmc8sPuU7V2T5bAlVR/Sec4unTrC0vQgJQInV5LTMpI5BB
         Txn4Y5jPkU7rm5NJ5/MdOjToFnEhzzZmUHO2TgWPWgMg2cL4rSbAe+MHGxxv41LQeCFS
         yzrfl4T/DvVxS6/1HPAsj+CWsYqKqQsfOhEo/ImQA+1DyUGSIsyQzoCyVuA7PJUGMD9Y
         5KiG4X0WLsCNXdQ+A/o1jPyRG4iFMPIMh7CH3epFnLGLh9IFKItLPyHddY0tfrGMnSa1
         3GqyFFEBCyGKOfy2lKMP2JY/MTPmV9uSd4m3KtZsEDV5sR53EI1VGoxf/JKje8nX+Irm
         ZYOg==
X-Gm-Message-State: AOAM530yOD0rxLvk/rW/LXYDSGyRrR1zICMQvSKQ1wIFi9BldNm/LzHw
        UF260x/OnL7avBb3nWjPCO7Wvkv7QJaKTg==
X-Google-Smtp-Source: ABdhPJwU6c7EDHXOU0HI5iG2gP7rJvf524XTA0MFa2YFvj3VIF0rL1HgN+Nez4adjnLEDp+mhnzW8A==
X-Received: by 2002:a17:90a:b007:: with SMTP id x7mr6960818pjq.27.1616118679710;
        Thu, 18 Mar 2021 18:51:19 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:b599:deeb:4e65:5727])
        by smtp.gmail.com with ESMTPSA id w17sm3217689pgg.41.2021.03.18.18.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 18:51:19 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Check for device within remove function
Date:   Thu, 18 Mar 2021 18:51:03 -0700
Message-Id: <20210319015103.3751672-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of call sites, we use the same pattern of checking for a
partner or cable device before attempting to remove it. Simplify this by
moving those checks into the remove functions.

Cc: Benson Leung <bleung@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0811562deecc..8e7fde3e7032 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -220,6 +220,9 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 
+	if (!port->partner)
+		return;
+
 	cros_typec_unregister_altmodes(typec, port_num, true);
 
 	cros_typec_usb_disconnect_state(port);
@@ -235,6 +238,9 @@ static void cros_typec_remove_cable(struct cros_typec_data *typec,
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 
+	if (!port->cable)
+		return;
+
 	cros_typec_unregister_altmodes(typec, port_num, false);
 
 	typec_unregister_plug(port->plug);
@@ -253,11 +259,8 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 		if (!typec->ports[i])
 			continue;
 
-		if (typec->ports[i]->partner)
-			cros_typec_remove_partner(typec, i);
-
-		if (typec->ports[i]->cable)
-			cros_typec_remove_cable(typec, i);
+		cros_typec_remove_partner(typec, i);
+		cros_typec_remove_cable(typec, i);
 
 		usb_role_switch_put(typec->ports[i]->role_sw);
 		typec_switch_put(typec->ports[i]->ori_sw);
@@ -647,11 +650,8 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 				 "Failed to register partner on port: %d\n",
 				 port_num);
 	} else {
-		if (typec->ports[port_num]->partner)
-			cros_typec_remove_partner(typec, port_num);
-
-		if (typec->ports[port_num]->cable)
-			cros_typec_remove_cable(typec, port_num);
+		cros_typec_remove_partner(typec, port_num);
+		cros_typec_remove_cable(typec, port_num);
 	}
 }
 
-- 
2.31.0.rc2.261.g7f71774620-goog

