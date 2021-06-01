Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51FB39734F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhFAMeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbhFAMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:33:55 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7790C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 05:32:13 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b17-20020ac854110000b02901f279c73d75so4558357qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N3k4r2devy507FQlh/IHXNwgibHstn5wOW3VSoEKkfs=;
        b=NWI3glTWl+MRBAO80pWGcB0JP4ULfdTlUZD7CC0zNU5M0ne0fMkxizDYf430Fem7ED
         3+5vt4nVydEYqm6nM/XTTyA141jK97p1oBUIXR4ihtL9D8UURT9gByIcmjlSw1Wv+RkR
         c0YO75Y0wRjSwxkpX/POsQI6TlYz6pFAysMnmNm3w71K5FrUxDrwDWuBe3f6lkociiwf
         lsAjVbxOrujkla3mebpo+DHiAFNI9KlDpZDep/ofVP/pGwNsfwV3o67igse9e1pJtS+d
         ZgbDZNi1eEu+qITPjnpJDBkccV+ISaLIxOBl7BVgffNlFg1Xr5F66BXqDAYYL3mIiWFH
         r/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N3k4r2devy507FQlh/IHXNwgibHstn5wOW3VSoEKkfs=;
        b=ojBH7TuJdmPVjkLefgB87Uv20AfWGXyyoINgFhABK48/gLrBO0tbJfKK2Of1ZDaMel
         xeUud2goE0PH77ODTEs4dcRk9p4K9PD6/8QQxJZl+FHDji1aEMstgkFZWUcQJUunz30e
         1NbDwCUMnTnPdjEA8OhSrwboNMd900sTRD8Oy1ReMSBJ5RwvbNUFsa/ij6tUSZb6Y2fN
         IOABJEDYEyTdmi4XDWxY5enmhZ+XWZoTqcAW1Z9in3JvLwegyLeOZlenLk+iuvo2EAnN
         Pjzqpt1EFPmCyWERsBT4VcP7zYA8HYzIsC7igwnMB9gm8YxaLBOthkzof1sNJGnTpEcr
         ZG4g==
X-Gm-Message-State: AOAM530mDwDZGHbRFRvjPUjw7gBWkB5CCyjNpvBZ79plIUXTHnEOpCZK
        mnOj4wbQAtxz8anoGTnwZcFMU06+kZqO
X-Google-Smtp-Source: ABdhPJzAZexrTW+OtZij5NsHi7IgsAw9VWmgdvbjjD4PyPgxMnDVhBL84gO6nKM1GJHVxzPrymQIGYdgnnxo
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:c9e8:9a17:9774:bcd3])
 (user=kyletso job=sendgmr) by 2002:a05:6214:1788:: with SMTP id
 ct8mr7138841qvb.0.1622550732802; Tue, 01 Jun 2021 05:32:12 -0700 (PDT)
Date:   Tue,  1 Jun 2021 20:31:50 +0800
In-Reply-To: <20210601123151.3441914-1-kyletso@google.com>
Message-Id: <20210601123151.3441914-4-kyletso@google.com>
Mime-Version: 1.0
References: <20210601123151.3441914-1-kyletso@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v3 3/4] usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM
 version 1.0
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

The ID Header VDO and Product VDOs defined in USB PD Spec rev 2.0 and
rev 3.1 are quite different. Add an additional array snk_vdo_v1 and
send it as the response to the port partner if it only supports SVDM
version 1.0.

Signed-off-by: Kyle Tso <kyletso@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
changes since v2:
- no change

 drivers/usb/typec/tcpm/tcpm.c | 40 ++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 617f48cdd90c..ebe490949fa0 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -401,6 +401,8 @@ struct tcpm_port {
 	unsigned int nr_src_pdo;
 	u32 snk_pdo[PDO_MAX_OBJECTS];
 	unsigned int nr_snk_pdo;
+	u32 snk_vdo_v1[VDO_MAX_OBJECTS];
+	unsigned int nr_snk_vdo_v1;
 	u32 snk_vdo[VDO_MAX_OBJECTS];
 	unsigned int nr_snk_vdo;
 
@@ -1589,18 +1591,16 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			 */
 			if ((port->data_role == TYPEC_DEVICE || svdm_version >= SVDM_VER_2_0) &&
 			    port->nr_snk_vdo) {
-				/*
-				 * Product Type DFP and Connector Type are not defined in SVDM
-				 * version 1.0 and shall be set to zero.
-				 */
-				if (svdm_version < SVDM_VER_2_0)
-					response[1] = port->snk_vdo[0] & ~IDH_DFP_MASK
-						      & ~IDH_CONN_MASK;
-				else
-					response[1] = port->snk_vdo[0];
-				for (i = 1; i <  port->nr_snk_vdo; i++)
-					response[i + 1] = port->snk_vdo[i];
-				rlen = port->nr_snk_vdo + 1;
+				if (svdm_version < SVDM_VER_2_0) {
+					for (i = 0; i < port->nr_snk_vdo_v1; i++)
+						response[i + 1] = port->snk_vdo_v1[i];
+					rlen = port->nr_snk_vdo_v1 + 1;
+
+				} else {
+					for (i = 0; i < port->nr_snk_vdo; i++)
+						response[i + 1] = port->snk_vdo[i];
+					rlen = port->nr_snk_vdo + 1;
+				}
 			}
 			break;
 		case CMD_DISCOVER_SVID:
@@ -5969,6 +5969,22 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 			return ret;
 	}
 
+	/* If sink-vdos is found, sink-vdos-v1 is expected for backward compatibility. */
+	if (port->nr_snk_vdo) {
+		ret = fwnode_property_count_u32(fwnode, "sink-vdos-v1");
+		if (ret < 0)
+			return ret;
+		else if (ret == 0)
+			return -ENODATA;
+
+		port->nr_snk_vdo_v1 = min(ret, VDO_MAX_OBJECTS);
+		ret = fwnode_property_read_u32_array(fwnode, "sink-vdos-v1",
+						     port->snk_vdo_v1,
+						     port->nr_snk_vdo_v1);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

